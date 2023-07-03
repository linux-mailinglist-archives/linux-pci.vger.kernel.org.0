Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 080F8745DDD
	for <lists+linux-pci@lfdr.de>; Mon,  3 Jul 2023 15:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjGCNxf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Jul 2023 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbjGCNxe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Jul 2023 09:53:34 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8854F173E;
        Mon,  3 Jul 2023 06:53:03 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 363DlFK3021013;
        Mon, 3 Jul 2023 13:53:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=Zks76VxuDXc3c1DjkxHa0WDuacHs0LnUM0tAkMPj8+c=;
 b=iXTmlK4tseie+0fDzhM9cj3/om4qRJ1u3bzuh+cpJu2PcAr6Ur3UGHi3VlZNQG9jZXi/
 muHY8yG0pv5RuLEAxUx1WAkjNQuZq13IE5QYHJQVB1MT22+w17iPyfO3k4RTLFMzGllH
 SvZpVvpjjZbcO3BhV/H14ZFK96vACO8LnPDAc0PGDU59yOl9xztd6FZVUAIN7UwV5+qX
 KXxjovjoPhJvWCge0p2YRZmNxRVhX4Nt85qAkhuHXvQfnXnZ9y7WyGm54aC1EP56tLcE
 MXtsInzERtpzsCMWNveNMVwyPbb7rcPTgxmd2CKS0cwz9+60jojppVqrY3GxqDULeiBN xw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkygwr519-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 13:53:00 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 363DmVZE026888;
        Mon, 3 Jul 2023 13:53:00 GMT
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rkygwr50j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 13:53:00 +0000
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3633jhVV031193;
        Mon, 3 Jul 2023 13:52:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma04ams.nl.ibm.com (PPS) with ESMTPS id 3rjbs4sbsf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 03 Jul 2023 13:52:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 363DqtfV58655128
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 3 Jul 2023 13:52:55 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B89F32004B;
        Mon,  3 Jul 2023 13:52:55 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 88D5320043;
        Mon,  3 Jul 2023 13:52:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
        Mon,  3 Jul 2023 13:52:55 +0000 (GMT)
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] PCI: Handle HAS_IOPORT dependencies
Date:   Mon,  3 Jul 2023 15:52:53 +0200
Message-Id: <20230703135255.2202721-1-schnelle@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 27iTxnSSNzd-vp5FGE3aD5NqLdxLxHkz
X-Proofpoint-GUID: 5tYmno7q2ZRSLYX8vwVUNCUDvxfq_xFS
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-03_11,2023-06-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 adultscore=0 mlxlogscore=939 impostorscore=0 bulkscore=0
 mlxscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307030122
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

This is a follow up to my ongoing effort of making the inb()/outb() and
similar I/O port accessors compile-time optional. Previously I sent this as
a complete treewide series titled "treewide: Remove I/O port accessors for
HAS_IOPORT=n" with the latest being its 5th version[0]. Now about half of
the per-subsystem patches have been merged so I'm changing over to stand
alone subsystem patches. These series are stand alone and should be merged
via the relevant tree such that with all subsystems complete we can follow
this up with the last patch[1] that will make the I/O port accessors
compile-time optional.

As for compile-time vs runtime see Linus' reply to my first attempt[2].

Other than rebasing on current master there are no changes to these
two patches for the PCI subsystem.

Thanks,
Niklas

[0] https://lore.kernel.org/all/20230516110038.2413224-1-schnelle@linux.ibm.com/
[1] https://lore.kernel.org/all/20230516110038.2413224-42-schnelle@linux.ibm.com/
[2] https://lore.kernel.org/lkml/CAHk-=wg80je=K7madF4e7WrRNp37e3qh6y10Svhdc7O8SZ_-8g@mail.gmail.com/

Niklas Schnelle (2):
  PCI: Make quirk using inw() depend on HAS_IOPORT
  PCI/sysfs: Make I/O resource depend on HAS_IOPORT

 drivers/pci/pci-sysfs.c | 4 ++++
 drivers/pci/quirks.c    | 2 ++
 2 files changed, 6 insertions(+)


base-commit: a901a3568fd26ca9c4a82d8bc5ed5b3ed844d451
-- 
2.39.2

