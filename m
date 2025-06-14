Return-Path: <linux-pci+bounces-29802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29DDBAD9982
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 03:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21A4C189FC22
	for <lists+linux-pci@lfdr.de>; Sat, 14 Jun 2025 01:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8606122EF5;
	Sat, 14 Jun 2025 01:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rw2v6/oM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85B3FD4;
	Sat, 14 Jun 2025 01:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749865116; cv=none; b=rpWd1K5qiKw70yTrZDOSzWHDP8DdL2+PL7vcd7jZwGlpChrwRoFf4S9bL6TmyxqtzKD9vskCpA4wXqDecCw4IBrGnAHWbiOVRtICD+Q2+jy34FIMe+eTLT2wW0QAKLs66vMXOV4Yst/EAlSDmoA1YxylV85vpdUmOySUWF0q+OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749865116; c=relaxed/simple;
	bh=1t2JgUYUU36zTeFilfNtFiyEJY5c/S+KS6xlRrjKu6o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urNCJ7XC4LkpfktEk/eCM2TSa5aoetKvAmvLzLh43drX5wRGPrqJr+QiGfRJp1LFGozDsVzXyT43klLiZmTrfkXdZHhssCkpgNgBN60PFhZe5Rphfzli4xRZ5NnpTWML2jTTCMR8d5O7KQjQcGryU2MD/Ro+XD93Wcth7EQnxIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rw2v6/oM; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-234bfe37cccso35797705ad.0;
        Fri, 13 Jun 2025 18:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749865114; x=1750469914; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0lQejjsw0q+CGE5uh3c+Gs+NLf8tN+h+7rm943Xmkng=;
        b=Rw2v6/oMSbIk3ycRDHx3rwg4hDHo0xVqTUel3yRsIdrVd747jxgNU3k+w1MEF6magy
         HOfXPAsbBRef62YWLW2zL+g8GCnryeB4X/O7JBV2WJvskJDU7/OFhRhDZ4f2ugolJWu5
         q3Bl2AMLVeP+iV5YeQzoEt1egLeM7HDv9OLWAyABQ6RjqveV9Rf9foPTgiNvWx1eCgJJ
         cLNyZIVR2thmtgGY0VhjWUoCZgHVZXuq9aEyK2PbTfi4Pbggal6yvps1gmw92PlltkQN
         9oLPXSSlmgv2FeHqIT0/2FnliU6M4pLbhkJR8r+ug9WqePe8rmcRssTccg8h+IL+yZ5S
         Rb/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749865114; x=1750469914;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0lQejjsw0q+CGE5uh3c+Gs+NLf8tN+h+7rm943Xmkng=;
        b=b4V5LlgXhvQwe1qhXxJthKpV40sqqAj+6WPb9aluQzeE7eAIOWfYdSzpFaCe4lBqlI
         ZY8EjTtKSytUG8sCcl6X37bSvpUbeHw2uBOvvbZXRycWHxwOX87MCHgKwfnNT2qAF6om
         FkMk/FEsD/eK2eEBzeurEX3gSawSEby0w7FQibXlbd2VofIOk5HvYdq3OB/kI1O2G5MD
         Xb4nkaO8T1/UXbZWUyFtM41kIzoGicv1IAT2RkL8uVXDwEA1kIzrFT7hm4dKmkMQotg9
         HLgRu9Wn4fOxJWRBu3wb70r3k/q0l7iggFM2gptQPo+5tIXBepBGFlS8K1p0RAmWU8Ld
         l72Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJhI7uZudqqUMNPj1FGGV+Td6AdK3UUMBhALhCYD1DfB247oAnW9dX9no8PiW66cnWcFj2J4BM30xwE7o=@vger.kernel.org, AJvYcCXEowq85y/3XJ+L/kspfInAPr0BjlpvRROPcplRKMcX3eOf5sXTK3/8j21ITZQgzt4A4dRaZUoH23WU@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3wQKLH0bjXhy5B1jehITYgQTUNRva3RcuBUWrRAERePXdb3lg
	z91XJgTx9rqXDfwDWACAhpEgg2YeK6g5iX9WfzmNUYVtB4hqC0lRukOg
