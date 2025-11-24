Return-Path: <linux-pci+bounces-41992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D128AC828FA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 22:43:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7FE3AEA45
	for <lists+linux-pci@lfdr.de>; Mon, 24 Nov 2025 21:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8373B32ED4A;
	Mon, 24 Nov 2025 21:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt+myOlg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E18132ED24
	for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 21:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764020570; cv=none; b=R1HDIJLtwGGiHM5+EQKWwYOYUipMxH8R3xJ/c0KIOatqrVdm8iuY1X1zLnokhHSlEChDKALJ3D842CZynO9faZlBaud7kOHCuzD3+ZAvLCRRj3wOtl4ZEc5kSHqJBUDnFp0BRbxotpKKxzszZSqhGQtgJEqdM6TrHtUwiYnSE+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764020570; c=relaxed/simple;
	bh=zMEVRNWtaJhEk6cA0gcGBz/uzupVdTWSN726LtO0lvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qnwQIch5ZC1A3BlYJnbl3a+O1RlVUM295th3HO/xrzStKWqApeO+v5G+bL3g/83HTxV9UVvkt0vWP81cBnF89xHJ0Qmked0QdfPqFufoFUVVfRpye/DCqe+AHWF/K+nfZcjnwm35O6LQ9uAhCfc6Oukb6zL9pO/dhbYI9cDhIg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt+myOlg; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47789cd2083so28651225e9.2
        for <linux-pci@vger.kernel.org>; Mon, 24 Nov 2025 13:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764020565; x=1764625365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azjd/qcQrhADibLrfRmh6V9yy/7q2hObFD5GqSGj+Ao=;
        b=Jt+myOlgrJpKpEccYXnKuyWOoANrcHZ+GBemPK07AXRxyxkQmpC17iSXqlO9Zq1eXF
         uHfOvr6r/7suO/8yfTACYTtdOjGMjQGU3sw4RJGY3wGBnRfclVzS/Ao2f8dwTHf7MwaB
         FT3XPsCgj+ekI/1mhi+ZT9c8wowWL4mLZDIFzCH9PHIfkclAFjOsOrnsxsqgfKoJtlJo
         /IZywnF/U1TQniIQJkez1Xi34Q1npaeE75tqjk8BWwvZ0P+A/Y1K98yDuVONxDSeM176
         fn35rI3Qu0+Sfdn1k0p0Hw6UBQ17sT9Pcs8sY4OviIZpC1xtP7WvuraS5HlkFFSc+ZwW
         5CDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764020565; x=1764625365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=azjd/qcQrhADibLrfRmh6V9yy/7q2hObFD5GqSGj+Ao=;
        b=Mq2DMWGm8RXmthgfp3+K7I8SL/VjlbursiFGNQGL1/W888lITijq8N7xItpXZeiBIX
         bW+ezggOMCpFkZ+KDRRVrjqnnJmnGodaPJ6vP2gPQ1mLipgGK9aVxmZGcyQqrAZLc51Y
         fuGvE3ZIrinxfXn/XaB/7Di3FHEpAsPfZafByM4VN/Zy3+6+sBcd/2pPJDI1IL6FI9bs
         0VMEjhI3y0S3bArKVHgFbwuZyIxshbMwClYeGz1S1JgntwKKHXfo8cryEqcAopeW+8aI
         S5RmJHMkKiUhsYp6LdLyR5LOph84pAeZNb8RK8+w/S/0pE98Rmye3VCf3OjtJ3xruKoo
         S4+w==
X-Forwarded-Encrypted: i=1; AJvYcCVZDhVWb6zQ6p9u5Svlu7SmUMahfyuLZozWjnOX9tvn0BDXHBb898nzf4ukkLxzDqL4sKREs1g+cIs=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp6qKfGbv2tNZjJk+3tARhoFab7VGAriAQ57y3e13qWHHEOr2c
	zj79ES+SzQFmOq9KBAkkoQDG68wrL4+mo3icP7GrQmnjbTWr+uZGtLSLFRZtJg==
