Return-Path: <linux-pci+bounces-33507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C8AB1D13E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 05:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0546016C8A2
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 03:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A2D4199939;
	Thu,  7 Aug 2025 03:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b="t0kUy8eZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from server-vie001.gnuweeb.org (server-vie001.gnuweeb.org [89.58.62.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA311E4AB;
	Thu,  7 Aug 2025 03:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.62.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754537658; cv=none; b=FemAeZHG0XF5Z17LEyi3CUjVURvAKV1FeywIE0nxX4ZFvqsX6btlJn2OhmUC15eXLaWiNjLY8JLD9yB4T9B6h3TnIWwiSgzi9lewSZcwaXpOT+Kj/VTGqUoMz1URioppwartJ3F3575Nhj1Piy6/Ap72oA3vbhN+OgS5SQzBDmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754537658; c=relaxed/simple;
	bh=qdWaCy0abPzHN3lj3EK5At1AD7+aS1u6F/ouw5ILBUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBMPHURbbAIoUGaWu/itAQy4Um7ji5lpUCcBoLf6pYscrB3ZzuQqsikXOCw1dNH91AFhK3SvezH8utzFYrxI5IBUNBK+Y1gsD75eGDqJfUUDHFPIQ9x9PlrfJiR+/JDIUlCWVR867owE5Ztg+KpmXsyOj1pdVTQZPzBzCet4tnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org; spf=pass smtp.mailfrom=gnuweeb.org; dkim=pass (2048-bit key) header.d=gnuweeb.org header.i=@gnuweeb.org header.b=t0kUy8eZ; arc=none smtp.client-ip=89.58.62.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gnuweeb.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gnuweeb.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gnuweeb.org;
	s=new2025; t=1754537654;
	bh=qdWaCy0abPzHN3lj3EK5At1AD7+aS1u6F/ouw5ILBUI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Message-ID:Date:From:
	 Reply-To:Subject:To:Cc:In-Reply-To:References:Resent-Date:
	 Resent-From:Resent-To:Resent-Cc:User-Agent:Content-Type:
	 Content-Transfer-Encoding;
	b=t0kUy8eZII1CPvd/McQ51xwqysCOW5D4QM8e0XMRCzRHWv6L23/z9ImvqgO4ZCYAZ
	 ZRNCv0Zv4NFM/FcOsUOiucttgpXMA4KASBXqme2Q6OGC9H4iA6pAtfPnolnDtaX3T1
	 7Z8G1k8ewm37xZipEhgwnZ8vUGoK6t23IneSeKrHHTCl68lsDQvUH+AQodrbKijQog
	 Bh07EF0dZtJUO3txN1zQCp4lrX/AUrblEf4qwm78sqDrkt11BtMpyzhrKqF3RH66Ee
	 E7q7cA6iIweCwOOyRZBZJx3RR8l770l105zj6ANM6ocC9+3RcgJQKCFEOq+ww7cB1p
	 sdABxOwpl8Cgg==
Received: from integral2.. (unknown [182.253.126.227])
	by server-vie001.gnuweeb.org (Postfix) with ESMTPSA id AE4F23127C57;
	Thu,  7 Aug 2025 03:34:11 +0000 (UTC)
From: Ammar Faizi <ammarfaizi2@gnuweeb.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Linux PCI Mailing List <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>,
	Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
	gwml@vger.gnuweeb.org
Subject: Re: [GIT PULL v2] PCI changes for v6.17
X-Gw-Bpl: wU/cy49Bu1yAPm0bW2qiliFUIEVf+EkEatAboK6pk2H2LSy2bfWlPAiP3YIeQ5aElNkQEhTV9Q==
Date: Thu,  7 Aug 2025 10:34:08 +0700
Message-Id: <ed53280ed15d1140700b96cca2734bf327ee92539e5eb68e80f5bbbf0f01@linux.gnuweeb.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <175408424863.4088284.13236765550439476565.pr-tracker-bot@kernel.org>
References: <20250801142254.GA3496192@bhelgaas> <175408424863.4088284.13236765550439476565.pr-tracker-bot@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 01 Aug 2025 21:37:28 +0000, pr-tracker-bot@kernel.org, wrote:
>
> The pull request you sent on Fri, 1 Aug 2025 09:22:54 -0500:
>
> > git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git tags/pci-v6.17-changes
>
> has been merged into torvalds/linux.git:
> https://git.kernel.org/torvalds/c/0bd0a41a5120f78685a132834865b0a631b9026a

Yesterday, I synced with Linus' tree, but couldn't boot. Crashed with
this call trace:

  https://gist.githubusercontent.com/ammarfaizi2/3ba41f13517be4bae70cde869347d259/raw/0ac09b3e1d90d51c3fed14ca9f837f45d7730f0a/crash.jpg

This morning, I synced with Linus' tree again, still the same result.

I suspect it's related to pci. I'm still bisecting. I've successfully
narrowed it down to this pci pull.

  0bd0a41a5120 (refs/bisect/bad) Merge tag 'pci-v6.17-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
  db5f0c3e3e60 ring-buffer: Convert ring_buffer_write() to use guard(preempt_notrace)
  12d518961586 tracing: Use __free(kfree) in trace.c to remove gotos
  debe57fbe12c tracing: Add guard() around locks and mutexes in trace.c
  788fa4b47cdc tracing: Add guard(ring_buffer_nest)
  c89504a703fb tracing: Remove unneeded goto out logic
  877d94c74e4c (refs/bisect/good-877d94c74e4c6665d2af55c0154363b43b947e60) Merge tag 'linux-watchdog-6.17-rc1' of git://www.linux-watchdog.org/linux-watchd

Now, I am testing:

  769ce531faa6 (HEAD) Merge branch 'pci/controller/msi-parent'

I'll be back to it later. git bisect says:

  Bisecting: 65 revisions left to test after this (roughly 6 steps)

-- 
Ammar Faizi

