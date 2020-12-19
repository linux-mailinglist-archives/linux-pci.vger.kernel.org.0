Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B1E2DEC63
	for <lists+linux-pci@lfdr.de>; Sat, 19 Dec 2020 01:28:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbgLSA2C (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Dec 2020 19:28:02 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:53494 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725939AbgLSA2B (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Dec 2020 19:28:01 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0BJ0OqMf019161;
        Fri, 18 Dec 2020 16:27:17 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=ImY7P1oS1VczfP/s/GTB6zDSm8fFai9bAiH3SN5S3qY=;
 b=PzJsljh8xTSZzvonqRYGU/63ru9A3sCWLe3jB09G3M7un4PoHedi+JexeYYGqO2QLEEB
 3DFUyvuKVts/lbLbpz+3RSn2Y/4z1VA0QIXEq9EBwrCHnlqG4lslPoz5L5EmnpurEm14
 d9WFNZbwNrwn7BpEB3ph2gQLJwUvX4loJgJU4Mvrp8iU9PLO7rSpikWkDRUKZBh9tS+T
 iiNXviSZG6G0rm+hCm8XyvGMVKRHf1oxBYnQcOE48goMV7b+8X5ewt839FJrCO4FkMxR
 myPtOALq3LnMfZeHqJCNXNf4RHnxFkY2eccJON+DuOHyPGaGE73RldagP1o6lMmlQWcm lw== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 35gq80jakk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 18 Dec 2020 16:27:17 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 18 Dec
 2020 16:27:15 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Dec 2020 16:27:16 -0800
Received: from irv1user01.caveonetworks.com (unknown [10.104.116.179])
        by maili.marvell.com (Postfix) with ESMTP id D2CBF3F7041;
        Fri, 18 Dec 2020 16:27:15 -0800 (PST)
Received: from localhost (aeasi@localhost)
        by irv1user01.caveonetworks.com (8.14.4/8.14.4/Submit) with ESMTP id 0BJ0RFNe010588;
        Fri, 18 Dec 2020 16:27:15 -0800
X-Authentication-Warning: irv1user01.caveonetworks.com: aeasi owned process doing -bs
Date:   Fri, 18 Dec 2020 16:27:15 -0800
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@irv1user01.caveonetworks.com
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Girish Basrur" <GBasrur@marvell.com>,
        Quinn Tran <qutran@marvell.com>
Subject: Re: [EXT] Re: VPD blacklist of Marvell QLogic 1077/2261
In-Reply-To: <20201217174821.GA9644@bjorn-Precision-5520>
Message-ID: <alpine.LRH.2.21.9999.2012181625140.28924@irv1user01.caveonetworks.com>
References: <20201217174821.GA9644@bjorn-Precision-5520>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-18_14:2020-12-18,2020-12-18 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 17 Dec 2020, 9:48am, Bjorn Helgaas wrote:

> ----------------------------------------------------------------------
> On Wed, Dec 16, 2020 at 04:44:47PM -0800, Arun Easi wrote:
> > Hi Bjorn,
> > 
> > This is regarding the blacklisting of one of the Marvell QLogic FC
> > adapter (1077/2261) on VPD area access. The commit that did was
> > this:
> > 
> > --8<-- pruned commit message --8<--
> > | commit 0d5370d1d85251e5893ab7c90a429464de2e140b
> > | Author: Ethan Zhao <ethan.zhao@oracle.com>
> > | Date:   Mon Feb 27 17:08:44 2017 +0900
> > | 
> > |     PCI: Prevent VPD access for QLogic ISP2722
> > |     Call Trace:
> > |      <NMI>  [<ffffffff817193de>] dump_stack+0x63/0x81
> > |      [<ffffffff81714072>] panic+0xd0/0x20e
> > |      [<ffffffff8101c8b4>] do_nmi+0xf4/0x170
> > |      <<EOE>>  [<ffffffff815db4b3>] raw_pci_read+0x23/0x40
> > |      [<ffffffff815db4fc>] pci_read+0x2c/0x30
> > |      [<ffffffff8136f612>] pci_user_read_config_word+0x72/0x110
> > |      [<ffffffff8136f746>] pci_vpd_pci22_wait+0x96/0x130
> > |      [<ffffffff8136ff9b>] pci_vpd_pci22_read+0xdb/0x1a0
> > |      [<ffffffff8136ea30>] pci_read_vpd+0x20/0x30
> > 
> > 
> > https://urldefense.proofpoint.com/v2/url?u=https-3A__git.kernel.org_pub_scm_linux_kernel_git_torvalds_linux.git_commit_-3Fid-3D0d5370d1d85251e5893ab7c90a429464de2e140b&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=P-q_Qkt75qFy33SvdD2nAxAyN87eO1d-mFO-lqNOomw&m=ELM92cQ6_T7TDXwxkSNKe9OLqFeqz7taCSqUM65T0s0&s=FIa8kmuzs8pePhWEFklKpu49_i72T5mJMZgLp1QrEg0&e= 
> > 
> > While investigating the original report of the issue, I found an
> > interesting information that may explain why Ethan Zhao was
> > hitting the NMI/crash.
> > 
> > If you notice the stack referred in the commit, you could see that
> > a bunch of old vpd access functions, pci_vpd_pci22*, were referred.
> > When these functions were in use (these functions were renamed
> > around 2016 Feb by f1cd93f9aabe), there was a critical VPD
> > access bug missing; missing in fact most of the life of those
> > functions.
> > 
> > This one:
> >     104daa71b396: PCI: Determine actual VPD size on first access
> > 
> > Without this patch, a read of the vpd sysfs file can access area
> > outside of VPD space, which is not allowed by the spec.
> > 
> > My guess here is that, Ethan, when trying to access VPD of the QLogic
> > 1077/2261 adapter, was using a kernel that had the bug present and
> > it led up to the NMI/crash he was observing on his machine.
> > 
> > We had an early firmware that returned CA on VPD access beyond
> > bounds that is known to NMI some servers. The FW has since changed to
> > not clear the VPD flag upon out-of-bound access.
> > 
> > In light of the above, plus the fact that I did try the
> > experiment on multiple setups and was not able to reproduce the
> > issue, would you be willing to revert the above patch? If so, I
> > could send a git revert (or equivalent) patch of the commit.
> > 
> > This blacklisting is preventing multiple customers from accessing
> > the VPD area of the said production adapter and making their life
> > a bit difficult.
> > 
> > Regards,
> > -Arun
> > 
> > Old discussion of the topic:
> >     https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2019_5_21_991&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=P-q_Qkt75qFy33SvdD2nAxAyN87eO1d-mFO-lqNOomw&m=ELM92cQ6_T7TDXwxkSNKe9OLqFeqz7taCSqUM65T0s0&s=1vnPz2Y-ziZnOVBFLuc9QupJeVDdtUUJTMJrNknSe7o&e= 
> 
> It makes sense to revert 0d5370d1d852 ("PCI: Prevent VPD access for
> QLogic ISP2722") as long as the resulting kernel works correctly on
> all versions of the 2722 firmware.  We have to assume some customers
> still have the old firmware on their adapters.
> 
> Bjorn
> 

Thanks Bjorn. I'll post the patch with a stable cc of v4.6+, which has the 
VPD size check available.

Regards,
-Arun
