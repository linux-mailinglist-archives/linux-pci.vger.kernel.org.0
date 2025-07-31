Return-Path: <linux-pci+bounces-33227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93402B16F35
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 12:11:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7BBE35A47FE
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 10:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4213628726E;
	Thu, 31 Jul 2025 10:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AcZNWVUT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CDDF264616;
	Thu, 31 Jul 2025 10:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753956675; cv=none; b=RTrdl7X66TXC4anYOJmFVp9NHixdl+KL5XdlzxxACGmfS5YwsaN9CRXJCZoOvoetKJ+mX7CNfBRDPFUZK2R3b5n9aAkso0OnRy/U8Dx1PY6Qtl4ztV8cW8ShDKgdvWW+RyUPgI0qc9AjODrJuFo+I/62XSPzVb5d30Qkvp2pFTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753956675; c=relaxed/simple;
	bh=tWZfeSFi2UU9oU8q6zswXy8UK5JruTSm62FHtjbsLk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YllYaWc1w5Ilg8FZkghFtM05sVRCVIzzOgASuchzps0QOBZ4XUXJ5S/tWdBHIzRNAANl7LR1e8yR5ilg/l6PzjK2mmsOywd1cWkBIj4YKSrwsfLjsTjAfcLA8vaI+BFRhzIEmvIFlX7NNcsMhSZ5VVYpf7RzvR+GwKW4K1fmNy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AcZNWVUT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3b788feab29so135394f8f.2;
        Thu, 31 Jul 2025 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753956672; x=1754561472; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ot6rw0P4/LgBJ7r7yPhK5IvJdWliZLbA9mjsHTICzqw=;
        b=AcZNWVUTEh1DVd+hWtmdLx9jVcIyQtobtH04/Dtq5jWaXKB9UNnCeBC2GUvaDt0nJX
         CUOFlaBb//LPlnaugpngCs3YkZLsVQZZLEUW7bVASNGZ5r/Aa3tA1cnxMfJ6BQkbiPEP
         0g0AsKMmaGWRAupVdUymZoL9UexR127nDQ8ql1qFAHoSPziQRV53r9eEfQyp832ShPoX
         SCg2dPxDPUz9At/QK3NrlCI50+Uajeob8OV/wol5h6bZP4IuzkZZHLldhCdchXxrD7bQ
         pd3DdTML7YEVuuJNOrzO+2vTvFgLrlSxUlNh9VdgKolVjNt4PdNwiLw2vSsJZLmvWVLK
         7P0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753956672; x=1754561472;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ot6rw0P4/LgBJ7r7yPhK5IvJdWliZLbA9mjsHTICzqw=;
        b=K0+9vBCar61eb7PDrLo4YPYbXmw+kCIVTNY8CpDczerrDlJ76Z90d4jrpaZyHfdUAC
         FXVq/m7xTmRG/e7VTW6joJpHhNf/eLZBwhQjIHQJPlT9zADNicr3WfDn5YagVZQpKd4O
         XHXUIMypp9d8/xASMTs4S3EC+LG1zsqU9lS8+IXxOl/ZRCgt9ZRZVlwXYe7f8SHNhAKm
         GtjUbSh9g3+jidI7FLeeHUSzJsCEJahSPYPF+Lk+lwbaW6nPmU9GfLoHe1ZM1py4coDJ
         G8QyV7Fh+9p/QNHM3FRgvvYtcSLys5a5n7Y+ghBDvM1gPmSB8Y7Nr9tKrbQzGFQ2qbK0
         +J4w==
X-Forwarded-Encrypted: i=1; AJvYcCW1asWE3ooWSdJJbypk51DrPHmEnmJARJVRPM79fLPjzdMJ6kLXSIUbQ5R3rm8777j4rirJA08RD37jVS4=@vger.kernel.org, AJvYcCWPzMMK4hr3bUoDfheK71kUkhApl4DoJ6uaSwrjwohxE7e0LWno7lAMfmxy3LtgfmJiz8iOlD220h0j@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3BDMOZoXojjjSuo6c3eQ8wAZj+ivlDDVMWRpwPqlP2CC+7t6M
	JubdwoBLwWqt3wOKtZrceWdDnMahfSJkRNDZBhcmI8QAVoREXtOLQLzw
