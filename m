Return-Path: <linux-pci+bounces-18683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A5AD9F621B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 10:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C12161961
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 09:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65239198832;
	Wed, 18 Dec 2024 09:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WKZpv/dj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B79E7165EF8
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734515178; cv=none; b=Zrx0i6UjXCfF959gwlFX5h5JU1ZI1MeNIG8T2zsEE/+WgdncVUdz+dPYhbKeobOTgxKEqb3OXxc42/vnxnya0z/RyxvN9+Moze5TSVU9MSVvaQKrFPB4FfPdxpbKvubnOd3ewlaOJMDjo8QmMAJBQ723XiVOIjpwLAGNk+kOYMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734515178; c=relaxed/simple;
	bh=eIF1iCXbYoUBtz1oWY9/PbVWZ4xErWglHEwvqZrxO3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ru3AM+M7OqOdVtCZ0r6qgXMYW3z51pMMzVTgmKMMvvxFkMZqXp1a9wmZARCye0R6c+qaPaBcPBT7IUJSjliqx42K4zvyBcUKMQDNWuq2LVry/4n/UkDCrRWnCIC/gsy89CI/x+8gd+kjFmpp5cD5aaAUb/qzjW9ZVNjHS0M7pkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WKZpv/dj; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-215770613dbso42513655ad.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 01:46:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734515175; x=1735119975; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pXXsnJWHazfaSUP/GHMRDCdHmTBTRf0ix5hsVwacD90=;
        b=WKZpv/djOiut1GD6fpTmIsUzvEzcmdK7hnfTvJmLDbz0AtoToX1BQOQRA94om169EX
         SLGck0KO3fTDr1jUkm8SHZGj0PITZ3r0ACYD3AdVlxYlG8Pu5SZFt+ZdISQBINyk7bf1
         Z9RGqqtpjB9JtJNWr1GnziOQ9ghYtk3YXL1e5V4CxxYdX+4/rLjWLpGrJFg11tsubmzi
         kJtP6fu7foOcMb+Kr3Hm8qDOuVWjrRkLkTQgLMAQpypNz10VWrt8iO1N6Vlwh0rxywcb
         elPq1FXryMlIL/h4mnsSHcZytqRxFDbl4bnEsUpJDKvAoh0sh5cyT/9oFmxAe3IK6V9B
         ZTXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734515175; x=1735119975;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXXsnJWHazfaSUP/GHMRDCdHmTBTRf0ix5hsVwacD90=;
        b=svHvIVQNHzpLQhCTq+tvOn7tS+Tx9u9JrAHBLfi3MJ0y3RHIAOdv7ywEASSxNvZRhR
         KlmTlKiRzfaOs+c0AelprXbEQavL+11X2Qq79O4WGzTT66R2VbrRmVeR0HeZ+ZjO6p/p
         1SwnqcvwEFv14BDvSWTKtNBjDkK4xnmmrmZPkS+aqqsKcCeDOLFdeVHXsQy4XhUuWK7g
         iZeXewmohYcuZ6CKfZP0WJIi3TFXoxoWnf/19H0sZjiQKuOlCe+4NXBkTe+MdM5fx86F
         dAELD09RJ0MglGMxx6ZzgaQisu8bEpP1PP7oIkAqFzkKzezBRxi1crwhfY9ZPwElgdzO
         4T6g==
X-Forwarded-Encrypted: i=1; AJvYcCWbm9ws5nuJipWGFs2SVBcwmPz3SklkygjDuKJmkEVe934KQsU62LHM0rpQKtDboHFtOzmkNvNk+CY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9/suiLw87as3ebL7iqnKb7hS08YdvjQgzz13iXkND4fk+izHS
	DJpXk1eFPgnaBYCZ9gAjCSKzFpSYm3InGL9mIEkOpRML7PZk4bj0YrxQbG09SA==
