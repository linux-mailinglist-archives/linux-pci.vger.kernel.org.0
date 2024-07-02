Return-Path: <linux-pci+bounces-9593-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE8A9241A8
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 17:00:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3F71C22A4E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 15:00:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048BB1BA89C;
	Tue,  2 Jul 2024 14:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jIxXEhEt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955AE1BA89B;
	Tue,  2 Jul 2024 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719932387; cv=none; b=JG09qMgOVUALq7Q+JGU596Z/8F0MxLQhhNHl6cruCqfZ/kW8QlRgzwcNIK4KJSDNcm8Rv/ob50lrl0tixns3PgB3uXMw/3oS4FHJfZZhE3KOpTXG8kMLHyjkG4G6QJgKwkROORaRo6FqpyVWmWL/9FAQCSn9NhQeGEHqgKXehT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719932387; c=relaxed/simple;
	bh=Fh3+YN6x4wQRVGUysFM6HXguzt0afiR9ubQe7ALSnGA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DL/5/2zohCYpUNKNUulfLIScNQ/6grTesj2NGPToZRRRtz/CZ7ZWPzDitg15/kBXRF280ASh+6I0EW60u4RK8hHilGVEz8PDwl9JoidBZd1VNgLca0q3emJtLh+DsKL2j+pJEaeiJNkChwcYfcwWnhUTv3r0LQb7ETRaBteKLPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jIxXEhEt; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1fb05ac6b77so3829525ad.0;
        Tue, 02 Jul 2024 07:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719932386; x=1720537186; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W5KxrsmOj10YgMpkQiTq5L07X8mvZPUOQamgvBk8/U8=;
        b=jIxXEhEtcHFXQgQFOewk2fQpiSRYSvyb4NErdMGhHWpXJV+pd9qBqWXeQVAtFAgXps
         1Nu/99Ztc3EqZ7784Xo5iIL71fzmmEDkUhri9Mds7HOQgqjatFtjlFgQ7zxcrVQZjvIg
         Ea1xnrpyaiP9zuPSIUxvaXlnOr18ftW4qDbMVj4yJgucVL1ATV6lOkXO0wgfJxiiTz09
         cUfd6ftHtElryRGCRZIj1W4YWD+7Ho4FDPRkmEj99hc3cQS6yaLLCIAj98d7T4m+VsdI
         aneuiRaDxnZdo6mUudNXMkx568vuOWczEssS/lRNBbyWMsgy2Qpxo4jV9oICEum2RzFH
         ainA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719932386; x=1720537186;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5KxrsmOj10YgMpkQiTq5L07X8mvZPUOQamgvBk8/U8=;
        b=v1gW75uIx2fqfrWmId+ufdAQwl2rMQ5WAKkF6h2QyOXIeHW3Wjl2L0O1iFbhKApdBI
         cPWGTkLumvFkkOG/DAHNY2Po9iM1UtxMTgfukiENym8fN3x9usIfF8W06kMhx3qpTaPl
         pkEShrrSyxn9BIU+H77+sz+z+Hv0mweKJ8CMqfaM4svtuafhNs9C8K3oiM7vSbTS7rxZ
         YRlkvCV29A+3bsmNVx+iIJqXfD1KNtGoeuo9mf8q7ORUurzoyk3wx0tCxB1LxpXu4P2v
         v2/pJNdNtUqHP5laQ7ogCfQ7syckjvtYds8ZqxMwwU3ZiZsSKieIGdTyvwMuoK1k8ujC
         fQ3g==
X-Gm-Message-State: AOJu0YyDHXlk71GvI0mCv3z7j64HIf2liE2jsbN/DRkdnaFPBDrqp7dw
	xukEDB5ugq/1KkRiXDmPeSicPPDZZdju44sNO2LLcwUghlYDEkwI
X-Google-Smtp-Source: AGHT+IFDDCvFuxeptKDKcLHip+haknm5pexdd7iGWd1ib7hCLFYU1hypdbUH5b1ta55zHKsTHuJTBA==
X-Received: by 2002:a17:902:d48a:b0:1fb:3a7:11ac with SMTP id d9443c01a7336-1fb03a713d9mr9605935ad.32.1719932385842;
        Tue, 02 Jul 2024 07:59:45 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac156948csm87247715ad.221.2024.07.02.07.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:59:45 -0700 (PDT)
Subject: [net-next PATCH v3 01/15] PCI: Add Meta Platforms vendor ID
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 Bjorn Helgaas <bhelgaas@google.com>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, kernel-team@meta.com
Date: Tue, 02 Jul 2024 07:59:44 -0700
Message-ID: 
 <171993238433.3697648.15891502416828493637.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <171993231020.3697648.2741754761742678186.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

Add Meta as a vendor ID for PCI devices so we can use the macro for future
drivers.

CC: linux-pci@vger.kernel.org
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 include/linux/pci_ids.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 677aea20d3e1..76a8f2d6bd64 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -2601,6 +2601,8 @@
 
 #define PCI_VENDOR_ID_HYGON		0x1d94
 
+#define PCI_VENDOR_ID_META		0x1d9b
+
 #define PCI_VENDOR_ID_FUNGIBLE		0x1dad
 
 #define PCI_VENDOR_ID_HXT		0x1dbf



