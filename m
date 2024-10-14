Return-Path: <linux-pci+bounces-14473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6E499CB77
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFDF41C22D7F
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 13:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F4C91A726B;
	Mon, 14 Oct 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CzpAG0sq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69092E659;
	Mon, 14 Oct 2024 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728912016; cv=none; b=h8uTCuoEPnnBStskjTh3PTt8zUrVWS3e2AetXWTKhDvtXzzkH6Ho2QK0xrmg48eCzoRJo0rNRndKdbjFI/uC3je3+rUp7a0s++Azerj9xH/8r4f5m0BcmH2agYGadxVyCj4MF0KEA5e9SHq3moFuOANMu/H73KiBTrp+kckK0zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728912016; c=relaxed/simple;
	bh=g1ApVtXktfn/7ob3WMQ7xB9x/GOzNyYOBnXLIeK05R4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGA2ayGnwwk4cd98Fwc57VD3fVPoncNALqu8qjmIAzDHBlxxROubMWZzt0AqnloDUpV1ovcFHOL+4sg5t5puSKOhvcBto4+OfABwD56hygTBsyhTA2u4aTU8ZO3cbt0k56AITsiPxGyorDM3wpgwvZUmHGkOaDyBTKYVLqaWKMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CzpAG0sq; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e2e8c8915eso2943689a91.3;
        Mon, 14 Oct 2024 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728912014; x=1729516814; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PnIQCT5EAf4D/q+zlrns+kyFpnKjw9kFZRzD9+mWzjg=;
        b=CzpAG0sq06L6t+zx2xBuAPerMmk7JWKPjLtccFE28c4vNAZRr3/tWYMBMUn/rRcs2P
         ZcIDJX0G7YodT1XozHwQfhqhY4JyXzTm7PSFY576mYJYhnYN+ow5pLBwv0Rjawin+TFg
         oeMVvEfwF7krl8vfPnhBz7H6R6ZkngFP2lcEsKMbSVlyRuCjcu8e2jZVX3i+xyAPkV8N
         6gwULNgbLxnDB20cE62H5v3gJxzbCE0RSFkqsm7lC761j1U4OmmH0DAbVX1LZLo8qgHR
         86wnYmld2p4zcXMCtvAv2ACux+rj9/qHTmqJBxpJDcjh9QCHrjLrTdSu5cBNWgSNFZub
         uifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728912014; x=1729516814;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PnIQCT5EAf4D/q+zlrns+kyFpnKjw9kFZRzD9+mWzjg=;
        b=ki/L7wetJ9H3r2uDhnYeTWr+8/c5Joqceh332+nl4K2qkajFx4IRj4r0cF/4soaKUo
         h9+QR1RCFkX1kKe+nHVYw74SXO6Dv2pYmTOBKCIsogkeAIztiYeSji3H4Q8ItMEMKAWp
         jxPkiFaLCcHCo2+29FxpXwdGyX0N6+8AveaMCSB2efN+PFER0sxVwMqB9a1RLjkWq70d
         4Oa0T8ZN5CrD9Q1BGzyV6Ih2l4U0ndS06iG5lOU+vDj+STdBXSVL4gS/2DWQRafGiBBl
         8I0/voZuIqLReVahw7mfdVIvIhR81TmxBNtRl1abrRIWhlxmD5X+lLBlt8z7owCrfs33
         QaAw==
X-Forwarded-Encrypted: i=1; AJvYcCXA3W0T8gFJ+kF3bmgAQ7K+kM4TxxmwXcKObyovHTZJWpia7pRppQXukQ2j0pdAY+74XL/Hro+bKWQxE1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcgGWDi+2ko0mJh5vPLxlbhURpKwI6IGDz5CLhMmQb/wIgz/SA
	8qBbRF5q2/+hRqaz1vWpJ/oq4KTqEA6W2Gm9K2Xg1qEDNsoLFHiWUZtrvf0Y
X-Google-Smtp-Source: AGHT+IHO5ZiYHWJlNRSnYuVh3AsdjH83YDljE/J3KhsHBNSRMG6dcWxOciWNP7TQ5pEDCI55/QXQ7w==
X-Received: by 2002:a17:90b:3b90:b0:2e2:cd6b:c6ca with SMTP id 98e67ed59e1d1-2e3153589c9mr9923489a91.25.1728912013932;
        Mon, 14 Oct 2024 06:20:13 -0700 (PDT)
Received: from localhost.localdomain ([187.120.154.170])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2e2bf0b3011sm10124558a91.1.2024.10.14.06.20.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 06:20:13 -0700 (PDT)
From: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
To: trintaeoitogc@gmail.com,
	scott@spiteful.org,
	bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] PCI: cpcihp: remove uneccessary field
Date: Mon, 14 Oct 2024 10:19:17 -0300
Message-ID: <20241014131917.324667-1-trintaeoitogc@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The hardware_test field in cpci_hp_controller_ops is uneccessary because
no file is being used. How a pointer need a space in memory for storage
the address (4 bytes in 32bits systems and 8 bytes in 64 bits sustems),
remove this dead code to reduce resource consumption.

Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
---
 drivers/pci/hotplug/cpci_hotplug.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug.h b/drivers/pci/hotplug/cpci_hotplug.h
index 6d8970d8c3f2..03fa39ab0c88 100644
--- a/drivers/pci/hotplug/cpci_hotplug.h
+++ b/drivers/pci/hotplug/cpci_hotplug.h
@@ -44,7 +44,6 @@ struct cpci_hp_controller_ops {
 	int (*enable_irq)(void);
 	int (*disable_irq)(void);
 	int (*check_irq)(void *dev_id);
-	int (*hardware_test)(struct slot *slot, u32 value);
 	u8  (*get_power)(struct slot *slot);
 	int (*set_power)(struct slot *slot, int value);
 };
-- 
2.46.2


