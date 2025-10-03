Return-Path: <linux-pci+bounces-37492-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 264D0BB5BB0
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 03:18:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3F0C1AE4816
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 01:19:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0435242D67;
	Fri,  3 Oct 2025 01:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PzTtmNDo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666F81DA60F
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 01:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759454322; cv=none; b=n9WAdQ4A3oFAmcm1bakOtN0Oc4ovDVGK8mZvthzBItzqj3oCA+mQbkQLKsqpWEl+F0AFyM3kIpPInWjiBYbTUM9yNa/DnM+ZqD+4KpasQNNFs5HOBIiqdc6cKvLgWFP3x+P9rxYbVNc1PxXeEhtKygXVl9/+yuhFJrCq+JCsca8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759454322; c=relaxed/simple;
	bh=pA4WP3zt2G1DomcTbYcD2Gr68u+gCkSUrvSZJPMp3RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XRskSH3KYdSMzQd8xRll9ZAzl0IrRN1ltc3HRDq0QdlNIprZLx69f1HxWpOWBY3vzt6cdp+7JV7f8LncU9Jt/J9jkM0wzDjaVcXlrC2DR51xcyhzV9c4TtFrClFCp083GfSslJr5ITZOd45O9KY9ArgG9c9eY1Fitm/ygKiomm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PzTtmNDo; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-b551b040930so1045937a12.2
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 18:18:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759454317; x=1760059117; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8Ok6Brl0A8XUEUFiH0UWwQ2wUkCLnBX8pSnfXubriaQ=;
        b=PzTtmNDowiPPLvaHYGA2yBofOoJnku8NWlTp4z5hiwcMRtctmIHDQmlE2+qhpWJn9E
         cFg/YPrUl0zQBvBUEm+pWJerFpA3l/Ho6wJjOvRLRqX8CIOAflBylQ/klaoIkm5cKqlC
         zaoPd5d9LttPfYQ+4bNylE5DBK0dO2bITSv5dViUKkc+se7AJcEnC7N4Ene5yZsRyqlM
         3ZYe/uPihFTD438zCxBjZ/5wwoATOrFE+COOryPsVNPxO8FMbhnrrzwRKI/7XHzo64Jx
         LXH4AOtzfscqiSq9W2K1427qnvrLIP1zwycmiesTHUXfhj+Tm6o+usbEaHdkAmrlU48a
         RZkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759454317; x=1760059117;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8Ok6Brl0A8XUEUFiH0UWwQ2wUkCLnBX8pSnfXubriaQ=;
        b=G01cBVWe3R/e+4tpUpnIqat/WV4LjjaDO8GJhHAfkdmumh3dJ6IS/wfU3BzQeOFOJQ
         3zV0aQEvix0+FaaqLPj4Yxmopv2l9bO8ohrEtzg10fqJ0xlZA01lUXclK2uQqH09yTWA
         eqQz/3pC0/BejxKDuAFc8J5IAhyWQwQAw2FRILLhQ7tNqEEZFuoWW+ccjqfIcv4QP/dd
         7E/x2Bj2bVKljKe/3WNHDER6VXelY53zxsNKr0sWGVBITX6yvUhQ8imNmbGJ9MHHp4Yv
         gcbZ3z/wdgH80Pb0gMHQU8PzxrkXp8m1IQN0+MjvqPN5gOVA4woeJIuUTZEq//RK/RzL
         ithg==
X-Forwarded-Encrypted: i=1; AJvYcCW7Db36BSXIF2n63aL3Nw5PWeNaeZxDX05RvXjvEzNM3vpGWy1JLXvu2GsDlZoBw4HsLMOXVEr0ODk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHWjgcfRs3U9er6lgvrE1puKDuOfgtWnctpBqa7vJCxilIoHZg
	J8gFHRVBYMcpKuq0Dyz4D3+kfzfJycKIOCO9mYhVpML7Dc8JGoAnoOAd
