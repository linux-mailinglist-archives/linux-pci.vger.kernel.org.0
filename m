Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9DBD2C9A74
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2019 11:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728763AbfJCJKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Oct 2019 05:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:51290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727912AbfJCJKu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Oct 2019 05:10:50 -0400
Received: from X250 (li937-157.members.linode.com [45.56.119.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9FAA3217D7;
        Thu,  3 Oct 2019 09:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570093849;
        bh=MMxJEs96BVXDKmKuJCphNcJwHlAfmZsNg6vA8HtDNS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z8S71spy+Xp8DisodNAuE7wi8wIsa9qQOR+VeMzwJLbpw4Dz2CBl4oDhZUZg7KyCI
         jKIATNnmJs4DhCYtb3wotBj33BxFRZNeLBIbIBtbocDEhzMwCTQxJd7mBGOpEAFDOG
         rXAe6mVQ6Y0Su2CLdU80pQ4UTH4eE+qWy+ExCBTc=
Date:   Thu, 3 Oct 2019 17:10:33 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Xiaowei Bao <xiaowei.bao@nxp.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, leoyang.li@nxp.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        lorenzo.pieralisi@arm.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, bhelgaas@google.com,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH v6 3/3] PCI: layerscape: Add LS1028a support
Message-ID: <20191003091019.GB22491@X250>
References: <20190902034319.14026-1-xiaowei.bao@nxp.com>
 <20190902034319.14026-3-xiaowei.bao@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190902034319.14026-3-xiaowei.bao@nxp.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
> 
> diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
> index 3a5fa26..f24f79a 100644
> --- a/drivers/pci/controller/dwc/pci-layerscape.c
> +++ b/drivers/pci/controller/dwc/pci-layerscape.c
> @@ -263,6 +263,7 @@ static const struct ls_pcie_drvdata ls2088_drvdata = {
>  static const struct of_device_id ls_pcie_of_match[] = {
>  	{ .compatible = "fsl,ls1012a-pcie", .data = &ls1046_drvdata },
>  	{ .compatible = "fsl,ls1021a-pcie", .data = &ls1021_drvdata },
> +	{ .compatible = "fsl,ls1028a-pcie", .data = &ls2088_drvdata },

I think you can save this driver change by using "fsl,ls2088a-pcie" as
compatible fallback like below.

  compatible = "fsl,ls1028a-pcie", "fsl,ls2088a-pcie";

Shawn

>  	{ .compatible = "fsl,ls1043a-pcie", .data = &ls1043_drvdata },
>  	{ .compatible = "fsl,ls1046a-pcie", .data = &ls1046_drvdata },
>  	{ .compatible = "fsl,ls2080a-pcie", .data = &ls2080_drvdata },
> -- 
> 2.9.5
> 
