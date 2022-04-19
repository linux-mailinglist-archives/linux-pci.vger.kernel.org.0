Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6173350714B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Apr 2022 17:06:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351960AbiDSPGb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Apr 2022 11:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352313AbiDSPGa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Apr 2022 11:06:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7273393E3;
        Tue, 19 Apr 2022 08:03:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EEBD615A3;
        Tue, 19 Apr 2022 15:03:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D38C385BB;
        Tue, 19 Apr 2022 15:03:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650380626;
        bh=2QAhuc2XWcc3cQISqAxXYVsD0D9u3Zzv0U665e9wblg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=sH1xvpevcqmRCg1FQs9IreiBFSyKwR9KorOvczKSfsvKZO7JGQBU8RSWYJxInjJUu
         aJf/p8r9ijLvNlXeoY517zB6xvdx5upsf50wP3LqXQC4anvduDfEH6789kmOrmHtyV
         T5ArVtogHhSLnz2Pwmm/nvIyf6YoALuaWLHJAwl2wepbhlk9T6H0v/GUYRK/A5UPri
         Xu37ZyCt2GzgaltOoY8YxFRaUWCtyebFlC12zaLez0zG2Bf66Md7rVha4m7YXd16kw
         kkLB1wf308TXgd5ocdZjKf43CtD7hM/3yiQUvLhym6/eIWI8yIUtm/pR9OgssQ7gwu
         A7+M2sRQwXkng==
Date:   Tue, 19 Apr 2022 10:03:44 -0500
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
Message-ID: <20220419150344.GA1198281@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d75ede81-49da-855a-6679-c3315089e067@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 19, 2022 at 11:59:17AM +0200, Hans de Goede wrote:
> On 1/1/70 01:00, Bjorn Helgaas wrote:
> > This is still work-in-progress on the issue of PNP0A03 _CRS methods that
> > are buggy or not interpreted correctly by Linux.
> > 
> > The previous try at:
> >   https://lore.kernel.org/r/20220304035110.988712-1-helgaas@kernel.org
> > caused regressions on some Chromebooks:
> >   https://lore.kernel.org/r/Yjyv03JsetIsTJxN@sirena.org.uk
> > 
> > This v2 drops the commit that caused the Chromebook regression, so it also
> > doesn't fix the issue we were *trying* to fix on Lenovo Yoga and Clevo
> > Barebones.
> > 
> > The point of this v2 update is to split the logging patch into (1) a pure
> > logging addition and (2) the change to only clip PCI windows, which was
> > previously hidden inside the logging patch and not well documented.
> > 
> > Bjorn Helgaas (3):
> >   x86/PCI: Eliminate remove_e820_regions() common subexpressions
> >   x86: Log resource clipping for E820 regions
> >   x86/PCI: Clip only host bridge windows for E820 regions
> 
> Thanks, the entire series looks good to me:
> 
> Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Thank you!

> So what is the plan to actually fix the issue seen on some Lenovo models
> and Clevo Barebones ?   As I mentioned previously I think that since all
> our efforts have failed so far that we should maybe reconsider just
> using DMI quirks to ignore the E820 reservation windows for host bridges
> on affected models ?

I have been resisting DMI quirks but I'm afraid there's no other way.
I think the web we've gotten into, where vendors have used E820 to
interact with _CRS in incompatible and undocumented ways, is not
sustainable.

I'm not aware of any spec that says the OS should use E820 to clip
things out of _CRS, so I think the long term plan should be to
decouple them by default.

Straw man:

  - Disable E820 clipping by default.

  - Add a quirk to enable E820 clipping for machines older than X,
    e.g., 2023, to avoid breaking machines that currently work.

  - Add quirks to disable E820 clipping for individual machines like
    the Lenovo and Clevos that predate X, but E820 clipping breaks
    them.

  - Add quirks to enable E820 clipping for individual machines like
    the Chromebooks (and probably machines we don't know about yet)
    that have devices that consume part of _CRS but are not
    enumerable.

  - Communicate this to OEMs to try to prevent future machines that
    need quirks.

Bjorn
