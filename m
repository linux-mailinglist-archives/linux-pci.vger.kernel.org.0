Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37303E93A8
	for <lists+linux-pci@lfdr.de>; Wed, 11 Aug 2021 16:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbhHKO0K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Aug 2021 10:26:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbhHKO0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Aug 2021 10:26:09 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB760C061765
        for <linux-pci@vger.kernel.org>; Wed, 11 Aug 2021 07:25:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
        Resent-Message-ID:In-Reply-To:References;
        bh=WzdWQy06DS0J8WWkpBWzbuyjsTOkr1JtwT0ohHK/jJA=; t=1628691942; x=1629901542; 
        b=asvlk1w/ETGucUJOKfqXQ+hPT8QZH9sCWVACegzi76YYi7R+eeySjonFx4P4g3ZE8goBUibzwe6
        wYQA6LR35dT1MucrgsVdxRqTcu43okz2WzBboRY/ig3ARDaqOQ0h/Xpm1qQLmWvW6Af6UWdeuTHtt
        vJtR/YuQqE2SPB9N+cT/PKFqzIERe97B9V7acmZdWcSrIR6snKD4eswO4NnAobtdUwnD/DUla2qjj
        5JgjxS7ngDar+E/7Br3Nod36TwmcozUm+IwaRswY47RuB1Y+mpMgyNyB7U1FSrJ/pisghBFNqWo3T
        0WTtvvuagR3BqbJBjAbiSC62jKdeMXa5xadA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94.2)
        (envelope-from <johannes@sipsolutions.net>)
        id 1mDpAn-009FiB-Am; Wed, 11 Aug 2021 16:25:37 +0200
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-pci@vger.kernel.org
Cc:     Jonathan Derrick <jonathan.derrick@intel.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-um@lists.infradead.org, Randy Dunlap <rdunlap@infradead.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] PCI: vmd: depend on !UML
Date:   Wed, 11 Aug 2021 16:25:30 +0200
Message-Id: <20210811162530.affe26231bc3.I131b3c1e67e3d2ead6e98addd256c835fbef9a3e@changeid>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

With UML having enabled (simulated) PCI on UML, VMD breaks
allyesconfig/allmodconfig compilation because it assumes
it's running on X86_64 bare metal, and has hardcoded API
use of ARCH=x86. Make it depend on !UML to fix this.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/pci/controller/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
index 64e2f5e379aa..297bbd86806a 100644
--- a/drivers/pci/controller/Kconfig
+++ b/drivers/pci/controller/Kconfig
@@ -257,7 +257,7 @@ config PCIE_TANGO_SMP8759
 	  config and MMIO accesses.
 
 config VMD
-	depends on PCI_MSI && X86_64 && SRCU
+	depends on PCI_MSI && X86_64 && SRCU && !UML
 	tristate "Intel Volume Management Device Driver"
 	help
 	  Adds support for the Intel Volume Management Device (VMD). VMD is a
-- 
2.31.1

