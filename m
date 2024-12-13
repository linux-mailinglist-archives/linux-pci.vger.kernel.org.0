Return-Path: <linux-pci+bounces-18415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 271C69F17A2
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 21:56:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 80F7218834AF
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 20:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69B0C19007F;
	Fri, 13 Dec 2024 20:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iov15RIq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A806FC3;
	Fri, 13 Dec 2024 20:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734123404; cv=none; b=eY+28+1RDs6S+V0w2jGNRM4831ZfJlKS2FeIsIyH/vt7hxw9WjL6CcrFNUjsSzXpE+/FAKt1py+QYFdUNzHBloHMrA7719A+OUsaeZLIwDM6kPTAEYq8VQjmLune32i262et//qB4flIuXT/RmlC8Je20rRnS6ctcKKKiPhZX9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734123404; c=relaxed/simple;
	bh=AAZE/tSLCVOWJntY5t9n49X/wYti4gdx7tyWZMqg3Vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=crP51De+KX4v7bFffDqiG2aLFJuJO08Uj6y8Pct/wfmREoGMt+NuMxaSD6M/xp6YA4JdS09uBm7rv+5ckI/3/nI9t/EQhBzFzEiNypO0BQDRwvAtLu8igcynMwREQpywIIWbCiJel1JMXlrT7NYNGvmbEj6CzBezpMG4kOWACrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iov15RIq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 635C5C4CED4;
	Fri, 13 Dec 2024 20:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734123403;
	bh=AAZE/tSLCVOWJntY5t9n49X/wYti4gdx7tyWZMqg3Vg=;
	h=From:Date:Subject:To:Cc:From;
	b=Iov15RIqyXZSIj+OUqVW5LghQI6lwK88mvCdKDsTlEEE57jx4gBM4VDqNNdwu7akJ
	 4dV2L7ETLWeA6wvfGGm2knypiTFsQGQUbkaLN7nXuAIuVHAtgvEslkXuZzhLtAbdVf
	 kBWe9phkDLQP7VWbcn1jxfRJEdHZQAt1A3pobrO4NaHObpF2H5Z81gRxJik4ZEre1U
	 ZljjtLw5bTbKjJMMhzM+2dWLw1b2RpMpNSC1jIO6uZBsns94pj0nfoSAfSCPYAlX1i
	 owkOys6F77hC58sbfS9dwPVFnQRlQqVwgmADlG+vxi7AHTxGJEQkl1K10E3yvBV24O
	 AJ8G4deh7bpVA==
From: Niklas Schnelle <niks@kernel.org>
Date: Fri, 13 Dec 2024 21:56:14 +0100
Subject: [PATCH v2] PCI/portdrv: Disable bwctrl service if port is fixed at
 2.5 GT/s
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241213-fix_bwctrl_thunderbolt-v2-1-b52fef641dfc@kernel.org>
X-B4-Tracking: v=1; b=H4sIAG2fXGcC/4WNUQ6CMBBEr0L22xq2ihW/vIchhNItNJLWbCtqC
 He3cgE/32TmzQKR2FGES7EA0+yiCz6D3BXQj50fSDiTGWQpjyhLJax7t/rVJ57aND69IdZhSkI
 btPVJH0x9tpDHD6bc3MS3JvPoYgr82X5m/KV/lTMKFFoh2krJTpXV9U7sadoHHqBZ1/ULhxQc7
 r0AAAA=
X-Change-ID: 20241207-fix_bwctrl_thunderbolt-bd1f96b3d98f
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>, 
 Krzysztof Wilczy??ski <kw@linux.com>, 
 "Maciej W . Rozycki" <macro@orcam.me.uk>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
 Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
 Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>, 
 linux-kernel@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, 
 Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>, 
 Mika Westerberg <mika.westerberg@linux.intel.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 Niklas Schnelle <niks@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3339; i=niks@kernel.org;
 h=from:subject:message-id; bh=AAZE/tSLCVOWJntY5t9n49X/wYti4gdx7tyWZMqg3Vg=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNJj5ten/X82V7vo1pxTZdPFp0nN/dtWunqqVXKkLU8WZ
 5/5f5PUjlIWBjEuBlkxRZZFXc5+6wqmmO4J6u+AmcPKBDKEgYtTACby/A4jw4rZPZ8Exde9fan+
 qGHeXP8L8t+rf1wp2DNBy093ZVs+azAjQ3ugkv384DSBxk7mfRP8RO8IPbh1srO2Q9bCSXTn91R
 ldgA=
X-Developer-Key: i=niks@kernel.org; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090

Trying to enable bwctrl on an Intel JHL7540 (Titan Ridge) based
Thunderbolt port causes a boot hang on at least some systems though the
exact reason is not yet understood. As per the spec Thunderbolt PCIe
Downstream Ports have a fake Max Link Speed of 2.5 GT/s (USB4 v2 sec
11.2.1):

   "Max Link Speed field in the Link Capabilities Register set to 0001b
    (data rate of 2.5 GT/s only).
    Note: These settings do not represent actual throughput.
    Throughput is implementation specific and based on the USB4 Fabric
    performance."

More generally if 2.5 GT/s is the only supported link speed there is no
point in throtteling as this is already the lowest possible PCIe speed
so don't advertise the capability stopping bwctrl from being probed on
these ports.

The PCIe r6.2 specification section 7.5.3.18 recommends to primarily
utilize the Supported Link Speeds Vector instead of the Max Link Speeds
field to prevent confusion if future specifications allow devices not
to support lower speeds. This concern does not apply however when
specifically targeting devices claiming support only for 2.5 GT/s.

Link: https://lore.kernel.org/linux-pci/Z1R4VNwCOlh9Sg9n@wunner.de/
Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
Tested-by: Niklas Schnelle <niks@kernel.org>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Niklas Schnelle <niks@kernel.org>
---
Note: This issue causes a boot hang on my personal workstation.

While there is an ongoing discussion about generalizing this to all
devices with a single supported speed. It turns out however that in my
case dev->supported_speeds incorrectly claims 2.5-8 GT/s requiring
a seperate second fix. So in the interest of simplicity and because I'll
be out from the 19th until January, I'd like to propose to do this simple
fix to the boot hang now and take the time to figure out a more general
approach afterwards.
---
Changes in v2:
- Improve commit message to mention the specific controller and
  why using the Max Link Speeds field should be fine here.
- Add a comment (Lukas)
- Add R-b's (no change to logic).
- Link to v1: https://lore.kernel.org/r/20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org
---
 drivers/pci/pcie/portdrv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 5e10306b63081b1ddd13e0a545418e2a8610c14c..9edd10f4f516c1fb5416a810d884739d82d08587 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -270,7 +270,12 @@ static int get_port_device_capability(struct pci_dev *dev)
 		u32 linkcap;
 
 		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
-		if (linkcap & PCI_EXP_LNKCAP_LBNC)
+		/*
+		 * Enable bandwidth control only if more than just the base
+		 * speed of 2.5 GT/s is supported.
+		 */
+		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
+		    (linkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB)
 			services |= PCIE_PORT_SERVICE_BWCTRL;
 	}
 

---
base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
change-id: 20241207-fix_bwctrl_thunderbolt-bd1f96b3d98f

Best regards,
-- 
Niklas Schnelle <niks@kernel.org>


