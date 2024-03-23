Return-Path: <linux-pci+bounces-5029-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5EF088760A
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 01:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ABEF1F21A78
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 00:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3456638F;
	Sat, 23 Mar 2024 00:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HmwdVPgT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34436385
	for <linux-pci@vger.kernel.org>; Sat, 23 Mar 2024 00:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711153359; cv=none; b=hjPOhTilpTX5Y3bQ+QE1Q23vQKsLB7uiYKFtZld3q+dHVFKSxsIyDb7EATmNdzqthcfYVN7CLFIVI8e38xNP2dv03pFDT0dsfjpQ1F8gnz0Dd7HylnPTABO4ET83NxUr6/YtH/EdWDMi8bN4X1sNcD4DEwBJ/hfxhp0NL7v/0Ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711153359; c=relaxed/simple;
	bh=L7+9l9T2QmTtHUT05szPg/MIy2qIavylZgBbehnqygI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c0rGkULaIRrADTszwZg/WU3toiuGmPJ73RC4EG2JU9LnCGmCSeojCBAQvC0xBy9nwHUxva0sORRVyG72OnPaKzxQnjTHEGeQiJvfG6u85AwSVMbICFDiS0V8GV3wowcma4iY4fcyD9+XI+LwDPtoYWg1YX4VteS4k5DwtUvdGyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HmwdVPgT; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a4707502aafso459040866b.0
        for <linux-pci@vger.kernel.org>; Fri, 22 Mar 2024 17:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711153355; x=1711758155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=58yjr++p7fDA387lI742mHf4CyLdjO1DHyQT9HaMHKk=;
        b=HmwdVPgTJ/W2Jd/dDiaSqxru72XoNkZzauNZnd1ubtiPyyz1C7q94lWyirBPj1iLsW
         6zHMSqNnlEV//DiUmlhzZAXKccnIplQEC3f4nZpqxGEwk1ac1hCZIZqwx1q8lvTz6kv4
         KnszWl3eckuyQuQkhBApDJgYLz62GbFH95tNqNElW4V24oqXlBZP81RWXRLSTMsRMct4
         285ZDcYpaUXuVJYXPO/oSL8vUceazev0YK4348lErh0/gA139aaG8aPotBzomiLHp5nW
         vt2BUAjdMoZSuC89u+IznPzBCk8Viv8tliCJ/Bv/CheEJetgkolMgR8vWzvzmEpKwJux
         Pv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711153355; x=1711758155;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=58yjr++p7fDA387lI742mHf4CyLdjO1DHyQT9HaMHKk=;
        b=DnvhFB80e/m717WNkOW/FPwGDZGAzHCMB1JdzxZCweLz1bJVa8DoKvFpOE2T4O2bZK
         H8Wrk2MSxJEr236O/pWfitAWIcITUGNz0hgFDeLhwv5m3aLEVaKxfiRPQ3rbtCBDKqwB
         /GP5s54E9AZwISdRVgZl6hhuvPjafrRFveYHfOOoYMK6l1hR6fTSl6BDLkeMwXPVUY5d
         0uQnVXwcvzyAMi52Ch+WYET9Edv9fpefk9fneqxvTF+MocJPlozSEhccXdwHikZcZTgT
         NtokMkva4Fj3Kq3pWXg4JG6043I9leEav/nwga7BQBJhQWptNuE6WlHt4ewq1h8OVof9
         y8pA==
X-Forwarded-Encrypted: i=1; AJvYcCXjs2u4wLUaqziiEAjtqmY5ZoICalzMLi23ocGcPPNErSfOBnmCWmEayAnJFwt+cfEjldHJxXTWnwsW5bwcCLIiYVFwoVFOMbyJ
X-Gm-Message-State: AOJu0YxwbcAphrl+JTrpkHMeb3bEHq6weNlvoaSCG6pQ4XIiZDYTqBzO
	SKDKQSk6WiXPNugohC2tD0k1lO+bUn7e2kCXm0pt6XnsbIbSlCn/D7cw9uwVbts=
X-Google-Smtp-Source: AGHT+IHeVso4/sOgvQ74mwbg2tg2J4qx5kBhIl3p69FrctbsvC/8FGL2ESxX0Mi2glRRdSW0ckaveA==
X-Received: by 2002:a17:907:7625:b0:a46:fb47:7752 with SMTP id jy5-20020a170907762500b00a46fb477752mr395711ejc.23.1711153355480;
        Fri, 22 Mar 2024 17:22:35 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id l14-20020a1709067d4e00b00a46af0fbf5dsm344011ejp.103.2024.03.22.17.22.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 17:22:35 -0700 (PDT)
