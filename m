Return-Path: <linux-pci+bounces-30643-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E59CAE8E61
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:18:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 118301C20878
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 19:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E6B2DCC0D;
	Wed, 25 Jun 2025 19:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m44wtbqB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E01C2DCBEC;
	Wed, 25 Jun 2025 19:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750879083; cv=none; b=hcOoumqqkV4o16ifFa2oYjDZFhjv4Lx5QFcRYlCgKf6RhzBV1wXe/xjLH5PvIgUFz0X8swp4zhrikRgm/7nT+7ofxSCdfONGFh3W75K9yaw57EiSFah2/h5YvnQsnv6YVTeliox5wydbW2zBu0yfnNJ9k8Gkl+z7obLVxqF9ACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750879083; c=relaxed/simple;
	bh=r4Jd7amZN0Y++n+cxyUCk6FX3dy8XmJ4WfVyH1KUlkA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=j18ue/pHJwjPwbgwbVBKzUNQSryvhtLCNEEn4kXXk4b98T+STS+xOC/15PwqUy9Ba9O3zdhimC95/fFtA2x+dy8VA7iW7Yv6msE7hq+VwVP8a9DgComEZ1WjHT4I6PYBxlG/iw00qBURCOrKGpqI6j7/ODYydJ0GzCLeRvR6xFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m44wtbqB; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-e81a7d90835so142787276.1;
        Wed, 25 Jun 2025 12:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750879081; x=1751483881; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8403cEKgjhhrx1TsMbshffovgr9tyzdkU6aIUKCINXk=;
        b=m44wtbqBw0uy6VANJ3KUvIvNX7iepvodFICO/5pfl2w0VQfw3M3o1mXQS+/DDpeK/U
         n1lofqIlDJtS1YVdF1Sacu7jAU2P2aq+bO+muHRa5qIt/qnYaqviwTaWB5J3U2vplUAa
         hjrAIKza4AKDc0XgOK3zHc+Gy++7rmhnP95nF80rbLZC9gnu6Vy+8fbnn+DTxiXLBsd/
         u8DW3XVB0VHU+x3lDmNZv99Ds3Mt+6OpGDdLRaJCr9//61eu14LO/qtcGhNTSFleCsgX
         ySJzklpTwBa2k1ZWjInTNsoQRR1qzgh0N3T1OjSFdXePTKhpu1eULijXTo/3vv3gyhCb
         kocg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750879081; x=1751483881;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8403cEKgjhhrx1TsMbshffovgr9tyzdkU6aIUKCINXk=;
        b=AMwDsz3ONkw5HKlvJkfESOCTQ9fWRoJZLga+YD77CwAT5jDqn5vnOACE/i3toJiY8A
         Pk3CfgFbVoFeik1WU+xp9hH27VgY6Hp3TtDNKLEQs6mROXOxLTl5nZICMWGWIJskxBqT
         wZeUDQ2kCKRweojuw56S2R3n/UTP5AYIHEkNXcN/qqN00Rxu+8ErLOgMY8WG7zgnUQJH
         8vXP1Ce2COYSCi25YT/9HYc4Dcm1i0/nvTXQmPTlfslTWe7cLvwIkxOdHAKjwEcD4plS
         9wt3/YRGMYiz7XPsVqkGQZJC1uO5npuxIKOT3H6wsI73LlNG4Sim5OZ9mZMaqm323SE1
         ntCg==
X-Forwarded-Encrypted: i=1; AJvYcCUTjA0ALMi7Cf55s4CNlS0r9N6Ts5jHEe5qtiTPCLWpnNsfkOOT3+WH55/xYIZsW5snhcsoV5me4po0rOBPH4A=@vger.kernel.org, AJvYcCUq1XR6ilcySY5g9NkT+e71Aa4Vhea9+53V64OeAeerrywdda000Mhk3ixGsiWFlgq620UxkLOKk89B@vger.kernel.org, AJvYcCXdxQa7qbRTeaHBKGEHUxBlomRUlRzecCRD/3we9p3h/tCqBqaLLtXPxP7jjgdWMwG9VmkrFRuG@vger.kernel.org
X-Gm-Message-State: AOJu0YxgcCbR/i7niaHtyIrc0v8kQJyUiaLyQ4s80KYJf/F3OFQY7wx7
	bpEyFV2VHKc87cHCDGnTgcYni81J0ZWwoCEiO4mMGK1HT8NIl0WPyJWMitqTUuhiPVTEE8NeAgl
	zYhJhvzLWQtS1dX9E7NyMj8OG7ryuWxhf5jJvVMU=
