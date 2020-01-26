Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F28B6149C36
	for <lists+linux-pci@lfdr.de>; Sun, 26 Jan 2020 19:13:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbgAZSNF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Jan 2020 13:13:05 -0500
Received: from mga05.intel.com ([192.55.52.43]:4980 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725838AbgAZSNF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Jan 2020 13:13:05 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 26 Jan 2020 10:13:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,366,1574150400"; 
   d="scan'208";a="427092196"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 26 Jan 2020 10:13:01 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1ivmP7-0007jp-DH; Mon, 27 Jan 2020 02:13:01 +0800
Date:   Mon, 27 Jan 2020 02:12:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Shiju Jose <shiju.jose@huawei.com>
Cc:     kbuild-all@lists.01.org, linux-acpi@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        rjw@rjwysocki.net, helgaas@kernel.org, lenb@kernel.org,
        bp@alien8.de, james.morse@arm.com, tony.luck@intel.com,
        gregkh@linuxfoundation.org, zhangliguang@linux.alibaba.com,
        tglx@linutronix.de, linuxarm@huawei.com,
        jonathan.cameron@huawei.com, tanxiaofei@huawei.com,
        yangyicong@hisilicon.com, Shiju Jose <shiju.jose@huawei.com>
Subject: [RFC PATCH] PCI: hip: hisi_pcie_sec_type can be static
Message-ID: <20200126181214.vszdyo5qdsm7cjqb@f53c9c00458a>
References: <20200124123938.16524-3-shiju.jose@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200124123938.16524-3-shiju.jose@huawei.com>
X-Patchwork-Hint: ignore
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


Fixes: 9bf6eb234cd2 ("PCI: hip: Add handling of HiSilicon hip PCIe controller's errors")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 pcie-hisi-error.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/pcie-hisi-error.c b/drivers/pci/controller/pcie-hisi-error.c
index 7c669043a4e0e..76c37abaaf968 100644
--- a/drivers/pci/controller/pcie-hisi-error.c
+++ b/drivers/pci/controller/pcie-hisi-error.c
@@ -50,7 +50,7 @@
 #define HISI_ERR_SEV_CORRECTED		2
 #define HISI_ERR_SEV_NONE		3
 
-guid_t hisi_pcie_sec_type = GUID_INIT(0xB2889FC9, 0xE7D7, 0x4F9D, 0xA8, 0x67,
+static guid_t hisi_pcie_sec_type = GUID_INIT(0xB2889FC9, 0xE7D7, 0x4F9D, 0xA8, 0x67,
 				       0xAF, 0x42, 0xE9, 0x8B, 0xE7, 0x72);
 
 #define HISI_PCIE_CORE_ID(v)             ((v) >> 3)
