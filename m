Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 38B9BF073F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 21:50:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727401AbfKEUuI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 15:50:08 -0500
Received: from foss.arm.com ([217.140.110.172]:32816 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729760AbfKEUt5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 15:49:57 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF31412FC;
        Tue,  5 Nov 2019 12:49:56 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96B3340139;
        Tue,  5 Nov 2019 04:32:50 -0800 (PST)
Date:   Tue, 5 Nov 2019 12:32:40 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, shawnguo@kernel.org,
        leoyang.li@nxp.com, minghuan.Lian@nxp.com, mingkai.hu@nxp.com,
        roy.zang@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH v6 3/3] PCI: layerscape: Add LS1028a support
Message-ID: <20191105123233.GA26960@e121166-lin.cambridge.arm.com>
References: <20190902034319.14026-1-xiaowei.bao@nxp.com>
 <20190902034319.14026-3-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902034319.14026-3-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 02, 2019 at 11:43:19AM +0800, Xiaowei Bao wrote:
> Add support for the LS1028a PCIe controller.
> 
> Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> ---
> v2:
>  - No change.
> v3:
>  - Reuse the ls2088 driver data structurt.
> v4:
>  - No change.
> v5:
>  - No change.
> v6:
>  - No change.
> 
>  drivers/pci/controller/dwc/pci-layerscape.c | 1 +
>  1 file changed, 1 insertion(+)

I have not seen any comment on any layerscape driver patches
coming from the maintainers as listed in the MAINTAINERS
file (and CCed in this series).

I request maintainers ACK on these patches and I expect them
to start reviewing your code if they want to be still considered
maintainers for this driver.

The changes look OK minus Shawn's remark on compatible string
that was ignored.

Thanks,
Lorenzo

> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 3a5fa26..f24f79a 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -263,6 +263,7 @@ static const struct ls_pcie_drvdata ls2088_drvdata = {
>  static const struct of_device_id ls_pcie_of_match[] = {
>  	{ .compatible = "fsl,ls1012a-pcie", .data = &ls1046_drvdata },
>  	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
> +	{ .compatible = "fsl,ls1028a-pcie", .data = &ls2088_drvdata },
>  	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
>  	{ .compatible = "fsl,ls1046a-pcie", .data = &ls1046_drvdata },
>  	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
> -- 
> 2.9.5
> 
