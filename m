Return-Path: <linux-pci+bounces-10823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F33393CD6C
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 07:08:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30D5A1F21E36
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 05:08:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986882B9B6;
	Fri, 26 Jul 2024 05:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sqOA+kbS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BC8219EA
	for <linux-pci@vger.kernel.org>; Fri, 26 Jul 2024 05:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721970493; cv=none; b=egbsGxoo6GparYIP/88gwIJQr2OQ4yE3YF+HQyvrX2K8DS6Zf5CgpuBL6vTmQ6Etj+Aby2nDLN3tXu6hAtRQVOedGAMQjgEzcVdA1kWuW4b7zHIAckOA3xSAvLxhcQZ6HyFybQd9MQBhqv1lzm8ypY8JdnFmS8T3Rdl+hCt3Fto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721970493; c=relaxed/simple;
	bh=vRgTjVmBkef0bZYyhRCaL2/45FsAz1WDLtETKuC747c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pzOA0wZ5FUTOn5TminVrG3WXvIBmBR72J0PpmoHZp7kOuDeeL4yB6LYnAeJU9Z0XEJ+FFJdMPHOnjLJa20rAHYyUBa6a1Qc3dXqzzgHThbKxYIpwrKyZ7fKUniipfwN1K1YRf+kaqB6/7lTVg1LujXmxPUvsf2XoKzIumD8tk6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sqOA+kbS; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d2ae44790so452125b3a.2
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 22:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721970491; x=1722575291; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=3rKwuSlqAIySxz11l4PWG6VIoo7RMKChxKPZ2GCuBEY=;
        b=sqOA+kbSzpKrS1p78jLMNk5h5+k31RBR6LTEwrtkOqwcPbtodik8J5Ix+zIX44c08u
         vk98RRhzB6td0SF7BauWYKCO6pFMsXikLDkeqNbrcpm2nHQH1Nb08wnqhOYkz53MJNXi
         AW077w+9TScSVS6Xl+bFdbDVIEhbD9uEOH+VPFT7dUInGG5cuGZNE7NGaLTBntw1khdF
         V+8NHheZUulpmjTcxiReF/VztZJOsg1kETTxf5SGhA2JQR9g+9HbQJCaRr8gBJf49VmA
         +e0GkWO6L8/Zi7gg/XW9s74by5CHlD+stjf88n3EdI/y5wRV81tWP3SLOTjiZuk95Syc
         gTlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721970491; x=1722575291;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3rKwuSlqAIySxz11l4PWG6VIoo7RMKChxKPZ2GCuBEY=;
        b=MOsViBe466Enl0Cb/8FalSg66QzD185HjVaUvhLlgDds7Ry8iccfpJV4AEDrdQyM5G
         WUOQz/vdtX0h/bAAk0ApnHpkfMJzHLl7WsVpnexHosJMhau8dv60g1/jZWMpDztFlDy7
         EalWxiSe6+KnsWt09+fjXqxCchnDiRO0HS2TfFzD+ndAFxDM4bZILpKpEcVE3ErqKOj5
         DvXQ7Zq+Dov9yoH7el5unQfVKj1167NoPg/5XIIhJL4p605S1ehMmct9GZ8YmXV+9hcE
         ynUebXCi4ax39dQpVsSmQUcdwkVQru7gVMcTRflM+Ols4mYw1TwrIHgpLENiQpdDkv4W
         eaWw==
X-Gm-Message-State: AOJu0YzCGrbqdXqjT/pUF7khhVJKQh/Ya6UftBcXRnDPe7CWbqNxFCjv
	Bxz8tsgtDfN5+AqGKf9W/csUMytTzDbbQXSQAJjrJeYZWoFgvraADXdEtG3Wgw==
X-Google-Smtp-Source: AGHT+IFPb+cpIlmTJHSn/eJI9XIpxgM8cTQg0C4/esBr4+srXONC/O3SgQ8mdQoB+Y0Wokbd7ElKDg==
X-Received: by 2002:a05:6a21:388a:b0:1c4:7138:ad1b with SMTP id adf61e73a8af0-1c47b4f896amr4158589637.54.1721970491165;
        Thu, 25 Jul 2024 22:08:11 -0700 (PDT)
Received: from thinkpad ([220.158.156.199])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f99099sm22814675ad.247.2024.07.25.22.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 22:08:10 -0700 (PDT)
Date: Fri, 26 Jul 2024 10:38:05 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 09/12] PCI: brcmstb: Refactor for chips with many
 regular inbound BARs
Message-ID: <20240726050805.GC2628@thinkpad>
References: <20240716213131.6036-1-james.quinlan@broadcom.com>
 <20240716213131.6036-10-james.quinlan@broadcom.com>
 <20240725045318.GJ2317@thinkpad>
 <CA+-6iNyQ09BESbdCwY1x4yUOLmAHKFBU3-9TO_ST+2GkOEEAng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNyQ09BESbdCwY1x4yUOLmAHKFBU3-9TO_ST+2GkOEEAng@mail.gmail.com>

On Thu, Jul 25, 2024 at 04:29:56PM -0400, Jim Quinlan wrote:
> On Thu, Jul 25, 2024 at 12:53 AM Manivannan Sadhasivam
> <manivannan.sadhasivam@linaro.org> wrote:
> >
> > On Tue, Jul 16, 2024 at 05:31:24PM -0400, Jim Quinlan wrote:
> > > Previously, our chips provided three inbound "BARS" with fixed purposes:
> > > the first was for mapping SoC internal registers, the second was for
> > > memory, and the third was for memory but with the endian swapped.  We
> > > typically only used one of these BARs.
> > >
> > > Complicating that BARs usage was the fact that the PCIe HW would do a
> > > baroque internal mapping of system memory, and concatenate the regions of
> > > multiple memory controllers.
> > >
> > > Newer chips such as the 7712 and Cable Modem SOCs have taken a step forward
> > > and now provide multiple inbound BARs.  This works in concert with the
> > > dma-ranges property, where each provided range becomes an inbound BAR.
> > >
> > > This commit provides support for these new chips and their multiple
> > > inbound BARs but also keeps the legacy support for the older system.
> > >
> >
> > BAR belongs to the endpoints not to the RC. How can the RC have 'BARs'? RC can
> > only map endpoint BARs to MEM region. What you are referring to is 'MEM region'
> > maybe?
> 
> Agreed, it is confusing.  Long story short, the HW team gave the
> inbound windows the label "BAR".   We will still have to use their
> register names,

Wow, such an inventive naming :)

> e.g. PCIE_MISC_RC_BAR4_CONFIG_LO, but what I can do is change
> for example "struct rc_bar" to "struct inbound_win" as well as make similar
> changes to the code and function names.
> 
> Let's assume you will be okay with my plan above; if not, please tell
> me what you would prefer.
> 

Yes please. Just keep BAR in the register name and use 'inbound_win' elsewhere.
Even better, add a comment at the top of these register names to clarify that
these refer to inbound windows.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

