Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3746918D8AF
	for <lists+linux-pci@lfdr.de>; Fri, 20 Mar 2020 20:46:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726773AbgCTTqs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Mar 2020 15:46:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:37580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726666AbgCTTqr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Mar 2020 15:46:47 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3B1520739;
        Fri, 20 Mar 2020 19:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584733607;
        bh=cWtAUzd2rzDP9wEzmMrW/qhJoPZ5i4sE8aCtwPlju7w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=X3d+L4Jqyb6dAW7q1cPglXf0FktkzS3wWtwooGY+RoSz3BWL3o5F9Z5AN7Kcgt/Gf
         3wQIAOtzNyVvErjlICDEncCpzpiwUU+kWLR/M5mZqN/nW0QsHfh2fWqvCnWKj+fc5L
         r2apIhcVhBidEfiS8bIYAaN7+ImQqdNl2BlHCeuM=
Date:   Fri, 20 Mar 2020 14:46:45 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Ansuel Smith <ansuelsmth@gmail.com>
Cc:     Stanimir Varbanov <svarbanov@mm-sol.com>,
        Sriram Palanisamy <gpalan@codeaurora.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 12/12] pcie: qcom: Set PCIE MRRS and MPS to 256B
Message-ID: <20200320194645.GA251282@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200320183455.21311-12-ansuelsmth@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 20, 2020 at 07:34:54PM +0100, Ansuel Smith wrote:
> From: Sriram Palanisamy <gpalan@codeaurora.org>
> 
> Set Max Read Request Size and Max Payload Size to 256 bytes,
> per chip team recommendation.

Is this to avoid a device defect or to optimize performance?

This should not be done in an individual driver for performance
reasons because these parameters need to be managed at the system
level.

If this is to work around a device defect, we probably need to think
about a quirk that changes the device capabilities advertised by this
bridge and then changes to the PCI core code to take that into
account.

> Signed-off-by: Gokul Sriram Palanisamy <gpalan@codeaurora.org>
> Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 37 ++++++++++++++++++++++++++
>  1 file changed, 37 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 03130a3206b4..ad437c6f49a0 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -125,6 +125,14 @@
>  
>  #define PCIE20_LNK_CONTROL2_LINK_STATUS2        0xA0
>  
> +#define __set(v, a, b)	(((v) << (b)) & GENMASK(a, b))
> +#define __mask(a, b)	(((1 << ((a) + 1)) - 1) & ~((1 << (b)) - 1))
> +#define PCIE20_DEV_CAS			0x78
> +#define PCIE20_MRRS_MASK		__mask(14, 12)
> +#define PCIE20_MRRS(x)			__set(x, 14, 12)
> +#define PCIE20_MPS_MASK			__mask(7, 5)
> +#define PCIE20_MPS(x)			__set(x, 7, 5)

These should all be the generic PCI_EXP_DEVCTL_READRQ and similar
#defines, since you use them on values from PCI_EXP_DEVCTL.

>  #define DEVICE_TYPE_RC				0x4
>  
>  #define QCOM_PCIE_2_1_0_MAX_SUPPLY	3
> @@ -1595,6 +1603,35 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  	return ret;
>  }
>  
> +static void qcom_pcie_fixup_final(struct pci_dev *pcidev)
> +{
> +	int cap, err;
> +	u16 ctl, reg_val;
> +
> +	cap = pci_pcie_cap(pcidev);
> +	if (!cap)
> +		return;
> +
> +	err = pci_read_config_word(pcidev, cap + PCI_EXP_DEVCTL, &ctl);
> +
> +	if (err)
> +		return;
> +
> +	reg_val = ctl;
> +
> +	if (((reg_val & PCIE20_MRRS_MASK) >> 12) > 1)
> +		reg_val = (reg_val & ~(PCIE20_MRRS_MASK)) | PCIE20_MRRS(0x1);
> +
> +	if (((ctl & PCIE20_MPS_MASK) >> 5) > 1)
> +		reg_val = (reg_val & ~(PCIE20_MPS_MASK)) | PCIE20_MPS(0x1);
> +
> +	err = pci_write_config_word(pcidev, cap + PCI_EXP_DEVCTL, reg_val);
> +
> +	if (err)
> +		dev_err(&pcidev->dev, "pcie config write failed %d\n", err);
> +}
> +DECLARE_PCI_FIXUP_FINAL(PCI_ANY_ID, PCI_ANY_ID, qcom_pcie_fixup_final);
> +
>  static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-apq8084", .data = &ops_1_0_0 },
>  	{ .compatible = "qcom,pcie-ipq8064", .data = &ops_2_1_0 },
> -- 
> 2.25.1
> 
