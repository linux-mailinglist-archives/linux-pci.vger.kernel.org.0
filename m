Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207387CDF09
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 16:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbjJROQN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Oct 2023 10:16:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345102AbjJROPb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Oct 2023 10:15:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33390D61;
        Wed, 18 Oct 2023 07:13:48 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-5079f9675c6so7255130e87.2;
        Wed, 18 Oct 2023 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697638426; x=1698243226; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=PhyxmUtG7ajyW2SjJyU5m+NzLdFKfkutpPsZw1ffkps=;
        b=eHO5mQcHxbbVmVyUsdm3qfVjWzY+w9bQtxkJI0c35p3h7lQuNTeztpOG0cCewLmQuG
         iyppswWFa3ckyNVz0D8+6kc0j8xcKXiTQQbMURHfXFsDOwHYfaE7BpgLwPlNYk9+tPw8
         cNaKtQLzF297Fz9NAEOSXHPETpsOBD0gY71efeG7QWATTM8vdNEfn1pmlpRpSKevgBTJ
         WWmzeGmKu2bGtHxDAGw2A+eJBzqTfT06YOI/qf+kexkieSvNvJl58D/a+ArLKW1H7J+2
         zyQWK3zyMhZg8GjkI//OR4U+hFyzBezK2KBL8iCMH9A+IHvLayLasYc4PBA7G+eQIR7r
         kVvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697638426; x=1698243226;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PhyxmUtG7ajyW2SjJyU5m+NzLdFKfkutpPsZw1ffkps=;
        b=VeY2PyfFfoU8cpkNx+Gr+tOKc40DRQ7Zp2cI45eMqkoFLHzDhGwmosRzx9cb1D71Ri
         v6ZN4gf2S4SNYBFjPujRv5WTkxabvnpK6B9CurGZIjsgaX4raoBepcbgYYHAEDkhYi61
         14CTVkFZD1SNcof0XIhSZ9M2K3tZFO5EKBtOgf2sSPMNlXLiN4MSyYJ0REPBOW+476cf
         jkOJAaDCDX+3zxUK2/5Si0r2WNIinLimPc7iPvYjheuzpMIJK8mO7Ik7WGSor2zB5C0Q
         Sq+obrz93GdkL+tnCH1agg5RHde/aqfcpl4X+bK+dIqqmHdSegYCfBExA6k/DNgKvLQa
         qIkQ==
X-Gm-Message-State: AOJu0Yzhm967Z1byeowY5wuOn3VIg7CHIPeWbOCr6b7cRLzan+cx1fsy
        QeKkmVCVbQrIEN3yJpGxOGs=
X-Google-Smtp-Source: AGHT+IFXuSn1gbUFD88OFr29Di5DE0IEbBaKZ3/Kw7Gmui5oNJaleutG9zWrKFBSC2OhiZQESHKcTw==
X-Received: by 2002:ac2:548e:0:b0:507:9fa0:e244 with SMTP id t14-20020ac2548e000000b005079fa0e244mr3912595lfk.65.1697638425660;
        Wed, 18 Oct 2023 07:13:45 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id k10-20020ac257ca000000b00500a4679148sm714150lfo.20.2023.10.18.07.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Oct 2023 07:13:45 -0700 (PDT)
Date:   Wed, 18 Oct 2023 17:13:41 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 1/2] PCI: dwc: Add new accessors to enable/disable DBI
 CS2 while setting the BAR size
Message-ID: <rsv5vgle2d36skx75ds4hqzmlqwldmj4g4ghrlyfuu3ideb3rh@74mnro7qnp4v>
References: <20231017-pcie-qcom-bar-v1-0-3e26de07bec0@linaro.org>
 <20231017-pcie-qcom-bar-v1-1-3e26de07bec0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017-pcie-qcom-bar-v1-1-3e26de07bec0@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Oct 17, 2023 at 11:47:54AM +0530, Manivannan Sadhasivam wrote:
> From: Manivannan Sadhasivam <mani@kernel.org>
> 
> As per the DWC databook v4.21a, section M.4.1, in order to write some read
> only and shadow registers through application DBI, the device driver should
> assert DBI Chip Select 2 (CS2) in addition to DBI Chip Select (CS).
> 
> This is a requirement at least on the Qcom platforms while programming the
> BAR size, as the BAR mask registers are marked RO. So let's add two new
> accessors dw_pcie_dbi_cs2_{en/dis} to enable/disable CS2 access in a vendor
> specific way while programming the BAR size.

