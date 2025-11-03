Return-Path: <linux-pci+bounces-40146-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CDCC2E113
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 21:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 937FD3BD087
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 20:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B84F2C11C2;
	Mon,  3 Nov 2025 20:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2OcNpEm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4A2C11F6
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 20:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762203351; cv=none; b=ZiZHf9r6DZr46k67CkuVPFnA3rO+rBO1Kc1mAD+76LFF6iptavVC1cOzHOGvlBTVN60qhw/z4nOvBuuT0gy17L+vN0Yzwn+9K6JNz/+iQXzELRHLDBXKVEQrcf2mVKOTGNxg8kzcvJZxG61uNypSLyAihmLdJCTKKDmrK+YKiHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762203351; c=relaxed/simple;
	bh=MNnc+69lZjEdoLNMNHpdOsL37uDyvF8N6B5j/i2FB1Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rt0HJNevBiOVaHi3R8m4EmAfhdxz0Ua8wnEM1pr+njtNc4a7nlUcpuvOZCckTClaS0AHV7vspIEPKJmcjNVZ4osnU4n65AJBGLvD4aNewwUawo/ynrhUiXKxLXeU1aRb4s6HNDXqY7ahpBWtUn1NzqxeGg/Hyf4hpmYqD2UDjxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2OcNpEm; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781206cce18so5218488b3a.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 12:55:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762203350; x=1762808150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=T1FZmM9cdt+xj6V1Hd+gvwGWqSc0g8vu7TF1E04sPkw=;
        b=l2OcNpEmACr8JWpNNLwqV0fE5/Q8WdPZcCmzr0WtrcU5TNyxUwI2sVvEQzHJx6cJFG
         wILCbGqQV/B74yFiIk3mW9cPRH/Ous89Gav/EjTFBbL9YI9P8uz+vOslotKEkmX41Wlu
         Gta4YSeCoe7pme7MYSHRukmx3nGvlBChhmCSGUpFx+p8+StGb7WN77kWW4urxk6O9wlU
         +wzlPrTymXjjl0ZF3P0k5+atqbnbwhkUij8gpR0LPN39r7oDqw+J0c6c2ZBI4g71aJzm
         q3Y6IaW2RahFWb4L+UU+RvI/XvcN/0MrMJM0FJMdQJoQ+F/Y4npEsH8myWIUut6iLYoa
         nl8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762203350; x=1762808150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T1FZmM9cdt+xj6V1Hd+gvwGWqSc0g8vu7TF1E04sPkw=;
        b=RDiY5CRMUWeQ8BdZ3JHyQYeZwp6ymnmZPH5Dn/05jc5ZgnPRkGY0uRHUdHoaawC753
         /CSJdZlMKPawMsA/BKHvtt5M5eSI2AHRvSpSvr2eei9dJQwBkC5UVfmCqhBwHZl1JFQd
         ayi1K3Ghbh13erbN59CYTKJy22I2mmxiQbNc1sP84gmh/C4HMufpCO2O0JTsf04Lk7/6
         avX+OhoLyCk3RtrpsVMbUFo3Yrto8gSaK47IkJfS9LbdqkcjH4acrTyELkR6tszN9db4
         twT/opnOa9cOBXBLEqn5J0IxF3g4nvR9nIpCUxGbXjHabcKNRDjGZ6cUysT2wCn7Fh1u
         302g==
X-Forwarded-Encrypted: i=1; AJvYcCXzQt8k+Ex7rPxmz6fAXY6aOmJaweek0SLeKyzhGUZr1d/jzQ7mBPy4X4zHFJRySGXbXvPeYzgbyrQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpD20We2y2Ph3f3lgKUH9yBKIA07Z4UP0KY6/3gUpEd84SOOuq
	4EWsqkgFPVASGAKSIPXwMdHHZFF8jiY6Wka0ZBCdVJMg7vSbcnT4YhFU
