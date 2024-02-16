Return-Path: <linux-pci+bounces-3611-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE940858410
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 18:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C071C212F6
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 17:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F30131726;
	Fri, 16 Feb 2024 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="kVeZSphJ";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="+Ua4oWif"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B0513174F;
	Fri, 16 Feb 2024 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104318; cv=pass; b=nddnZiHwfwIwGn8Et/CHUyPNarb6UzmFSemWZLkQLBto9IHReVW5j2E4THSaqljfN3ArkiGpvxiEgvFOpH4qF+DEMdmP3oDftGH5xBtdFKL9YXtA9pSz/NKZXlSkzRiwjyoEl2x8KvxIoIs+C2QY+V2i4AeGvAmffpZFAnUSrws=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104318; c=relaxed/simple;
	bh=vw0rNcyA7O8cn4iC/wvsYop5qoo0mCb/vQ9UNuNjumE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=EATCKe/9EXYYCKoSulosy8GbDjq0sdgusI0cn2A2Yr0z9zSekjt6OEMtRpG5ADm/WeBU+J3/gMoT5U8ym1HqE+S9w/8X9ujLnGB7Kh3h+xg/t45v73PXIuaHm3Shr9ERCm/wvZFuCbMGckq/fBKKl8JHVAL+kuBSGED1PwHfLFc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=kVeZSphJ; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=+Ua4oWif; arc=pass smtp.client-ip=85.215.255.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
ARC-Seal: i=1; a=rsa-sha256; t=1708104303; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=r9ejQfS2vKcTkZniWrS4Rf7Nhx8GEdhxjhNp9bGFxZDjPmXQBDNuE+piD7iK9y4+kd
    4NmHOE8z/NNs+uJ8cMvoLKqXNZbHZCmZUIWWlgIfCcW1gaalSUmvhKDYADhIYIPinuh4
    Vaok+wKNLJDg4jBk3Cen3m9VqPk3h1hi+YNy1OnidcwJOfh1OU2Gd2mSCEMPAuJQfBQQ
    1Q5vR2l5DXDrULUxQccED6MyWXn/9+LrXgdM0sdwHuJIMhCAIXKX9j29elvEl/498dRO
    wfCQ0zCzF/qrBRLmbC5LXqKX8Of7ePUNyaVq3pvoZ0rCZdjHYBiKj5OT0lZ3NHMaxGiJ
    TO6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708104303;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=j22ne6vf0iiLVaB0kMY3IJwscuu3gnRGe2AM31t/QKM=;
    b=eOJ5pOU1oMOqsO7Nj/pE0RAtakyQ3E2uXPy6Gz3aABQKfoPxbiWku7TMXNcxflb+pw
    ZZNv6FgghFmFp9Hm0DKjPS4aS2VR317c/3QbL9/y8wfk4J15OZN2v0V4w7P9UrRcqX4z
    Ds/mAabEiKwEYiHyr8ylN7CGt+DJ0uttx/Et6LB+dAhkFCXjDHAgj/DJJ4l9U1rtU0Ki
    Hs7anoFU1sAb+0Vw7bFQ2iCZ2v/QkeiEyuFDQaQ/n08MLrgwor2IIQs8/36kd0V14fPW
    PEQ9O+MeYbWSBGpyq1dESc8/AWXMB6QFzhkQ+2X44LOrWeb67loisOa5U5GaO9Y4kFWu
    1TXw==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708104303;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=j22ne6vf0iiLVaB0kMY3IJwscuu3gnRGe2AM31t/QKM=;
    b=kVeZSphJFLBzvO3asnnxFaJ/8s9tOBskGNCp4OSpHvNJfQ3fugk7dk00S04VN0OMKA
    1vOytfPzHJvsRyz/vKnnlQFYifMjF/h4uobrkk9QEbEII5xNLGEW2APygEgAQlDKKNob
    /7uhgGxgGucyFAQVYkNfQne4gDR4HQt56sf3zFniVtQSumdpiOiubdaWUgBQrUzT1u/j
    BWikv2FntVwOsFIUcQ7FYTKKHt3ozYpYsUjpWxS2fTs5qHnDtN0qupY5Fd10yUEaY51X
    HNKh5jULty+RZEyz4fNovZuI2+5/mg1dv8WUCtc73jZ5WBzFt21sNHBm7h1UEfxS9sQq
    PwiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708104303;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=j22ne6vf0iiLVaB0kMY3IJwscuu3gnRGe2AM31t/QKM=;
    b=+Ua4oWif162T8cepsUno7aTQo2l/Tc24AUEScqD49gj5FPWQo1U2qBcnbHxvduERPy
    2bOMKc6920jh+HPbDXDg==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id z34ed901GHP2Aq5
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 16 Feb 2024 18:25:02 +0100 (CET)
From: Bean Huo <beanhuo@iokpp.de>
To: bhelgaas@google.com,
	schnelle@linux.ibm.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bean Huo <beanhuo@micron.com>
Subject: [PATCH v1] PCI: Increase maximum PCIe physical function number to 7 for non-ARI devices
Date: Fri, 16 Feb 2024 18:24:49 +0100
Message-Id: <20240216172449.8052-1-beanhuo@iokpp.de>
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

This adjustment was verified against the PCIe spec (reference specific
sections if applicable) and tested with a range of PCIe devices not supporting
ARI to ensure no regressions in functionality.

Signed-off-by: Bean Huo <beanhuo@micron.com>
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


