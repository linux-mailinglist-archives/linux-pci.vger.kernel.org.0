Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECE82880A7
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 05:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731464AbgJIDUQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Oct 2020 23:20:16 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:43532 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731460AbgJIDUQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Oct 2020 23:20:16 -0400
X-Greylist: delayed 1625 seconds by postgrey-1.27 at vger.kernel.org; Thu, 08 Oct 2020 23:20:15 EDT
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0992pmsW006097;
        Fri, 9 Oct 2020 02:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=erK5VDpscxSJhwKatGVr3HjSAqajsE6uS5msqeUQlr8=;
 b=C7KEa0YISIcm9Fuq4NCMopNVwD3YL45rz+X/fxfc7LV7XEMuqnYxuy9tKTVDU8fMSP0e
 0swyqsAYt/7meZtINkrfvgOnLc192TjI3Jd5VW46hYtFTLPyeHAGbUwJjA463lTcKJ8E
 mrSl3KZK2GbdwhO6aIhgu+vngoYEE460MwGY/v8mQE4ShN2Oo6GH7wJy54A7kuvOD567
 vyPuwrPpY+ZQleOcZhX+swMS7PSluO+oKguC1uZaz6plQFDnog5ADJ8cI3nr+QwzvRGn
 X1329aXuiyqTj72KxoAluNSZTqn+PXMmhxaE4KwMDFfsILb15NlY1/8H0b38+aTe71Yu iw== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 3429kx28ny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 02:53:01 +0000
Received: from sarge.linuxathome.me (unknown [16.29.167.198])
        by g4t3427.houston.hpe.com (Postfix) with ESMTP id 79D595C;
        Fri,  9 Oct 2020 02:52:58 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Russ Anderson <rja@hpe.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Joerg Roedel <jroedel@suse.com>, stable@kernel.org
Subject: [PATCH v1 1/1] PCI/ERR: don't clobber status after reset_link()
Date:   Fri,  9 Oct 2020 03:52:51 +0100
Message-Id: <20201009025251.2360659-1-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_01:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 lowpriorityscore=0 malwarescore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090019
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
changed pcie_do_recovery() so that status is updated with the return
value from reset_link(); this was to fix the problem where we would
wrongly report recovery failure, despite a successful reset_link(),
whenever the initial error status is PCI_ERS_RESULT_DISCONNECT or
PCI_ERS_RESULT_NO_AER_DRIVER.

Unfortunately this breaks the flow of pcie_do_recovery() as it prevents
the actions needed when the initial error is PCI_ERS_RESULT_CAN_RECOVER
or PCI_ERS_RESULT_NEED_RESET from taking place which causes error
recovery to fail.

Don't clobber status after reset_link() to restore the intended flow in
pcie_do_recovery().

Fix the original problem by saving the return value from reset_link()
and use it later on to decide whether error recovery should be deemed
successful in the scenarios where the initial error status is
PCI_ERS_RESULT_{DISCONNECT,NO_AER_DRIVER}.

Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
Cc: Russ Anderson <rja@hpe.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Joerg Roedel <jroedel@suse.com>

Cc: stable@kernel.org # v5.7+
---
 drivers/pci/pcie/err.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c543f419d8f9..dbd0b56bd6c1 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -150,7 +150,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 			pci_channel_state_t state,
 			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
 {
-	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
+	pci_ers_result_t post_reset_status, status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
 
 	/*
@@ -165,8 +165,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
+		post_reset_status = reset_link(dev);
+		if (post_reset_status != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(dev, "link reset failed\n");
 			goto failed;
 		}
@@ -174,6 +174,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_walk_bus(bus, report_normal_detected, &status);
 	}
 
+	if ((status == PCI_ERS_RESULT_DISCONNECT ||
+	     status == PCI_ERS_RESULT_NO_AER_DRIVER) &&
+	     post_reset_status == PCI_ERS_RESULT_RECOVERED) {
+		/* error recovery succeeded thanks to reset_link() */
+		status = PCI_ERS_RESULT_RECOVERED;
+	}
+
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast mmio_enabled message\n");
-- 
2.28.0

