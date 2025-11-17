Return-Path: <linux-pci+bounces-41370-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A6D61C63150
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 10:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20A6E4F1520
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 09:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 478803277A4;
	Mon, 17 Nov 2025 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="bRRQepz3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0493277AF
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370575; cv=none; b=TrhkoI4PgZ1HQj8l07IhkY1U++aAVCVwK5yy3EOxVRodj4KjbeZbnTU8BUzYpAfQMKsvU0gZchwQMggV8Hy66bORm1LkYJgvJ3JJO932nIumvEkjm2p4l5wmUeJrbTmkqYo83woSxL+1+eSflWMgXvaE7IlR1RZQAvRRMuQL9lU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370575; c=relaxed/simple;
	bh=Uc0m+u0MfzVGyhFoLK6/9eDa4VlgU+XOoqI+PI/Ba+4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GX8ay4OhUrvQi6flNiBe64ol6Wlc3eLTTlaKdDap2WMmBth4CH/sOirfpH/sWF0x7jUU7Rwmx1vFakDDQlTRDUAf2Hz253nKclJUrNlg9oC03CIB3WdzscNCQlMNd30Ub1sTFONCSVb7i8yhYdeLNR/e9MpNK0flDtB27U6MQWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=bRRQepz3; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-42b32a5494dso2324828f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 01:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763370571; x=1763975371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8pjDugLKEkjAIimWBDbAyQf5qbHt8SfkOSPMTheV0Y0=;
        b=bRRQepz33UaVXEcFsMqvBSRlcw977qDw4RQpJDuuZmBxQqwcN60KUcK7f/xnAHApPx
         yHkKTusUigICyyev0WqoLpMCVLbGe6g80WJnvoWqKY27c9n84HpPMAn3lWG/iYNtZkhz
         VAtP2v5rx7tosaf6oHwrmtTybPsuaxXm2lfhu24dY2OoOSVyqZGQ9zzmLOgmb4xsHwjb
         ZFzccWdAa+6sgnx1uuSIQ2Q9rH7yDs7CjJU3nCWhMnHEjQOAaoiDKB5rCob2k2c5rbJg
         +5qYhATuVAGb9ad8gHCK5UuiwM2jyckb0s7wdyGg2YX3v2nztzO8kxFlcVJjbHYktQcT
         ckIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370571; x=1763975371;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8pjDugLKEkjAIimWBDbAyQf5qbHt8SfkOSPMTheV0Y0=;
        b=kH5/9pPkUy9K/DPJQ1blyV5CIgPbB9bAxAbwguI2FU0D7MgeA3Ce0vp6H1t/HzP/FA
         aBaH+NW/r6y10LZ7a5vCFJ0Qu/15LQz/rGs5J1OhYucNV/UUke0io5ySN6FUinyH0699
         pp3PWo1hzFttSW48cIi6uz+61v4rk928fDPW9q4OFhnMR1Kj5VF+YWozvQ8pEnY89NOl
         Emsyxuh7AQyyQ6KeSuP+oGpZ2FqZ9dbgW5DDxCsbx/3qciSyDrxghSNZFVaE6++vFrZS
         cruMOggxoCaNTTo1U0H6Daip9ZG3HD3Pzh6ZQymq466to7CTQvpmIYmXru4whii8mF/T
         OgIA==
X-Forwarded-Encrypted: i=1; AJvYcCU+MTZ0RGL6IyjYrNx1le7lD0hWHo/RhSGQcuhy+o6Taxp1Z7rcA38fSM/JXAC80Vcr3UHdFRV89m0=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhu01AXWO3A0kA8ceRiYZ5oifcVrhHzR6vDsq4Dt1h3xU0/qh8
	mRE4woq9FKCbBmyzQLzmcTmISmlH+LHa+9A5obGWl/DT8gv5W0lkWWhDor55iS9YGr4=
X-Gm-Gg: ASbGnctTMG9fwHuYAdivrdKGOddqGQSAkjrKYgr645vMdM2Ib9m4lPD6mStHVn82hZo
	jGtVvdqbXNSWCCV7u1D+f5Sb0VvIQ7RPlS+r5z3SW4c5nvKEOsz9UiFxL/oo8M00YgUOhcq9y2p
	PBEfVrw5Jj9aYHN1jzIw8gIb3hv85S6zm2kgGcat7lAnCcfcnBYfxJbiWGdM1jkVTDfNJhdpcnW
	+V/2qwBH+kEdCnbQmTApIy+VBfCq9hwD8E+2lzyw7XqgxX8aY2PHvkDlT9im7KqwivugRfBUBy0
	xg/RRxS3i3h43T4Ofi7gMJrPz7x4Vf8c++L1Xcv0FSgfbMWLH0R6WB6b/zzHScNgrzFTCHq6Cml
	RikqhfEpaLBTa/CKsixouJ5Zuq8xNcYblAnqN8jalwAr0QeJB7QX5YorAF0q3aG7zHiQE8sIkzh
	YxvpC3I9bq+R5yPXjtKZQWZGJSpbms8gxaI+UQUirr
X-Google-Smtp-Source: AGHT+IFgZYhCnic6U3YhRTVjNXH++Id/AtI5+oMJdQ8+Yorkl9uPjde2OHoNIXg0bcsWSzcUKJfixg==
X-Received: by 2002:a05:6000:2305:b0:3ec:db87:e5f4 with SMTP id ffacd0b85a97d-42b5932482dmr10896537f8f.7.1763370571069;
        Mon, 17 Nov 2025 01:09:31 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b894sm25703786f8f.26.2025.11.17.01.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 01:09:30 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v7 4/6] arm64: dts: renesas: rzg3s-smarc-som: Add PCIe reference clock
Date: Mon, 17 Nov 2025 11:08:56 +0200
Message-ID: <20251117090859.3840888-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117090859.3840888-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251117090859.3840888-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

Versa3 clock generator available on RZ/G3S SMARC Module provides the
reference clock for SoC PCIe interface. Update the device tree to reflect
this connection.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- none

Changes in v6:
- collected tags

Changes in v5:
- this patch is the result of dropping the updates to dma-ranges for
  secure area and keeping only the remaining bits

 arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
index 39845faec894..b196f57fd551 100644
--- a/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
+++ b/arch/arm64/boot/dts/renesas/rzg3s-smarc-som.dtsi
@@ -172,6 +172,11 @@ a0 80 30 30 9c
 	};
 };
 
+&pcie_port0 {
+	clocks = <&versa3 5>;
+	clock-names = "ref";
+};
+
 #if SW_CONFIG2 == SW_ON
 /* SD0 slot */
 &sdhi0 {
-- 
2.43.0