X-Gm-Gg: ASbGnctihQ31f2GUbVtKPwJmkCTjZuKN2Yf2XrJR6SlmQ5kGLQDYluncryM45WSddzt
	uKdTpd4oAw6Prlpftnpd2+oE9HpQ4No7LfVFh6PLbOkZ6rwo91L9B+yppZOYZh/Xnuje9MZ/2pX
	L8vyuabYAWVytUSqUahirq8+fkPf+Dl5ehrbAK6cB9nWrF8K3fdqoYHuhP+vXBfEbuX3Ibu/+i4
	nZvg48u1LOV4y0ebbvYXLqIFfsLW8dN8akv2io8TLpHWT6mDh8+JVyBvjOSrdluIREEkk0Lz+h0
	BGfFmEXH9bkb/fseDn7ZDmWSpV6GjI4d9TDgY012Iz02waXB0MtROa8N2KwV8hptTV+UuCiiN9O
	FcAgNCPk9hB+36EudGEOQ
X-Google-Smtp-Source: AGHT+IHCDqQ1uASl/GEbNLzMJO2yUNjEI9YMCj5M164a8YbekaA+7CXaneRqSzR5i2cyVfEzbID/1A==
X-Received: by 2002:a05:6000:1a8d:b0:3b7:644f:9ca7 with SMTP id ffacd0b85a97d-3b794fd7c3cmr4889445f8f.25.1753956671808;
        Thu, 31 Jul 2025 03:11:11 -0700 (PDT)
Received: from localhost ([87.254.0.133])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4589536bc34sm59073805e9.2.2025.07.31.03.11.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:11:11 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	linux-pci@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] PCI: cpqphp: move space in debug messages
Date: Thu, 31 Jul 2025 11:10:36 +0100
Message-ID: <20250731101036.2167812-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The space in a handful of debug messages is in the wrong place, it
is after a %d and before the \n, move it to be before the %d.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/pci/hotplug/cpqphp_pci.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/hotplug/cpqphp_pci.c b/drivers/pci/hotplug/cpqphp_pci.c
index ef7534a3ca40..88929360fe77 100644
--- a/drivers/pci/hotplug/cpqphp_pci.c
+++ b/drivers/pci/hotplug/cpqphp_pci.c
@@ -1302,7 +1302,7 @@ int cpqhp_find_available_resources(struct controller *ctrl, void __iomem *rom_st
 
 			dbg("found io_node(base, length) = %x, %x\n",
 					io_node->base, io_node->length);
-			dbg("populated slot =%d \n", populated_slot);
+			dbg("populated slot = %d\n", populated_slot);
 			if (!populated_slot) {
 				io_node->next = ctrl->io_head;
 				ctrl->io_head = io_node;
@@ -1325,7 +1325,7 @@ int cpqhp_find_available_resources(struct controller *ctrl, void __iomem *rom_st
 
 			dbg("found mem_node(base, length) = %x, %x\n",
 					mem_node->base, mem_node->length);
-			dbg("populated slot =%d \n", populated_slot);
+			dbg("populated slot = %d\n", populated_slot);
 			if (!populated_slot) {
 				mem_node->next = ctrl->mem_head;
 				ctrl->mem_head = mem_node;
@@ -1349,7 +1349,7 @@ int cpqhp_find_available_resources(struct controller *ctrl, void __iomem *rom_st
 			p_mem_node->length = pre_mem_length << 16;
 			dbg("found p_mem_node(base, length) = %x, %x\n",
 					p_mem_node->base, p_mem_node->length);
-			dbg("populated slot =%d \n", populated_slot);
+			dbg("populated slot = %d\n", populated_slot);
 
 			if (!populated_slot) {
 				p_mem_node->next = ctrl->p_mem_head;
@@ -1373,7 +1373,7 @@ int cpqhp_find_available_resources(struct controller *ctrl, void __iomem *rom_st
 			bus_node->length = max_bus - secondary_bus + 1;
 			dbg("found bus_node(base, length) = %x, %x\n",
 					bus_node->base, bus_node->length);
-			dbg("populated slot =%d \n", populated_slot);
+			dbg("populated slot = %d\n", populated_slot);
 			if (!populated_slot) {
 				bus_node->next = ctrl->bus_head;
 				ctrl->bus_head = bus_node;
-- 
2.50.0


