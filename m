Return-Path: <linux-pci+bounces-35856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB90B52067
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 20:49:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2C0447B7B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 18:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D640299947;
	Wed, 10 Sep 2025 18:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wow6v4bd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4ECA27381E;
	Wed, 10 Sep 2025 18:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757530136; cv=none; b=dLxReQhlAH6NEUL1OUfd76H7Pu8hD54T1SobOFxA41FOOyxI+UyTtd2U8a04kOof0aMRHFsYSs1mbnXVjmsOWtTkG50AgGZQPEfVuTIBTFXUYOI0GEdSM53w5SucXAAH1G4zUSQjydqRd1/VTgE5K7kXjeyhhpsW9unD24cCB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757530136; c=relaxed/simple;
	bh=4ORbpdMUpYNGJsNem4Iy7fPKZBEsyh86L0Wxrru4w20=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oAm/nLIZcV623YFSQutoHROBBMpQyt7oZqAf7AAV2Qi3MeYDJLNqo/HC9E4kf/8cM8xwiyoFbUHE+uEmcWqUAM46dmaTO6C/C707qgTuM1RIntWXb9INyuvPzoQBS0MUqdfm37GnrM2DatBdpfQcPZFlJf05RiCyO9f8BVYUR+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wow6v4bd; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4b6304714a1so7036871cf.2;
        Wed, 10 Sep 2025 11:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757530133; x=1758134933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9DhJOzemU6EaJThIiquMzmhs8hxD9vT8pUjHzzfSgf8=;
        b=Wow6v4bdmqHH9lpZ+vOFlugaLgM4wCffppcVt6G1nqB4KzTGo428T0glljuc9wbPuX
         lPK/8iA2fBEMGU7g7Aw5fpbtIWcZNIWpm5GSNzqu0uJiEZ1VG/zdtY4sTNoibGOl1fYl
         WZTieqlLFSVXIUct91n7zqCI+FYhq/qFsUmjt5WploNuA4GasylJ9uOORC2uhB5NG2ze
         QctgjFwMxtEl94Ucad9rQnFoGOqrWo98+u47iayGgV6U0COUHtT/6R+WH6h7xxka1vVC
         XiuaR8a88gQL5JyhdURVHCUCggjbQukC00Ud3CW0Rbw0Hf0ukzGsSJwCRfYyor7Tj4Kf
         EdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757530133; x=1758134933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9DhJOzemU6EaJThIiquMzmhs8hxD9vT8pUjHzzfSgf8=;
        b=eWRxU9DVFl0WTW2b+q100LDyIlR9NezlaUgbHMRktLSeNfH9T5/sfek8Q76ItoTwv3
         048kiwpHKDnz0J9r4vs6ZDdv2GZt6gDKYdl0uzeWNhRm6XhORWeoW9vJRvrMRIDKn/mp
         dh70kO6uecswX0+zY2jfqTuH8mwzupls6kjZgoisTWRtGWAVY4SEAKuC9GwsGuvLZh07
         4sJRTmSz50+x6JMqG9QjuVeSo5GqCbfbce7i+4Mh2YB2s8sxFw0RBJPNTk6mkqQuVAKX
         awVh9fNnduT51ywSAn69LMx7EPNJearY7+T069xcpr9kUcYcmtzlqODJpK14Y/X12SHK
         HRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUy4qtMj3YgyCLJRU3KyKH1z5XMNxvaNtTfhG1zML7HdGxCk/oIkTTLyTvHRSuJhZso9WfGkpJ8pPTA91Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxJbUtUyAx6KHPj9JpD87VhGV58U4UzMMyXaMKnAR79ea1lB4Q
	05n2TVfN9rdtebRN4gVlGluc0oBeMFDlEbFSlIpKV9Rr/zWhh8WFFPg3
X-Gm-Gg: ASbGnculN/q1s38apNt6TPOoq6I88MUZxmCq3L5TDJWSLZYFNzrGsGEyuuZ/KR8JwPg
	Qt6ESIH8j5tZQvSYPuNvSFVHXg727MkuwNhIkqM/YRz7ZFmghgZBlOg7w52UCCsVGKPSLGKB24q
	lWwKZ7F6sSW3aHB3vZCdsgb0ki4sOUUGmAsBuda9OX+SnJD6c7ngr6VqH/uAm4JvWeW6NNwtUhZ
	7uBYo7xU51stDjfe/EjMOgKQiq7H2v33PUlt4gADPU1oRAfWXSCjWOx7YepyoKGHguDQfPeFhJ8
	b+rZmQ1Jg3D8IH5egca4b7Z7wnhV07aVNrDmZ1vhCLVd55AvRdJi9ImyZ9vYop8DgsnjqI7pl36
	7MJVFeY1B8tjeu2WZqh1QWyywE4FAfARSUao+PTEnbqj3o3434yC79B1dDK4CTgJfhPX8t8WRzB
	nMnI7c1Q==
