Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A30DC242D9E
	for <lists+linux-pci@lfdr.de>; Wed, 12 Aug 2020 18:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbgHLQrv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Aug 2020 12:47:51 -0400
Received: from mga12.intel.com ([192.55.52.136]:33856 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726816AbgHLQrY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Aug 2020 12:47:24 -0400
IronPort-SDR: UIARZ50YjkfBY6Vz3RZzf61/I89sGxNBxb1HQKdGm2PqAeEmjdox+CoWIHtbqPFee/kuso+rm9
 F28CXUO4xkhg==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="133538566"
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="133538566"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 09:47:23 -0700
IronPort-SDR: 7sgPFqLLhM0D6StT99Hvfk8YpH8q7PJOBXJ/iIFi941Gg5+u9AmuYZLlWJDacEuiscNW/d5c4e
 u1gvFrpItoXA==
X-IronPort-AV: E=Sophos;i="5.76,305,1592895600"; 
   d="scan'208";a="439442708"
Received: from ticede-or-099.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.58.97])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2020 09:47:21 -0700
From:   Sean V Kelley <sean.v.kelley@intel.com>
To:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, qiuxu.zhuo@intel.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@intel.com>
Subject: [PATCH v3 10/10] PCI/AER: Add RCEC AER error injection support
Date:   Wed, 12 Aug 2020 09:46:59 -0700
Message-Id: <20200812164659.1118946-11-sean.v.kelley@intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812164659.1118946-1-sean.v.kelley@intel.com>
References: <20200812164659.1118946-1-sean.v.kelley@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Qiuxu Zhuo <qiuxu.zhuo@intel.com>

The Root Complex Event Collectors(RCEC) appear as peers to Root Ports
and also have the AER capability. So add RCEC support to the current AER
error injection driver.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Co-developed-by: Sean V Kelley <sean.v.kelley@intel.com>
Signed-off-by: Sean V Kelley <sean.v.kelley@intel.com>
---
 drivers/pci/pcie/aer_inject.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pcie/aer_inject.c b/drivers/pci/pcie/aer_inject.c
index 21cc3d3387f7..8107e782546a 100644
--- a/drivers/pci/pcie/aer_inject.c
+++ b/drivers/pci/pcie/aer_inject.c
@@ -333,8 +333,11 @@ static int aer_inject(struct aer_error_inj *einj)
 	if (!dev)
 		return -ENODEV;
 	rpdev = pcie_find_root_port(dev);
+	/* If Root port not found, try to find an RCEC */
+	if (!rpdev)
+		rpdev = dev->rcec;
 	if (!rpdev) {
-		pci_err(dev, "Root port not found\n");
+		pci_err(dev, "Neither root port nor RCEC found\n");
 		ret = -ENODEV;
 		goto out_put;
 	}
-- 
2.28.0

