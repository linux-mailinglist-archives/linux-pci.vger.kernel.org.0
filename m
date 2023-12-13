Return-Path: <linux-pci+bounces-862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B23E9810ED5
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 11:49:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23881C20C03
	for <lists+linux-pci@lfdr.de>; Wed, 13 Dec 2023 10:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCFA22F03;
	Wed, 13 Dec 2023 10:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SST6rnK5"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28FD8D5
	for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 02:49:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702464575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
	b=SST6rnK5EaMhcmxmPvsPsXsYIEg2MC4Oe0TnFEVmwcv/C+ouz+OLFZiEfoWm02x0og+bdc
	7Nj8/fxz+VmA1oZpGXRD9MdxhAjAtoptHSoOqImdi6uOpmRKFRQMcHCKzoXJ7cjQK5rzOK
	kUha+woMy5Tg2874oqSyhuBKFGwfMg0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-377-CFLknbPXNQuSy6lE7YBzdg-1; Wed, 13 Dec 2023 05:49:33 -0500
X-MC-Unique: CFLknbPXNQuSy6lE7YBzdg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a1f72871acdso104453266b.0
        for <linux-pci@vger.kernel.org>; Wed, 13 Dec 2023 02:49:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702464572; x=1703069372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
        b=YhrqSasSqeLybjnoPdPkY9kXka3+K+cd80Y2LaB2xFU+9iNveXqOvsMgWERyzYOj4l
         bNmVrt4Uk90w/RIBbkqr+2RVtMTSlW+NmVbx0UOLlE1aSg6sL9vOEmmz+WnNykgvB7Qg
         VYFP4hWK+v9i8tCiOwrJ88mGdiN0aO7h4Ey7u93C3KWczTC/VvnuWK0R+Nvx3eJIR2PD
         1K5c65O1CXpbqoy1oW2zhhwQ9VMwik5ZDKGPBdFeiCsWA3t7ULioxa/tktu17yy5EHgs
         fLHorLs/QXnaHrNZkiyoWl9WYon0dP5PMogf8o1mDrEC9VCK3OgchFcSLnMxOSfLuAlY
         YQhQ==
X-Gm-Message-State: AOJu0YwhtKG6VhRNY9R4T6YjBBzxjruvT27/H6J0JO6j7F1njkTX2B2q
	SCZl+6akDTPCvVlvsb2fYRqC8Q/mY86lb1YeHgsCCthnOsnnUjLPr7TNUG1jFpPCrgvYsQmxxH/
	YfwhZJTZrx4Mrwn1sc/0O
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr8780437ejc.5.1702464572485;
        Wed, 13 Dec 2023 02:49:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHKgFPrh8KzPFJxkHMTnI08lj2bQ889ejHtYo2j82GcEnRYLPMKJx+/M/r6P6Msuj9VzaynPg==
X-Received: by 2002:a17:907:d384:b0:a1b:1daf:8270 with SMTP id vh4-20020a170907d38400b00a1b1daf8270mr8780419ejc.5.1702464572286;
        Wed, 13 Dec 2023 02:49:32 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2a01:599:914:ed27:4fa9:dbce:10f5:d0b9])
        by smtp.gmail.com with ESMTPSA id vu8-20020a170907a64800b00a1d5c52d628sm7527135ejc.3.2023.12.13.02.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 02:49:31 -0800 (PST)
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
Date: Wed, 13 Dec 2023 11:49:18 +0100
Message-ID: <20231213104922.13894-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231213104922.13894-1-pstanner@redhat.com>
References: <20231213104922.13894-1-pstanner@redhat.com>
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


