Return-Path: <linux-pci+bounces-4545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF016872EEB
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 07:33:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 41B211F21F38
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 06:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C0375A4C7;
	Wed,  6 Mar 2024 06:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O+vTxwX8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD04B1BDD3
	for <linux-pci@vger.kernel.org>; Wed,  6 Mar 2024 06:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709706793; cv=none; b=VZ5jRF52jo3NwULZgRKaZ8ThCZA2/vu3AXjMrcAPtIQvEQw4Ljj+NVj0XSEpBtWVaxjB9heJrj4vPWELHrE1OMLBif2cobZRZVM99HZ+SqEQkpVzhVFqnNmSU8sPLHo9by/bu7EEEBNXevRmTNA9TBbqvgCrw6p9fyb5gP4w7hQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709706793; c=relaxed/simple;
	bh=lnj04D8zBAmypP6j2POjy3y/xNsAC09Cm+3BIi+/VRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTx1Ns0sOCposa43DMlS3cLjC4CtikdE9YZa1oihEOMllDJNwjsk44245HGkmQzrlQfR5nGXtBqHim1XRgOlGKCci9snVfiy6g555eL8KyKUZprJrEeyxMvFhY20xY1QwvYmwb0NyDzBHxlEPC6KVdr5W11rbjgd0WKZnbY5TCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O+vTxwX8; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-78841026a65so3766185a.3
        for <linux-pci@vger.kernel.org>; Tue, 05 Mar 2024 22:33:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709706790; x=1710311590; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PzzqnLQBHpN+9urj8XiH2dFm2U46R6xFzTYOnXW2Hvs=;
        b=O+vTxwX8jPbg+fbjLrM2yUfgSznPFlGhGMSzaiwFimqk/+kGzC57CuV4OllfUxr/pk
         fO15Y3K9PFb7EzF7zfjt/yfE68/yaPvccu06Vu1yyxviXrjtfvlSVeFKNvls9g2qT9Uf
         bbGGIBbsWbvrDT6tJsPWuJGgcEIcf2XJkJDeqxMYrdubRdRrttik+Li8RnYVPkOYH4Oz
         Kv0AHQ9oHBiZMPkAsvUOhNFfKRwj70IK/uU8xlgaR7XHcFcch2gEwxxBTxe2iLufIGSX
         3iJFvXhSwmfAXYIS7hkcrUl8xX57izNy3vsrbNfyxlyjyhUZygV9R7V87HT4VkONPPG5
         /reA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709706790; x=1710311590;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzzqnLQBHpN+9urj8XiH2dFm2U46R6xFzTYOnXW2Hvs=;
        b=c1YKqTu81uZJYmeqLo++zTelE9Tw+TC6SntunN//TgXGGW9RL9G4IbRKOMAChvEYOY
         K8bIssbgYRbLvgTxyxz0N+dAlVw13Ke9earJojZTjb5UKbD4liTxNVbLEvGJ0DsvWjxH
         e+uBIxFPglOkyDjJxehsw7hgi45wsARwaqXrwYHRNBsFJizCvNvkTHHHAgn1wuUzLZQg
         cxX1+YjTK8sjfKYNLIWlpi3yFJn+CGhtJwatXQHueH9ue0JWKLQ0UfMNrX0wR0oV3B1p
         bXMe2JI5zK4rGg7xAwF361/pHV7ensLH/s/TGlWzyOa0aIFkpbtSxVlLwil8S9P6xCz/
         7TVg==
X-Forwarded-Encrypted: i=1; AJvYcCU9LVkfBcsHGTsA0NIyvsMYx1hTcbVdvTLj19jKekwsAP4u/1s+5UZaz8c7blxb5q1qklm5hs8kQXBXLd+AyeGATWtmwqLNVRHw
X-Gm-Message-State: AOJu0YzGIF1L6SdsUWZFZc+NaxSUnrbbYa3j0DCfAgqSPdA70CSRfJLM
	c2qJ4XIbR5DZFj1e+W8MYj2NMmDpiWQbZNBlC7uqCwpHQJ8QaOKLoaeLZAAX8g==
X-Google-Smtp-Source: AGHT+IFLka1W5sBQpiugLgmQG2wEsLa+Bvr76ZGfB5U9MeSgecbtI+9k8NDXeMjSLd+eRIFfWofSjg==
X-Received: by 2002:a05:620a:6120:b0:788:3c4e:b84f with SMTP id oq32-20020a05620a612000b007883c4eb84fmr1755223qkn.35.1709706790464;
        Tue, 05 Mar 2024 22:33:10 -0800 (PST)
Received: from thinkpad ([117.248.1.99])
        by smtp.gmail.com with ESMTPSA id p14-20020ae9f30e000000b0078825e2c57dsm3109737qkg.76.2024.03.05.22.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Mar 2024 22:33:10 -0800 (PST)
Date: Wed, 6 Mar 2024 12:03:02 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <20240306063302.GA4129@thinkpad>
References: <20240305081105.11912-1-johan+linaro@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240305081105.11912-1-johan+linaro@kernel.org>

