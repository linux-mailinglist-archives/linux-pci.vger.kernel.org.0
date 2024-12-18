Return-Path: <linux-pci+bounces-18690-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD19F9F653F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 12:46:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C769B163349
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 11:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6622B19F485;
	Wed, 18 Dec 2024 11:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IR+x8HXT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 969DA19F135
	for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 11:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734522394; cv=none; b=iZpL2TbC0wMQFTovgDE9Cszar4ecNRh8Y+YsItuVs0jsZpb2NL8JS0XT62tlMYbchEtRxpB4XyRP+vsTb5IgwVShaWK6oikJRub9aajZOXMdg8LV37vqfGPY+gbQ/YkcOcjWusnGtBsnFefruk42YOqOFvoPRikml6czhDKm6nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734522394; c=relaxed/simple;
	bh=WV+a4z5duAoPF4CNoUdiZVVbM+He69iNU0WxLENhLfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0BCRenbP/srJW1iND64/yww1Ri1DGilTw3NGVDJRrjc68zDkMTmiESR7xZCN72G54zZd6Eo7MtaBU3inQdWMAJkVSvBNaJr+qeQ9/47nk4DuxNiexHj8dyz756g5w8b42tX2Nm+fTK9c+MJl2uJjJ5VkpRrupuU0XCY4jN8ZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IR+x8HXT; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f42992f608so211821a91.0
        for <linux-pci@vger.kernel.org>; Wed, 18 Dec 2024 03:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734522392; x=1735127192; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TrVaSMgbTfMEJQGridzhaDtd8gpO8DG1MuI/x/WUz/s=;
        b=IR+x8HXTrHN9akPzN1Pr0DvvDJ/5j892c9sLxYXXGmpenD/Gcw2wW46dHy1pVREPzL
         zvDoKMJhC87DjGbKfM3uFgVrBKluWpAHQ50bPsFyfOf0H3T06O9+bGM9RaUg+EbsZj1e
         8OKFwkWyThZMfeq8NlMCY/SVOU2qJye7yncbpwiJhTQwZnTbnchPQ8zdsxxT9gJ/3NwG
         kJa1xsL4xmZ38VLBHy7Aks/VCLhJz5GCL8yVXdoWCLguH4LbjwMd1212o73qB0QwaNaX
         nR6lwoajut+JN7yuIKrlW/aCCGk38rREQfRecsPH80MgmsMxO43PXCuo4/VeOdfcal7h
         yyGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734522392; x=1735127192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TrVaSMgbTfMEJQGridzhaDtd8gpO8DG1MuI/x/WUz/s=;
        b=RJ2nBxa2kzxaI1nk16dALgx20GYlQ3aWb5ryx3/os/mgSxG6wUynG/YVCBMrlpKcmh
         X856H25AaiZnjC4zLjUp8Vr1v/aBosuzwO8ELytmmT34VS+3SDq/FlYA9WF+gZiKMAGV
         Qww4k7rsYk311Hcr/udqYRgsY8W/x8z9s9GK2pDju/X/OBLPLuU58aenqfi5yP0s+SUH
         X+pdN2VSja/Svi2Av1dQw0VW++U3hKVyZxvxH84dV1txyshXDUzjDBF0LAbYolZnAbHP
         hvYW1qnYznjxIHnRtGEsJUcYsUBPI4lVVqkCAx1pPmP+UDCvCs5IOoyhp3jSiAJY1/zk
         30Mg==
X-Forwarded-Encrypted: i=1; AJvYcCWjikypUiaxyrWGRTpmX7vxmFGzel1lHPiLoq2d8T/jP9AUiB/Cm46h3gr7kIEJ1FW972mCch12EOE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlwsNx8E1wKVtOXAceg8Ya7Q73BX6ErU21Z3tqGKhepXCInC8s
	s33guFv0D2Qy+lppCPNuI8gKsIDyfzXH13d6cPCQwSbKjh6dcdoQJt5YaDw5Zw==
X-Gm-Gg: ASbGncs7Y/G68XwvZJW5BEmqO3JWmS/jINwbjx/zC+lidXPac6Do1y215pRDx3WUppt
	HKwf5HWEEFRNs64hYOVtx31qVwt/g+QPzkKJQ8B3mdnrWZnA5ydWAYyhyqCzvhYHkMygKqZgISj
	WO9c6hLfKv7ZjN2w7fe8j0kYbo/amDBs7QtebYQinTmxbXFdhYyPyX1UsPjfazJiNWvoKOCDHYr
	0xZe1NCFSfwJlR97lSlHoSMSLiKdkOvdmiVm1wm7o/nXf0pOxUrrzSSVqHwt5lI3I6e
X-Google-Smtp-Source: AGHT+IGQCgOq49R63ovvMukQoYUb7D03BYa7ObLjFwjqufc6miUeckdIMCl7aC+v7+RULldgNi6Ukw==
X-Received: by 2002:a17:90b:548f:b0:2ee:8e75:4aeb with SMTP id 98e67ed59e1d1-2f2e91f6469mr4114590a91.17.1734522391875;
        Wed, 18 Dec 2024 03:46:31 -0800 (PST)
