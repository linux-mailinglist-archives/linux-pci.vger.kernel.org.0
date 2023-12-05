Return-Path: <linux-pci+bounces-503-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1098058E1
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 16:38:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2207FB20D76
	for <lists+linux-pci@lfdr.de>; Tue,  5 Dec 2023 15:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FBB15F1CD;
	Tue,  5 Dec 2023 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aTpJmBIK"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE79383
	for <linux-pci@vger.kernel.org>; Tue,  5 Dec 2023 07:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701790686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
	b=aTpJmBIK8PwgvktqOAM7SfZxJ06lLy6DnGsShEorVazYcoLGOdXuUqE5OPnTLjMrqGTjPk
	HSxr8F3QJMBFCuvVRxG8ksE6mc4BKG4b+jfyNylTr6G8A4C17+G+mv9/0k+BqodY+p/uDH
	WFhaipFWNMG1yaZ8oCv6ICekSwnSwiI=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-168-OksBZoCdNPKoSsZrnns7Sw-1; Tue, 05 Dec 2023 10:37:55 -0500
X-MC-Unique: OksBZoCdNPKoSsZrnns7Sw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-54cc6ae088bso134871a12.1
        for <linux-pci@vger.kernel.org>; Tue, 05 Dec 2023 07:37:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701790673; x=1702395473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
        b=ZgFbKWY1h0nWrHJVEuploh3gvGfHhY7YgNT9JoYWX1xULx5oKpuH9XMJmGDs5RuTBn
         NJXKBvJseuENI4Qq2yH8rB6/J1BGQcfLBCu03d+bZ4aHcgPrFD5GJEnz83cliphQy0RV
         AhvvPwrCNz2OxSBw6Qso82DlqHk9ceg5caH6GkczrtfzczhrmhKAJL66qAf3lvy3JY78
         SlzyYJLaxZsbUaMilaB+Jhv9XW09fsY3tytq2GdJMeW85Q2euFcTLvQE7pHhawipMf1f
         D4I518r8K20g088pHG+ybIP6kxDlNJ9JDGoWv06+hU9VYTRVtV+/B8x4O+wF2diPWKPk
         Buaw==
X-Gm-Message-State: AOJu0YyYoqn8WjyqH1JUEUO3rzLTQYUppWKbM7ss5kDk/pSrgXH3Blwm
	Nhdmu096mj7Ph/sL7MrfuX6I9JTFg7z1EsjewXa60dSV6zs1N+kPQanyHpQdBr+wNfoTT0QPoKo
	jh0EDFK7QeT8BJ0GuHo6S
X-Received: by 2002:a05:6402:1d0e:b0:54d:2efd:369e with SMTP id dg14-20020a0564021d0e00b0054d2efd369emr1100570edb.1.1701790673581;
        Tue, 05 Dec 2023 07:37:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHMWm/1bFBFbNN6jWtOQ+6Wi9ETG9A4NbaILiBypRArdxNy576pceUJLgrbNKwNpAp9z7aoNA==
X-Received: by 2002:a05:6402:1d0e:b0:54d:2efd:369e with SMTP id dg14-20020a0564021d0e00b0054d2efd369emr1100547edb.1.1701790673178;
        Tue, 05 Dec 2023 07:37:53 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2a01:599:912:71c8:c243:7b37:30b:a236])
        by smtp.gmail.com with ESMTPSA id r15-20020a056402018f00b0054c21d1fda7sm1244578edv.1.2023.12.05.07.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 07:37:52 -0800 (PST)
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
Subject: [PATCH v4 1/5] lib/pci_iomap.c: fix cleanup bugs in pci_iounmap()
Date: Tue,  5 Dec 2023 16:36:26 +0100
Message-ID: <20231205153629.26020-3-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205153629.26020-2-pstanner@redhat.com>
References: <20231205153629.26020-2-pstanner@redhat.com>
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