Message-ID: <d9616001-e64e-4fe6-ba53-4dc90555d226@linaro.org>
Date: Sat, 23 Mar 2024 01:22:32 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI: qcom: Add equalization settings for gen4
Content-Language: en-US
To: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
 agross@kernel.org, andersson@kernel.org, mani@kernel.org
Cc: quic_msarkar@quicinc.com, quic_kraravin@quicinc.com,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Jingoo Han <jingoohan1@gmail.com>,
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Serge Semin <fancer.lancer@gmail.com>,
 Conor Dooley <conor.dooley@microchip.com>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org
References: <20240320071527.13443-1-quic_schintav@quicinc.com>
 <20240320071527.13443-3-quic_schintav@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240320071527.13443-3-quic_schintav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20.03.2024 08:14, Shashank Babu Chinta Venkata wrote:
> GEN3_RELATED_OFFSET is being used as shadow register for generation4 and
> generation5 data rates based on rate select mask settings on this register.
> Select relevant mask and equalization settings for generation4 operation.
> 
> Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
> ---

[...]

> +
> +#define GEN3_EQ_FB_MODE_DIR_CHANGE_OFF          0x8ac
> +#define GEN3_EQ_FMDC_T_MIN_PHASE23_MASK         GENMASK(4, 0)
> +#define GEN3_EQ_FMDC_N_EVALS_MASK               GENMASK(9, 5)
> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_MASK  GENMASK(13, 10)
> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_MASK	GENMASK(17, 14)
> +#define GEN3_EQ_FMDC_N_EVALS_SHIFT			5
> +#define GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_SHIFT		10
> +#define GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_SHIFT	14

The beauty of bitops.h is you no longer need to define these shifts..
Just use FIELD_GET/FIELD_PREP with the field! Please also drop _MASK
from the leftover definitions.

> +void qcom_pcie_cmn_set_16gt_eq_settings(struct dw_pcie *pci)
> +{
> +	u32 reg;
> +
> +	/*
> +	 * GEN3_RELATED_OFF is repurposed to be used with GEN4(16GT/s) rate
> +	 * as well based on RATE_SHADOW_SEL_MASK settings on this register.
> +	 */

Given this comment and the commit message, should setting of this field
be factored out to a function that would accept a generation argument?

> +	reg = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +	reg &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +	reg &= ~GEN3_RELATED_OFF_RATE_SHADOW_SEL_MASK;
> +	reg |= (0x1 << GEN3_RELATED_OFF_RATE_SHADOW_SEL_SHIFT);
> +	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, reg);
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF);
> +	reg &= ~GEN3_EQ_FMDC_T_MIN_PHASE23_MASK;
> +	reg &= ~GEN3_EQ_FMDC_N_EVALS_MASK;
> +	reg |= (GEN3_EQ_FMDC_N_EVALS_16GT_VAL <<
> +		GEN3_EQ_FMDC_N_EVALS_SHIFT);
> +	reg &= ~GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_MASK;
> +	reg |= (GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_16GT_VAL <<
> +		GEN3_EQ_FMDC_MAX_PRE_CUSROR_DELTA_SHIFT);
> +	reg &= ~GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_MASK;
> +	reg |= (GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_16GT_VAL <<
> +		GEN3_EQ_FMDC_MAX_POST_CUSROR_DELTA_SHIFT);
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_FB_MODE_DIR_CHANGE_OFF, reg);
> +
> +	reg = dw_pcie_readl_dbi(pci, GEN3_EQ_CONTROL_OFF);
> +	reg &= ~GEN3_EQ_CONTROL_OFF_FB_MODE_MASK;
> +	reg &= ~GEN3_EQ_CONTROL_OFF_PHASE23_EXIT_MODE;
> +	reg &= ~GEN3_EQ_CONTROL_OFF_FOM_INC_INITIAL_EVAL;
> +	reg &= ~GEN3_EQ_CONTROL_OFF_PSET_REQ_VEC_MASK;
> +	dw_pcie_writel_dbi(pci, GEN3_EQ_CONTROL_OFF, reg);
> +}