X-Gm-Gg: ASbGncsxPTNWXDOluKaiuzO0nFOOY2DxA2OJC888Hsz6Mxl+nwddN4gw2x6wX7ZgL4O
	RBYBXZiF+r11tN2HisCxitf+s8WzYrZkndoLxoZcQPMlCPjZANhzp7diUgUh4WhfGnBw7jfmATR
	MBnRKcU+be347uNh3hEFOHOMMqIk1qTdQHP/3Dl9fjP0wxB62oPNw2ELvpnqM8NJo1C7DjGyu1c
	xhoh5Yd/XZbkl6JL9rWvpzXckQmqSq/4ZwEhWEAaOMDBWUC97xgKc3mmkV9bZbnMa40
X-Google-Smtp-Source: AGHT+IFqUIwo1Ikpx9Q1p35hwXgeavzvbPAmGa2NY+JFf2suz00vESnUChpaxHz8BxW9HDpRMZJpNA==
X-Received: by 2002:a17:902:c407:b0:216:2dc5:233c with SMTP id d9443c01a7336-218d724962dmr29793665ad.41.1734515175035;
        Wed, 18 Dec 2024 01:46:15 -0800 (PST)
Received: from thinkpad ([117.193.214.60])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-218a1db5e05sm72437155ad.44.2024.12.18.01.46.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 01:46:14 -0800 (PST)
Date: Wed, 18 Dec 2024 15:16:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	p.zabel@pengutronix.de, cassel@kernel.org,
	quic_schintav@quicinc.com, fabrice.gasnier@foss.st.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] PCI: stm32: Add PCIe host support for STM32MP25
Message-ID: <20241218094606.sljdx2w27thc5ahj@thinkpad>
References: <20241126155119.1574564-1-christian.bruel@foss.st.com>
 <20241126155119.1574564-3-christian.bruel@foss.st.com>
 <20241203145244.trgrobtfmumtiwuc@thinkpad>
 <ced7a55a-d968-497f-abc2-663855882a3f@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ced7a55a-d968-497f-abc2-663855882a3f@foss.st.com>

On Mon, Dec 16, 2024 at 10:00:27AM +0100, Christian Bruel wrote:

[...]

