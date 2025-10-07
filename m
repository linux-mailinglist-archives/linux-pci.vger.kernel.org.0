Return-Path: <linux-pci+bounces-37652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AD06BC0D7E
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 11:23:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C32733BD82E
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 09:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FFC2D73B3;
	Tue,  7 Oct 2025 09:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b="o/rzLmJS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138BB253F13
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 09:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759829016; cv=none; b=R9h15/GKagxjApRNJ2r/BwOk9Q6VLVG6/yaaQQpmyBf4FTBc+fIwc+nZ8LzXmSLE3dhl6P5rac1uNHH5kwrFt2VO5JbFfSRzu4H1CcHsID+FkGXul1+YufCkaAnFTv6xu9c3mtIqVVfzht9eA1CDwQfxCWnytGE/hO5tCHrxScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759829016; c=relaxed/simple;
	bh=OyjOTab8mpNvoOfusTuJ3kewJnbeyW2Tdc9RzvHdAeo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q59BXHFYyskPS2QixgOqK+Bak3U2mYHJCr8YdTr0yRngKVabYFxFsHGr1v7IOimVulT7IEPSKXaWtsrhQvUxjSVK6wXxWmji7c0jh/OE4bcgp1x41/yR2aPOo+si1hYIA+9kkizk3SkvbqTFMDtBlpCuDBIw/f+eTAQ2EiB5tK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp; spf=pass smtp.mailfrom=0x0f.com; dkim=pass (1024-bit key) header.d=thingy.jp header.i=@thingy.jp header.b=o/rzLmJS; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=thingy.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=0x0f.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77f68fae1a8so7712748b3a.1
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 02:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=thingy.jp; s=google; t=1759829013; x=1760433813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8BMrreGYaM+ETQ7wh1dqgwXsdvPXSRmjMBiX7/QH9P8=;
        b=o/rzLmJSzvU+bl/b5A83rPIePTO1rSYrAurGBRr9Kb3MfK0vwefQYDA8jegUJvh69w
         UiGz020TWipS40Lx58rOw5pzRqQK88NYtMb+Ktwzqj7vbiMYdgHrTNNgJNrpiJTQ0kwu
         f+hb/k8KNQnGxHEZGFMwU7zPqV6m+asSc7c6Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759829013; x=1760433813;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8BMrreGYaM+ETQ7wh1dqgwXsdvPXSRmjMBiX7/QH9P8=;
        b=DUbvQTZHxz4KtV7389p1BkEZ2OLyk09Qmv6+soigFLkyuJo0xuTPQV2xzKC5cnMbxL
         XlZyQO/4uXbgeSxsbcyeEpL0f/7wU7en7abONCU50VlbCGK/EizjCjk5uDHXIQ1EOkLd
         X7VgNF6IHMvW0oOdWXTx1d8h/4Qpr7Wu0jPXGwt40tFW8wKm7O1qMSRMGDdoA81NRRAW
         uR6Z9NZJakhXUdPOsBB3HoHOFRbJmqp1oerTjKP8XZpyaZ+9UJqnS4UfNpnFqVMBhHlq
         IDtrthLJ+r9Di4xzpBzY96+GgYHenm9AU9g+r57IpAkdLsVdhtElp2yJ8IwBRkr9eZfP
         Q/vg==
X-Forwarded-Encrypted: i=1; AJvYcCWSCP/jZ0hjI2fsKUUSsaypwCJwJX3ruu65vCiwH9Jm1KVfWWWWpCAqNc/fwFsYqY9BwLeuduzzvH8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZcx0s3qT3FSWzUxLJtW1NODsohxDBEcrhKzVRm3qW/nuhzczg
	8NCPObcIMnUZlK57MuHppXn1xUY91fulTRCx5jqe4Qow+3kk9cQ7O8j0ADJhjuMi1iqpXEbZPDN
	8G1r7Fmg=
