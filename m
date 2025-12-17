Return-Path: <linux-pci+bounces-43164-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C44C0CC745C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 12:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3EE153018BE1
	for <lists+linux-pci@lfdr.de>; Wed, 17 Dec 2025 11:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCD12F49F8;
	Wed, 17 Dec 2025 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="qlXpc7KW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FCA3342509
	for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 11:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765970117; cv=none; b=Oxah+Q5tERt0qk2MO7pxdjzmAgUY8l7m2q8NASGkHzQGAjjztI6M27I8tU7t3gb9brgatJyOOmtWIJjZRLPSPkWSIVyZBW1TRohKDOpQcrTwhcJxCpzIzIRqx7aQMW4pa8uOJxg72gmVGiRmBoDrOSjmWQOAHybPgFPoxqnCIKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765970117; c=relaxed/simple;
	bh=ewOAPZc1uTLLRex5XDX/9U5h9oB3Nl4CnrMPgz5eilY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tUz1E56zxWztcqG5z4uEK2pZ28MtC7ALw6kBKRp0VsQdzS7pkFVdeUOGSqLymIZOLsZTSX/bhbokV+w4h3nvvVMxhg6H/vhfEKvY2i8oNyMCBuxxy87J+UMxkYFPa7HHYeGI3qH5b86FHduDPsMxPS7xqNDXZbrShXwrb9Z8c+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=qlXpc7KW; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b7636c96b9aso944061066b.2
        for <linux-pci@vger.kernel.org>; Wed, 17 Dec 2025 03:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1765970114; x=1766574914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=DyGlf6oa5RfbiSrZlCMKvxwFDL5r90eILAlesdGthps=;
        b=qlXpc7KWBHL+wYRBURNFa75lQ/XdqphghYwXz9mlYql9vWoJorEdNRDikEThg7ZLcD
         /0yix7ooYe+gwBFKyeeF/GABCIgyE6cykFPto8jPSgLO3PByulhg/c2m+B9i2p6a1t5l
         y+uC2fYBbh7eHdxAVb4XZMVehe/tNJo/9NqpoO+iPZCh6+II2k8pf7aXMJSPPAbckRBu
         RqprShY25lVRvXHEhyjkcQkxz6T+c4qLlEesFo82yyeHq2Qx83NiRjnwShE/chLQ4iyd
         1mT76Ltn1CApYTotz4SwwCp0A3nVZunHUwWxJrpu9dv5B+gEWVgGzVl7Y2Jh5JPOy9jL
         4Lgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765970114; x=1766574914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DyGlf6oa5RfbiSrZlCMKvxwFDL5r90eILAlesdGthps=;
        b=iZbZ1wc1hz0Y145buj0JtfNwXQo9NbCY+pKlZxbtszJuk2OL3araQyXMytxkVyZUcW
         SAIX53lUdNi8M8fAny9CLDknWLKI7KIVdzHKiIOsN74WM1F/HLJh/tnXwXNCWBMhs5z/
         hdE+VBt2PV/7zkuHXKP7jSKiScAcW/fLO8lpAY5Ov4TKM1Vs3hT3uocxFseWMreuFZnh
         /smpJo3roIlGJNPwRgYmYxcRTVTM/ET5gZM8QQ+w2K49SqHRopoEyljR4w0be6dqDdHc
         LE+KHJiKbxUOaGtCCpi6mR1UM1w5RclvM67i8cvPKL7xjscgGp/7fsj3rH589CHiLv09
         bTFg==
X-Forwarded-Encrypted: i=1; AJvYcCXNi/K6+WAp8YbUQucm+zTifJXiBmRH/Zt/zLkKTDlTi+hte21czrV7zJ3CJHpDlTRInKKATTiqMR0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlkDYDlaewK4za1L6N5114cwmuaWToxpNaWEG+8Rd8EaIs8hAS
	/0vFTUxPKrR9tgbA1ZYShyWWJWTkRPIwhCiAuQnWJVpagguz+7Un8IBJ/uZ6gdC9ssakADh6wRU
	FjHUA
X-Gm-Gg: AY/fxX6J0ooLqMHGAGMxyFdjIZy7zLLRAj3Q6zI9VjjEPEukuHxftwt1sGI8i8+IHLf
	x0/EDomkZb9sXeAYYKUh4k5NkRaxcO0RZzk47oEOLLidwABFOa4l8Rfokq6OecjVekn6m/MuuHd
	nT/vbQ/KU2jO/tHhTnqa5wRQFP12gjcZVc4Q8cv5p4SzfFzdqTQlDDn/YihKUt+4fAlTjwFl4WM
	AfdhaOKAVJra1VAx3MP49NLP25HUzNlW6c3bDVe/5FrpY8ZR7tKZlTHkf9zVnwalUHkntHpMAy0
	KQaeXZLWcESstuc3BXutppErG5DHbpNtKtCjh9c6sAHb7kmp43hFW8xru0ao+wuk5efKmRHvWsY
	Z1GEL7Yl4dJ/SENv3BdJtcCSKVn2CWuiBAzv/GuavvYvaXFzmgs2hescAZYzQHZT2bMnugxKZkS
	6VcelZNb9cdzhQmDJiahN4UuVDVciGE/BnvcTUDN9kNxI/iLRuoDE=
X-Google-Smtp-Source: AGHT+IGrpw/ztz8lQHk5n/Diu7FydfYc10cG+TYVFE8BGuAzR90NbrZZ7iq8psbYjIViY4gAZI/J/g==
X-Received: by 2002:a17:907:3e1a:b0:b73:4d06:bc8 with SMTP id a640c23a62f3a-b7d23a22b5emr1855064866b.53.1765970113720;
        Wed, 17 Dec 2025 03:15:13 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa2e817csm1933465066b.19.2025.12.17.03.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 03:15:13 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 0/2] PCI: rzg3s-host: Cleanups
Date: Wed, 17 Dec 2025 13:15:08 +0200
Message-ID: <20251217111510.138848-1-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Hi,

Series adds cleanups for the Renesas RZ/G3S host controller driver
as discussed in [1].

Thank you,
Claudiu

Changes in v2:
- added fixes tag for patch 1/2

[1] https://lore.kernel.org/all/20251125183754.GA2755815@bhelgaas/

Claudiu Beznea (2):
  PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
  PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and
    RZG3S_PCI_PINTRCVIS

 drivers/pci/controller/pcie-rzg3s-host.c | 34 +++++-------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

-- 
2.43.0


