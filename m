Return-Path: <linux-pci+bounces-10499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4161F934CD9
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 13:58:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0197283F14
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 11:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31EF813B2A4;
	Thu, 18 Jul 2024 11:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mWufwUOg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5007013AD2F
	for <linux-pci@vger.kernel.org>; Thu, 18 Jul 2024 11:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721303914; cv=none; b=W5z+cOUbYuzIvKgh9mPCyqVhYzi5ygW/Krr/MQFuwU97HrtA7qbPMatiB/c+2YML0pePf3XziNy1+tPxZph4dysdrlW8MMDJUuixGFzaB1SPK5SyUSPxVLwK7DiHWD1WaYWFQ29GGJTCnpT5gKkF4SRbqStPLjP54LaVxYT28gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721303914; c=relaxed/simple;
	bh=FFrNdvWWjN63s42BKAKBM8xaz6ftXrgEKRS6jcbmJL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q3MoTWt4JGZgfPZ9h/CFh1IpkeSjcV1a3oWMfqiiNhBf8hkoT5IKdMvf9j/5yZXQs2YKrThZZjgmFWhGkOf5uh9KrxS1JqH7Olcw2LThIrEQ2TgIEuhEB2X9aBho7uM5RDX9PvxrwL4a/lGhx7fR/SFwwwp5s+sWBdF2vPwsZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mWufwUOg; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-426717a2d12so1669035e9.0
        for <linux-pci@vger.kernel.org>; Thu, 18 Jul 2024 04:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1721303909; x=1721908709; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eT3/r8iq9vh5IHb+laarDBOv4FqNaSgzXd7Frm5ubA4=;
        b=mWufwUOgGu9tdiTbF+wwaBViwZ/n4VkZG88CacADd3i1zoS9DkkZusfrOmHeK/jtli
         Np/roYCnPe/6gkZWafuTul7lmwqWOct92+bai0+qHrEjtsqT/9krxKTRlxCe2zq2rYvv
         ASYfWg4jaZMhWrVKMb9zOq5kI/rJQviCHWeK/o9qB7DB2ECMjFjn7SMvqlH8SLgGQGxz
         CJplTKapwkiyg8sm6kBEKMrj68Iez0l3L60XL0SrUo5m82q3VKstqAULLMEROCSnuErU
         pc71vIg7gz5X+z4zGwuqAeyodqQUmUyBvspOf974PiNE080Sr97Gn+/iH0N0vhRxCO7z
         NxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721303909; x=1721908709;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eT3/r8iq9vh5IHb+laarDBOv4FqNaSgzXd7Frm5ubA4=;
        b=IdSuYQGzIBsMca/M55aeTBhOlLcIbI3rqGD1oRAQO+EDbzcVmz+SpmDTHnrY1Rw0/O
         /Ore2t4rOBOvv5QylOyE5gzGJS2Um1jTBWnJzvE347ylS6778+kJ5fMTDjE/m1dDLXWj
         BBpm2H0bY0uT6mSXMh3z0DZjonI0qRU7y3x4/+2GiAvfjyFgHlp2mrDUyn5WZ4TMNn6Q
         OH7zVJS0l4VOV1MXl/xArYC2lcRKwx0DKizmiwdZAMwzg9z0OpQlZej7OCBfrQb2UDPZ
         pETShZsidxNVbiE6NPgJ2yGtg36KYMLDBzpSUIuoVnPdmOhhgiV38jjcWy3QvjWm3dXp
         jZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGi8IwjUDvlVEZKXczfoGKvRniyq36tnlpx/ZQ9WbNno+Qbeta0CQDnfm2pIACc3p9+5Exlg7tMrXcJ0mi4xdy97NG1AAQlKmn
X-Gm-Message-State: AOJu0Yz5PyESQWdwrfr0BUNF5b+s7wK+kS9x+zMWrXYxQoJVl8FFK5ow
	JDWMkZwVhEDjexMs/Jd5qSqSQ9HlufKtZB0gWr9kwIlEFPNvkFErCV27nkXbOgk=
X-Google-Smtp-Source: AGHT+IHpOFhVVOR50WDCPfi6DXrjDJkGmwaqmpgdsmAo5+FCsTxtL42b6u3Rfj/yngP1z/p7fq9EnA==
X-Received: by 2002:a05:600c:4751:b0:426:5cc7:82f with SMTP id 5b1f17b1804b1-427d2b527demr5295885e9.13.1721303909431;
        Thu, 18 Jul 2024 04:58:29 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:dc:7e00:58d4:2f84:5fcd:8259])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-368467a34dcsm2258703f8f.109.2024.07.18.04.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 04:58:29 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	linux-pci@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Kconfig: reduce the amount of power sequencing noise
Date: Thu, 18 Jul 2024 13:58:27 +0200
Message-ID: <172130382340.64067.7765392027721457700.b4-ty@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240717142803.53248-1-brgl@bgdev.pl>
References: <20240717142803.53248-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>


On Wed, 17 Jul 2024 16:28:03 +0200, Bartosz Golaszewski wrote:
> Kconfig will ask the user twice about power sequencing: once for the QCom
> WCN power sequencing driver and then again for the PCI power control
> driver using it.
> 
> Let's automate the selection of PCI_PWRCTL by introducing a new hidden
> symbol: HAVE_PWRCTL which should be selected by all platforms that have
> the need to include PCI power control code (right now: only ARCH_QCOM).
> 
> [...]

I'm picking this up into my pwrseq/for-current branch. I'll be off next week
so I want to give the autobuilders the chance to play with this and I'll send
a PR to Linus with another pwrseq fix I have queued tomorrow evening.

Let me know if there are any objections.

[1/1] Kconfig: reduce the amount of power sequencing noise
      commit: ed70aaac7c359540d3d8332827fa60b6a45e15f2

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

