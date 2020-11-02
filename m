Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 816E22A2DAF
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 16:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726336AbgKBPKQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 10:10:16 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:57692 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725817AbgKBPKP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 10:10:15 -0500
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A2F2hkL027558;
        Mon, 2 Nov 2020 15:10:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=uzqNJsf7emtpOGz6czbw5NJi/GMYRCcRDs2k3kzG2QU=;
 b=eiGLOUjFUGQQnM3nJeYcs8KEsbRiDLyfozqSCwR5jrPMWjFoLt42q0aOJtKxXWXubmw2
 QpfseskB/TBqIFKshCIw5LGOERBXM8xI9/GA3sVg9MUuDgXtQ1qBjYy8SjGJB26DecPD
 lQ2SL9Ylift6FQC7m2M1zffAd8KXrWx+AURC9YsPdAQikcexptacRmsjhbu0hkbrW/C/
 4CuMNbH4S3mXW6rpe6F5LH0PXLr6zN14LrS/ww6D2nFIsENR1SJnblRrsynNa97tEvdC
 ARhFpIcDmGY7ki7idBIQ0YG4Nfsm0/2IbWiuXm5rlVD2WYbbX9HVz2FvUEXUfC2ATf+z Og== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 34h07gye93-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 15:10:03 +0000
Received: from sarge.linuxathome.me (unknown [16.29.176.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id 86A4F74;
        Mon,  2 Nov 2020 15:10:00 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Sinan Kaya <okaya@kernel.org>, Russ Anderson <rja@hpe.com>,
        Joerg Roedel <jroedel@suse.com>, stable@kernel.org
Subject: [PATCH v4 1/1] PCI/ERR: don't clobber status after reset_link()
Date:   Mon,  2 Nov 2020 15:09:51 +0000
Message-Id: <20201102150951.149893-2-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201102150951.149893-1-hedi.berriche@hpe.com>
References: <20201102150951.149893-1-hedi.berriche@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_09:2020-11-02,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 malwarescore=0
 impostorscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 spamscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020120
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

Don't clobber status with the return value of reset_link(); set status
to PCI_ERS_RESULT_RECOVERED, in case of successful link reset, if and
only if the initial value of error status is PCI_ERS_RESULT_DISCONNECT
or PCI_ERS_RESULT_NO_AER_DRIVER.

Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>

Reviewed-by: Sinan Kaya <okaya@kernel.org>
Cc: Russ Anderson <rja@hpe.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Joerg Roedel <jroedel@suse.com>

Cc: stable@kernel.org # v5.7+
---
 drivers/pci/pcie/err.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index c543f419d8f9..2730826cfd8a 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -165,10 +165,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
+		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
 			pci_warn(dev, "link reset failed\n");
 			goto failed;
+		} else {
+			if (status == PCI_ERS_RESULT_DISCONNECT ||
+			    status == PCI_ERS_RESULT_NO_AER_DRIVER)
+				status = PCI_ERS_RESULT_RECOVERED;
 		}
 	} else {
 		pci_walk_bus(bus, report_normal_detected, &status);
-- 
2.28.0