X-Gm-Gg: ASbGncuDBTQhB6Kkp8O9s1l4eDvVyqV2LGGKS2uA381OMMVAvMUT9RvVfxE8ANtss3w
	/jaOh6Ku2Y3tMfGqimWeGYxCS7ZuUel6eWM2mYy5rjkDgh+eboIfESCBfjk5boH+jv9JgW7gTB5
	WRleaypXzHWfv2IKDWTz+/D9K4nvb+3vi97cMsOuynFyRSFucHwp8y+2t9HcjEVx0d83UOmguhh
	V17Tn9qGoynYglKvzp2kU6BKiad2b4Kc7L6l86/EGxnRNC3B9dJH/tL/hLcQBB5BQaWBC+buAwv
	3y6Za3JhNl3YwYyuucGqR7Bn+I6Rnt4rAhcWaTtwiDSc88Xc64N/ZkOJPW9dzMPOLeSqlvnsExo
	rwo8Aix9Db/Rsr9Aj71THdV7zyk/nkcP9jpocy2lyDj6cdanqdS86KmPsw7uiyrOhZbCPf0qrn2
	NFN1LFMMZFgPalembwuXuI3W7uPrvdCpvZVI+jJU1hDdjKRfVqohWk
X-Google-Smtp-Source: AGHT+IHTxSaOa2kt5YN5WfOGej0F6r+Gi9WzebbEtWvfagNddB3Q4SQPDmMcUntu1xCWwGqExiBVFA==
X-Received: by 2002:a05:600c:a07:b0:477:a3d1:aafb with SMTP id 5b1f17b1804b1-477c115c657mr131509575e9.29.1764020564694;
        Mon, 24 Nov 2025 13:42:44 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm30419112f8f.33.2025.11.24.13.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 13:42:44 -0800 (PST)
Date: Mon, 24 Nov 2025 21:42:40 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, Bjorn Helgaas
 <bhelgaas@google.com>
Subject: Re: [PATCH 25/44] drivers/pci: use min() instead of min_t()
Message-ID: <20251124214240.03af61f9@pumpkin>
In-Reply-To: <20251124210410.GA2708124@bhelgaas>
References: <20251119224140.8616-26-david.laight.linux@gmail.com>
	<20251124210410.GA2708124@bhelgaas>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Nov 2025 15:04:10 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Nov 19, 2025 at 10:41:21PM +0000, david.laight.linux@gmail.com wrote:
> > From: David Laight <david.laight.linux@gmail.com>
> > 
> > min_t(unsigned int, a, b) casts an 'unsigned long' to 'unsigned int'.
> > Use min(a, b) instead as it promotes any 'unsigned int' to 'unsigned long'
> > and so cannot discard significant bits.
> > 
> > In this case although pci_hotplug_bus_size is 'long' it is constrained
> > to be <= 255.
> > 
> > Detected by an extra check added to min_t().  
> 
> I don't mind applying this, but it sure would be nice to have a hint
> at the max() and max_t() definitions about when and why to prefer one
> over the other.

When I've sorted out local commits for all the other 400 files I've
had to change to get allmodconfig to build I'm going to look at
minmax.h and checkpatch.pl.

The current bit in checkpatch that suggests transforming
	min(a, (type)b) => min_t(type, a, b)
isn't even a good idea.
The latter is min((type)a, (type)b) - which isn't the same.
at least in with min(a, (type)b)) the truncation is obvious.

I think I'll try to get checkpatch to reject min_t(u8|s8|u16|s16, ...
outright - remember the values get promoted the 'int'.
Unless the code is doing something really obscure they can all be
replaced with a plain min().

Then get minmax.h to reject u8 casts when one of the values is 255
(and u16 casts with 65535) - particularly for clamp_t().
That will error a small number of files - but only a handful.

I need to find the #if that is set for a W=1 build so that I can 'error'
more of the 'dodgy' cases.
That might include all the u8|s8|u16|s16 ones.

But I'll have to leave all the u32 casts of u64 values (on 64bit) for later
(they are typically u32 and size_t).
I've not yet looked for u32 casts of u64 values (long v long long) on 32bit.
I suspect there are some real bugs there.
Maybe I'll try to get them into the W=2 build no one does :-)

I'm retired, need to find something to do ...
(apart from getting to PoGo level 80)

	David

