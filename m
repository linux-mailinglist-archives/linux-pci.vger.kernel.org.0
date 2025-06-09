Return-Path: <linux-pci+bounces-29263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 989FCAD294D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 00:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 41A5F3AEBBC
	for <lists+linux-pci@lfdr.de>; Mon,  9 Jun 2025 22:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15CE42253E8;
	Mon,  9 Jun 2025 22:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KQHk3kPX"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC989224B1C
	for <linux-pci@vger.kernel.org>; Mon,  9 Jun 2025 22:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749507443; cv=none; b=f05apdD8pD04/IlAiCQhJBo3VWco9D29Zly/Z4g6E79UaPx5/Pl/Li2DbIHCYJU6bFokZkUIVJEXQ6PAD+7kwv9QwllKcc6z6W0A3N2a1SfNeajlLjU16qm9BKNcKjgBIueuWp9yr/9J2UXYUV7QR5P01F1k0xEGmC6V/BLoLII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749507443; c=relaxed/simple;
	bh=PTJgwmboDh3zwtCWo3X0HdMzg1bjCtzlOP89sJZk87U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ujk6sa4iEfZ583wyEUZx2ZOD26lBtadvUbcASx0u25/fwR1p4XjlCyRT+GKLnV8B8k+uZWsQdlnJ8P7qp1JxwfOkPkZKL8iDRJhGUdLybUsCX4WjGMCKG0/ZPIMatIC6xuB2ZXPRqEZJpDuHeww7q+/XhfA7zeoWaUf8jYPVHhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KQHk3kPX; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b2f1032e1c4so4460223a12.3
        for <linux-pci@vger.kernel.org>; Mon, 09 Jun 2025 15:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1749507440; x=1750112240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vh/JtGXJq1ScSanttjAc4pgnb9sqVVMcQN566gVE5Cg=;
        b=KQHk3kPX6AbRGseD7ZJk+RehSdnU2Hvit0xwGXTOxGe+7lmS3bZ6GzNYVOlogzoGE4
         2NagoQhiP/eKPNTFR3TaIp2WKpK92mBKNlnQP7lXCNFJptocyaHvoaI2+T31Q1z692Jn
         fMiUzdowM+d9pfN/w63PPa39YQRly1eUNw0Oc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749507440; x=1750112240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vh/JtGXJq1ScSanttjAc4pgnb9sqVVMcQN566gVE5Cg=;
        b=o7ytDfGKzRHA38rHUFZNQfVCbLlkujQyONYC6iyibjzUDrdc9r+r9JpCZG7RizXqRx
         7eXXMyykmbSYecLpae1d2+jdBBaKLshLtM1HRgRHq5amL5XErXktgmTfsmJPSX0adLRk
         XiEyQ9ruxkdH4vL+pwd0ihU2zI/Sct/vy+tP4voLdkzDOpOmxwy+TzfpMPJHzdfQAVTd
         C0fn5m25XTlik1Dww2JX9RrXozvffIc7q49ni+shgfw2RV9uX43FP/3qClJUN3R8Zfb6
         KSZb2Uuf6QPg4fhIq/f2HaNRiXwWon/RxDwkoKC6s0OC3MN7EHzt9y6Y1LyDJD2jd1XS
         sHew==
X-Gm-Message-State: AOJu0YwenUIo3uFLjRFnduSILo3sgd93CvcTkVVh5NKGhxa6p/fUMaAC
	vKASrT49OV3iODTy1AI6/nGGW0gj+TdvDa+NvFO2GiMHQ8sbSDGrmnm9gQ0OzBI9pbgv9puGpUR
	RJYJN0C+Eet42HPhfM3TRhS1RCGtWToWxtNUWvFfFYuxlUfFsDpegzMjn5OMlyjvtlk2fHnt8yC
	t5luaz8E+nonEGi4L9ezP3X82m1fu8EZz6hJ0dtcuB867Rv3Q9Fmyn
X-Gm-Gg: ASbGnctUUwjL06fpemu1p5fWdljW4hkupBnQRDm1HsVPCME18kl0bOEZ6VSODYIVsAK
	3EIt8dxnDikiPikBSEGhT5zyoQKxqepfyrFnRUuufz24x/PLO/qOFB50lsoVp24I0KYz9237/1I
	5b5bCpqCuaj62FoM1lvXdsXUtRvJBHlW3RPwwgNgtjr3UjB22xKDJLtf9yvZeGz6URR/xQXfFrz
	ns3m+WO+J6ZJgvoPaUTwsyBGmLDrDv3pjuMJDVliIl6C3kFe3zpSw2ADDeIbIasXvebdZ5uu7vi
	ai3CsAOTqnO/f1yrkEraOLSKwaybx0lPZik0bcKg8q6dFATNK5C5bHhCcvOUfx7JtVewZzZkjRf
	oflOxOrsDcRhfJpPwJyM4vxlmVDUw1FPvVMs4W3Eb5A==
X-Google-Smtp-Source: AGHT+IGu+nDuRxQ9N/1g/F5ZQ5bigX27pmvAno5gKj+c/t7BgQSFCAow3ysCS4pqkXEmCzwSGjxbww==
X-Received: by 2002:a17:90b:3c8b:b0:311:f99e:7f4a with SMTP id 98e67ed59e1d1-313476822a8mr16779583a91.26.1749507440399;
        Mon, 09 Jun 2025 15:17:20 -0700 (PDT)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23603078d65sm59290415ad.5.2025.06.09.15.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jun 2025 15:17:19 -0700 (PDT)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/3] dt bindings: PCI: brcmstb: Include cable-modem SoCs
Date: Mon,  9 Jun 2025 18:17:04 -0400
Message-ID: <20250609221710.10315-2-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250609221710.10315-1-james.quinlan@broadcom.com>
References: <20250609221710.10315-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add four Broadcom Cable Modem SoCs to the compatibility list.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
index c4f9674e8695..5a7b0ed9464d 100644
--- a/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
@@ -15,6 +15,9 @@ properties:
       - enum:
           - brcm,bcm2711-pcie # The Raspberry Pi 4
           - brcm,bcm2712-pcie # Raspberry Pi 5
+          - brcm,bcm3162-pcie # Broadcom DOCSIS 4.0 CMTS w/ 64b ARM
+          - brcm,bcm3390-pcie # Broadcom DOCSIS 3.1 CM w/ 32b ARM
+          - brcm,bcm3392-pcie # Broadcom DOCSIS 3.1 CM w/ 64b ARM
           - brcm,bcm4908-pcie
           - brcm,bcm7211-pcie # Broadcom STB version of RPi4
           - brcm,bcm7216-pcie # Broadcom 7216 Arm
@@ -23,6 +26,7 @@ properties:
           - brcm,bcm7435-pcie # Broadcom 7435 MIPs
           - brcm,bcm7445-pcie # Broadcom 7445 Arm
           - brcm,bcm7712-pcie # Broadcom STB sibling of Rpi 5
+          - brcm,bcm33940-pcie # Broadcom DOCSIS 4.0 CM w/ 64b ARM
 
   reg:
     maxItems: 1
-- 
2.43.0


