Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC9E2DCA19
	for <lists+linux-pci@lfdr.de>; Thu, 17 Dec 2020 01:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725889AbgLQAph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Dec 2020 19:45:37 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:26656 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725871AbgLQAph (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Dec 2020 19:45:37 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BH0isjD002616;
        Wed, 16 Dec 2020 16:44:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : message-id : mime-version : content-type; s=pfpt0220;
 bh=+NssCuTE/6KL6AeGPhw1nDTQTbl48RuyAedc8KFXKyc=;
 b=evDf4EbPCoxXx3TERiBfAK48CWVs0xJXVG050OhMwZ6VPZQ1Z7cRcFKO2YJSK0OZ4P+7
 rA3ZRgwsDSAow+J8gx6rW/Tya9zMr2fqI+HcJnrIOqdr6ZBwfWRtkAilCF/XenTrOan8
 nLOJxM9FGmL14KxJjL5d/g+YDQgcGzlESgjfeQIvv5Z92m3Fyk5Ak3IVEWnQRKmoonK9
 GXhGP4Qo2ffdAyL5uZPGz7AmjkLxp9d/9q5Ec7XDvnILmuUCzLcBiFuob4Wov5Nc1goZ
 g45QfSehRs8qTwmS3j1KHRoEhSeL0/Rn1zmlpPac5ko+t9Pr7ocDUI75gn4/09iCahrE og== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 35cx8tdxej-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 16 Dec 2020 16:44:54 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Dec
 2020 16:44:48 -0800
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 16 Dec
 2020 16:44:47 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 16 Dec 2020 16:44:47 -0800
Received: from irv1user01.caveonetworks.com (unknown [10.104.116.179])
        by maili.marvell.com (Postfix) with ESMTP id 6C4AB3F703F;
        Wed, 16 Dec 2020 16:44:47 -0800 (PST)
Received: from localhost (aeasi@localhost)
        by irv1user01.caveonetworks.com (8.14.4/8.14.4/Submit) with ESMTP id 0BH0ilxF029033;
        Wed, 16 Dec 2020 16:44:47 -0800
X-Authentication-Warning: irv1user01.caveonetworks.com: aeasi owned process doing -bs
Date:   Wed, 16 Dec 2020 16:44:47 -0800
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@irv1user01.caveonetworks.com
To:     <linux-pci@vger.kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Girish Basrur <GBasrur@marvell.com>,
        Quinn Tran <qutran@marvell.com>
Subject: VPD blacklist of Marvell QLogic 1077/2261
Message-ID: <alpine.LRH.2.21.9999.2012161641230.28924@irv1user01.caveonetworks.com>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-16_12:2020-12-15,2020-12-16 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

This is regarding the blacklisting of one of the Marvell QLogic FC
adapter (1077/2261) on VPD area access. The commit that did was
this:

--8<-- pruned commit message --8<--
| commit 0d5370d1d85251e5893ab7c90a429464de2e140b
| Author: Ethan Zhao <ethan.zhao@oracle.com>
| Date:   Mon Feb 27 17:08:44 2017 +0900
| 
|     PCI: Prevent VPD access for QLogic ISP2722
|     Call Trace:
|      <NMI>  [<ffffffff817193de>] dump_stack+0x63/0x81
|      [<ffffffff81714072>] panic+0xd0/0x20e
|      [<ffffffff8101c8b4>] do_nmi+0xf4/0x170
|      <<EOE>>  [<ffffffff815db4b3>] raw_pci_read+0x23/0x40
|      [<ffffffff815db4fc>] pci_read+0x2c/0x30
|      [<ffffffff8136f612>] pci_user_read_config_word+0x72/0x110
|      [<ffffffff8136f746>] pci_vpd_pci22_wait+0x96/0x130
|      [<ffffffff8136ff9b>] pci_vpd_pci22_read+0xdb/0x1a0
|      [<ffffffff8136ea30>] pci_read_vpd+0x20/0x30


https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0d5370d1d85251e5893ab7c90a429464de2e140b

While investigating the original report of the issue, I found an
interesting information that may explain why Ethan Zhao was
hitting the NMI/crash.

If you notice the stack referred in the commit, you could see that
a bunch of old vpd access functions, pci_vpd_pci22*, were referred.
When these functions were in use (these functions were renamed
around 2016 Feb by f1cd93f9aabe), there was a critical VPD
access bug missing; missing in fact most of the life of those
functions.

This one:
    104daa71b396: PCI: Determine actual VPD size on first access

Without this patch, a read of the vpd sysfs file can access area
outside of VPD space, which is not allowed by the spec.

My guess here is that, Ethan, when trying to access VPD of the QLogic
1077/2261 adapter, was using a kernel that had the bug present and
it led up to the NMI/crash he was observing on his machine.

We had an early firmware that returned CA on VPD access beyond
bounds that is known to NMI some servers. The FW has since changed to
not clear the VPD flag upon out-of-bound access.

In light of the above, plus the fact that I did try the
experiment on multiple setups and was not able to reproduce the
issue, would you be willing to revert the above patch? If so, I
could send a git revert (or equivalent) patch of the commit.

This blacklisting is preventing multiple customers from accessing
the VPD area of the said production adapter and making their life
a bit difficult.

Regards,
-Arun

Old discussion of the topic:
    https://lkml.org/lkml/2019/5/21/991
