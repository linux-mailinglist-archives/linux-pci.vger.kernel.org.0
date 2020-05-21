Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA411DD596
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 20:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729360AbgEUSFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 14:05:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:33180 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729029AbgEUSFy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 14:05:54 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52DBC20738;
        Thu, 21 May 2020 18:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590084353;
        bh=yJ0qIK3gno9lWuuF46x47r/J0sJx8QW2OS7g3KNRXdQ=;
        h=From:To:Cc:Subject:Date:From;
        b=qJjoxBJDgWqeO5tjbNZvisKY2r8k6K8pM9zBRlKC+k7hssyAneTaIgXM3ZC9tyAh4
         piwGFRumYfFMoAvr0z7TtfB3p8tgWM+wo4d/daQrtE18YWgvnlUDDA5p9SVLurOJvj
         6OEEc4NYXYJJ+2/0q1YuYnCiK9v/I/mOyoCAehdk=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Klaus Doth <kdlnx@doth.eu>, Rui Feng <rui_feng@realsil.com.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 0/6] misc: rtsx: Clean up Realtek card reader driver
Date:   Thu, 21 May 2020 13:05:39 -0500
Message-Id: <20200521180545.1159896-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

These are minor cleanups of the Realtek card reader driver.  They shouldn't
fix or break anything by themselves; they're just to make it slightly more
readable and maintainable.

Bjorn Helgaas (6):
  misc: rtsx: Remove unused pcr_ops
  misc: rtsx: Removed unused dev_aspm_mode
  misc: rtsx: Use ASPM_MASK_NEG instead of hard-coded value
  misc: rtsx: Use pcie_capability_clear_and_set_word() for
    PCI_EXP_LNKCTL
  misc: rtsx: Simplify rtsx_comm_set_aspm()
  misc: rtsx: Remove unnecessary rts5249_set_aspm(), rts5260_set_aspm()

 drivers/misc/cardreader/rts5249.c  | 29 --------------------
 drivers/misc/cardreader/rts5260.c  | 26 ------------------
 drivers/misc/cardreader/rts5261.c  | 38 +++-----------------------
 drivers/misc/cardreader/rtsx_pcr.c | 43 ++++++------------------------
 drivers/misc/cardreader/rtsx_pcr.h |  1 -
 include/linux/rtsx_pci.h           | 25 -----------------
 6 files changed, 12 insertions(+), 150 deletions(-)


base-commit: 8f3d9f354286745c751374f5f1fcafee6b3f3136
-- 
2.25.1

