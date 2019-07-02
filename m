Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5DF75DA98
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 03:18:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfGCBST (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Jul 2019 21:18:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:59100 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727377AbfGCBSF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 2 Jul 2019 21:18:05 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75DB3218D9;
        Tue,  2 Jul 2019 21:39:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1562103594;
        bh=qg21pARqRrGiqzp8oVFATV/rRvwdeZy0ZvC+FpGJras=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AdDH7F2UwNKk7hs8XFn48mBnJYW3tekpy49ww101NDf6ClrVP8HVoVh9ZXMduwfGI
         4c9zuOtndSvhsQmRkGPnlQJT1IUNR1jMFyb0erLoU6mlKMKP/lZCGuiIKyloixILC7
         QSoakQtXMIafoY2n2pzNdlCTaF9hR/xp3U/7j5RQ=
Date:   Tue, 2 Jul 2019 16:39:51 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: Multitude of resource assignment functions
Message-ID: <20190702213951.GF128603@google.com>
References: <SL2P216MB01874DFDDBDE49B935A9B1B380E50@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e768271e-9455-2a3d-ad76-4a6d9c71d669@deltatee.com>
 <SL2P216MB01872DFDDA9C313CA43C7B3280E40@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <024eec86-dfb9-0a23-6385-9e8dfe9a0381@deltatee.com>
 <SL2P216MB0187340941F03A5A03625F4F80E10@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <442c6b35a1aab9833fd2942b499d4fb082a71a15.camel@kernel.crashing.org>
 <dc631e87-099f-3354-5477-b95e97e55d3f@deltatee.com>
 <SL2P216MB01875C9CB93E6B39846749B280FD0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
 <e2eec9dc-5eef-62ba-6251-f420d6579d03@deltatee.com>
 <SL2P216MB0187E659CFF6F9385E92838680FE0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SL2P216MB0187E659CFF6F9385E92838680FE0@SL2P216MB0187.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Jun 30, 2019 at 02:57:37AM +0000, Nicholas Johnson wrote:

> - Should pci=noacpi imply pci=nocrs? It does not appear to, and I feel 
> like it should, as CRS is part of ACPI and relates to PCI.

"pci=noacpi" means "Do not use ACPI for IRQ routing or for PCI
scanning."

"pci=nocrs" means "Ignore PCI host bridge windows from ACPI."  If we
ignore _CRS, we have no idea what the PCI host bridge apertures are,
so we cannot allocate resources for devices on the root bus.

The "Do not use ACPI for ... PCI scanning" part indeed does suggest
that "pci=noacpi" could imply "pci=nocrs", but I don't think there's
anything to be gained by changing that now.

We probably *should* remove "or for PCI scanning" from the
documentation, because "pci=noacpi" only affects IRQs.

The only reason these exist at all is as a debugging aid to
temporarily work around issues in firmware or Linux until we can
develop a real fix or quirk that works without the user specifying a
kernel parameter.

> - Does anybody know why with pci=noacpi, you get dmesg warnings about 
> cannot find PCI int A mapping - but they do not seem to cause the 
> devices any issues in functioning? Is it because they are using MSI?

I doubt it.  I think you're just lucky.  In general the information
from _PRT and _CRS is essential for correct operation.

> - Does pci=ignorefw sound good for a future proposal?

No, at least not without more description of what this would
accomplish.

It sounds like you would want this to turn off _PRT, _CRS, and other
information from ACPI.  You may not like ACPI, but that information is
there for good reason, and if we didn't get it from ACPI we would have
to get it from somewhere else.

There is always "acpi=off" if you just don't want ACPI at all.

Bjorn
