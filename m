Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43631289C9B
	for <lists+linux-pci@lfdr.de>; Sat, 10 Oct 2020 02:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728793AbgJJAM0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 20:12:26 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:40080 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728696AbgJJALH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 20:11:07 -0400
Received: from pps.filterd (m0134423.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09A08t2l016461;
        Sat, 10 Oct 2020 00:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=s6G6YLhuQ8YhUBsYDzQjuCrO5rTHLw9HuFyhEDF1ae0=;
 b=hbzoONbNgv1IfWMe6VwhKAE0f/2ph0f40vq57EpLpFdo5g8R4dhlpOhyDtAEwWOEoZQf
 JZhV968xKRM6+4agzUR/SWPyeUgkPH7y8HbPXWNDXV07rJd/LUBY6pCM90bB/sool4Ce
 eXmvO9V4CVVLjR3XigdbXkjHnq+SYwAgETA4XodIkYjtbpbyhwGVc0xzk+5jSsszyBBQ
 Xs1djC6tpA0nzT742LQtf6zHFhIKPKs5YEimzPtJb30J8zI/eWz8nD1EvuwB+uS41qpH
 Gu1TdO+7Oqd6Rw8wX+3yBlAmrvdKTcB+HfuxgrloAUfIoqpVthLXRJBG6uqSTBq89WMW 3w== 
Received: from g9t5008.houston.hpe.com (g9t5008.houston.hpe.com [15.241.48.72])
        by mx0b-002e3701.pphosted.com with ESMTP id 342nqcdd02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Oct 2020 00:09:30 +0000
Received: from g9t2301.houston.hpecorp.net (g9t2301.houston.hpecorp.net [16.220.97.129])
        by g9t5008.houston.hpe.com (Postfix) with ESMTP id 838F462;
        Sat, 10 Oct 2020 00:09:29 +0000 (UTC)
Received: from sarge.linuxathome.me (unknown [16.29.167.198])
        by g9t2301.houston.hpecorp.net (Postfix) with ESMTP id 8E03D4A;
        Sat, 10 Oct 2020 00:09:27 +0000 (UTC)
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hedi Berriche <hedi.berriche@hpe.com>,
        Russ Anderson <rja@hpe.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Joerg Roedel <jroedel@suse.com>, stable@kernel.org
Subject: [PATCH v2 0/1] PCI/ERR: fix regression introduced by 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
Date:   Sat, 10 Oct 2020 01:09:15 +0100
Message-Id: <20201010000916.2572432-1-hedi.berriche@hpe.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_14:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 phishscore=0 clxscore=1015 adultscore=0 spamscore=0 impostorscore=0
 bulkscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 mlxlogscore=664 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090182
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

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

 drivers/pci/pcie/err.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

-- 
2.28.0

