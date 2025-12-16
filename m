Return-Path: <linux-pci+bounces-43070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7957ECC0624
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 01:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 836783014118
	for <lists+linux-pci@lfdr.de>; Tue, 16 Dec 2025 00:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A848E3B1B3;
	Tue, 16 Dec 2025 00:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TE03njbb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219072DF68
	for <linux-pci@vger.kernel.org>; Tue, 16 Dec 2025 00:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765846492; cv=none; b=Ry7UjxeVQpSIhxaPeRewWdGZHbfa+KX81CVWu3FZEybN2DjyM5cuxAYumU+Qs0U4KgK2iwox6jrlP6K+nO2zaRAJU/W8/9Dm0mymUKCh7acNTwUN2BA5e4G8xjLC9OBqceUVX14gR1yMPSiB+0X/SeLf18PbhT3xVG/qjdgHFv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765846492; c=relaxed/simple;
	bh=Zp3LVoQGqhCuciLMYb1NTjbULyVlauJWW4qhU4UobKg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=F1OIybhKxrnA8WTJra/0yKX0vXOsADqawIWd+aUUjaTSw3v+8FmgjrqQSSX6ebnPOW72qgI9HJyUQUTZuoB5vHS5VYyLtm4wzegYwfZL2i7hD92erbgqBWz2Uk7FPHt4c71zAnIqfnmVarRz6UcZgYl+mogMAVqrJBiF7s/qxXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TE03njbb; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8b2627269d5so412350185a.2
        for <linux-pci@vger.kernel.org>; Mon, 15 Dec 2025 16:54:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765846489; x=1766451289; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cN60CPknruvImi7D36lxZ9ebhSHEOAt45uyBFYcamSg=;
        b=TE03njbbzId7Cn2NpT/xlXswALK6wypv1/ScMYlti2Ufpx8WJAvYXfsZJUCuQ3cRy6
         XkQVI9tcjmFh0pp3ifbP6aBpYIv04B7q4fob2qp9BwAKQOR0Y19HUDgGLbwInSGPA95u
         cQYbmhbohaMhnIVGiVpso3IFoeKK6lYdVN8XC1wO1IlC0AmYWtKOh2RgMucF41PWuJLm
         +1p2HrhuypIFlDcS0jeKek93N4t3bB/0WlvaITNQf2rzTA/LY8sNMFS4oBFoPWC3srZx
         e8Xl4uo640A8Z+B2sunJ4GsxzkrouJnPlGWpplK4rs1fIHvwBHQNbnQVxl/bPpnK5hsF
         01dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765846489; x=1766451289;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cN60CPknruvImi7D36lxZ9ebhSHEOAt45uyBFYcamSg=;
        b=jG+z7t2Bn9MFSlh2yzb1Um8qF1/fLrWMoji3XYpbCJwaAOK1zzHf62Mtd544qp2Izw
         vHbg0u0r16RlghB91X5VmKvlQnXcAuuhchNy2nogFjv7z56FhVutUSwphQdBsCsy6hHs
         nna9OuDbfIdJRMtn83CN9a2mQlDZI/Avdc7vWmst+KUnJLryRNm7FtihYpZJykNfWkCg
         eFcw8hHcJwG/anynpoxCaN/98SfHUkjNZDuNZU5i2jRmWSz9wVXbd993pmdWm7DsX6ug
         gD/QGiCwTu+BMOl3nK2UbT7PQqUYrI9P36QSynq8QakUD26pRijQVgQjGvrPPTJFBTll
         /KtQ==
X-Gm-Message-State: AOJu0YxFWcaQKHNCr2k4Ok3ZLpSoKuu/R8QkT9otLQGB0BoisRF4RRRh
	nLnTGqqNHBSsDoPFY/8Y12HjITBbgJbgAkA2E9e4u8JtsNR8IPHf3bqz3CIaqA==
X-Gm-Gg: AY/fxX77vyc6XBb5+ylL5tr8SKxDa6wo+kM8WEglQEfVDDWk8kbBPKhYPBn75WQ2Fnb
	x3Xn72o/XDkBEe8blHTyhSyjsnbLeZ1/e/hiQY2N09AJuUGPVWFN0H5E87ZNBGUw33iMjJY/yl0
	+kKd7oS+GhXoF8SSezR8vvX+kgC9IgR4iXGp3oL50T2mUNCpNawSKHpKNkXjicWAsDr+pomf+jY
	h2j3lDBANnpOIahO1CQh3/BOfTP1dtgymNCquJvJdX+9JgWLDoz1KZ9IOJCPZF+qRt/ogWTKCee
	lJ6Fpe/9yXgIgRV3Fq6hytkL9cRf/BGzWBSkxZVxYo9Zs5tqL4gqUH5uGfinUvC9YWElpP5C6hZ
	iBuK3My6BGQK21ont6Lm6CslDsfuOhNEd6Vbkjv1P9cYwzeh7A+iAtNvXgyH6DaY98Cm9zkbWzy
	RV0yiddHPoIV1DndzT1wocT/MPTXdiFxbyVADnBv6kuptjVUAWtUudIXpSpRtwazo=
X-Google-Smtp-Source: AGHT+IFJmPCllxyvP4bwrSt7wGM8mW9MVqnGLqc7xboFj/lLbvtJmheubFIgt6eNqFCUukkDfcdL7g==
X-Received: by 2002:a05:620a:444d:b0:8b2:e5da:d302 with SMTP id af79cd13be357-8bb399dc119mr1734994785a.18.1765846488913;
        Mon, 15 Dec 2025 16:54:48 -0800 (PST)
Received: from eggsbenedict (ip-74-215-254-164.dynamic.fuse.net. [74.215.254.164])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8be30e986cesm70948585a.24.2025.12.15.16.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 16:54:48 -0800 (PST)
Date: Mon, 15 Dec 2025 19:54:46 -0500
From: Adam Stylinski <kungfujesus06@gmail.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com
Subject: Kernel regression in 6.13
Message-ID: <aUCt1tHhm_-XIVvi@eggsbenedict>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/2.2.14 (2025-02-20)

Hello,

I seem to be encountering a regression that prevents my system from booting.  The regression occurred between 6.12 and 6.13.  I've bisected it to this commit:
665745f274870c921020f610e2c99a3b1613519b

Some info about this system: it's ancient. It's a Q9650 that I used as a mythbackend/frontend for over a decade. This booting failure on newer kernels finally forced my hand to buy new a "new" PCI Express based tuner and upgrade the system into the modern age. It boots via MBR on a P45 based chipset (A P5Q Plus board, to be precise).  Given the age, I chalked the issue up to possibly some failing hardware or memory corruption that happened at compile time. I recently pulled the system back out again to do some performance testing in zlib-ng only to find out it hangs on the latest Ubuntu server ISO. I figured at this point it wasn't something specific to my kernel config / compilation and it's likely a regression. It's also old enough that I may be in the position of the only one having this problem, so I took it upon myself to bisect what was going on. Let me know if there's anything you'd like me to test or try.

