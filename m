Return-Path: <linux-pci+bounces-2874-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C092F843A34
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 10:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E1BE1F295CA
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jan 2024 09:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB44F762CD;
	Wed, 31 Jan 2024 09:00:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VfVOq0DW"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 367E474E17
	for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 09:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706691652; cv=none; b=mkAPMAf28L4ByhOprH6GRkw8Q0MFHKraarFctNHa+whC5bMxKuUs4BbIxC67XWJGMzcX4GWYXoYRaFYfkgpOtmny/NCTdZv+jaGW1B9/jP1OSJpwM/ce9KUnHYWmG8/EIzLjkudSI8txVSb2KVpHBMcq0OI+7DagvpOtMQ/d1JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706691652; c=relaxed/simple;
	bh=vH3oPgaI8JxuUuwWch/HQ93o84vdfvLqDCcNgnv6A3Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YpvfOe4PTyvsW3RgvMXszg/BNPzTNzPgue/aNIJKLqVSst1LUpVyQaKFnh7VFHcBLDWyLZ3BlbnAFoSaYXTglPszT/oGdz4t+FGLCipWJU+szf1pUdzrhh3v/rX59aiJN7NGU4oB7iRL//ikruwpAZAJGoqCHSzACbYqvuRJt1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VfVOq0DW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706691649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7vzi2j4G3178It/+rST4Ai2Ba1aZ21wL7YawLdngYBs=;
	b=VfVOq0DWaVGwz4S8ZrqOv1yh0dPziEyx6ceMt6dXpMX+qVhGC7+GoVmUvPd3oohkU6mldd
	5YDCfcoaCqvoumekNFZHvyvCAL4o+HStw9IXw11vK+k25smFS8kWhH6tDZTngT+0lY7TJ/
	z1Fbe+ZZwj10mAA+FG4GjHEOXvBgN/A=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-aOA6YJfNNBaTSfk0AuTA8g-1; Wed, 31 Jan 2024 04:00:47 -0500
X-MC-Unique: aOA6YJfNNBaTSfk0AuTA8g-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-5111638f3e0so724175e87.0
        for <linux-pci@vger.kernel.org>; Wed, 31 Jan 2024 01:00:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706691646; x=1707296446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7vzi2j4G3178It/+rST4Ai2Ba1aZ21wL7YawLdngYBs=;
        b=H0WfpNP/K08y6B0hLkjesoMDPJ1boDucdJtOwY3yp0VYEMI9TpBMzP6uqLYyCeW1nO
         qIuvu4gNsELDGqJwBo+r/Q6DwOdJjczEHLcyetFN0awYLdDaB4kzny3kCZw2VZTsHGjU
         0ygFcMilyfyJaWS5W7bTDHA1WxDZE5KlJY56I1JmyEMRT+7Pj4s/p2UM8vVJeuhh+hPn
         GseWmxTEShiMFJ/suSSF+drAh7N7ETTalOiZX65j9SWDQD3y9dad/f6MDeBIIaiEWrRN
         P1jMEjY+VZDb7BD5ornBvBYMmQT5fhqvxAJ+6HAb00J0TIvCyep4HoMX9jsPLv0D7VgP
         Eb0A==
X-Forwarded-Encrypted: i=0; AJvYcCXD/+7wThKCsGrQjfk3bYLWgnPR9snnjEbUdDLCFNE/ea9mHwarDm+sNA5uZT8yDArfPs6eAVdB59eIVc1Dqms+jt/MB7D3hSod
X-Gm-Message-State: AOJu0YwyS4iFHAlzUI8cd8fSjgB9xWDL6yWuxq6Ee3an4SXxzofWa3av
	d9be/3ZZ9ukPzoFCUgtfFMgP7vSo3MTF7hiKz4PBouH7n656XiWvNo3/gQJCsBt37sLMnZ73Q+c
	IA4RbDFAYG5tYJR+8ppXSYsRtURq8czmoaRpS4CLyHa8i93oyeBdis5BdcQ==
X-Received: by 2002:a19:8c4b:0:b0:50e:337b:f316 with SMTP id i11-20020a198c4b000000b0050e337bf316mr713650lfj.1.1706691646163;
        Wed, 31 Jan 2024 01:00:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHlzIWl97OR7xsdMRKZGvN84dU1MtwIX5ZbxjHka1V7daDCGV1BWKKGhihNsakGU8cfez3rsQ==
X-Received: by 2002:a19:8c4b:0:b0:50e:337b:f316 with SMTP id i11-20020a198c4b000000b0050e337bf316mr713612lfj.1.1706691645825;
        Wed, 31 Jan 2024 01:00:45 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id t15-20020a05600c198f00b0040ee51f1025sm940261wmq.43.2024.01.31.01.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 01:00:45 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Johannes Berg <johannes@sipsolutions.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	NeilBrown <neilb@suse.de>,
	John Sanpe <sanpeqf@gmail.com>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	David Gow <davidgow@google.com>,
	Kees Cook <keescook@chromium.org>,
	Rae Moar <rmoar@google.com>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Baron <jbaron@akamai.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Marco Elver <elver@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	dakr@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v6 1/4] lib/pci_iomap.c: fix cleanup bug in pci_iounmap()
Date: Wed, 31 Jan 2024 10:00:20 +0100
Message-ID: <20240131090023.12331-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240131090023.12331-1-pstanner@redhat.com>
References: <20240131090023.12331-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The #ifdef for the ioport-ranges accidentally also guards iounmap(),
potentially compiling an empty function. This would cause the mapping to
be leaked.

Move the guard so that iounmap() will always be part of the function.

CC: <stable@vger.kernel.org> # v5.15+
Fixes: 316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make sense of it all")
Reported-by: Danilo Krummrich <dakr@redhat.com>
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/pci_iomap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index ce39ce9f3526..2829ddb0e316 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -170,8 +170,8 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 
 	if (addr >= start && addr < start + IO_SPACE_LIMIT)
 		return;
-	iounmap(p);
 #endif
+	iounmap(p);
 }
 EXPORT_SYMBOL(pci_iounmap);
 
-- 
2.43.0