X-Gm-Gg: ASbGncu2UalMfMFJXULrOIVLXblR4CpPD9R3jk4YUWA66SWlpLRYyNCr3/34sARCik1
	GARL7b1mfPvPqKWgebPWUn+PQLElVhOgFG65eEjHXGk8+c2tWAsk/e38cVYlxCDEElpLIrpxf4n
	DgZVOR/5jdOR5xDk064EVLLHzh1nlhDcHR66+AydsjgWy6vYnwFT6scI2xWW9wZ19ETlYw8ZId7
	TRCT7jAHG1M+5QkaNsc9Jq3kEzHPmXoI7kZ0AKwX6pCC45CENLyxo+Pf7Y0QgE675AXKRXL5qu1
	UzOiUHIZWn8HQuFeFFE1Z2yc99ADGoN4KlYfVe1OCByqBv7HOkFZPODbYk68U7Xy2XJwPmcbDzK
	l0MvwGYTuFr6PrIZKklzJmCojGqGRB2OmU2KnKEs4ltzpThpIZlmAA6+uKTj07L+Bd08/b/mWQK
	UJmVhzbS+mB/sCO+R25BsP5pPwUh12Jj3VZk0=
X-Google-Smtp-Source: AGHT+IG2M1roqWj3uq0lJ8nnzGjIVwpT4KjTyGoeZ+ChvFAl/lA0gtYsMYOlp2/3j2ZlBG1u6YV22A==
X-Received: by 2002:aa7:8dcd:0:b0:792:52ab:d9fe with SMTP id d2e1a72fcca58-79252abe295mr2218766b3a.0.1759829013136;
        Tue, 07 Oct 2025 02:23:33 -0700 (PDT)
Received: from kinako.work.home.arpa (p1522181-ipxg00c01sizuokaden.shizuoka.ocn.ne.jp. [122.26.198.181])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-78b01f99acesm15123273b3a.5.2025.10.07.02.23.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 02:23:32 -0700 (PDT)
From: Daniel Palmer <daniel@thingy.jp>
To: linux-m68k@lists.linux-m68k.org,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Daniel Palmer <daniel@thingy.jp>
Subject: [RFC PATCH 0/5] PCI on the Amiga 4000
Date: Tue,  7 Oct 2025 18:23:08 +0900
Message-ID: <20251007092313.755856-1-daniel@thingy.jp>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds a driver for the Mediator 4000 PCI
bridge for the Amiga 4000.

Since this is my first PCI driver it's probably awful
so this is an RFC and also there is one interesting
unsolved bit:

As far as I can tell the Mediator 4000 cannot do DMA
between the normal memory and the PCI cards but PCI cards
can DMA between themselves. In the AmigaOS drivers a
bounce buffer is allocated on one of the cards that contains
memory, like a graphics card, and that is used for PCI
DMA. I'm not sure if that's even possible to do in Linux?

I've managed to use a network card that doesn't need DMA
so far, but I'm having trouble getting a Voodoo 3000 or
Radeon 9250 graphics card to come up properly. I guess
no one tests their cutting edge graphics drivers on non-x86
machines. ;)

Daniel Palmer (5):
  m68k: Adjust the pci io range
  m68k: Increase number of IRQs for Amiga to allow for PCI
  m68k: amiga: Allow PCI
  zorro: Add ids for Elbox Mediator 4000
  PCI: Add driver for Elbox Mediator 4000 Zorro->PCI bridge

 arch/m68k/Kconfig.machine                 |   1 +
 arch/m68k/include/asm/io_mm.h             |   9 +-
 arch/m68k/include/asm/irq.h               |   4 +-
 drivers/pci/controller/Kconfig            |  11 +
 drivers/pci/controller/Makefile           |   1 +
 drivers/pci/controller/pci-mediator4000.c | 314 ++++++++++++++++++++++
 drivers/zorro/zorro.ids                   |   2 +
 7 files changed, 338 insertions(+), 4 deletions(-)
 create mode 100644 drivers/pci/controller/pci-mediator4000.c

-- 
2.51.0


