Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EEDE914526A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jan 2020 11:18:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728901AbgAVKSl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Jan 2020 05:18:41 -0500
Received: from foss.arm.com ([217.140.110.172]:54452 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728890AbgAVKSk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Jan 2020 05:18:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A0DC1FB;
        Wed, 22 Jan 2020 02:18:40 -0800 (PST)
Received: from e119886-lin.cambridge.arm.com (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8BCE43F68E;
        Wed, 22 Jan 2020 02:18:39 -0800 (PST)
From:   Andrew Murray <andrew.murray@arm.com>
To:     lorenzo.pieralisi@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update my email address
Date:   Wed, 22 Jan 2020 10:18:31 +0000
Message-Id: <20200122101831.47628-1-andrew.murray@arm.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I will lose access to my @arm.com email address next week, so
let's update the MAINTAINERS file and map it correctly in
.mailmap

Signed-off-by: Andrew Murray <andrew.murray@arm.com>
---
 .mailmap    | 2 ++
 MAINTAINERS | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index d9d5c80252f9..f332b79c2e85 100644
--- a/.mailmap
+++ b/.mailmap
@@ -27,6 +27,8 @@ Andi Shyti <andi@etezian.org> <andi.shyti@samsung.com>
 Andreas Herrmann <aherrman@de.ibm.com>
 Andrey Ryabinin <ryabinin.a.a@gmail.com> <a.ryabinin@samsung.com>
 Andrew Morton <akpm@linux-foundation.org>
+Andrew Murray <amurray@thegoodpenguin.co.uk> <andrew.murray@arm.com>
+Andrew Murray <amurray@thegoodpenguin.co.uk> <amurray@embedded-bits.co.uk>
 Andrew Vasquez <andrew.vasquez@qlogic.com>
 Andy Adamson <andros@citi.umich.edu>
 Antoine Tenart <antoine.tenart@free-electrons.com>
diff --git a/MAINTAINERS b/MAINTAINERS
index cf6ccca6e61c..4326bddef572 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12779,7 +12779,7 @@ F:	arch/x86/kernel/early-quirks.c
 
 PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS
 M:	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
-R:	Andrew Murray <andrew.murray@arm.com>
+R:	Andrew Murray <amurray@thegoodpenguin.co.uk>
 L:	linux-pci@vger.kernel.org
 Q:	http://patchwork.ozlabs.org/project/linux-pci/list/
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git/
-- 
2.21.0

