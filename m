Return-Path: <linux-pci+bounces-13050-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6101A97572D
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 17:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78BCEB23916
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 15:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050F5185B7A;
	Wed, 11 Sep 2024 15:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TLuxYG2o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53DF21E498
	for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2024 15:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726068760; cv=none; b=stxYFauRlmtO0uvGyqswZw0KIfGl1EYZjYSU5K4d4c/Mp8GAy5o+DOn/pOXDPGBmWTjqYyApP+Z9eDdhWnXnLRLfwF6nxN+FX/EdfADhpkWrblemqt+1Vpz/OfGQqa6Dd9V1KjUDpNQa9bfPzwY3AclN4k//RFbi+yzISAxgtH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726068760; c=relaxed/simple;
	bh=n/THAopzoKNb9ho6jlx1u+EKvseKQuYpJqcPQgFMlqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SZpc3hRTqQvZBoW1phkMO0BqEHdUE1mxJlVz10UigdkVKZyk+buee9QdTjUQUEQOT6ndCCcBkAt+slY0pEGQuaVpVegJIyM/wpx/tun726qONkmN31VFR+161Tr3F1zuoAUXofE2Fijmu/iDR7vbPw+OyFfP7jjHK8s0ihmjF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TLuxYG2o; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-718da0821cbso4492566b3a.0
        for <linux-pci@vger.kernel.org>; Wed, 11 Sep 2024 08:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726068759; x=1726673559; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JUnLTmnkKuTjduDvDakmnEv59zQ17ggV64w/1jebL68=;
        b=TLuxYG2o17aScjBLybw279ioBxR58blaPAE4nIApf+9a9PaFvqMsxOQat190ivSi8v
         jD4fkfx0tFXfTEbM2/2K3x4Nob2Kymauq4QdP4f6lXfgwarMubQKd/4yKbNeVO+/zfIu
         VExs1w+kS0bOVwSvjcSNWBD1d3RJxgqgcu3VvRTen+cnLjtjnsCV4ELJxCRVPGseKNh7
         c1pDkFcTFDcjfr0LpyPJCVupp1NACHgEZHRg8o1uhN0JwLnh2X4S1qMI8y8qkjCFCDW8
         a2z7sF3ruBXWYnC3TJyJSY4n+CzhlPgVGnvS5ByCIv0ogdwfrfnA4z48YOp/TXFaXP8g
         EnwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726068759; x=1726673559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JUnLTmnkKuTjduDvDakmnEv59zQ17ggV64w/1jebL68=;
        b=Mr3VXSmgRnz+Gf4/bV7QPK6lt3nox+DcXq0tNskl7O80dejX/DCGf1c0moSIgWUYSh
         QAyL+B0FLOT8rzvF5txU0z2w0GPHbRIvKRW41t024cTUfAjZIJ4rkU4elo5K5HvElpQ7
         tG+vwTGcE+LStwNDULwjMPYG8S4UD0PgxSKi3Xo87wMgFWypsediOW+NKlv/B7KkAf3Q
         bQlS0mrZQ4bbQzqlyO0WM/Nm9nblWUeEbOgyJ4LdQSMahYORsXDWDvut+VnXkHNcmfwj
         P796grodK8Hoq62OinCmu94gz1c7tfbQAUIQs6WDP85WV25Du7amSqkNIdUZzOeQyiOW
         vp1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXrZPnWvSPGGgfIpeRLje2Omu5M8rbVSyAMOY8jU6nbb0q8rrJad3PRKH7hIo2ag2r7mc7RIq/kkoI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6AybqzmtdhakIJaSrZaSKT1QjLxovKZU7pnQ16l9n+CMMDwWE
	Xh3yvdVkyYW4w54Ll7h0329IxRMHX+kmuMSgo+dAczd49jKVfSrY5iHc/WJVDg==
X-Google-Smtp-Source: AGHT+IEgOgO8muSou4mMHOAUIftNXmTF9h5ug/uQEGPL0Bqkvr313ObMh3MqMwuRezxyzZzkjOshzA==
X-Received: by 2002:a05:6a00:4fc3:b0:717:fd98:4a6 with SMTP id d2e1a72fcca58-718e3fc0534mr21290930b3a.11.1726068758507;
        Wed, 11 Sep 2024 08:32:38 -0700 (PDT)