On Tue, Mar 05, 2024 at 09:10:55AM +0100, Johan Hovold wrote:
> This series addresses a few problems with the sc8280xp PCIe
> implementation.
> 
> The DWC PCIe controller can either use its internal MSI controller or an
> external one such as the GICv3 ITS. Enabling the latter allows for
> assigning affinity to individual interrupts, but results in a large
> amount of Correctable Errors being logged on both the Lenovo ThinkPad
> X13s and the sc8280xp-crd reference design.
> 
> It turns out that these errors are always generated, but for some yet to
> be determined reason, the AER interrupts are never received when using
> the internal MSI controller, which makes the link errors harder to
> notice.
> 
> On the X13s, there is a large number of errors generated when bringing
> up the link on boot. This is related to the fact that UEFI firmware has
> already enabled the Wi-Fi PCIe link at Gen2 speed and restarting the
> link at Gen3 generates a massive amount of errors until the Wi-Fi
> firmware is restarted. This has now also been shown to cause the Wi-Fi
> to sometimes not start at all on boot for some users.
> 
> A recent commit enabling ASPM on certain Qualcomm platforms introduced
> further errors when using the Wi-Fi on the X13s as well as when
> accessing the NVMe on the CRD. The exact reason for this has not yet
> been identified, but disabling ASPM L0s makes the errors go away. This
> could suggest that either the current ASPM implementation is incomplete
> or that L0s is not supported with these devices.
> 
> Note that the X13s and CRD use the same Wi-Fi controller, but the errors
> are only generated on the X13s. The NVMe controller on my X13s does not
> support L0s so there are no issues there, unlike on the CRD which uses a
> different controller. The modem on the CRD does not generate any errors,
> but both the NVMe and modem keeps bouncing in and out of L0s/L1 also
> when not used, which could indicate that there are bigger problems with
> the ASPM implementation. I don't have a modem on my X13s so I have not
> been able to test whether L0s causes any trouble there.
> 
> Enabling AER error reporting on sc8280xp could similarly also reveal
> existing problems with the related sa8295p and sa8540p platforms as they
> share the base dtsi.
> 
> After discussing this with Bjorn Andersson at Qualcomm we have decided
> to go ahead and disable L0s for all controllers on the CRD and the
> X13s.
> 

Just received confirmation from Qcom that L0s is not supported for any of the
PCIe instances in sc8280xp (and its derivatives). Please move the property to
SoC dtsi.

- Mani

> Note that disabling ASPM L0s for the X13s Wi-Fi does not seem to have a
> significant impact on the power consumption (and there are indications
> that this applies generally for L0s on these platforms).
> 
> ***
> 
> As we are now at 6.8-rc7, I've rebased this series on the Qualcomm PCIe
> binding rework in linux-next so that the whole series can be merged for
> 6.9 (the 'aspm-no-l0s' support and devicetree fixes are all marked for
> stable backport anyway).
> 
> The DT bindings and PCI patch are expected to go through the PCI tree,
> while Bjorn A takes the devicetree updates through the Qualcomm tree.
> 
> Johan
> 
> 
> Changes in v3
>  - drop the two wifi link speed patches which have been picked up for
>    6.8
>  - rebase on binding rework in linux-next and add the properties also to
>    the new qcom,pcie-common.yaml
>    - https://lore.kernel.org/linux-pci/20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org/
>  - fix an 'L0s' typo in one commit message
> 
> Changes in v2
>  - drop RFC from ASPM patches and add stable tags
>  - reorder patches and move ITS patch last
>  - fix s/GB/MB/ typo in Gen2 speed commit messages
>  - fix an incorrect Fixes tag
>  - amend commit message X13 wifi link speed patch after user
>    confirmation that this fixes the wifi startup issue
>  - disable L0s also for modem and wifi on CRD
>  - disable L0s also for nvme and modem on X13s
> 
> 
> Johan Hovold (10):
>   dt-bindings: PCI: qcom: Allow 'required-opps'
>   dt-bindings: PCI: qcom: Do not require 'msi-map-mask'
>   dt-bindings: PCI: qcom: Allow 'aspm-no-l0s'
>   PCI: qcom: Add support for disabling ASPM L0s in devicetree
>   arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
>   arm64: dts: qcom: sc8280xp-crd: disable ASPM L0s for NVMe
>   arm64: dts: qcom: sc8280xp-crd: disable ASPM L0s for modem and Wi-Fi
>   arm64: dts: qcom: sc8280xp-x13s: disable ASPM L0s for Wi-Fi
>   arm64: dts: qcom: sc8280xp-x13s: disable ASPM L0s for NVMe and modem
>   arm64: dts: qcom: sc8280xp: enable GICv3 ITS for PCIe
> 
>  .../bindings/pci/qcom,pcie-common.yaml        |  6 +++++-
>  .../devicetree/bindings/pci/qcom,pcie.yaml    |  6 +++++-
>  arch/arm64/boot/dts/qcom/sc8280xp-crd.dts     |  5 +++++
>  .../qcom/sc8280xp-lenovo-thinkpad-x13s.dts    |  5 +++++
>  arch/arm64/boot/dts/qcom/sc8280xp.dtsi        | 17 +++++++++++++++-
>  drivers/pci/controller/dwc/pcie-qcom.c        | 20 +++++++++++++++++++
>  6 files changed, 56 insertions(+), 3 deletions(-)
> 
> -- 
> 2.43.0
> 

-- 
மணிவண்ணன் சதாசிவம்

