Return-Path: <linux-pci+bounces-20026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1704AA1485D
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 03:52:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726513A9851
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2025 02:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E01DE4F9;
	Fri, 17 Jan 2025 02:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Qc1uBM6j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1EB17084F
	for <linux-pci@vger.kernel.org>; Fri, 17 Jan 2025 02:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737082319; cv=none; b=lpbvBDqF/GnaaXocIaxJeZFZIpUYUR8FupAR5hjkcHQso2fXRaZ6cYoJTzjdRXtq5jznaq9HwJ3zUyGLX5szMGW1U4l72+M9i16E3oWK/181RbFCnrJVJvuUNeaFu37k3uuZs6QBuF97CQnc99kfa2s6WSrBGRSa5L1LDQU9Cu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737082319; c=relaxed/simple;
	bh=GlXugIQp6WJ2PxP0qElQk+LyISfmltufC3bBjrtcRs0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4CXBJ14j6+1+Yi6PHTCcQ9fSuihcWUKbBZDMSYLYrOTXa35gGJfzvtEG3vnH8I+zTSDVH7gu5g4BPIxQ8eeZ/uTcOZU8vrDq8YyQar5LKVJQtP0WhQjfo+tMmwMnaktoq37v6h7H9C4lCBGfZRnNbZL32MTEOV/j+h+Z4OvwjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Qc1uBM6j; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-aaecf50578eso346079766b.2
        for <linux-pci@vger.kernel.org>; Thu, 16 Jan 2025 18:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737082316; x=1737687116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlXugIQp6WJ2PxP0qElQk+LyISfmltufC3bBjrtcRs0=;
        b=Qc1uBM6jJN7z3+ja04VIV53kdu9+1heKZvJz8BnJOxMkL8+G/jjWKKaChlEzWWqsqB
         MsbIcmwDy0nsX9G9ORkCZi3KhpGV9ZDNpxqpNMk73aOu+W4X1QTWpP/5S8HQcqqaWM+w
         1OnrIi3EXizCndTLuEugI0pFGf1GnG8WhO72voqQJgu31uVVnh5bZNoJ+szx9qqWPccT
         6PTwCvDvud/PuMyC9VpENdTFpYoClvRRzOm544Wa/Dr5SUXNeOzEZGPf5kF5tESAJfAD
         SGij+IoZVpnCeISdYHiuXaYf01dEAv1u0tE90w7o9/sgz96IP01erXlOJCn61r7BKgO1
         FXtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737082316; x=1737687116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GlXugIQp6WJ2PxP0qElQk+LyISfmltufC3bBjrtcRs0=;
        b=aWvBFtVF5mLYUKS1D2Ri9t+hJB7B44D7rb20pfTHCwzUQV9ITsC6ZGmz+JRXJRI8X/
         T/vCq5We++QoE3ZaLGBDm8aygTXhfywnLSQqtYuIA+LgtRpD35kgNU6nx94graRe3WTI
         5qTCIXBRJ6UxRMPkYwFW3wEY1aI8PLfy67kwDLl2IaBisdnuCjp9in1mcLSiF/6GYMrf
         dlZXeBseSbs2gO2uCnhzBu8rZvXAXLIpLRswL/ukVOWTAfO6Vll6+3JEFmFGVsRvUVai
         MXZUSpyb6QjAl1/i9fsIo/UHBHwLuU7b5Bl7/4WL6uYpdMelFS/QfPSiKhS92XMCAtlT
         VEPA==
X-Forwarded-Encrypted: i=1; AJvYcCXQxmvXOO9rDlHjwsfDd/Nixx9g1X3BPf7ltdFgj2bOsXbHbMgjJwwqqi63CNP/Jh/3gXSwdslSEYk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn7xE4P6EA6YeTo7mckmUDCYmvkWP5SEU404L1D/Ump94kPhfo
	t3FkzvgfmwVeHuMH/e5GcJo6a+VYpNhcFvUA0e31AjZYlXoB1XkKKGooByzMXcL+21rj45GcfSR
	YIDyOl1AGcUnuirei3D6gjn7KqC88l/7WXONi
X-Gm-Gg: ASbGnct3degOeeRac+8OVTufkXPc8OrfrOCmR4TcoygmSHzMMi+mqdcjyL+fipEsqVs
	MUh6p6U6JUO9R7FJTMdR2IHaYfXFgplzGugF/5rFjTmc+Ox++apUeI3drY49LGVy65Hg=
X-Google-Smtp-Source: AGHT+IEf4Vaa3C/EW4lUJUC4dWGK68YcuOkmusTZL78zroc0nSR1PDByNx3AeuIeSaO5ICppzrFCteEtXbJsWcU5i/M=
X-Received: by 2002:a17:906:dc8c:b0:ab2:debf:8992 with SMTP id
 a640c23a62f3a-ab38b3d5ecamr108573366b.50.1737082316333; Thu, 16 Jan 2025
 18:51:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1736341506.git.karolina.stolarek@oracle.com>
 <20250115075553.3518103-1-pandoh@google.com> <8be04d4f-c9e8-4ed2-bf6a-3550d51eb972@oracle.com>
In-Reply-To: <8be04d4f-c9e8-4ed2-bf6a-3550d51eb972@oracle.com>
From: Jon Pan-Doh <pandoh@google.com>
Date: Thu, 16 Jan 2025 18:51:45 -0800
X-Gm-Features: AbW1kvZkWhLjSY2C1EMu8jXzK1uCzLs0l0i2BHfvHrws5mMplo8hG9MZnR4RVVI
Message-ID: <CAMC_AXXvTgEaMSBsmr_eS7=8gCcmn5ep3f88kc=SjfmsRvNQYQ@mail.gmail.com>
Subject: Re: [PATCH RESEND 0/4] Rate limit reporting of Correctable Errors
To: Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: ben.fuller@oracle.com, bhelgaas@google.com, linux-pci@vger.kernel.org, 
	martin.petersen@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 15, 2025 at 6:18=E2=80=AFAM Karolina Stolarek
<karolina.stolarek@oracle.com> wrote:
> Feel free to incorporate the 1/4 patch into your series. I plan to do a
> proper review tomorrow.

Ack.

> Out of curiosity, do your patches apply to cleanly to pci/err and/or
> pci-next branches? From what I can see, "PCI: Consolidate TLP Log
> reading and printing" series[1] had been just merged, so there could be
> conflicts.

Good catch. I rebased off of Linus' master branch so it's unlikely to
be clean. I'll rebase off of pci-next in the next version.

Thanks,
Jon