X-Gm-Gg: ASbGnctJMr/M9altUrxjyoimtLuDqpjq3xDKqzGXYe2GiLQkchyUs5nWfntmibjKQQe
	wNHBlStOPq+VwnvN6PuPji+zcjol2E6Ci94aWfSk0Jnb/GLKmgl6896XJS9qHkjZ7Ftd1zXwhij
	k/Fr+A8CKzExS4QBKsRNVA+Dqgl+RNhhGqGJI2ZTLB/YSlG5QZnlmCGeFKlfE7O8gOY2rI7e4VD
	VTzTAC+vJ/Vh4bO9dri77wl7M5moDnrIEG23+7aa3q9iUN3PE25oWN3wixveEsOr0WqLoDdqFVr
	dLr4633iZIi33DZNz0A08et71pOqjOvfksIOWxp1kTzmmD+jvkM9GbLP4KprE4zLog9yuUg7Wnt
	tOC1ufmKeAQ1mob/ZUVx5k0C86Mf2B8U6ow0HCxQGmH8w4aTZT5fFPfXIbkDENw==
X-Google-Smtp-Source: AGHT+IGYDVdNgNWocqi7ihWCrOOfROJ4jnfVXq0iLB5L8b6BF6bhkooF51PIKfTJUsi9RRg9FKFduA==
X-Received: by 2002:a05:6a00:468a:b0:7aa:19a9:566a with SMTP id d2e1a72fcca58-7acbbb5a284mr818412b3a.0.1762203349654;
        Mon, 03 Nov 2025 12:55:49 -0800 (PST)
Received: from geday ([2804:7f2:800b:e79::dead:c001])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7acd623e091sm315775b3a.54.2025.11.03.12.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 12:55:49 -0800 (PST)
Date: Mon, 3 Nov 2025 17:55:38 -0300
From: Geraldo Nascimento <geraldogabriel@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-rockchip@lists.infradead.org,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Johan Jonker <jbx6244@gmail.com>
Subject: Re: [RFC PATCH 2/2] PCI: rockchip-host: drop wait on PERST# toggle
Message-ID: <aQkWysK2XA01lkB8@geday>
References: <d3d0c3a387ff461e62bbd66a0bde654a9a17761e.1762150971.git.geraldogabriel@gmail.com>
 <20251103181038.GA1814635@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103181038.GA1814635@bhelgaas>

On Mon, Nov 03, 2025 at 12:10:38PM -0600, Bjorn Helgaas wrote:
> On Mon, Nov 03, 2025 at 03:27:25AM -0300, Geraldo Nascimento wrote:
> > With this change PCIe will complete link-training with a known quirky
> > device - Samsung OEM PM981a SSD. This is completely against the PCIe
> > spec and yet it works as long as the power regulator for 3v3 PCIe
> > power is not defined as always-on or boot-on.
> 
> What is against the spec?  In what way is this SSD "known quirky"?  Is
> there a published erratum for it?

Hi Bjorn!

My proposed change itself is against the spec.

This SSD is known to simply not complete initial link-training with
Rockchip-IP PCIe. This is not officialy documented but based on
reports across boards (like the Armbian one).

I think it's the other way around though, it's the Rockchip-IP PCIe
controller that is quirky somehow and doesn't play nice with
many, many devices.

> 
> Removing this delay might make this SSD work, but if this delay is
> required per PCIe spec, how can we be confident that other devices
> will still work?

We really can't be sure there will be no side-effects to other devices.

> 
> Reports of devices that still work is not really enough to move this
> from the "hack that makes one device work" column to the "safe and
> effective for all devices" column.

I agree, and I knew from the start I would not get encouragements from
the community relative to this change. Still, it seemed selfish not to
share the workaround.

> 
> It's easy to see how *lack* of a delay can break something, but much
> harder to imagine how *removing* a delay can make something work.
> Devices must be able to tolerate pretty much arbitrary delays.

That said, the problem of quirky Rockchip-IP PCIe remains. The fact
that removing the delay makes it work with devices that previously
did not complete initial link training must at least point to a
resolution somehow, even if the present change is unacceptable.

I'll continue to hack around this, see if I can pinpoint exactly why
that delay screws up my initial link training.

Thanks,
Geraldo Nascimento

