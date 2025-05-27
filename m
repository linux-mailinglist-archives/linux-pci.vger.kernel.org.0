Return-Path: <linux-pci+bounces-28473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0575AC5AC4
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 21:33:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A606D16C2D3
	for <lists+linux-pci@lfdr.de>; Tue, 27 May 2025 19:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DAF27FD78;
	Tue, 27 May 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XKg/Mn1I"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com [209.85.222.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C1C17A314;
	Tue, 27 May 2025 19:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748374429; cv=none; b=X8hktnFo3iwKMmDx0BuLgORzB7TctTsAvRRl1iCIxCK5KPKn2IzvXOmzhHcMv5PpJ5TiCkJ5c3tcn9AgBq96fk78IiZaW2LJ5k5wHJZCife34j6+hlxZdRekKDA8hjaVbHLkCa/LAMs/hBZ7C2/ufRKJyI6pRwlb5stJY32s40c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748374429; c=relaxed/simple;
	bh=wZgm6b+aaYaDHSCtiEqey06T+bU5xLWsquPRNzTnwAY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OEGa+7DMlbTAtE7L63xAJV+kXg7IVIirQM+9lIsSCukjQIlzV2cMAES12tKRSydP8TyeVkPgvIYOtFDT+ZRHR12vfjNch+GgauE6Fe25swtsLBZydHY2dwfsnqi16dWaOQ6gQmYy8jkBekCxy3uT/Wut8ffOUALpTuAubNPVaRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XKg/Mn1I; arc=none smtp.client-ip=209.85.222.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-87e049bb3e4so1093361241.0;
        Tue, 27 May 2025 12:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748374427; x=1748979227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mDW7FpZdddVN8iP+dZ71T1ANA9fYJqbCRdgup6n4kvE=;
        b=XKg/Mn1IvmxJp09xlzp5XyWi2FnmCUPlVePP8Ecujwp/pZGVRb9R+Y8E2WAzxlV4Gt
         7FXMFDP+y7XMa2YQ1d523VaNUCPxqgXkQK3jGKQ1hBsu6dRpTunIpD5rK2i2paDRzzBT
         6iGoGlGZYGr6ywLVh0GJKTe7oVekeaM/1d1drOhrxJP1n8fOAc87xYG2DBm3UR1NBqNb
         pSK/S8eYIDQ3m6MEI2gN4/lufoMuAEhgUqD9HKncjtC5WLGXt0s/xSqOg1h8lIoaO+gk
         NpZ1MotAsrMcbp7OQMAzvwTNKUkhyhdzPRBFTTu9zLTmylW6MfyaVqUSvp3+TV5Ukbf5
         fGeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748374427; x=1748979227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mDW7FpZdddVN8iP+dZ71T1ANA9fYJqbCRdgup6n4kvE=;
        b=KvIDWN91V/SiEkNI36jntBCSnmAD2YnRBSUAJ8l6uT0nNosuJf3+G/ulU0XvrRBpki
         4P6INHdDa+2fZ7/PoslTqdv6mTXBMvQ5plkpbAg2B6q2KZ2MMHfliJpe3fWJBe1UxetA
         OdWbXmlh75DQJfMwqdd3Mfk0FUwDrc6XrqE6WGtY4xd3WCp0h6b+kYIuGP/mDLwuLEat
         ZXzWyxttqY1iKzO4M+GX9tFfMFKjm4i6ZpKCxOR/VHcS7PNEkfTGs95rz8TiogUY9xVy
         atVaFTzSTEtUJh78zmEjd1fdXu26vRW1RutNVxA73i1X+BM02k1qP8vyk3PlOFWescQC
         uaXg==
X-Forwarded-Encrypted: i=1; AJvYcCWKAgehCABi/hf56+1X+xY36t2TCDTABddg60iHwhzjBEj72rp8riIH05Izd2cEA2p+5dkL8uiXg0rbDWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YywDUMHWYY7uugPWQQTOm7Bw419vazEvyYiXY04ZOw2HaWaK9UU
	v7pLGemxJM5wYolqQ2wvx+/SNwf4za/vZbFayVGRtiERIpyMZZjAZUuhnDszbJEs
X-Gm-Gg: ASbGncu+7pxEq0aY2jtNFycPrHtRx6h47EQu2JkbaY7tqrraBTrM+sLpbPTIZXyCou+
	4c5IIJWLmAfUBReblA5cHz6LYMmyr/PuoAbXhQE18yoTfH7lEL03xVyxf8B9cDVlJFQ5DHYASO7
	okeJadEy8VQO4MuNYeOeMpB7E+j7Ho6f86qHM2IX8f2kPxx9oa4uQpqWOU/taYXT8TCPO1wBGkG
	jq8/nQEQg2IG8Evdmoc6TrrkS5rVoSF7zP55VnSzcoETBWzUh9WqWj/JxG8huT0p5ECVY4uMm8u
	YEP+5CHgzyVBENayghFYGtic1THmYGB20nH3kegRBiip+b5mdz1aWS1OV4qJfA==
X-Google-Smtp-Source: AGHT+IHleVfAYbprBkha7Sxd/HbDmeea5NfDCG1nXZZh+m5RwRGihOKTx5xoyAae/DidOgdg6N81wQ==
X-Received: by 2002:a05:6102:c04:b0:4e5:9b5f:a7a2 with SMTP id ada2fe7eead31-4e59b5fa9admr784991137.9.1748374426799;
        Tue, 27 May 2025 12:33:46 -0700 (PDT)
Received: from pop-os.. ([201.49.69.163])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87e1d329b4dsm22294241.0.2025.05.27.12.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 12:33:46 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: bhelgaas@google.com,
	ngn@ngn.tf
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Subject: [PATCH] PCI: hotplug: remove resolved TODO
Date: Tue, 27 May 2025 16:33:37 -0300
Message-Id: <20250527193337.144148-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit 8ff4574cf73d ("PCI: cpcihp: Remove unused .get_power() and
.set_power()") and commit 5b036cada481 ("PCI: cpcihp: Remove unused
struct cpci_hp_controller_ops.hardware_test") is resolved this TODO.

Remove this obsolete TODO notes.

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
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


