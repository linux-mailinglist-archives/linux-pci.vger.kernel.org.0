Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0BF3256CB
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 20:35:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234464AbhBYTfW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 25 Feb 2021 14:35:22 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:53228 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235186AbhBYTdZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 25 Feb 2021 14:33:25 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11PJUWEw004976;
        Thu, 25 Feb 2021 11:32:31 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=HraabW82K+sMIIfvUrBZngCWyOuSaJDv4W/m/bvfKrk=;
 b=B9cZJ/oq8R/IdCosF9cvvdqSqt4sZqlezAtH2Qljo7pLpZ05wgBJyz60x/5D0RRIU86N
 /lK4V/Pu5EDFFciHqiIEzbR4feb9EvhnoCXX+PiUbTCEXNOoj6yhZ65weDATmPWso7QL
 5KtDyMPf7bgObhr9hbLeUyw0nSSEOtilLqIz4yzviNS0HE7FITZ/ile9Nqc+H3ucZbhc
 p/QpiVW1/ol8Q8JFhHrRYEaLMhgKD+vBOw7KSa6Zx08ELN2O4bNwEJmjrvwhSeq1Nmjo
 p0uikHuV7R74xAZ+uxb/98Wfw1PjsxWek5HJtxgVd7Qf9mq4u7uLCxtvrzZADCN2mZEX Dg== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36wxbwueas-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 25 Feb 2021 11:32:30 -0800
Received: from SC-EXCH04.marvell.com (10.93.176.84) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Feb
 2021 11:32:29 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH04.marvell.com
 (10.93.176.84) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Feb
 2021 11:32:29 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Feb 2021 11:32:29 -0800
Received: from irv1user01.caveonetworks.com (unknown [10.104.116.179])
        by maili.marvell.com (Postfix) with ESMTP id 282193F7040;
        Thu, 25 Feb 2021 11:32:29 -0800 (PST)
Received: from localhost (aeasi@localhost)
        by irv1user01.caveonetworks.com (8.14.4/8.14.4/Submit) with ESMTP id 11PJWSTs012642;
        Thu, 25 Feb 2021 11:32:28 -0800
X-Authentication-Warning: irv1user01.caveonetworks.com: aeasi owned process doing -bs
Date:   Thu, 25 Feb 2021 11:32:28 -0800
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@irv1user01.caveonetworks.com
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        "Girish Basrur" <GBasrur@marvell.com>,
        Quinn Tran <qutran@marvell.com>
Subject: Re: [EXT] Re: [PATCH] PCI/VPD: Remove VPD quirk for QLogic
 1077:2261
In-Reply-To: <20210225163157.GA5064@bjorn-Precision-5520>
Message-ID: <alpine.LRH.2.21.9999.2102251127560.13940@irv1user01.caveonetworks.com>
References: <20210225163157.GA5064@bjorn-Precision-5520>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-25_11:2021-02-24,2021-02-25 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 25 Feb 2021, 8:31am, Bjorn Helgaas wrote:

> On Wed, Feb 24, 2021 at 03:00:18PM -0800, Arun Easi wrote:
> > Hi Bjorn,
> > 
> > On Fri, 18 Dec 2020, 5:04pm, Arun Easi wrote:
> > 
> > > The VPD quirk was added by [0] to avoid a system NMI; this issue
> > > has been long fixed in the HBA firmware. In addition, PCI also has
> > > the logic to check the VPD size [1], so this quirk can be reverted
> > > now. More details in the thread:
> > >     "VPD blacklist of Marvell QLogic 1077/2261" [2].
> > > 
> > > [0] 0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722")
> > > [1] 104daa71b396 ("PCI: Determine actual VPD size on first access")
> > > [2] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dpci_alpine.LRH.2.21.9999.2012161641230.28924-40irv1user01.caveonetworks.com_&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=P-q_Qkt75qFy33SvdD2nAxAyN87eO1d-mFO-lqNOomw&m=Bw8qGbVsETqSibSD8JVMAxZh8BCn1cHuskKjbarfuT8&s=IMvYnIBgaHJkzF2-GgIrGymbRguV287NVLG1_KcP_po&e= 
> > > 
> > > Signed-off-by: Arun Easi <aeasi@marvell.com>
> > > CC: stable@vger.kernel.org      # v4.6+
> > > ---
> > 
> > Wondering if there is something needed from my side. I could not find this 
> > in the v5.12 list.
> 
> Sorry, I blew it on this one (and other VPD patches from Heiner).
> It's too late for v5.12, but I'll try again for v5.13.
> 

No worries. As these are mostly one-liners and straight forward changes, 
posting during RC is not an option for 5.12 inclusion?

Regards,
-Arun
