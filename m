Return-Path: <linux-pci+bounces-1322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BAE81D69A
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 22:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 132802829D1
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 21:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DADF16400;
	Sat, 23 Dec 2023 21:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="WGWBs8rb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFFA2168A8
	for <linux-pci@vger.kernel.org>; Sat, 23 Dec 2023 21:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-203fed05a31so2026606fac.0
        for <linux-pci@vger.kernel.org>; Sat, 23 Dec 2023 13:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1703366574; x=1703971374; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Aq9uIMa/nGGGaXr1m2A0PcSADVoztRQWWvtd/EHEe7c=;
        b=WGWBs8rbF/FJJE7KWp+Yz48wds+bafyeiJveGBKI44FfH4B9M/ZfwsmY42cCDPosLu
         HvvR13SV03CMaIdJyX/BSUhcENGhY8j4RXgXT4RVTA6+DvFdffe8lPix51dgaoulSzGQ
         Uco1LMndk2ynA/wnUGijmvBUBAHZrrCf8kGdJ1mMzirBUmdev/Ni0GJYWCWomD6agYbb
         gprRiF63fv670+KXEH2curpl3X/ZukY0xFXPB6o6n9+BW0e4Mfrmazmh/oSNNClh4KMa
         0qiza8+kaSmyOPDNWIzdaiy7X03YBgdkqXQRSV9yTn2EL5HbBWyDDGu32b/dLO5zlPn9
         pjsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703366574; x=1703971374;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Aq9uIMa/nGGGaXr1m2A0PcSADVoztRQWWvtd/EHEe7c=;
        b=mqOsAegOP41fqg/cNZ30GyTAsyHNdQ/XKJCrhms1I2EDZVlGq16NA55nSx7PqIsPc/
         9FfmyL+MxQcq0mHmrteHLmxC1X2GVng6FDqAnMUmhc9ggzd9T4cJ7ApxNs+Jlj33OHmz
         EfKCOsJt2lPGC1lwuhUfyl98XE+K2xp2hg0r9YBXChBAaDDtVosPjghkeQrsJ93RD8GI
         u2SJ7AMhR5yGpr37IGlZKmC2Siud54hkjVI9zQzJnE2PcWlPiRgHZa1jWSqkGX+qzbHU
         k3yAwgAUNsuWJuumw+B/hPl39DrLjiQTozjQcdEk3veVSGNq2mtY3lOrwIJZQG/JbQRL
         Va6Q==
X-Gm-Message-State: AOJu0YyHVrql8bj8dhO7Ipa4/KazmIXO04gCFL+dRYRLJPuvURQTiyCy
	hv2E5u48WdUGGxaUqLX5J1+gv7IDzKYtKw==
X-Google-Smtp-Source: AGHT+IGHBgoL55jCBZEhN8xpRlEKQVGzdJnSRMDi+qE6BeF7G5hGIEXPaVSL47UpB6jK7NQnKHOlzQ==
X-Received: by 2002:a05:6870:e38d:b0:204:2bc4:87c9 with SMTP id x13-20020a056870e38d00b002042bc487c9mr3063234oad.86.1703366571959;
        Sat, 23 Dec 2023 13:22:51 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id pt13-20020a17090b3d0d00b002858ac5e401sm3603775pjb.45.2023.12.23.13.22.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Dec 2023 13:22:51 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: helgaas@kernel.org,
	bhelgaas@google.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-pci@vger.kernel.org,
	mika.westerberg@linux.intel.com
Cc: Matthew W Carlis <mattc@purestorage.com>
Subject: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER natively.
Date: Sat, 23 Dec 2023 14:22:35 -0700
Message-Id: <20231223212235.34293-2-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231223212235.34293-1-mattc@purestorage.com>
References: <20231223212235.34293-1-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

This change ensures the kernel will use DPC on a supporting device if
the kernel will also control AER on the Root Ports & RCECs.

The rules around controlling DPC/AER are somewhat clear in PCIe/ACPI
specifications. It is recommended to always link control of both to the
same entity, being the OS or system firmware. The kernel wants to be
flexible by first having a default policy, but also by providing command
line parameters to enable us all to do what we want even if it might
violate the recommendations.

The following mentioned patch brought the kernels default behavior
more in line with the specification around AER, but changed its behavior
around DPC on PCIe Downstream Switch Ports; preventing the kernel from
controlling DPC on them unless using pcie_ports=dpc-native.
    * "PCI/portdrv: Allow AER service only for Root Ports & RCECs"
After this change the behavior around using DPC on PCIe switch ports
and Root Ports should be as it was before.

Signed-off-by: Matthew W Carlis <mattc@purestorage.com>
---
 drivers/pci/pcie/portdrv.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..8e023aa97672 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -257,12 +257,19 @@ static int get_port_device_capability(struct pci_dev *dev)
 	}
 
 	/*
+	 * _OSC AER Control is required by the OS & requires OS to control AER,
+	 * but _OSC DPC Control isn't required by the OS to control DPC; however
+	 * it does require the OS to control DPC. _OSC DPC Control also requres
+	 * _OSC EDR Control (Error Disconnect Recovery) (PCI Firmware - DPC ECN rev3.2)
+	 * PCI_Express_Base 6.1, 6.2.11 Determination of DPC Control recommends
+	 * platform fw or OS always link control of DPC to AER.
+	 *
 	 * With dpc-native, allow Linux to use DPC even if it doesn't have
 	 * permission to use AER.
 	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-	    pci_aer_available() &&
-	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
+	    pci_aer_available() && (pcie_ports_dpc_native ||
+	    (dev->aer_cap && host->native_aer)))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
-- 
2.17.1


