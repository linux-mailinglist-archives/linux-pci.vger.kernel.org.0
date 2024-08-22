Return-Path: <linux-pci+bounces-11984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7040995AF85
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 09:42:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C55D283237
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 07:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A29E3165F10;
	Thu, 22 Aug 2024 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C7MPBGFC"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05260154448
	for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 07:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724312539; cv=none; b=YHCtbNLEKt/7ApjC8OF2kUdCUlipa/Kd+f3QN24yJ74h7clRQUrPJDOG0Nrj0ov/1Hwo1xcteRPuIGY02qfDDWPv9+lbgFBua6NXw0Ksh0MaiIMhIDZVWLMWbcHNybQRjefOjV2sme32oBNvJjvodhp3CrwAKVyCBPKqgqWtDDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724312539; c=relaxed/simple;
	bh=YSAwNeyg69fJMyPt1ovAVwmgX6pw6P+wSZYD+y6HIIE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QY+1wDFqEu13tg4gpRmjEUAIbCb4RlGpX/mHrEkjKw0/2hNgxYYDf8ozLW6Ld/TlrZuApUEQUWpye48V6DZA7BMggtGTIZLXyoG64Aks6bCMkaqsHCg6czZdWTWeauttj7decSNybXFQWeLV6/uwQvMp+T1fjNWLLbGhNpSLGFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C7MPBGFC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724312536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Qeaxowy9FkN+6LhQhAJTapPp7jhqCmRI6C39kG4kUWo=;
	b=C7MPBGFCeNoijvxu8WyAf7xwngnUJBAhSm0a0oNAvYx1pcwnSTzbqpdPby50dRceN80VeQ
	FOBWft+DCoVnU1RzVwK+Wh+h1VoylvJEB2tOA/lbFZa9RuybosDRJGJAyTm38IgJcswHbO
	ZVtMje/SBKhMZGqDYqvJKcxs/mOaV6I=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-G0m7Si3XPt6cguLJAz5y0A-1; Thu, 22 Aug 2024 03:42:15 -0400
X-MC-Unique: G0m7Si3XPt6cguLJAz5y0A-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a66bf35402so59161885a.3
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 00:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724312534; x=1724917334;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qeaxowy9FkN+6LhQhAJTapPp7jhqCmRI6C39kG4kUWo=;
        b=Hx7aMNY2EFjGl6TJ9h8Dh7dOd8S2XIV6uOC1iWP4om6pfA9qnpFen0vgupZpMjaSLT
         z+nuEoNP5L7lg4PlPx3EJWBV+w4RgY5PVusF4DoXr8ZP3k6oHKZO2zuPGncgKJsReHfm
         cPoGsXmAoekNSHryoD3Irpn2KnBG2culXhGw+bRdeP4SDO33750rUCJPIQIcGaFfrXPH
         uD67unpTfQf/ggs2SZDyhJnuEdkQ6VFUuOIgwZA20eDjr/CYOx+6DVBiXz59ce4L1I5M
         IKpGDnycgbO1qObTH6mCeptvqvjamnSvgov1LiZQ8wZYqt7+ej4Q1wG2K4yA+MeiXgcJ
         4cKQ==
X-Gm-Message-State: AOJu0YzxyVaXevrkcNUR4d7rhE2CBzY4oGxXERRQRNV8ttsuEwxKNTCr
	+r7Df2f5wPJJfza/teZ60lb2cw35YcCvmJpj1NDivQFoON5ldc2wX4XrWW8lTsRdljkq9EXIjdT
	yFKa36gF2bGFCHninEvuhmoKkTSEhJ8VAN9i0817MOJhIlR67+a+zOCo35A==
X-Received: by 2002:a05:620a:2914:b0:7a2:16f:a7d4 with SMTP id af79cd13be357-7a680b37624mr84907185a.59.1724312534570;
        Thu, 22 Aug 2024 00:42:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLpDWyP0WjL1P9bD8La920CyTDVGs9PsV5ciIX2srhEQbPEJBV6oZrk7ge23TddAvxRqFXpw==
X-Received: by 2002:a05:620a:2914:b0:7a2:16f:a7d4 with SMTP id af79cd13be357-7a680b37624mr84905485a.59.1724312534158;
        Thu, 22 Aug 2024 00:42:14 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f3199dasm42993085a.15.2024.08.22.00.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 00:42:13 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH] PCI: Deprecate pcim_pin_device()
Date: Thu, 22 Aug 2024 09:38:16 +0200
Message-ID: <20240822073815.12365-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit f748a07a0b64 ("PCI: Remove legacy pcim_release()") the only
thing pcim_enable_device() does is set up the cleanup callback
pcim_disable_device(); the only thing this function in turn does is to
disable the device if it has not been pinned through pcim_pin_device().

Previously, pcim_enable_device() had set up several cleanup callbacks to
iounmap BARs etc., which made pcim_pin_device() necessary. All of that
is now done through separate interfaces, however.

Consequently, everyone who does not want the device to be disabled on
driver detach can now simply use pci_enable_device() instead of
pcim_enable_device().

Mark pcim_pin_device() as deprecated.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
I am aware that there are only 16 callers.
Porting them right away is a bit tricky, though, since you'd have to
replace their pcim_enable_device(), which still activates
pci_dev.is_managed, which still affects the code in pci.c

So I'd prefer to postpone removing pcim_pin_device() until my ATA
cleanup series is done. All that might take a few releases.

P.
---
 drivers/pci/devres.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3780a9f9ec00..87a125cc5207 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -520,11 +520,15 @@ int pcim_enable_device(struct pci_dev *pdev)
 EXPORT_SYMBOL(pcim_enable_device);
 
 /**
- * pcim_pin_device - Pin managed PCI device
+ * pcim_pin_device - Pin managed PCI device (DEPRECATED)
  * @pdev: PCI device to pin
  *
  * Pin managed PCI device @pdev. Pinned device won't be disabled on driver
  * detach. @pdev must have been enabled with pcim_enable_device().
+ *
+ * This function is DEPRECATED. Do not use it in new code. If you want the
+ * device to remain enabled after driver detach, just use pci_enable_device()
+ * instead of pcim_enable_device().
  */
 void pcim_pin_device(struct pci_dev *pdev)
 {
-- 
2.46.0


