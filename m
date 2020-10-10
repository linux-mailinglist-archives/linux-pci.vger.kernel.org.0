Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BAF7289C9D
	for <lists+linux-pci@lfdr.de>; Sat, 10 Oct 2020 02:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728808AbgJJAOi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 20:14:38 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:58514 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728700AbgJJALX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 20:11:23 -0400
Received: from pps.filterd (m0148663.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09A08Djf028210;
        Sat, 10 Oct 2020 00:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=GAI2sOsgaX31oj6JLKYL1pceXdVeg/7kC6u3nxvYi0c=;
 b=CrYrOMHEhrRzQditlDPTxezUQjA0MQUW+ZVltny1tnJd3xoXgCZw6u5E5VRynJhlak06
 TJwyTPX6KcMAzUi85HU0zG14LD4NO22LxvCw3zafSNoOnRpvsNa2gpH93gdmSAWwOfMu
 gyqvEHnco5bp8hksDy0Yuow3rbKS4PVzxzG2am2cbCNFFh/C1JIcF3DwEzKbcIJt/nxm
 pa/uBDlDqhA4kqcTRgL4XVuwtoQ6MqvzzebPb7xNnwt/bAPjXwRH7sjE4Ypa7r52wf8r
 zY1rGH0hCv35NOtd4dmGwLGkkFBS7afJPDmiMKwffF15sZBG3Lth0R+wTdgu7C6lersQ HQ== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 3431geg5my-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Oct 2020 00:09:33 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id A766561;
        Sat, 10 Oct 2020 00:09:31 +0000 (UTC)
Received: from sarge.linuxathome.me (unknown [16.29.167.198])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id CD5564A;
        Sat, 10 Oct 2020 00:09:29 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Russ Anderson <rja@hpe.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <jroedel@suse.com>, stable@kernel.org
Subject: [PATCH v2 1/1] PCI/ERR: don't clobber status after reset_link()
Date:   Sat, 10 Oct 2020 01:09:16 +0100
Message-Id: <20201010000916.2572432-2-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201010000916.2572432-1-hedi.berriche@hpe.com>
References: <20201010000916.2572432-1-hedi.berriche@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_14:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 mlxlogscore=999
 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010090182
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
broke pcie_do_recovery(): updating status after reset_link() has the ill
side effect of causing recovery to fail if the error status is
PCI_ERS_RESULT_CAN_RECOVER or PCI_ERS_RESULT_NEED_RESET as the following
code will *never* run in the case of a successful reset_link()

   177         if (status == PCI_ERS_RESULT_CAN_RECOVER) {
   ...
   181         }

   183         if (status == PCI_ERS_RESULT_NEED_RESET) {
   ...
   192         }

For instance in the case of PCI_ERS_RESULT_NEED_RESET we end up not
calling ->slot_reset() (because we skip report_slot_reset()) thus
breaking driver (re)initialisation.

Don't clobber status after reset_link(), use a boolean instead to track
the outcome of reset_link().

Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
Cc: Russ Anderson <rja@hpe.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Joerg Roedel <jroedel@suse.com>

Cc: stable@kernel.org # v5.7+
---
 drivers/pci/pcie/err.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c543f419d8f9..b4bfa87fc49d 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -152,6 +152,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
+	bool reset_failed = false;
 
 	/*
 	 * Error recovery runs on all subordinates of the first downstream port.
@@ -165,8 +166,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
+		reset_failed = (reset_link(dev) != PCI_ERS_RESULT_RECOVERED);
+		if (reset_failed) {
 			pci_warn(dev, "link reset failed\n");
 			goto failed;
 		}
@@ -174,6 +175,12 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 		pci_walk_bus(bus, report_normal_detected, &status);
 	}
 
+	if ((status == PCI_ERS_RESULT_DISCONNECT ||
+	     status == PCI_ERS_RESULT_NO_AER_DRIVER) &&
+	     !reset_failed) {
+		status = PCI_ERS_RESULT_RECOVERED;
+	}
+
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
 		pci_dbg(dev, "broadcast mmio_enabled message\n");
-- 
2.28.0

