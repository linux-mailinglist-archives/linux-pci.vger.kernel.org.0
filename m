Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6B5414CB47
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jan 2020 14:15:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgA2NP5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jan 2020 08:15:57 -0500
Received: from mx2.suse.de ([195.135.220.15]:48188 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726177AbgA2NP5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Jan 2020 08:15:57 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2CFB8B278;
        Wed, 29 Jan 2020 13:15:55 +0000 (UTC)
Date:   Wed, 29 Jan 2020 14:15:52 +0100
From:   Libor Pechacek <lpechacek@suse.cz>
To:     Stuart Hayes <stuart.w.hayes@gmail.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Austin Bolen <austin_bolen@dell.com>,
        Keith Busch <keith.busch@intel.com>,
        Alexandru Gagniuc <mr.nuke.me@gmail.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        "Gustavo A . R . Silva" <gustavo@embeddedor.com>,
        Sinan Kaya <okaya@kernel.org>,
        Oza Pawandeep <poza@codeaurora.org>, linux-pci@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH v4 1/3] PCI: pciehp: Add support for disabling in-band
 presence
Message-ID: <20200129131530.GA3208@fm.suse.cz>
References: <20191025190047.38130-2-stuart.w.hayes@gmail.com>
 <20191127013613.GA233706@google.com>
 <CAL5oW00Lh4v2YpX2GcDoRS2fFJjvHRsdhNjtvyYGpWOpgL=TCg@mail.gmail.com>
 <f14d8325-8635-329f-cdc7-fd27a52b2704@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f14d8325-8635-329f-cdc7-fd27a52b2704@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue 31-12-19 16:06:45, Stuart Hayes wrote:
> On 11/26/19 8:19 PM, Stuart Hayes wrote:
> > On Tue, Nov 26, 2019 at 7:36 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
[...]
> >> I think I'm fine with this patch, but I would like to include the
> >> specific reference for this recommendation.  If you have it handy, I
> >> can just insert it.
> >>
> > 
> > The PCI Express Base Specification Revision 5.0, Version 1.0, in the
> > implementation note under Appendix I ("Async Hot-Plug Reference
> > Model"), it says "If OOB PD is being used and the associated DSP
> > supports In-Band PD Disable, it is recommended that the In-Band PD
> > Disable bit be Set, ..."
> > 
> > 
> 
> Is that what you were looking for?  Please let me know if there's anything
> else I can do to help.

Gentlemen,

I'm wondering about that is the status of this patch set. Reading through the
discussion, it looks to me that it has been accepted. However, I cannot find
the corresponding changes in Bjorn's Git tree.

I'm asking because we've got a request for including the patches in our distro
and I'd like to shepherd the changes there. Knowing if, and possibly also when,
the patch set will hit the repo would help me plan my actions. If, by any
chance, I can help here, let me know.

Thanks!

Libor
-- 
Libor Pechacek
SUSE Labs                                Remember to have fun...
