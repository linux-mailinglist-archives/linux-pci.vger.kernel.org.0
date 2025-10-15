Return-Path: <linux-pci+bounces-38280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC57BE0ECB
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 00:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB98F352045
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 22:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EBAA305E2C;
	Wed, 15 Oct 2025 22:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NEHR4jDe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42202566E2
	for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 22:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760567136; cv=none; b=DGJ2V784Ex2SeM8RrfHE8gdeViGtFjpNgf/GOn8KC/fdA2b8eO18bUV7KnIkcg8mBQvSQwl3hc/Pc9go/0tfk+uwVPqbWWMVO25BRX3kt29lTXD17/iWP7ay641WrLppY1pHzrhnPEU0PNWp0UVmTIY0QqJUB5kkkZVdyKYHKCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760567136; c=relaxed/simple;
	bh=qeJHI8yoReSHxOQfeolEaKrMMwj1D4y2YcobkdfgeeQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i3c/mo7X+NLNeAis3ek9ogaQ5VvLHiDpsi6nTrnQ/WT9ZiShyuBFzplBvdfscYF0ctow8LE7Ose2l8v1ppHc+c7InkoYP9lgWVfY0Gdn/rVf5iBGxtjtKkubTnSvVbHZJD4zritcMzgddUBjxRmmYO64JKmrk67SucPhAquXhDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NEHR4jDe; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b553412a19bso21471a12.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Oct 2025 15:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760567134; x=1761171934; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xjoy4U6lwBVcJX4g7XgGN7qWhWge6KpG7ODmo44sqlE=;
        b=NEHR4jDeidKxLWqii5ozllIjq62HFf5lDyCCX8ytZ+WxVQacOeQhhfrXmXhenOEuvo
         19qLdU5bZ75ZUszWOBfO2KLxApujGgUw9iAyFGobAkXNoZcG8dkf/XA3LHRGe6d7obKi
         fJpVICx/tjWyBD+OemThUJCtfaB+wzkufdR/ZKG6sR3MANaW5hw/dfUCZS/uK09UiRtF
         mOYf7d2ss3oN5I622S3TBrUFpjD2FV9tsKCY/DtKCy7s0+8mmzIZh3y79+Rxf79qDp1g
         oPNi7z5XXDCr8q0aVCo7Nm+PXScTvywuIl72R9STtDFDYO+pwgCoz04vAcKlS9YYNmtW
         JDGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760567134; x=1761171934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xjoy4U6lwBVcJX4g7XgGN7qWhWge6KpG7ODmo44sqlE=;
        b=n3AmMJ1CYyCvskLIXCkR42/jK3mllpvEnLCdV7KpkpXWRP7hHLcIy+WwG4WeefJ/nX
         RVETeaKNqnimuV2q9SA8HHFAZ5u92XPafBo1VtS1wEivrz+BGr6x5X7e+3fR1/pEDTvK
         lU86qU5m2NjzM8qaZPZclIYRmMAIUgpcfBm//MxmqhxdmT/0mM6wO1Lh0gpkEHndhhP7
         qYR1PhBRKkyorZeeDyBf59zwP70Mgmy8lgumRvp/1n3uwYWurJnqfiyjiCp0+5l5igUi
         /uvi9lV+aOnXDc6FzRV1pzeF6xVFo2zMOqTdwxNtvxi6sVldZzfLkoTcwS/B5YO1UF7i
         lzmg==
X-Forwarded-Encrypted: i=1; AJvYcCU4WgThaF8MKm7j1liz/ps/0Ug2Q5wjnbKOkfpnoihmQetruid0k600ahLiM25iSqw3nd42Tu6QZSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJz3P2nImLR6jVkndc6jN+9qzlVKXpQYp0ASOc8fjjBjn3Ezsw
	H7zI7azBKodBnw55q0VvkSBrmGyxpvn8FdpoiPE4VJq51FzMRHuvXoGA+Khd06nhjpc=
