Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C8854A2FC
	for <lists+linux-pci@lfdr.de>; Tue, 14 Jun 2022 02:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiFNAA7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jun 2022 20:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231284AbiFNAA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Jun 2022 20:00:58 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0679D30F5B
        for <linux-pci@vger.kernel.org>; Mon, 13 Jun 2022 17:00:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B6FB2B8168D
        for <linux-pci@vger.kernel.org>; Tue, 14 Jun 2022 00:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A640C34114;
        Tue, 14 Jun 2022 00:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655164854;
        bh=0PrpgM1A+kQ6oQViCMgUSKoyB+V0WvCh8ECHe+2ip3I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RwWWX7lqAhOe810J5slooRKhfJiL/fkm9XDi0w/PZ5aFVjvcltpCMS8xXue4EOTcS
         EmewtnkQrZwLe220gUQqInU1InKXodCd5nLWroYx1UJVZRLM1qOgkS1KgI6+GPaO6h
         jRB9pUKTDmDqtLZangBAMicOAmydVWh+iWuqNbcw+3nXMLPBE4SDsODRE85Mt8rdCV
         E4IbdF9FpxPBn8GGAjxQJl+QnXs8VrZSiWbywGgdWw3624RSxjIL15SPSiQF13CInn
         3tCzgKJQRX1RARdpvgltcYIHhJlbe350ePK/+xlUOS8yywNhXw8dPEYfb0tZE2MLtm
         JWz0u895HpHHw==
Date:   Mon, 13 Jun 2022 19:00:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
        regressions@lists.linux.dev, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/4] PCI: brcmstb: Revert subdevice regulator stuff
Message-ID: <20220614000052.GA727153@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e58125a4-f885-ae55-0441-d52ecab9a1e8@gmail.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 13, 2022 at 10:06:12AM -0700, Florian Fainelli wrote:
> On 5/11/22 13:39, Bjorn Helgaas wrote:
> > On Wed, May 11, 2022 at 01:24:55PM -0700, Florian Fainelli wrote:
> > > On 5/11/22 13:18, Bjorn Helgaas wrote:
> > > > From: Bjorn Helgaas <bhelgaas@google.com>
> > > > 
> > > > Cyril reported that 830aa6f29f07 ("PCI: brcmstb: Split brcm_pcie_setup()
> > > > into two funcs"), which appeared in v5.17-rc1, broke booting on the
> > > > Raspberry Pi Compute Module 4.  Revert 830aa6f29f07 and subsequent patches
> > > > for now.
> > > 
> > > How about we get a chance to fix this? Where, when and how was this even
> > > reported?
> > 
> > Sorry, I forgot to cc you, that's my fault:
> >    https://lore.kernel.org/r/CABhMZUWjZCwK1_qT2ghTSu2dguJBzBTpiTqKohyA72OSGMsaeg@mail.gmail.com
> > 
> > If you come up with a fix, I'll drop the reverts, of course.

> What is even better is that meanwhile there was already a candidate fix
> proposed on May 18th, and a v2 on May 28th, so still an alternative to the
> reverts making it to Linus' tree, or so I thought.

I hoped for a fix, but neither of those seemed to be clearly better.

> - the history for pcie-brcmstb.c is now looking super ugly because we have 4
> commits getting reverted and if we were to add back the original feature
> being added now what? Do we come up with reverts of reverts, or the modified
> (with the fix) original commits applied on top, are not we going to sign
> ourselves for another 13 or so round of patches before we all agree on the
> solution?

I agree on the ugliness and I try hard to avoid that.  In this case I
waited too long after the regression was discovered, hoping for a fix
that was better than the revert.  And I should have asked for
trade-offs between the revert and the the CM4 regression.

> - we could have just fixed this with proper communication from the get go
> about the regression in the first place, which remains the failure in
> communicating appropriately with driver authors/maintainers

I apologized earlier for omitting you when the regression was
discovered, and I'm still sorry.

> I appreciate that as a maintainer you are very sensitive to regressions and
> want to be responsive and responsible but this is not leaving just a
> slightest chance to right a wrong. Can we not do that again please?

Cyril opened the bugzilla April 30 and I forwarded it to linux-pci and
to Jim (but not you; again, I'm sorry for that omission) on May 2.
From my perspective we had almost a month to push this forward, but we
didn't quite make it.

I posted the reverts May 11, but I did not realize the regression to
you and other users they would cause.  I apologize for that.

Bjorn
