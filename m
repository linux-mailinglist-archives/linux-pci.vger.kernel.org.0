Return-Path: <linux-pci+bounces-31983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A589B027DA
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jul 2025 01:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34312A4812C
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jul 2025 23:49:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A70FD21E0BA;
	Fri, 11 Jul 2025 23:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lTOSy/LX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0A71FDE19
	for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 23:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752277771; cv=none; b=ad6sPjUd3lRwUkbAxj9bIWNzwU+rBfvmBzKuaOSyxBmNaF9xtGk1+MLDsl44bURIA1dAvrR2BSpXzmZdsh2fCuqc6FPZG8cm7jEFiTehLCsh8RAQArRK39EUMr9IZolZ1/cvfqQmE7+bjYHbaPnrloK9B5vICh1NYpBvviCPuEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752277771; c=relaxed/simple;
	bh=MrjFFSLrixtNQISgNSoqC6by9asCMdinuhdIGBG/7UQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TomAcq8BOHgy2EzUsLMHnEJf12+F3lCcsWmWS1UdAzcHUC9P7jS7lrCz8npxhvBzOKP13C6JieSJmIJjjh7s+8cxoosp+TO0ongDJBB2Bt2hOdoSWaOH3bkLVOpzsWfjT6+dmVXFD0n0rt/ZWIMTEj8Rk11WLjcTP0LUBmtOBPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lTOSy/LX; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7490702fc7cso1700942b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 11 Jul 2025 16:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1752277769; x=1752882569; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KC1CYY+XS/EVReWHxILsWiPjh9LJPfU94snv8/jX79c=;
        b=lTOSy/LXZfKubczJI7oKZlrg+rRwJWas7qtj0Zis/Gn1QcHcjtdj8V2e0ltGLqWQn/
         LlsJINN01ieselFSj4LLKiZCL5AcJtX1pULZT35Ng5NsGTD3tecUWaW3B7sqc9bIhspF
         tfmHpaMGtlkjbc8boHF8eqD5lRHS+11XmaMTo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752277769; x=1752882569;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KC1CYY+XS/EVReWHxILsWiPjh9LJPfU94snv8/jX79c=;
        b=Whx2mzueSVyf+96k83kMQ/1f4zrzy9NVAM6o441dS5OEclpUB9hhaXkmvBJPDopZTU
         F53li0ZpDNLnQIv1h6U8LPCD5EZjBeJn5tTw6sMSMgROfO75ffX/YKhgfRJQ7I4rfnJF
         8grux3W8UmFNsHW2CEko5D5RwyYmjCGrnoHFm5hLHt1ZAWFl5zcoZZ1jasvH3WBwYaYf
         nGZhx8Oy8AM97tzUzc6456JZZqxglOuMlsYLLvGEA1CKkc7WKs2hbuqsg29yOc1ISF2/
         InyEbQy5kI3M+JbSUoEZdm22WJ4+7syGuZba5BHwz+C8vwPMofkFi1wiz3Wbf9o9JLK0
         6U3w==
X-Forwarded-Encrypted: i=1; AJvYcCU4BFaZX7kXPu+xp4glFZXrXq3YofBeqJy1b86ZhkhTxuG4mnr+ouSp52ad6KQsvQ8MtObln6MRLx0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFmjCNuCBs/ZV6E4UA3+tTC9O95eydfh6eLCRQCjoNaKyWz4pB
	OCgilEkFLAAvYXY+VaYj5w3CjjAkLGgogEoNL9kjSTY5avDWj6PA8ilwEmvpsiu3FA==
X-Gm-Gg: ASbGnctTGP0phKzOwpp/15BcKkPrQmUmwpbAgm3bIxbWlUS9GPIAw3jY/c8Dd0JSf3P
	YjwtVd9evMdmoqfJRbWq6kL0LQSwUq/IuaBmPRFNy2WPox+SDk7mIE5r6Ma0UjIgL7WCpup2JpZ
	OCdRvTwJDSgnoN/0nn8cZ62WQm5WReE9YbRgVr4FUITyiFG6ESx+kldG0a/Wy43linYg7MNlpM8
	Q+2DxO0FlJQTvZF+HTB8l4ByYpf/2cZEiIjzRJ3tNbhKn8UcrlVFECTWvZmtbx50lRN9iBbT7Ke
	1JDclxTYh7vEx2ZhJ+3gqtt203qO7Rgsibv2DFY8RtZQxOZ0o81Y9+Phi6xa0vBUoI8r4eTn64b
	R0NHk+WgjlFDeePyMKlEpOBWHf6dYe5HWddzF50yll2ClSbsKnocXogXs9Iah
X-Google-Smtp-Source: AGHT+IEZEOkHg2JDnPVscnsdRLHkXkD8TwYVqpEi0tinyurqooXEUZWQu4K9HvxpNjbOnoSzMA4FEg==
X-Received: by 2002:a17:903:46cb:b0:23d:dd04:28e5 with SMTP id d9443c01a7336-23df08e1bd4mr68820345ad.34.1752277769541;
        Fri, 11 Jul 2025 16:49:29 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:2386:8bd3:333b:b774])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-23de4322f15sm53994305ad.130.2025.07.11.16.49.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Jul 2025 16:49:29 -0700 (PDT)
Date: Fri, 11 Jul 2025 16:49:27 -0700
From: Brian Norris <briannorris@chromium.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: [PATCH RFC 2/3] PCI/pwrctrl: Allow pwrctrl core to control
 PERST# GPIO if available
Message-ID: <aHGjBxKYJCkhXcbo@google.com>
References: <20250707-pci-pwrctrl-perst-v1-0-c3c7e513e312@kernel.org>
 <20250707-pci-pwrctrl-perst-v1-2-c3c7e513e312@kernel.org>
 <aG3e26yjO4I1WSnG@google.com>
 <kl5rsst6p2lgnepopxij5o6vyca4abrjlktsirfac3v7cnm33l@svrcm7v4gasr>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <kl5rsst6p2lgnepopxij5o6vyca4abrjlktsirfac3v7cnm33l@svrcm7v4gasr>

On Wed, Jul 09, 2025 at 01:35:08PM +0530, Manivannan Sadhasivam wrote:
> On Tue, Jul 08, 2025 at 08:15:39PM GMT, Brian Norris wrote:
> > On Mon, Jul 07, 2025 at 11:48:39PM +0530, Manivannan Sadhasivam wrote:
> > > --- a/drivers/pci/pwrctrl/core.c
> > > +++ b/drivers/pci/pwrctrl/core.c
> > > +static void pci_pwrctrl_perst_deassert(struct pci_pwrctrl *pwrctrl)
> > > +{
> > > +	/* Bail out early to avoid the delay if PERST# is not available */
> > > +	if (!pwrctrl->perst)
> > > +		return;
> > > +
> > > +	msleep(PCIE_T_PVPERL_MS);
> > > +	gpiod_set_value_cansleep(pwrctrl->perst, 0);
> > 
> > What if PERST# was already deasserted? On one hand, we're wasting time
> > here if so. On the other, you're not accomplishing your spec-compliance
> > goal if it was.
> > 
> 
> If controller drivers populate 'pci_host_bridge::perst', then they should not
> deassert PERST# as they don't control the supplies. I've mentioned it in the
> cover letter, but I will mention it in commit message also.

Sorry, I think I partially read that, but didn't really grasp how it fit
in here.

I commented on patch 3 where you try to implement this. IIUC, you're
making excessive assumptions about the use of pwrctrl.

Brian

