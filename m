Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABEE357818
	for <lists+linux-pci@lfdr.de>; Thu,  8 Apr 2021 00:57:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229845AbhDGW5r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Apr 2021 18:57:47 -0400
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:29826 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S229460AbhDGW5r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Apr 2021 18:57:47 -0400
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137MuhKQ019052;
        Wed, 7 Apr 2021 15:57:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=8m49GbG4M/pYXsG3YpXl5KihbBBvfyriAv3RT1h560g=;
 b=ff7Ulmn8lBCCtB1co35xPm8N2li79gfF50eSkKFc8PL3Ql0qqecr1aGgdS29SBENGTlO
 j3QH+hTPnOIbmSBX7qW0AsauPdeqVdY1rNBFAorJJXNo1fNK5LiUsb+rTYy3x+Tcdd1Q
 E+ZiptSfckmJeNiArDNKevpjjVHxV2wFnAx/6nOu3ity3rn9gptHcMrR8/khpnvBeys8
 zMRuZ+9UmnvYTW9329KWZ/sK0Il6STp2kZEDOGfpixVLcmA/DhJaPb3LRZfYJW8dztlV
 Q/KZtcc90Z0VTqT1fZCRnGrr11MKx8WlMNfh8cSLqbcVOp09O2cyy2JppilMtpoCxQsF bA== 
Received: from dc5-exch01.marvell.com ([199.233.59.181])
        by mx0a-0016f401.pphosted.com with ESMTP id 37shqxgtx7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 07 Apr 2021 15:57:33 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 7 Apr
 2021 15:57:32 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 7 Apr 2021 15:57:32 -0700
Received: from irv1user01.caveonetworks.com (unknown [10.104.116.179])
        by maili.marvell.com (Postfix) with ESMTP id 947463F703F;
        Wed,  7 Apr 2021 15:57:32 -0700 (PDT)
Received: from localhost (aeasi@localhost)
        by irv1user01.caveonetworks.com (8.14.4/8.14.4/Submit) with ESMTP id 137MvWKC029508;
        Wed, 7 Apr 2021 15:57:32 -0700
X-Authentication-Warning: irv1user01.caveonetworks.com: aeasi owned process doing -bs
Date:   Wed, 7 Apr 2021 15:57:32 -0700
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@irv1user01.caveonetworks.com
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        "Girish Basrur" <GBasrur@marvell.com>,
        Quinn Tran <qutran@marvell.com>
Subject: Re: [PATCH 1/1] PCI/VPD: Fix blocking of VPD data in lspci for QLogic
 1077:2261
In-Reply-To: <20210407221312.GA1872228@bjorn-Precision-5520>
Message-ID: <alpine.LRH.2.21.9999.2104071535110.13940@irv1user01.caveonetworks.com>
References: <20210407221312.GA1872228@bjorn-Precision-5520>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-ORIG-GUID: GgTjBsau_zKITH1dqI9LbYy2ilZeY6gE
X-Proofpoint-GUID: GgTjBsau_zKITH1dqI9LbYy2ilZeY6gE
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_11:2021-04-07,2021-04-07 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 7 Apr 2021, 3:13pm, Bjorn Helgaas wrote:

> On Wed, Mar 03, 2021 at 02:42:50PM -0800, Arun Easi wrote:
> > "lspci -vvv" for Qlogic Fibre Channel HBA 1077:2261 displays
> > "Vital Product Data" as "Not readable" today and thus preventing
> > customers from getting relevant HBA information. Fix it by removing
> > the blacklist quirk.
> > 
> > The VPD quirk was added by [0] to avoid a system NMI; this issue has
> > been long fixed in the HBA firmware. In addition, PCI also has changes
> > to check the VPD size [1], so this quirk can be reverted now regardless
> > of a firmware update.
> 
> This is not a very convincing argument yet since 104daa71b396 ("PCI:
> Determine actual VPD size on first access") appeared in v4.6 and
> 0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722") appeared
> in v4.11.
> 
> If 104daa71b396 really fixed the problem, why did we need
> 0d5370d1d852?

True, 0d5370d1d852 was not really neeeded for 104daa71b396 and newer 
kernels; my theory is that when Ethan Z. ran the tests, he was using an 
older (older than 104daa71b396) kernel, but by the time the blacklisting 
was put in place, the kernel already had the fix that made the 
blacklisting unnecessary.

More of my investigation details explained here:
	https://lore.kernel.org/linux-pci/alpine.LRH.2.21.9999.2012161641230.28924@irv1user01.caveonetworks.com/

A quick summary of which is that, when Ethan reported the crash stack, it 
had pci_vpd_pci22* calls which is seen only in older kernels. Though 
104daa71b396 too had those calls, it was very close to the commit that 
renamed those calls (f1cd93f9aabe) -- and I theorized Ethan probably was 
not running a kernel between 104daa71b396 and f1cd93f9aabe (only 3 
commits (drivers/pci/) away).

Unfortunately, Ethan's blacklisting patch did not have the kernel commit 
SHA he had used.

Regards,
-Arun

> 
> > Some more details can be found in the following thread:
> >     "VPD blacklist of Marvell QLogic 1077/2261" [2].
> > 
> > [0] 0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722")
> > [1] 104daa71b396 ("PCI: Determine actual VPD size on first access")
> > [2] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dpci_alpine.LRH.2.21.9999.2012161641230.28924-40irv1user01.caveonetworks.com_&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=P-q_Qkt75qFy33SvdD2nAxAyN87eO1d-mFO-lqNOomw&m=lPsRSUHeHa9BMJpm_qohlCkGzpRmhdPSNythG7ljHAU&s=Orsa4H3WN7tR8DOfCIof1toWvMUQZ2Mq0HzHPIFzEhQ&e= 
> > 
> > Signed-off-by: Arun Easi <aeasi@marvell.com>
> > CC: stable@vger.kernel.org      # v4.6+
> > ---
> >  drivers/pci/vpd.c | 1 -
> >  1 file changed, 1 deletion(-)
> > 
> > diff --git a/drivers/pci/vpd.c b/drivers/pci/vpd.c
> > index 7915d10..bd54907 100644
> > --- a/drivers/pci/vpd.c
> > +++ b/drivers/pci/vpd.c
> > @@ -570,7 +570,6 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005d, quirk_blacklist_vpd);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_LSI_LOGIC, 0x005f, quirk_blacklist_vpd);
> >  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATTANSIC, PCI_ANY_ID,
> >  		quirk_blacklist_vpd);
> > -DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_QLOGIC, 0x2261, quirk_blacklist_vpd);
> >  /*
> >   * The Amazon Annapurna Labs 0x0031 device id is reused for other non Root Port
> >   * device types, so the quirk is registered for the PCI_CLASS_BRIDGE_PCI class.
> > -- 
> > 2.9.5
> > 
> 
