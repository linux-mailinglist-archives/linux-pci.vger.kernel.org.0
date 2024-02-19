Return-Path: <linux-pci+bounces-3719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 513BB85A1E4
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 12:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79AFC1C21664
	for <lists+linux-pci@lfdr.de>; Mon, 19 Feb 2024 11:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14A632C1A3;
	Mon, 19 Feb 2024 11:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="CHUZ/QSl";
	dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b="y2jCVXIe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97FE2C1A8;
	Mon, 19 Feb 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=81.169.146.166
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708341887; cv=pass; b=cCB7fM/vr0hPaefWpVkMdLOoIlOXOOq8/pIYOIsdL6cllTb2ivYfoJ9OD80gi8nIGFo3557C5lfyQKRlmttg+Oqlnq4Goh1UlHQCZVsaPu49EDmJvOgSBCIDC8ki7oj3GAEFtatGHQ0zWwG4xGQ88GmroQ1/WeBgGjJIqbl/osE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708341887; c=relaxed/simple;
	bh=CECuXd/sAjuMl8S3hYucJLp7m080yOv2QH0Zc6Te/CE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=AwGPNrNAJto61aFcEFL2iPs8Xg/8X5EAi9AmCnXa0LKF00/J7nHkCEWPeyR2p4WM/OAhk6KzWn6cmNRYSSiPiYOehT9Gpidh7cvSpU9DEuDza60wEhtmgU3Rh169pdrvQP+OkiHy9KlCAnd3NuwNK8t5gkpIAMjodGRbVOR6N88=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de; spf=none smtp.mailfrom=iokpp.de; dkim=pass (2048-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=CHUZ/QSl; dkim=permerror (0-bit key) header.d=iokpp.de header.i=@iokpp.de header.b=y2jCVXIe; arc=pass smtp.client-ip=81.169.146.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iokpp.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=iokpp.de
ARC-Seal: i=1; a=rsa-sha256; t=1708341874; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=jn6KI7Y+2bQKmHtzMpZ38jQcvIwTANNdQB4gmsojPYn0qOkXeQPhu2NxP4/9/P3RQt
    4U7r7Aaqx88rm0wCTkwYCW8v3pNTkfEBZj+YQrUVpGTvurnrnouqBbihgwFc89LpphDn
    k31Cg1RvKzs2/ZlCy9mA2AlLDsupt3UiT55WEOo+W5bXP+XztJ9+ZaFirPnecaXPjWYY
    Xx5F3a7u+YuGFhpu4/+YLWQWZDJu57u/sCQLrHAjoBWhgIgUqMVQB84dg1hNwyCFKbY/
    JOpH9HQ8aqIq0JxDt0FMhAdyrnFi9q2DEz7//14qulIjHkEQE2wWxkQ5UDAcv5nGw25k
    YZiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1708341874;
    s=strato-dkim-0002; d=strato.com;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=c2BOxqJDmwafqSoi14gmFtIw7xEH8uiVYYguCeROLgM=;
    b=tQSoTO42PyGFWtzDApFtdiKGQQSVQ4rnwXzLIDTuXY99vdTIwYoc32RYMixP6uKHhM
    QoENrizvpI/glEspsfhaRxolt5gJGlruvGOBgGmI5cwDaeGHvoD4xMF5g7Tm6NzP8+R6
    7kHEnYScoS4CtbheJmliYd8YvLZppDvzuRjJr1NaaAxGxYFAVhWu1exG71ENUsFNMSMJ
    wbVVJEdfrzYubWwsXgbuY/5dvcJoFEe6J4Dl44LpUT9MPpFmjJHKhD62+MhbUXvyQZoX
    sbCxCWRWGuveYRnP+v8M7LokTet4ktqlPj011ILvWCMg6dyZgCzHbY4cPSmFyysWP/vU
    UhLA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1708341874;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=c2BOxqJDmwafqSoi14gmFtIw7xEH8uiVYYguCeROLgM=;
    b=CHUZ/QSliIpXr6X4GsuWL7JBHA8muK0btQIqLqV4yTeuWhaZzoyLBuIPGv/0KMtOQ8
    VT4HbGmkpFsw8JUrLmx/V806U0iXn/GPr13Tcf3gjAilSUTkARAgWXh+fVoeQw9nLcSH
    JxJvKnJAlVrGrZiG+OivpZKT7XWMzjyuLz89C9WNOOXJ+177YwJ0DRPWRazgB5U27kNA
    QjNXJ/EKql6IULECONxYistwuGYswr7Jyjm81MUe3ecM2h2ucoNvZlKMQb7hWL2OQRr1
    i3c0FPipWZTH+Ovrm4wFuLuWG3Uy0Oj2Dq7k5nTuEpvuS+FQP85Yei43QrxmqgIslWQV
    Wwzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1708341874;
    s=strato-dkim-0003; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=c2BOxqJDmwafqSoi14gmFtIw7xEH8uiVYYguCeROLgM=;
    b=y2jCVXIeaacOIfsN+IEXyu7hnpx20lwahwAAcoju47Oz5dTbSge4oWaHHrLYEOXlsJ
    NXg1XP1wD1aW6dewwsDw==
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
Received: from Munilab01-lab.micron.com
    by smtp.strato.de (RZmta 49.11.2 AUTH)
    with ESMTPSA id z34ed901JBOWFh1
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 19 Feb 2024 12:24:32 +0100 (CET)
From: Bean Huo <beanhuo@iokpp.de>
To: bhelgaas@google.com,
	helgaas@kernel.org,
	sathyanarayanan.kuppuswamy@linux.intel.com
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bean Huo <beanhuo@micron.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] PCI: Increase maximum PCIe physical function number to 7 for non-ARI devices
Date: Mon, 19 Feb 2024 12:24:22 +0100
Message-Id: <20240219112422.54657-1-beanhuo@iokpp.de>
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

As per PCIe r6.2, sec 6.13 titled "Alternative Routing-ID Interpretation
(ARI)", up to 8 [fn # 0..7] Physical Functions(PFs) are allowed in an
non-ARI capable device. Previously, our implementation erroneously limited
the maximum number of PFs to 7 for endpoints without ARI support.

This patch corrects the maximum PF count to adhere to the PCIe specification
by allowing up to 8 PFs on non-ARI capable devices. This change ensures better
compliance with the standard and improves compatibility with devices relying
on this specification.

Fixes: c3df83e01a96 ("PCI: Clean up pci_scan_slot()")
Cc: stable@vger.kernel.org
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
Changelog:
	v2--v3:
		1. Update commit messag 
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


