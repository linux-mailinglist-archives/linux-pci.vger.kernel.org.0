Return-Path: <linux-pci+bounces-11438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E6894AB4F
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 17:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 93B671C2196D
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 15:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D8B281AB1;
	Wed,  7 Aug 2024 15:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BiBqr+6K"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0668C78C67
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 15:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723043057; cv=none; b=EUM2znRUjsHouQs6rEEtkPxPASvh5xd3cdKRCkqgzW89ZnRDIgl5tcWEIHgtM4/anxPJaXUTRIq5eXVtmvAsT8vZ0P3mUujXLamuZUoRwpGwUzyckYWnfLEfVYsO+gPueJ1IW5lykZJuiu+u7o4GNRo13jfjqf9pQ70O4mSUpl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723043057; c=relaxed/simple;
	bh=9/AgtS1xl+hUVG+/ngIpGUPthHDHXYwAlaqfvl9/mj0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RTekeaqbVw5YvJMzYZdC78XLjLfl76LmOFpf6qX24vyPQnLLTfbAv7hHvnoFf6H8hESHRxL3l/cZIk67FYPXBK8r8ttLF0lKeGqWaAVI7IzfD8lo29viVsC/yuEas5XqxYn/fIIlz0/Yst6iR78ZPQoxttkOYF9WzF8ZgPaUavQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BiBqr+6K; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-70d18112b60so763837b3a.1
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2024 08:04:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723043055; x=1723647855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RIRNLkw9dTzgIpXpghTsmUqrsJ/SAPgpl7FytrsGTJU=;
        b=BiBqr+6KUH9+ux6k7PZl+koLT18Suii6gOs9vLxNU55YJ7nRtd0LMfcZFJvfJ0ojpN
         HMVqiRDdGuo9PbiXMyXw60t/pZgs7OlKAOC1kRj5vwuIE5bzR0B2YZJ99ivLonC44Hf9
         WHQBcTDGMlvLySjPfIduCbCmKaA+DlFOZfuPzweqfK8055FI58Xq9JgwWL2PZ2QP05jG
         vy1/E5kQWSec9hwrt2/ImYFIURbTbDOommzeUiYgA60Ya0eQ7DUe1cQfAPVYZHj5oQLb
         KfDK4AZaNPK2y5/VySnkSavtaYdeYLW+j4Ns5n4c6zVZNNr4s4gBY/hgFOiRxhso0Pw6
         0N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723043055; x=1723647855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RIRNLkw9dTzgIpXpghTsmUqrsJ/SAPgpl7FytrsGTJU=;
        b=aZTr06nXQ5goV1dnyUveBP02vGI1ScZKBNFrdyoQpYE/AQQldnuLomUsSoV8Nrq5A7
         RGR0dHP9wnsS6vBWHgDZs4QGzPqcSM5QF62UyBqcoFUvRq/+GownPKVvDz8lXss8PfyN
         lZCgw5O89OuJBdhgRb4vsqKv8eIMovCuJ1CW8sfoUHkqUfZaTJ0QWCsiWcBoprX4Gk68
         UFBTCCDHaEGMAO9YKowrvGjXaI0MGM5Di1ly+dSdq7z5p15XlPg1O5F9wNaYSDXEthkV
         3WgIfBlVTRyzdjleEd1GZPTNDrlq10NlmYdWatlx0RkMnY0ah6ExR9q92o1R1R8YTPoI
         oiPQ==
X-Forwarded-Encrypted: i=1; AJvYcCUB4sSmu/SrEGv5PGCbYy73ykOChzRvLr0TfstZ7pBM7tklaQUhn9znAus7PBtRdP5AwpYm4BlhL7k78iFQ2QAXnOM4HLN+v8gI
X-Gm-Message-State: AOJu0YwSTo3gqxmCZFi7Ewtvv/Sijb0gblx+D0Ce67WgyyhbtNHeoB75
	RY6PN+ePtvw1YPffZ6EHpzK+I9DSm6qX0/zeGrBCdrWMEtErfTPF/h0I6OmavA==