X-Google-Smtp-Source: AGHT+IHZ4XDe+siBts0szSeE7KvT1HEvIJV4FJIJ1DHOqtVs2/ICpzbYcgku3ytPvAnOp9zFhHL78A==
X-Received: by 2002:a05:622a:1a19:b0:4b3:b34:9395 with SMTP id d75a77b69052e-4b5f846e130mr136899911cf.65.1757530133278;
        Wed, 10 Sep 2025 11:48:53 -0700 (PDT)
Received: from instance-20230512-1534.taildd7ada.ts.net ([158.101.111.136])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4b62e251ccesm8896461cf.20.2025.09.10.11.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 11:48:52 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roshan Kumar <roshaen09@gmail.com>
Subject: [PATCH] pci: access: fixed coding style issues in access.c
Date: Wed, 10 Sep 2025 18:48:09 +0000
Message-Id: <20250910184809.392702-1-roshaen09@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed coding style warnings and errors in drivers/pci/access.c

Signed-off-by: Roshan Kumar <roshaen09@gmail.com>
---
 drivers/pci/access.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/access.c b/drivers/pci/access.c
index b123da16b63b..5ed434d3763d 100644
--- a/drivers/pci/access.c
+++ b/drivers/pci/access.c
@@ -25,16 +25,16 @@ DEFINE_RAW_SPINLOCK(pci_lock);
 #define PCI_dword_BAD (pos & 3)
 
 #ifdef CONFIG_PCI_LOCKLESS_CONFIG
-# define pci_lock_config(f)	do { (void)(f); } while (0)
-# define pci_unlock_config(f)	do { (void)(f); } while (0)
+# define pci_lock_config(f) ((void)(f))
+# define pci_unlock_config(f) ((void)(f))
 #else
 # define pci_lock_config(f)	raw_spin_lock_irqsave(&pci_lock, f)
 # define pci_unlock_config(f)	raw_spin_unlock_irqrestore(&pci_lock, f)
 #endif
 
 #define PCI_OP_READ(size, type, len) \
-int noinline pci_bus_read_config_##size \
-	(struct pci_bus *bus, unsigned int devfn, int pos, type *value)	\
+noinline int pci_bus_read_config_##size \
+	(struct pci_bus *bus, unsigned int devfn, int pos, type * value)	\
 {									\
 	unsigned long flags;						\
 	u32 data = 0;							\
@@ -55,7 +55,7 @@ int noinline pci_bus_read_config_##size \
 }
 
 #define PCI_OP_WRITE(size, type, len) \
-int noinline pci_bus_write_config_##size \
+noinline int pci_bus_write_config_##size \
 	(struct pci_bus *bus, unsigned int devfn, int pos, type value)	\
 {									\
 	unsigned long flags;						\
@@ -72,17 +72,16 @@ int noinline pci_bus_write_config_##size \
 }
 
 PCI_OP_READ(byte, u8, 1)
-PCI_OP_READ(word, u16, 2)
-PCI_OP_READ(dword, u32, 4)
-PCI_OP_WRITE(byte, u8, 1)
-PCI_OP_WRITE(word, u16, 2)
-PCI_OP_WRITE(dword, u32, 4)
-
 EXPORT_SYMBOL(pci_bus_read_config_byte);
+PCI_OP_READ(word, u16, 2)
 EXPORT_SYMBOL(pci_bus_read_config_word);
+PCI_OP_READ(dword, u32, 4)
 EXPORT_SYMBOL(pci_bus_read_config_dword);
+PCI_OP_WRITE(byte, u8, 1)
 EXPORT_SYMBOL(pci_bus_write_config_byte);
+PCI_OP_WRITE(word, u16, 2)
 EXPORT_SYMBOL(pci_bus_write_config_word);
+PCI_OP_WRITE(dword, u32, 4)
 EXPORT_SYMBOL(pci_bus_write_config_dword);
 
 int pci_generic_config_read(struct pci_bus *bus, unsigned int devfn,
@@ -226,7 +225,7 @@ static noinline void pci_wait_cfg(struct pci_dev *dev)
 /* Returns 0 on success, negative values indicate error. */
 #define PCI_USER_READ_CONFIG(size, type)				\
 int pci_user_read_config_##size						\
-	(struct pci_dev *dev, int pos, type *val)			\
+	(struct pci_dev *dev, int pos, type * val)			\
 {									\
 	u32 data = -1;							\
 	int ret;							\
@@ -247,7 +246,7 @@ int pci_user_read_config_##size						\
 									\
 	return pcibios_err_to_errno(ret);				\
 }									\
-EXPORT_SYMBOL_GPL(pci_user_read_config_##size);
+EXPORT_SYMBOL_GPL(pci_user_read_config_##size)
 
 /* Returns 0 on success, negative values indicate error. */
 #define PCI_USER_WRITE_CONFIG(size, type)				\
@@ -268,7 +267,7 @@ int pci_user_write_config_##size					\
 									\
 	return pcibios_err_to_errno(ret);				\
 }									\
-EXPORT_SYMBOL_GPL(pci_user_write_config_##size);
+EXPORT_SYMBOL_GPL(pci_user_write_config_##size)
 
 PCI_USER_READ_CONFIG(byte, u8)
 PCI_USER_READ_CONFIG(word, u16)
-- 
2.34.1


