Return-Path: <linux-pci+bounces-10016-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C0792C270
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 19:28:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2F461C22F60
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 17:28:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 830EB17B034;
	Tue,  9 Jul 2024 17:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UgUOSnJm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D0EF1B86C5;
	Tue,  9 Jul 2024 17:28:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720546118; cv=none; b=XGU0Zk1R2kKdMnbivBx8Y/+cH/aqQbgGOMjG7R7wot7cABgcHzErsP33ZzMg4xkJKLTCCNjlETAhsIoMOBlXDrIG+HVQLJHuvTFcKy0V2ejAWjnMIi8vt6F0PKoZo5NGjch9G7Cgauq33rzIa7k1BBj6VBeU/bsDw8LFHrYCNRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720546118; c=relaxed/simple;
	bh=Fh3+YN6x4wQRVGUysFM6HXguzt0afiR9ubQe7ALSnGA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k/p5hOcp3YYnUmzjTlk+OZaIDlIrBP/adyAD6AWs/PWL0QwJEoVXB45C2Uq4wlI5fVbLP91pWo0iMTaEJAgIwIHeLxNoRvVPL7k1EJhWZn/voL56vF7VRdbBuW+9QueoI2wzuHSiwlG63d8PsNebAZZsUGCTK34BWlPsg7MfPZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UgUOSnJm; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-70af2b1a35aso3534191b3a.1;
        Tue, 09 Jul 2024 10:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720546116; x=1721150916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W5KxrsmOj10YgMpkQiTq5L07X8mvZPUOQamgvBk8/U8=;
        b=UgUOSnJm2AQ0nNi8vBWKYtGlzM2ktw9XT004X9pp13ZUqVe3MKi8qIjAxejn54Yqee
         PslpHn1hJO5JxVfpDwyA+OmVsyGLZyzle2eEtfeJBe3ekdlp51k/8w0UWH27pIiUh+Qp
         OILpylrBC+V2eNTbQgJ5wJ60KbB0CfffA/Fe0H1i7HZKyN2BJV98gZKy42ltiLRtZ13m
         CiKO2y1kSLfZ7e80H5ajCLTrTlwHC73R5YeNOpX9mCHbAP3xqvlvfrcMFPzer1V2QOE9
         3PN0OS0rN+DOcVCRqH5wu7pRgrNStB2KXLPzIXh8M4hxTClUzwpHH9iUl7dfPQpctbIN
         LzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720546116; x=1721150916;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5KxrsmOj10YgMpkQiTq5L07X8mvZPUOQamgvBk8/U8=;
        b=ZZpr55H2FxNu7TwKkmN14/Dgh4LduHDWn2n4XHMJNSkKHVESG76wweGtI62dkUl8Vp
         aVkMMZE16bqDXjmjMJTX32RFOrAF5TrYnfyPyBtdVVPwL+bzG0VauTy38/CB82Led9yc
         4j0l4zWGDBFAqRsmzD6TOd+2ujpQpvlLRTmLQLmI4W/+uuQA2VHTdk7FaTWoZRrcy+b4
         lVUhEX3aiK4OVkKfyjKkrJNT90t0zmVDchJ6NioAU8wjToLHr3iDg+rZjtdqdWa4//fJ
         amp9gk7oBaSq8pmpMBrBxgyrl6Fk5K0KNFfE2sScjfZskV66bQpCX0jTB+nPa9HJg78P
         TxUA==
X-Gm-Message-State: AOJu0YyHPHKHEaTtquAde0Snl+HvURsqQA4G0N15aKwk9LgMr86/wgpT
	QjcqMmTn5Efr1oHe/eCv+kQlfovRKJK0fiLy5r7LVTXM9hz15sa+
X-Google-Smtp-Source: AGHT+IHX0VwQ8KFeA72DMn2B0pnWum1FSZBxM9VAb03ea80FtBUr6B3HAQxwxtpZ+nm8akmiHlx+4g==
X-Received: by 2002:a05:6a00:9285:b0:70b:1b51:b8af with SMTP id d2e1a72fcca58-70b43586d9dmr3679042b3a.19.1720546116369;
        Tue, 09 Jul 2024 10:28:36 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438c70a4sm2096867b3a.83.2024.07.09.10.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 10:28:36 -0700 (PDT)
Subject: [net-next PATCH v4 01/15] PCI: Add Meta Platforms vendor ID
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 Bjorn Helgaas <bhelgaas@google.com>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, kernel-team@meta.com
Date: Tue, 09 Jul 2024 10:28:34 -0700
Message-ID: 
 <172054611479.1305884.16620350406334873674.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <172054602727.1305884.10973465571854855750.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <172054602727.1305884.10973465571854855750.stgit@ahduyck-xeon-server.home.arpa>
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



