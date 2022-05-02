Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1FD6517828
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 22:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387406AbiEBUfk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 16:35:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350516AbiEBUfk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 16:35:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C31B1E2;
        Mon,  2 May 2022 13:32:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E657660B00;
        Mon,  2 May 2022 20:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFB14C385A4;
        Mon,  2 May 2022 20:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651523528;
        bh=xyHnevJ0bkGZ99FU3xXECPdssgskXtwRkKrhR/D9hOk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MQtRi7FlqJJpVvSQnmizAN4fk541RLiiKL8fVIjFlJTtJlV43GsqRvatoB40sjtnz
         NuAyDcsgB85FayQ1smVmZJHW5xINveJYIrYEHX0OrSKzaAQZPoxf7fUrzkTCZar4Vl
         RFDlsrIrIOngDEEEt2YgIF7PeYypOxmkBZRYQ9J9rmYJtE2YwOFKcdlt02293Xz6QG
         AdzwCaWKiYmr1MLdaFr6mT65SIy4qlgUqtJPo/uaxPOOPhhWfZiwlM3Pn+Tj3RWfAf
         JfLa6V4oJWkNo6gFB8HmlUwlzGfRB7ukea7oZXiwGGYdEKnVsyEpzrl79oSQN2i2XD
         yO+ogbdgQ6vLQ==
Date:   Mon, 2 May 2022 15:32:05 -0500
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
Message-ID: <20220502203205.GA349835@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7bbd9205-aa35-4a27-0df4-8f2b22603831@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, May 02, 2022 at 02:24:26PM +0200, Hans de Goede wrote:
> On 4/19/22 18:45, Bjorn Helgaas wrote:
> > On Tue, Apr 19, 2022 at 05:16:44PM +0200, Hans de Goede wrote:
> >> On 4/19/22 17:03, Bjorn Helgaas wrote:
> >>> On Tue, Apr 19, 2022 at 11:59:17AM +0200, Hans de Goede wrote:

> >>>> So what is the plan to actually fix the issue seen on some
> >>>> Lenovo models and Clevo Barebones ?   As I mentioned previously
> >>>> I think that since all our efforts have failed so far that we
> >>>> should maybe reconsider just using DMI quirks to ignore the
> >>>> E820 reservation windows for host bridges on affected models ?
> >>>
> >>> I have been resisting DMI quirks but I'm afraid there's no other
> >>> way.
> >>
> >> Well there is the first match adjacent windows returned by _CRS
> >> and only then do the "covers whole region" exception check. I
> >> still think that would work at least for the chromebook
> >> regression...
> > 
> > Without a crystal clear strategy, I think we're going to be
> > tweaking the algorithm forever as the _CRS/E820 mix changes.
> > That's why I think that in the long term, a "use _CRS only, with
> > quirks for exceptions" strategy will be simplest.
> 
> Looking at the amount of exception we already now about I'm not sure
> if that will work well.

It's possible that many quirks will be required.  But I think in the
long run the value of the simplest, most obvious strategy is huge.
It's laid out in the spec already and it's the clearest way to
agreement between firmware and OS.  When we trip over something, it's
very easy to determine whether _CRS is wrong or Linux is using it
wrong.  If we have to bring in question of looking at E820 entries,
possibly merging them, using them or not based on overlaps ... that's
a much more difficult conversation without a clear resolution.

> > So I think we should go ahead with DMI quirks instead of trying to
> > make the algorithm smarter, and yes, I think we will need commandline
> > arguments, probably one to force E820 clipping for future machines,
> > and one to disable it for old machines.
> 
> So what you are suggesting is to go back to a bios-date based approach
> (to determine old vs new machines) combined with DMI quirks to force
> E820 clipping on new machines which turn out to need it despite them
> being new ?

Yes.  It's ugly but I think the 10-year outlook is better.

> I have the feeling that if we switch to top-down allocating
> that we can then switch to just using _CRS and that everything
> will then just work, because we then match what Windows is doing...

Yes, it might.  But I'm not 100% comfortable because it basically
sweeps _CRS bugs under the rug, and we may trip over them as we do
more hotplug and (eventually) resource rebalancing.  I think we need
to work toward getting _CRS more reliable.

Bjorn
