Return-Path: <linux-pci+bounces-12295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 414069614C8
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 18:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED519283646
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 16:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CFB1D0493;
	Tue, 27 Aug 2024 16:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TX8SU47K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235271CF2B8
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724777920; cv=none; b=aRArygAq5s/I52/sMx5SrMLPfq4aOxqwLkUgOlJApO9H1y99LY8uy8DnctkJRhelnLl2jTmmolnghuNEM5+BuVdJSsMoAoOQLkZg6DR8h8EBEytsLpYjPY7VRNaeOfzeOePXG3UweXN/RBVE8Xw0AOWF61s5xDEleCRSKRfhn0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724777920; c=relaxed/simple;
	bh=lNC8TKaZ7ZAeR7oZUyy1KiKW62bn47+uI8IaJy1GuD4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bk2Vx5epz95gZ/KCJrlr5mFl0Xq1ZYTms2WKssPFphJDUjKKP6DiMtBPziRPLPSaPubgEFhqRlK42MKWZDU9W8kpGPpokBIC0tXODF2uJpk4nLh7ggzoPbnxaVYr8UPBVu42Pu79vlKcA67BtCuF2jjTOnyjJ0H5EXlm2X/3BCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TX8SU47K; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-7cd8d2731d1so3786946a12.3
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 09:58:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724777917; x=1725382717; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RNOwiGcykeoyGFZH+Z8xEbsCMXGedxmWrwkU43JsjYY=;
        b=TX8SU47KoQckwcUGI/0lnAuH463BP1bmO5nAgkSfZ153JDzS4BxFs4QkxX3Pmksfxi
         ZoqS+7PIlFfXeup1GXypegHWsfyOQnikutwN/k1vRVYvaVOZXZ2sGskklCY0A75nCW2n
         AGo7P0IbX/uFND436/RisTyeN4NuVTa/A6HHIwVCpKB64o9zPezbDEpU7Zxo0T2Mliyy
         V4YrRMC1VdA3GlYkvBcwkwt1lJAQuPPKMl2W/nSB6OAsVyswc9MRkioAVfyyDL+WIAAv
         qfoK17lMiDdFL5JDjgG4P2tVjILQb9y0sPRPCZNJQxN0ZmjfBg4UbrlRAfX3g8YAWTWB
         WCEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724777917; x=1725382717;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNOwiGcykeoyGFZH+Z8xEbsCMXGedxmWrwkU43JsjYY=;
        b=axN8zz4tkUqhKffU6qjSE1cJvqPGw5EwIUzZeiaiDwX41QEHUyQ/YNIx7h63PfgsWW
         BFS/rQylT2T4dLvbZME5eCbK0wHxh6stIfZtOEGQTHsxmat39aDmhHXOCJMQGTN7sDR/
         e56QtbPGFic9Wc+e8yehF057FrnbyVfy6H8+R2cSGqnrfZQs28cGxaJqDHnT4b9eVFzU
         G24Gf7WCHBA81/WsVdF7Krm7OVNCa0R/T1cJvnzg6jSGNScMwL7wGi6uqp5BAMctAuGG
         TcpgBTtWdtmJ0lPWYLUZYf42bLVoApiZ2USdJKV4RbSB8sUx+i5/sFlTfqXIKxzMawqg
         zKog==
X-Forwarded-Encrypted: i=1; AJvYcCV+Dajrtq7oLswtDzjgq9CAgTMCeNmiD4KVsTl8DB1yyAhyEO+UmEEnm9dLL1bsmUTQBdW5R/w0ams=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvrwBKzvir3fOSiharyoX2axuElLiEhQmOdKeDBhg5gr3DYBgM
	W6DOt9PSC+BBO7AMjol7rwhkRbOJm3c62gPhfbjf8nSrn6xxYpspTwhsN79jlA==
X-Google-Smtp-Source: AGHT+IGLcPL1IDSSlTXVztXaCfb8EIBRYUJpya5p4/6WNmOA1w8yKEQ+6PrKcZDyqShicuXYBx34YA==
X-Received: by 2002:a17:90a:a883:b0:2d3:cfe1:31f6 with SMTP id 98e67ed59e1d1-2d646c1ebd8mr13729729a91.25.1724777917253;
        Tue, 27 Aug 2024 09:58:37 -0700 (PDT)
Received: from thinkpad ([117.213.96.164])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613b1f0d5sm12370594a91.55.2024.08.27.09.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 09:58:36 -0700 (PDT)
Date: Tue, 27 Aug 2024 22:28:26 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Qiang Yu <quic_qianyu@quicinc.com>, vkoul@kernel.org, kishon@kernel.org,
	robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
	sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
	quic_devipriy@quicinc.com, kw@linux.com, lpieralisi@kernel.org,
	neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH 8/8] PCI: qcom: Add support to PCIe slot power supplies
Message-ID: <20240827165826.moe6cnemeheos6jn@thinkpad>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-9-quic_qianyu@quicinc.com>
 <CAA8EJpq5KergZ8czg4F=EYMLANoOeBsiSVoO-zAgfG0ezQrKCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAA8EJpq5KergZ8czg4F=EYMLANoOeBsiSVoO-zAgfG0ezQrKCQ@mail.gmail.com>

