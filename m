Return-Path: <linux-pci+bounces-42691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D83F7CA75BF
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 12:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CB9C730B9140
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 11:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28F92F8BE6;
	Fri,  5 Dec 2025 11:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aQKljUeY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D0A3242BA
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 11:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764933892; cv=none; b=Smj3eli19wMbOPPA9xGxO2zvwQTaq7gmVSru9wXoGlZfaLSlwyBvl56nZwf5zKfUlH/a70igOS1qrrd/7yGXT5ZFz42ltszGj0DL+3pohtj6jN99EIWbpHqp/Dp7RE7HOdgPxXlW9apg5qx4IukrY85xOudcpFLTr2wKPGdWHMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764933892; c=relaxed/simple;
	bh=7mvPTtAkxGch/589grpI4OSJ06JNoaZrJlWD5ezBPYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cLuZnGcQgGfxuGm5i8TgafecgvosbJciXV4DIp976H4zGoLtCdc1tuXcmkbzk+Skl5jiC+ED42RN5eWoQsVqWtLRVr9ZExBUv7RMSKGxsajsNE8//whqqIEZBqkc8LSr6h1slcJDsstgQFGo2EVYxOSk2cfZcDoDV/Xx69VHH8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aQKljUeY; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-477a219dbcaso21734265e9.3
        for <linux-pci@vger.kernel.org>; Fri, 05 Dec 2025 03:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1764933887; x=1765538687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p+uaOHWzNRe+p5LocFUj4Ghbmcl+3sN5RqjgY7tb7wc=;
        b=aQKljUeYj8vMlq3T5b4GqwDrJDIx2/SFwTlCzIw+BKGZq1/JbZehFnIbQpLnZr9Pb2
         cQLD5xquBhE7hPMZaV13KnRe/ttFaP7S6gp6+iKQjwO53PbxU9uuFUxWDNpAAS/XplLt
         /VqmzIPJ1Kt9BEiyJRrmW2hkJw4WdsCXUiOdL1NpQMDBwcxpG+vWbFlfbgjXkeUyaP7l
         eTZBAV+BYLF1g8g+SIcoUhJM4qr69cGu1RJZYbvHvGwarSWlUal1vm2qdClO4P9jUKtZ
         T6FSysXKChfzaay2mykObTiFw5oYGqbkmCP4nyEaVAJBBTzLlQI9c79LMv8t/2qgfrj4
         V+PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764933887; x=1765538687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p+uaOHWzNRe+p5LocFUj4Ghbmcl+3sN5RqjgY7tb7wc=;
        b=Myd29kecsw8NZSNe2LtJfTHS8Ox97pDrXu+p8ls3DH08npoVYnOJejC0G6jXYZJtJ1
         fThrBTDzdAFcu2tKMfg3SUJ3DV4lnde/SoUv1ZrltvPHCzR0N00H7lNL9V9OJtuyc5jK
         DEK0+sUj7g7TCZzjhe0XhWuEBaDaBttDWyiQPlNTgKsej6iNxG66g3NbByOEdwnmIDi+
         MYaMqV+8cVNAM6wQMQqpnpoduXsMAQoFRB8O61G6SBoY7PguUhIMksnslpjl8qjqMaGo
         06XhlBxl6r2jAkftCjpEse98VyDUu79uv0Rc9UKQu7fOAHLx8SeDNhjJ7WQ0ml9Z09vH
         Eieg==
X-Forwarded-Encrypted: i=1; AJvYcCWk+bLAamVRwkfk18xH7IPQ+6VrxX95XcsFeBMpULpJBtCH8mC+8dizniobsPWl4uYOwPDOl2xeAVQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwKbgdHb16LEH01KnCzX+PCB6+jxG/EBfi7e5g/+PIP+NrlUwz4
	PI4x4f+YXnwLu/q5+zbkWw77h3SOTeCTDBZ5Jge0pu5QESTpdOp468jVLruTAO2hOiCrR91jjs0
	WccHA
X-Gm-Gg: ASbGnct7pvIN69wDclsIh5oMEK80f/mIKwazm1CVFpcNXpQY9QsVXSoRrJF25JL3NpP
	a2Of0WNcTDqeC72zE8YCoafsfuDnF1qbCk6erZrtiyaB7hsvZ6uBdW821D+VueTRCyaM3HDPCUW
	I1fEUlfK3PZTDPMfu1qzHz63XWIThwLLnAIDz4DX/deBSIXvg56HEE9tQSLWyLHYs8Iy4NBqOss
	aL2t18HjKgs9bTJfUsZjA/9/7Q0OD24qohWsMGvFSUBcVeX07x/kDKBztmsXesS3cb0i/h5duua
	K2rM1JGtIdmDCd58XvczdJRA/MRD+4Yhn+eRBYXS4MN8SuZMZsgHAoqgvVKtlIFmdVYL65qLMUs
	2dkq8f3oKDRR2nzL6v3W+VXVb7STtMTCbgdLqyapN5KmakUbHHXl8oLjcS014aAVzwEVRDyZZ0P
	FN7Tw9dWixCSMPuDRMG2OXqWJDexa8YxY2sA+J5p08
X-Google-Smtp-Source: AGHT+IEop5yf/enJbkcuIAAdW/2CeTmAvsqsHkxaqBz1Tg1XGRKj0gw2WAKsuQEoDfx+YIrCtjBn2w==
X-Received: by 2002:a05:600c:3b22:b0:479:1ac2:f9b8 with SMTP id 5b1f17b1804b1-4792af2fe93mr95141625e9.21.1764933887118;
        Fri, 05 Dec 2025 03:24:47 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-479310a6d9dsm78176435e9.2.2025.12.05.03.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 03:24:46 -0800 (PST)
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
Subject: [PATCH 0/2] PCI: rzg3s-host: Cleanups
Date: Fri,  5 Dec 2025 13:24:41 +0200
Message-ID: <20251205112443.1408518-1-claudiu.beznea.uj@bp.renesas.com>
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

[1] https://lore.kernel.org/all/20251125183754.GA2755815@bhelgaas/

Claudiu Beznea (2):
  PCI: rzg3s-host: Use pci_generic_config_write() for the root bus
  PCI: rzg3s-host: Drop the lock on RZG3S_PCI_MSIRS and
    RZG3S_PCI_PINTRCVIS

 drivers/pci/controller/pcie-rzg3s-host.c | 34 +++++-------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

-- 
2.43.0


