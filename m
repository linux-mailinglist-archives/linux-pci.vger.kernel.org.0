Return-Path: <linux-pci+bounces-10209-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EACF492FDD7
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 17:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8CAA9B21A66
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jul 2024 15:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE942174EC8;
	Fri, 12 Jul 2024 15:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhBp3UcY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 672811741FF;
	Fri, 12 Jul 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720799356; cv=none; b=HkFZmygQSlDPA4fIFlF3Oa9rAjJP7PQJC2nFIuve4kZiYzydUR0qt3X4hoN8HyDzYrof855EaRZKdEXok3gH3hnUE0kL3IyB8Y9nWJDacTYv3sfx+9WI8d4vGcYkWxvPb3kcAzQtrJASGcanpxVWHb39vI3rYcvjg3xz7v9eSsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720799356; c=relaxed/simple;
	bh=Fh3+YN6x4wQRVGUysFM6HXguzt0afiR9ubQe7ALSnGA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RYCjwysEYGJ6HyxUZvawNeTT4L/hz8hkxFmxQD1bMuz+EbcK6h2Sx/U0sfeCEWbhUFl8AQbu97PSL8MsMJcTJ62b9q98f1YV/yPRcm93MhHhYYBABGGN9/6rSsGHB8q4YrdeX2t8jSC5egCrCBM5r11e2cN8jgbmILgmoAwws8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhBp3UcY; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-75a6c290528so1480970a12.1;
        Fri, 12 Jul 2024 08:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720799354; x=1721404154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=W5KxrsmOj10YgMpkQiTq5L07X8mvZPUOQamgvBk8/U8=;
        b=KhBp3UcYQZam+1zgsinz0LZ7TBjVoG3J8Cexo1F+alaIY3BBbbx1a+CwzuRySLubak
         h0R+RYhFiAQTZj2JKS8Yz4meKNO9jaUelj2pKgj4SY0EUMIoJMjt26osNY0h2peTHh5j
         3HUMaMaH5CTRlf3+BekqDK61hwEoNLGX6DU/jBkkmey39k/XNWUWQsZC2vE8YCm3ED/E
         DFCUn3h9d8a4FeZdWXrGUMGNYnt4rQd5gpUMq9ZZ+Wj6z2pt7exD/dY7X86jPBnGk8pb
         5bMvEtpxJtFVkvp2oyGsDO3dNmB/Xp4UPY5+E/0ilJkyyozLIu3XkPdz8caYehz9e7xz
         WJ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720799354; x=1721404154;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=W5KxrsmOj10YgMpkQiTq5L07X8mvZPUOQamgvBk8/U8=;
        b=XtfBzt+7m5BVvo23k9HPNpU0TXnGQwwMRs+FNlBj/mT557I4qD5vMyvqM3UmfaRl5f
         ttloZPHinp94ARv3OK7yJocrfiMhweQxlafBA/taUFYyYL9Lhk2htUARWWiZZBxwTGb/
         jpGyJR3r+xP5w9dzXlwHcUCzNDvvQtPdPeaR2oY9fwU3i/OG/Sc+f+U7x5GX1x6Q/B9d
         XY4RzwJm2Do6/CouVDRqyOCkkcNYYSL02LcBEvOuaYzYKy8hLMXFyEW9UaueF0XVtoBD
         934t/Dvq+g95LpGePuF/++YPAJKYz4Z/6C+NtAEU2o1W3IZHED3eoADpE/nNQZS55Hpz
         +N4g==
X-Gm-Message-State: AOJu0Yx6nCO6MxyLKuYOVOkABXmxPB2F+7mlGtC6XauTtYLgbepefaMY
	C0iJKFimys74TuTRGFf1puMCUASDj/bzq/lWi+4lkh7pHhq/TsM7oYOk1Q==
X-Google-Smtp-Source: AGHT+IEZ3xOyM2z9grn3qrk2AnL7c58B2pqHUATRWF8aRKGpck+f0/AMR/5xAzyLXl7ILYQ1Hz3qFA==
X-Received: by 2002:a05:6a21:e88:b0:1c3:b2b3:442d with SMTP id adf61e73a8af0-1c3b2b3448cmr6159536637.40.1720799354290;
        Fri, 12 Jul 2024 08:49:14 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.103.43])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b438e53a7sm7671150b3a.88.2024.07.12.08.49.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 08:49:13 -0700 (PDT)
Subject: [net-next PATCH v5 01/15] PCI: Add Meta Platforms vendor ID
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-pci@vger.kernel.org, Alexander Duyck <alexanderduyck@fb.com>,
 Bjorn Helgaas <bhelgaas@google.com>, kuba@kernel.org, davem@davemloft.net,
 pabeni@redhat.com, edumazet@google.com, kernel-team@meta.com
Date: Fri, 12 Jul 2024 08:49:12 -0700
Message-ID: 
 <172079935272.1778861.13619056509276833225.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <172079913640.1778861.11459276843992867323.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <172079913640.1778861.11459276843992867323.stgit@ahduyck-xeon-server.home.arpa>
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



