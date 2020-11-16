Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213162B43D6
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 13:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727881AbgKPMhj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 07:37:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:48364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726097AbgKPMhi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 16 Nov 2020 07:37:38 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9A9A2224B;
        Mon, 16 Nov 2020 12:37:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605530258;
        bh=0kS8Uc7Er7SdxpAiM6lRVec4sOzXxKls7swHKqN78xY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sDV8cAFTc0QUtZGFzcifnkB+rLqxVrZt3OAjYgOz6f1u1TD88/JXEYp/6RvwXbmFx
         rQEdw2UXCJDzkURiQqHeZlC0m+GaiVIkZ7uBEyMElFWAHPSUslnReb4UzE8IlVoQ63
         ltxFS56FRi+u1X0Dd514BFavIeGdmvn8FBZ/hyK4=
Date:   Mon, 16 Nov 2020 06:37:35 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        johan@kernel.org, linux-usb@vger.kernel.org,
        alberto.vignani@fastwebnet.it
Subject: Re: [PATCH v2 1/2] PCI: Disable MSI for Pericom PCIe-USB adapter
Message-ID: <20201116123735.GA1273179@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201116094644.GP4077@smile.fi.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 16, 2020 at 11:46:44AM +0200, Andy Shevchenko wrote:
> On Fri, Nov 13, 2020 at 05:21:38PM -0600, Bjorn Helgaas wrote:
> > On Fri, Nov 06, 2020 at 12:05:25PM +0200, Andy Shevchenko wrote:
> > > Pericom PCIe-USB adapter advertises MSI, but documentation says
> > > "The MSI Function is not implemented on this device." in the chapters
> > > 7.3.27, 7.3.29-7.3.31.
> > > 
> > > Fixes: 306c54d0edb6 ("usb: hcd: Try MSI interrupts on PCI devices")
> > > Datasheet: https://www.diodes.com/assets/Datasheets/PI7C9X440SL.pdf
> > > Reported-by: alberto.vignani@fastwebnet.it
> > 
> > Is there a URL to a problem report we can include here?
> 
> You mean URL to email archives or something else?

Yes.  URL to lore email archive, bugzilla, or any other report of the
problem this caused, i.e., how Alberto noticed something wrong.