Received: from thinkpad ([120.60.130.207])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db1fdf67b0sm108896a12.79.2024.09.11.08.32.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 08:32:38 -0700 (PDT)
Date: Wed, 11 Sep 2024 21:02:28 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Qiang Yu <quic_qianyu@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, vkoul@kernel.org,
	kishon@kernel.org, robh@kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	mturquette@baylibre.com, sboyd@kernel.org, abel.vesa@linaro.org,
	quic_msarkar@quicinc.com, quic_devipriy@quicinc.com, kw@linux.com,
	lpieralisi@kernel.org, neil.armstrong@linaro.org,
	linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH 8/8] PCI: qcom: Add support to PCIe slot power supplies
Message-ID: <20240911153228.7ajcqicxnu2afhbp@thinkpad>
References: <20240827063631.3932971-1-quic_qianyu@quicinc.com>
 <20240827063631.3932971-9-quic_qianyu@quicinc.com>
 <CAA8EJpq5KergZ8czg4F=EYMLANoOeBsiSVoO-zAgfG0ezQrKCQ@mail.gmail.com>
 <20240827165826.moe6cnemeheos6jn@thinkpad>
 <26f2845f-2e29-4887-9f33-0b5b2a06adb6@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <26f2845f-2e29-4887-9f33-0b5b2a06adb6@quicinc.com>

On Wed, Sep 11, 2024 at 04:17:41PM +0800, Qiang Yu wrote:
> 
> On 8/28/2024 12:58 AM, Manivannan Sadhasivam wrote:
> > On Tue, Aug 27, 2024 at 02:44:09PM +0300, Dmitry Baryshkov wrote:
> > > On Tue, 27 Aug 2024 at 09:36, Qiang Yu <quic_qianyu@quicinc.com> wrote:
> > > > On platform x1e80100 QCP, PCIe3 is a standard x8 form factor. Hence, add
> > > > support to use 3.3v, 3.3v aux and 12v regulators.
> > > First of all, I don't see corresponding bindings change.
> > > 
> > > Second, these supplies power up the slot, not the host controller
> > > itself. As such these supplies do not belong to the host controller
> > > entry. Please consider using the pwrseq framework instead.
> > > 
> > Indeed. For legacy reasons, slot power supplies were populated in the host
> > bridge node itself until recently Rob started objecting it [1]. And it makes
> > real sense to put these supplies in the root port node and handle them in the
> > relevant driver.
> > 
> > I'm still evaluating whether the handling should be done in the portdrv or
> > pwrctl driver, but haven't reached the conclusion. Pwrctl seems to be the ideal
> > choice, but I see a few issues related to handling the OF node for the root
> > port.
> > 
> > Hope I'll come to a conclusion in the next few days and will update this thread.
> > 
> > - Mani
> > 
> > [1] https://lore.kernel.org/lkml/20240604235806.GA1903493-robh@kernel.org/
> Hi Mani, do you have any updates?
> 

I'm working with Bartosz to add a new pwrctl driver for rootports. And we are
debugging an issue currently. Unfortunately, the progress is very slow as I'm on
vacation still.

Will post the patches once it got resolved.

- Mani

