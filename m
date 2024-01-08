Return-Path: <linux-pci+bounces-1835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DC788278B6
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 20:47:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2ACAB22A39
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 19:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 710C852F8B;
	Mon,  8 Jan 2024 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="AlFX9mG4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2845576A
	for <linux-pci@vger.kernel.org>; Mon,  8 Jan 2024 19:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a271a28aeb4so219273266b.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2024 11:46:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1704743210; x=1705348010; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fNh3M10wY088521GPKYKME8VzzuWaF1cy11TUNaZUxw=;
        b=AlFX9mG4XqDeM3wrghMsU1b5u3eIB6qX8wUIGoKsDHbQQnNt+D6Kd8dMma27jKwK8G
         YU6RITirgLWXjRwt6uI/glUV8Shcr3EGmLBLv+xgcBIF42Pm1mbT5753eGCQ0z5RKTcN
         7/Fx2TWvdn8f0z+QXUazhqLeXu+P18mv1jQr9+g4iPf5kwwoAMAiBkfkHi5NgbykYjBN
         dXiaW3W/2HxoSB68sLfAgFlLyIVYYfphwmxRLyLAle30OiuJXJGYM25FG7Mqir0oXmaV
         Q1gpzrVtCr4wz0jkawHBHJd+zZGa+Ka+D1oPZOK2kj2u1KnFOSAD5K2pPieWOjfIWSTe
         6fdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704743210; x=1705348010;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fNh3M10wY088521GPKYKME8VzzuWaF1cy11TUNaZUxw=;
        b=l0hESTuDnzUyCmKI6vtVpq1Wd4abUbk4qK82NvPYCi1CyFh2Ybto2wAEjo8s1bznoo
         S74aVX+ry04xv2EyhaGnkNyeBH2tN0n+9gAC+t1WGU1NSU+2OqlVe9oFY5slW4Y0lLSE
         gpJQOwLValv3376RV4Qu+gaK4OVX/c58qt8zroOwPw5Y2N7osyT61hjYti7cSoDqie7i
         7OIIEMoMNKrotPFsv/Tg/Me5TYyuPYnMr7h8Y1LyoLMeB3NCxN+BNDaf1G9c/98CH2IO
         Dotj+h61SLYKIKavnLK93bZG8iEOeIZzqFM/wcNPHz/sFaZ/jXryBkusdVwN/aLYvOlJ
         27Yw==
X-Gm-Message-State: AOJu0YxPmCvIssmwSj6IqcfTjXtE08oJWNz9fiW2MllEEhfJ47d2eFtY
	o5Cp8zDLfh3Y5CsJYa42V9OM11ghuhlA8A==
X-Google-Smtp-Source: AGHT+IGBIoRi9+UgQit1+QEoRsBrSmAbwEmLdNmC56T0S81786bVebPbpvyJmpK6hG6HGwOTXCmfQg==
X-Received: by 2002:a17:906:c044:b0:a27:6560:a058 with SMTP id bm4-20020a170906c04400b00a276560a058mr1704592ejb.29.1704743210481;
        Mon, 08 Jan 2024 11:46:50 -0800 (PST)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.128])
        by smtp.googlemail.com with ESMTPSA id s10-20020a170906a18a00b00a28badcf367sm199077ejy.54.2024.01.08.11.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 11:46:50 -0800 (PST)
From: Matthew W Carlis <mattc@purestorage.com>
To: sathyanarayanan.kuppuswamy@linux.intel.com
Cc: bhelgaas@google.com,
	helgaas@kernel.org,
	kbusch@kernel.org,
	linux-pci@vger.kernel.org,
	lukas@wunner.de,
	mattc@purestorage.com,
	mika.westerberg@linux.intel.com
Subject: [PATCH 1/1] PCI/portdrv: Allow DPC if the OS controls AER natively.
Date: Mon,  8 Jan 2024 12:46:42 -0700
Message-Id: <20240108194642.30460-1-mattc@purestorage.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ed47c116-78eb-40d7-a5e7-0c23e1e6712f@linux.intel.com>
References: <ed47c116-78eb-40d7-a5e7-0c23e1e6712f@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Hello again, sorry for the delayed response.. I have been on PTO. The above patch
doesn't fix the problem in our systems as host->native_dpc is not set due to
not using or having support for Error Disconnect Recovery (EDR). I wonder if
host->native_dpc is a misleading name a way... Misleading in the sense that
setting host->native_aer implies firmware intends the OS to control AER, whereas
host->native_dpc being set appears to have an additional requirement on the
use/support of EDR in addition to DPC. When I was working on the patch as
submitted I had been thinking about all of these fields & my thinking was
as follows.. The kernel requires host->native_aer in order to control AER, but
it could control DPC whether host->native_dpc is set or unset. Therefore, if
the kernel will control AER it should also control DPC on any capable devices.
Of course there is also the requirement of having built with CONFIG_PCIE_AER
& CONFIG_PCIE_DPC. Please advise if my understanding of all this is incorrect..

Thanks,
-Matt

I included an update to the patch submitted in chain which should remove the
build error that occured when CONFIG_PCIE_AER was not set. Including it
in case my understanding of EDR/DPC/etc is correct.

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 14a4b89a3b83..2fc006f12988 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -257,12 +257,18 @@ static int get_port_device_capability(struct pci_dev *dev)
        }

        /*
+        * _OSC AER Control is required by the OS & requires OS to control AER,
+        * but _OSC DPC Control isn't required by the OS to control DPC; however
+        * it does require the OS to control DPC. _OSC DPC Control also requres
+        * _OSC EDR Control (Error Disconnect Recovery) (PCI Firmware - DPC ECN rev3.2)
+        * PCI_Express_Base 6.1, 6.2.11 Determination of DPC Control recommends
+        * platform fw or OS always link control of DPC to AER.
+        *
         * With dpc-native, allow Linux to use DPC even if it doesn't have
         * permission to use AER.
         */
        if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-           pci_aer_available() &&
-           (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
+           pci_aer_available() && (pcie_ports_dpc_native || host->native_aer))
                services |= PCIE_PORT_SERVICE_DPC;

        if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||

