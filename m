Return-Path: <linux-pci+bounces-35342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 218EEB41045
	for <lists+linux-pci@lfdr.de>; Wed,  3 Sep 2025 00:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 482C5178E9C
	for <lists+linux-pci@lfdr.de>; Tue,  2 Sep 2025 22:45:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF35C27A12C;
	Tue,  2 Sep 2025 22:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RxpPvYvg"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C0A2798FE
	for <linux-pci@vger.kernel.org>; Tue,  2 Sep 2025 22:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756853125; cv=none; b=SHodTvqTgYdhgupLqage0A+9b4gxOdx0i/jG9Uo17P1zZhVZJSJJOLJUfEe63o3ExLgWV1R9Qs0TBun3XsKJBqyY2fzaOasWajWArLLjY0R1ffXeTtuBMHbZlKqpIAf+VksnUjbGspoNm6M3IM9AJd47+AkaGcRmOzMC6R9iDzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756853125; c=relaxed/simple;
	bh=za1IhyeT1KHUL8P6O84MBxuBubv4gycG9hGlmDgXhbM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Py4H7BwkBLL0QykL8dD+FlEDhlnpJFTsxbAHXWfrExIC1pNFrlL3bg5hzacN957ypRuCVNZ33pOOpWPhkiwfxOwCwXrPoiPu1rB6OXKQR5UoaEONs0gJNN77EeILf0IV/IIXOF0r8KhNXjIKXwl7grDfKgIb9gjn1jm1zFAkPdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RxpPvYvg; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756853121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=RJyVMg+m0HnoyVkyf5gUwY/kUFpbW+dsoDfxJhmLAUE=;
	b=RxpPvYvg0aNFKGGWWXDD1mI5YJSOYjOAXwMVSOUWBjrGobk9rsuofKQ3K+K/cDboOMZXuB
	D4OUJYSF1sBBZMwE2bk49GNaZyveqpBvR8fEORtomnjYNsaOYmP87Pftu8fzlOQLcdvUa0
	B1dxoFxf70tJJUdKzQLjrxMHCZXjmP0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-671-0HAwu_KSOEaOu2webprExQ-1; Tue, 02 Sep 2025 18:45:20 -0400
X-MC-Unique: 0HAwu_KSOEaOu2webprExQ-1
X-Mimecast-MFC-AGG-ID: 0HAwu_KSOEaOu2webprExQ_1756853120
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70dd6d25992so110353506d6.2
        for <linux-pci@vger.kernel.org>; Tue, 02 Sep 2025 15:45:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756853120; x=1757457920;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RJyVMg+m0HnoyVkyf5gUwY/kUFpbW+dsoDfxJhmLAUE=;
        b=ABLQthpPNwLZdGmYRAwkazLjE9c/jiwkMEhg1/fB+aIw6TzjuUTg8KuD0kKD7G7t6q
         u9s55S4JZe+WjXcLVQXaWxsAp07oXlkjihE+CIBvXEzp2/j9AfcXR5JN/0kjzUI7ED/1
         LXjs1TT6E9yKkhz3hOPLRxXBk75V2AL18XEQqA2Ml7CWY1sOFnBBp7DyLEZJ7WR8V5Vy
         jo+85IkxRWRvNV/yv8+d5VEZVkQbMQ4T2GANQ7QHhSPm2C1vbwSBVpx8xtvDKWybhBXe
         FbLILeT0/4vqtLgi/gyX2afzpKTNReQxLXkEssixlb8eOreZu2+71PDFK9TaaSki74t8
         LM/g==
X-Forwarded-Encrypted: i=1; AJvYcCX0/WvxwRi7tpIgyNDee/9wUawINhrRQG4FEOEipcVCs4xIiuwAdAMRJGmbHR83IbAEd3eRTSZhc+E=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIS4H8gUEjSiBCkShm+9xDeNfHwkER5di43ccHUrByZAr9W8Ba
	BEnzdHcNvQJMdwT4amFAsTg4TKDUvpu62N4H6zkE/nAmbZan6wfP6ABw2o0J/jjTHwgo7KV0/7X
	bwAHDhwhLy447ZA/lFGVOdlUGEAtN6iAjlO+qZp5EFZnE/lIR0qrr/Fnnt6UOlQ==
