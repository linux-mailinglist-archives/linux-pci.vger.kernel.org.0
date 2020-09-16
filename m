Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B27626CE4D
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 00:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbgIPWGV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 18:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:36050 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726084AbgIPWGV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Sep 2020 18:06:21 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E40DE206CA;
        Wed, 16 Sep 2020 22:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600293980;
        bh=HhexOyxrZbLvVV+72b1lIviOhvFDH6uZ/bUlsYtWPio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=rVwpXrDi3mbuLSa4Ub9e3VirMVCIepbV/7Whdx6YK92YJtdSelaMZH42apzK4nFUs
         ur40xEI3g3IxpyKvxIGk7q+UDh06FhQ4GEb8/Jrnejk5U2+ATbaKRyq017p/GvA8w6
         e2FtQc53AxUd8aU2Hr7XMeP4Uw8qk+f8TKT+4c6I=
Date:   Wed, 16 Sep 2020 17:06:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, kishon@ti.com,
        vkoul@kernel.org, robh@kernel.org, svarbanov@mm-sol.com,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, mgautam@codeaurora.org,
        devicetree@vger.kernel.org, Jonathan Marek <jonathan@marek.ca>
Subject: Re: [PATCH 5/5] pci: controller: dwc: qcom: Harcode PCIe config SID
Message-ID: <20200916220618.GA1589351@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200916132000.1850-6-manivannan.sadhasivam@linaro.org>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

s/Harcode/Hardcode/ (in subject)

Also fix subject format as for 4/5.

On Wed, Sep 16, 2020 at 06:50:00PM +0530, Manivannan Sadhasivam wrote:
> Hardcode the PCIe config SID table value. This is needed to avoid random
> MHI failure observed during reboot on SM8250.
> 
> Signed-off-by: Jonathan Marek <jonathan@marek.ca>
> [mani: stripped out unnecessary settings and ported for upstream]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index ca8ad354e09d..50748016ce96 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -57,6 +57,7 @@
>  #define PCIE20_PARF_SID_OFFSET			0x234
>  #define PCIE20_PARF_BDF_TRANSLATE_CFG		0x24C
>  #define PCIE20_PARF_DEVICE_TYPE			0x1000
> +#define PCIE20_PARF_BDF_TO_SID_TABLE_N		0x2000
>  
>  #define PCIE20_ELBI_SYS_CTRL			0x04
>  #define PCIE20_ELBI_SYS_CTRL_LT_ENABLE		BIT(0)
> @@ -1290,6 +1291,9 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
>  	if (ret)
>  		goto err;
>  
> +	writel(0x0, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N);
> +	writel(0x01000100, pcie->parf + PCIE20_PARF_BDF_TO_SID_TABLE_N + 0x054);
> +
>  	return 0;
>  err:
>  	qcom_ep_reset_assert(pcie);
> -- 
> 2.17.1
> 
