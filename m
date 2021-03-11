Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D59BE336880
	for <lists+linux-pci@lfdr.de>; Thu, 11 Mar 2021 01:18:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbhCKARl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Mar 2021 19:17:41 -0500
Received: from mail-lj1-f176.google.com ([209.85.208.176]:39211 "EHLO
        mail-lj1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbhCKAR2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 10 Mar 2021 19:17:28 -0500
Received: by mail-lj1-f176.google.com with SMTP id e20so88408ljn.6
        for <linux-pci@vger.kernel.org>; Wed, 10 Mar 2021 16:17:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A5H4fGIgo3dUpMCIo2j40I5wIj0MRYFpDDCxoqUPc5w=;
        b=JdP9wBDtVoDVmbhkD2mNWQbughy+Z96KbJ2CK24A2pZjI9aluL6QQ61IaxVWA4WlEc
         tA/Kwn0TxjLIWWqk31Vi+NAtGLE/majG3M9ZZh1ETY6mGTNWWPqzVxhZLvf0qdPtmikY
         C4YFZp1M90679+nA1BIFW5gZC3YlOXaJPShUsyWEY42LdqmGHz6WWLVh/so+j+ar0Dp4
         HaAilcy+oSCsoPr5jz65hKG1OXqwnEv2w41NkrRKkVvSa+nofQCG1qtDj8a2scMO4dST
         d5/tVXMYrXBnxwgTvsM5b9jK2fCQP8dRmb5QcBiGgY5WG4lUwBqhjNKviEm+bDPagCw9
         0pJQ==
X-Gm-Message-State: AOAM531RmUmCKs6LjzriVCu9SDE/nZwJtyrlbEubVFHgIeqJTC/V9KKJ
        LqdJM8UDN5Xa7ArJkNaUNxo=
X-Google-Smtp-Source: ABdhPJzx8D8PuTst522MhCYIm0jb2r1VSliIaz1do8blvP5IxyLsQo7fTvG1hCDuJLJ+SZQ6w0gTNA==
X-Received: by 2002:a2e:a0d0:: with SMTP id f16mr3360194ljm.215.1615421847382;
        Wed, 10 Mar 2021 16:17:27 -0800 (PST)
Received: from workstation.lan ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id y186sm269332lfc.304.2021.03.10.16.17.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 16:17:26 -0800 (PST)
From:   =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Tom Joseph <tjoseph@cadence.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Rob Herring <robh@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Jay Fang <f.fangjian@huawei.com>, linux-pci@vger.kernel.org
Subject: [PATCH 2/8] PCI/AER: Update functions names in the kernel-doc
Date:   Thu, 11 Mar 2021 00:17:18 +0000
Message-Id: <20210311001724.423356-2-kw@linux.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210311001724.423356-1-kw@linux.com>
References: <20210311001724.423356-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Update function names in the kernel-doc to match function prototypes
for functions enable_ecrc_checking(), disable_ecrc_checking() and
pcie_aer_init(), and resolve build time warnings related to kernel-doc:

 drivers/pci/pcie/aer.c:138: warning: expecting prototype for
 enable_ercr_checking(). Prototype was for enable_ecrc_checking()
 instead

 drivers/pci/pcie/aer.c:1450: warning: expecting prototype for
 aer_service_init(). Prototype was for pcie_aer_init() instead

 drivers/pci/pcie/aer.c:162: warning: expecting prototype for
 disable_ercr_checking(). Prototype was for disable_ecrc_checking()
 instead

No change to functionality intended.

Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
---
 drivers/pci/pcie/aer.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index ba22388342d1..ec943cee5ecc 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -129,7 +129,7 @@ static const char * const ecrc_policy_str[] = {
 };
 
 /**
- * enable_ercr_checking - enable PCIe ECRC checking for a device
+ * enable_ecrc_checking - enable PCIe ECRC checking for a device
  * @dev: the PCI device
  *
  * Returns 0 on success, or negative on failure.
@@ -153,7 +153,7 @@ static int enable_ecrc_checking(struct pci_dev *dev)
 }
 
 /**
- * disable_ercr_checking - disables PCIe ECRC checking for a device
+ * disable_ecrc_checking - disables PCIe ECRC checking for a device
  * @dev: the PCI device
  *
  * Returns 0 on success, or negative on failure.
@@ -1442,7 +1442,7 @@ static struct pcie_port_service_driver aerdriver = {
 };
 
 /**
- * aer_service_init - register AER root service driver
+ * pcie_aer_init - register AER root service driver
  *
  * Invoked when AER root service driver is loaded.
  */
-- 
2.30.1

