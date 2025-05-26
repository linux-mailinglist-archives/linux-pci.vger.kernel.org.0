Return-Path: <linux-pci+bounces-28400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F46AC3DF5
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 12:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A09C3B85D2
	for <lists+linux-pci@lfdr.de>; Mon, 26 May 2025 10:42:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372E21C07C4;
	Mon, 26 May 2025 10:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xaxGoRwP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81EB320F
	for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 10:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748256168; cv=none; b=a+51jase5kLDov/n8snLQVXk27+CG/Y6b+DW1vrIZuAoJJYmREEkfeLSx4PHxjrLP/M5liSNS26TXE9Trm3IQjqKYsqZvpEk0lmLbh8FFaYmuZKTlp/+PoYLuytfIj7X18xADBBHD2YaMV5nQKl/pSEW6Uoh1+9vPbmOuBKfFPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748256168; c=relaxed/simple;
	bh=fUwz1mg0Wq4VD3WtIWWxA+8j7o1n672LeoQiq7Dpqx8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Nw2vnPIZgMdZChY484iNmXXag9SjZ94igidRwD1brJ7rmyMvb0YqLQd9lh1WJ8nNi77SgVa85kOI1WSqXKt8xTmqThpmo52nVjn55x+3b/LojDTPfTbZcKbXhMSWQxG7EDhabZv1w0csDHDeY3epamRtrIVpJPD53xjHf0PiFpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--samikshagarg.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xaxGoRwP; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--samikshagarg.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b270145b864so1231675a12.3
        for <linux-pci@vger.kernel.org>; Mon, 26 May 2025 03:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1748256166; x=1748860966; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6SIGHh/Ha36Zobz2HnNwfDHbCE8x7N0HhlHgcxveQHA=;
        b=xaxGoRwPNN37qbI0T6m74sxPu6/Rtxpcfte78L1RsZJt3vGnwzjrBGFd5Y2ya/SqJV
         ZQmkmIzuudKC8OdHqfMBbMYufggsZet2OjYBmSJU/1tcSHpu1UVFUeQ/bumJ4Qh/Ypsk
         EGQpDVv3LNkfD1usTyDOuow8PVjVGMZ899AUOA7m31Czhg5NZrerbDuW1DzwMVKYbfBF
         7H87COHOpTpE66Nzw1DEAHOQnUIbKij+3U25L6MhrfOFjW1BRkKBIW1c5ub+ySjh7QwE
         Gyi0/0z8wc8/47/Z604Pot3FJmSjkiMXxJq9rLASrtbOHA1rcCTHApRRQIcaYrSAQiJo
         KELA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748256166; x=1748860966;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6SIGHh/Ha36Zobz2HnNwfDHbCE8x7N0HhlHgcxveQHA=;
        b=s7r5QUqqD6/OXY1L65W0hwJAg2YtAqFPEJ0UFxZydUQC9JlEU1Iz0hhiolDfCatzQu
         Oic1OIWe1p36pORBtm6R7IXKBoKOE6b5StMc43/GK15ps96hJmhbMkI5+J8FEcRcqSbI
         ZnUmNR27fUYkAp2q1uD5/NHkjfZdyo6UyFM3FoRSF0s5ekpc3aCeclpHgNHcGwDIq2wO
         QfWN6kE1KqDLBlmvGW8Ifl/vwOLvzGOi24z8g73C+BiNL8NRRJ0gZGFQoJrvXBVPeX3C
         2inkrztirTVIMa9XuaJX0stzegGWn/KmRwNNVgkgAmgGoSZfBtiBSBXf/K5pclJzeXdh
         ZtEg==
X-Forwarded-Encrypted: i=1; AJvYcCW82MhhA+NzDAqaCH7Jo/78ZYHQaJflQOw7ftVVXFN45NBHrOWB1Jfmgpuqjh+WNYJBXWCJ6FWOM+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YypuQLFiqlICvQ6pOc8IubQnP7pCvyXp7H1OIYLTXMM4sw+vVLg
	/HdvW7pKIifRZrr5ujiTrIvZPhRj7bSAnddJ7skVbZScEI8iDyZUG4lWIUsZpOklcwPEE4uJbax
	JMPj+Gp7+sqIZSfEuD16v6I1L2gKoaA==
X-Google-Smtp-Source: AGHT+IH4OyNSNtJ26a5M47mrX+mmEIiibwfws1X+hbtf3HjwQ6a6qw6EC8HmBGPRonRaoHJ/yHllcDRSoln/lJg6O0k=
X-Received: from plk21.prod.google.com ([2002:a17:902:e9d5:b0:234:4c97:1e83])
 (user=samikshagarg job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e881:b0:22e:50e1:746 with SMTP id d9443c01a7336-23414fb2517mr146619145ad.36.1748256165984;
 Mon, 26 May 2025 03:42:45 -0700 (PDT)
Date: Mon, 26 May 2025 10:42:40 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250526104241.1676625-1-samikshagarg@google.com>
Subject: [PATCH] PCI: dwc: EXPORT dw_pcie_allocate_domains
From: Samiksha Garg <samikshagarg@google.com>
To: jingoohan1@gmail.com, manivannan.sadhasivam@linaro.org
Cc: ajayagarwal@google.com, maurora@google.com, linux-pci@vger.kernel.org, 
	manugautam@google.com, Samiksha Garg <samikshagarg@google.com>
Content-Type: text/plain; charset="UTF-8"

Some vendor drivers need to write their own `msi_init` while
still utilizing `dw_pcie_allocate_domains` method to allocate
IRQ domains. Export the function for this purpose.

Signed-off-by: Samiksha Garg <samikshagarg@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index ecc33f6789e3..5b949547f917 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -249,6 +249,7 @@ int dw_pcie_allocate_domains(struct dw_pcie_rp *pp)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(dw_pcie_allocate_domains);
 
 static void dw_pcie_free_msi(struct dw_pcie_rp *pp)
 {
-- 
2.49.0.1151.ga128411c76-goog


