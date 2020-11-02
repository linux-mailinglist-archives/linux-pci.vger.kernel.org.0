Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F10512A2DAD
	for <lists+linux-pci@lfdr.de>; Mon,  2 Nov 2020 16:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726043AbgKBPKM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Nov 2020 10:10:12 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:43094 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725817AbgKBPKM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Nov 2020 10:10:12 -0500
Received: from pps.filterd (m0150244.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A2F3R3W002229;
        Mon, 2 Nov 2020 15:10:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=bMsdKUsDbBtdRjs7iz+41iYksutZLHfpc65lqduc7hc=;
 b=VFiYIZ4Ckd49NPOz3KIkheC3O+jZismG2wGmy8D6zodpj5Jep/Eae4THHtAReD/mQjj1
 ZFZLLa0DYm69uaJBvjihX7itDdY3n38bhlUxxH3Bwbb+J6hFoq3dC4WHz1pAoHWT87dR
 WQeW2cB6Vx05GbIEcGswyuJhLuDndWnuOhr0EKi/SpbVa8tEkCc6JOFnu896w2nPuOpg
 lhVUlw+DUQalJ1q+1Qn2/S38uzvIN+f3AALHRWQfW52I8hGN2tuspu+uHsoFX1H8Z3kp
 pZOcb7T52XDQZZE+mZY4VrdkISZl7GgLNJJ5WifufZMch2rIfuRDtbo2eAyFArv80OpQ 9A== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com with ESMTP id 34h0k1yhqp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 02 Nov 2020 15:10:00 +0000
Received: from sarge.linuxathome.me (unknown [16.29.176.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id CFC336C;
        Mon,  2 Nov 2020 15:09:57 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Russ Anderson <rja@hpe.com>, Joerg Roedel <jroedel@suse.com>,
        Sinan Kaya <okaya@kernel.org>, stable@kernel.org
Subject: [PATCH v4 0/1] PCI/ERR: fix regression introduced by 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
Date:   Mon,  2 Nov 2020 15:09:50 +0000
Message-Id: <20201102150951.149893-1-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.29.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-02_09:2020-11-02,2020-11-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1015 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 spamscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011020120
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is essentially a resend of v3 as it failed to get enough traction;
no code change, I only added Sinan Kaya's Reviewed-by.

- Changes since v3:
* added Sinan Kaya <okaya@kernel.org> Reviewed-by

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
Cc: Sinan Kaya <okaya@kernel.org>

Cc: stable@kernel.org # v5.7+

---
Hedi Berriche (1):
  PCI/ERR: don't clobber status after reset_link()

 drivers/pci/pcie/err.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.28.0

