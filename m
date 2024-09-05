Return-Path: <linux-pci+bounces-12817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD25D96D05A
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 09:26:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFFC1F23420
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2024 07:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 820B5192B94;
	Thu,  5 Sep 2024 07:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7k4wX0R"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E511883CC1
	for <linux-pci@vger.kernel.org>; Thu,  5 Sep 2024 07:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725521188; cv=none; b=q43jc0ArqPJqniru+iZ+WiSg788gyQXgykF+Gua0bHxsvusOrsxBTO8SdmBjlfihFP47Y2uB2HtCBZ2LJkG0gohj6MC3i7nM8iK5tZNKnfZeKdVkb+XayUaAQV+fZYsbYQ1BTRTvoqriCSrl+hN+fBHjGFo0/YIJFXD+2XFkp8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725521188; c=relaxed/simple;
	bh=1E90GDaWcU2dYBUkZZSE7DrGg3MiyzaXBiTYpbewsn8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tf0LdsdELSDyXakgy8Fshk6KqWoWncqtEZUQD5BwC6pgg0cRgC/xRjHo92oZC60JdMdRcLzWYFOnMIPgqN/Gmqz0AvLMtaFx21KLTZm2GxyPJK/5P4DBpQXem7+6uXbeW5v9RLugdkidfx49Rq3+xMjSjAYE/sEv7cOu1OsA2nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T7k4wX0R; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725521185;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=yaOGeMd8w3UisQhL375DuduTAHttyCwkLUEKAc7a4E8=;
	b=T7k4wX0RMnwP8QyWnAvI1HO0M3V0Liz4UNYNe7NbqcqXEXEYKsjBblW5p9XR3x8InsC5n9
	QnKYe74swri2kfQFmvSLcA9f3CRMdWedSuPII9iJMzfhWbN66QXkDW6uhCYEL+vaT11esr
	SCAhgs27fHq1nSuGUcJWdLmZFvaH6j4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-45-FPwILioCNVaa5BIzuzWyFw-1; Thu, 05 Sep 2024 03:26:24 -0400
X-MC-Unique: FPwILioCNVaa5BIzuzWyFw-1
Received: by mail-yb1-f198.google.com with SMTP id 3f1490d57ef6-e13e682bee1so1131662276.2
        for <linux-pci@vger.kernel.org>; Thu, 05 Sep 2024 00:26:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725521184; x=1726125984;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yaOGeMd8w3UisQhL375DuduTAHttyCwkLUEKAc7a4E8=;
        b=Vr1JxT6Br9iVkN+A0f4oJynX4YUzxzlZYOBs9IlFkxulIAvZhS8osrkkpTc8A+6Z3r
         REwcpYpbC2gDhAZZ5FJ6e912jXpyvnA33r/MSWOK/1BH5P+VsGEaLf82dskFmhvlXTUj
         rSt4RXkr5kk5DLt65dJzYDkzF8WpHvcmZGoJn4EW6hC6XP7CE6rIG0JBri6vssCry9NO
         i7T/ILLGO6m8CeFwMHw9WIsVe0pa5Zcm5ScW4yrRMe4LIlpW3ZTRU5ObQ5ByqXLdHtnC
         5uvMDAzqPvNDf16aXScfAhaWRKMEqb+SFoKPIpGhrJRkdHHPx/D4OnKCRicXxiUtverW
         uJow==
X-Gm-Message-State: AOJu0Yy9vIjSXwx0l5hCrbssuXMmc2eXQksud0U5XTkTwbbhoDYn7OX7
	Rsi2GA9zUqqQzaO+f4K892BJKCQSODsOOgzqjSAkU9/2hOBWMs5jvIxmWA6ZCdZh/zuYInuTFDd
	j6wK61uYMh9StgT6z8ZuBi+oCNNz0OBbe6nT+fxRsg8BeskVCiHAPpuMXNg==
X-Received: by 2002:a05:6902:120d:b0:e16:55cc:215c with SMTP id 3f1490d57ef6-e1a79fe3948mr26285994276.6.1725521183782;
        Thu, 05 Sep 2024 00:26:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfflzeoBEgBEeoMRSumn4e17QiyfLrzWs8/iJJXxkGrbsKpnb66lp9FuBKXH+zZQwHmz9aOQ==
X-Received: by 2002:a05:6902:120d:b0:e16:55cc:215c with SMTP id 3f1490d57ef6-e1a79fe3948mr26285971276.6.1725521183238;
        Thu, 05 Sep 2024 00:26:23 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c5201defd8sm5404376d6.24.2024.09.05.00.26.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:26:23 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Stanner <pstanner@redhat.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alex Williamson <alex.williamson@redhat.com>
Subject: [PATCH v2] PCI: Fix potential deadlock in pcim_intx()
Date: Thu,  5 Sep 2024 09:25:57 +0200
Message-ID: <20240905072556.11375-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 25216afc9db5 ("PCI: Add managed pcim_intx()") moved the
allocation step for pci_intx()'s device resource from
pcim_enable_device() to pcim_intx(). As before, pcim_enable_device()
sets pci_dev.is_managed to true; and it is never set to false again.

Due to the lifecycle of a struct pci_dev, it can happen that a second
driver obtains the same pci_dev after a first driver ran.
If one driver uses pcim_enable_device() and the other doesn't,
this causes the other driver to run into managed pcim_intx(), which will
try to allocate when called for the first time.

Allocations might sleep, so calling pci_intx() while holding spinlocks
becomes then invalid, which causes lockdep warnings and could cause
deadlocks:

========================================================
WARNING: possible irq lock inversion dependency detected
6.11.0-rc6+ #59 Tainted: G        W
--------------------------------------------------------
CPU 0/KVM/1537 just changed the state of lock:
ffffa0f0cff965f0 (&vdev->irqlock){-...}-{2:2}, at:
vfio_intx_handler+0x21/0xd0 [vfio_pci_core] but this lock took another,
HARDIRQ-unsafe lock in the past: (fs_reclaim){+.+.}-{0:0}

and interrupts could create inverse lock ordering between them.

other info that might help us debug this:
 Possible interrupt unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(fs_reclaim);
                               local_irq_disable();
                               lock(&vdev->irqlock);
                               lock(fs_reclaim);
  <Interrupt>
    lock(&vdev->irqlock);

 *** DEADLOCK ***

Have pcim_enable_device()'s release function, pcim_disable_device(), set
pci_dev.is_managed to false so that subsequent drivers using the same
struct pci_dev do implicitly run into managed code.

Fixes: 25216afc9db5 ("PCI: Add managed pcim_intx()")
Reported-by: Alex Williamson <alex.williamson@redhat.com>
Closes: https://lore.kernel.org/all/20240903094431.63551744.alex.williamson@redhat.com/
Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Tested-by: Alex Williamson <alex.williamson@redhat.com>
---
@Bjorn:
This problem was introduced in the v6.11 merge window. So one might
consider getting it into mainline before v6.11.0 gets tagged.

P.
---
 drivers/pci/devres.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3780a9f9ec00..c7affbbf73ab 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -483,6 +483,8 @@ static void pcim_disable_device(void *pdev_raw)
 
 	if (!pdev->pinned)
 		pci_disable_device(pdev);
+
+	pdev->is_managed = false;
 }
 
 /**
-- 
2.46.0


