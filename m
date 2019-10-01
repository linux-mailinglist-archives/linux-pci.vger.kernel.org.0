Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE1C3C2D23
	for <lists+linux-pci@lfdr.de>; Tue,  1 Oct 2019 08:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732140AbfJAGMd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Oct 2019 02:12:33 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:36196 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731869AbfJAGMd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Oct 2019 02:12:33 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9168E4e031291;
        Tue, 1 Oct 2019 02:12:22 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vbyueaa7p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 02:12:22 -0400
Received: from m0098419.ppops.net (m0098419.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.27/8.16.0.27) with SMTP id x916BQQg039555;
        Tue, 1 Oct 2019 02:12:22 -0400
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2vbyueaa75-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 02:12:21 -0400
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.27/8.16.0.27) with SMTP id x916A5bl015866;
        Tue, 1 Oct 2019 06:12:21 GMT
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com [9.57.198.23])
        by ppma03dal.us.ibm.com with ESMTP id 2v9y57y3kh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 01 Oct 2019 06:12:21 +0000
Received: from b01ledav004.gho.pok.ibm.com (b01ledav004.gho.pok.ibm.com [9.57.199.109])
        by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x916CJq449152488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 1 Oct 2019 06:12:19 GMT
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B410B112063;
        Tue,  1 Oct 2019 06:12:19 +0000 (GMT)
Received: from b01ledav004.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3E0EF112061;
        Tue,  1 Oct 2019 06:12:19 +0000 (GMT)
Received: from ltcalpine2-lp18.aus.stglabs.ibm.com (unknown [9.40.195.201])
        by b01ledav004.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue,  1 Oct 2019 06:12:19 +0000 (GMT)
From:   Tyrel Datwyler <tyreld@linux.ibm.com>
To:     mpe@ellerman.id.au, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        nathanl@linux.ibm.com, Tyrel Datwyler <tyreld@linux.ibm.com>
Subject: [RFC PATCH 0/9] Fixes and Enablement of ibm,drc-info property
Date:   Tue,  1 Oct 2019 01:12:05 -0500
Message-Id: <1569910334-5972-1-git-send-email-tyreld@linux.ibm.com>
X-Mailer: git-send-email 2.7.4
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-10-01_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1908290000 definitions=main-1910010060
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There was an initial previous effort yo add support for the PAPR
architected ibm,drc-info property. This property provides a more
memory compact representation of a paritions Dynamic Reconfig
Connectors (DRC). These can otherwise be thought of the currently
partitioned, or available, but yet to be partitioned, system resources
such as cpus, memory, and physical/logical IOA devices.

The initial implementation proved buggy and was fully turned of by
disabling the bit in the appropriate CAS support vector. We now have
PowerVM firmware in the field that supports this new property, and 
further to suppport partitions with 24TB+ or possible memory this
property is required to perform platform migration.

This serious fixup the short comings of the previous implementation
in the areas of general implementation, cpu hotplug, and IOA hotplug.

Tyrel Datwyler (9):
  powerpc/pseries: add cpu DLPAR support for drc-info property
  powerpc/pseries: fix bad drc_index_start value parsing of drc-info
    entry
  powerpc/pseries: fix drc-info mappings of logical cpus to drc-index
  PCI: rpaphp: fix up pointer to first drc-info entry
  PCI: rpaphp: don't rely on firmware feature to imply drc-info support
  PCI: rpaphp: add drc-info support for hotplug slot registration
  PCI: rpaphp: annotate and correctly byte swap DRC properties
  PCI: rpaphp: correctly match ibm,my-drc-index to drc-name when using
    drc-info
  powerpc: Enable support for ibm,drc-info property

 arch/powerpc/kernel/prom_init.c                 |   2 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c    | 117 ++++++++++++++++------
 arch/powerpc/platforms/pseries/of_helpers.c     |   8 +-
 arch/powerpc/platforms/pseries/pseries_energy.c |  23 ++---
 drivers/pci/hotplug/rpaphp_core.c               | 124 +++++++++++++++++-------
 5 files changed, 191 insertions(+), 83 deletions(-)

-- 
2.7.4