Received: from thinkpad ([117.213.97.217])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ee06dd84sm1313616a91.38.2024.12.18.03.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 03:46:31 -0800 (PST)
Date: Wed, 18 Dec 2024 17:16:22 +0530
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
Message-ID: <20241218114622.3fgdooag6hwlmipr@thinkpad>
References: <20241126155119.1574564-1-christian.bruel@foss.st.com>
 <20241126155119.1574564-3-christian.bruel@foss.st.com>
 <20241203145244.trgrobtfmumtiwuc@thinkpad>
 <ced7a55a-d968-497f-abc2-663855882a3f@foss.st.com>
 <20241218094606.sljdx2w27thc5ahj@thinkpad>
 <d15cec4e-e06a-47f7-aa8a-744c0829d244@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d15cec4e-e06a-47f7-aa8a-744c0829d244@foss.st.com>

On Wed, Dec 18, 2024 at 12:24:21PM +0100, Christian Bruel wrote:

[...]

> > > > > +static int stm32_pcie_suspend_noirq(struct device *dev)
> > > > > +{
> > > > > +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> > > > > +
> > > > > +	stm32_pcie->link_is_up = dw_pcie_link_up(stm32_pcie->pci);
> > > > > +
> > > > > +	stm32_pcie_stop_link(stm32_pcie->pci);
> > > > 
> > > > I don't understand how endpoint can wakeup the host if PERST# gets asserted.
> > > 
> > > The stm32 PCIe doesn't support L2, we don't expect an in-band beacon for the
> > > wakeup. We support wakeup only from sideband WAKE#, that will restart the
> > > link from IRQ
> > > 
> > 
> > I don't understand how WAKE# is supported without L2. Only in L2 state, endpoint
> > will make use of Vaux and it will wakeup the host using either beacon or WAKE#.
> > If you don't support L2, then the endpoint will reach L3 (link off) state.
> 
> I think this is what happens, my understanding is that the device is still
> powered to get the wakeup event (eg WoL magic packet), triggers the PCIe
> wake_IRQ from the WAKE#.
> 

Honestly, I still cannot understand how this can happen.

> > 
> > > > 
> > > > > +	clk_disable_unprepare(stm32_pcie->clk);
> > > > > +
> > > > > +	if (!device_may_wakeup(dev) && !device_wakeup_path(dev))
> > > > > +		phy_exit(stm32_pcie->phy);
> > > > > +
> > > > > +	return pinctrl_pm_select_sleep_state(dev);
> > > > > +}
> > > > > +
> > > > > +static int stm32_pcie_resume_noirq(struct device *dev)
> > > > > +{
> > > > > +	struct stm32_pcie *stm32_pcie = dev_get_drvdata(dev);
> > > > > +	struct dw_pcie *pci = stm32_pcie->pci;
> > > > > +	struct dw_pcie_rp *pp = &pci->pp;
> > > > > +	int ret;
> > > > > +
> > > > > +	/* init_state must be called first to force clk_req# gpio when no
> > > > 
> > > > CLKREQ#
> > > > 
> > > > Why RC should control CLKREQ#?
> > > 
> > > REFCLK is gated with CLKREQ#, So we cannot access the core
> > > without CLKREQ# if no device is present. So force it with a init pinmux
> > > the time to init the PHY and the core DBI registers
> > > 
> > 
> > Ok. You should add a comment to clarify it in the code as this is not a standard
> > behavior.
> > 
> 
> OK
> 
> > > > 
> > > > Also please use preferred style for multi-line comments:
> > > > 
> > > > 	/*
> > > > 	 * ...
> > > > 	 */
> > > > 
> > > > > +	 * device is plugged.
> > > > > +	 */
> > > > > +	if (!IS_ERR(dev->pins->init_state))
> > > > > +		ret = pinctrl_select_state(dev->pins->p, dev->pins->init_state);
> > > > > +	else
> > > > > +		ret = pinctrl_pm_select_default_state(dev);
> > > > > +
> > > > > +	if (ret) {
> > > > > +		dev_err(dev, "Failed to activate pinctrl pm state: %d\n", ret);
> > > > > +		return ret;
> > > > > +	}
> > > > > +
> > > > > +	if (!device_may_wakeup(dev) && !device_wakeup_path(dev)) {
> > > > > +		ret = phy_init(stm32_pcie->phy);
> > > > > +		if (ret) {
> > > > > +			pinctrl_pm_select_default_state(dev);
> > > > > +			return ret;
> > > > > +		}
> > > > > +	}
> > > > > +
> > > > > +	ret = clk_prepare_enable(stm32_pcie->clk);
> > > > > +	if (ret)
> > > > > +		goto clk_err;
> > > > 
> > > > Please name the goto labels of their purpose. Like err_phy_exit.
> > > 
> > > OK
> > > 
> > > > 
> > > > > +
> > > > > +	ret = dw_pcie_setup_rc(pp);
> > > > > +	if (ret)
> > > > > +		goto pcie_err;
> > > > 
> > > > This should be, 'err_disable_clk'.
> > > > 
> > > > > +
> > > > > +	if (stm32_pcie->link_is_up) {
> > > > 
> > > > Why do you need this check? You cannot start the link in the absence of an
> > > > endpoint?
> > > > 
> > > 
> > > It is an optimization to avoid unnecessary "dw_pcie_wait_for_link" if no
> > > device is present during suspend
> > > 
> > 
> > In that case you'll not trigger LTSSM if there was no endpoint connected before
> > suspend. What if users connect an endpoint after resume?
> 
> Yes, exactly. We don't support hotplug, and plugging a device while the
> system is in stand-by is something that we don't expect. The imx6 platform
> does this also.
> 

You should reconsider this approach. You'll never know how the OEMs are going to
use the PCIe slot. And lack of standard hotplug is not preventing users from
doing hotplug (they could try to do rescan themselves etc...)

- Mani

-- 
மணிவண்ணன் சதாசிவம்

