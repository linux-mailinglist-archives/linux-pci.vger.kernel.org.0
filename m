Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9D841B6AF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 20:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242225AbhI1Swp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 14:52:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:25636 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230109AbhI1Swp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Sep 2021 14:52:45 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SHbbM3009168;
        Tue, 28 Sep 2021 14:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=Fo76ByiqeOHFiBPRaUB60vCUZ5ZTcNN8irtEceOnV3I=;
 b=A+7gJz9Hupkj6XEYcdMOTg6+FnM9VaisxT4UhoyyHXjX5OD0rphs7KeMS7pmoQ1YAiES
 s4Xp86O2UT6RqwCMYcyGI6m1ukc+veyI5xwD2+NEu0dUeBrCPL1JwZ1gd1W+mDMQfoIL
 cnCYkdB5Ir39mFmKJTS8+3vgKgHjeBq34lsO5KYPP5JzJ4lpA4ldLtCpMFAh0pUnhk6Y
 4V9roWV9lIU7whPabPUZt6Ixrzr5qgBVn6tIWxDOAeiso1PsEdojIVACXw04U/0FPaSd
 7MWBC84WvB45uF/oaV7acE1R5ZTIDIUne+dUUAUblg5iDG7BeujLGdWNC167vi/0W5hJ HQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bbktr2p1v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 14:51:03 -0400
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 18SIIBgd009501;
        Tue, 28 Sep 2021 14:51:02 -0400
