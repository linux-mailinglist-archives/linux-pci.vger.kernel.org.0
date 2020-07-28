Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C732423109A
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 19:11:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731937AbgG1RKu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 13:10:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:35746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731070AbgG1RKu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Jul 2020 13:10:50 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4F0E720792;
        Tue, 28 Jul 2020 17:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595956250;
        bh=W09MG88rY5IUoeTZVSJ0vF7v6B+fC0V56WD0WHJGdbI=;
        h=From:To:Cc:Subject:Date:From;
        b=imIPN0qq76Onx7g+Wn0hJP1ninuDU2lMHUWQyXyT/TZIeiFpxpiufn9pPyQ/8LKhP
         WujNmGDTwaKbyz+92SR0+cuAohRAJ1jZ6qIz03N0Wc+e1uinTEfmUB9zol+twxPYF9
         uhsH+qssz4yuhBYzdXxPvBr93vNh5KuHIVLrwgHc=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] pci: vc: Fix kerneldoc
Date:   Tue, 28 Jul 2020 19:10:45 +0200
Message-Id: <20200728171045.28606-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/pci/vc.c:188: warning: Excess function parameter 'name' description in 'pci_vc_do_save_buffer'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
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