X-Gm-Gg: ASbGncu3kT90N1RhmROjcfVgVMuRbuXN7qmnT7CUfVx0C/0rp/+ps6NBP17M1k0ffZJ
	qsGqdN23/lZSgLNrs0HUlv6aipj+aNRKYrVSpfEgqvtHw0MjNvq8eXkTsbXVzrwvGbN/FSZaikF
	Gy6c1Bmk+LLZx/Tl90EVLaH9JzJmNRF+kluz6hNJPvBymq8wujoHIkgO9Pr/0aIPM5qnqAdcOCK
	kRUXkDF2pQvGnUNOVkElRj7HGWgzGj0ps5IzrBoxws2QqhoxskdbCaO4e//zfrHdeXQGI9wJh1c
	J3tIKiQ0QY83sDNTKtay9nEJ6h+OQmWfOtCwJ0ygAt4A6kZxzCpPsYjG08CoMOuI4Ob1
X-Received: by 2002:a05:6214:62d:b0:70d:6df3:9a7c with SMTP id 6a1803df08f44-70fac91f549mr163001526d6.60.1756853120047;
        Tue, 02 Sep 2025 15:45:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZJ7Rb63m7d1x/fV7yb6DC5dPEHvsph5C1Gwo41SOjU8ruCfu4BA/m7dr3bqjoAfkOYnnrlA==
X-Received: by 2002:a05:6214:62d:b0:70d:6df3:9a7c with SMTP id 6a1803df08f44-70fac91f549mr163001246d6.60.1756853119647;
        Tue, 02 Sep 2025 15:45:19 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-720ac16e430sm19861206d6.5.2025.09.02.15.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 15:45:19 -0700 (PDT)
From: Crystal Wood <crwood@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Attila Fazekas <afazekas@redhat.com>,
	linux-pci@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	Crystal Wood <crwood@redhat.com>
Subject: [PATCH] PCI/AER: Use IRQF_NO_THREAD on aer_irq
Date: Tue,  2 Sep 2025 17:44:41 -0500
Message-ID: <20250902224441.368483-1-crwood@redhat.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On PREEMPT_RT, currently both aer_irq and aer_isr run in separate threads,
at the same FIFO priority.  This can lead to the aer_isr thread starving
the aer_irq thread, particularly if multi_error_valid causes a scan of
all devices, and multiple errors are raised during the scan.

On !PREEMPT_RT, or if aer_irq runs at a higher priority than aer_isr, these
errors can be queued as single-error events as they happen.  But if aer_irq
can't run until aer_isr finishes, by that time the multi event bit will be
set again, causing a new scan and an infinite loop.

Signed-off-by: Crystal Wood <crwood@redhat.com>
---
I'm seeing this on a particular ARM server when using /sys/bus/pci/rescan,
though the internal reporter sometimes saw it happen on boot as well.
On !PREEMPT_RT, or with this patch, a finite number of errors are emitted
and the scan completes.
---
 drivers/pci/pcie/aer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 15ed541d2fbe..6945a112a5cd 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -1671,7 +1671,8 @@ static int aer_probe(struct pcie_device *dev)
 	set_service_data(dev, rpc);
 
 	status = devm_request_threaded_irq(device, dev->irq, aer_irq, aer_isr,
-					   IRQF_SHARED, "aerdrv", dev);
+					   IRQF_NO_THREAD | IRQF_SHARED,
+					   "aerdrv", dev);
 	if (status) {
 		pci_err(port, "request AER IRQ %d failed\n", dev->irq);
 		return status;
-- 
2.47.1