On Tue, Aug 27, 2024 at 02:44:09PM +0300, Dmitry Baryshkov wrote:
> On Tue, 27 Aug 2024 at 09:36, Qiang Yu <quic_qianyu@quicinc.com> wrote:
> >
> > On platform x1e80100 QCP, PCIe3 is a standard x8 form factor. Hence, add
> > support to use 3.3v, 3.3v aux and 12v regulators.
> 
> First of all, I don't see corresponding bindings change.
> 
> Second, these supplies power up the slot, not the host controller
> itself. As such these supplies do not belong to the host controller
> entry. Please consider using the pwrseq framework instead.
> 

Indeed. For legacy reasons, slot power supplies were populated in the host
bridge node itself until recently Rob started objecting it [1]. And it makes
real sense to put these supplies in the root port node and handle them in the
relevant driver.

I'm still evaluating whether the handling should be done in the portdrv or
pwrctl driver, but haven't reached the conclusion. Pwrctl seems to be the ideal
choice, but I see a few issues related to handling the OF node for the root
port.

Hope I'll come to a conclusion in the next few days and will update this thread.

- Mani

[1] https://lore.kernel.org/lkml/20240604235806.GA1903493-robh@kernel.org/

> >
> > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom.c | 52 +++++++++++++++++++++++++-
> >  1 file changed, 50 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 6f953e32d990..59fb415dfeeb 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -248,6 +248,8 @@ struct qcom_pcie_cfg {
> >         bool no_l0s;
> >  };
> >
> > +#define QCOM_PCIE_SLOT_MAX_SUPPLIES                    3
> > +
> >  struct qcom_pcie {
> >         struct dw_pcie *pci;
> >         void __iomem *parf;                     /* DT parf */
> > @@ -260,6 +262,7 @@ struct qcom_pcie {
> >         struct icc_path *icc_cpu;
> >         const struct qcom_pcie_cfg *cfg;
> >         struct dentry *debugfs;
> > +       struct regulator_bulk_data slot_supplies[QCOM_PCIE_SLOT_MAX_SUPPLIES];
> >         bool suspended;
> >         bool use_pm_opp;
> >  };
> > @@ -1174,6 +1177,41 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
> >         return !!(val & PCI_EXP_LNKSTA_DLLLA);
> >  }
> >
> > +static int qcom_pcie_enable_slot_supplies(struct qcom_pcie *pcie)
> > +{
> > +       struct dw_pcie *pci = pcie->pci;
> > +       int ret;
> > +
> > +       ret = regulator_bulk_enable(ARRAY_SIZE(pcie->slot_supplies),
> > +                                   pcie->slot_supplies);
> > +       if (ret < 0)
> > +               dev_err(pci->dev, "Failed to enable slot regulators\n");
> > +
> > +       return ret;
> > +}
> > +
> > +static void qcom_pcie_disable_slot_supplies(struct qcom_pcie *pcie)
> > +{
> > +       regulator_bulk_disable(ARRAY_SIZE(pcie->slot_supplies),
> > +                              pcie->slot_supplies);
> > +}
> > +
> > +static int qcom_pcie_get_slot_supplies(struct qcom_pcie *pcie)
> > +{
> > +       struct dw_pcie *pci = pcie->pci;
> > +       int ret;
> > +
> > +       pcie->slot_supplies[0].supply = "vpcie12v";
> > +       pcie->slot_supplies[1].supply = "vpcie3v3";
> > +       pcie->slot_supplies[2].supply = "vpcie3v3aux";
> > +       ret = devm_regulator_bulk_get(pci->dev, ARRAY_SIZE(pcie->slot_supplies),
> > +                                     pcie->slot_supplies);
> > +       if (ret < 0)
> > +               dev_err(pci->dev, "Failed to get slot regulators\n");
> > +
> > +       return ret;
> > +}
> > +
> >  static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> >  {
> >         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -1182,10 +1220,14 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> >
> >         qcom_ep_reset_assert(pcie);
> >
> > -       ret = pcie->cfg->ops->init(pcie);
> > +       ret = qcom_pcie_enable_slot_supplies(pcie);
> >         if (ret)
> >                 return ret;
> >
> > +       ret = pcie->cfg->ops->init(pcie);
> > +       if (ret)
> > +               goto err_disable_slot;
> > +
> >         ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> >         if (ret)
> >                 goto err_deinit;
> > @@ -1216,7 +1258,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> >         phy_power_off(pcie->phy);
> >  err_deinit:
> >         pcie->cfg->ops->deinit(pcie);
> > -
> > +err_disable_slot:
> > +       qcom_pcie_disable_slot_supplies(pcie);
> >         return ret;
> >  }
> >
> > @@ -1228,6 +1271,7 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
> >         qcom_ep_reset_assert(pcie);
> >         phy_power_off(pcie->phy);
> >         pcie->cfg->ops->deinit(pcie);
> > +       qcom_pcie_disable_slot_supplies(pcie);
> >  }
> >
> >  static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
> > @@ -1602,6 +1646,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> >                         goto err_pm_runtime_put;
> >         }
> >
> > +       ret = qcom_pcie_get_slot_supplies(pcie);
> > +       if (ret)
> > +               goto err_pm_runtime_put;
> > +
> >         ret = pcie->cfg->ops->get_resources(pcie);
> >         if (ret)
> >                 goto err_pm_runtime_put;
> > --
> > 2.34.1
> >
> 
> 
> -- 
> With best wishes
> Dmitry

-- 
மணிவண்ணன் சதாசிவம்

