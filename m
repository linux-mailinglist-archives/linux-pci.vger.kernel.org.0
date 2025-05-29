Return-Path: <linux-pci+bounces-28595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39773AC7C37
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 12:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E98FB5002FF
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 10:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB99290093;
	Thu, 29 May 2025 10:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Q3CtZRCJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D7B28FA86
	for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748515698; cv=none; b=FHdf11a5meNoWOB/IRkZNe9u7LmjLqKrxn/ycGUXgIDvH3bvo756G/i9lSZ5q2KQhSt9UmobZH++7m536pLdricgrNDJgDQd1s38jYRkqk1duZv8ojFRcAAAal9HY58tX7TXmgwIDzQSRIhGO6iqgyvz/Op1JPz1d1bCUWijAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748515698; c=relaxed/simple;
	bh=Cxv3DdNSTbG6mkWW+XlQDzM5M3k//FCq7uG/9MGjWvM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ogf7fBrgditU1QdEJebVFuuVnKZ7MaDyIQ6wsWMwcc3eGbgCtJkdmuSPtIeHkh7WGPwdmhyjH2jtOfgnPI81clN5vuuUHkJCvMicywZlGgga4gU4HdD2yABSzFH2tT/pPDsNI5xx3SE36eKAiB0TN9D23BDDfJU8qr4ckg9ciok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Q3CtZRCJ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ac2bb7ca40bso158850066b.3
        for <linux-pci@vger.kernel.org>; Thu, 29 May 2025 03:48:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1748515694; x=1749120494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i8LMEHYmovrRN8zYWQwYy5+2ddqvSDMDQcnZraZcEHI=;
        b=Q3CtZRCJowoXIw9k5V+3iZoCTdugPF58iaqdfcqz80heP0XsjGP0ABOSveurgOuHYE
         GHm89aeuaU7zghhvq9/WpfhwyhDFWfsHIiBIpUc8JZcguiJTz3BJ1cqwpyGZS8dhzP4F
         drGimBhYTxl3t3ALgQMncORgvKX9iE4HO4/S45E822yfoGb2EPnmH0fCz3x0DD5MAOSc
         ezPmAq4UAUU+JbT7igdYJmMiAWShIssFwVNUlFlIUPLwewCpL/bC8H75h8z21TcPBl2z
         77ZhBj0KvUfYH9+5oOfpBpMnenj70rKWikvl9R0Pp8fwbkUS1ju5hH2DHoIozYrLH1Gd
         xKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748515694; x=1749120494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i8LMEHYmovrRN8zYWQwYy5+2ddqvSDMDQcnZraZcEHI=;
        b=N/qQbAeb/fmG1Ma7ovxaAaFHwWc8NhGbKb7jKcIgaofPegTfnflkULQv2aP8SVVfkf
         9z4ckJ04BdufCcZgTmBobf2lcEFuE1/T+9/zh5yOWCXDAm2gR4ZmLHzurf9HqQidbDj9
         LRHGFltpp2JAn3pOQzBfhXYO+dYJp/mX0tjm2Ueus13Gr4DyJyH1w7/VNj/Vv3hLoJLn
         mWLiY7eXdzCZ2J6exGzVEFDMF0FLdZB9FEpsuDNztoV7LI9U7Aiy4ZXlHu4ojI65HpZr
         gJtVSjKhHqmhazxeyaE0uJ8Aa5n7KnlBKVs+IFDwIK2sIkki0YQ2Lsz55P/74ZKq/mYr
         WM0g==
X-Forwarded-Encrypted: i=1; AJvYcCVNF9HxtEY3KZldo8FqVty5eo6UeFE7nL1zVV2Owjn1uvde4g2V+uDg5uO0Tzr6fEVl1T1I/WSMVLA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzClRasUreDA/uMGViQXD9NI/PU1E427gjHv77hWdkEcbNO3ClY
	p8g5FGzzBGSbtMS5qeIPfMDw6D7f4e4mSfBI4WENkr7UWJssWgRk9StvptiTWsYUkp8=
X-Gm-Gg: ASbGnctoY3TTtkGXs5NLyjX/fUx3pRC039xZ95aGtbux6Uskf6euQFKjG/bEieg81q2
	xomuop8sbwAHcfuNGqTBVH+NhMWyYVL4vAyXYbfNkAzUwAbRYUDdSAtqtb+h22cOf7YaEL29IYB
	XwSPG9lCjvASpcYQIL8bpB3EUoMQxdody/VIpIzBpQi+ge2kz8Ra4V6Os11Ir+Xa07rTrJkNkYf
	UAF93uutO51iTEbSDI1vDhQu++RPM9LvCTavMrAWlpw0+eo9GV7BD5zSRXWcukFWiK4DDgiqV1o
	1UGF/dXiDKZWtOfpUGUAAvov60H8ir/2CsjU2BlbIKZXXMg07VmBHTshi/dCIjoXYm+0VoU7b1W
	omdZUGaRhm6ljfPaFz3F8vg==
X-Google-Smtp-Source: AGHT+IFh2Bjt/nqjLOv5kZdMBtyzXg8Cp6AwiLw6gyh2kIz8WiLSbkCwXlnCYcseB95A5qV9519CkQ==
X-Received: by 2002:a17:906:c152:b0:aca:c38d:fef0 with SMTP id a640c23a62f3a-ad8a1da7029mr467304966b.0.1748515693881;
        Thu, 29 May 2025 03:48:13 -0700 (PDT)
Received: from localhost (host-87-21-228-106.retail.telecomitalia.it. [87.21.228.106])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada6ad6aa17sm120147166b.175.2025.05.29.03.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 May 2025 03:48:13 -0700 (PDT)
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
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
	Matthias Brugger <mbrugger@suse.com>
Subject: [PATCH v10] MAINTAINERS: add Raspberry Pi RP1 section
Date: Thu, 29 May 2025 12:49:30 +0200
Message-ID: <20250529104940.23053-8-andrea.porta@suse.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1748514765.git.andrea.porta@suse.com>
References: <cover.1748514765.git.andrea.porta@suse.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Raspberry Pi RP1 is a southbridge PCIe device which embeds several
peripherals.
Add a new section to cover the main RP1 driver, DTS and specific
subperipherals (such as clock and pinconf/pinmux/gpio controller).

Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2b16ba4eb1ce..2add073f5bdf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20197,6 +20197,14 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/media/raspberrypi,rp1-cfe.yaml
 F:	drivers/media/platform/raspberrypi/rp1-cfe/
 
+RASPBERRY PI RP1 PCI DRIVER
+M:	Andrea della Porta <andrea.porta@suse.com>
+S:	Maintained
+F:	arch/arm64/boot/dts/broadcom/rp1*.dts*
+F:	drivers/clk/clk-rp1.c
+F:	drivers/misc/rp1/
+F:	drivers/pinctrl/pinctrl-rp1.c
+
 RC-CORE / LIRC FRAMEWORK
 M:	Sean Young <sean@mess.org>
 L:	linux-media@vger.kernel.org
-- 
2.35.3


