Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F734461270
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 11:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234012AbhK2Kgs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Nov 2021 05:36:48 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:18934 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S231773AbhK2Ker (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Nov 2021 05:34:47 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AT9r9Ih001417;
        Mon, 29 Nov 2021 10:31:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=AlQwF06pb8+7lyCbb6gawpvTVyXzla4O23k9bJrSaiM=;
 b=Q9/xU96V1D84c8E7utR//dH9hXQlKA9C2UNh7xBfbNBP/9Jt9eH5o5fLov3uUl9EoEzN
 CWrWkxbUvEZaSKoSp2Z5PJ35Sa6aCp5AHhNl2A1uMwhP9ydgBQikRhnk9TR1Xr99Pe7g
 ZWLTvA0xRHWTgCGVqh+QMJC+aElqpiHIXzSg/8wEEpC5DtBdu5G6TqmfJljRl/4YXPuh
 XaECV/o/L9O57tctwO2Nd2LJeVpGaiX49ZFtN/FSVlAFle6q0UyPVe2edhgcbZ6ajjh9
 tJF36SYCMKRy0wzmj0i65vru8iXXE30SOJDBsaP8XWy0rrTaNDxxAE38uvf5dsD/azRq 4g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmvmg8s4b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 10:31:16 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1AT9rmsa002957;
        Mon, 29 Nov 2021 10:31:16 GMT
Received: from ppma03ams.nl.ibm.com (62.31.33a9.ip4.static.sl-reverse.com [169.51.49.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3cmvmg8s3x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 10:31:16 +0000
Received: from pps.filterd (ppma03ams.nl.ibm.com [127.0.0.1])
        by ppma03ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1ATAESKY001089;
        Mon, 29 Nov 2021 10:31:14 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma03ams.nl.ibm.com with ESMTP id 3ckca93fp6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Nov 2021 10:31:14 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1ATAVBQa63177034
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 10:31:11 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 21392A4071;
        Mon, 29 Nov 2021 10:31:11 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0E020A406D;
        Mon, 29 Nov 2021 10:31:10 +0000 (GMT)
Received: from sig-9-145-154-31.de.ibm.com (unknown [9.145.154.31])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Mon, 29 Nov 2021 10:31:09 +0000 (GMT)
Message-ID: <22589eefb62ac6f99f576082a65e7987a6761329.camel@linux.ibm.com>
Subject: Re: [patch 14/32] s390/pci: Rework MSI descriptor walk
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Date:   Mon, 29 Nov 2021 11:31:09 +0100
In-Reply-To: <20211126232735.130164978@linutronix.de>
References: <20211126230957.239391799@linutronix.de>
         <20211126232735.130164978@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: T4zBVQ4nSjNNrDgIvHLx_Jliwbz2dycD
X-Proofpoint-GUID: DdkLvko9I-gLFVnTeRxuc5TrlpJKM1LF
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-29_07,2021-11-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 adultscore=0 suspectscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2111290052
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 2021-11-27 at 02:23 +0100, Thomas Gleixner wrote:
> Replace the about to vanish iterators and make use of the filtering.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-s390@vger.kernel.org
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/pci/pci_irq.c |    6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -303,7 +303,7 @@ int arch_setup_msi_irqs(struct pci_dev *
>  
>  	/* Request MSI interrupts */
>  	hwirq = bit;
> -	for_each_pci_msi_entry(msi, pdev) {
> +	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_NOTASSOCIATED) {
>  		rc = -EIO;
>  		if (hwirq - bit >= msi_vecs)
>  			break;
> @@ -362,9 +362,7 @@ void arch_teardown_msi_irqs(struct pci_d
>  		return;
>  
>  	/* Release MSI interrupts */
> -	for_each_pci_msi_entry(msi, pdev) {
> -		if (!msi->irq)
> -			continue;
> +	msi_for_each_desc(msi, &pdev->dev, MSI_DESC_ASSOCIATED) {
>  		irq_set_msi_desc(msi->irq, NULL);
>  		irq_free_desc(msi->irq);
>  		msi->msg.address_lo = 0;
> 

Hi Thomas,

while the change looks good to me I ran into some trouble trying to
test it. I tried with the git repository you linked in the cover
letter:
git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git msi-v1-part-3

But with that I get the following linker error on s390:

s390x-11.2.0-ld: drivers/pci/msi/legacy.o: in function `pci_msi_legacy_setup_msi_irqs':
/home/nschnelle/mainline/drivers/pci/msi/legacy.c:72: undefined reference to `msi_device_populate_sysfs'
s390x-11.2.0-ld: drivers/pci/msi/legacy.o: in function `pci_msi_legacy_teardown_msi_irqs':
/home/nschnelle/mainline/drivers/pci/msi/legacy.c:78: undefined reference to `msi_device_destroy_sysfs'
make: *** [Makefile:1161: vmlinux] Error 1

This is caused by a misspelling of CONFIG_PCI_MSI_ARCH_FALLBACKS
(missing the final S) in kernel/irq/msi.c. With that fixed everything
builds and MSI IRQs work fine. So with that fixed you have my

Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Best regards,
Niklas

