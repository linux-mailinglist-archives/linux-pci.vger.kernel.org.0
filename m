Return-Path: <linux-pci+bounces-33742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAB0B20B7A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 16:15:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBE7F3A9283
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E75862165EC;
	Mon, 11 Aug 2025 14:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="KzniqePJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BC67217F31
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754921455; cv=none; b=BDVgQlmYwk89A5y49KTQKV2RSM30+vnjXF+/PgsF6Q0b0eCj1rwPeTawLyYauKeibSqXYJnZSgcpFCP6ls+tMDY6ox9q+SX1S506K4aLNYQG58Sxw8OMOCCC5RnOtnJsqzNUzjT+8G0RC9DpiX17j4AmAXnsvOkNDIikQG3bFO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754921455; c=relaxed/simple;
	bh=YQdnjakWI6X1ZHqFhx7ybyszvQDMdraK7i+ce55DJ9Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ar7+zQS8OuMoSbPqhkUNYckaEPfh4KLhGGla12sju71uz78VCipkPu7EEJVIv4WvEIL8YC+NQkzm78T7eff6V6IsWvNaZwfs4i4CyUgEW9fA2cu1jW0Zl2AuDxM/9jtwU0EV8q30xlENtCNWgB7jot5F1Efc/J42p+LTXvKYHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=KzniqePJ; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-61576e33ce9so7541473a12.1
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 07:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1754921451; x=1755526251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VlWQwa2PAoVxO2iD+h8/whtAT2rN/XrFrW/caXqog0A=;
        b=KzniqePJ8BhCyIuG/HFbx8JlA4LqYA8hoQ4DW/g1hCknkihDX+ct9RMafEot1gWoKL
         RBi7t5LHoAslJYNxQicWQA1HsAajiFIy4eQjrOPLBVeLTIZHH3Jwoz47pJyees8MFfcv
         XUbwCImvfbyGp5JNc8Km7W5v0/FpjkAYorsskyJcpZ8sei2KCdVc7Rp9DZOG+Yd/FAzs
         ceQrku/WelAwPWMnemBSjYHE78JqWARZcDeN+2ve5e04pB2kGjDoG9RXtW88m9tNwr5Y
         J77nQI8UpGlH1eB5MlwiGXDOHtjp/s3mlMxaT/d4WcrBZV2o1pUsHLN42KMNG5+4mf3v
         AY1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754921451; x=1755526251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlWQwa2PAoVxO2iD+h8/whtAT2rN/XrFrW/caXqog0A=;
        b=XkSuCcAV7b4Kh3UwGcg4xzXxoaI/Fxxi6mFJq52OSYVE9bWGKFg9I/3KGvZ9q1LOuL
         J01QOCjUo0Au2QKKIGp4fIFzA+t5ZAMYTGi9ydFaMmFhy72OTiyF3YqCGNBI4/cpABki
         OOFCIIztmPb27zdDSKyeS9RD9DNzX9OmCrbzHOBzCuSHCSjvH0XxyzRV0ixn7sxh1+ky
         5BOn8Rc1Fd0fxNGHeC1QRXMjEumzF7qoEqnmf2LkQKtKY5SzCYT+egRyOyXY6zuZYJg3
         NiwxuLGPYLWDaTE9qTcZqbzZPPk4Mk6q+Ss7iX0v28HTzqAU3Dq/ndEteX7V8q/GP9zH
         xnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCNOVXpXnuJjTv5BYrkmrCiUCb720ziyPxHc1I2Mj8QfAv0+BcWoXdH3UtPfGd/+gpx1GtasFubEU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yye0E8EYGnoB+01BpDFRvsAB0IhlubSSrEY3O8SM/F5VyZzQvUI
	UqfFPDXRfmil8BcCBqQ600TflnLe29wCAntIP2aOGHxih6FulQdyzcYP7FR5fidd7XI=
