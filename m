Return-Path: <linux-pci+bounces-12923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6F98970318
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 18:09:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 626C3283D53
	for <lists+linux-pci@lfdr.de>; Sat,  7 Sep 2024 16:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 946A2160783;
	Sat,  7 Sep 2024 16:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I8m8u/ew"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E28518030;
	Sat,  7 Sep 2024 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725725386; cv=none; b=ccwpb4HKQEAV9LTBHygoJKTAye2Jl19iOgb4YMC/olx7sc3A8sj8HvHNvfKQ7f0bd1xuRySemrOXhqaUjzDdeoigoOTcy8AiLCP3OP78dfv9j2pV+ogv2VRa/W6xxBdinv9kun+U62PdIf7lkPciKD/0+yE8Qi3QLYRl4YQv5vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725725386; c=relaxed/simple;
	bh=z/4IM2dGlbPJsvbxWOfmYypM8xkdyvzr5CAHzTI0Kfw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=exIiYB/RnrjCxPeiwSu6QUA1q4SiqNs+aJSgPddj2tE83LdZOukdlJmMO3HKDkaZZz4O8e4+Xxn66yzdK1uTSgPHq7rHRHGyyste6ykuRrdQseZqmtsY/GnP64x2A1iLyZ8LUoZphLscpL4p3rey7143t1aNGXqh/N77id6Zkn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I8m8u/ew; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-718e9c8bd83so157941b3a.1;
        Sat, 07 Sep 2024 09:09:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725725384; x=1726330184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+g5hAHvMQPPH39bScYXFvi1rVaMwrdyfGczEk5Cm4ms=;
        b=I8m8u/ew+rxshXFkhVmtX04fabb2YzUS7BmBheUgruAf/z3V5stsibiV3FBHeYIw3N
         O9K6eAm72Ndge/VS8LwrtSUYptF4Cet6Ho/g61FStMNxY4PGvSCoL6YfdBAhZ89YXCa7
         ahXG605KpHdxcs86rd8lyo8w0/gOhQp8tGxdbs/7xWSLxijsaCc1UQD8hA3Cj8kbvNGB
         NQZuuzJJeoksVh6mEw1G4NNanB8g1vxaAUBAlGhXc5pSes+rRb64X/TcC4nbFk7Qxmjo
         9j+5drfJ4Qcm9ufiUQ0sjhwDaoZNSbhOfEPtf1nwu1V9vZLdSNPQvVXUoGYzeajR6dz9
         z4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725725384; x=1726330184;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+g5hAHvMQPPH39bScYXFvi1rVaMwrdyfGczEk5Cm4ms=;
        b=bHoJ3q1uqo5FUJ/Cu0qeS3mld2WCc3zO5Tw/mNqvUsJMDgDzBpmcOg/wxKNvrUspe7
         6I8WqffevUe335D4NbIsCULEJreJLK9gNy8IFp07KFzAgdoH6MR73DS8lRnmvUhbpyo7
         aGTKpyalTD6yLmeeSp5c07lDwj2PQ0alhzDTwFVnQP6k/eVDK2VKovOyp02xYRlJXik3
         UNqYrBE+RxSTE0JVdnsn2t8RVrhW/3ZmoSKqpAMautesyzY+3P209UAgPg2C+2Gd7bRP
         RlGoBalUZ2/T7xsrP2PxHAR7lcJGFhlUbX5OAkXrcopmjI5ffiSB6KMHLsW52+u2BuoN
         e0fg==
X-Forwarded-Encrypted: i=1; AJvYcCWBirk013eT4hla3ytrXnD5Q4E/ZPfZkZ6jXEhoac+SZugvw8rVnyO33n24hRTBD7SVqQF5Lv4nZVv7PZw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCWjV61YNPaW+wwqnLuJnt1/7h35+bLFQMNfGtyntklU0zJP4n
	47an0R24o5x4AdeDwxBdEhh8CSWXAA3HhhHHOqBX2daeK4VRWleX0sgCjl6oH4I=
X-Google-Smtp-Source: AGHT+IFcKQSqo8fsKqSWcivcS8mPO/shbBNm49Vdwr9wRmoLmLr0nfkFACshXBy7qTw/PzlwMq1CQg==
X-Received: by 2002:a05:6a20:2d0e:b0:1cf:1228:c175 with SMTP id adf61e73a8af0-1cf1bfa1533mr9190686637.8.1725725384027;
        Sat, 07 Sep 2024 09:09:44 -0700 (PDT)
Received: from fedora.. ([106.219.163.133])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-718e5983002sm1034353b3a.157.2024.09.07.09.09.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Sep 2024 09:09:43 -0700 (PDT)
From: Riyan Dhiman <riyandhiman14@gmail.com>
To: jim2101024@gmail.com,
	nsaenz@kernel.org,
	lorian.fainelli@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Riyan Dhiman <riyandhiman14@gmail.com>
Subject: [PATCH next V2] PCI: brmstb: Fix type mismatch for num_inbound_wins in brcm_pcie_get_inbound_wins
Date: Sat,  7 Sep 2024 21:39:26 +0530
Message-ID: <20240907160926.39556-1-riyandhiman14@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change num_inbound_wins from u8 to int to correctly handle
potential negative error codes returned by brcm_pcie_get_inbound_wins().
The u8 type was inappropriate for capturing the function's return value,
which can include error codes.

Signed-off-by: Riyan Dhiman <riyandhiman14@gmail.com>
---
V2: Added missing semicolon in variable declaration

 drivers/pci/controller/pcie-brcmstb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index e8332fe5396e..b2859c4fd931 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -1030,7 +1030,8 @@ static int brcm_pcie_setup(struct brcm_pcie *pcie)
 	struct pci_host_bridge *bridge;
 	struct resource_entry *entry;
 	u32 tmp, burst, aspm_support;
-	u8 num_out_wins = 0, num_inbound_wins = 0;
+	u8 num_out_wins = 0;
+	int num_inbound_wins = 0;
 	int memc, ret;
 
 	/* Reset the bridge */
-- 
2.46.0


