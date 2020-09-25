Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6DEE2783DD
	for <lists+linux-pci@lfdr.de>; Fri, 25 Sep 2020 11:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727183AbgIYJWV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Sep 2020 05:22:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:53364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727044AbgIYJWV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 25 Sep 2020 05:22:21 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0260206E5;
        Fri, 25 Sep 2020 09:22:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601025741;
        bh=z2ZmkEr89nA2lgCWVvPk5uA4AW6XvocTjwAvUEjuono=;
        h=From:To:Cc:Subject:Date:From;
        b=LkwzkXPW6m/xWEBurFKnc6fZ39jx77yGeVP7nUwoI+j4AXwUQykbRUK2LJ+KVDBaW
         OXnlHA+lKigGp+lq1KPlGjSniS+LMyeykJlzbJoV0DHcuf92Qs3hoGg/A1I3mZI4DK
         d+AS8Fic8f3yJsvbb1jhkzLMYlDTb5sgoMmeCiPg=
Received: by pali.im (Postfix)
        id 3E40CE94; Fri, 25 Sep 2020 11:22:18 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add me as a reviewer for PCI aardvark
Date:   Fri, 25 Sep 2020 11:21:15 +0200
Message-Id: <20200925092115.16546-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
I have provided more fixes to this driver, I have needed functional
specification for this PCI controller and also hardware for testing
and developing (Espressobin V5 and Turris MOX B and G modules).

Thomas already wrote [1] that is less involved in this driver, so I
can help with reviewing/maintaining it.

[1] - https://lore.kernel.org/linux-pci/20200513135643.478ffbda@windsurf.home/
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d746519253c3..e245dbe280ac 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13185,6 +13185,7 @@ F:	drivers/firmware/pcdp.*
 
 PCI DRIVER FOR AARDVARK (Marvell Armada 3700)
 M:	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
+R:	Pali Rohár <pali@kernel.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
-- 
2.20.1

