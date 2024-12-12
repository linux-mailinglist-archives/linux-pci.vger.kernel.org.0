Return-Path: <linux-pci+bounces-18300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48AA49EF219
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E57B2189E4CB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:37:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5467E217664;
	Thu, 12 Dec 2024 16:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KnaKgQV/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F614223326;
	Thu, 12 Dec 2024 16:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020762; cv=none; b=q6gflBOTdcYnSmHisx0lxw8ODUPG36/bp25tdInlHRIMLXwcp55w7KNAcohDUyy188LPDB1uWYwAf7shFLntR3ZPZMoOvzgEYr/cu4sSWDaJvqwoxWuvPlUcZmwtv/8jcJ7FCBZE8jfIl/2hhEU03WcX95k8j6p41fABUJa0Bi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020762; c=relaxed/simple;
	bh=Q2qGXQBhBOEQTELdC4nAPpauKHiUFIz6hHU0yEQjG9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZnFK/vpggQ/kSLXmv8wSiZIoAwhl8lf+2KDcp2GIZoQ98R5hagEpzkzZkpdk3DxgYfAvCXKTDCrCb7tR1WhK6SzCF4V/P71VMNlRzN36FtX/JBMNTgI2t7rjkF1++PZLiKdH/94nfyI7xJ8E+5ItZ9x9oiVSxCC43IzY5EaaXVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KnaKgQV/; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-aa69107179cso151206366b.0;
        Thu, 12 Dec 2024 08:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734020759; x=1734625559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UiLu6Qd4XKHvmBw/a3PTPIB2iHIIVTsKyZcLt8s54x8=;
        b=KnaKgQV/75KswmK3tYIbG9YOqr6YxoRdFAptUsQiSKjyhNhMdY2EPmPl/WLN3Ox3uo
         O7QNAxQBbHvl5jwdMCSBBaIWSZ/9EercQdoHiMx5ryxPGLHOKzh7hYWl6iAh6chTjfIN
         pys3uzIKUoJX+gPRixXYDo208qipF/Gdubzmnwmjz0xLaRa73GxTGpKtGnTAvqb3R8XY
         FTd+9PUKHRlby7Il9fY2CBdXhwiLzG5CTqpyGrMa6LCHRNG7nxe6DQ11cZ2rzzYh6CVC
         e6Kk2o1Gh1+nm5wfmCSqj/RRgw1PVU6MQyZyAMZD3ZyS/T4DHIwUCuad3mikX29tB5RH
         JP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734020759; x=1734625559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UiLu6Qd4XKHvmBw/a3PTPIB2iHIIVTsKyZcLt8s54x8=;
        b=qchgB5sSuocTcONpIV7xz8+4JrcDkxc3KMRK90pWIbTB2aMHcmHWQqEfJOSp3wFXaU
         /CJw+Y+h0l2iqZ3doMSfP5PyQ15Jo5DGg6hvy04e9uNSqHH84ZVlDW9PWCFNr3CjqlS6
         E8vO/AySnzS8/3mjUI8THB+6rjmZ20TJGQNRFIxy0NULeVoPYqpzvtY6BU6IzCSZLF2h
         RDvQt5HONwvmZQOwyUilSb5+Qr1RcbF7ACkpmCj68qXdJiMuTnRKgQ/XS3bHaZ1B7yw5
         Go/KrYh2f2wlxlO6yyG0ZDSqT9wkO+HF1YgwgfbLqqw1aM5bee140OGAepQXCRWhTume
         pH2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQlOGehOcsrzneYDrY3yma/jfcInn/e3wTGGR8dzeWV+p2Mpo/wCxM/7tCsxrJNLecm+p4O+Qf0D/JgxQ=@vger.kernel.org, AJvYcCXwr+LFA017R+X0+/6vd0JBAPganJPz5TGp6s+NTCC5qZa+B+F1ShFlscFRFfSORKpIpWThuB2V/usr@vger.kernel.org
X-Gm-Message-State: AOJu0YxlyBwn1FaBUsRzgJHA606YNaXUOy/orhRNGyGYg4ppV4RCg5mA
	2WyorKjP7YxLSzwInatXbQZ2c/0Al3XXh3WrOa8vTvzD6Ofm6Aro
X-Gm-Gg: ASbGncu55BWwRl6La/VUvrJTUkHjhvn9yuziPFj4UItiZL2pUuSlkGgCfhEUE0EtdUB
	nbH8ol7RMM/M9/zeR0/kU1Ra3awG6kcvvFkzwn32pDAXPdemAlnKuwMfYye4wsHI3twBdhJCOvl
	UvA7J/bL/yNw/COqlwPHkNufQZZ57Kqeh2HkdWTweluQmJN9jRtcL8jcd3E5EW1T88VOMgV9Rym
	+Ry/cXhNndqiIJgJReXhM8OpxayuH6Elltzhde+d5huVFwcXEfk4UnzsLPwfMsEe6PP4F+89kT0
	Dl72iJLc
X-Google-Smtp-Source: AGHT+IE65DY23fbfUpZzUvZ8cLq4ww49YZSH3MeXPwgUJqyomZvheSytrkB4HRTUvpUFdj9Sc5Kf/Q==
X-Received: by 2002:a17:906:3cb2:b0:aa6:8430:cb02 with SMTP id a640c23a62f3a-aa6b1500792mr608257666b.61.1734020758650;
        Thu, 12 Dec 2024 08:25:58 -0800 (PST)
Received: from A13PC04R.einet.ad.eivd.ch ([193.134.219.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa683a0a736sm634969566b.142.2024.12.12.08.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Dec 2024 08:25:58 -0800 (PST)
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
To: 
Cc: rick.wertenbroek@heig-vd.ch,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: endpoint: Replace magic number "6" by PCI_STD_NUM_BARS
Date: Thu, 12 Dec 2024 17:25:47 +0100
Message-Id: <20241212162547.225880-1-rick.wertenbroek@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the constant "6" by PCI_STD_NUM_BARS, as defined in
include/uapi/linux/pci_regs.h:

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
---
 include/linux/pci-epf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index 18a3aeb62ae4..ee6156bcbbd0 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -157,7 +157,7 @@ struct pci_epf {
 	struct device		dev;
 	const char		*name;
 	struct pci_epf_header	*header;
-	struct pci_epf_bar	bar[6];
+	struct pci_epf_bar	bar[PCI_STD_NUM_BARS];
 	u8			msi_interrupts;
 	u16			msix_interrupts;
 	u8			func_no;
@@ -174,7 +174,7 @@ struct pci_epf {
 	/* Below members are to attach secondary EPC to an endpoint function */
 	struct pci_epc		*sec_epc;
 	struct list_head	sec_epc_list;
-	struct pci_epf_bar	sec_epc_bar[6];
+	struct pci_epf_bar	sec_epc_bar[PCI_STD_NUM_BARS];
 	u8			sec_epc_func_no;
 	struct config_group	*group;
 	unsigned int		is_bound;
-- 
2.25.1