> > 
> > > +		msleep(PCIE_T_RRS_READY_MS);
> > > +
> > > +	return ret;
> > > +}
> > > +
> > > +static void stm32_pcie_stop_link(struct dw_pcie *pci)
> > > +{
> > > +	struct stm32_pcie *stm32_pcie = to_stm32_pcie(pci);
> > > +
> > > +	regmap_update_bits(stm32_pcie->regmap, SYSCFG_PCIECR,
> > > +			   STM32MP25_PCIECR_LTSSM_EN, 0);
> > > +
> > > +	/* Assert PERST# */
> > > +	if (stm32_pcie->perst_gpio)
> > > +		gpiod_set_value(stm32_pcie->perst_gpio, 1);
> > 
> > I don't like tying PERST# handling with start/stop link. PERST# should be
> > handled based on the power/clock state.
> 
> I don't understand your point: We turn off the PHY in suspend_noirq(), so
> that seems a logical place to de-assert in resume_noirq after the refclk is
> ready. PERST# should be kept active until the PHY stablilizes the clock in
> resume. From the PCIe electromechanical specs, PERST# goes active while the
> refclk is not stable/
> 

While your understanding about PERST# is correct, your implementation is not.
You are toggling PERST# from start/stop link callbacks which are supposed to
control the LTSSM state only. I don't have issues with toggling PERST# in
stm32_pcie_{suspend/resume}_noirq().

> 
> > 
> > > +}
> > > +
> > > +static int stm32_pcie_suspend(struct device *dev)
> > > +{
> > > +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> > > +
> > > +	if (device_may_wakeup(dev) || device_wakeup_path(dev))
> > > +		enable_irq_wake(stm32_pcie->wake_irq);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int stm32_pcie_resume(struct device *dev)
> > > +{
> > > +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> > > +
> > > +	if (device_may_wakeup(dev) || device_wakeup_path(dev))
> > > +		disable_irq_wake(stm32_pcie->wake_irq);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int stm32_pcie_suspend_noirq(struct device *dev)
> > > +{
> > > +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> > > +
> > > +	stm32_pcie->link_is_up = dw_pcie_link_up(stm32_pcie->pci);
> > > +
> > > +	stm32_pcie_stop_link(stm32_pcie->pci);
> > 
> > I don't understand how endpoint can wakeup the host if PERST# gets asserted.
> 
> The stm32 PCIe doesn't support L2, we don't expect an in-band beacon for the
> wakeup. We support wakeup only from sideband WAKE#, that will restart the
> link from IRQ
> 

I don't understand how WAKE# is supported without L2. Only in L2 state, endpoint
will make use of Vaux and it will wakeup the host using either beacon or WAKE#.
If you don't support L2, then the endpoint will reach L3 (link off) state.

> > 
> > > +	clk_disable_unprepare(stm32_pcie->clk);
> > > +
> > > +	if (!device_may_wakeup(dev) && !device_wakeup_path(dev))
> > > +		phy_exit(stm32_pcie->phy);
> > > +
> > > +	return pinctrl_pm_select_sleep_state(dev);
> > > +}
> > > +
> > > +static int stm32_pcie_resume_noirq(struct device *dev)
> > > +{
> > > +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> > > +	struct dw_pcie *pci = stm32_pcie->pci;
> > > +	struct dw_pcie_rp *pp = &pci->pp;
> > > +	int ret;
> > > +
> > > +	/* init_state must be called first to force clk_req# gpio when no
> > 
> > CLKREQ#
> > 
> > Why RC should control CLKREQ#?
> 
> REFCLK is gated with CLKREQ#, So we cannot access the core
> without CLKREQ# if no device is present. So force it with a init pinmux
> the time to init the PHY and the core DBI registers
> 

Ok. You should add a comment to clarify it in the code as this is not a standard
behavior.

> > 
> > Also please use preferred style for multi-line comments:
> > 
> > 	/*
> > 	 * ...
> > 	 */
> > 
> > > +	 * device is plugged.
> > > +	 */
> > > +	if (!IS_ERR(dev->pins->init_state))
> > > +		ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
> > > +	else
> > > +		ret = pinctrl_pm_select_default_state(dev);
> > > +
> > > +	if (ret) {
> > > +		dev_err(dev, "Failed to activate pinctrl pm state: %d\n", ret);
> > > +		return ret;
> > > +	}
> > > +
> > > +	if (!device_may_wakeup(dev) && !device_wakeup_path(dev)) {
> > > +		ret = phy_init(stm32_pcie->phy);
> > > +		if (ret) {
> > > +			pinctrl_pm_select_default_state(dev);
> > > +			return ret;
> > > +		}
> > > +	}
> > > +
> > > +	ret = clk_prepare_enable(stm32_pcie->clk);
> > > +	if (ret)
> > > +		goto clk_err;
> > 
> > Please name the goto labels of their purpose. Like err_phy_exit.
> 
> OK
> 
> > 
> > > +
> > > +	ret = dw_pcie_setup_rc(pp);
> > > +	if (ret)
> > > +		goto pcie_err;
> > 
> > This should be, 'err_disable_clk'.
> > 
> > > +
> > > +	if (stm32_pcie->link_is_up) {
> > 
> > Why do you need this check? You cannot start the link in the absence of an
> > endpoint?
> > 
> 
> It is an optimization to avoid unnecessary "dw_pcie_wait_for_link" if no
> device is present during suspend
> 

In that case you'll not trigger LTSSM if there was no endpoint connected before
suspend. What if users connect an endpoint after resume?

- Mani

-- 
மணிவண்ணன் சதாசிவம்

