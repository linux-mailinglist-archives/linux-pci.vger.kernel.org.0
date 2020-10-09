Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70B35288106
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 06:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgJIELS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 00:11:18 -0400
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:61042 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726147AbgJIELS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 00:11:18 -0400
Received: from pps.filterd (m0148664.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09946OCd013591;
        Fri, 9 Oct 2020 04:11:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=date : from : to :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pps0720; bh=UFmCA3vn2Jwa1U3jzBh3mGOHf5C1nnnscXE2M84P0Lg=;
 b=RWuJDDSGoyN5ihItZgu7JGLEiT7RfL1Vo9zHaoG5ZvKef0srG6ATQaXLEIO4V6KafVLq
 21Z9fKTuaWTjDm2wTFbxJLJK/dWLcIVth2P8PfWrLJdG5u+ISdgImChCCIIf6Q+jRQ+B
 dsoePztXkZhJe6fNsF5KiK5i+ciGp0aJfZylZH8HcZUNOFPXRGD780g8RvrMhKu/zssf
 Eg2CQz5/vrsExGfL+HjxF9DaOSVLrYB6Y/TUUGI4PN1R60PcZVS/NvYL6o0zLgnvg89n
 pofecqy63fJWu83m+4eWB9WAjhjetExW9Naf3Gmj8sgvuz/1SVfn9/jS4aH96V51Fv/u VA== 
Received: from g4t3426.houston.hpe.com (g4t3426.houston.hpe.com [15.241.140.75])
        by mx0b-002e3701.pphosted.com with ESMTP id 3429m52q20-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Oct 2020 04:11:08 +0000
Received: from g4t3433.houston.hpecorp.net (g4t3433.houston.hpecorp.net [16.208.49.245])
        by g4t3426.houston.hpe.com (Postfix) with ESMTP id D79A35F;
        Fri,  9 Oct 2020 04:11:07 +0000 (UTC)
Received: from sarge.linuxathome.me (unknown [16.29.167.198])
        by g4t3433.houston.hpecorp.net (Postfix) with ESMTP id 1434647;
        Fri,  9 Oct 2020 04:11:05 +0000 (UTC)
Date:   Fri, 9 Oct 2020 05:11:05 +0100
From:   Hedi Berriche <hedi.berriche@hpe.com>
To:     "Raj, Ashok" <ashok.raj@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russ Anderson <rja@hpe.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.com>, stable@kernel.org
Subject: Re: [PATCH v1 1/1] PCI/ERR: don't clobber status after reset_link()
Message-ID: <20201009041105.GC2365427@sarge.linuxathome.me>
Mail-Followup-To: "Raj, Ashok" <ashok.raj@intel.com>,
        Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Russ Anderson <rja@hpe.com>, Bjorn Helgaas <bhelgaas@google.com>,
        Joerg Roedel <jroedel@suse.com>, stable@kernel.org
References: <20201009025251.2360659-1-hedi.berriche@hpe.com>
 <20201009034614.GB60852@otc-nc-03>
 <20201009040554.GB2365427@sarge.linuxathome.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20201009040554.GB2365427@sarge.linuxathome.me>
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-09_01:2020-10-09,2020-10-09 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 mlxscore=0 adultscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 priorityscore=1501 impostorscore=0 suspectscore=1 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010090027
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 09, 2020 at 05:09 Hedi Berriche wrote:
>On Fri, Oct 09, 2020 at 04:46 Raj, Ashok wrote:
>
>Hi Ashok,
>
>Thanks for looking into this.
>
>>On Fri, Oct 09, 2020 at 03:52:51AM +0100, Hedi Berriche wrote:
>>>Commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>>>changed pcie_do_recovery() so that status is updated with the return
>>>value from reset_link(); this was to fix the problem where we would
>>>wrongly report recovery failure, despite a successful reset_link(),
>>>whenever the initial error status is PCI_ERS_RESULT_DISCONNECT or
>>>PCI_ERS_RESULT_NO_AER_DRIVER.
>>>
>>>Unfortunately this breaks the flow of pcie_do_recovery() as it prevents
>>
>>What is the reference to "this breaks" above?
>
>The code change introduced by commit 6d2c89441571; would
>
>    "this code change" instead of "this breaks"
>
>work better? If not, I can also rephrase the whole paragraph along the following lines:
>
>Commit 6d2c89441571 ("PCI/ERR: Update error status after reset_link()") breaks the flow
>of pcie_do_recovery() as it prevents the actions needed when the initial error is
>PCI_ERS_RESULT_CAN_RECOVER or PCI_ERS_RESULT_NEED_RESET from taking place which causes
>error recovery to fail.
>
>... and do away with the first paragraph.
>
>>>the actions needed when the initial error is PCI_ERS_RESULT_CAN_RECOVER
>>>or PCI_ERS_RESULT_NEED_RESET from taking place which causes error
>>>recovery to fail.
>>>
>>>Don't clobber status after reset_link() to restore the intended flow in
>>>pcie_do_recovery().
>>>
>>>Fix the original problem by saving the return value from reset_link()
>>>and use it later on to decide whether error recovery should be deemed
>>>successful in the scenarios where the initial error status is
>>>PCI_ERS_RESULT_{DISCONNECT,NO_AER_DRIVER}.
>>
>>I would rather rephrase the above to make it clear what is being proposed.
>>Since the description seems to talk about the old problem and new solution
>>all mixed up.
>
>OK; will do that to clarify that what's being proposed here is:
>
>    1. fix the regression introduced by commit 6d2c89441571
>    2. address the problem that commit 6d2c89441571 aimed to fix
>
>>>Fixes: 6d2c89441571 ("PCI/ERR: Update error status after reset_link()")
>>>Signed-off-by: Hedi Berriche <hedi.berriche@hpe.com>
>>>Cc: Russ Anderson <rja@hpe.com>
>>>Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
>>>Cc: Bjorn Helgaas <bhelgaas@google.com>
>>>Cc: Ashok Raj <ashok.raj@intel.com>
>>>Cc: Keith Busch <keith.busch@intel.com>
>>>Cc: Joerg Roedel <jroedel@suse.com>
>>>
>>>Cc: stable@kernel.org # v5.7+
>>>---
>>> drivers/pci/pcie/err.c | 13 ++++++++++---
>>> 1 file changed, 10 insertions(+), 3 deletions(-)
>>>
>>>diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
>>>index c543f419d8f9..dbd0b56bd6c1 100644
>>>--- a/drivers/pci/pcie/err.c
>>>+++ b/drivers/pci/pcie/err.c
>>>@@ -150,7 +150,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>> 			pci_channel_state_t state,
>>> 			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
>>> {
>>>-	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
>>>+	pci_ers_result_t post_reset_status, status = PCI_ERS_RESULT_CAN_RECOVER;
>>
>>why call it post_reset_status?
>
>Perhaps post_reset_status is not a great choice; would reset_result or reset_link_result be better?

... or just do this with a boolean instead as I had it in an earlier iteration of the patch before I
eventually opted to use an pci_ers_result_t.

Cheers,
Hedi.
>
>Cheers,
>Hedi.
>
>>
>>> 	struct pci_bus *bus;
>>>
>>> 	/*
>>>@@ -165,8 +165,8 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>> 	pci_dbg(dev, "broadcast error_detected message\n");
>>> 	if (state == pci_channel_io_frozen) {
>>> 		pci_walk_bus(bus, report_frozen_detected, &status);
>>>-		status = reset_link(dev);
>>>-		if (status != PCI_ERS_RESULT_RECOVERED) {
>>>+		post_reset_status = reset_link(dev);
>>>+		if (post_reset_status != PCI_ERS_RESULT_RECOVERED) {
>>> 			pci_warn(dev, "link reset failed\n");
>>> 			goto failed;
>>> 		}
>>>@@ -174,6 +174,13 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
>>> 		pci_walk_bus(bus, report_normal_detected, &status);
>>> 	}
>>>
>>>+	if ((status == PCI_ERS_RESULT_DISCONNECT ||
>>>+	     status == PCI_ERS_RESULT_NO_AER_DRIVER) &&
>>>+	     post_reset_status == PCI_ERS_RESULT_RECOVERED) {
>>>+		/* error recovery succeeded thanks to reset_link() */
>>>+		status = PCI_ERS_RESULT_RECOVERED;
>>>+	}
>>>+
>>> 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
>>> 		status = PCI_ERS_RESULT_RECOVERED;
>>> 		pci_dbg(dev, "broadcast mmio_enabled message\n");
>>>--
>>>2.28.0
>>>
>
>-- 
>Be careful of reading health books, you might die of a misprint.
>	-- Mark Twain

-- 
Be careful of reading health books, you might die of a misprint.
	-- Mark Twain
