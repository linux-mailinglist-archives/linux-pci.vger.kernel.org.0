Return-Path: <linux-pci+bounces-33796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D050FB21873
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 00:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87A164273B7
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 22:33:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49CB221C19D;
	Mon, 11 Aug 2025 22:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OomxcUfK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902131C1AB4;
	Mon, 11 Aug 2025 22:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951632; cv=none; b=UQZ/s8c11ttjbGqejnK/nXfpZcZydNFqleBaeLo4OKPsySTHq/sgdS81qH6kb1eYmXcR/hZAIr8sNn4y1++T+bpHMWTS4KNP0QhvKDEPDOd7/UszGdgjrotAC9YBA8Jsa172X2ZYY0M/mqyCTmE/RTcMxDFC+2dkHD0W/RiqKGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951632; c=relaxed/simple;
	bh=ekPQOUTGLm1W5r1CZug+kR/2MpUPe3OXrDWHjhckxLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nyBOVkRRAYG4Q+A09pyHjqQ8jWsXTO19r0AJ1flOWpdBk80yBSPgThh+PNwtl+D+qzVyEfpll0sYVffwK3XfaRrgKwbgCXAUZMTBMP+huFO5PSVRlAZ3FT3b3+oqMWxlCl7bvX4OpDBG7lcyokAZDYFwXBBCDVPePE2Ewu0K3QY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OomxcUfK; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-55b85d01b79so5120033e87.3;
        Mon, 11 Aug 2025 15:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754951629; x=1755556429; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g3g+wZXFPmNskPkEAXy6Ad546UIsJ+3096p7iAg6LtE=;
        b=OomxcUfKDXsHNndkrDr31wwf1tvNQhK57R5KOtM/YhkD3URniDGHu89nRGKe0YLwVq
         3u/9DM5wQWvF9bAJkI4w8t6XsakBNHMW3moorERtAYHbWl8tMp4sHgpGDZa7bhqSp4ng
         UlEL+8gsDKGq/f1+Pdb/t0yCbfxSGfNOztYh4gJULTPJcW0cjbezc6cY8cFKfuc3A/uk
         odqbKVwBcU691TEDKUv5Ajlp96F78FKTy1vR1TO/eiXikd/U+EZUq3zG5hcJNYd6zrYY
         DCLMLkrRNWl/smW92FHAHZLIQA9Og9wGe6EQsLGtvPPwYe0dvQfpIE/wS0SqqQUhthZ9
         YPdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754951629; x=1755556429;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g3g+wZXFPmNskPkEAXy6Ad546UIsJ+3096p7iAg6LtE=;
        b=VJASKeIteb6GI5rXkJc7E+84X2bk8bFb1aIkfQcSx2+C8loELRk4jsJapzLrUKUryK
         HNqsU0GKX6RsCdWNKckYzIV/QR/NORJYBMxVmvS+w8uEx6SwvP2qFqMaOFQe2olgeVaY
         uE9DoHgJYOKj3+AJNqVwwc2RmGGn1ri/boRyJ1HL9e/9VZtSpWhXn1j2I6KLK4f5A/xY
         WZ2mmVZhNQC5bckJ587KnhJPvlyRjc9HLMptNKtdj7PzRohvB1JVcQ9WLFom1K5NlQ8E
         Mtc0IIfROAvenb04kYpcdXiIAO/nyNb5BLrBy3JVrKpdPWoXK215C7TeiSi25X/sZBIy
         hNGA==
X-Forwarded-Encrypted: i=1; AJvYcCV1Rr9vK448zY+AUyfCxBDCVkycEP6xDXFs1Iirxdytgl80RjB2T1dyrw36NHmarL/y1w1mD6MZoqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ8Ow39pT3DYKUrjNTomV7XBsZGBdiLP+PVuQHTQNqsspqad1d
	zfGQvNbfZj4HE2FfPkzaLBMBmd55uZH4CG3Is5qEAWf/l6wP4608lbv0
X-Gm-Gg: ASbGncuml+suypXFZCxtjycBBmJBFssW90S3i+3wNnY2483t1cW1U6853PVcBFoxs1X
	v6Xvw10gyzPjLh2GaGsx6grEUL1PjJg8wIpfM2S7NUug4jaN6azkpecokqUMy22FPpPLPxWSjK6
	+AIQIHbathjVL0xEGaI7Weh4AZ28peSdQmKcz/bq8FAphnp0Izej53rzgHu2PbVgT/oXoKk1CEh
	scpclDTGY+GteLaujjdlV4qXQreqR3kzFPH0uAivboVaB416z5aj7NT4xpx0Ez9acNqUAZQgh6z
	scF7U2m7iJ6eWMBCAS8+nGiRNJ9cVNr+pO13sPWqh2Z6LKJD5OsqxheMEzPjbdUkyrCRoUULdbY
	rrjvzyYdb1YetRkn0Mq24UA==
X-Google-Smtp-Source: AGHT+IEygDT+H9f2F7NW6piXIApHNiycvYlXlF8MP0wBwKaWi5hiDBriuTTACcQQyurjzRm9IRUj4w==
X-Received: by 2002:a05:651c:4197:b0:32b:5a32:1849 with SMTP id 38308e7fff4ca-333d7b0b29amr3023001fa.18.1754951628253;
        Mon, 11 Aug 2025 15:33:48 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id 38308e7fff4ca-332382be1a3sm41542461fa.34.2025.08.11.15.33.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:33:47 -0700 (PDT)
Date: Tue, 12 Aug 2025 06:32:59 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
	Inochi Amaoto <inochiama@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Jonathan Cameron <Jonathan.Cameron@huwei.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 1/4] genirq: Add irq_chip_(startup/shutdown)_parent
Message-ID: <iebegtfdwlmaj63wmsjnks2nmizgou7ndhqzf3yxrgvxqqibex@seqik3unl544>
References: <20250807112326.748740-1-inochiama@gmail.com>
 <20250807112326.748740-2-inochiama@gmail.com>
 <87zfc57wlx.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zfc57wlx.ffs@tglx>

On Mon, Aug 11, 2025 at 04:37:30PM +0200, Thomas Gleixner wrote:
> On Thu, Aug 07 2025 at 19:23, Inochi Amaoto wrote:
> 
> Please use 'function()' notation for functions. See
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html
> 
> I'm sure I pointed you to this documented at least three times in the
> past. Do you think this was written for entertainment?
> 

Yeah, I have remembered to add this brace for the function. It seems
like I have forgot to fix this when I do the rebase. I apology for it.

> > Add helper irq_chip_startup_parent and irq_chip_shutdown_parent. The
> > helper implement the default behavior in case irq_startup or irq_shutdown
> > is not implemented for the parent interrupt chip, which will fallback
> > to irq_chip_enable_parent or irq_chip_disable_parent if not available.
> 
> Also please use the documented structure for change logs. Starting with
> 'Add' is just wrong. See Documentation.
> 

OK, I will structure the changelog.

Regards,
Inochi.

