Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFFC828A45C
	for <lists+linux-pci@lfdr.de>; Sun, 11 Oct 2020 01:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730509AbgJJWvh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 10 Oct 2020 18:51:37 -0400
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:14930 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730012AbgJJTvB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 10 Oct 2020 15:51:01 -0400
Received: from pps.filterd (m0150242.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09AFE2FQ021425;
        Sat, 10 Oct 2020 15:17:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=ECq6xELVDsr8lYsu7huKMW66NXHdSUrpUkYwuYZ8tGo=;
 b=k3K5FKhZ53zKbunEp2XeYuiMmZwrm8ipKu/IyZdctf5/+WOp3cnHI5h8WHRT/29XDgwC
 WeoMQfmU6wD+vuljmLHKXtlSMPW5sRs05LJtv/QJj52m6Mvyt7tp+5QU76JS0YOgLKTW
 MVmJV01GZzUpq94lQrAkwe2JuG/jZ9uj/FMkEeclkvq4Bk3awG4FMayvhpCmgJGhTkWQ
 44mrKxNQbWno3ma9tzTwhYOCKaMWRSpssQBQpMprtRBATIN9EQfsMRLvWyp9dzRrxvfJ
 T3Sav2bZ43qCprCR81v2NQvdYDjlW/uycHXlqLsFi4051eigAOfeBitIh7fzHLf6f76D uw== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0a-002e3701.pphosted.com with ESMTP id 34366dt707-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Oct 2020 15:17:17 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id 9373661;
        Sat, 10 Oct 2020 15:17:16 +0000 (UTC)
Received: from sarge.linuxathome.me (unknown [16.29.167.198])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id A2D7648;
        Sat, 10 Oct 2020 15:17:14 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Russ Anderson <rja@hpe.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <jroedel@suse.com>, stable@kernel.org
Subject: [PATCH v3 0/1] PCI/ERR: fix regression introduced by 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
Date:   Sat, 10 Oct 2020 16:16:53 +0100
Message-Id: <20201010151654.2707914-1-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-10_07:2020-10-09,2020-10-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxlogscore=809 mlxscore=0 impostorscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 suspectscore=1 malwarescore=0
 priorityscore=1501 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2010100143
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

