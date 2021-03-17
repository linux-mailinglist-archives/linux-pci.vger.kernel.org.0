Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0591F33F976
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 20:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbhCQTkP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 15:40:15 -0400
Received: from bmailout2.hostsharing.net ([83.223.78.240]:42699 "EHLO
        bmailout2.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbhCQTkK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 15:40:10 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id C1CA02800B3C3;
        Wed, 17 Mar 2021 20:40:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id B5EA4107323; Wed, 17 Mar 2021 20:40:09 +0100 (CET)
Date:   Wed, 17 Mar 2021 20:40:09 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     "Raj, Ashok" <ashok.raj@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Sathyanarayanan Kuppuswamy Natarajan 
        <sathyanarayanan.nkuppuswamy@gmail.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>, knsathya@kernel.org,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: pciehp: Skip DLLSC handling if DPC is
 triggered
Message-ID: <20210317194009.GA9515@wunner.de>
References: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
 <20210317041342.GA19198@wunner.de>
 <CAPcyv4jxTcUEgcfPRckHqrUPy8gR7ZJsxDaeU__pSq6PqJERAQ@mail.gmail.com>
 <20210317053114.GA32370@wunner.de>
 <CAPcyv4j8t4Y=kpRSvOjOfVHd107YemiRcW0BNQRwp-d9oCddUw@mail.gmail.com>
 <CAC41dw8sX4T-FrwBju2H3TbjDhJMLGw_KHqs+20qzvKU1b5QTA@mail.gmail.com>
 <CAPcyv4gfBTuEj494aeg0opeL=PSbk_Cs16fX7A-cLvSV6EZg-Q@mail.gmail.com>
 <20210317190952.GB27146@wunner.de>
 <20210317192241.GE52280@otc-nc-03>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317192241.GE52280@otc-nc-03>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 17, 2021 at 12:22:41PM -0700, Raj, Ashok wrote:
> On Wed, Mar 17, 2021 at 08:09:52PM +0100, Lukas Wunner wrote:
> > On Wed, Mar 17, 2021 at 10:45:21AM -0700, Dan Williams wrote:
> > > Ah, ok, we're missing a flush of the hotplug event handler after the
> > > link is up to make sure the hotplug handler does not see the Link Up.
> > > I'm not immediately seeing how the new proposal ensures that there is
> > > no Link Up event still in flight after DPC completes its work.
> > > Wouldn't it be required to throw away Link Up to Link Up transitions?
> > 
> > If you look at the new code added to pciehp_ist() by my patch...
> > 
> >       atomic_and(~PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
> >       if (pciehp_check_link_active(ctrl) > 0)
> >               events &= ~PCI_EXP_SLTSTA_DLLSC;
> 
> When you have a Surprise Link Down and without any DPC, the link trains
> back up. Aren't we expected to take the slot down and add it as if a remove
> and add happens?
> 
> without this change if slot-status == ON_STATE, DLLSC means we would power
> the slot off. Then we check link_active and bring the slot back on isn't
> it?

Yes to both questions.  That behavior should still be the same
with the patch.  Do you think it's not?
