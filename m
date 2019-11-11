Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D149F6DCA
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2019 06:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfKKFWC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Nov 2019 00:22:02 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:17516 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726164AbfKKFWB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Nov 2019 00:22:01 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xAB5IdBo025529;
        Mon, 11 Nov 2019 00:21:49 -0500
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w6v51rr7y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 00:21:49 -0500
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id xAB5IwWI026607;
        Mon, 11 Nov 2019 00:21:48 -0500
Received: from ppma04wdc.us.ibm.com (1a.90.2fa9.ip4.static.sl-reverse.com [169.47.144.26])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w6v51rr74-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 00:21:48 -0500
Received: from pps.filterd (ppma04wdc.us.ibm.com [127.0.0.1])
        by ppma04wdc.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id xAB5K7P7013981;
        Mon, 11 Nov 2019 05:21:47 GMT
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com [9.57.198.28])
        by ppma04wdc.us.ibm.com with ESMTP id 2w5n35j7db-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Nov 2019 05:21:47 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id xAB5LkJO50200940
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Nov 2019 05:21:46 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8B62128064;
        Mon, 11 Nov 2019 05:21:46 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D5DD828059;
        Mon, 11 Nov 2019 05:21:45 +0000 (GMT)
Received: from ltcalpine2-lp18.aus.stglabs.ibm.com (unknown [9.40.195.201])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon, 11 Nov 2019 05:21:45 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
        tlfalcon@linux.ibm.com, nathanl@linux.ibm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [PATCH v2 0/9] Fixes and Enablement of ibm,drc-info property
Date:   Sun, 10 Nov 2019 23:21:27 -0600
Message-Id: <1573449697-5448-1-git-send-email-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-11-10_08:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1910280000 definitions=main-1911110051
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There was a previous effort to add support for the PAPR
architected ibm,drc-info property. This property provides a more
memory compact representation of a parition's Dynamic Reconfig
Connectors (DRC). These can otherwise be thought of as currently
partitioned, or available but yet to be partitioned system resources
such as cpus, memory, and physical/logical IOA devices.

The initial implementation proved buggy and was fully turned off by
disabling the bit in the appropriate CAS support vector. We now have
PowerVM firmware in the field that supports this new property, and
further to support partitions with 24TB+ of possible memory this
property is required to perform platform migration.

This series fixs the short comings of the previous submission
in the areas of general implementation, cpu hotplug, and IOA hotplug.

v2 changelog:
	Cover Letter: fixed up spelling errors (mpe, tfalcon)
	Patch 3: added comment regarding indexing of drc values (tfalcon)
		 split drc-index and drc-info logic into multiple
		 functions for collecting cpu drc's for dlpar (mpe)
	Patch 7: fix up a couple more sparse warnings (mpe)

Tyrel Datwyler (9):
  powerpc/pseries: Fix bad drc_index_start value parsing of drc-info
    entry
  powerpc/pseries: Fix drc-info mappings of logical cpus to drc-index
  powerpc/pseries: Add cpu DLPAR support for drc-info property
  PCI: rpaphp: Fix up pointer to first drc-info entry
  PCI: rpaphp: Don't rely on firmware feature to imply drc-info support
  PCI: rpaphp: Add drc-info support for hotplug slot registration
  PCI: rpaphp: Annotate and correctly byte swap DRC properties
  PCI: rpaphp: Correctly match ibm,my-drc-index to drc-name when using
    drc-info
  powerpc/pseries: Enable support for ibm,drc-info property

 arch/powerpc/kernel/prom_init.c                 |   2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c    | 127 +++++++++++++++++++++---
 arch/powerpc/platforms/pseries/of_helpers.c     |   8 +-
 arch/powerpc/platforms/pseries/pseries_energy.c |  23 ++---
 drivers/pci/hotplug/rpaphp_core.c               | 127 +++++++++++++++++-------
 5 files changed, 216 insertions(+), 71 deletions(-)

-- 
2.7.4

