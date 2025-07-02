Return-Path: <linux-pci+bounces-31217-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1275AF0AB1
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 07:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E06D41C0218D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 05:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8171D618E;
	Wed,  2 Jul 2025 05:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="KahxNlhj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5BA1D2F42
	for <linux-pci@vger.kernel.org>; Wed,  2 Jul 2025 05:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433933; cv=none; b=r6SAHIE0wCCzdt68S6rUk0KPjZzP+mznp2vzA2QHblso/IRUCocjcO0pw8eOFHzf2qaWS4S2HTY61q6YqoH8UDLmK9nVbTW7MJbj33QJ2diBEx+Fw7IlbBl/syid3n3He1DfO3thSKzvxMrdSANZiOLH+VeAJsGDEXSLIJNqch8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433933; c=relaxed/simple;
	bh=DCVeOplSNEgUp39pfh26wN2iyGTtfrMEsCri9chBELA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=unLQrW1adg0CpeXDj2l17t5wL1EEW9nGy1LAT00tzTYVO1dow5hyxQLektvz3hqqxkCAW05Z3+nSnEvFE2ZTFenJCnjwyiSyzh4o66LoJS1c5a21bkR7RiwUIcdpo+pTgDYjglqIte00jFyHwP0N+ueuwoDnID8z9myiFx7BiXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=KahxNlhj; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b31f0ef5f7aso2529030a12.3
        for <linux-pci@vger.kernel.org>; Tue, 01 Jul 2025 22:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1751433931; x=1752038731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=adPdQMff1oMKO9t3wVsMipneJwGr2jVwfDynyERIbxY=;
        b=KahxNlhjBVls3OoIm+nbySK5XI7vm+zf4FjkIs8qEtUuUe9ApojRVvqinI44nm1/Ya
         LEdcWd8UZWBOxMIKE85B3wqC/QXFQ5qnYIKs467OWMhfyfOK26B6LvWVMTOU3ay62imt
         HT6GyOolq3B5YNRjXydWqzXrwU8uV+tQG8iuhH/yDGts+hDbGOcgIFy1nIAZ6Oed/IRg
         OVfvXNX3hKFHqpQDwY5/3b7ft9XpFYduAKeFG4MR+s0PfOs6usqHub3JQjmQ7zQIH/7s
         5xVtnWvMJnXBwkIb/mnlTmXMvmuLyarMGgP4GMyODo+eApbSRCsCYW58LX6JfBF3hLT0
         gbBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751433931; x=1752038731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=adPdQMff1oMKO9t3wVsMipneJwGr2jVwfDynyERIbxY=;
        b=KE9orT4+3kG7Z3wmqvOG2x3+X6dI5F0fA+qZPWaVGypkOBgN4XK6+7/tLEsdIx7nVq
         Ao+hrQvYBY3Pn8KlRogPuq9rfSwNk/PVdPKFybS9ebTFtwcY8gOWTYY9el3JmdVp7Imq
         fBABZ3X7xvMxBvN/wHBiOAdvGoxYdLs+BJD2j9xFLyc4zeHfG/hkj2ryU2u9dj8R6M4P
         yEL+t2iV5EO/uhNq2VIZC/J0DSlas+UO0wYDz6nalnyrc2WIz3CVaaMOl3+tKWsoEeM2
         ykpz4QsPLMqo/wt6Jsy31UQPBkIz8N9kmbsq+lwolQozZCvHR7LchH27DYJ1yZ+FD8Lo
         Einw==
X-Gm-Message-State: AOJu0YwZA+PAttlK+AFc0XKmHq4UowQYd/LB/1fzLk0krn97m4maTYRg
	GJMQ2DhzvcoMjQ76vU8PZ4+qJBqVd7EFXzLSZnLXfJVGu636VsDmAVsVRJMvookFU3qMQPQFGfB
	3PBjzw6aWiIE2Xp4paMgmXLonxlIfW9WW1lxuxO+msSQe0Fl8I2ijSkSTvpZtZxnaU2ULP/6CU9
	qrP9Rl6hIo8Az0/fObbOrNrq8O1D37pBAyI0jZ+DN2bEAXlA==
X-Gm-Gg: ASbGnctVSX73drDPLzoKYB+PAmDyFeE4N0QBV0pKQ+L9WwOrn8UBcTAorUA9tQuswBG
	y8C+OEkcbUbHBtFDeRF05MCDNqlaf3DPh7HdUw3MerrjDGbJlFXK7zgBSNi5odZ+ifJUShS3KIO
	yohfhFQdhcuPpDt1xnDV2LPqXU3aSRMc7EjEMu+yOmH+jOkXWnUkYUCEH92iOQZUJEwR8Cgt1KZ
	oSbAhfTeZ7n5sUkE5IjZPMr+xxJqUGLhw4FoMvuk0llHF4veYOrphtutT2W8gj9HVapceqLCiN7
	gZdWhcwKhtuOPCbKjRU03j/kWlUo0EDH2l+LqqrHKky2DWf0kCJ9Vrv7ndzuBrDJVPFgD8IDD8/
	/XwGOQ3m4Ye9sBDI4u5ijVpQ=
