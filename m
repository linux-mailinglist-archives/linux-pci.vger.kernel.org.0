Return-Path: <linux-pci+bounces-28723-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C59AC92DF
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 18:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9A3E170C22
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 16:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063412356B3;
	Fri, 30 May 2025 16:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="af7lniqD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464BE2356C3
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748620809; cv=none; b=XLZYgs5HSSK1NUftWnGuF2LlXRdLbmwGehQiKsaJ9eYg2MsZB3sNQGGm2ewFQ0ej6cKGD0nc1aJXe7/CuQrDWL6a7DIvdZ2mm6uo77daod0kJiND+2/6oLpkZQPA/58ssYW9oVX1AYPI9tHt1ZG/PrCtCLl3HvKWkCxn/hggMiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748620809; c=relaxed/simple;
	bh=YjLNzHCSASFSMH6VmmBM9Q/RhmciNXiBXZnvo+uz9vU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdvPQvnTk9fVlg7ArTiqzjguRxswFkNLm9IxxCKgMWyrEISR81VWsx/5zarGHKXCDXEzuZQGiE+jGrE6Z6ijnQXMXqcmjwh0H1UHi/5nwm9V30hrLqcx+VLZZ0VzA04UL+vCdoGAeIXs8ARqADVSV7yk21SZ+BTzaeoFkZT7KWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=af7lniqD; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742c2ed0fe1so2065756b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748620807; x=1749225607; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=77+FrcIpWSxgma5SjFDEMO5xH+4H9hBqTDfsgt+zhq4=;
        b=af7lniqDtfeczBglMXXJjnIjHvtZxcKSZ5wsZ02kSNsDmLMF5wxwFABPPU/Cpd0pjg
         sTrIGw5m9zXwkFAfCUl4oTZ7AMZI4oNvcrGhpUhFvo3QbYXVUo7zvGBeWh80iD2CEt5r
         HeDLEwrrK9YZF3+GLq8iBLFnJyOgWUq8ERQVmAQjABQqex2Ro5fOZY8gGJF9oSaGbQl6
         7t+4pk4vTQUsCyp2GR8mVwhbQTR7OqvJHGeU/gw8r0fr+cxIMTBEHUb8q17h+3tScMSh
         PJC0ChL+odw1vIvJAgJDs5RPhm9yusS4Mv+NenOK6lcFg2pQBSDa17OMXDnbyehNjxzg
         r2tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748620807; x=1749225607;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=77+FrcIpWSxgma5SjFDEMO5xH+4H9hBqTDfsgt+zhq4=;
        b=l0iCGmRnGPoICpO/JGj+WbHRAZ8A1nP+RdRl1R8biK2trYLwUwnZW2UPhLqoowAIpf
         uSSRKG3TcoODGrTn2zx9HoRlvAAlbU3bnN5cYHdSSY9bVV3gFJb7mF/wrpY7x8pfqyJ/
         fTRvWZhzKac3IZBw8GKo3aj0hX5utRHxww+X7g2ruKX+VP46XMiW8KicigWCuYokYW2U
         GK8YiKtLMUQQwYEzZgLauFoq26NgKGbtmSFf7cHjLdLTDU9No+h1fbLNt8xitvaJHWX9
         FWvnAqdlNLnKoZAd49+bC+Ea/vIhm4nWaDskFJHtag2tXDUhbHPRhkpB5Z0TVKyrzO8i
         Tx1g==
X-Forwarded-Encrypted: i=1; AJvYcCXfpFD5YFzxaWRn821HIqfeh4dJmOaiJc12BxQdya4hYHEPjlKbM7fFMi0vruO4765kuSfX7k78FNE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMlNuNkhB0IbwZYLfsflrVkJhtD1unMJWnXGgC0MI+I0KOtTpC
	3TSkbU4ZIQjDJNNSGBteZwUXXqyF0GGxH33wQLO+ssmLOFXtYqZ3AXQyTpDPPEYiHA==