Emm, it's a known thing for all IP-core versions: dbi_cs2 must be
asserted to access the shadow DW PCIe CSRs space for both RC and
EP including the BARs mask and their enabling/disabling flag (there
are many more shadow CSRs available on DW PCIe EPs, and a few in DW
PCIe RCs). That's why the dw_pcie_ops->writel_dbi2 pointer has been
defined in the first place (dbi2 suffix means dbi_cs2). You should use
it to create the platform-specific dbi_cs2 write accessors like it's
done in pci-keystone.c and pcie-bt1.c. For instance like this:

static void qcom_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val)
{
	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
	int ret;

	writel(1, pcie_ep->elbi + ELBI_CS2_ENABLE);

	ret = dw_pcie_write(pci->dbi_base2 + reg, size, val);
	if (ret)
		dev_err(pci->dev, "write DBI address failed\n");

	writel(0, pcie_ep->elbi + ELBI_CS2_ENABLE);
}

/* Common DWC controller ops */
static const struct dw_pcie_ops pci_ops = {
	.link_up = qcom_pcie_dw_link_up,
	.start_link = qcom_pcie_dw_start_link,
	.stop_link = qcom_pcie_dw_stop_link,
	.write_dbi2 = qcom_pcie_write_dbi2,
};

For that reason there is absolutely no need in adding the new
callbacks.

-Serge(y)

> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-designware-ep.c |  6 ++++++
>  drivers/pci/controller/dwc/pcie-designware.h    | 13 +++++++++++++
>  2 files changed, 19 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index d34a5e87ad18..1874fb3d8df4 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -269,11 +269,17 @@ static int dw_pcie_ep_set_bar(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
>  
> +	dw_pcie_dbi_cs2_en(pci);
>  	dw_pcie_writel_dbi2(pci, reg_dbi2, lower_32_bits(size - 1));
> +	dw_pcie_dbi_cs2_dis(pci);
> +
>  	dw_pcie_writel_dbi(pci, reg, flags);
>  
>  	if (flags & PCI_BASE_ADDRESS_MEM_TYPE_64) {
> +		dw_pcie_dbi_cs2_en(pci);
>  		dw_pcie_writel_dbi2(pci, reg_dbi2 + 4, upper_32_bits(size - 1));
> +		dw_pcie_dbi_cs2_dis(pci);
> +
>  		dw_pcie_writel_dbi(pci, reg + 4, 0);
>  	}
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 55ff76e3d384..3cba27b5bbe5 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -379,6 +379,7 @@ struct dw_pcie_ops {
>  			     size_t size, u32 val);
>  	void    (*write_dbi2)(struct dw_pcie *pcie, void __iomem *base, u32 reg,
>  			      size_t size, u32 val);
> +	void	(*dbi_cs2_access)(struct dw_pcie *pcie, bool enable);
>  	int	(*link_up)(struct dw_pcie *pcie);
>  	enum dw_pcie_ltssm (*get_ltssm)(struct dw_pcie *pcie);
>  	int	(*start_link)(struct dw_pcie *pcie);
> @@ -508,6 +509,18 @@ static inline void dw_pcie_dbi_ro_wr_dis(struct dw_pcie *pci)
>  	dw_pcie_writel_dbi(pci, reg, val);
>  }
>  
> +static inline void dw_pcie_dbi_cs2_en(struct dw_pcie *pci)
> +{
> +	if (pci->ops && pci->ops->dbi_cs2_access)
> +		pci->ops->dbi_cs2_access(pci, true);
> +}
> +
> +static inline void dw_pcie_dbi_cs2_dis(struct dw_pcie *pci)
> +{
> +	if (pci->ops && pci->ops->dbi_cs2_access)
> +		pci->ops->dbi_cs2_access(pci, false);
> +}
> +
>  static inline int dw_pcie_start_link(struct dw_pcie *pci)
>  {
>  	if (pci->ops && pci->ops->start_link)
> 
> -- 
> 2.25.1
> 