X-Google-Smtp-Source: AGHT+IHVUkmUQRD7ZMAR+t2Cr+ipjMxhBPFCsJXNqas3YSWdkXlQxrKoNiZItnbxwcwns3V5DR3plg==
X-Received: by 2002:a17:90b:2752:b0:312:1b53:5e9f with SMTP id 98e67ed59e1d1-31a90bed455mr2697632a91.24.1751433930803;
        Tue, 01 Jul 2025 22:25:30 -0700 (PDT)
Received: from dev-mattc2.dev.purestorage.com ([208.88.159.129])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-b34e301f704sm11878325a12.18.2025.07.01.22.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 22:25:30 -0700 (PDT)
From: Matthew W Carlis <mattc@purestorage.com>
To: linux-pci@vger.kernel.org
Cc: bhelgaas@google.com,
	ashishk@purestorage.com,
	macro@orcam.me.uk,
	msaggi@purestorage.com,
	sconnor@purestorage.com,
	Matthew W Carlis <mattc@purestorage.com>
Subject: [PATCH v2 1/1] PCI: pcie_failed_link_retrain() return if dev is not ASM2824
Date: Tue,  1 Jul 2025 23:24:29 -0600
Message-ID: <20250702052430.13716-2-mattc@purestorage.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250702052430.13716-1-mattc@purestorage.com>
References: <20250702052430.13716-1-mattc@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

  The pcie_failed_link_retrain() was added due to a behavior observed with
a very specific set of circumstances which are in a comment above the
function. The "quirk" is supposed to force the link down to Gen1 in the
case where LTSSM is stuck in a loop or failing to train etc. The problem
is that this "quirk" is applied to any bridge & it can often write the
Gen1 TLS (Target Link Speed) when it should not. Leaving the port in
a state that will result in a device linking up at Gen1 when it should not.
  Incorrect action by pcie_failed_link_retrain() has been observed with a
variety of different NVMe drives using U.2 connectors & in multiple different
hardware designs. Directly attached to the root port, downstream of a
PCIe switch (Microchip/Broadcom) with different generations of Intel CPU.
All of these systems were configured without power controller capability.
They were also all in compliance with the Async Hot-Plug Reference model in
PCI Express® Base Specification Revision 6.0 Appendix I. for OS controlled
DPC Hot-Plug.
  The issue appears to be more likely to hit to be applied when using
OOB PD (out-of band presence detect), but has also been observed without
OOB PD support ('DLL State Changed' or 'In-Band PD').
  Powering off or power cycling the slot via an out-of-band power control
mechanism with OOB PD is extremely likely to hit since the kernel would
see that slot presence is true. Physical Hot-insertion is also extremly
likely to hit this issue with OOB PD with U.2 drives due to timing
between presence assertion and the actual power-on/link-up of the NVMe
drive itself. When the device eventually does power-up the TLS would
have been left forced to Gen1. This is similarly true to the case of
power cycling or powering off the slot.
  Exact circumstances for when this issue has been hit in a system without
OOB PD due hasn't been fully understood to due having less reproductions
as well as having reverted this patch for this configurations.

Signed-off-by: Matthew W Carlis <mattc@purestorage.com>
---
 drivers/pci/quirks.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index d7f4ee634263..39bb0c025119 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -100,6 +100,8 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	};
 	u16 lnksta, lnkctl2;
 	int ret = -ENOTTY;
+	if (!pci_match_id(ids, dev))
+		return ret;
 
 	if (!pci_is_pcie(dev) || !pcie_downstream_port(dev) ||
 	    !pcie_cap_has_lnkctl2(dev) || !dev->link_active_reporting)
@@ -124,8 +126,7 @@ int pcie_failed_link_retrain(struct pci_dev *dev)
 	}
 
 	if ((lnksta & PCI_EXP_LNKSTA_DLLLA) &&
-	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT &&
-	    pci_match_id(ids, dev)) {
+	    (lnkctl2 & PCI_EXP_LNKCTL2_TLS) == PCI_EXP_LNKCTL2_TLS_2_5GT) {
 		u32 lnkcap;
 
 		pci_info(dev, "removing 2.5GT/s downstream link speed restriction\n");
-- 
2.46.0


