Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2123C35A775
	for <lists+linux-pci@lfdr.de>; Fri,  9 Apr 2021 21:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234273AbhDIT7J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Apr 2021 15:59:09 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:13438 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S232855AbhDIT7I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Apr 2021 15:59:08 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 139JuXuN011941;
        Fri, 9 Apr 2021 12:58:51 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=4NiYhGVCH8GN2M6Y3X9LTuBR+VPe2jWncvPnS5UTpfE=;
 b=U0BOrWedV7OMNfBzvSMCLAItiHERRhVG8e8LFmJ2Ki0Z4W6gaxXhSk4ko4ft8heoR+k1
 4mk62oSSbNGMwEJ4frz0Mh8uY4dyJlSdjZZAKZZ0risyjgEfB2VAyzpJXXIgYvTY6Qha
 Mme+NqNWv8qRz2rGxt36nnJ5lhZF3LNR4hxOO+kCI5GRL5fUHC/pkZqliYaiCm2x3Umi
 n1XLXMw2fbbQBectctWobDfg1DF1kP6y6UvVX9Ap4byjxZECgP7hAnaiS6S3WUnchMzX
 btXOTCVF9wWhQ2HbNOcmcROznTQ1o9lTXeQcmp4q9oJU41g4+sFAr/uoZbrdLMLqyRsw Zw== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 37tftpac6a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Fri, 09 Apr 2021 12:58:51 -0700
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Apr
 2021 12:58:50 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Apr 2021 12:58:50 -0700
Received: from irv1user01.caveonetworks.com (unknown [10.104.116.179])
        by maili.marvell.com (Postfix) with ESMTP id 474353F703F;
        Fri,  9 Apr 2021 12:58:50 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by irv1user01.caveonetworks.com (8.14.4/8.14.4/Submit) with ESMTP id 139Jwo9Z022597;
        Fri, 9 Apr 2021 12:58:50 -0700
X-Authentication-Warning: irv1user01.caveonetworks.com: aeasi owned process doing -bs
Date:   Fri, 9 Apr 2021 12:58:49 -0700
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@irv1user01.caveonetworks.com
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        "Girish Basrur" <GBasrur@marvell.com>,
        Quinn Tran <qutran@marvell.com>
Subject: Re: [EXT] Re: [PATCH 1/1] PCI/VPD: Fix blocking of VPD data in lspci
 for QLogic 1077:2261
In-Reply-To: <20210408172747.GA1940414@bjorn-Precision-5520>
Message-ID: <alpine.LRH.2.21.9999.2104091255490.13940@irv1user01.caveonetworks.com>
References: <20210408172747.GA1940414@bjorn-Precision-5520>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-GUID: k3T8v6_IxLnWiTLQVdkakwdRWbdLqSBm
X-Proofpoint-ORIG-GUID: k3T8v6_IxLnWiTLQVdkakwdRWbdLqSBm
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-09_07:2021-04-09,2021-04-09 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 8 Apr 2021, 10:27am, Bjorn Helgaas wrote:

> External Email
> 
> ----------------------------------------------------------------------
> On Wed, Apr 07, 2021 at 03:57:32PM -0700, Arun Easi wrote:
> > On Wed, 7 Apr 2021, 3:13pm, Bjorn Helgaas wrote:
> > 
> > > On Wed, Mar 03, 2021 at 02:42:50PM -0800, Arun Easi wrote:
> > > > "lspci -vvv" for Qlogic Fibre Channel HBA 1077:2261 displays
> > > > "Vital Product Data" as "Not readable" today and thus preventing
> > > > customers from getting relevant HBA information. Fix it by removing
> > > > the blacklist quirk.
> > > > 
> > > > The VPD quirk was added by [0] to avoid a system NMI; this issue has
> > > > been long fixed in the HBA firmware. In addition, PCI also has changes
> > > > to check the VPD size [1], so this quirk can be reverted now regardless
> > > > of a firmware update.
> > > 
> > > This is not a very convincing argument yet since 104daa71b396 ("PCI:
> > > Determine actual VPD size on first access") appeared in v4.6 and
> > > 0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722") appeared
> > > in v4.11.
> > > 
> > > If 104daa71b396 really fixed the problem, why did we need
> > > 0d5370d1d852?
> > 
> > True, 0d5370d1d852 was not really neeeded for 104daa71b396 and newer 
> > kernels; my theory is that when Ethan Z. ran the tests, he was using an 
> > older (older than 104daa71b396) kernel, but by the time the blacklisting 
> > was put in place, the kernel already had the fix that made the 
> > blacklisting unnecessary.
> > 
> > More of my investigation details explained here:
> > 	https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dpci_alpine.LRH.2.21.9999.2012161641230.28924-40irv1user01.caveonetworks.com_&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=P-q_Qkt75qFy33SvdD2nAxAyN87eO1d-mFO-lqNOomw&m=6AxpinjPP1ODX7dE-syNBDgke94moUP_K_jm_ZTu6pI&s=YxWnXn7ZfcD1PJlUkl82l8TK5sNX7uBwkCJxKgpAgEM&e= 
> > 
> > A quick summary of which is that, when Ethan reported the crash stack, it 
> > had pci_vpd_pci22* calls which is seen only in older kernels. Though 
> > 104daa71b396 too had those calls, it was very close to the commit that 
> > renamed those calls (f1cd93f9aabe) -- and I theorized Ethan probably was 
> > not running a kernel between 104daa71b396 and f1cd93f9aabe (only 3 
> > commits (drivers/pci/) away).
> 
> We should put the outline of this theory in the commit log for the
> benefit of future readers who have the same question I did.
> 

Sure, will post a V2. BTW, the details were mentioned as a link "[2]" in 
the commit, I will pull the contents to the commit message.

Thanks Bjorn.

Regards,
-Arun