X-Gm-Gg: ASbGncs+PJLp/g4mI0j63NMQN/C3G+2bPjiqlnNzBEgVxLziciA9QxsPLwQ3qFfgitO
	kwjqOVJKubi2iBsYrPLNse9zQQHQaOFYlAqPo6aUfJU/eh2nZzwgzcYP09ryC2iG/SGtFGmxg1s
	BZmp+jYfmvT/Qx/smeTDwIUEoKZPPjH/uQMP2ztABEL2il0Q==
X-Google-Smtp-Source: AGHT+IEBJ1HQs0iJN6i2v3yoEYIATq1lJulVqezGwirJwda+5IVis0IKTmDBeXLkkfhMuPo/Gu6h1RQpTOE45CdVKtA=
X-Received: by 2002:a05:690c:3804:b0:714:13:357a with SMTP id
 00721157ae682-71406db2354mr62440497b3.20.1750879080340; Wed, 25 Jun 2025
 12:18:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Bandhan Pramanik <bandhanpramanik06.foss@gmail.com>
Date: Thu, 26 Jun 2025 00:47:49 +0530
X-Gm-Features: AX0GCFvRn0BDXlBswPH6d5ky9QP8oDFSJMjA4U3BLjHSMHUHJF7QbU0sAtdUwJ4
Message-ID: <CAEmM+Qi-Waxk5qcR+nfip-QGXaKk0-Kq7QSq890e9oYOPjW+bA@mail.gmail.com>
Subject: Instability in ALL stable and LTS distro kernels (IRQ #16 being
 disabled, PCIe bus errors, ath10k_pci) in Dell Inspiron 5567
To: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Cc: ath10k@lists.infradead.org, linux-wireless@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

The following is the original thread, where a bug was reported to the
linux-wireless and ath10k mailing lists. The specific bug has been
detailed clearly here.

https://lore.kernel.org/linux-wireless/690B1DB2-C9DC-4FAD-8063-4CED659B1701@gmail.com/T/#t

There is also a Bugzilla report by me, which was opened later:
https://bugzilla.kernel.org/show_bug.cgi?id=220264

As stated, it is highly encouraged to check out all the logs,
especially the line of IRQ #16 in /proc/interrupts.

Here is where all the logs are:
https://gist.github.com/BandhanPramanik/ddb0cb23eca03ca2ea43a1d832a16180
(these logs are taken from an Arch liveboot)

On my daily driver, I found these on my IRQ #16:

  16:     173210          0          0          0 IR-IO-APIC
16-fasteoi   i2c_designware.0, idma64.0, i801_smbus

The fixes stated on the Reddit post for this Wi-Fi card didn't quite
work. (But git-cloning the firmware files did give me some more time
to have stable internet)

This time, I had to go for the GRUB kernel parameters.

Right now, I'm using "irqpoll" to curb the errors caused.
"intel_iommu=off" did not work, and the Wi-Fi was constantly crashing
even then. Did not try out "pci=noaer" this time.

If it's of any concern, there is a very weird error in Chromium-based
browsers which has only happened after I started using irqpoll. When I
Google something, the background of the individual result boxes shows
as pure black, while the surrounding space is the usual
greyish-blackish, like we see in Dark Mode. Here is a picture of the
exact thing I'm experiencing: https://files.catbox.moe/mjew6g.png

If you notice anything in my logs/bug reports, please let me know.
(Because it seems like Wi-Fi errors are just a red herring, there are
some ACPI or PCIe-related errors in the computers of this model - just
a naive speculation, though.)

Thanking you,
Bandhan Pramanik

