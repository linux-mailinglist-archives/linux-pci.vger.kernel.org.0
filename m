Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95255507583
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 18:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349428AbiDSQuV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 12:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352873AbiDSQsU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 12:48:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB47EA1BF;
        Tue, 19 Apr 2022 09:45:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4862461883;
        Tue, 19 Apr 2022 16:45:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6748FC385A7;
        Tue, 19 Apr 2022 16:45:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650386728;
        bh=G0OvqP43pBlucS2bwhbAfQlIUn2CHJUI1Pp798ChPPw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jhhGUe+s0QSuW058hOTgQRDXlLp07EUc0RpaIWBYFIkUe/WP3XBJhga9Ehm7dXgJz
         VPVoU+3Qox99raGnuwwt+IMRCxX6x1G9enBw9BB7m5wUCCGckdk/mc+UOzL9dgwUMt
         ji1s62SkIYKv9d+tyu2Tl878AV2ArQbwR/Nznr6E0P1kqtLdt1cDEMCvBJU285cyIS
         2kvJTr+fBiw63HkIiFrp79WZUVxFQlbfZ7Dpy82rlclnMwH9jMtqg5Wih8dKJwjvyG
         voxxODzyRe3U7c1GdW+MD5woPipjVGr8Kl7ulS4/SvhXnQrZDtilz8w1EZxoxq5uAX
         3396mF+8umvEw==
Date:   Tue, 19 Apr 2022 11:45:26 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Myron Stowe <myron.stowe@redhat.com>,
        Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Hui Wang <hui.wang@canonical.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 0/3] x86/PCI: Log E820 clipping
Message-ID: <20220419164526.GA1204065@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fa9afde-5cc4-2e5d-30ac-ccc6ff4c8039@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 19, 2022 at 05:16:44PM +0200, Hans de Goede wrote:
> Hi,
> 
> On 4/19/22 17:03, Bjorn Helgaas wrote:
> > On Tue, Apr 19, 2022 at 11:59:17AM +0200, Hans de Goede wrote:
> >> On 1/1/70 01:00, Bjorn Helgaas wrote:
> >>> This is still work-in-progress on the issue of PNP0A03 _CRS methods that
> >>> are buggy or not interpreted correctly by Linux.
> >>>
> >>> The previous try at:
> >>>   https://lore.kernel.org/r/20220304035110.988712-1-helgaas@kernel.org
> >>> caused regressions on some Chromebooks:
> >>>   https://lore.kernel.org/r/Yjyv03JsetIsTJxN@sirena.org.uk
> >>>
> >>> This v2 drops the commit that caused the Chromebook regression, so it also
> >>> doesn't fix the issue we were *trying* to fix on Lenovo Yoga and Clevo
> >>> Barebones.
> >>>
> >>> The point of this v2 update is to split the logging patch into (1) a pure
> >>> logging addition and (2) the change to only clip PCI windows, which was
> >>> previously hidden inside the logging patch and not well documented.
> >>>
> >>> Bjorn Helgaas (3):
> >>>   x86/PCI: Eliminate remove_e820_regions() common subexpressions
> >>>   x86: Log resource clipping for E820 regions
> >>>   x86/PCI: Clip only host bridge windows for E820 regions
> >>
> >> Thanks, the entire series looks good to me:
> >>
> >> Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Thank you!
> > 
> >> So what is the plan to actually fix the issue seen on some Lenovo models
> >> and Clevo Barebones ?   As I mentioned previously I think that since all
> >> our efforts have failed so far that we should maybe reconsider just
> >> using DMI quirks to ignore the E820 reservation windows for host bridges
> >> on affected models ?
> > 
> > I have been resisting DMI quirks but I'm afraid there's no other way.
> 
> Well there is the first match adjacent windows returned by _CRS and
> only then do the "covers whole region" exception check. I still
> think that would work at least for the chromebook regression...

Without a crystal clear strategy, I think we're going to be tweaking
the algorithm forever as the _CRS/E820 mix changes.  That's why I
think that in the long term, a "use _CRS only, with quirks for
exceptions" strategy will be simplest.

> So do you want me to give that a try; or shall I write a patch
> using DMI quirks. And if we go the DMI quirks, what about
> matching cmdline arguments?  If we add matching cmdline arguments,
> which seems to be the sensible thing to do then to allow users
> to test if they need the quirk, then we basically end up with my
> first attempt at fixing this from 6 months ago:
> 
> https://lore.kernel.org/linux-pci/20211005150956.303707-1-hdegoede@redhat.com/

So I think we should go ahead with DMI quirks instead of trying to
make the algorithm smarter, and yes, I think we will need commandline
arguments, probably one to force E820 clipping for future machines,
and one to disable it for old machines.

> > I think the web we've gotten into, where vendors have used E820 to
> > interact with _CRS in incompatible and undocumented ways, is not
> > sustainable.
> > 
> > I'm not aware of any spec that says the OS should use E820 to clip
> > things out of _CRS, so I think the long term plan should be to
> > decouple them by default.
> 
> Right and AFAICT the reason Windows is getting away with this is
> the same as with the original Dell _CRS has overlap with
> physical RAM issue (1), Linux assigns address to unassigneds BAR-s
> starting with the lowest available address in the bridge window,
> where as Windows assigns addresses from the highest available
> address in the window.

Right, I agree.  I'm guessing Chromebooks don't get tested with
Windows at all, so we don't even have that level of testing to help.

> So the real fix here might very well be
> to rework the BAR assignment code to switch to fill the window
> from the top rather then from the bottom. AFAICT all issues where
> excluding _E820 reservations have helped are with _E820 - bridge
> window overlaps at the bottom of the window.
> 
> IOW these are really all bugs in the _CRS method for the bridge,
> which Windows does not hit because it never actually uses
> the lowest address(es) of the _CRS returned window.

Yes.  We actually did try this
(https://git.kernel.org/linus/1af3c2e45e7a), but unfortunately we had
to revert it.  Even more unfortunately, the revert
(https://git.kernel.org/linus/5e52f1c5e85f) doesn't have any details
about what went wrong.

> 1) At least I read in either a bugzilla, or email thread about
> this that Windows allocating bridge window space from the top
> was assumed to be why Windows was not impacted.
> 
> > Straw man:
> > 
> >   - Disable E820 clipping by default.
> > 
> >   - Add a quirk to enable E820 clipping for machines older than X,
> >     e.g., 2023, to avoid breaking machines that currently work.
> > 
> >   - Add quirks to disable E820 clipping for individual machines like
> >     the Lenovo and Clevos that predate X, but E820 clipping breaks
> >     them.
> > 
> >   - Add quirks to enable E820 clipping for individual machines like
> >     the Chromebooks (and probably machines we don't know about yet)
> >     that have devices that consume part of _CRS but are not
> >     enumerable.
> > 
> >   - Communicate this to OEMs to try to prevent future machines that
> >     need quirks.
> > 
> > Bjorn
> > 
> 
