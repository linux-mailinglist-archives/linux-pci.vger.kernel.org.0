Return-Path: <linux-pci+bounces-18390-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 930DC9F10A8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 16:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CF751881341
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:17:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B71751E102E;
	Fri, 13 Dec 2024 15:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncG9MPA5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55F121DE4FF;
	Fri, 13 Dec 2024 15:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734103041; cv=none; b=Q+GborPhhdahGJqLadeFmt3RnMB0GJC7pZYk50wPFP3f2tOyKovD6CQUKEt/3YYetHl5Of6f/Sy8o3YOii600yw/5cYHT5vYOV9pyj4QbwZMT7iHYtot9Rkf52a1zuItWLsw6GROjrOWd4xAcKolEXgsIhiuOes1WHOBnj43Dbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734103041; c=relaxed/simple;
	bh=vU2lwiJ0NU8bPtYkBRMPIXY4l6NNjiChHDMI7SgQBo4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z9fbsmGwG2Jkhba25rVZF2fDwbJEh3vQe5eFNbJblrVFVp+MaIGg+ipFLrGbqpVbYZwoV/69q4Mg1re+kDyDBSdLZMCHFIaupaisjq35actHBijMluSeM2heKTSM7E9FzSjZQt0YRjiK8Zu0S2b3UHWPd7QSKrKU/OUvCMpN7UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ncG9MPA5; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-728e1799d95so2254316b3a.2;
        Fri, 13 Dec 2024 07:17:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734103039; x=1734707839; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=snR0l35al56QxuLvp2av1CppmOJ19UO4yxrssrqk870=;
        b=ncG9MPA5rSsNNeQhxTfX/uSF6fdeZC751XLDB8+pPM8CCR50At5GQ5OZPtkQevB1dO
         XU/OMnftux82c7uBZrVeOCt2/fHlwoSLR2pNMGYhBXzCwKvuwJpNXJtpVUBg/D4G0llW
         H/v9Sgdp4Qz0WYWqb73RTBDWRPlqV4N8osANfeunMvbZlG/0JnK9ZQqcL+xdqq6e0deM
         I8G5mSZueMotKChJr1tUeLZPccWN75O0jn1whtiV/yiRyOEwRnqzvXRbKOYtUeHef+h/
         IL46cv1JAOEjO/+MJ50dGTbwut3fG3agCKN6evpBp3iOLeTV4+CYPQxMbyYECB0pe0zZ
         gdng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734103039; x=1734707839;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=snR0l35al56QxuLvp2av1CppmOJ19UO4yxrssrqk870=;
        b=dr+XHiqMgSxl84rJTceo9lFL7c85oFopt/7DCxT8JwOXBwdBUliPrAcM4Fin50myxa
         IVpW1Zv9IduRiCAb2dK32a7co3TejhlheRBZk7gGCLA1RM+NloqNmInJKqMYbicNSMiT
         lzhoWihc4S5P9ypx3PRXdCDng7ud/QBPIlEiScAhmleZryS6uhsojopVWH5duTtozRY2
         1vOXqhy8lkZqhfuAnO5R12LwTIWq/S2yxHWbw2xoQ22HwdIWu/VjcqfTUyNzdhLF0hrQ
         INlV9STJuivfFNEsaZN2L84fFy9WSI33YticYTLyKjJ+MUuYqFSVIQ/3KQtsOw89EF1k
         4+lA==
X-Forwarded-Encrypted: i=1; AJvYcCUQcYOkZkSSfKQy31DoZ56mycXM9xLWlHkpOpufvroxN5jsDNgGfy8atcdMn98YC++PCr6+DTo3PO6M@vger.kernel.org, AJvYcCVC/pRkXRPBIEiiaWcPekkq5QyfAGbkU/q+O4wRRn3mzhAqLv8HiQbZmRBtzTfnTOZE/4/pFw6auU+BVhI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIDPllQ5zpIcMNmmRx+4bjTiq84RPZDBFxXKt2hUV93d+MpRjx
	3uG84wHzC51o/WVLTaQLGIFKFV6U1PmpriNgANBn+TQCCI2LyGDU
X-Gm-Gg: ASbGncujJYsNhN2rVRe6sh69wniJWAWQUVisbog0CZguwjDcoU0vLpPfYY317/EkkSw
	x23FMEyiIlWA+3Dvc8vGExJShgNWm19SNuwLduIGEQlx6y8AVAZvqGtHB8N3QvHQsshu0W7di36
	xeE46eZDnznWWhweAQ41c5bLH5TmJDEbdm9zJK4xn8zoi03Y/A8wbmIH8zYq4ISNfWqC1WuSQqR
	YHe8heVDJu66LBVhT8KqERLa+WVcRoLs7p+BYZyEXyrtxA2Sj+ZNZ/mhkyPgFg=
X-Google-Smtp-Source: AGHT+IFVn+GJ2jRCHXJc1gz5c06gb9eKcTyAu/jHztOJDnMg44onAa/qQA2fWJHRzF6EmHGntPmbLQ==
X-Received: by 2002:a05:6a20:9f96:b0:1e0:f05b:e727 with SMTP id adf61e73a8af0-1e1dfc09e7cmr4467502637.2.1734103039386;
        Fri, 13 Dec 2024 07:17:19 -0800 (PST)
Received: from linuxsimoes.. ([177.21.143.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725c64272d2sm12588673b3a.145.2024.12.13.07.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 07:17:19 -0800 (PST)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: helgaas@kernel.org
Cc: bhelgaas@google.com,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	namcao@linutronix.de,
	ngn@ngn.tf,
	scott@spiteful.org,
	trintaeoitogc@gmail.com
Subject: Re: [RESEND PATCH] PCI: remove already resolved TODO
Date: Fri, 13 Dec 2024 12:17:10 -0300
Message-Id: <20241213151710.805485-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241212163629.GA3346193@bhelgaas>
References: <20241212163629.GA3346193@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bjorn Helgaas <helgaas@kernel.org> wrote:
> I see a test and call for .get_power() and .set_power(), but no actual
> implementations, so I think they can be removed as well, can't they?
> If so, I'll wait for that removal before applying this patch.
You are right. Both only have a check if exist the {g|s}et_power(), then this
is called.
But, as you already said, seems that really don't have a implementations for
both. So, I can work on remove this fields an tests this.  

In the cpci_hotplug.h we can crate a `flags` field in `cpci_hp_controller_ops`
struct, in addition of remove the {g|s}et_power(). In the cpci_hotplug_core.c
that the cpci_hp_controller_ops struct is in use, maybe we can create a #define
SLOT_ENABLED 0x00000001, and we can do `ops->flags |= ENABLED_SLOT` when we
need enable the slot in the enable_slot() function and `ops->flags &=
~ENABLE_SLOT` in the disable_slot() function. In the get_power() function we
only need return `ops->flags & SLOT_ENABLED`.
what do you think?

> In
> https://lore.kernel.org/r/20241014131917.324667-1-trintaeoitogc@gmail.com,
> you capitalized your names.  What's your preference?  I'd like to use
> your name correctly and consistently.
I make mistake, sorry for this. In the next commit I will send with my name
capitalized. 

