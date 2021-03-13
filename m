Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1743339F64
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 18:12:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbhCMRMF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Mar 2021 12:12:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:59706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234174AbhCMRLm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 13 Mar 2021 12:11:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2C76864E2E;
        Sat, 13 Mar 2021 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615655501;
        bh=wP5rJWj91sCTtBjfV4gXU1J3V5urwcHzS4UHBgx1JTw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q8EBncD2Zgm+lBQ6vnQcma8UtNCUxMLf20FbAtR7/HSNNGB1oK1ATQS+C6Do1E7K4
         GDEh5EpmRgJRCAhK8xKlloZzB9N17Absrv7h1jkuQ8Y5JALiU04MK9zBtAVU9vwMAR
         B5imjpyagFVM2EK6jHxd7q+83+7kYZ/0UUtI3Lowivb/Qvh9vv343S92hIGgzJGGiW
         VEyMjca295zTpRW23tfbxljAqB2v6jaojPqSJvoKOJ40dAdybxeT3AvsUU1tvfx/Ng
         oNzKbB1vim6e4O+RAzdDRLkC/hR6Q/IPrnL+aYe5i7yi0O9TtovYymsXM0KRg2dmye
         NWjFnlthZ+PCA==
Date:   Sun, 14 Mar 2021 02:11:35 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     James Puthukattukaran <james.puthukattukaran@oracle.com>
Cc:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>
Subject: Re: pci_do_recovery not handling fata errors
Message-ID: <20210313171135.GA8648@redsun51.ssa.fujisawa.hgst.com>
References: <MN2PR10MB4093188B8CDC659AE68E5640996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
 <B2696632-CB84-420E-B072-044603A6D3B7@intel.com>
 <MN2PR10MB40933D5232D0F58ECAF4387D996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN2PR10MB40933D5232D0F58ECAF4387D996F9@MN2PR10MB4093.namprd10.prod.outlook.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 12, 2021 at 10:57:18PM +0000, James Puthukattukaran wrote:
> But the clearing of fatal error in the dpc_process_error is only for DPC trigger due to "unmaskable uncorrectable". 
> If the trigger reason is ERR_FATAL, then it does not hit the else clause and neither is it cleared in the pci_do_recovery code.

If the reason is ERR_FATAL, then the port didn't detect the error; it is
just the first DPC capable downstream port to receive the message from
some device downstream, so there's nothing to clear in its AER register.
 
> From dpc_process_error with more context -- 
> 
>        else if (reason == 0 &&  <<<<<<< only for "unmaskable uncorrectable". What about for ERR_FATAL?
>                  dpc_get_aer_uncorrect_severity(pdev, &info) &&
>                  aer_get_device_error_info(pdev, &info)) {
>                 aer_print_error(pdev, &info);
>                 pci_aer_clear_nonfatal_status(pdev);
>                 pci_aer_clear_fatal_status(pdev);
>         }
>  
> 
> > -----Original Message-----
> > From: Kelley, Sean V <sean.v.kelley@intel.com>
> > Sent: Friday, March 12, 2021 5:25 PM
> > To: James Puthukattukaran <james.puthukattukaran@oracle.com>;
> > Kuppuswamy, Sathyanarayanan
> > <sathyanarayanan.kuppuswamy@intel.com>
> > Cc: Linux PCI <linux-pci@vger.kernel.org>; bhelgaas@google.com
> > Subject: [External] : Re: pci_do_recovery not handling fata errors
> > 
> > 
> > 
> > > On Mar 12, 2021, at 12:56 PM, James Puthukattukaran
> > <james.puthukattukaran@oracle.com> wrote:
> > >
> > > Hi -
> > > I’m trying to understand why pci_do_recovery() only clears non-fatal but
> > not fata errors? My immediate concern is call from dpc_handler. If a device
> > sends an ERR_FATAL to the root port, I would think that as part of recovery
> > the fatal status in the AER registers of the endpoint device would be cleared?
> > >
> > 
> > 
> > Adding Sathya who mentioned to me that:
> > 
> > Fatal error are cleared in
> > 
> > void dpc_process_error(struct pci_dev *pdev)
> > 
> > 253                  dpc_get_aer_uncorrect_severity(pdev, &info) &&
> > 254                  aer_get_device_error_info(pdev, &info)) {
> > 255                 aer_print_error(pdev, &info);
> > 256                 pci_aer_clear_nonfatal_status(pdev);
> > 257                 pci_aer_clear_fatal_status(pdev);
> > 
> > Thanks,
> > 
> > Sean
> > 
> > > Snippet of concern in pci_do_recovery –
> > >
> > >         /*
> > >          * If we have native control of AER, clear error status in the Root
> > >          * Port or Downstream Port that signaled the error.  If the
> > >          * platform retained control of AER, it is responsible for clearing
> > >          * this status.  In that case, the signaling device may not even be
> > >          * visible to the OS.
> > >          */
> > >         if (host->native_aer || pcie_ports_native) {
> > >                 pcie_clear_device_status(bridge);
> > >                 pci_aer_clear_nonfatal_status(bridge);   <<<< Just clearing
> > nonfatal. What about fatal?
> > >         }
> > >
> > > Thanks
> > > James
> 
