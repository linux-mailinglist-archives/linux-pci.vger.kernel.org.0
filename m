Return-Path: <linux-pci+bounces-409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A42D803314
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 13:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99C42B20B13
	for <lists+linux-pci@lfdr.de>; Mon,  4 Dec 2023 12:39:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 709E5241F0;
	Mon,  4 Dec 2023 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UwcVCVE2"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0FED1A2
	for <linux-pci@vger.kernel.org>; Mon,  4 Dec 2023 04:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701693544;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FFtPPFlPjH6SVTrSMMFZ3PPUy8xNeziB9aHHtXxHnVY=;
	b=UwcVCVE2Gn26ki5ZPyKX8Ez4rSR/Ftv5OelqtDSUGonTDPFgKuJUqMX1qWV7aRzf95GVau
	jlBdKFxYDlik3qS0bRZiD9VoIeFFLlvhZj9xl8Ci9i7BuL79LWf4/FOsdFArdPIHHZ/BGv
	h+EDWeQ/Tc9NTcIlyhedELA9S7PL/f4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-190-lU7IH6F6PLG3lEMY958veQ-1; Mon, 04 Dec 2023 07:39:03 -0500
X-MC-Unique: lU7IH6F6PLG3lEMY958veQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-40b473b7014so6456125e9.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Dec 2023 04:39:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693542; x=1702298342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FFtPPFlPjH6SVTrSMMFZ3PPUy8xNeziB9aHHtXxHnVY=;
        b=OnoKXNPr1qokqLCLTlR6mPropRQpxW4EZA9ExxDFd5XqbG4NtvBpj93+fr2yt5Q8WZ
         d8i3hMErPD9MFfn5CVlw8l9P2gaNhwKw3dgif+fIpZrrFmAJCN9ce5htZm83OpI1nyGx
         IkLEM0YrnKC6o7Z2zwFo2efPcIkz3Pt/zDfBhBS7qzi9PO4IS6XFMrwKhjQsucC46Lw2
         XGcBCmYnGVfckjSukymQI4wcfx+1OxcrxCc5VeQXP2oQ58i8YfBy2mX2CZ/qj4fseXiX
         icgcMRiZBpo+9QqQ2Rc/T+q7LBErLBVwWknhkUDQbbc8qx9cNJ/8WEv6CmjvvSWmEIK/
         dO2A==
X-Gm-Message-State: AOJu0Yx+gVxKhET9bSpwZCebdbUXxoVy7ikr3LcnjG/eovNc+az3Ej35
	RKbCgaJfx4FUZnR4b2zlsUQ0IGWF2HohhmcA8niCa9+DQR49hn+VPqci1Ktv5JbnDcAz89r92uf
	Pe/cSsf5ZvTb87fM8FiPn
X-Received: by 2002:a05:600c:993:b0:40b:3d90:884e with SMTP id w19-20020a05600c099300b0040b3d90884emr20346583wmp.2.1701693542498;
        Mon, 04 Dec 2023 04:39:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEa9D3Oq68dv0QV+vUk78rlYYf7kq5RJzRekj2cg40Dksne3tRnoCEbe7teyc0q5ukqXIbMgg==
X-Received: by 2002:a05:600c:993:b0:40b:3d90:884e with SMTP id w19-20020a05600c099300b0040b3d90884emr20346552wmp.2.1701693542121;
        Mon, 04 Dec 2023 04:39:02 -0800 (PST)
Received: from pstanner-thinkpadt14sgen1.remote.csb ([2001:9e8:32c8:b00:227b:d2ff:fe26:2a7a])
        by smtp.gmail.com with ESMTPSA id d4-20020a05600c3ac400b0040b538047b4sm18355935wms.3.2023.12.04.04.39.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 04:39:01 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Hanjun Guo <guohanjun@huawei.com>,
	NeilBrown <neilb@suse.de>,
	Kent Overstreet <kent.overstreet@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Uladzislau Koshchanka <koshchanka@gmail.com>,
	John Sanpe <sanpeqf@gmail.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Kees Cook <keescook@chromium.org>,
	David Gow <davidgow@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Shuah Khan <skhan@linuxfoundation.org>,
	"wuqiang.matt" <wuqiang.matt@bytedance.com>,
	Yury Norov <yury.norov@gmail.com>,
	Jason Baron <jbaron@akamai.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Ben Dooks <ben.dooks@codethink.co.uk>,
	dakr@redhat.com
Cc: linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arch@vger.kernel.org,
	stable@vger.kernel.org,
	Arnd Bergmann <arnd@kernel.org>
Subject: [PATCH v3 1/5] lib/pci_iomap.c: fix cleanup bugs in pci_iounmap()
Date: Mon,  4 Dec 2023 13:38:28 +0100
Message-ID: <20231204123834.29247-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231204123834.29247-1-pstanner@redhat.com>
References: <20231204123834.29247-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
---
In case someone wants to look into that and provide patches for kernels
older than v5.15:
Note that this patch only applies to v5.15+ – the leaks, however, are
older. I went through the log briefly and it seems f5810e5c32923 already
contains them in asm-generic/io.h.
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


