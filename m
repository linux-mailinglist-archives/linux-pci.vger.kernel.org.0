Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF023564CD3
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jul 2022 06:54:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231444AbiGDEyX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jul 2022 00:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230298AbiGDEyX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Jul 2022 00:54:23 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AE4261D
        for <linux-pci@vger.kernel.org>; Sun,  3 Jul 2022 21:54:21 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id a15so7907097pfv.13
        for <linux-pci@vger.kernel.org>; Sun, 03 Jul 2022 21:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=U+oU/OdcgqH94M8swY4c+9YpGrNEnPjLxx/obSui+jU=;
        b=dWabeNHnC6wAnuk5VA78pkZLlqPybVNG4pBfdPO9L0rA5T2pjqxC5av38jEovwuViO
         75ohOySX1hL0k4LqWrLLkEzgyKvTXwEW7T0iD9nhgk0MupDhL1Vw5d3xZ4ZLyghZQzE+
         rjsFFgvzHjOqAsuvKFs1yhw/4gkmnaBCXZdBffKczocO7hGq+vgmf+1zMngFKhYaik+W
         Mdeql9bAk0LEAWRsslOPxCZ7Zk6r4lMLppfJs4fdLIa8FxDNPumUG7I5jElGo+xaMJbA
         tF0ZWKXpUtx3+8rLq0fFFkMsUkWJ3tuiQYvbuM/cribfK9jEXrRTObnZNaWH0W/hjQHd
         rNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=U+oU/OdcgqH94M8swY4c+9YpGrNEnPjLxx/obSui+jU=;
        b=Ad9BR02voly7ACQ9VJznFDnWyh1HJfdl3PKoXHSRlj98gXniw8YhrhI6L3B1jxqd6c
         CU5mVhFjGBBTpRlg9DdsV67YEKs3qqOueN/RQGZnL4WK3oxj6Isx4ll6HSg7Iekj1XtM
         LmHiv66uot3PQQTn7L6+1d7GtSg2ylJKyCC66VVfOeq9qvjZGcE7SeW6lR7PXc8T0RxI
         9Psr3WAVQpePReStB/EZD+WdfVp8j3wEBNY032WXViVQYaqXE1xEBss9+8Vdm6SR1VjH
         WYbvKn2wleVrfeKUQu81kRclHsQ5UpId4QY36hCCLd4660tjNnXL/ZpdbnoUZhBCEyEk
         NINA==
X-Gm-Message-State: AJIora/SZrearQmE6kN35gg6dsdrO5yy16EXXHCDYLbjcBFakFfB8Esl
        0Pj0rWw+4JLu7PIsetwtf80j
X-Google-Smtp-Source: AGRyM1uv4M688ateZQuPmOIkkJ7vVj1NsDIwiqbKZuDPvJJHqUZmrCBVbXepb9w5i7xf2Svc7KpySA==
X-Received: by 2002:a63:6c06:0:b0:40d:e2a0:278c with SMTP id h6-20020a636c06000000b0040de2a0278cmr23030507pgc.328.1656910461287;
        Sun, 03 Jul 2022 21:54:21 -0700 (PDT)
Received: from thinkpad ([220.158.158.244])
        by smtp.gmail.com with ESMTPSA id a4-20020a170902710400b0016a1c61c603sm19781301pll.154.2022.07.03.21.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 21:54:21 -0700 (PDT)
Date:   Mon, 4 Jul 2022 10:24:15 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>
Subject: Re: [PATCH v2 2/2] PCI: qcom: Restrict pci transactions after pci
 suspend
Message-ID: <20220704045415.GC6560@thinkpad>
References: <1656055682-18817-1-git-send-email-quic_krichai@quicinc.com>
 <1656495214-4028-1-git-send-email-quic_krichai@quicinc.com>
 <1656495214-4028-3-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1656495214-4028-3-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 29, 2022 at 03:03:34PM +0530, Krishna chaitanya chundru wrote:
> If the endpoint device state is D0 and irq's are not freed, then
> kernel try to mask interrupts by writing in to the vector
> table (for MSIX interrupts) and config space (for MSI's).
> 
> These transactions are initiated after clocks are getting disabled
> as part of PM suspend call. Due to it, these transactions are
> resulting in un-clocked access and eventual to crashes.
> 
> So added a logic in qcom driver to restrict the unclocked access.
> And updated the logic to check the link state before masking
> or unmasking the interrupts.
> 

No other PCI driver is doing the DBI access restriction. So this makes me feel
that the fix is somewhere else.

I'll dig into it and come back.

Thanks,
Mani

> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware-host.c | 14 +++++++--
>  drivers/pci/controller/dwc/pcie-qcom.c            | 35 +++++++++++++++++++++--
>  2 files changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 2fa86f3..2a46b40 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -29,13 +29,23 @@ static void dw_msi_ack_irq(struct irq_data *d)
>  
>  static void dw_msi_mask_irq(struct irq_data *d)
>  {
> -	pci_msi_mask_irq(d);
> +	struct pcie_port *pp = irq_data_get_irq_chip_data(d->parent_data);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	if (dw_pcie_link_up(pci))
> +		pci_msi_mask_irq(d);
> +
>  	irq_chip_mask_parent(d);
>  }
>  
>  static void dw_msi_unmask_irq(struct irq_data *d)
>  {
> -	pci_msi_unmask_irq(d);
> +	struct pcie_port *pp = irq_data_get_irq_chip_data(d->parent_data);
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +
> +	if (dw_pcie_link_up(pci))
> +		pci_msi_unmask_irq(d);
> +
>  	irq_chip_unmask_parent(d);
>  }
>  
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 8e9ef37..227bc24a 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1331,12 +1331,41 @@ static int qcom_pcie_disable_clks_2_7_0(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> +static u32 qcom_pcie_read_dbi(struct dw_pcie *pci, void __iomem *base,
> +				u32 reg, size_t size)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	u32 val;
> +
> +	if (pcie->is_suspended)
> +		return PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +	dw_pcie_read(base + reg, size, &val);
> +	return val;
> +}
> +
> +static void qcom_pcie_write_dbi(struct dw_pcie *pci, void __iomem *base,
> +					u32 reg, size_t size, u32 val)
> +{
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +
> +	if (pcie->is_suspended)
> +		return;
> +
> +	dw_pcie_write(base + reg, size, val);
> +}
>  
>  static int qcom_pcie_link_up(struct dw_pcie *pci)
>  {
> -	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	u16 val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> +	struct qcom_pcie *pcie = to_qcom_pcie(pci);
> +	u16 offset;
> +	u16 val;
> +
> +	if (pcie->is_suspended)
> +		return false;
>  
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	val = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
>  	return !!(val & PCI_EXP_LNKSTA_DLLLA);
>  }
>  
> @@ -1580,6 +1609,8 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
>  static const struct dw_pcie_ops dw_pcie_ops = {
>  	.link_up = qcom_pcie_link_up,
>  	.start_link = qcom_pcie_start_link,
> +	.read_dbi = qcom_pcie_read_dbi,
> +	.write_dbi = qcom_pcie_write_dbi,
>  };
>  
>  static int qcom_pcie_probe(struct platform_device *pdev)
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
