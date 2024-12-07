Return-Path: <linux-pci+bounces-17882-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BB61F9E81A4
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 19:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87744188440F
	for <lists+linux-pci@lfdr.de>; Sat,  7 Dec 2024 18:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F5F114D2AC;
	Sat,  7 Dec 2024 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SNg2bEsO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C931B2E822;
	Sat,  7 Dec 2024 18:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733597068; cv=none; b=IUHT7F/oTmT8yNtdt8yqMKKPnR085F7pLXGxOh5g96UbQz/LKbbAP1oZA6I7FbWjZ8hWIbRCDBKt24TD3Er0yncTRQvuUNrjH+bTAqdIb4aKkNinfzyaAkOobPFR8B2B6uBINKQX4oOjk7bDus2OLA5YGhYqEkqaONQQkrUvKxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733597068; c=relaxed/simple;
	bh=P0Tz+o0ppzWiPXWBhrr7FTaRZO/5732ZljC69tIiaeI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pIMF30RqxQhI3MFUXomF/tVyikk6j77jWIjDp4YFfyhYYpe3hub+sTDTO45RRMH/FuYQdvMON17J4X2plm6YAA3QeG3PFC8CVLuOrvbNNHFSHdA2uIPDNuI6MfnWduezZAhLFdjkwjGnMb7pqGWMc4w4X28jRxvu2Mjua0meDCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SNg2bEsO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D79C4CECD;
	Sat,  7 Dec 2024 18:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733597068;
	bh=P0Tz+o0ppzWiPXWBhrr7FTaRZO/5732ZljC69tIiaeI=;
	h=From:Date:Subject:To:Cc:From;
	b=SNg2bEsOR26tW9s04pPMuXjOtkLwIiRN4+AdL/DXXm/fOCIbhFpl4c/alaKerOjFk
	 eaIg9oIceNo9PDWmzSTPHZXMZ6K4+YBTDP98WlzaDPDpRSvjHR4yWDuVz0z4YrZv9Z
	 g7aYNaue3BBfQ1ZSaRK3Ag3MCUPvH6JAGsGYwZFEjVsIM4KgUHmqWCuDuqKW4WjEuo
	 /67eqeZNZxGveOoD0mD6VHuEGb6uuFt4SoBXas2asBs/zH1eA3sUAFCmjp72yX1vSK
	 jQZE2+3mWzzxpZGMlIRU0LqK49N3rDaRot7xYhfY3QrGrYCUH2DlBXx0tSJpWD0wHF
	 eVcEeVTdyrr9w==
From: Niklas Schnelle <niks@kernel.org>
Date: Sat, 07 Dec 2024 19:44:09 +0100
Subject: [PATCH] PCI/portdrv: Disable bwctrl service if port is fixed at
 2.5 GT/s
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>
X-B4-Tracking: v=1; b=H4sIAHiXVGcC/x2MWwqAIBAArxL7nZAWva4SEZlrLYTFag+I7p70O
 TAzD3hkQg9t8gDjSZ42F0GmCUzL6GYUZCKDylQhVVYJS/egrynwOoTlcAZZb2sQ2kjblDo3TW0
 hxjtjNP9x17/vB+BxVCtoAAAA
X-Change-ID: 20241207-fix_bwctrl_thunderbolt-bd1f96b3d98f
To: =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Bjorn Helgaas <bhelgaas@google.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1958; i=niks@kernel.org;
 h=from:subject:message-id; bh=P0Tz+o0ppzWiPXWBhrr7FTaRZO/5732ZljC69tIiaeI=;
 b=owGbwMvMwCX2Wz534YHOJ2GMp9WSGNJDpjcGNbbuPzVVuuxeitx919Kcetv0awlCgUvmnPLNC
 9p+T7K/o5SFQYyLQVZMkWVRl7PfuoIppnuC+jtg5rAygQxh4OIUgInoJTH84dryVpiRIY7laYuA
 xfWWy7+c1os9/zBzz+W6LTm64vGGDgz/a+3m6L533xbrtfjU9MdZfL/nWe5Mnmz//Le2z+6wiQu
 m8wMA
X-Developer-Key: i=niks@kernel.org; a=openpgp;
 fpr=9DB000B2D2752030A5F72DDCAFE43F15E8C26090

Trying to enable bwctrl on a Thunderbolt port causes a boot hang on some
systems though the exact reason is not yet understood. As per the spec
Thunderbolt PCIe Downstream Ports have a fake Max Link Speed of 2.5 GT/s
(USB4 v2 sec 11.2.1):

   "Max Link Speed field in the Link Capabilities Register set to 0001b
    (data rate of 2.5 GT/s only).
    Note: These settings do not represent actual throughput.
    Throughput is implementation specific and based on the USB4 Fabric
    performance."

More generally if 2.5 GT/s is the only supported link speed there is no
point in throtteling as this is already the lowest possible PCIe speed
so don't advertise the capability stopping bwctrl from being probed on
these ports.

Link: https://lore.kernel.org/linux-pci/Z1R4VNwCOlh9Sg9n@wunner.de/
Fixes: 665745f27487 ("PCI/bwctrl: Re-add BW notification portdrv as PCIe BW controller")
Tested-by: Niklas Schnelle <niks@kernel.org>
Signed-off-by: Niklas Schnelle <niks@kernel.org>
---
Note: This issue causes a boot hang on my personal workstation see the
Link for details.
---
 drivers/pci/pcie/portdrv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/portdrv.c b/drivers/pci/pcie/portdrv.c
index 5e10306b63081b1ddd13e0a545418e2a8610c14c..e5f80e4a11aad4ce60b2ce998b40ec9fda8c653d 100644
--- a/drivers/pci/pcie/portdrv.c
+++ b/drivers/pci/pcie/portdrv.c
@@ -270,7 +270,8 @@ static int get_port_device_capability(struct pci_dev *dev)
 		u32 linkcap;
 
 		pcie_capability_read_dword(dev, PCI_EXP_LNKCAP, &linkcap);
-		if (linkcap & PCI_EXP_LNKCAP_LBNC)
+		if (linkcap & PCI_EXP_LNKCAP_LBNC &&
+		    (linkcap & PCI_EXP_LNKCAP_SLS) != PCI_EXP_LNKCAP_SLS_2_5GB)
 			services |= PCIE_PORT_SERVICE_BWCTRL;
 	}
 

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241207-fix_bwctrl_thunderbolt-bd1f96b3d98f

Best regards,
-- 
Niklas Schnelle <niks@kernel.org>


