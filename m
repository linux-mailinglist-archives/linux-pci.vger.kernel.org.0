Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79F4C1A2973
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 21:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbgDHTmS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 15:42:18 -0400
Received: from mga01.intel.com ([192.55.52.88]:36095 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729090AbgDHTmS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 15:42:18 -0400
IronPort-SDR: fWZ2WQWMiMq+RCJN4SmGWeLPuQl4WM3aXbt0XC9VXl5iopbp92qIB6Nx8sD7p6zcuHUfDw/vyY
 i1+zsXMJcY7A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 12:42:18 -0700
IronPort-SDR: V9zmvoI/wrc/la0Eit0dJ+nWEE0wnSiqpAJmv8vKLyM19ppRttdvpyrVA12TZIxoQqgPSlyd+G
 g4k/IMzeEBgg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,359,1580803200"; 
   d="scan'208";a="286654685"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Apr 2020 12:42:15 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jMGaS-0009pI-Br; Thu, 09 Apr 2020 03:42:12 +0800
Date:   Thu, 9 Apr 2020 03:41:27 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, bp@alien8.de, james.morse@arm.com,
        helgaas@kernel.org, lenb@kernel.org, tony.luck@intel.com,
        dan.carpenter@oracle.com, gregkh@linuxfoundation.org,
        zhangliguang@linux.alibaba.com, tglx@linutronix.de
Subject: [RFC PATCH] ACPI / APEI: ghes_gdata_pool_init() can be static
Message-ID: <20200408194127.GA90427@7d29259190c9>
References: <20200407120045.958-2-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407120045.958-2-shiju.jose@huawei.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Signed-off-by: kbuild test robot <lkp@intel.com>
---
 ghes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index 5c0ab54223118..6d698867468d1 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -207,7 +207,7 @@ int ghes_estatus_pool_init(int num_ghes)
 	return -ENOMEM;
 }
 
-int ghes_gdata_pool_init(void)
+static int ghes_gdata_pool_init(void)
 {
 	unsigned long addr, len;
 	int rc;
