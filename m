Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAD441B673
	for <lists+linux-pci@lfdr.de>; Tue, 28 Sep 2021 20:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhI1SlB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Sep 2021 14:41:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:46534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230095AbhI1SlB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 28 Sep 2021 14:41:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2A16160F9D;
        Tue, 28 Sep 2021 18:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632854361;
        bh=jvbn6ZFxjCfma38b/vyndAGQTEngi9bv2Mbj2/OPw+o=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=TtOLxyIhP8Qg+oRJj5meNYt5+TvS5epOVefzqiPW9PAnOvxhu/w1YK+GLBT3pJq8A
         CloudKe9UQDsOSCqcELQzVotH5l011dIZTfN1VeAXUSA7O3qTZcUkWr0yOrylxEqL5
         i3Icru+zGAK6Ywpwi/Ezf2HHWAHJeDolAAJMhmUG5bzTMRa0rBkAsKtYR3bSig2nK1
         cGmp1V3EVDDIyMcPicvV/V7pRyVKzVF90JAjDIBynvEuW2QIoucY1JRn4oduQXhO2K
         VrwSR/tYra8xwxr2SL406JZNEoU6zmieOQcFMxi6EFyPk2JUlMetASkax1cRkN04Ju
         fYN6M8VQGlMVA==
Date:   Tue, 28 Sep 2021 13:39:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Linas Vepstas <linasvepstas@gmail.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-pci@vger.kernel.org, Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>
Subject: Re: [PATCH v2 4/4] s390/pci: implement minimal PCI error recovery
Message-ID: <20210928183919.GA716407@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <efdab70e1050e2f7a7d7e7c5983c0eef794d9181.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 28, 2021 at 08:30:44PM +0200, Niklas Schnelle wrote:
> On Tue, 2021-09-28 at 13:11 -0500, Bjorn Helgaas wrote:
> > On Thu, Sep 16, 2021 at 11:33:36AM +0200, Niklas Schnelle wrote:
> > > When the platform detects an error on a PCI function or a service action
> > > has been performed it is put in the error state and an error event
> > > notification is provided to the OS.
> > > 
> > > Currently we treat all error event notifications the same and simply set
> > > pdev->error_state = pci_channel_io_perm_failure requiring user
> > > intervention such as use of the recover attribute to get the device
> > > usable again. Despite requiring a manual step this also has the
> > > disadvantage that the device is completely torn down and recreated
> > > resulting in higher level devices such as a block or network device
> > > being recreated. In case of a block device this also means that it may
> > > need to be removed and added to a software raid even if that could
> > > otherwise survive with a temporary degradation.
> > > 
> > > This is of course not ideal more so since an error notification with PEC
> > > 0x3A indicates that the platform already performed error recovery
> > > successfully or that the error state was caused by a service action that
> > > is now finished.
> > > 
> > > At least in this case we can assume that the error state can be reset
> > > and the function made usable again. So as not to have the disadvantage
> > > of a full tear down and recreation we need to coordinate this recovery
> > > with the driver. Thankfully there is already a well defined recovery
> > > flow for this described in Documentation/PCI/pci-error-recovery.rst.
> > > 
> > > The implementation of this is somewhat straight forward and simplified
> > > by the fact that our recovery flow is defined per PCI function. As
> > > a reset we use the newly introduced zpci_hot_reset_device() which also
> > > takes the PCI function out of the error state.
> > > 
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > > v1 -> v2:
> > > - Dropped use of pci_dev_is_added(), pdev->driver check is enough
> > > - Improved some comments and messages
> > > 
> > >  arch/s390/include/asm/pci.h |   4 +-
> > >  arch/s390/pci/pci.c         |  49 ++++++++++
> > >  arch/s390/pci/pci_event.c   | 182 +++++++++++++++++++++++++++++++++++-
> > >  3 files changed, 233 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/arch/s390/include/asm/pci.h b/arch/s390/include/asm/pci.h
> > > index 2a2ed165a270..558877aff2e5 100644
> > > --- a/arch/s390/include/asm/pci.h
> > > +++ b/arch/s390/include/asm/pci.h
> > > @@ -294,8 +294,10 @@ void zpci_debug_exit(void);
> > >  void zpci_debug_init_device(struct zpci_dev *, const char *);
> > >  void zpci_debug_exit_device(struct zpci_dev *);
> > >  
> > > -/* Error reporting */
> > > +/* Error handling */
> > >  int zpci_report_error(struct pci_dev *, struct zpci_report_error_header *);
> > > +int zpci_clear_error_state(struct zpci_dev *zdev);
> > > +int zpci_reset_load_store_blocked(struct zpci_dev *zdev);
> > >  
> > >  #ifdef CONFIG_NUMA
> > >  
> > > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > > index dce60f16e94a..b987c9d76510 100644
> > > --- a/arch/s390/pci/pci.c
> > > +++ b/arch/s390/pci/pci.c
> > > @@ -954,6 +954,55 @@ int zpci_report_error(struct pci_dev *pdev,
> > >  }
> > >  EXPORT_SYMBOL(zpci_report_error);
> > >  
> > > +/**
> > > + * zpci_clear_error_state() - Clears the zPCI error state of the device
> > > + * @zdev: The zdev for which the zPCI error state should be reset
> > > + *
> > > + * Clear the zPCI error state of the device. If clearing the zPCI error state
> > > + * fails the device is left in the error state. In this case it may make sense
> > > + * to call zpci_io_perm_failure() on the associated pdev if it exists.
> > > + *
> > > + * Returns: 0 on success, -EIO otherwise
> > > + */
> > > +int zpci_clear_error_state(struct zpci_dev *zdev)
> > > +{
> > > +	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_RESET_ERROR);
> > > +	struct zpci_fib fib = {0};
> > > +	u8 status;
> > > +	int rc;
> > > +
> > > +	rc = zpci_mod_fc(req, &fib, &status);
> > > +	if (rc)
> > > +		return -EIO;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +/**
> > > + * zpci_reset_load_store_blocked() - Re-enables L/S from error state
> > > + * @zdev: The zdev for which to unblock load/store access
> > > + *
> > > + * R-eenables load/store access for a PCI function in the error state while
> > > + * keeping DMA blocked. In this state drivers can poke MMIO space to determine
> > > + * if error recovery is possible while catching any rogue DMA access from the
> > > + * device.
> > > + *
> > > + * Returns: 0 on success, -EIO otherwise
> > > + */
> > > +int zpci_reset_load_store_blocked(struct zpci_dev *zdev)
> > > +{
> > > +	u64 req = ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_RESET_BLOCK);
> > > +	struct zpci_fib fib = {0};
> > > +	u8 status;
> > > +	int rc;
> > > +
> > > +	rc = zpci_mod_fc(req, &fib, &status);
> > > +	if (rc)
> > > +		return -EIO;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  static int zpci_mem_init(void)
> > >  {
> > >  	BUILD_BUG_ON(!is_power_of_2(__alignof__(struct zpci_fmb)) ||
> > > diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> > > index e868d996ec5b..73389e161872 100644
> > > --- a/arch/s390/pci/pci_event.c
> > > +++ b/arch/s390/pci/pci_event.c
> > > @@ -47,15 +47,182 @@ struct zpci_ccdf_avail {
> > >  	u16 pec;			/* PCI event code */
> > >  } __packed;
> > >  
> > > +static inline bool ers_result_indicates_abort(pci_ers_result_t ers_res)
> > > +{
> > > +	switch (ers_res) {
> > > +	case PCI_ERS_RESULT_CAN_RECOVER:
> > > +	case PCI_ERS_RESULT_RECOVERED:
> > > +	case PCI_ERS_RESULT_NEED_RESET:
> > > +		return false;
> > > +	default:
> > > +		return true;
> > > +	}
> > > +}
> > > +
> > > +static pci_ers_result_t zpci_event_notify_error_detected(struct pci_dev *pdev)
> > > +{
> > > +	pci_ers_result_t ers_res = PCI_ERS_RESULT_DISCONNECT;
> > > +	struct pci_driver *driver = pdev->driver;
> > > +
> > > +	pr_debug("%s: asking driver to determine recoverability\n", pci_name(pdev));
> > > +	ers_res = driver->err_handler->error_detected(pdev,  pdev->error_state);
> > > +	if (ers_result_indicates_abort(ers_res))
> > > +		pr_info("%s: driver can't recover\n", pci_name(pdev));
> > > +	else if (ers_res == PCI_ERS_RESULT_NEED_RESET)
> > > +		pr_debug("%s: driver needs reset to recover\n", pci_name(pdev));
> > 
> > Are you following a convention of using pr_info(), etc here?  I try to
> > use the pci_info() family (wrappers around dev_info()) whenever I can.
> 
> A convention in the sense that so far all code under arch/s390/pci/
> uses pr_info()  which comes out as "zpci: ..". It seems that similar
> pr_info() constructs are also common in other arch/s390/ and
> drivers/s390 code.

That sounds like a convention to me.  As long as it exists, I would
follow it.  Maybe somebody will decide someday to convert them all at
once, but that would be a separate project.

> On the other hand we already agreed that some of the s390 specific PCI
> code is more like a PCI controller. So I'm open to suggestions.
> 
