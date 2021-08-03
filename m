Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B9B33DEE2D
	for <lists+linux-pci@lfdr.de>; Tue,  3 Aug 2021 14:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236018AbhHCMsx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Aug 2021 08:48:53 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7008 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235909AbhHCMsw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Aug 2021 08:48:52 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 173CXF1o026900;
        Tue, 3 Aug 2021 08:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=y7eI/WKog5QgbT7neYvgTkNPKlxpYkmXQahi9gRnTTE=;
 b=h2wOAO13925nivPLe5i3sHZeZ2FWsrCvN0ztNOBvkVJbhBTTNtEHvEnPyfHA4VO15W92
 3uLowxhQPz8nbcV0fVvkvqQm1bajUT73AxgsL/aG7+peIkvCGAUiYqwWSMtA0Q7fDtqd
 zsxuJoh/a0+a6OPqsjm+GxpgHumfDb/OepMJUGyUABHqW3QhqMCLNqs2+iHg4ETr1HFq
 TYDO3ggzNAk+dEvyovndt2wmKDTuXBUEnLnyoHp7UAPGtaC+Hb9tsmUsBFs60xgbUpPj
 A+9GxfUjgr7OvL7XcuHg3/0greq84bGkK/H/tw6poKsJXa2ujWojefebkx7h20nDNOwz Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a5kke2g3q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 08:48:23 -0400
Received: from m0098393.ppops.net (m0098393.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 173CY5N9029863;
        Tue, 3 Aug 2021 08:48:22 -0400
Received: from ppma04fra.de.ibm.com (6a.4a.5195.ip4.static.sl-reverse.com [149.81.74.106])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3a5kke2g2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 08:48:22 -0400
Received: from pps.filterd (ppma04fra.de.ibm.com [127.0.0.1])
        by ppma04fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 173Chdmr032507;
        Tue, 3 Aug 2021 12:48:19 GMT
Received: from b06cxnps4076.portsmouth.uk.ibm.com (d06relay13.portsmouth.uk.ibm.com [9.149.109.198])
        by ppma04fra.de.ibm.com with ESMTP id 3a4x596b9s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 03 Aug 2021 12:48:19 +0000
Received: from d06av21.portsmouth.uk.ibm.com (d06av21.portsmouth.uk.ibm.com [9.149.105.232])
        by b06cxnps4076.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 173CmF2Y51446018
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 3 Aug 2021 12:48:15 GMT
Received: from d06av21.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4485F5204E;
        Tue,  3 Aug 2021 12:48:15 +0000 (GMT)
Received: from sig-9-145-29-26.uk.ibm.com (unknown [9.145.29.26])
        by d06av21.portsmouth.uk.ibm.com (Postfix) with ESMTP id 905AA52050;
        Tue,  3 Aug 2021 12:48:14 +0000 (GMT)
Message-ID: <9adb96573280c12a277ac8f63742065d6d574e54.camel@linux.ibm.com>
Subject: Re: [patch V2 12/19] s390/pci: Do not mask MSI[-X] entries on
 teardown
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-s390@vger.kernel.org,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Date:   Tue, 03 Aug 2021 14:48:14 +0200
In-Reply-To: <20210729222542.939798136@linutronix.de>
References: <20210729215139.889204656@linutronix.de>
         <20210729222542.939798136@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Tnmq2Rh380lFtGMTYA-muuklRO8VYSL0
X-Proofpoint-ORIG-GUID: 9iN5-hZhFCBWSavvkM-BUdb7I6xKL7Y_
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-08-03_02:2021-08-03,2021-08-03 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 bulkscore=0 clxscore=1011 priorityscore=1501 adultscore=0
 mlxlogscore=981 phishscore=0 impostorscore=0 spamscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2107140000 definitions=main-2108030084
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2021-07-29 at 23:51 +0200, Thomas Gleixner wrote:
> The PCI core already ensures that the MSI[-X] state is correct when MSI[-X]
> is disabled. For MSI the reset state is all entries unmasked and for MSI-X
> all vectors are masked.
> 
> S390 masks all MSI entries and masks the already masked MSI-X entries
> again. Remove it and let the device in the correct state.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-s390@vger.kernel.org
> Cc: Niklas Schnelle <schnelle@linux.ibm.com>
> Cc: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/pci/pci_irq.c |    4 ----
>  drivers/pci/msi.c       |    4 ++--
>  include/linux/msi.h     |    2 --
>  3 files changed, 2 insertions(+), 8 deletions(-)
> 
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -365,10 +365,6 @@ void arch_teardown_msi_irqs(struct pci_d
>  	for_each_pci_msi_entry(msi, pdev) {
>  		if (!msi->irq)
>  			continue;
> -		if (msi->msi_attrib.is_msix)
> -			__pci_msix_desc_mask_irq(msi, 1);
> -		else
> -			__pci_msi_desc_mask_irq(msi, 1, 1);
>  		irq_set_msi_desc(msi->irq, NULL);
>  		irq_free_desc(msi->irq);
>  		msi->msg.address_lo = 0;
> --- a/drivers/pci/msi.c
> +++ b/drivers/pci/msi.c
> @@ -143,7 +143,7 @@ static inline __attribute_const__ u32 ms
>   * reliably as devices without an INTx disable bit will then generate a
>   * level IRQ which will never be cleared.
>   */
> -void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
> +static void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag)
>  {
>  	raw_spinlock_t *lock = &desc->dev->msi_lock;
>  	unsigned long flags;
> @@ -180,7 +180,7 @@ static void __iomem *pci_msix_desc_addr(
>   * file.  This saves a few milliseconds when initialising devices with lots
>   * of MSI-X interrupts.
>   */
> -u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
> +static u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
>  {
>  	u32 mask_bits = desc->masked;
>  	void __iomem *desc_addr;
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -232,8 +232,6 @@ void free_msi_entry(struct msi_desc *ent
>  void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>  void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
>  
> -u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag);
> -void __pci_msi_desc_mask_irq(struct msi_desc *desc, u32 mask, u32 flag);
>  void pci_msi_mask_irq(struct irq_data *data);
>  void pci_msi_unmask_irq(struct irq_data *data);
>  
> 

I gave this patch a try, adapted for v5.14-rc4 where
__pci_msi_desc_msg() returns a u32, and all looks good. I tested with
our pretty quirky ISM devices too, which are the only MSI ones on
s390x.

It also makes sense to me to let the common code handle this so feel
free to add my:

Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>

and/or

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>

Thanks.


