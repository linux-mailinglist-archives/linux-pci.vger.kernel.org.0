Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ACC310EA34
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2019 13:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727362AbfLBMrr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Dec 2019 07:47:47 -0500
Received: from inca-roads.misterjones.org ([213.251.177.50]:50451 "EHLO
        inca-roads.misterjones.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727354AbfLBMrr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Dec 2019 07:47:47 -0500
Received: from www-data by cheepnis.misterjones.org with local (Exim 4.80)
        (envelope-from <maz@misterjones.org>)
        id 1ibl76-0000Yo-Ut; Mon, 02 Dec 2019 13:47:40 +0100
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: Re: [PATCH] PCI: layerscape: Add the SRIOV support in host side
X-PHP-Originating-Script: 0:main.inc
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 02 Dec 2019 12:47:40 +0000
From:   Marc Zyngier <maz@misterjones.org>
Cc:     <robh+dt@kernel.org>, <frowand.list@gmail.com>,
        <minghuan.lian@nxp.com>, <mingkai.hu@nxp.com>, <roy.zang@nxp.com>,
        <lorenzo.pieralisi@arm.com>, <andrew.murray@arm.com>,
        <bhelgaas@google.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <zhiqiang.hou@nxp.com>
Organization: Metropolis
In-Reply-To: <20191202104506.27916-1-xiaowei.bao@nxp.com>
References: <20191202104506.27916-1-xiaowei.bao@nxp.com>
Message-ID: <606a00a2edcf077aa868319e0daa4dbc@www.loen.fr>
X-Sender: maz@misterjones.org
User-Agent: Roundcube Webmail/0.7.2
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Rcpt-To: xiaowei.bao@nxp.com, robh+dt@kernel.org, frowand.list@gmail.com, minghuan.lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com, lorenzo.pieralisi@arm.com, andrew.murray@arm.com, bhelgaas@google.com, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, zhiqiang.hou@nxp.com
X-SA-Exim-Mail-From: maz@misterjones.org
X-SA-Exim-Scanned: No (on cheepnis.misterjones.org); SAEximRunCond expanded to false
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2019-12-02 10:45, Xiaowei Bao wrote:
> GIC get the map relations of devid and stream id from the msi-map
> property of DTS, our platform add this property in u-boot base on
> the PCIe device in the bus, but if enable the vf device in kernel,
> the vf device msi-map will not set, so the vf device can't work,
> this patch purpose is that manage the stream id and device id map
> relations dynamically in kernel, and make the new PCIe device work
> in kernel.
>
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> ---
>  drivers/of/irq.c                            |  9 +++
>  drivers/pci/controller/dwc/pci-layerscape.c | 94
> +++++++++++++++++++++++++++++
>  drivers/pci/probe.c                         |  6 ++
>  drivers/pci/remove.c                        |  6 ++
>  4 files changed, 115 insertions(+)
>
> diff --git a/drivers/of/irq.c b/drivers/of/irq.c
> index a296eaf..791e609 100644
> --- a/drivers/of/irq.c
> +++ b/drivers/of/irq.c
> @@ -576,6 +576,11 @@ void __init of_irq_init(const struct
> of_device_id *matches)
>  	}
>  }
>
> +u32 __weak ls_pcie_streamid_fix(struct device *dev, u32 rid)
> +{
> +	return rid;
> +}
> +
>  static u32 __of_msi_map_rid(struct device *dev, struct device_node 
> **np,
>  			    u32 rid_in)
>  {
> @@ -590,6 +595,10 @@ static u32 __of_msi_map_rid(struct device *dev,
> struct device_node **np,
>  		if (!of_map_rid(parent_dev->of_node, rid_in, "msi-map",
>  				"msi-map-mask", np, &rid_out))
>  			break;
> +
> +	if (rid_out == rid_in)
> +		rid_out = ls_pcie_streamid_fix(parent_dev, rid_in);

Over my dead body. Get your firmware to properly program the LUT
so that it presents the ITS with a reasonable topology. There is
absolutely no way this kind of change makes it into the kernel.

Thanks,

         M.
-- 
Who you jivin' with that Cosmik Debris?
