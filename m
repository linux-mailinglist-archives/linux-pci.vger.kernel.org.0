Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B866F6ED2
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 17:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbjEDPXt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 11:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjEDPXs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 11:23:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 650CE44BB
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 08:23:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 01C24634F6
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 15:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2407DC433EF;
        Thu,  4 May 2023 15:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683213826;
        bh=cx2Pm4KLnBIf9oBX5HGLD4VmQLIA+zu/GxMXPdHg/eg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aj6Nfc4Gl+msjemNwyZNwCgB1B/zmnVAnrM7qWTX/zQKemHVGLFMuMQvfRlerV1vr
         Q+B/Olc5ZGF8F8Ci6lbu3dwC2Cs79C2QbmJPU5POZelQXnhNe9U7yDNcrrRwHsRQdP
         ziin9OT4uajH6+q6aSNZAtBt/2CncFbJwkWrlgjijh4PaF8Kglt8fa1HyqmG1edJSA
         PffYm8AUXJcYZduA0W3qoax1/6S4EUyVbFdyd0zHG0w0UOU3MNzHf1AoPJw1d10h2P
         3BMelG36vBJqlw8e3ATNFIW5dtGX+ZbPodAukzNgAiESW6LeHfkjA8XfPXkWomRkQo
         fqgU99c9UmY1w==
Date:   Thu, 4 May 2023 10:23:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Vidya Sagar <vidyas@nvidia.com>, Koba Ko <koba.ko@canonical.com>,
        Ajay Agarwal <ajayagarwal@google.com>,
        Tasev Nikola <tasev.stefanoska@skynet.be>,
        Mark Enriquez <enriquezmark36@gmail.com>,
        Thomas Witt <kernel@witt.link>, regressions@lists.linux.dev
Subject: Re: [Bug 217321] New: Intel platforms can't sleep deeper than PC3
 during long idle
Message-ID: <20230504152344.GA857680@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230411204229.GA4168208@bhelgaas>
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Koba, Ajay, Tasev, Mark, Thomas, regressions list]

On Tue, Apr 11, 2023 at 03:42:29PM -0500, Bjorn Helgaas wrote:
> On Tue, Apr 11, 2023 at 08:32:04AM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=217321
> > ... 
> >         Regression: No
> > 
> > [Symptom]
> > Intel cpu can't sleep deeper than pcˇ during long idle
> > ~~~
> > Pkg%pc2 Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
> > 15.08   75.02   0.00    0.00    0.00    0.00    0.00
> > 15.09   75.02   0.00    0.00    0.00    0.00    0.00
> > ^CPkg%pc2       Pkg%pc3 Pkg%pc6 Pkg%pc7 Pkg%pc8 Pkg%pc9 Pk%pc10
> > 15.38   68.97   0.00    0.00    0.00    0.00    0.00
> > 15.38   68.96   0.00    0.00    0.00    0.00    0.00
> > ~~~
> > [How to Reproduce]
> > 1. run turbostat to monitor
> > 2. leave machine idle
> > 3. turbostat show cpu only go into pc2~pc3.
> > 
> > [Misc]
> > The culprit are this 
> > a7152be79b62) Revert "PCI/ASPM: Save L1 PM Substates Capability for
> > suspend/resume”
> > 
> > if revert a7152be79b62, the issue is gone
> 
> Relevant commits:
> 
>   4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for suspend/resume")
>   a7152be79b62 ("Revert "PCI/ASPM: Save L1 PM Substates Capability for suspend/resume"")
> 
> 4ff116d0d5fd appeared in v6.1-rc1.  Prior to 4ff116d0d5fd, ASPM L1 PM
> Substates configuration was not preserved across suspend/resume, so
> the system *worked* after resume, but used more power than expected.
> 
> But 4ff116d0d5fd caused resume to fail completely on some systems, so
> a7152be79b62 reverted it.  With a7152be79b62 reverted, ASPM L1 PM
> Substates configuration is likely not preserved across suspend/resume.
> a7152be79b62 appeared in v6.2-rc8 and was backported to the v6.1
> stable series starting with v6.1.12.
> 
> KobaKo, you don't mention any suspend/resume in this bug report, but
> neither patch should make any difference unless suspend/resume is
> involved.  Does the platform sleep as expected *before* suspend, but
> fail to sleep after resume?
>
> Or maybe some individual device was suspended via runtime power
> management, and that device lost its L1 PM Substates config?  I don't
> know if there's a way to disable runtime PM easily.

Koba, per your bugzilla update, the issue happens even without
suspend/resume.  And we don't know whether some particular device is
responsible.

But if we save/restore L1SS state, we can sleep deeper than PC3.  If
we don't preserve L1SS state, we can't.

We definitely want to preserve the L1SS state, but we can't simply
apply 4ff116d0d5fd ("PCI/ASPM: Save L1 PM Substates Capability for
suspend/resume") again because it caused its own regressions [1,2,3]

So somebody needs to figure out what was wrong with 4ff116d0d5fd, fix
it, verify that it doesn't cause the issues reported by Tasev, Thomas,
and Mark, and then we can apply it.

Bjorn

[1] https://git.kernel.org/linus/a7152be79b62
[2] https://bugzilla.kernel.org/show_bug.cgi?id=216782
[3] https://bugzilla.kernel.org/show_bug.cgi?id=216877
