Return-Path: <linux-pci+bounces-2038-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4B682A9CF
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 09:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23F0A281D2F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 08:56:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07898FBFA;
	Thu, 11 Jan 2024 08:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ds+Gaehn"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B3710949
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 08:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704963367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
	b=Ds+GaehnQdgb1v7JAMBEn7OnJJZQqd0t9puFslKnHUfDmwbBG8fr2JSiSjcl3OBc+eImIM
	CEq5H2VXSViYNUrv6Kuvmufb8rkUOmSBC84WZugjB7Scj3Een+tQdafgXXUWZuFTZv+MjU
	GVRAYaLb/cav+tG2cSaB+mHxYrhZQjE=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-31-5oj9767aPomL3rDeIVamBA-1; Thu, 11 Jan 2024 03:56:06 -0500
X-MC-Unique: 5oj9767aPomL3rDeIVamBA-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-680b74cba78so13216666d6.1
        for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 00:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704963366; x=1705568166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NoDK23LlK5p4IgH6ZTqMMZELxs6CauTLQ4NGvi9HnM4=;
        b=EYlEk4p9pF7jwJF/gqQFA3XFOcyRdu2h0E8JIThAODM7qDijnM+xxoMVzMWYtLwKA0
         mFp2LNkdlCCfeG8vCFd9UaM3nOjIme0hFxx4OCoVw3rKKQW8T0MGMzCWEq7YWpXI9DYx
         fIDnqCoVGn+5yakGhZbctds6EFgyvjQekdnjgLE9+Iq9od3KItQIYi0zbIjJ5zFLu5SE
         t7JEeZ1lg0Dn4ZEMc7CJN95pqqxrqejQOn8lhX1GCKoFeKhQIa5P3Q8F+uD3E06mZuWc
         f+fmSDL7Pw7t7xOIecXtQcyzhg+nKrnMBg1ad9VtkSpTIgh9Zi79FnZtuDCbe1tc17u+
         RrRQ==
X-Gm-Message-State: AOJu0YzNb9xciGIUP0+gP685+drPv1CeQahuMqbXxSAABrfg3dPuXOPI
	lFJLPmpL8mL2yDX3BSDf0ohkV5J5o1BCwEmL6buS9vs2eSu7sqd8t/odqxbCJmjDJTpFAW+ihTW
	pwdmgeirLjWdT8XWuGIaKFMKIZ46f
X-Received: by 2002:a05:6214:2a8c:b0:680:feea:fb6a with SMTP id jr12-20020a0562142a8c00b00680feeafb6amr1473393qvb.5.1704963366173;
        Thu, 11 Jan 2024 00:56:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGwR2D+JAYjUh/tvLjPn3BRlKCjqfMx89cDFz/vkVMvQ7Bx6KRoZssIGHZc081+cOaUMDXyAg==
X-Received: by 2002:a05:6214:2a8c:b0:680:feea:fb6a with SMTP id jr12-20020a0562142a8c00b00680feeafb6amr1473359qvb.5.1704963365935;
        Thu, 11 Jan 2024 00:56:05 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id e16-20020a0cd650000000b0067f7d131256sm168341qvj.17.2024.01.11.00.56.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 00:56:05 -0800 (PST)
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
Subject: [PATCH v5 RESEND 1/5] lib/pci_iomap.c: fix cleanup bugs in pci_iounmap()
Date: Thu, 11 Jan 2024 09:55:36 +0100
Message-ID: <20240111085540.7740-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111085540.7740-1-pstanner@redhat.com>
References: <20240111085540.7740-1-pstanner@redhat.com>
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


