Return-Path: <linux-pci+bounces-17337-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E819D9675
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 12:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EA462889ED
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 11:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D2A1CEE8C;
	Tue, 26 Nov 2024 11:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="u/kneQym"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6583C1CB51B
	for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 11:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732621762; cv=none; b=gfSIbc2gR/U3pwWvvCaKxF/F4q0ZzgGYTECewuWfhpXmSctQuvxNxTzOVhnJ7EkiycEdVj+OzvyoaggTqLvXRd1zoFD2IFcYw1hwwnBIBfWwqwccG+HWw37BCAsHnwD5ss1s19UOj9U+5PfDpzhGVon8Vt5sAZta7/lS73judxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732621762; c=relaxed/simple;
	bh=UGw0zzCTxmWhjk2Kr7lUkghqevSUdxS2ujFgteFo7bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nZjCRdq1Wbg7XSuyyrt7s6Y8T+YkcxeZ3Ct5r5mT3+gDEIiItHV1tOkeaKeGCtwr1+ck2QiAkzsdkYYIKzaeS0FlPGZqo/PPrNwHdXF6AO/LIS4VTuyVPwbL7+BrOR8jq4BvbgFXw7Ct0qSi0kgnG7DX7vMHLKLqitmGfXbz9hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=u/kneQym; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ffced84ba8so4756131fa.2
        for <linux-pci@vger.kernel.org>; Tue, 26 Nov 2024 03:49:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732621757; x=1733226557; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qbQUZzbSmChhIBAFL2qH1RGbuk5eGQ4M+u90/hV2Yco=;
        b=u/kneQym9SNLuY38M0eMt+LwbmDISko6PJAUxodZ4o+ZyMEyEXNrEB5htcPL76FP5g
         yNEKs15e0xgUG93NbHOaRLM3AEwQP8BU1RaU4UUwgXvjcBuLYTMV68MucNjUDQCmsxEj
         LM5SutlkYMgVR82ooMhKHsO2HRiOFx9vaOAHwzI5syudolkhpPzGgRZjMWo0yG3k3pUk
         FKZ6784j1bFAq8Q49UMZvW/SBecLohZqLiQOkHFwGpuFKmQo9o45+6amsGZiDvjYnOOt
         dUm9OVcxcmGYYZZhtf5dAemWEtNWPWxVPVPtid3PsIVnBhtVXALoSFeh0t2PjEoP6ofb
         2bXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732621757; x=1733226557;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbQUZzbSmChhIBAFL2qH1RGbuk5eGQ4M+u90/hV2Yco=;
        b=U8GSA8XpuNmcVvAYY3FcYurEioAMhix4B6a9eEcWZdkvK22MPNxEdx3hVP67vkDBIs
         Wv4qk+98O3QyhuU/qfYS/2urBVASkVwz/JGKxEPGDYW0LCAJXXDQgCzW6sFVyDVGvAVb
         0ger19FM8BVAyRS6oPJH2KmIW1vwQb90rn9x7KA2MJrMhQu/3bzVZuJ5yZwmd8U57aXO
         uc4dyxJreHupT5lXmwQBYXS0tNP8FeWhZ3ZUzaUy7a23djcDz2KAtCLBugmSghkQB+/W
         xxaZMkGNtQcNdKIFK8TvhYTSHKzdAODO3UwyiLGx8ACnDZ/xTF0FQSvtrf3XF5qsSjEy
         6oLg==
X-Forwarded-Encrypted: i=1; AJvYcCXVOi+yTj8smd+nppTVpZyxVWREakvEaUdDVsTEWPdrR0NeyTFB+bGBqAxYjc2MY9H3RPT0Hs2IEts=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqGSBWXXU06irNXI56VOQCwK9fmviNZ8lhxmLdrLuPYNaTuOXy
	EHtHgHHqKkuIxe5rY5uKZnMWYLc6HJTPU1CLFPy4919mthkW0RCdVMJvhzoHYDM=
X-Gm-Gg: ASbGncsbZV5tWJsk8bRYisKtud0qIsdEP1o0MsVA1OjnlNGCA7Uy9TGji0gdG/caL1b
	CHz8svJa4PwiHH7YeoZ+SCVFK4Y5yKTgMitKotXsyG1NZ9mgkL18A31xIcXDj43+0Ow6lSuE6r+
	lZ46XMRjNIo7Q8/r8bXqaGZzTY5YO0xs+E5fqHjuf1nwQ6ouHH2gnVnIZqAuVFy+cvCya3UJs3B
	0NCZrZwnciRv3c3m0tedEGqRgOqae+svRs1Fu1Emr5nU92CVQ4vHuLISznh2jf/ZYVuSd7anPNn
	/sRqRK2KwgK713sWH/jBQ4uHxz9VIQ==
X-Google-Smtp-Source: AGHT+IHASf7kbq6ptV3Ip32BjIMPh2Df4iR7dpz+DS9GMEkuPq44nPlThPmRMDSlE/KTqC3KTABcig==
X-Received: by 2002:a05:6512:b17:b0:539:905c:15ab with SMTP id 2adb3069b0e04-53dd3992d93mr9289024e87.32.1732621757253;
        Tue, 26 Nov 2024 03:49:17 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53dd2481424sm1996842e87.133.2024.11.26.03.49.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 03:49:16 -0800 (PST)
Date: Tue, 26 Nov 2024 13:49:15 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8650: Add 'global' interrupt to
 the PCIe RC nodes
Message-ID: <vhyqpnparlikqpzltdi6suo4emt7ezyawgz6neyjssznlm7ank@pt7cryux7jbp>
References: <20241126-topic-sm8x50-pcie-global-irq-v1-0-4049cfccd073@linaro.org>
 <20241126-topic-sm8x50-pcie-global-irq-v1-3-4049cfccd073@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241126-topic-sm8x50-pcie-global-irq-v1-3-4049cfccd073@linaro.org>

On Tue, Nov 26, 2024 at 11:22:51AM +0100, Neil Armstrong wrote:
> Qcom PCIe RC controllers are capable of generating 'global' SPI interrupt
> to the host CPUs. This interrupt can be used by the device driver to
> identify events such as PCIe link specific events, safety events, etc...
> 
> Hence, add it to the PCIe RC node along with the existing MSI interrupts.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8650.dtsi | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

