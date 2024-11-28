Return-Path: <linux-pci+bounces-17439-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12B49DBCE5
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2024 21:29:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69986164877
	for <lists+linux-pci@lfdr.de>; Thu, 28 Nov 2024 20:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0671C2DA1;
	Thu, 28 Nov 2024 20:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bmiyvqN7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C3D1B3933;
	Thu, 28 Nov 2024 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732825779; cv=none; b=qUMHiTBpEtW/MgW5vqDU0c5H4qYLN07etQNlAV7tSWoQcSLbh4c3NkS6HxGpkK4QEeoVdAGyZYjxWILSxNr8EHCMypq/jytnCkwRzLaCz1Gvhs+DgesxbrKMNhyARH4NRDg4nK1Ty9pCO/lcgb3XinFTivd42ul4h5iT3L+Mgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732825779; c=relaxed/simple;
	bh=qAUGg3igamS5aggQF6++zFN3fZRAeWNNqwHFVdcfvAA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KT9iMGXLh9f+uli4yAjM97EBwCPLxuLcHRl8y/m+/Liq0LBuz8VSrH7IqYoFMA3YK/XY3VxFbXFI2dqz+lB5cW1delZn8QcOnkv+Opcgrgxl9EtxeUTEwPeMZVx3FVXGh61fgGRArsQDHoEbx9Vq7ibqJkd5bqd3v6CuaGcEA/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bmiyvqN7; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2124a86f4cbso8958365ad.3;
        Thu, 28 Nov 2024 12:29:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732825778; x=1733430578; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=roq0jjNW+0dJq9LFOZyLd+OgpvWNVcBi+LZaoyb9Brs=;
        b=bmiyvqN7UQCM+C4H3tsyEhrCk5Bg4r3+IUAuIVesxkM0DhkbVUXF+5mR39/YeyUD3Y
         Sj8NCq9HV8K32CiIxGaQSRa+Ed5nFqWWootAqWpg2nrXOWugodLcrT1/m0BDvijuB9eO
         +XHxUbPgngQRFCBCwJ8WZWVc3ltDUSyLLhzdQQSqN6Mjp/P94jtOrozDi5vhZmrgBWbh
         38h+YvXi1aiTeZrlpd42by9a03Ro9h1BjVvrC3+qYXZc+tsEQCOxG3C68zQNnZn6T1JJ
         QKzyLt1vxaHVBIoLOZ4k+z47EP6aDZX5KA5kbw2agSsn6sIv+krP/ny7M1/c1Jv1le9O
         E7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732825778; x=1733430578;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=roq0jjNW+0dJq9LFOZyLd+OgpvWNVcBi+LZaoyb9Brs=;
        b=UfrHFbXnTIlEyMXqtxDA62ossOWVXuwQvurcFaZIyRcJGQA9rrEbQLpz8EhD+9ukPa
         Fy2lmSfx9LU5UcHkDB80yDfY4/lP8oxqd3j3Ob10mRdXuqLT5T5TnZNuuc6yowLbduxS
         NV/FzkOirrt/27C8TTwmdQwcWxF3q3A5a9YFE3TKnFBVLDDNOQuKUCSXDk/ytCPQr91M
         z/4JY4Eo08bZ7W9yZY5OR+lNWPA98T/9tdvhpjmQf/VvChVIEHYktGUONiLyKKsrnowa
         u/SIlZGqsu1mKuWd7T6hg+E/emvodNT0gEJwvVpBIBuflQ5EflP9BN8RiOzhMO23ctSZ
         99Kg==
X-Forwarded-Encrypted: i=1; AJvYcCXbmTvEv93I6IGJ4ZfsbR5e3ZF4GG85R9Zgrh2IRvbJ2ft9KYx+qZPVW0jrIl3VHKMeDiCcicJLyeiQ+BI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzdF07+LJ2n4gQjLCHtSC9/CR/J151yXdYGw8MJkfcvnSH1tTt
	OoVoZKod8A3Ztx1SpNVgB8Flqkq+9iELeNB2pVeGccPcMk5hkBvq
X-Gm-Gg: ASbGnctxLcibYC3KLD0p6y2oiEqwsB8fct5HUq2UQo8z/wwTA61Q2ONnf3GlE1L4CvC
	h0YXRNPCiyOM776Og/s1JcwyxczdYSi/V/XG8RLuCMFEvu2IPDicvDVwml05uyC6Fdqp3/nNRf7
	8tfDl79Q/rF7DlWoxEgboujukf3US7dDap/2HyTxGSv25t7I/klNFe8yFNlrJlpgojAX6Ub1IrX
	2SJN9M0Vqkknjmt7M2lIZH9+J9ahXZkWifjhAeUrqPwYO716HzpwsiG
X-Google-Smtp-Source: AGHT+IHGO44u+2/nvxDQSB2Ns6hDfTnziv8HRr9nSI0ibgFGTC53V230Ql0RGCZp3PpsG3B5degyZA==
X-Received: by 2002:a17:902:f682:b0:20d:2848:2bee with SMTP id d9443c01a7336-2150109a12fmr92192585ad.16.1732825777621;
        Thu, 28 Nov 2024 12:29:37 -0800 (PST)
Received: from linuxsimoes.. ([177.21.143.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-215219b01f1sm17661385ad.239.2024.11.28.12.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Nov 2024 12:29:37 -0800 (PST)
From: guilherme giacomo simoes <trintaeoitogc@gmail.com>
To: scott@spiteful.org,
	bhelgaas@google.com,
	namcao@linutronix.de,
	trintaeoitogc@gmail.com,
	ngn@ngn.tf
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: remove already resolved TODO
Date: Thu, 28 Nov 2024 17:29:31 -0300
Message-Id: <20241128202931.9730-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_power and set_power fields is used, and only hardware_test is
really not used. So, after commit
5b036cada481a7a3bf30d333298f6d83dfb19bed ("PCI: cpcihp: Remove unused
struct cpci_hp_controller_ops.hardware_test") this TODO is completed.

Signed-off-by: guilherme giacomo simoes <trintaeoitogc@gmail.com>
---
 drivers/pci/hotplug/TODO | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/pci/hotplug/TODO b/drivers/pci/hotplug/TODO
index 92e6e20e8595..7397374af171 100644
--- a/drivers/pci/hotplug/TODO
+++ b/drivers/pci/hotplug/TODO
@@ -2,10 +2,6 @@ Contributions are solicited in particular to remedy the following issues:
 
 cpcihp:
 
-* There are no implementations of the ->hardware_test, ->get_power and
-  ->set_power callbacks in struct cpci_hp_controller_ops.  Why were they
-  introduced?  Can they be removed from the struct?
-
 * Returned code from pci_hp_add_bridge() is not checked.
 
 cpqphp:
-- 
2.34.1


