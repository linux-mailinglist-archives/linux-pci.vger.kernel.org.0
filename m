Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50B0D2B84F0
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 20:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726092AbgKRTdF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 14:33:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725947AbgKRTdE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 18 Nov 2020 14:33:04 -0500
Received: from localhost (129.sub-72-107-112.myvzw.com [72.107.112.129])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B23052225B;
        Wed, 18 Nov 2020 19:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605727984;
        bh=gDzooGw4/SrS1GfnVlMfA1o1rZNcQ5Gr93Abm/EVJ9U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=mzhCnQec1LNOarC3zNqY6xxfEoSh4hT5Aq9/DNLohnCYnpg7doakHwnKLyZ6wf7P5
         OuHhgu3s8VZY4LPbxFBD1CoOmuBMcADjCQc/iiP3/43QHlJ+y3857phQ03Ly/jNoEh
         l5gpTI7+XqFrHfP00zI3iJx4vuQtrWsDsuxWoUkE=
Date:   Wed, 18 Nov 2020 13:33:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Saheed Olayemi Bolarinwa <refactormyself@gmail.com>,
        linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH] PCI/DPC: Fix info->id initialization in
 dpc_process_error()
Message-ID: <20201118193301.GA75328@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f4c022a-a669-096c-d318-1e202c9eebbf@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 04, 2020 at 07:06:44PM -0800, Kuppuswamy, Sathyanarayanan wrote:
> On 10/31/20 3:01 AM, Saheed Olayemi Bolarinwa wrote:
> > From: "Saheed O. Bolarinwa" <refactormyself@gmail.com>
> > 
> > In the dpc_process_error() path, the error source ID is obtained
> > but not stored inside the aer_err_info object. So aer_print_error()
> > is not aware of the error source if it gets called.
> > 
> > Use the obtained valued to initialise info->id

> Is it useful for DPC case ? I don't think we set info->error_dev_num for
> DPC case right ?
> 
> if (info->id && info->error_dev_num > 1 && info->id == id)
>  726                 pci_err(dev, "  Error of this Agent is reported first\n");

It's true that we only assign to info->error_dev_num in aer.c.  That
looks like another defect.

We're passing "info" to aer_print_error() when both info->id and
info->error_dev_num are stack junk.

> > Signed-off-by: Saheed O. Bolarinwa <refactormyself@gmail.com>
> > ---
> >   drivers/pci/pcie/dpc.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> > index e05aba86a317..9f8698812939 100644
> > --- a/drivers/pci/pcie/dpc.c
> > +++ b/drivers/pci/pcie/dpc.c
> > @@ -223,6 +223,7 @@ void dpc_process_error(struct pci_dev *pdev)
> >   	else if (reason == 0 &&
> >   		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
> >   		 aer_get_device_error_info(pdev, &info)) {
> > +		info.id = source;
> >   		aer_print_error(pdev, &info);
> >   		pci_aer_clear_nonfatal_status(pdev);
> >   		pci_aer_clear_fatal_status(pdev);
> > 
> 
> -- 
> Sathyanarayanan Kuppuswamy
> Linux Kernel Developer