X-Gm-Gg: ASbGncsQzMPiNDAu+YC0dAVmjC5CbvglqqBoYVv5McIlaRQp9ydLfUhkMdOMVyQ8RYu
	9++98V/fveBpCTfuXh00PE02hrHS6DHtz9oZwJ8EL+t+NOAnLXA5K7YUkLZiREOduRdVh3XI0hH
	v88XQw5VFdzea1mNgEbA2nZmvDoEgwaO20NiL8x0zZPC0oCq+gS7K3v0V8ZGhcX3o58sBkTRGQu
	HLiIujIBeroygXVexNDw4aPStfKJTvGnHvPncnf1MijqOJ9Iv4ou7SKtMYGY1mCXrEZ2JUCM26Y
	EJMpg6ZjDdvJqgWtij6h2vm0NaSYuCL9y8OlErsSojFkqUagelqSfTjgYmujHnU+y19QCqkRiYz
	Sx9ZOtbZnhQQvzYUyzzVQJmK/H0bFusxxWcrRlMNjIsrMQ2th+aBI4Q+tvp8x8DSEx3GrL3XlIH
	E=
X-Google-Smtp-Source: AGHT+IGKJ8ivTeBPRZBXe5CziPc9DVEnUB5DYs1OU0qo9FmUXxCbpxZLv8A1OWewK4vIo+s6JpgT3A==
X-Received: by 2002:a17:902:f641:b0:27e:edd9:576e with SMTP id d9443c01a7336-290273ef199mr345723695ad.30.1760567133788;
        Wed, 15 Oct 2025 15:25:33 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29099310394sm7228785ad.1.2025.10.15.15.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 15:25:33 -0700 (PDT)
Date: Thu, 16 Oct 2025 06:24:46 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Oliver Hartkopp <socketcan@hartkopp.net>, 
	Herve Codina <herve.codina@bootlin.com>, Christian Zigotzky <chzigotzky@xenosoft.de>, 
	Inochi Amaoto <inochiama@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: PCI/MSI: Boot issue on X86 Laptop 6.18-rc1
Message-ID: <6qtkyvywsz3p7ajhxonw4kvu7tivk3ka2fahab4o3jrttttjk4@nvjztgc6s7w5>
References: <8d6887a5-60bc-423c-8f7a-87b4ab739f6a@hartkopp.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d6887a5-60bc-423c-8f7a-87b4ab739f6a@hartkopp.net>

On Wed, Oct 15, 2025 at 09:05:11PM +0200, Oliver Hartkopp wrote:
> Hi all,
> 
> my Lenovo V17 Gen 2 (i7-1165G7) does not boot since commit
> 
> 54f45a30c0d0 ("PCI/MSI: Add startup/shutdown for per device domains")
> 
> from the beginning of the 6.18 merge window.
> 
> I've checked the discussion about the original patch "[PATCH v2 2/4]
> PCI/MSI: Add startup/shutdown for per device domains" here:
> 
> https://lore.kernel.org/all/qe23hkpdr6ui4mgjke2wp2pl3jmgcauzgrdxqq4olgrkbfy25d@avy6c6mg334s/
> 
> where a fix has been suggested (which was later applied) that doesn't help
> on my machine. So the Linus' latest tree 6.18.0-rc1-00017-g5a6f65d15025
> still does not work.
> 
> I was pretty lost when trying to follow the PCI quirk discussion about
> "[PPC] Boot problems after the pci-v6.18-changes" here:
> 
> https://lore.kernel.org/linux-pci/4rtktpyqgvmpyvars3w3gvbny56y4bayw52vwjc3my3q2hw3ew@onz4v2p2uh5i/T/#ma4425fd40ec041dcda2393a55bca5907887c2b52
> 
> Any idea how I can support you to make my machine boot again?
> 

Can you try the following patch?
https://lore.kernel.org/all/20251014014607.612586-1-inochiama@gmail.com

Regards,
Inochi

