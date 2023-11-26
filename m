Return-Path: <linux-pci+bounces-167-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B0F7F91B5
	for <lists+linux-pci@lfdr.de>; Sun, 26 Nov 2023 08:14:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 01B271C20917
	for <lists+linux-pci@lfdr.de>; Sun, 26 Nov 2023 07:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F7E3C2F;
	Sun, 26 Nov 2023 07:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="djLRIGJM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com [IPv6:2001:4860:4864:20::42])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3AE85
	for <linux-pci@vger.kernel.org>; Sat, 25 Nov 2023 23:14:45 -0800 (PST)
Received: by mail-oa1-x42.google.com with SMTP id 586e51a60fabf-1efb9571b13so1951220fac.2
        for <linux-pci@vger.kernel.org>; Sat, 25 Nov 2023 23:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700982884; x=1701587684; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1E7PvdLj3nF/M5Lr3ChS7UisI31Y6yBvX5wmzhXNEY=;
        b=djLRIGJMEL5bR1IjAQlP5RZJxU+kHZaManrwqjlUWKr5HcunmeZLh8w+8eO4QEjbxe
         2kZBNU8ygGaGbtr0zxUk7nZRJr4cKT61TBOphXyn6EyEa4TaPv3eQBRQ7KwXks//kSmD
         /uSL5wkcMqWG1zWhYEyoBlqbJghNN9k+KUhBCVLnj867o/nwWFBO7lEaB0eR+Bo8DlVl
         iZCoQZG7a4LAkVG7cKFRPc4P37bgReHFOhcoQTBtfs9fcHb2yO/5JXNUd1QmCfX49Gnp
         49HwJR0rD2uHOd6Z0gbCtLX9RjIKoQS5kTveunTMlbb2YWdtibib/2EAQ4bTvWyUnNZV
         DQ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700982884; x=1701587684;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1E7PvdLj3nF/M5Lr3ChS7UisI31Y6yBvX5wmzhXNEY=;
        b=kowar8hlt6U9pJWUOjm1EGJTwgrAQ15JhXKOYmpgTOMEs858L/cXS5b18/ooM02ecN
         QzF7vNZlcRC1xy8AwSi9WyslUeaxNEWaJLIsHKBny9UBJkp2qm3vSNBoS8hGnFG30mEA
         l2GEiivS+oPJhnBqeQU3KbZlAzokMBCJytmhTvOjmYKnA3ns4xJXsGYgMEdOTGb1W15D
         6khKl4JLtpX3geXBCKs9tf3QzUOfpknUWwMLDfPzlnvRVbqF6hbXlO/ys9AflCCmiXB7
         DkT7qzg+uK8A8FBawT65LbGlowoHRVga8GqzpI0HAT3weeqmG+dNj9eCjc5waQOqVULj
         RCIw==
X-Gm-Message-State: AOJu0YxBkfEE2dTjoygaNEWYkUGJ36EToKtm9+gjFVYKVqdGZOD9W/jr
	6l8jyimNMfKXZbpnZo1+LHY=
X-Google-Smtp-Source: AGHT+IENSqhtRKilKg4A91pY5p2+JbsQxxtoiOakV+LGT7j1GeR/5lhxP+BZacsT+EstkroniyH1Pw==
X-Received: by 2002:a05:6870:718c:b0:1e9:d25d:3cb0 with SMTP id d12-20020a056870718c00b001e9d25d3cb0mr10647050oah.21.1700982884694;
        Sat, 25 Nov 2023 23:14:44 -0800 (PST)
Received: from song.localdomain ([219.145.35.232])
        by smtp.gmail.com with ESMTPSA id i10-20020a170902eb4a00b001cfc618d76csm333805pli.70.2023.11.25.23.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Nov 2023 23:14:44 -0800 (PST)
From: Harry Song <jundongsong1@gmail.com>
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org,
	jundongsong1@gmail.com
Subject: [PATCH] PCI/RTR: Add RTR capability structure register definitions
Date: Sun, 26 Nov 2023 15:14:20 +0800
Message-Id: <20231126071420.4207-1-jundongsong1@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add RTR(Readiness Time Reporting) capability structure register
definitions for use in subsequent patches.
See the PCIe r3.1 spec, sec 7.35.

Signed-off-by: Harry Song <jundongsong1@gmail.com>
---
 include/uapi/linux/pci_regs.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index 85ab12788..47db4915b 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -734,6 +734,7 @@
 #define PCI_EXT_CAP_ID_DPC	0x1D	/* Downstream Port Containment */
 #define PCI_EXT_CAP_ID_L1SS	0x1E	/* L1 PM Substates */
 #define PCI_EXT_CAP_ID_PTM	0x1F	/* Precision Time Measurement */
+#define PCI_EXT_CAP_ID_RTR	0x22	/* Readiness Time Reporting */
 #define PCI_EXT_CAP_ID_DVSEC	0x23	/* Designated Vendor-Specific */
 #define PCI_EXT_CAP_ID_DLF	0x25	/* Data Link Feature */
 #define PCI_EXT_CAP_ID_PL_16GT	0x26	/* Physical Layer 16.0 GT/s */
@@ -1065,6 +1066,14 @@
 #define  PCI_PTM_CTRL_ENABLE		0x00000001  /* PTM enable */
 #define  PCI_PTM_CTRL_ROOT		0x00000002  /* Root select */
 
+/* Readiness Time Reporting */
+#define PCI_RTR_CAP			0x04	    /* RTR Capability */
+#define  PCI_RTR_RST_TIME_MASK		0xFFF	    /* RTR Reset Time Mask */
+#define  PCI_RTR_DLUP_TIME_MASK		0xFFF000    /* RTR Downstream Link UP Time Mask */
+#define PCI_RTR_CAP2			0x08	    /* RTR Capability 2 */
+#define  PCI_RTR_FLR_TIME_MASK		0xFFF	    /* RTR Function Level Reset Time Mask */
+#define  PCI_RTR_D3_TO_D0_TIME_MASK	0xFFF000    /* RTR D3-hot To D0 Time Mask */
+
 /* ASPM L1 PM Substates */
 #define PCI_L1SS_CAP		0x04	/* Capabilities Register */
 #define  PCI_L1SS_CAP_PCIPM_L1_2	0x00000001  /* PCI-PM L1.2 Supported */
-- 
2.17.1


