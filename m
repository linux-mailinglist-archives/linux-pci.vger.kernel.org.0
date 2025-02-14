Return-Path: <linux-pci+bounces-21507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BE097A364E2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 18:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6A3189508D
	for <lists+linux-pci@lfdr.de>; Fri, 14 Feb 2025 17:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E207269AF7;
	Fri, 14 Feb 2025 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SQLOb6CO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF67269AEF
	for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 17:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739554821; cv=none; b=gjt12TIpHI4sw7+RCgysl1tK+anSMvxub7E2IrzkT0k6kRdDZxz3dAMw8Nd0Qi3MEG0luIsfTtDkqw9WKj02goGymVlQmDMemrGqdDxRzyZeso0snozlV+/dF0j25hLl9rKVNh5ggyCw/ewY3F3nHW2UYGXrXHzXcs4U76trEtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739554821; c=relaxed/simple;
	bh=fGgqLUYQ3l+rbJFzjKjU0U0rU073XUhDX3WKSwxzq9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iEwghY6s7vibimOlQDDwlksHViVVNgf5ir6Hn/3aX5Cs898zkDpWVsqXO/H8X3IsqIaMv4/Pm5ecME8D4YPKns+1SM3fKkzhifs0DTS8Z90X/w7YNoori3LjY5SpUUAk7xA9TK4KWCzPEIXIBk+sGfgb/tYoLyQvGWpHXfQhkvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=SQLOb6CO; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5fcb3ee41c5so590194eaf.1
        for <linux-pci@vger.kernel.org>; Fri, 14 Feb 2025 09:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1739554818; x=1740159618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CSW4cfeQPfDzJdrXVnX+xGV7pqYpNxrZbvVlU0rLzgU=;
        b=SQLOb6CO+0a5oC6HFk4K90rrSIg5jYZ2GU3l8gR507Rfs8tNjYLHyOvxR4h0C6TQ0g
         2SAiiPOWYdIoOq/nUHnZuMwdzOnW26FMICQ+VhCZv70ZXekWiPPgLBkBeJw0pj1Ks7Qz
         nU68mA+NHfSAH4g4o+2ZZn7u1WCl91ofjnkWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739554818; x=1740159618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CSW4cfeQPfDzJdrXVnX+xGV7pqYpNxrZbvVlU0rLzgU=;
        b=PxqGFrB82+fmyfyEExCKZJMqbH2XppoXduXX9rmmXA/tmP/Z7l8ZPRe6gb7hj+PO2O
         l8LmsIOEsIZeYKSpXBrpczBa2WAvplF7ZiKEcg90tOtqhvHyqUTMeU9uYuflQfRv0QgK
         PJ3sviNp5+PheKEH6ACPepdgXEX402GHPTrz8s7W1kjOCiJPNzOnjgyuOfUTvrrfYZOz
         P0/o5oMKL/joMrRG6ezfeGje3jPW+gBGG5Gnsz5Wdv45hOGShdYO8vUrcaJ5OYhVa3Au
         oest0ytuyjjvM7UDT35yTm4McX/79chcxErMgIurDI2uzpexcgb/traqWeqDVDpJ9qOA
         PVSg==
X-Gm-Message-State: AOJu0YwAmSH77rzLPyjWpx/wdTjnHWd1+GRHIQmYsqxs24VUukD0l/sU
	jFfeTWiZ7aRPYm1ImC1R837cPmnebK1bccTYMDGtIWhfgRo0HhI4ZeCQiS+2lWa4QYd2DyOUGY1
	zDNaJmkN/HfPBo6B7w3c+HPak1KZHv83hJvIY/XmWzxYY4p3RI57X+hCBTEKWjDSDE5xPopkgv5
	wzPmaQa+mrpis0qdoWHeOOotzSktpIkkcUCL9QJv7ly8Vxn8Vd
X-Gm-Gg: ASbGncsydD70w4ui27NSWWGyLKS1QlkJU04/PXzlQGud1ngJWSp3X9qBIUAsrtNj12a
	2rqyMapeupf2j5azAhr8rI2x30+DTAObjLwRi1f1h9SG0daKMhs0ioVmSiiHyYdZIsh+RoRuAKW
	iDWbdxA7ZOoL5eYz2DWhJfU0uWpzQ65YWOYGgpnNzk+tQ02POiwt+5KnZMQW/zENT0NW9AesofD
	hIsH8Dn4pPFi03pUQlVd/SDUO25cByqpVEAVgCOIfEDf+SbdHd3yLRW+Zto/CQh9QpKojzzaGJz
	p82XmTMUgo0Rf/+F+LBmg8mrAH0RKg+I2xealrzkGaUzEGBCXqni8NAa1ieTjpO1RuMPBhk=
X-Google-Smtp-Source: AGHT+IGzGxY4gVdlR82gAdB7cjaGdcaL5kCbohfl9gRTT5OL6p6gaqIDXsIm/04V9i6hRIlQvRjbtQ==
X-Received: by 2002:a05:6820:1c8f:b0:5fc:98ab:2b27 with SMTP id 006d021491bc7-5fcaf54776dmr4801224eaf.6.1739554817648;
        Fri, 14 Feb 2025 09:40:17 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5fcb17a4ca4sm1284073eaf.30.2025.02.14.09.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 09:40:16 -0800 (PST)
From: Jim Quinlan <james.quinlan@broadcom.com>
To: linux-pci@vger.kernel.org,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	bcm-kernel-feedback-list@broadcom.com,
	jim2101024@gmail.com,
	james.quinlan@broadcom.com
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 7/8] PCI: brcmstb: Make two changes in MDIO register fields
Date: Fri, 14 Feb 2025 12:39:35 -0500
Message-ID: <20250214173944.47506-8-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250214173944.47506-1-james.quinlan@broadcom.com>
References: <20250214173944.47506-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HW team has decided to "tighten" some field definitions in the MDIO
packet format.  Fortunately these two changes may be made in a backwards
compatible manner.

The CMD field used to be 12 bits and now is one.  This change is backwards
compatible because the field's starting bit position is unchanged and the
only commands we've used have values 0 and 1.

The PORT field's width has been changed from four to five bits.  When
written, the new bit is not contiguous with the other four.  Fortunately,
this change is backwards compatible because we have never used anything
other than 0 for the port field's value.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 923ac1a03f85..cb897d4b2579 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -175,8 +175,9 @@
 #define MDIO_PORT0			0x0
 #define MDIO_DATA_MASK			0x7fffffff
 #define MDIO_PORT_MASK			0xf0000
+#define MDIO_PORT_EXT_MASK		0x200000
 #define MDIO_REGAD_MASK			0xffff
-#define MDIO_CMD_MASK			0xfff00000
+#define MDIO_CMD_MASK			0x00100000
 #define MDIO_CMD_READ			0x1
 #define MDIO_CMD_WRITE			0x0
 #define MDIO_DATA_DONE_MASK		0x80000000
@@ -327,6 +328,7 @@ static u32 brcm_pcie_mdio_form_pkt(int port, int regad, int cmd)
 {
 	u32 pkt = 0;
 
+	pkt |= FIELD_PREP(MDIO_PORT_EXT_MASK, port >> 4);
 	pkt |= FIELD_PREP(MDIO_PORT_MASK, port);
 	pkt |= FIELD_PREP(MDIO_REGAD_MASK, regad);
 	pkt |= FIELD_PREP(MDIO_CMD_MASK, cmd);
-- 
2.43.0


