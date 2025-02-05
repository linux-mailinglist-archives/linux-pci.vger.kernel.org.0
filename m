Return-Path: <linux-pci+bounces-20775-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 674D4A299DC
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 20:13:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE38A3A8801
	for <lists+linux-pci@lfdr.de>; Wed,  5 Feb 2025 19:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADCC1FFC48;
	Wed,  5 Feb 2025 19:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gNETaXez"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014761FF7BB
	for <linux-pci@vger.kernel.org>; Wed,  5 Feb 2025 19:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782762; cv=none; b=tUmnSb/+Q8k3/zIuxeT2VmvZKGh0jDjCjiX9Cic5+Sn9GK3MiWLE7xXxSsr/xEbnOOltMrdo0mMGgNexKWwdDwRDtZ3QlN5IkrdXKZYrR8MwizxclklJcEMNPIRIBm9fPx2A89STsS4rO8M4OY9m1cP1eV0ySRZde5N2IVYfvsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782762; c=relaxed/simple;
	bh=wZgft2YLjV2DroNV6XigKYbwwzbKeQIY9KdCoa4mICQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rPwoejDemflwkGhPPEFt/ysnk7hvpOFPShSaMDdOUW2hCT7Ja1YCnKcKa07leG2tPw6D8T60VDIZFGM7/2jMprzy+euxtfgJqShVdpBK8YLWCBEEYVsVNAauitKqSFDoO6gPU1Ph+dd3ajwR3SX89pbOKoCYFHoGySfEpDctJPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gNETaXez; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21634338cfdso3603665ad.2
        for <linux-pci@vger.kernel.org>; Wed, 05 Feb 2025 11:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1738782760; x=1739387560; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10mgnfIVzR+iSJ+OJSuQ8EcOXoSsF+yM91bimaJiDRM=;
        b=gNETaXezgNkXhyYIrmQJ9NUstck9E17lhxH3vgBSSteHFXDxiyQozJi3FefJvpTQM4
         ozEEZK/Ccx8m+EhjhypuCY3hr/oPXXzPKaoNU1ZoaWuOydrQVwvPLHDL1xLSWzFJqlsa
         sYVdvtpj/VPihCFCpkC7AWnNu6vpa95xUvHZs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738782760; x=1739387560;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10mgnfIVzR+iSJ+OJSuQ8EcOXoSsF+yM91bimaJiDRM=;
        b=D4cgZegOBka3rytMArPUgUar2Jm/7YwoQyQhXIyhswgHpeALY1+z1Ue4GOqrUOUxGY
         KGaKbseRLmThrxfOlyg59EMabSliwFRlcMjYaupKIqDJsAu+2tWDuxpBKjMBCqGANxxR
         7HDELpffC2ZmUZGnRiNJaRRHWeqqsAGXeHHaZped9VcCb3YT9h3Obf6swflcw4psGCZD
         ERwUoXXnFbi/4/FOrXwOOG+l8vAbkATE33fS/K5OUXtoqyWlw/1Jefbpj79IG7N3+0Df
         43kf6DC7cokhIGGWD8fSdYFc80HNy2XbJrC5zSsJnVdskTWpoJUGikt7BHlur0T8IEhn
         cxnA==
X-Gm-Message-State: AOJu0YyLE/SqGndgptFyHYF2lSnSf4aALsEtAYRim0Dh4+pOtqAwD0Yn
	95hUz8mw3c1Elq1yfMlwhGy/m1yfyY8wQl2OHAW+OpxKnSBaL2N5R2mqQ+/jCQ4LLnzT4SSNSHt
	2NVgsLog2I2blQd60XocsJ//G4JbNLt1XDI9YnqQmCLs6htPj/ml2OdY9AVz+YoyGULqXHxlHpG
	0L0f6450fun8/ppiT/uYiPMW+YbI6C/ToV8TEdqkP040ax6rI4
X-Gm-Gg: ASbGncuJMOcVo2AupjUQcrpR2KyO8JMiiHAefIFjav1yBLBsPeGfvj7LwDFzW1DPbot
	QN1uqgpc48GYaX/6rrvD21U4NNLyH8nlT6APObPTzyszegrqVi9Is6KWgASmt5YypV2NsFf27z8
	ozSGTDnyGkUChjqVlItl+xI8Bf4j3JZCtZqhQ4sLqZBlNdiXShp6TWJWtrSj5AIToCR8Etiksou
	gGVVe/j9ACMI5VWzAWQtPizWWX4fyvI/i899pL+CzuIagMzRENQHTGSPv6b9YmIGS6ztY1UJ7Fv
	e7buS7NEgMrOMEWemqGr3g4X+LS7/fn5o6YlqRn85DXLltKVODOAko37LLLEwadDU+WnHQs=
X-Google-Smtp-Source: AGHT+IF/Wwlp9qYJd0K8y8zdsTfFgaW5Ghm0UX8Zc6UwKaMRKZ6CF/yzfZfIYoJNe7yUoNtnkLYNSA==
X-Received: by 2002:a05:6a00:3905:b0:725:4615:a778 with SMTP id d2e1a72fcca58-7303511d28fmr6538015b3a.7.1738782759745;
        Wed, 05 Feb 2025 11:12:39 -0800 (PST)
Received: from stbsrv-and-02.and.broadcom.net ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72fe69ceb1csm12670842b3a.151.2025.02.05.11.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Feb 2025 11:12:39 -0800 (PST)
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
Subject: [PATCH v1 5/6] PCI: brcmstb: Make two changes in MDIO register fields
Date: Wed,  5 Feb 2025 14:12:05 -0500
Message-ID: <20250205191213.29202-6-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250205191213.29202-1-james.quinlan@broadcom.com>
References: <20250205191213.29202-1-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HW team has decided to "tighten" some field definitions
in the MDIO packet format.  Fortunately these two changes may
be made in a backwards compatible manner.

The CMD field used to be 12 bits and now is one.  This change is
backwards compatible because the field's starting bit position is
unchanged and the only commands we've used have values 0 and 1.

The PORT field's width has been changed from four to five bits.  When
written, the new bit is not contiguous with the other four.
Fortunately, this change is backwards compatible because we have never
used anything other than 0 for the port field's value.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 drivers/pci/controller/pcie-brcmstb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
index 2d1969d7fd30..da7b10036948 100644
--- a/drivers/pci/controller/pcie-brcmstb.c
+++ b/drivers/pci/controller/pcie-brcmstb.c
@@ -176,8 +176,9 @@
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
@@ -328,6 +329,7 @@ static u32 brcm_pcie_mdio_form_pkt(int port, int regad, int cmd)
 {
 	u32 pkt = 0;
 
+	pkt |= FIELD_PREP(MDIO_PORT_EXT_MASK, port >> 4);
 	pkt |= FIELD_PREP(MDIO_PORT_MASK, port);
 	pkt |= FIELD_PREP(MDIO_REGAD_MASK, regad);
 	pkt |= FIELD_PREP(MDIO_CMD_MASK, cmd);
-- 
2.43.0