X-Gm-Gg: ASbGnct3MxaaI4AjvE6aNFZ7D0w+HLHCPQCSszGMozuVMCgyog47p8F4ztoPylV9v0s
	n+vCh8ZANOq0WN8wPbYyehJEK5qG/YQ9Sqyt2sXqV+9hx1uYRwbBiKYiaDJ5/6wzv4xOCse+11l
	IFiR+GEHEbuI8wPSy+XaTcLiaDhIZ/sn7q6uCQJ0rVKElhi2AjecaYI0e4lPaogEEiSPrO320lO
	Td4O2zYZKDSXCsssHqyNEJb51jkKfEr0KIzJYBP2PLCLXQsq0wUGamjROTeJqukbjcdeafiAxIq
	YqFnwgYKheewEBMGJMuU4woUJYbZ4nqeXQqkbKUN+W2pKk2YmxEaUfy2mQb9ukJ2JmzdDN1b
X-Google-Smtp-Source: AGHT+IF/8QTsNcVL/z+rQlAga/Geyj/2FCJ5vD5YDtu2ldaYPZerMoqgdp4D+2pixaewJCBXnV6XdQ==
X-Received: by 2002:a05:6a00:1743:b0:736:43d6:f008 with SMTP id d2e1a72fcca58-747bd980d13mr5393036b3a.12.1748620804748;
        Fri, 30 May 2025 09:00:04 -0700 (PDT)
Received: from thinkpad ([120.60.139.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-747afed34fdsm3213450b3a.75.2025.05.30.09.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 09:00:04 -0700 (PDT)
Date: Fri, 30 May 2025 21:29:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Wilfred Mallawa <wilfred.mallawa@wdc.com>, 
	Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>, 
	Laszlo Fiat <laszlo.fiat@proton.me>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2 1/4] PCI: dw-rockchip: Do not enumerate bus before
 endpoint devices are ready
Message-ID: <fbvatgydh64wr2z2srivbuurjonxpq46xie3bq57grtosesfti@v6vplhyxc343>
References: <20250506073934.433176-7-cassel@kernel.org>
 <20250528224251.GA58400@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250528224251.GA58400@bhelgaas>

On Wed, May 28, 2025 at 05:42:51PM -0500, Bjorn Helgaas wrote:
> On Tue, May 06, 2025 at 09:39:36AM +0200, Niklas Cassel wrote:
> > Commit ec9fd499b9c6 ("PCI: dw-rockchip: Don't wait for link since we can
> > detect Link Up") changed so that we no longer call dw_pcie_wait_for_link(),
> > and instead enumerate the bus when receiving a Link Up IRQ.
> > 
> > Laszlo Fiat reported (off-list) that his PLEXTOR PX-256M8PeGN NVMe SSD is
> > no longer functional, and simply reverting commit ec9fd499b9c6 ("PCI:
> > dw-rockchip: Don't wait for link since we can detect Link Up") makes his
> > SSD functional again.
> > 
> > It seems that we are enumerating the bus before the endpoint is ready.
> > Adding a msleep(PCIE_T_RRS_READY_MS) before enumerating the bus in the
> > threaded IRQ handler makes the SSD functional once again.
> 
> This sounds like a problem that could happen with any controller, not
> just dw-rockchip?  Are we missing some required delay that should be
> in generic code?  Or is this a PLEXTOR defect that everybody has to
> pay the price for?
> 
> Delays like this are really hard to get rid of once we add them, so
> I'm a little bit cautious.
> 

Ok, I digged into the spec a little more and I could see below paragraph in
r6.0, sec 6.6.1 for devices not supporting Device Readiness Status (DRS):

"With a Downstream Port that does not support Link speeds greater than 5.0 GT/s,
software must wait a minimum of 100 ms following exit from a Conventional Reset
before sending a Configuration Request to the device immediately below that
Port.

With a Downstream Port that supports Link speeds greater than 5.0 GT/s,
software must wait a minimum of 100 ms after Link training completes before
sending a Configuration Request to the device immediately below that Port.
Software can determine when Link training completes by polling the Data Link
Layer Link Active bit or by setting up an associated interrupt
(see § Section 6.7.3.3 ). It is strongly recommended for software to use this
mechanism whenever the Downstream Port supports it."

We are not checking for DRS after the PERST# deassert or after link is up, I
think DRS check only applies to enumerated devices, but I'm not 100% sure. But
if we assume that the devices doesn't support DRS, then we should make sure
that all controller drivers wait for 100ms even after link up event before
issuing the config request.

So I don't think this is a device specific issue but rather controller specific.
And this makes the Qcom patch that I dropped a valid one (ofc with change in
description).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

