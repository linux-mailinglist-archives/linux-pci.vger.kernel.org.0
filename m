Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66B2117C331
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 17:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726579AbgCFQmB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 11:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:41534 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726178AbgCFQmB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 11:42:01 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 785572073D;
        Fri,  6 Mar 2020 16:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583512920;
        bh=DStAMwpUFKCJjVHMSmPwm1TPMEHOzo1D99MN2bb/uMo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HUXQp/mrePRhxF0ttHn34h8iL7Oylz99OR1/AuNhuBJlq61yPLaR9rz2v4fAa8jxI
         VVXxEnzdt5ZJWzQRRYwNwo8krFPuY3gxm93QZ/IhyEaYtkbfqFy7PzOKHMwN3Kgriv
         NLgUqrC1Av/IJ4Pymgcrm9Vhc/n/Jxc5b6ccFVok=
Date:   Fri, 6 Mar 2020 10:41:57 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com
Subject: Re: [PATCH v17 09/12] PCI/AER: Allow clearing Error Status Register
 in FF mode
Message-ID: <20200306164157.GA175224@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ee591afe-f022-9152-9c6f-34fe9987077e@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 06, 2020 at 08:11:41AM -0800, Kuppuswamy, Sathyanarayanan wrote:
> On 3/6/2020 8:04 AM, Bjorn Helgaas wrote:
> > On Thu, Mar 05, 2020 at 09:45:46PM -0800, Kuppuswamy, Sathyanarayanan wrote:
> > > On 3/3/2020 6:36 PM, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> > > > From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > 
> > > > As per PCI firmware specification r3.2 System Firmware Intermediary
> > > > (SFI) _OSC and DPC Updates ECR
> > > > (https://members.pcisig.com/wg/PCI-SIG/document/13563), sec titled "DPC
> > > > Event Handling Implementation Note", page 10, Error Disconnect Recover
> > > > (EDR) support allows OS to handle error recovery and clearing Error
> > > > Registers even in FF mode. So create new API pci_aer_raw_clear_status()
> > > > which allows clearing AER registers without FF mode checks.
> > > > 
> > > > Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> > > > ---
> > > >    drivers/pci/pci.h      |  2 ++
> > > >    drivers/pci/pcie/aer.c | 22 ++++++++++++++++++----
> > > >    2 files changed, 20 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > index e57e78b619f8..c239e6dd2542 100644
> > > > --- a/drivers/pci/pci.h
> > > > +++ b/drivers/pci/pci.h
> > > > @@ -655,6 +655,7 @@ extern const struct attribute_group aer_stats_attr_group;
> > > >    void pci_aer_clear_fatal_status(struct pci_dev *dev);
> > > >    void pci_aer_clear_device_status(struct pci_dev *dev);
> > > >    int pci_cleanup_aer_error_status_regs(struct pci_dev *dev);
> > > > +int pci_aer_raw_clear_status(struct pci_dev *dev);
> > > >    #else
> > > >    static inline void pci_no_aer(void) { }
> > > >    static inline void pci_aer_init(struct pci_dev *d) { }
> > > > @@ -665,6 +666,7 @@ static inline int pci_cleanup_aer_error_status_regs(struct pci_dev *dev)
> > > >    {
> > > >    	return -EINVAL;
> > > >    }
> > > > +int pci_aer_raw_clear_status(struct pci_dev *dev) { return -EINVAL; }
> > 
> > > It's missing static specifier. It needs to be fixed. I can fix it in
> > > next version.  Bjorn, if there is no need for next version, can you
> > > please make this change?
> > 
> > pci_aer_raw_clear_status() is defined in aer.c and called from aer.c
> > and edr.c, so I do not think it can be static.  Am I missing
> > something?

> For kernel configs that does not define CONFIG_PCIEAER, it will create
> redefinition error since pci.h can be included in many files.

Oh, right, I thought you were talking about the definition in aer.c.
The stub in pci.h is missing "inline" as well as "static".

Fixed.
