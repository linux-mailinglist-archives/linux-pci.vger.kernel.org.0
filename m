Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E771D10FCDF
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2019 12:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725954AbfLCLvM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 06:51:12 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:39275 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725907AbfLCLvM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Dec 2019 06:51:12 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@kernel.org>)
        id 1ic6hv-0004Si-8u; Tue, 03 Dec 2019 12:51:07 +0100
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCH] PCI: layerscape: Add the SRIOV support in host side
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 03 Dec 2019 11:51:07 +0000
From:   Marc Zyngier <maz@kernel.org>
Cc:     <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>
In-Reply-To: <AM5PR04MB3299A5A504DEFEF3E137A27CF5420@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20191202104506.27916-1-xiaowei.bao@nxp.com>
 <606a00a2edcf077aa868319e0daa4dbc@www.loen.fr>
 <AM5PR04MB3299A5A504DEFEF3E137A27CF5420@AM5PR04MB3299.eurprd04.prod.outlook.com>
Message-ID: <3dcdf44eb76390730658e3f4d932620c@www.loen.fr>
X-Sender: maz@kernel.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: xiaowei.bao@nxp.com, robh+dt@kernel.org, frowand.list@gmail.com, minghuan.lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com, lorenzo.pieralisi@arm.com, andrew.murray@arm.com, bhelgaas@google.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, zhiqiang.hou@nxp.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-12-03 01:42, Xiaowei Bao wrote:
>> -----Original Message-----
>> From: Marc Zyngier <maz@misterjones.org>
>> Sent: 2019年12月2日 20:48
>> To: Xiaowei Bao <xiaowei.bao@nxp.com>
>> Cc: robh+dt@kernel.org; frowand.list@gmail.com; M.h. Lian
>> <minghuan.lian@nxp.com>; Mingkai Hu <mingkai.hu@nxp.com>; Roy Zang
>> <roy.zang@nxp.com>; lorenzo.pieralisi@arm.com; 
>> andrew.murray@arm.com;
>> bhelgaas@google.com; devicetree@vger.kernel.org;
>> linux-kernel@vger.kernel.org; linux-pci@vger.kernel.org;
>> linux-arm-kernel@lists.infradead.org; Z.q. Hou 
>> <zhiqiang.hou@nxp.com>
>> Subject: Re: [PATCH] PCI: layerscape: Add the SRIOV support in host 
>> side
>>
>> On 2019-12-02 10:45, Xiaowei Bao wrote:
>> > GIC get the map relations of devid and stream id from the msi-map
>> > property of DTS, our platform add this property in u-boot base on 
>> the
>> > PCIe device in the bus, but if enable the vf device in kernel, the 
>> vf
>> > device msi-map will not set, so the vf device can't work, this 
>> patch
>> > purpose is that manage the stream id and device id map relations
>> > dynamically in kernel, and make the new PCIe device work in 
>> kernel.
>> >
>> > Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
>> > ---
>> >  drivers/of/irq.c                            |  9 +++
>> >  drivers/pci/controller/dwc/pci-layerscape.c | 94
>> > +++++++++++++++++++++++++++++
>> >  drivers/pci/probe.c                         |  6 ++
>> >  drivers/pci/remove.c                        |  6 ++
>> >  4 files changed, 115 insertions(+)
>> >
>> > diff --git a/drivers/of/irq.c b/drivers/of/irq.c index
>> > a296eaf..791e609 100644
>> > --- a/drivers/of/irq.c
>> > +++ b/drivers/of/irq.c
>> > @@ -576,6 +576,11 @@ void __init of_irq_init(const struct 
>> of_device_id
>> > *matches)
>> >  	}
>> >  }
>> >
>> > +u32 __weak ls_pcie_streamid_fix(struct device *dev, u32 rid) {
>> > +	return rid;
>> > +}
>> > +
>> >  static u32 __of_msi_map_rid(struct device *dev, struct 
>> device_node
>> > **np,
>> >  			    u32 rid_in)
>> >  {
>> > @@ -590,6 +595,10 @@ static u32 __of_msi_map_rid(struct device 
>> *dev,
>> > struct device_node **np,
>> >  		if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
>> >  				"msi-map-mask", np, &rid_out))
>> >  			break;
>> > +
>> > +	if (rid_out == rid_in)
>> > +		rid_out = ls_pcie_streamid_fix(parent_dev, rid_in);
>>
>> Over my dead body. Get your firmware to properly program the LUT so 
>> that it
>> presents the ITS with a reasonable topology. There is absolutely no 
>> way this
>> kind of change makes it into the kernel.
>
> Sorry for this, I know it is not reasonable, but I have no other way,
> as I know, ARM
> get the mapping of stream ID to request ID from the msi-map property
> of DTS, if
> add a new device which need the stream ID and try to get it from the
> msi-map of DTS,
> it will failed and not work, yes? So could you give me a better
> advice to fix this issue,
> I would really appreciate any comments or suggestions, thanks a lot.

Why can't firmware expose an msi-map/msi-map-mask that has a large
enough range to ensure mapping of VFs? What are the limitations of
the LUT that would prevent this from being configured before the
kernel boots?

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