X-Gm-Gg: ASbGncu73avn/0sp/SiGQS3AvJcuuKv8edfXXX9seLXin4RPtbDzbVqXEKPvdsHcDa6
	qrs6FBQUpiK5+LvOH3mSWWY4AL4QhzFp59wHGaGcHH2DrlhkUQXVN1H80tox5GVRTBLvsRTPUvX
	lTxiCwW9sN7aPt0qrFGlZXJ0c9MXACi8LIITfE9uKRy4f+O3u6fd+j7pnyp0G04dGekGgKs5mYc
	PGFNLdwii7Dkyp/81sISgmiZ87mwG8FRZjrhfZPw5KgBsiSsP5oT2yfiQC9tquOoZ+OmWDCCvID
	m7dcpVQKY5jWlNyYf+gP1aYXGu7LITltXG2Isd7vSzyzgg7YqjuWivMEdsqsZ/pi4apxjRA1v9e
	PueEi4PhmVoAoiJpA+/ER36Z5Qd8xGw4rxXiyzQnkYUyfLHyMIUqw1GjeflvCmoMoJg==
X-Google-Smtp-Source: AGHT+IGSXO0okwpD5kpNnaGjEGTT73fQPhYl2aV7TxCeznx0RSbicpQ7u0NLlVgRRhjgMGZAIA2ZgA==
X-Received: by 2002:a05:6402:3491:b0:618:4a1b:e311 with SMTP id 4fb4d7f45d1cf-6184a1be33amr433396a12.3.1754921451307;
        Mon, 11 Aug 2025 07:10:51 -0700 (PDT)
Received: from localhost (host-79-44-170-80.retail.telecomitalia.it. [79.44.170.80])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-615a8f2c265sm18398979a12.26.2025.08.11.07.10.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 07:10:50 -0700 (PDT)
From: Andrea della Porta <andrea.porta@suse.com>
To: Andrea della Porta <andrea.porta@suse.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof Wilczynski <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Saravana Kannan <saravanak@google.com>,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	Masahiro Yamada <masahiroy@kernel.org>,
	Stefan Wahren <wahrenst@gmx.net>,
	Herve Codina <herve.codina@bootlin.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Phil Elwell <phil@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	kernel-list@raspberrypi.com,
	Matthias Brugger <mbrugger@suse.com>,
	iivanov@suse.de,
	svarbanov@suse.de
Subject: [PATCH 2/2] arm64: dts: broadcom: amend the comment about the role of BCM2712 board DTS
Date: Mon, 11 Aug 2025 16:12:35 +0200
Message-ID: <47f6368a77d6bd846c02942d20c07dd48e0ae7df.1754914766.git.andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1754914766.git.andrea.porta@suse.com>
References: <cover.1754914766.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Current board DTS for Raspberry Pi5 states that bcm2712-rpi-5-b.dts
should not be modified and all declarations should go in the overlay
board DTS instead (bcm2712-rpi-5-b-ovl-rp1.dts).

There's a caveat though: there's currently no infrastructure to reliably
reference nodes that have not been declared yet, as is the case when
loading those nodes from a runtime overlay. For more details about
these limitations see [1] and follow-ups.

Change the comment to make it clear which DTS file will host specific
nodes, especially the RP1 related nodes which should be customized
outside the overlay DTS.

Link
[1] - https://lore.kernel.org/all/CAMEGJJ3=W8_R0xBvm8r+Q7iExZx8xPBHEWWGAT9ngpGWDSKCaQ@mail.gmail.com/

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
index adad85e68f1b..865f092608a6 100644
--- a/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
+++ b/arch/arm64/boot/dts/broadcom/bcm2712-rpi-5-b.dts
@@ -4,8 +4,14 @@
  * the RP1 driver to load the RP1 dtb overlay at runtime, while
  * bcm2712-rpi-5-b.dts (this file) is the fully defined one (i.e. it
  * already contains RP1 node, so no overlay is loaded nor needed).
- * This file is not intended to be modified, nodes should be added
- * to the included bcm2712-rpi-5-b-ovl-rp1.dts.
+ * This file is intended to host the override nodes for the RP1 peripherals,
+ * e.g. to declare the phy of the ethernet interface or the custom pin setup
+ * for several RP1 peripherals.
+ * This in turn is due to the fact that there's no current generic
+ * infrastructure to reference nodes (i.e. the nodes in rp1-common.dtsi) that
+ * are not yet defined in the DT since they are loaded at runtime via overlay.
+ * All other nodes that do not have anything to do with RP1 should be added
+ * to the included bcm2712-rpi-5-b-ovl-rp1.dts instead.
  */
 
 /dts-v1/;
-- 
2.35.3


