Return-Path: <linux-pci+bounces-8375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B318FDA29
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 01:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FEBB286134
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 23:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEF7160880;
	Wed,  5 Jun 2024 23:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNqG1LcE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48154BA38;
	Wed,  5 Jun 2024 23:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717629019; cv=none; b=HuHyqwv4+exBks7r1x0Z5Xl3/VcNxWp0tjlLDMe1snmtKC659OT325pHMFcx7vPAjNhnWIxQ2BwwwA5/iTh5DSvyX9R9/AxqwLPqJNrViR25dCXlW5wJXwSX9G3mynXPkQBYJt5urry5iAN04v//4uqtTCMnLOsVy0xNieujEDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717629019; c=relaxed/simple;
	bh=+qzBgVypxo5Oj7OFL4Z4L8bH4RlG4KNWwruaVnHr1Ug=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=keDx01i1WXx91ZxOHZauGhyssre8OuNzysEtqT6Ej3l4FzGQLsKDvCJztIXfkGoW6xAO/mUWrXOZj51sNyLmBTNUIAlpcNzEmcX91fFDGyc0pePJZ9jeohVnZSOBa04jF1Z251hu3hmlCOqTp1g6mVzL5tOhAw10ke8Jbc4Q+k8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNqG1LcE; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6cb6b9ada16so267010a12.0;
        Wed, 05 Jun 2024 16:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717629017; x=1718233817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mfqo8SpJ+6G4s4wmk6y7o8hH2xAWf7/sXOwEQu/ezXs=;
        b=lNqG1LcETvh4JV/0tahj6y91X1uo4oKLT/w7zDGnzz9XfhDQZ7IOBgXQ0hyNna8psA
         Be/7uhcWGUDnIdWQb6u1A0UxWEnpGBBSCXFpGP+aBKxsFTSEG54zhsOeJcz7d7yMpq23
         gSEYMqimh5PMltQpbPwCqFiU1llTEj3n+ytVCo0gDu5/7ERDexH4jZqwMhggC47hQHD6
         mg6Z10qParPs5FAvES3fd/WwQfcgRpnAGJfqQwGbyaz2eEIlpKtL7CfAIFtpaty2+Kan
         8inqrt2I66fOppt99t72UuX7aJUA3FDZuLV0AobzynCL/PEOfb84TET1rH19UBOdT7Kj
         vrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717629017; x=1718233817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Mfqo8SpJ+6G4s4wmk6y7o8hH2xAWf7/sXOwEQu/ezXs=;
        b=ZzSRSaB3AiJBcyetpFYZ7MsEo4I2RxRqNShscr7DH9CPEDmOERyc8sYf2rVcQNgbBJ
         6/qy+sPgP22BVf7mKIq0BUsXi7YboCSpUHgbtDbulcepX3yKrnbrFtOj1nRrMaljVN3H
         ahcP6gv1YjI7z3dBHZASakRzqmb76KkAcZsh1BsbIV4/9lnbGBvy1bDBs0qHCZV0pWT1
         f5OpNvmmT8fbAzDfK5wcMqkrOpZUlWEWi6nqZJjFzwHOlDuEKX8UmTD9aFdkSjjoN3T/
         v7ok6cFgu7MKGzLwRPA8hCrv5iZffbwCC2rFX/wR5r5TkE6l3dBRtCm7Y6L8+zaS0z00
         VlcA==
X-Forwarded-Encrypted: i=1; AJvYcCXlHvweG33meO8yQwIt/lEmWsfOPHHgfUdmdKB8WAeOORr6MOajyYayOuJVcszxaKUDOTBvmM8TGkLBK3czI/l2qspnEDPX2rgWAmusDeJrOJbFKOl0KoZXprKIjBMyGXtqFB8o4vot
X-Gm-Message-State: AOJu0YyeVCveM/UHLH+WwAGao7v5O9BhX9iCDBB9suHYBdwWeODEEJWv
	5rk2+bDoSZZLPknT2h6/vsnc5EzM1WjXv2vuMj7zy0ar7LdUkKUx
X-Google-Smtp-Source: AGHT+IFlRibt1HmJPsoOQnfwix6H7u/g4nSL0HZ2m1iS08mkDy8ml0ygiSVOBol4eJWWadYR1TyGHQ==
X-Received: by 2002:a17:90b:4016:b0:2c1:a068:ba83 with SMTP id 98e67ed59e1d1-2c27db0ebb0mr4023969a91.11.1717629017487;
        Wed, 05 Jun 2024 16:10:17 -0700 (PDT)
Received: from dev0.. ([49.43.162.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c29c20d8afsm139596a91.2.2024.06.05.16.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 16:10:17 -0700 (PDT)
From: Abhinav Jain <jain.abhinav177@gmail.com>
To: mahesh@linux.ibm.com,
	oohall@gmail.com,
	bhelgaas@google.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com,
	jain.abhinav177@gmail.com
Subject: [PATCH v3] PCI/AER: Log error message if there are too many PCI devices with errors
Date: Wed,  5 Jun 2024 23:09:54 +0000
Message-Id: <20240605230954.22911-1-jain.abhinav177@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added pci_err() to log PCI device information on which iteration fails.
Added pci_err() to log note if there are too many failed devices.

Signed-off-by: Abhinav Jain <jain.abhinav177@gmail.com>
---

PATCH v2:
https://lore.kernel.org/all/20240605212344.21808-1-jain.abhinav177@gmail.com/

Changes since v2:
 - Switched to pci_err() to log failing PCI device
 - Included the historical note below the "---" line
 - Fixed other style changes in the patch
---
 drivers/pci/pcie/aer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 8b820a74dd6b..0bca83827ac1 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -882,11 +882,13 @@ static int find_device_iter(struct pci_dev *dev, void *data)
 	struct aer_err_info *e_info = (struct aer_err_info *)data;
 
 	if (is_error_source(dev, e_info)) {
+		/* Log error for the device */
+		pci_err(dev, "Error detected on device: %s\n", pci_name(dev));
+
 		/* List this device */
 		if (add_error_device(e_info, dev)) {
 			/* We cannot handle more... Stop iteration */
-			pr_notice("%s: Cannot handle more devices - iteration stopped\n",
-					__func__);
+			pci_err(dev, "Too many error devices encountered. Stopping iteration.\n");
 			return 1;
 		}
 
-- 
2.34.1


