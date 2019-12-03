Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 254FE11010C
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 16:20:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbfLCPUb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 10:20:31 -0500
Received: from foss.arm.com ([217.140.110.172]:44236 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbfLCPUb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Dec 2019 10:20:31 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5C73F31B;
        Tue,  3 Dec 2019 07:20:30 -0800 (PST)
Received: from [10.1.196.37] (e121345-lin.cambridge.arm.com [10.1.196.37])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 686E23F52E;
        Tue,  3 Dec 2019 07:20:28 -0800 (PST)
Subject: Re: [PATCH] PCI: layerscape: Add the SRIOV support in host side
To:     Marc Zyngier <maz@kernel.org>, Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     Roy Zang <roy.zang@nxp.com>, lorenzo.pieralisi@arm.com,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>, linux-kernel@vger.kernel.org,
        "M.h. Lian" <minghuan.lian@nxp.com>, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, bhelgaas@google.com,
        andrew.murray@arm.com, frowand.list@gmail.com,
        Mingkai Hu <mingkai.hu@nxp.com>
References: <20191202104506.27916-1-xiaowei.bao@nxp.com>
 <606a00a2edcf077aa868319e0daa4dbc@www.loen.fr>
 <AM5PR04MB3299A5A504DEFEF3E137A27CF5420@AM5PR04MB3299.eurprd04.prod.outlook.com>
 <3dcdf44eb76390730658e3f4d932620c@www.loen.fr>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <8f56c2d9-ab01-a91e-902f-a61def0e8ce8@arm.com>
Date:   Tue, 3 Dec 2019 15:20:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3dcdf44eb76390730658e3f4d932620c@www.loen.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 03/12/2019 11:51 am, Marc Zyngier wrote:
> On 2019-12-03 01:42, Xiaowei Bao wrote:
>>> -----Original Message-----
>>> From: Marc Zyngier <maz@misterjones.org>
>>> Sent: 2019年12月2日 20:48
>>> To: Xiaowei Bao <xiaowei.bao@nxp.com>
>>> Cc: robh+dt@kernel.org; frowand.list@gmail.com; M.h. Lian
>>> <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang
>>> <roy.zang@nxp.com>; lorenzo.pieralisi@arm.com; andrew.murray@arm.com;
>>> bhelgaas@google.com; devicetree@vger.kernel.org;
>>> linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org;
>>> linux-arm-kernel@lists.infradead.org; Z.q. Hou <zhiqiang.hou@nxp.com>
>>> Subject: Re: [PATCH] PCI: layerscape: Add the SRIOV support in host side
>>>
>>> On 2019-12-02 10:45, Xiaowei Bao wrote:
>>> > GIC get the map relations of devid and stream id from the msi-map
>>> > property of DTS, our platform add this property in u-boot base on the
>>> > PCIe device in the bus, but if enable the vf device in kernel, the vf
>>> > device msi-map will not set, so the vf device can't work, this patch
>>> > purpose is that manage the stream id and device id map relations
>>> > dynamically in kernel, and make the new PCIe device work in kernel.
>>> >
>>> > Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
>>> > ---
>>> >  drivers/of/irq.c                            |  9 +++
>>> >  drivers/pci/controller/dwc/pci-layerscape.c | 94
>>> > +++++++++++++++++++++++++++++
>>> >  drivers/pci/probe.c                         |  6 ++
>>> >  drivers/pci/remove.c                        |  6 ++
>>> >  4 files changed, 115 insertions(+)
>>> >
>>> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c index
>>> > a296eaf..791e609 100644
>>> > --- a/drivers/of/irq.c
>>> > +++ b/drivers/of/irq.c
>>> > @@ -576,6 +576,11 @@ void __init of_irq_init(const struct of_device_id
>>> > *matches)
>>> >      }
>>> >  }
>>> >
>>> > +u32 __weak ls_pcie_streamid_fix(struct device *dev, u32 rid) {
>>> > +    return rid;
>>> > +}
>>> > +
>>> >  static u32 __of_msi_map_rid(struct device *dev, struct device_node
>>> > **np,
>>> >                  u32 rid_in)
>>> >  {
>>> > @@ -590,6 +595,10 @@ static u32 __of_msi_map_rid(struct device *dev,
>>> > struct device_node **np,
>>> >          if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
>>> >                  "msi-map-mask", np, &rid_out))
>>> >              break;
>>> > +
>>> > +    if (rid_out == rid_in)
>>> > +        rid_out = ls_pcie_streamid_fix(parent_dev, rid_in);
>>>
>>> Over my dead body. Get your firmware to properly program the LUT so 
>>> that it
>>> presents the ITS with a reasonable topology. There is absolutely no 
>>> way this
>>> kind of change makes it into the kernel.
>>
>> Sorry for this, I know it is not reasonable, but I have no other way,
>> as I know, ARM
>> get the mapping of stream ID to request ID from the msi-map property
>> of DTS, if
>> add a new device which need the stream ID and try to get it from the
>> msi-map of DTS,
>> it will failed and not work, yes? So could you give me a better
>> advice to fix this issue,
>> I would really appreciate any comments or suggestions, thanks a lot.
> 
> Why can't firmware expose an msi-map/msi-map-mask that has a large
> enough range to ensure mapping of VFs? What are the limitations of
> the LUT that would prevent this from being configured before the
> kernel boots?

Furthermore, note that this attempt isn't doing anything for the SMMU 
Stream IDs, so the moment anyone tries to assign those VFs they're still 
going to go bang anyway. Any firmware-based fixup for ID mappings, 
config space addresses, etc. needs to be SR-IOV-aware and account for 
all *possible* BDFs.

On LS2085 at least, IIRC you can configure a single LUT entry to just 
translate the Bus:Device identifier and pass some or all of the Function 
bits straight through as the LSBs of the Stream ID, so I don't believe 
the relatively limited number of LUT registers should be too much of an 
issue. For example, last time I hacked on that I apparently had it set 
up statically like this:

&pcie3 {
	/* Squash 8:5:3 BDF down to 2:2:3 */
	msi-map-mask = <0x031f>;
	msi-map = <0x000 &its 0x00 0x20>,
		  <0x100 &its 0x20 0x20>,
		  <0x200 &its 0x40 0x20>,
		  <0x300 &its 0x60 0x20>;
};

Robin.