X-Google-Smtp-Source: AGHT+IFUq3a888UA6wQ7lTpYeaEGuRpyGPntz4KOze7iKWL5Lbq2AqEWrIvFsDKl9yLEGbIl3Z7fZw==
X-Received: by 2002:a05:6a00:9155:b0:70d:32bf:aa45 with SMTP id d2e1a72fcca58-710bc916b4fmr3349555b3a.14.1723043055153;
        Wed, 07 Aug 2024 08:04:15 -0700 (PDT)
Received: from thinkpad ([120.60.60.211])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ecfd064sm8809352b3a.170.2024.08.07.08.04.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 08:04:14 -0700 (PDT)
Date: Wed, 7 Aug 2024 20:33:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: Jim Quinlan <james.quinlan@broadcom.com>, linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound windows
Message-ID: <20240807150357.GB5664@thinkpad>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-10-james.quinlan@broadcom.com>
 <20240807140401.GJ3412@thinkpad>
 <c32a28f3-aa64-4e89-a8f7-acfaed8ac090@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c32a28f3-aa64-4e89-a8f7-acfaed8ac090@broadcom.com>

On Wed, Aug 07, 2024 at 07:16:44AM -0700, Florian Fainelli wrote:
> 
> 
> On 8/7/2024 7:04 AM, Manivannan Sadhasivam wrote:
> > On Wed, Jul 31, 2024 at 06:28:23PM -0400, Jim Quinlan wrote:
> > > Provide support for new chips with multiple inbound windows while
> > > keeping the legacy support for the older chips.
> > > 
> > > In existing chips there are three inbound windows with fixed purposes: the
> > > first was for mapping SoC internal registers, the second was for memory,
> > > and the third was for memory but with the endian swapped.  Typically, only
> > > one window was used.
> > > 
> > > Complicating the inbound window usage was the fact that the PCIe HW would
> > > do a baroque internal mapping of system memory, and concatenate the regions
> > > of multiple memory controllers.
> > > 
> > > Newer chips such as the 7712 and Cable Modem SOCs take a step forward and
> > > drop the internal mapping while providing for multiple inbound windows.
> > > This works in concert with the dma-ranges property, where each provided
> > > range becomes an inbound window.
> > > 
> > > Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> > > ---
> 
> [snip]
> 
> > > +static void set_inbound_win_registers(struct brcm_pcie *pcie,
> > > +				      const struct inbound_win *inbound_wins,
> > > +				      int num_inbound_wins)
> > > +{
> > > +	void __iomem *base = pcie->base;
> > > +	int i;
> > > +
> > > +	for (i = 1; i <= num_inbound_wins; i++) {
> > > +		u64 pci_offset = inbound_wins[i].pci_offset;
> > > +		u64 cpu_addr = inbound_wins[i].cpu_addr;
> > > +		u64 size = inbound_wins[i].size;
> > > +		u32 reg_offset = brcm_bar_reg_offset(i);
> > > +		u32 tmp = lower_32_bits(pci_offset);
> > > +
> > > +		u32p_replace_bits(&tmp, brcm_pcie_encode_ibar_size(size),
> > > +				  PCIE_MISC_RC_BAR1_CONFIG_LO_SIZE_MASK);
> > > +
> > > +		/* Write low */
> > > +		writel(tmp, base + reg_offset);
> > 
> > Can you use writel_relaxed() instead? Here and below. I don't see a necessity to
> > use the barrier that comes with non-relaxed version of writel.
> 
> Out of curiosity what is the reasoning here for asking to use
> writel_relaxed(), this is not a hot path, this is a configuration path
> anyway. I am not certain clear on the implication of using writel_relaxed()
> on systems like 7712/2712 where the busing is different from the other STB
> chips.

It is the general recommendation (although not documented). If the code path do
not need ordering/barrier, then there is no need for non-relaxed variants.

Btw, if the register accesses are to the same domain (like PCIe), then certainly
you do not need barrier as writes to the same domain are ordered.

Problem with readl/writel is that the drivers started using non-relaxed variants
as if it is a norm and completely ignored the relaxed variants.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