X-Gm-Gg: ASbGnctzylCeT9DJ/lSyRZ2+KOSiSifVWSPV/plXGuxpoBK+Cj1ieFHuKVc7U3SzNVE
	TDzOuJb9X0rHb7v0+uw3DuLAvNMo3zg3rjVqNgD71y2A6mKB1NjjCut9MopoFbI9ZtgyyRWSCre
	E3g/Oht24BgNAgXVnjuP4b0tpaI/kouWTfyvWrHv5yg7sLSxAaSivDVm7TOvoH+PBoAbiVYA0Pn
	zDp27Dy8KkH3PMuYq4AqglydNrButgfyxWA5yHQ+AMVNQFsH1Ps9XPINuD8A7WEA0WlyCjCc2To
	Vx0vm/kYCFoqpr9oVdzVxtb9Ps7u9rv685MJEahUNXdd+KUNJpz/y/BkGvz2dS6LF+5qH6sqS2E
	xT+Zdfy2wKYQ5OnHTK1/HeQrDZdVgYZjnFqmy0O8Bv+IbIA==
X-Google-Smtp-Source: AGHT+IHD1NKeqaobY6RUyVgwqkWW8cf78ghAcEtZAV/t32H6q47TljyoimNEg0sNl1+8XzhOHhWUbw==
X-Received: by 2002:a17:903:3888:b0:27e:ef27:1e47 with SMTP id d9443c01a7336-28e9a5f7186mr13518235ad.31.1759454316583;
        Thu, 02 Oct 2025 18:18:36 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-28e8d111b32sm33440985ad.12.2025.10.02.18.18.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 18:18:36 -0700 (PDT)
Date: Fri, 3 Oct 2025 09:18:03 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Kenneth Crudup <kenny@panix.com>, Inochi Amaoto <inochiama@gmail.com>
Cc: tglx@linutronix.de, bhelgaas@google.com, unicorn_wang@outlook.com, 
	linux-pci@vger.kernel.org
Subject: Re: commit 54f45a30c0 ("PCI/MSI: Add startup/shutdown for per device
 domains") causing boot hangs on my laptop
Message-ID: <feedlab62syxyk56uzclvrltwhaui7qgaxsynsgpfrudmpue52@vbt6zahn5kif>
References: <8a923590-5b3a-406f-a324-7bd1cf894d8f@panix.com>
 <hxyz7e6ebp3hmwyv3ivhy5kwc5skpynzl4djyylusheuv3fmqf@tmh2bygaex4r>
 <05f38588-7759-42ce-9202-2c48c29e2f23@panix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05f38588-7759-42ce-9202-2c48c29e2f23@panix.com>

On Thu, Oct 02, 2025 at 06:10:25PM -0700, Kenneth Crudup wrote:
> 
> lspci output
> 
> On 10/2/25 18:06, Inochi Amaoto wrote:
> > On Thu, Oct 02, 2025 at 05:58:59PM -0700, Kenneth Crudup wrote:
> > > 
> > > Resending to re-add linux-pci (Vger thinks my tablet's MUA is "Spammy")
> > > 
> > > I'm going to figure out which line is is that's killing my NVMe IRQs.
> > > 
> > > FWIW, my NVMe is behind a VMD bridge(? I guess that's what it is):
> > > 
> > 
> > I think so, can you do "lspci -k" for this bridge? So I can know the driver
> > for it.
> > 
> > Regards,
> > Inochi
> > 
> 
> -- 
> Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County
> CA

[...]

> 0000:00:0e.0 RAID bus controller [0104]: Intel Corporation Volume Management Device NVMe RAID Controller [8086:467f]
> 	Subsystem: Dell Device [1028:0af3]
> 	Flags: bus master, fast devsel, latency 0, IOMMU group 9
> 	Memory at 603c000000 (64-bit, non-prefetchable) [size=32M]
> 	Memory at 72000000 (32-bit, non-prefetchable) [size=32M]
> 	Memory at 6040100000 (64-bit, non-prefetchable) [size=1M]
> 	Capabilities: [80] MSI-X: Enable+ Count=19 Masked-
> 	Capabilities: [90] Express Root Complex Integrated Endpoint, IntMsgNum 0
> 	Capabilities: [e0] Power Management version 3
> 	Kernel driver in use: vmd
> 	Kernel modules: vmd, ahci
> 

I have found something interesting in this driver.

```
static bool vmd_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
				  struct irq_domain *real_parent,
				  struct msi_domain_info *info)
{
	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
		return false;

	info->chip->irq_enable		= vmd_pci_msi_enable;
	info->chip->irq_disable		= vmd_pci_msi_disable;
	return true;
}
```

It seems like this driver already have a enable/disable function. It is 
like a violation for the change of msi domain.
I think I should change it to adapt the the domain change. I will send
a draft diff when I finish it.

Regards,
Inochi