X-Gm-Gg: ASbGncu8mNdyEn1T9utkZMI/kX6CsepEHuJ4FdyprI/D3kTza4oOjEPTik6I4LaoE0r
	Eyj5XxQrG9l5XT9Kq+AcYNrIc7WIwd5jNE/vB4i6c6OhadahgYjU/XAiRFoH2cGd3Q1O6BaMozJ
	wHcCdh7clMk43f08h2skqzHmjwnP80ZWr7PgEsX1A2xREvyP9yUzxJk/4A7ZleAZMYAo3YE70KS
	75PG+bHiXsc52WQB2bfUVAJVUfCwJOnRRcNWop9pc3vKoVOtqmmw8pHZzeRPNUneRttlRXAPrn2
	SsRHncQcXUAgvXLqvIGoxo5GdSYoTNgkuI0RZTiRaYJpIIvv9Q==
X-Google-Smtp-Source: AGHT+IEMPF1CG7Z4ty/9CQse/2JF9FvgerUO1LrtGFrS+i5WUaSY65B8ME0JLsiKs/vhtHxhj88YWw==
X-Received: by 2002:a17:902:f647:b0:234:e7bb:963b with SMTP id d9443c01a7336-2366b00ee33mr23760305ad.16.1749865114201;
        Fri, 13 Jun 2025 18:38:34 -0700 (PDT)
Received: from geday ([2804:7f2:800b:87ca::dead:c001])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d8a1fa0sm21379435ad.86.2025.06.13.18.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 18:38:33 -0700 (PDT)
Date: Fri, 13 Jun 2025 22:38:18 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND RFC PATCH v4 1/5] PCI: rockchip: Use standard PCIe
 defines
Message-ID: <aEzSilET0wAQ7ozA@geday>
References: <992ab6278af59b8f2f82521bf4611f69a916bbe1.1749827015.git.geraldogabriel@gmail.com>
 <20250613201409.GA973486@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250613201409.GA973486@bhelgaas>

On Fri, Jun 13, 2025 at 03:14:09PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 13, 2025 at 12:05:31PM -0300, Geraldo Nascimento wrote:
> > -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> > +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
> >  	status |= (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16;
> 
> It looks funny to write PCI_EXP_LNKCTL with bits from PCI_EXP_LNKSTA.
> I guess this is because rockchip_pcie_write() does 32-bit writes, but
> PCI_EXP_LNKCTL and PCI_EXP_LNKSTA are adjacent 16-bit registers.
> 
> If the hardware supports it, adding rockchip_pcie_readw() and
> rockchip_pcie_writew() for 16-bit accesses would make this read
> better.
> 
> Hopefully the hardware *does* support this (it's required per spec at
> least for config accesses, which would be a different path in the
> hardware).  Doing the 32-bit write of PCI_EXP_LNKCTL above is
> problematic because writes PCI_EXP_LNKSTA as well, and PCI_EXP_LNKSTA
> includes some RW1C bits that may be unintentionally cleared.

Hi Bjorn,

unfortunately Rockchip PCIe IP does not support 16-bit accesses,
I tried and it only rendered the kernel unbootable, which made
people in my house angry since the RK3399 box is my Internet Gateway!

:-)

For thit particular case, it is OK since LABS and LBMS are precisely
the only RW1C bits in LNKSTA as far as I know. But see below.
> >  
> > -	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCSR);
> > -	status &= ~PCIE_RC_CONFIG_DCSR_MPS_MASK;
> > -	status |= PCIE_RC_CONFIG_DCSR_MPS_256;
> > -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
> > +	status = rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
> > +	status &= ~PCI_EXP_DEVCTL_PAYLOAD;
> > +	status |= PCI_EXP_DEVCTL_PAYLOAD_256B;
> > +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR + PCI_EXP_DEVCTL);
> 
> Similar problem here; PCI_EXP_DEVCTL is only 16 bits, and writing the
> adjacent PCI_EXP_DEVSTA may clear RW1C bits you didn't want to clear.
> 

This is a bit more concerning then above. I'm out of ideas regarding
this particular issue you raised.

Geraldo Nascimento
> Bjorn

