Return-Path: <linux-pci+bounces-1649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD57823E31
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 10:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE2C51C238F3
	for <lists+linux-pci@lfdr.de>; Thu,  4 Jan 2024 09:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF902033C;
	Thu,  4 Jan 2024 09:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pr7SAUqx"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B7720303
	for <linux-pci@vger.kernel.org>; Thu,  4 Jan 2024 09:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704359246;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
	b=Pr7SAUqxYRK/Ic3MQtOTVajIXgzT6vddh1Xu1NxeMgCFU0C7L7fiUJn6OUOelq3im9hEyk
	T7os/DUsB3uLeqRYj4cEg3tMM6l6QgpMAeY4p+SB3MiszkJheft8FnIde87tivHEMGhwWv
	I7gb6uOjhk/wUSwUDtr1Ns9B1ZmJoA8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-ZoY5XyFRN-K-SJaYPzsZ5A-1; Thu, 04 Jan 2024 04:07:24 -0500
X-MC-Unique: ZoY5XyFRN-K-SJaYPzsZ5A-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-40d87d87654so728165e9.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Jan 2024 01:07:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704359243; x=1704964043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
        b=oMXleSJcW9qkUFFCOObqbERfloCmQxTcO2IM2qmDSc1mEQH/jz2UcywjCfCBSQqLdK
         wxdRyj2MauH9sPJgun7hNRBlbJI/dvR8vQtOkXU3IHbR+BjGjrQUzvvEekPvajLXU7DM
         BwYBcQk3mAxkNvWDeeDq0Yv+xDrosd0sc1bktadbbc33eAqf3VoFHwKKCMTFrd3OD0+A
         f6kRVMraFLQtFlVoc799dQSoFRrO3V+JKmmAnj2XNV9jWN6yR37n4vOmdsM++NkrJ2lx
         QvLj9fiYuti4yhDT7nC56kmT4YAD/vTaBP+wepcBYnin/8gd+tiL/P6YHfkgBltMrOOT
         5BQQ==
X-Gm-Message-State: AOJu0YyZ4rr6JARIxDgmhMxd05M2q049+IwPWEpEUSRBZAhX+usC+VDR
	lpkuy/JrDlfSCNjefx7x7lIxyRiEDiSEG9eSsumCKEOBG23CN/fHy/MzLEBqiwXkhqQf+bMRB2Q
	0Ljpl4UZ1fwlbE33UkLGOqAy2kikI
X-Received: by 2002:a5d:5f95:0:b0:337:3cf6:ed4c with SMTP id dr21-20020a5d5f95000000b003373cf6ed4cmr443085wrb.4.1704359243222;
        Thu, 04 Jan 2024 01:07:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGXzNqzW8kqtKPV62b5Zy3H304bH+UJk2Jf9aXIbT0CMRfAzqN9DqxRHxNyFzZiNtek5M5OJQ==
X-Received: by 2002:a5d:5f95:0:b0:337:3cf6:ed4c with SMTP id dr21-20020a5d5f95000000b003373cf6ed4cmr443049wrb.4.1704359242584;
        Thu, 04 Jan 2024 01:07:22 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id h15-20020a5d430f000000b0033740e109adsm8720864wrq.75.2024.01.04.01.07.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jan 2024 01:07:22 -0800 (PST)
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
Subject: [PATCH v5 1/5] lib/pci_iomap.c: fix cleanup bugs in pci_iounmap()
Date: Thu,  4 Jan 2024 10:07:05 +0100
Message-ID: <20240104090708.10571-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240104090708.10571-2-pstanner@redhat.com>
References: <20240104090708.10571-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pci_iounmap() in lib/pci_iomap.c is supposed to check whether an address
is within ioport-range IF the config specifies that ioports exist. If
so, the port should be unmapped with ioport_unmap(). If not, it's a
generic MMIO address that has to be passed to iounmap().

The bugs are:
  1. ioport_unmap() is missing entirely, so this function will never
     actually unmap a port.
  2. the #ifdef for the ioport-ranges accidentally also guards
     iounmap(), potentially compiling an empty function. This would
     cause the mapping to be leaked.

Implement the missing call to ioport_unmap().

Move the guard so that iounmap() will always be part of the function.

CC: <stable@vger.kernel.org> # v5.15+
Fixes: 316e8d79a095 ("pci_iounmap'2: Electric Boogaloo: try to make sense of it all")
Reported-by: Danilo Krummrich <dakr@redhat.com>
Suggested-by: Arnd Bergmann <arnd@kernel.org>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/pci_iomap.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/pci_iomap.c b/lib/pci_iomap.c
index ce39ce9f3526..6e144b017c48 100644
--- a/lib/pci_iomap.c
+++ b/lib/pci_iomap.c
@@ -168,10 +168,12 @@ void pci_iounmap(struct pci_dev *dev, void __iomem *p)
 	uintptr_t start = (uintptr_t) PCI_IOBASE;
 	uintptr_t addr = (uintptr_t) p;
 
-	if (addr >= start && addr < start + IO_SPACE_LIMIT)
+	if (addr >= start && addr < start + IO_SPACE_LIMIT) {
+		ioport_unmap(p);
 		return;
-	iounmap(p);
+	}
 #endif
+	iounmap(p);
 }
 EXPORT_SYMBOL(pci_iounmap);
 
-- 
2.43.0


