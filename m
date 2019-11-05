Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C187FF09BD
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2019 23:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729747AbfKEWph (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Nov 2019 17:45:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:43216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728515AbfKEWph (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 5 Nov 2019 17:45:37 -0500
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BCF032084D;
        Tue,  5 Nov 2019 22:45:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572993937;
        bh=qeOzdpBEuDiMpmOSAKfNlmAzdojPQjaJa658ujJW01Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ImC0mSOmC6vylLQ+gWsAKnmAveVApQHZv4sRNnxQ/v24djZWBSl1wvQ3F6h/0jNz/
         fhOXV+aLrmo/Ltkw3sA4FoZx3I/jSjP/8bLVV0bTdGwpoks37GinbXtOBUbA3DCuT1
         2jk+JDE7NTHOE3KZVA/Qv9Ds8S2cH3HDUnYhAZ+g=
Date:   Wed, 6 Nov 2019 07:45:29 +0900
From:   Keith Busch <kbusch@kernel.org>
To:     "Derrick, Jonathan" <jonathan.derrick@intel.com>
Cc:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "Paszkiewicz, Artur" <artur.paszkiewicz@intel.com>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "Fugate, David" <david.fugate@intel.com>,
        "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Busch, Keith" <keith.busch@intel.com>
Subject: Re: [PATCH 2/3] PCI: vmd: Expose VMD details from BIOS
Message-ID: <20191105224529.GA1443@redsun51.ssa.fujisawa.hgst.com>
References: <20191101215302.GA217821@google.com>
 <5c4521d26f45cfe01631d14c3d7edc9a10f99245.camel@intel.com>
 <20191104180700.GB26409@e121166-lin.cambridge.arm.com>
 <20191105101208.GA21113@e121166-lin.cambridge.arm.com>
 <5a87add6071259c45522001648b29c9e597ebd69.camel@intel.com>
 <20191105222247.GA890@redsun51.ssa.fujisawa.hgst.com>
 <e576c1081dbb05aa5931215a9ea684a40c094b6a.camel@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e576c1081dbb05aa5931215a9ea684a40c094b6a.camel@intel.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 10:38:05PM +0000, Derrick, Jonathan wrote:
> On Wed, 2019-11-06 at 07:22 +0900, Keith Busch wrote:
> > On Tue, Nov 05, 2019 at 09:32:07PM +0000, Derrick, Jonathan wrote:
> > > Without this patch, a /dev/mem, resource0, or third-party driver could
> > > overwrite these values if they don't also restore them on close/unbind.
> > > I imagine a kexec user would also overwrite these values.
> > 
> > Don't you have the same problem with the in-kernel driver? It
> > looks like pci core will clear the PCI_IO_BASE config registers in
> > pci_setup_bridge_io() because VMD doesn't provide an IORESOURCE_IO
> > resource. If you reload the driver, it'll read the wrong values on the
> > second probing.
> 
> Is there a corner case I am missing with patch 3/3 that restores on
> unload?

Nothing wrong with that. I just hadn't read that far :/
