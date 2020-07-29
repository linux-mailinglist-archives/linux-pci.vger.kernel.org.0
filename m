Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B655231982
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jul 2020 08:26:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgG2G0e (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jul 2020 02:26:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:38120 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgG2G0d (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jul 2020 02:26:33 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5C3952065E;
        Wed, 29 Jul 2020 06:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596003993;
        bh=vkIUhrSXc9r1hVlkGgUCMHbIKL3mi0oUqbt+Vn4a3P0=;
        h=From:To:Cc:Subject:Date:From;
        b=l+l1H1rVblgSS73ZaAE2UC/kDo7iAjSnAOHiYXmMKW+eVDY1VDCG67tzGIS4d5baJ
         OyoT6f0IsxM5s6mGsFyWJ9gf8jHWtWBkmd4Oe3IorumVdfK+PHfuyCrsQeJH3IQi1e
         b/43PGTUoHrt24KHg8H5co4oMmRCcl7jlu4h5Rvs=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2] PCI: Fix kerneldoc of pci_vc_do_save_buffer()
Date:   Wed, 29 Jul 2020 08:26:20 +0200
Message-Id: <20200729062620.4168-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/pci/vc.c:188: warning: Excess function parameter 'name' description in 'pci_vc_do_save_buffer'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>

---

Changes since v1:
1. Fix subject
---
 drivers/pci/vc.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/pci/vc.c b/drivers/pci/vc.c
index 5486f8768c86..5fc59ac31145 100644
--- a/drivers/pci/vc.c
+++ b/drivers/pci/vc.c
@@ -172,7 +172,6 @@ static void pci_vc_enable(struct pci_dev *dev, int pos, int res)
  * @dev: device
  * @pos: starting position of VC capability (VC/VC9/MFVC)
  * @save_state: buffer for save/restore
- * @name: for error message
  * @save: if provided a buffer, this indicates what to do with it
  *
  * Walking Virtual Channel config space to size, save, or restore it
-- 
2.17.1