> Thanks,
> Qiang
> > 
> > > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> > > > ---
> > > >   drivers/pci/controller/dwc/pcie-qcom.c | 52 +++++++++++++++++++++++++-
> > > >   1 file changed, 50 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index 6f953e32d990..59fb415dfeeb 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -248,6 +248,8 @@ struct qcom_pcie_cfg {
> > > >          bool no_l0s;
> > > >   };
> > > > 
> > > > +#define QCOM_PCIE_SLOT_MAX_SUPPLIES                    3
> > > > +
> > > >   struct qcom_pcie {
> > > >          struct dw_pcie *pci;
> > > >          void __iomem *parf;                     /* DT parf */
> > > > @@ -260,6 +262,7 @@ struct qcom_pcie {
> > > >          struct icc_path *icc_cpu;
> > > >          const struct qcom_pcie_cfg *cfg;
> > > >          struct dentry *debugfs;
> > > > +       struct regulator_bulk_data slot_supplies[QCOM_PCIE_SLOT_MAX_SUPPLIES];
> > > >          bool suspended;
> > > >          bool use_pm_opp;
> > > >   };
> > > > @@ -1174,6 +1177,41 @@ static int qcom_pcie_link_up(struct dw_pcie *pci)
> > > >          return !!(val & PCI_EXP_LNKSTA_DLLLA);
> > > >   }
> > > > 
> > > > +static int qcom_pcie_enable_slot_supplies(struct qcom_pcie *pcie)
> > > > +{
> > > > +       struct dw_pcie *pci = pcie->pci;
> > > > +       int ret;
> > > > +
> > > > +       ret = regulator_bulk_enable(ARRAY_SIZE(pcie->slot_supplies),
> > > > +                                   pcie->slot_supplies);
> > > > +       if (ret < 0)
> > > > +               dev_err(pci->dev, "Failed to enable slot regulators\n");
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > > +static void qcom_pcie_disable_slot_supplies(struct qcom_pcie *pcie)
> > > > +{
> > > > +       regulator_bulk_disable(ARRAY_SIZE(pcie->slot_supplies),
> > > > +                              pcie->slot_supplies);
> > > > +}
> > > > +
> > > > +static int qcom_pcie_get_slot_supplies(struct qcom_pcie *pcie)
> > > > +{
> > > > +       struct dw_pcie *pci = pcie->pci;
> > > > +       int ret;
> > > > +
> > > > +       pcie->slot_supplies[0].supply = "vpcie12v";
> > > > +       pcie->slot_supplies[1].supply = "vpcie3v3";
> > > > +       pcie->slot_supplies[2].supply = "vpcie3v3aux";
> > > > +       ret = devm_regulator_bulk_get(pci->dev, ARRAY_SIZE(pcie->slot_supplies),
> > > > +                                     pcie->slot_supplies);
> > > > +       if (ret < 0)
> > > > +               dev_err(pci->dev, "Failed to get slot regulators\n");
> > > > +
> > > > +       return ret;
> > > > +}
> > > > +
> > > >   static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> > > >   {
> > > >          struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > > > @@ -1182,10 +1220,14 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> > > > 
> > > >          qcom_ep_reset_assert(pcie);
> > > > 
> > > > -       ret = pcie->cfg->ops->init(pcie);
> > > > +       ret = qcom_pcie_enable_slot_supplies(pcie);
> > > >          if (ret)
> > > >                  return ret;
> > > > 
> > > > +       ret = pcie->cfg->ops->init(pcie);
> > > > +       if (ret)
> > > > +               goto err_disable_slot;
> > > > +
> > > >          ret = phy_set_mode_ext(pcie->phy, PHY_MODE_PCIE, PHY_MODE_PCIE_RC);
> > > >          if (ret)
> > > >                  goto err_deinit;
> > > > @@ -1216,7 +1258,8 @@ static int qcom_pcie_host_init(struct dw_pcie_rp *pp)
> > > >          phy_power_off(pcie->phy);
> > > >   err_deinit:
> > > >          pcie->cfg->ops->deinit(pcie);
> > > > -
> > > > +err_disable_slot:
> > > > +       qcom_pcie_disable_slot_supplies(pcie);
> > > >          return ret;
> > > >   }
> > > > 
> > > > @@ -1228,6 +1271,7 @@ static void qcom_pcie_host_deinit(struct dw_pcie_rp *pp)
> > > >          qcom_ep_reset_assert(pcie);
> > > >          phy_power_off(pcie->phy);
> > > >          pcie->cfg->ops->deinit(pcie);
> > > > +       qcom_pcie_disable_slot_supplies(pcie);
> > > >   }
> > > > 
> > > >   static void qcom_pcie_host_post_init(struct dw_pcie_rp *pp)
> > > > @@ -1602,6 +1646,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > > >                          goto err_pm_runtime_put;
> > > >          }
> > > > 
> > > > +       ret = qcom_pcie_get_slot_supplies(pcie);
> > > > +       if (ret)
> > > > +               goto err_pm_runtime_put;
> > > > +
> > > >          ret = pcie->cfg->ops->get_resources(pcie);
> > > >          if (ret)
> > > >                  goto err_pm_runtime_put;
> > > > --
> > > > 2.34.1
> > > > 
> > > 
> > > -- 
> > > With best wishes
> > > Dmitry

-- 
மணிவண்ணன் சதாசிவம்

