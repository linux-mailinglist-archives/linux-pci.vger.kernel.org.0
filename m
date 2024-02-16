Return-Path: <linux-pci+bounces-3624-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 290168585E2
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 20:01:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB87A1F219F6
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 19:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9104A131E5C;
	Fri, 16 Feb 2024 19:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="BA7o0hbZ";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="n8l7omRy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 105D51353EF;
	Fri, 16 Feb 2024 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110096; cv=pass; b=Okbpg/WM7P/9+vZkEx9jwtxlvs4u0DRAWRCC5r0Z/xyhxmoJzdepyzU5efTWU+b/vHCQqkcnDkgA8P+X4IGCXk8b2DxW1DGm1L+FEngj8uhTKTIQkpTqpLgatHaqH6SoHe76aAKWjGAKCW+S+CtYlbKcbk5ZUspUgfOOfVw3S+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110096; c=relaxed/simple;
	bh=CH2FDE3cYHYzxEu50JesEpNhdv0xF7mLVe/XBnyauJs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CpjESvKHj5WLEKoE3fELK6IT6hZWdtOcqyv30I9oEYvRCwiqR9/t3yoorkxLOqh6vEoLLhz3+/2m0Rwq7h3jWl6XEDMHmhzmYh8g02rdA5FEG/go3vYRlgIkEW4Q4fVUHfAz/Yjz+sQ+VoXR+vRH4PI5pjROYBT0vy5oHi4z3ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=BA7o0hbZ; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=n8l7omRy; arc=pass smtp.client-ip=81.169.146.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
ARC-Seal: i=1; a=rsa-sha256; t=1708110083; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=Y9fxoYfpM8UjXJsHtoSed8CsgJZBCUmbq2OwRinIfC90wUyT/EjbvvaucYsjPbvUfJ
    WaVCvXbXY785rTPx1A/cq7043uQvyDBvYWGawzKDGmNx0Jhwp1lDxT3DXubzZtsnHKpg
    mCr5syC79mOukC+zSHzPyMT73xIdQmvFTtbKAiTJJ98REytpL+QljCImrsN/Ana08kdt
    9R7t1/0WQhBeb2tLtEjexmJOod2dELo4Wg+U+eYusJeqixJBJnL7hOu+qxaL/LiwIPaS
    UjkYYABWslMaY0gsJWlXII9okJFqh5FCu8N3rB+lR4OtNTnxAqM82aUoPnXpPvJ/p5mu
    cqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708110083;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ulgL/REy0b8uw3Xwq8lpdyFjXWw2k4rZkOpC9L+y7y4=;
    b=Q515GNoPcgbJ16u9MwHLI2t8mIidDd7yzgtF0pN1dRMYpYbAg+96aikQOfd97fL7po
    0REFBzX0endps7mOoZbsRuXylHmGRrh5qYS0MGVTTUkKgHHtUwli1CuSYnnXW05I7ZX6
    eo6sIHHP/JFw7EE6tLQxgPA/Dqj1wZ/w87qtHkwBaL7z3a5J6X0eyLBXT457+YPSCV0g
    lHkATv1oaod1MbpGuiJDXLmR4OraeIR6y7HDBn3d/c8f7vvkuDos/iClVMsXDJPlWKQ7
    rBTfLGlIY+AaCSFHY1mUvEJ7s8LasB/825s6XERziyW0P+HDyiuSoWv2SM1IzRHCsa1R
    CvdA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708110082;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ulgL/REy0b8uw3Xwq8lpdyFjXWw2k4rZkOpC9L+y7y4=;
    b=BA7o0hbZHqrE8/4oJWHqYjHckQFIVJkH6b8yDJjJk+ZoiDIjXeZgVBL+Hlygol0sw7
    ZC3bFpff/FRgEjLLGnlMF103Oq/AKKA+cZMt7Ckx2bIuOWXvNeoXpRmeSOf2APv5sjkG
    0IaZgOeyQFj++UgTJAtU6Bu9KkwB4gl46d4c+7rFXJQS+0TU3ro6exZjD29PnEoeSR+h
    5eLYERmDn5bfw3z/czbGCeV1ho8iyHOPG++90qeyn4TIso7Pd6AIwVevOKXdxeMxCwwm
    XgEsRWgmNFcVahc+MVBB2fClMx6OSfuj0BwG13kcU7bclStMfg+sbKYf0db+rUeCSBtX
    8W8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708110082;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=ulgL/REy0b8uw3Xwq8lpdyFjXWw2k4rZkOpC9L+y7y4=;
    b=n8l7omRyOQ2jDSD/hAG4Aw0wM+MpGxa3SWFXkpDTNhxWvIE1zZ5pvZKyftK9cEfNVq
    JeWNEUREtm+6HOHwvaBg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id z34ed901GJ1MAwO
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Feb 2024 20:01:22 +0100 (CET)
From: Bean Huo <beanhuo@iokpp.de>
To: bhelgaas@google.com,
	schnelle@linux.ibm.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bean Huo <beanhuo@micron.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] PCI: Increase maximum PCIe physical function number to 7 for non-ARI devices
Date: Fri, 16 Feb 2024 20:01:13 +0100
Message-Id: <20240216190113.20341-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"

From: Bean Huo <beanhuo@micron.com>

The PCIe specification allows up to 8 Physical Functions (PFs) per endpoint
when ARI (Alternative Routing-ID Interpretation) is not supported. Previously,
our implementation erroneously limited the maximum number of PFs to 7 for
endpoints without ARI support.

This patch corrects the maximum PF count to adhere to the PCIe specification
by allowing up to 8 PFs on non-ARI endpoints. This change ensures better
compliance with the standard and improves compatibility with devices relying
on this specification.

The necessity for this adjustment was verified by a thorough review of the
"Alternative Routing-ID Interpretation (ARI)" section in the PCIe 3.0 Spec,
which first introduced ARI.

Fixes: c3df83e01a96 ("PCI: Clean up pci_scan_slot()")
Cc: stable@vger.kernel.org
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
Changelog:
	v1--v2:
		1. Add Fixes tag
		2. Modify commit message
---
 drivers/pci/probe.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index ed6b7f48736a..8c3d0f63bc13 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2630,7 +2630,8 @@ static int next_fn(struct pci_bus *bus, struct pci_dev *dev, int fn)
 	if (pci_ari_enabled(bus))
 		return next_ari_fn(bus, dev, fn);
 
-	if (fn >= 7)
+	/* If EP does not support ARI, the maximum number of functions should be 7 */
+	if (fn > 7)
 		return -ENODEV;
 	/* only multifunction devices may have more functions */
 	if (dev && !dev->multifunction)
-- 
2.34.1


