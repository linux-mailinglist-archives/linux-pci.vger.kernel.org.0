Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1CC324742
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 00:01:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231375AbhBXXBF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 18:01:05 -0500
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:33516 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234728AbhBXXBF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 18:01:05 -0500
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11ON0LaZ003867;
        Wed, 24 Feb 2021 15:00:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=date : from : to :
 cc : subject : in-reply-to : message-id : references : mime-version :
 content-type; s=pfpt0220; bh=VCzb5jrNLxNWd7+KBoBOrCAWvMof7wgRGvfUxf/pRTI=;
 b=LFbBSPPT+8IwHSbcgrJu4YHV1vhfIBJ9pZuW4/g0UD/HET/GngbjOwxEE4j4ZHG1kk8V
 Cn/QP6WMEgvxbAptXoF2Gh+n6lq61rDZFOoWgMamRcFpBjwzbtfjnofaYtyAbAuRnJMq
 Ut3rzz4sDTnyBVKucXuIzWb2Dxn6xpK+DN/6Mn9Z2fb1qamsKMF0GdTBTijH8Uei3YSt
 +udhJIKjGgjdQOKg5lSfSmbH6sJowdAU7hDL5NXVbkNHUnWQ9+KSBpRT1KhD3iT+dQOL
 BAzYXMq4XT43zWJVAVxB7ew/RQmt1Dw9MxkMP2i+FvtUkOs+E8ULzePKScJvN8gYLYZx Fw== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com with ESMTP id 36wxbwr87x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 24 Feb 2021 15:00:21 -0800
Received: from SC-EXCH01.marvell.com (10.93.176.81) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Feb
 2021 15:00:19 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by SC-EXCH01.marvell.com
 (10.93.176.81) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 24 Feb
 2021 15:00:18 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 24 Feb 2021 15:00:18 -0800
Received: from irv1user01.caveonetworks.com (unknown [10.104.116.179])
        by maili.marvell.com (Postfix) with ESMTP id CE8A53F7040;
        Wed, 24 Feb 2021 15:00:18 -0800 (PST)
Received: from localhost (aeasi@localhost)
        by irv1user01.caveonetworks.com (8.14.4/8.14.4/Submit) with ESMTP id 11ON0InO026325;
        Wed, 24 Feb 2021 15:00:18 -0800
X-Authentication-Warning: irv1user01.caveonetworks.com: aeasi owned process doing -bs
Date:   Wed, 24 Feb 2021 15:00:18 -0800
From:   Arun Easi <aeasi@marvell.com>
X-X-Sender: aeasi@irv1user01.caveonetworks.com
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, Girish Basrur <GBasrur@marvell.com>,
        "Quinn Tran" <qutran@marvell.com>
Subject: Re: [PATCH] PCI/VPD: Remove VPD quirk for QLogic 1077:2261
In-Reply-To: <20201219010443.6966-1-aeasi@marvell.com>
Message-ID: <alpine.LRH.2.21.9999.2102241456360.13940@irv1user01.caveonetworks.com>
References: <20201219010443.6966-1-aeasi@marvell.com>
User-Agent: Alpine 2.21.9999 (LRH 334 2019-03-29)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-24_13:2021-02-24,2021-02-24 signatures=0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Fri, 18 Dec 2020, 5:04pm, Arun Easi wrote:

> The VPD quirk was added by [0] to avoid a system NMI; this issue
> has been long fixed in the HBA firmware. In addition, PCI also has
> the logic to check the VPD size [1], so this quirk can be reverted
> now. More details in the thread:
>     "VPD blacklist of Marvell QLogic 1077/2261" [2].
> 
> [0] 0d5370d1d852 ("PCI: Prevent VPD access for QLogic ISP2722")
> [1] 104daa71b396 ("PCI: Determine actual VPD size on first access")
> [2] https://urldefense.proofpoint.com/v2/url?u=https-3A__lore.kernel.org_linux-2Dpci_alpine.LRH.2.21.9999.2012161641230.28924-40irv1user01.caveonetworks.com_&d=DwIBAg&c=nKjWec2b6R0mOyPaz7xtfQ&r=P-q_Qkt75qFy33SvdD2nAxAyN87eO1d-mFO-lqNOomw&m=Bw8qGbVsETqSibSD8JVMAxZh8BCn1cHuskKjbarfuT8&s=IMvYnIBgaHJkzF2-GgIrGymbRguV287NVLG1_KcP_po&e= 
> 
> Signed-off-by: Arun Easi <aeasi@marvell.com>
> CC: stable@vger.kernel.org      # v4.6+
> ---

Wondering if there is something needed from my side. I could not find this 
in the v5.12 list.

Regards,
-Arun
