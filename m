Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE4928A1EE
	for <lists+linux-pci@lfdr.de>; Sun, 11 Oct 2020 00:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730496AbgJJWvg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Oct 2020 18:51:36 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:61168 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731456AbgJJTXQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Oct 2020 15:23:16 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09AFGhlb023141;
        Sat, 10 Oct 2020 15:17:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=wSRn6DStJQfrwSTDj+DfXKvQUD8C1Q/aQBRYMzWuv7I=;
 b=NCoBl+Kc3r3M1kI5Tf+OiPMK2jerC073U7v7rK6SsaWfT36y1gNZJqjvMlGl+cdXdKnN
 5ZKDV8NlN8h+Pp2qccw4fqURlBTC9M86I0E2D6b+kgpMEfgCwmZNoyxpv+u2oyphPvHN
 DOOqhkN9tiUmXvt0WEkIjC5FJcr+4wHjw4q7pPqQl3FGWj7lkzDSIaTDZA3P8wkQ5WdJ
 HNSAZisK6UzL/6eqyhUu0PV8c0Dyfihy3LNXqTZM5EvSBSEhv4BWatFkwZb6hglQNagF
 knTtOpwt0zRpDRKoPRSbvweK7AVqOsNg8UJ3Ox/KOnamzuPo4pPtXnn57iCEgZgHQF8A Pg== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 34342ujnvs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Oct 2020 15:17:25 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 175FF61;
        Sat, 10 Oct 2020 15:17:25 +0000 (UTC)
Received: from sarge.linuxathome.me (unknown [16.29.167.198])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 4A78D45;
        Sat, 10 Oct 2020 15:17:23 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Russ Anderson <rja@hpe.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <jroedel@suse.com>, stable@kernel.org
Subject: [PATCH v3 1/1] PCI/ERR: don't clobber status after reset_link()
Date:   Sat, 10 Oct 2020 16:16:54 +0100
Message-Id: <20201010151654.2707914-2-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201010151654.2707914-1-hedi.berriche@hpe.com>
References: <20201010151654.2707914-1-hedi.berriche@hpe.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-10_07:2020-10-09,2020-10-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=999
 clxscore=1015 mlxscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 suspectscore=1 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010100143
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

