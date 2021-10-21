Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76B54368AD
	for <lists+linux-pci@lfdr.de>; Thu, 21 Oct 2021 19:05:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231865AbhJURHd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Oct 2021 13:07:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:37136 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232209AbhJURHZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 Oct 2021 13:07:25 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 32DF2613B3;
        Thu, 21 Oct 2021 17:05:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634835909;
        bh=Mtct3V9y7jFFGgbR+ibjjD7+N+gDCqWxEZbjvas13mE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LGWfVvzcHqc8yQRJdodC7oDOcxJa32yTi9zRNrtDJvhOqGMa33dLI9a+bTB6H7xVF
         3NIyDQY/V5AjyMn0KbJ6Y3vzJ4/3zT0mNXb7IUaA6ac7bA/biJYzZ8WisOIonkmIW2
         pcIkW73ffcBFKh571ioLdytq1cKNVR50zmV2lqNVxI3bnDA57aHYZE4UxJxVHH+M0U
         Qgrp2YS3GjymAg2qWmq0xbWuyG4XvQVqlD36Xcx/4r6WIc45uQ9u+woEonta5J+uKD
         40EcCk+7QaQXGDAg9yysbvDvVBEavfT+E5Zd0kdII6HLOAnfv2mC0CES5d+3dL0NAl
         X7mnuyXpi0mSw==
Date:   Thu, 21 Oct 2021 12:05:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com, ruscur@russell.cc, oohall@gmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH v4 4/8] PCI/DPC: Use pci_aer_clear_status() in
 dpc_process_error()
Message-ID: <20211021170507.GA2701463@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211021163611.rsfmberxw6dqn5gx@theprophet>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 21, 2021 at 10:06:11PM +0530, Naveen Naidu wrote:
> On 20/10, Bjorn Helgaas wrote:
> > On Tue, Oct 05, 2021 at 10:48:11PM +0530, Naveen Naidu wrote:
> > > dpc_process_error() clears both AER fatal and non fatal status
> > > registers. Instead of clearing each status registers via a different
> > > function call use pci_aer_clear_status().
> > > 
> > > This helps clean up the code a bit.
> > > 
> > > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > > ---
> > >  drivers/pci/pcie/dpc.c | 3 +--
> > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > > index df3f3a10f8bc..faf4a1e77fab 100644
> > > --- a/drivers/pci/pcie/dpc.c
> > > +++ b/drivers/pci/pcie/dpc.c
> > > @@ -288,8 +288,7 @@ void dpc_process_error(struct pci_dev *pdev)
> > >  		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
> > >  		 aer_get_device_error_info(pdev, &info)) {
> > >  		aer_print_error(pdev, &info);
> > > -		pci_aer_clear_nonfatal_status(pdev);
> > > -		pci_aer_clear_fatal_status(pdev);
> > > +		pci_aer_clear_status(pdev);
> > 
> > The commit log suggests that this is a simple cleanup that doesn't
> > change any behavior, but that's not quite true:
> > 
> >   - The new code would clear PCI_ERR_ROOT_STATUS, but the old code
> >     does not.
> > 
> >   - The old code masks the status bits with the severity bits before
> >     clearing, but the new code does not.
> > 
> > The commit log needs to show why these changes are what we want.
> >
> 
> Reading through the code again, I realize how wrong(stupid) I was when
> making this patch. I was thinking that:
> 
>   pci_aer_clear_status() = pci_aer_clear_fatal_status() + pci_aer_clear_nonfatal_status()
> 
> Now I understand, that it is not at all the case. I apologize for the
> mistake. I'll make sure to be meticulous while reading functions and not
> just assume their behaviour just from their function names.

No problem, one could argue that the collection of pci_aer_clear_*()
functions that do slightly different things is itself a defect.
