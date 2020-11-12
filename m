Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25BB52B0947
	for <lists+linux-pci@lfdr.de>; Thu, 12 Nov 2020 16:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729055AbgKLP7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Nov 2020 10:59:36 -0500
Received: from mx0a-002e3701.pphosted.com ([148.163.147.86]:24344 "EHLO
        mx0a-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729061AbgKLP73 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Nov 2020 10:59:29 -0500
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ACFVEoK014676;
        Thu, 12 Nov 2020 15:59:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=Hbf4fspH4F+J2nMeU0ZvDGNd4vlBMijSKNc6dujRs04=;
 b=V6Tg1TTm+iypDTapJiChdjG8vMXudJEBmFAC/goK3D/vjU2/MwKoh3y9tTTStKdSrvip
 KoGLcG/82B1H9OjtMwSirk3xP8j9lVK47D4K+Y2rK/quLOkT+//OWIkYyBCyomn2kVsV
 lV9fmn3m959x7gEBWCy1o3EbCwsjqAVVwNgTRebDDqlrQe+jCr5VcEhOLfo0rh/w6iXP
 WrD9/YEFtp2Tb847B5bO1cTBIEKJvLR9oexZv3/M1oQvrRpJ4LSdoqqx1QCpM+JwHyfh
 a+EFWKr3C6WrlmScEYa1DuBlyTtGG+gdqNek+kIpsm+GlquxHOS/rI2yLmOBJN2UyWF7 AA== 
Received: from g2t2352.austin.hpe.com (g2t2352.austin.hpe.com [15.233.44.25])
        by mx0b-002e3701.pphosted.com with ESMTP id 34r0yggma6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 12 Nov 2020 15:59:18 +0000
Received: from sarge.linuxathome.me (unknown [16.29.131.18])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by g2t2352.austin.hpe.com (Postfix) with ESMTPS id 4F8B99C;
        Thu, 12 Nov 2020 15:59:15 +0000 (UTC)
Date:   Thu, 12 Nov 2020 15:59:12 +0000
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sinan Kaya <okaya@kernel.org>, Russ Anderson <rja@hpe.com>,
        Joerg Roedel <jroedel@suse.com>, stable@kernel.org
Subject: Re: [PATCH v4 1/1] PCI/ERR: don't clobber status after reset_link()
Message-ID: <20201112155912.GE74254@sarge.linuxathome.me>
Mail-Followup-To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Ashok Raj <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinan Kaya <okaya@kernel.org>,
        Russ Anderson <rja@hpe.com>, Joerg Roedel <jroedel@suse.com>,
        stable@kernel.org
References: <20201102150951.149893-1-hedi.berriche@hpe.com>
 <20201102150951.149893-2-hedi.berriche@hpe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20201102150951.149893-2-hedi.berriche@hpe.com>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-12_06:2020-11-12,2020-11-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 adultscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 suspectscore=1 clxscore=1011 malwarescore=0 mlxscore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011120093
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 02, 2020 at 15:10 Hedi Berriche wrote:
>Commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>broke pcie_do_recovery(): updating status after reset_link() has the ill
>side effect of causing recovery to fail if the error status is
>PCI_ERS_RESULT_CAN_RECOVER or PCI_ERS_RESULT_NEED_RESET as the following
>code will *never* run in the case of a successful reset_link()
>
>   177         if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>   ...
>   181         }
>
>   183         if (status == PCI_ERS_RESULT_NEED_RESET) {
>   ...
>   192         }
>
>For instance in the case of PCI_ERS_RESULT_NEED_RESET we end up not
>calling ->slot_reset() (because we skip report_slot_reset()) thus
>breaking driver (re)initialisation.
>
>Don't clobber status with the return value of reset_link(); set status
>to PCI_ERS_RESULT_RECOVERED, in case of successful link reset, if and
>only if the initial value of error status is PCI_ERS_RESULT_DISCONNECT
>or PCI_ERS_RESULT_NO_AER_DRIVER.
>
>Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
>
>Reviewed-by: Sinan Kaya <okaya@kernel.org>
>Cc: Russ Anderson <rja@hpe.com>
>Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>Cc: Bjorn Helgaas <bhelgaas@google.com>
>Cc: Ashok Raj <ashok.raj@intel.com>
>Cc: Joerg Roedel <jroedel@suse.com>
>
>Cc: stable@kernel.org # v5.7+
>---
> drivers/pci/pcie/err.c | 7 +++++--
> 1 file changed, 5 insertions(+), 2 deletions(-)
>
>diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>index c543f419d8f9..2730826cfd8a 100644
>--- a/drivers/pci/pcie/err.c
>+++ b/drivers/pci/pcie/err.c
>@@ -165,10 +165,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
> 	pci_dbg(dev, "broadcast error_detected message\n");
> 	if (state == pci_channel_io_frozen) {
> 		pci_walk_bus(bus, report_frozen_detected, &status);
>-		status = reset_link(dev);
>-		if (status != PCI_ERS_RESULT_RECOVERED) {
>+		if (reset_link(dev) != PCI_ERS_RESULT_RECOVERED) {
> 			pci_warn(dev, "link reset failed\n");
> 			goto failed;
>+		} else {
>+			if (status == PCI_ERS_RESULT_DISCONNECT ||
>+			    status == PCI_ERS_RESULT_NO_AER_DRIVER)
>+				status = PCI_ERS_RESULT_RECOVERED;
> 		}
> 	} else {
> 		pci_walk_bus(bus, report_normal_detected, &status);
>-- 
>2.28.0

Bjorn,

Sorry to bug you, but could you please cast your eyes on this patch and let me know whether you have
any concerns that might be barring it from inclusion.

Cheers,
Hedi.
-- 
Be careful of reading health books, you might die of a misprint.
	-- Mark Twain
