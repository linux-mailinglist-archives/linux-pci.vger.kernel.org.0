Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 577F139DE5E
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jun 2021 16:10:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhFGOMZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Jun 2021 10:12:25 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:55782 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbhFGOMY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Jun 2021 10:12:24 -0400
Received: from imap.suse.de (imap-alt.suse-dmz.suse.de [192.168.254.47])
        (using TLSv1.2 with cipher ECDHE-ECDSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 98F7F21AA0;
        Mon,  7 Jun 2021 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623075032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yrrcDqwAUjI/Du1NgfJql1DxePl50i9q1z/v2S1/PjU=;
        b=yd+IGWFeVIzcWkH4CvAPf2cEyuzXDp4clwAPfcyvHi5LZW0PkbrpaSM/pPgQxXqShourjH
        UROju8kpwC5ucMYaLkUCY16/GW36p5+QtGgQJ3SvnGxXk95zvdcCIBZpiP76Y6L4pH08Zy
        ub2ZVCxIJeIxdDUCHfkshUbg7QOi2ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623075032;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yrrcDqwAUjI/Du1NgfJql1DxePl50i9q1z/v2S1/PjU=;
        b=5GCOfx0xyGHUY6Wh7ScIDhdgMv3eermx6Z1Jcx5JoRoC2w2vDh0jZ+4IOeymqA40G8FnJW
        TBxe0jyqUYPAakAQ==
Received: from imap3-int (imap-alt.suse-dmz.suse.de [192.168.254.47])
        by imap.suse.de (Postfix) with ESMTP id 4A7D8118DD;
        Mon,  7 Jun 2021 14:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1623075032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yrrcDqwAUjI/Du1NgfJql1DxePl50i9q1z/v2S1/PjU=;
        b=yd+IGWFeVIzcWkH4CvAPf2cEyuzXDp4clwAPfcyvHi5LZW0PkbrpaSM/pPgQxXqShourjH
        UROju8kpwC5ucMYaLkUCY16/GW36p5+QtGgQJ3SvnGxXk95zvdcCIBZpiP76Y6L4pH08Zy
        ub2ZVCxIJeIxdDUCHfkshUbg7QOi2ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1623075032;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yrrcDqwAUjI/Du1NgfJql1DxePl50i9q1z/v2S1/PjU=;
        b=5GCOfx0xyGHUY6Wh7ScIDhdgMv3eermx6Z1Jcx5JoRoC2w2vDh0jZ+4IOeymqA40G8FnJW
        TBxe0jyqUYPAakAQ==
Received: from director2.suse.de ([192.168.254.72])
        by imap3-int with ESMTPSA
        id lofQD9govmCrOwAALh3uQQ
        (envelope-from <jroedel@suse.de>); Mon, 07 Jun 2021 14:10:32 +0000
Date:   Mon, 7 Jun 2021 16:10:30 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>, rjw@rjwysocki.net,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI/APCI: Move acpi_pci_osc_support() check to
 negotiation phase
Message-ID: <YL4o1pJyIm74Lwz3@suse.de>
References: <20210603124814.19654-1-joro@8bytes.org>
 <20210603205047.GA2135380@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210603205047.GA2135380@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Bjorn,

On Thu, Jun 03, 2021 at 03:50:47PM -0500, Bjorn Helgaas wrote:
> On Thu, Jun 03, 2021 at 02:48:14PM +0200, Joerg Roedel wrote:

> If instead you mean that the OS has *not* been granted DPC control,
> but does _OSC(Query, SUPPORT=x, CONTROL=0), I think that means the OS
> is telling the platform what it supports but not requesting anything.
> That sounds legal to me, so if firmware complains about it, I would
> say it's a firmware problem.

I think it depends on how you look at it. The machine I was working with
has a BIOS setting where one can configure that DPC is controlled by the
OS. When it is configured that way, then the BIOS will issue an error
when an _OSC query is made with control set to 0. This is because it
indicates to the BIOS that the OS does not take control over DPC and
thus that the OS does not support it. The BIOS will issue a warning into
its log and when the Linux later takes control the warning is already
there.

> But please help me out if I'm misunderstanding something above.  I'm
> never confident that I really understand _OSC.

I am also not an _OSC expert, but you an Rafael already provided good
feedback on the necessity of at least one _OSC call, even when Linux
does not want to take control.

> Unrelated to *this* patch, but I don't understand the point of
> OSC_PCI_SUPPORT_MASKS and OSC_PCI_CONTROL_MASKS.  These are all
> internal static functions and it looks like pointless work to apply
> masks here and in acpi_pci_osc_control_set().

Okay, I will add a separate patch removing thos after this change.

> >  	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
> >  	if (ACPI_SUCCESS(status)) {
> 
> We can also drop the "if (control)" check inside the ACPI_SUCCESS()
> block, can't we?

Right, fixed that up.

Regards,

	Joerg

