Return-Path: <linux-pci+bounces-44022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4C0ACF3A96
	for <lists+linux-pci@lfdr.de>; Mon, 05 Jan 2026 14:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A33D230123C6
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jan 2026 12:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7C933E36D;
	Mon,  5 Jan 2026 12:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b="bKlS6fJH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C939D2D97BF
	for <linux-pci@vger.kernel.org>; Mon,  5 Jan 2026 12:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767617806; cv=none; b=BBhO6+heALywOeduc57t8YDgsk19ntE9s+4VODBdO9c7FVe9U13gLN1sm8wDISfNaVueheoZQuyzerrjbFYvszBiYj6V/Jj8BCOox6NnhCwuIG8SID2h4hArG5sFh1bNmFge551k31rzrWgmjRr++hO2wfD5jJQTgI1hdXa5R9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767617806; c=relaxed/simple;
	bh=V0eV9L9ITo8NgV25mFW1sr+g+mEaBKtqXjQS+8LF7A0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qjGbM/W3M+kYUA/2euIgyVBUJdLFiTVVs/Ssqc2XE55V+q0ejmGVxXb6+NGNoxDKhqMIxPl9zxBPFvKNah08BgqdSFoTXsBt9tRaVyArFA1elUABjaQAMGtg7v4rKa2/hZmjSKxZKLG10E+Aolk0shxUDWTBIDNsnZjzyEW2/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com; spf=pass smtp.mailfrom=googlemail.com; dkim=pass (2048-bit key) header.d=googlemail.com header.i=@googlemail.com header.b=bKlS6fJH; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=googlemail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64b9d01e473so20443719a12.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Jan 2026 04:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20230601; t=1767617802; x=1768222602; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=en2pW9puE35IFTbs++BWoNNKvbkB1aM3UnUzh6oqOZ4=;
        b=bKlS6fJHGox/wmOBaGKjuthWLPO4UDbieHYifcKbPxJQXv4eNdWOQRY7rg6BmTT09I
         8Ey6ZJvlvJoVDXEQZo9vS9b04qKssr7w1Kd3EbLD6SBQ/SjMka8AV8ng2AiX8ediL3N+
         5A+V0yQXthazKUYEoRABskHG7p3KmAfBVRzeEl/1BbA/MCox+yxqPG6embaAe6j0x5JU
         jclCttOJLuPvFjkehpGTefZwU4Lr29ZYoT8/tkpys0Si2+aglbmJXxLC22YKcugFF1cP
         9IoMFvB7PbgFXwznzb5tt5vh6y3O0FWyWN8fP0zi8uoNv4i+RiXGydKFYE/owe4pKdOk
         WSCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767617802; x=1768222602;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=en2pW9puE35IFTbs++BWoNNKvbkB1aM3UnUzh6oqOZ4=;
        b=QaI7JolzOuHUkcEoINCC5E6M7CNvfYW7QtZdHXdz6AnmzCFsfNVN2lt0c7VLp6fu0F
         K6a25Yhwu1v3wBao+2SOExuSXxEpkdSHS4bGmNePSxo8tishSaF0qh4otE/xPvRZZtw5
         cTvyXIB9mDlHk/tKYw0RfDSZbTZtHHAaRmM1315BQCfS/nYjtei38evp20uLbfF1jGXh
         CP5v2K0lA9kFzwZvEkb7dte9/5uar4bS1WHg56KFaiYCSEFkK6eTmNn4DRXgM9RDe5a/
         5lg514GSGisP+5bYowSdZ/mjau9OvJUlhgAcx8S/2N2GnwrnXhiDWAEG/h71kbOvPR+q
         Gr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCV122yt7VPdmmbyK7IHVxTn2bwOXU8aZA374spDYXB+MA59WyIL2IPRgl/QzcV7N/tbU4Sj15hKkx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5M4Zdh+VLbCefAmv5xFWJy1Q6aqMhQTdKocwOcVEOozeBJMET
	gXPaCH4aSpF0hmulPPPkO+Wlri0/TYz2RoSbESyg9SiLa6lOutsNE0Gq
X-Gm-Gg: AY/fxX73ABHZn0EXBgiGW2mqBxGKE8ehNNwAJ7woJ8n5jnKTMB6ATWzpl8e7EWSAwb5
	ufCP2XzOW0KxsAJMrJ4eyTW9r/ER60D1e4sjfGb4m32oLv2vZurr06BCDWvGrsN0xQmaxPVM93P
	0/u8PbOv48WGDDKBH2nIKpfSWOTznlOClqQXxVY6s5f++zK5FZkaZMfit3B46qYea08obvA6QoP
	rq1D0aGwWXKQIMKZJSk8wKO/ybiCLc4CtcTQq1buRtOuhuX24+pahjGhFf67i6pZ/UjjEf+6bHL
	x6KgNy71WNVFZL0cMvFTzoHPXHww+7U7ASwwXZmJHKkgZR7/F3/PU6mNfHxwzJx2P3QPhWZ/WiW
	LXo6nHWzELrvXHZnWt9Kl11D1NIELIQPHKCi639GZ1nY2/9WbcPRhrWFnD2dUMP6SapcOdwcIb1
	hhlhCu2NaYJSaZdk8jdn9PCSfm+L6bjKLk0TPIwZgA7cor9fAm/NQ2B7gyM7duG9/mdu7sprhzs
	pAwG61/BXVXHe0sc6oHduGNFU9boRsPX648lRHPEOrEKvXGb6aF
X-Google-Smtp-Source: AGHT+IGkQHUVn4G1LTfeKcgEt+M7w3okEoSSOC40iYpGOWHCsX59BOszv9hkdCiQgf3kosmWwCeYyQ==
X-Received: by 2002:a05:6402:3587:b0:64d:3b22:a5b9 with SMTP id 4fb4d7f45d1cf-64d3b22a88fmr37161484a12.9.1767617801949;
        Mon, 05 Jan 2026 04:56:41 -0800 (PST)
Received: from blackbox (dynamic-2a02-3100-a8ad-5500-1e86-0bff-fe2f-57b7.310.pool.telefonica.de. [2a02:3100:a8ad:5500:1e86:bff:fe2f:57b7])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-64b90f53b21sm53582712a12.5.2026.01.05.04.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jan 2026 04:56:41 -0800 (PST)
From: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To: linux-amlogic@lists.infradead.org,
	linux-pci@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	bhelgaas@google.com,
	robh@kernel.org,
	mani@kernel.org,
	kwilczynski@kernel.org,
	lpieralisi@kernel.org,
	yue.wang@Amlogic.com,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH] PCI: meson: Drop unused WAIT_LINKUP_TIMEOUT macro
Date: Mon,  5 Jan 2026 13:56:25 +0100
Message-ID: <20260105125625.239497-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 113d9712f63b ("PCI: meson: Report that link is up while in ASPM
L0s and L1 states") removed the waiting loop in meson_pcie_link_up()
making #define WAIT_LINKUP_TIMEOUT now unused.

Drop the now unused variable to keep the driver code clean.

Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/pci/controller/dwc/pci-meson.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index a1c389216362..0694084f612b 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -37,7 +37,6 @@
 #define PCIE_CFG_STATUS17		0x44
 #define PM_CURRENT_STATE(x)		(((x) >> 7) & 0x1)
 
-#define WAIT_LINKUP_TIMEOUT		4000
 #define PORT_CLK_RATE			100000000UL
 #define MAX_PAYLOAD_SIZE		256
 #define MAX_READ_REQ_SIZE		256
-- 
2.52.0


