Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE7F28A45B
	for <lists+linux-pci@lfdr.de>; Sun, 11 Oct 2020 01:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730636AbgJJWvh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Oct 2020 18:51:37 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:18038 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732044AbgJJW1C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Oct 2020 18:27:02 -0400
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09AMGFQB023509;
        Sat, 10 Oct 2020 22:17:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=ixjYBR/PK3Sy7gkULRXK0AQq/a1HShMfjXVqLX3x14g=;
 b=ivq49oPb38oCS4/n8qpkqbc6RLNOLZhdck30rDQ69YqTSx+LBXPqmw//MSFbs5fdjaw8
 Sup2gkJzZUF9kKKWRqZCtpRBklKK8hBj/IXlRLs8bNbgQzFE5PrRMIZ7ukeDfWeu+E1b
 ChJbpTEFOJbRiGySMYXSIwmt7VRvDfrPkEtO9T5mXCcoTZ64YMSOWDYQq+VqWA33ORfw
 j4YZRyPEia8XZY+/rSJpfPFJ2albQNudXrLbgozSTVpzlA5RM7j86srq+9bC9VLFpjQj
 uiB8ZhO15XWlo/KdZ0rIJl9n9zk6OALlDWg+oyEh7/UaZdSWnui/bUSrsti2Qhq8Vpwz QQ== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 3433xkv2j4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Oct 2020 22:17:03 +0000
Received: from sarge.linuxathome.me (unknown [16.29.167.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by g9t5008.houston.hpe.com (Postfix) with ESMTPS id B200D4F;
        Sat, 10 Oct 2020 22:17:00 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Russ Anderson <rja@hpe.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <jroedel@suse.com>, stable@kernel.org
Subject: [RESEND PATCH v3 0/1] PCI/ERR: fix regression introduced by 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
Date:   Sat, 10 Oct 2020 23:16:52 +0100
Message-Id: <20201010221653.2782993-1-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-10_07:2020-10-09,2020-10-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 mlxscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 adultscore=0 priorityscore=1501 suspectscore=1 impostorscore=0
 mlxlogscore=854 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010100210
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a resend of v3 as the the original, sent over 6 hours ago, is yet
to make it to LKML.

- Changes since v2:

 * set status to PCI_ERS_RESULT_RECOVERED, in case of successful link
   reset, if and only if the initial value of error status is
   PCI_ERS_RESULT_DISCONNECT or PCI_ERS_RESULT_NO_AER_DRIVER.

- Changes since v1:

 * changed the commit message to clarify what broke post commit 6d2c89441571
 * dropped the misnomer post_reset_status variable in favour of a more natural
   approach that relies on a boolean to keep track of the outcome of reset_link()

After commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
pcie_do_recovery() no longer calls ->slot_reset() in the case of a successful
reset which breaks error recovery by breaking driver (re)initialisation.

Cc: Russ Anderson <rja@hpe.com>
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Cc: Joerg Roedel <jroedel@suse.com>

Cc: stable@kernel.org # v5.7+

---
Hedi Berriche (1):
  PCI/ERR: don't clobber status after reset_link()

 drivers/pci/pcie/err.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.28.0

