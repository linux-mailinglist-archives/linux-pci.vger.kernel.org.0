Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3FA13169E9
	for <lists+linux-pci@lfdr.de>; Wed, 10 Feb 2021 16:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhBJPQw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Feb 2021 10:16:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:45586 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231810AbhBJPQr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Feb 2021 10:16:47 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 97E3364DEC;
        Wed, 10 Feb 2021 15:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612970166;
        bh=lfsFEAalhTM051RAsUfFSTOh24m0k34Q3x7HnpRka84=;
        h=From:To:Cc:Subject:Date:From;
        b=bvjPokggnyq3OgTYLtUUI3mrXjFGbXC6RW9fuQAqFcKDP6dUDxcyS2X3prfY2Q/AD
         +1ycekIEMhs2zJY0Lu74GQlMW6Or2uose+wmM3UxfeVe7w9LX0fpwTqtAYGguwRFr+
         fjmadDX66zoqi1AAuDItknzvjHkPQv1ngDJ7ZmEZpPs4tCHKELeoOixXFYnZo6J9IZ
         N0WT7ZJLCEGk/5d0iTCT2PPTkyatlQvz72sxBhdQTCEH+uNDdst5lBSl+WWCqz69bg
         QEWI1XGeLOfuwZM/72ztP5tUwqJ/b43v4AC0pychLPl04HUf7rb8LEGFJEQv7lfB89
         4qYncxaLokLhg==
From:   Keith Busch <kbusch@kernel.org>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Cc:     Keith Busch <kbusch@kernel.org>
Subject: [PATCH] PCI/ERR: Fix state assignment
Date:   Wed, 10 Feb 2021 07:16:04 -0800
Message-Id: <20210210151604.2678236-1-kbusch@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The state was intended to be assigned rather than compared for equality.

Link: https://lore.kernel.org/linux-pci/202102101255.HZtDITwe-lkp@intel.com/
Fixes: 8fae7d8809b815148 ("PCI/ERR: Simplify pci_dev_set_io_state()")
Cc: Bjorn Helgass <helgaas@kernel.org>
Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 drivers/pci/pci.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index db267120c962..1e4e4cb48bab 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -345,7 +345,7 @@ static inline bool pci_dev_set_io_state(struct pci_dev *dev,
 
 	/* Can always put a device in perm_failure state */
 	if (new == pci_channel_io_perm_failure) {
-		dev->error_state == pci_channel_io_perm_failure;
+		dev->error_state = pci_channel_io_perm_failure;
 		return true;
 	}
 
-- 
2.25.4