Received: from ppma04ams.nl.ibm.com (63.31.33a9.ip4.static.sl-reverse.com [169.51.49.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3bbktr2p16-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 14:51:02 -0400
Received: from pps.filterd (ppma04ams.nl.ibm.com [127.0.0.1])
        by ppma04ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 18SInqnW032131;
        Tue, 28 Sep 2021 18:51:00 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma04ams.nl.ibm.com with ESMTP id 3b9ud9rq4s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Sep 2021 18:51:00 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 18SIouUV40305126
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Sep 2021 18:50:56 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6292F42054;
        Tue, 28 Sep 2021 18:50:56 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D63334203F;
        Tue, 28 Sep 2021 18:50:55 +0000 (GMT)
Received: from sig-9-145-32-211.uk.ibm.com (unknown [9.145.32.211])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 28 Sep 2021 18:50:55 +0000 (GMT)
Message-ID: <6f23b1e47cbfcd2782b0bd6a2703bbefc83580bb.camel@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] s390/pci: implement minimal PCI error recovery
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linas Vepstas <linasvepstas@gmail.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Date:   Tue, 28 Sep 2021 20:50:55 +0200
In-Reply-To: <20210928183919.GA716407@bhelgaas>
References: <20210928183919.GA716407@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-16.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QvZKkA4WnoCaU7iAW9DcMzS-DRVl7mva
X-Proofpoint-GUID: 2iZhRdVxxXB8ZzDO9HQm5jE-lb9gN4Xv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 mlxlogscore=999 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280109
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2021-09-28 at 13:39 -0500, Bjorn Helgaas wrote:
> On Tue, Sep 28, 2021 at 08:30:44PM +0200, Niklas Schnelle wrote:
> > On Tue, 2021-09-28 at 13:11 -0500, Bjorn Helgaas wrote:
> > > On Thu, Sep 16, 2021 at 11:33:36AM +0200, Niklas Schnelle wrote:
> > > > When the platform detects an error on a PCI function or a service action
> > > > has been performed it is put in the error state and an error event
> > > > notification is provided to the OS.
> > > > 
> > > > Currently we treat all error event notifications the same and simply set
> > > > pdev->error_state = pci_channel_io_perm_failure requiring user
> > > > intervention such as use of the recover attribute to get the device
> > > > usable again. Despite requiring a manual step this also has the
> > > > disadvantage that the device is completely torn down and recreated
> > > > resulting in higher level devices such as a block or network device
> > > > being recreated. In case of a block device this also means that it may
> > > > need to be removed and added to a software raid even if that could
> > > > otherwise survive with a temporary degradation.
> > > > 
> > > > This is of course not ideal more so since an error notification with PEC
> > > > 0x3A indicates that the platform already performed error recovery
> > > > successfully or that the error state was caused by a service action that
> > > > is now finished.
> > > > 
> > > > At least in this case we can assume that the error state can be reset
> > > > and the function made usable again. So as not to have the disadvantage
> > > > of a full tear down and recreation we need to coordinate this recovery
> > > > with the driver. Thankfully there is already a well defined recovery
> > > > flow for this described in Documentation/PCI/pci-error-recovery.rst.
> > > > 
> > > > The implementation of this is somewhat straight forward and simplified
> > > > by the fact that our recovery flow is defined per PCI function. As
> > > > a reset we use the newly introduced zpci_hot_reset_device() which also
> > > > takes the PCI function out of the error state.
> > > > 
> > > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > > ---
> > > > v1 -> v2:
> > > > - Dropped use of pci_dev_is_added(), pdev->driver check is enough
> > > > - Improved some comments and messages
> > > > 
> > > >  arch/s390/include/asm/pci.h |   4 +-
> > > >  arch/s390/pci/pci.c         |  49 ++++++++++
> > > >  arch/s390/pci/pci_event.c   | 182 +++++++++++++++++++++++++++++++++++-
> > > >  3 files changed, 233 insertions(+), 2 deletions(-)
> > > > 
> > > > diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> > > > index 2a2ed165a270..558877aff2e5 100644
> > > > --- a/arch/s390/include/asm/pci.h
> > > > +++ b/arch/s390/include/asm/pci.h
> > > > @@ -294,8 +294,10 @@ void zpci_debug_exit(void);
> > > >  void zpci_debug_init_device(struct zpci_dev *, const char *);
> > > >  void zpci_debug_exit_device(struct zpci_dev *);
> > > >  
> > > > -/* Error reporting */
> > > > +/* Error handling */
> > > >  int zpci_report_error(struct pci_dev *, struct zpci_report_error_header *);
> > > > +int zpci_clear_error_state(struct zpci_dev *zdev);
> > > > +int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
> > > >  
> > > >  #ifdef CONFIG_NUMA
> > > >  
> > > > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > > > index dce60f16e94a..b987c9d76510 100644
> > > > --- a/arch/s390/pci/pci.c
> > > > +++ b/arch/s390/pci/pci.c
> > > > @@ -954,6 +954,55 @@ int zpci_report_error(struct pci_dev *pdev,
> > > >  }
> > > >  EXPORT_SYMBOL(zpci_report_error);
> > > >  
> > > > +/**
> > > > + * zpci_clear_error_state() - Clears the zPCI error state of the device
> > > > + * @zdev: The zdev for which the zPCI error state should be reset
> > > > + *
> > > > + * Clear the zPCI error state of the device. If clearing the zPCI error state
> > > > + * fails the device is left in the error state. In this case it may make sense
> > > > + * to call zpci_io_perm_failure() on the associated pdev if it exists.
> > > > + *
> > > > + * Returns: 0 on success, -EIO otherwise
> > > > + */
> > > > +int zpci_clear_error_state(struct zpci_dev *zdev)
> > > > +{
> > > > +	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_RESET_ERROR);
> > > > +	struct zpci_fib fib = {0};
> > > > +	u8 status;
> > > > +	int rc;
> > > > +
> > > > +	rc = zpci_mod_fc(req, &fib, &status);
> > > > +	if (rc)
> > > > +		return -EIO;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * zpci_reset_load_store_blocked() - Re-enables L/S from error state
> > > > + * @zdev: The zdev for which to unblock load/store access
> > > > + *
> > > > + * R-eenables load/store access for a PCI function in the error state while
> > > > + * keeping DMA blocked. In this state drivers can poke MMIO space to determine
> > > > + * if error recovery is possible while catching any rogue DMA access from the
> > > > + * device.
> > > > + *
> > > > + * Returns: 0 on success, -EIO otherwise
> > > > + */
> > > > +int zpci_reset_load_store_blocked(struct zpci_dev *zdev)
> > > > +{
> > > > +	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_RESET_BLOCK);
> > > > +	struct zpci_fib fib = {0};
> > > > +	u8 status;
> > > > +	int rc;
> > > > +
> > > > +	rc = zpci_mod_fc(req, &fib, &status);
> > > > +	if (rc)
> > > > +		return -EIO;
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > >  static int zpci_mem_init(void)
> > > >  {
> > > >  	BUILD_BUG_ON(!is_power_of_2(__alignof__(struct zpci_fmb)) ||
> > > > diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> > > > index e868d996ec5b..73389e161872 100644
> > > > --- a/arch/s390/pci/pci_event.c
> > > > +++ b/arch/s390/pci/pci_event.c
> > > > @@ -47,15 +47,182 @@ struct zpci_ccdf_avail {
> > > >  	u16 pec;			/* PCI event code */
> > > >  } __packed;
> > > >  
> > > > +static inline bool ers_result_indicates_abort(pci_ers_result_t ers_res)
> > > > +{
> > > > +	switch (ers_res) {
> > > > +	case PCI_ERS_RESULT_CAN_RECOVER:
> > > > +	case PCI_ERS_RESULT_RECOVERED:
> > > > +	case PCI_ERS_RESULT_NEED_RESET:
> > > > +		return false;
> > > > +	default:
> > > > +		return true;
> > > > +	}
> > > > +}
> > > > +
> > > > +static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev)
> > > > +{
> > > > +	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
> > > > +	struct pci_driver *driver = pdev->driver;
> > > > +
> > > > +	pr_debug("%s: asking driver to determine recoverability\n", pci_name(pdev));
> > > > +	ers_res = driver->err_handler->error_detected(pdev,  pdev->error_state);
> > > > +	if (ers_result_indicates_abort(ers_res))
> > > > +		pr_info("%s: driver can't recover\n", pci_name(pdev));
> > > > +	else if (ers_res == PCI_ERS_RESULT_NEED_RESET)
> > > > +		pr_debug("%s: driver needs reset to recover\n", pci_name(pdev));
> > > 
> > > Are you following a convention of using pr_info(), etc here?  I try to
> > > use the pci_info() family (wrappers around dev_info()) whenever I can.
> > 
> > A convention in the sense that so far all code under arch/s390/pci/
> > uses pr_info()  which comes out as "zpci: ..". It seems that similar
> > pr_info() constructs are also common in other arch/s390/ and
> > drivers/s390 code.
> 
> That sounds like a convention to me.  As long as it exists, I would
> follow it.  Maybe somebody will decide someday to convert them all at
> once, but that would be a separate project.

I agree. I think this might make sense if/when we split the PCI
controller like parts off and move them to drivers/pci/. Thanks anyway
for the suggestion it's definitely something to keep in mind.

