Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 673F74AA3E6
	for <lists+linux-pci@lfdr.de>; Sat,  5 Feb 2022 00:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377809AbiBDXCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 18:02:40 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:49942 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377814AbiBDXCj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 18:02:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 56FEFB83965;
        Fri,  4 Feb 2022 23:02:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93B8CC004E1;
        Fri,  4 Feb 2022 23:02:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644015757;
        bh=o2VFGLNW0Dd7KKuBrN5hzNBG6Tf7nQ6064dDe55xopM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=YITiFfCaOnsMORKmtcDiLlpaowUD1vcxapDSZGot81Xn2yBP/n1t5x4jw29h7PZbo
         K613Tj0B17M3B+u99SIIFfbIIYtelgvhXOChiSgWBpIJdqccJ7rnZ1zMqiIFV9iEMF
         8NpN+4pYMMjJZcIkZceWCixMPzGTShey+U0gH1eeaLVPS50jXLBQ6gY6UEx6HdpRpj
         wJbnxK0XlnlCLx1/pjlPVZCtsyMMm6unSUYbExbgv00xLDxxucmBxvxg4Al5HZse6R
         BTkWhRLb8mpbDPHXSfnt3/gGcnDOs82HVncumTXsV971a1TS+LV9KEwogD/ELDxlAy
         0a6dJVKz/NEng==
Date:   Fri, 4 Feb 2022 17:02:34 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     "Kenneth R. Crudup" <kenny@panix.com>, bhelgaas@google.com,
        lorenzo.pieralisi@arm.com, hkallweit1@gmail.com,
        wangxiongfeng2@huawei.com, mika.westerberg@linux.intel.com,
        kai.heng.feng@canonical.com, chris.packham@alliedtelesis.co.nz,
        yangyicong@hisilicon.com, treding@nvidia.com, jonathanh@nvidia.com,
        abhsahu@nvidia.com, sagupta@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI/ASPM: Save/restore L1SS Capability for
 suspend/resume
Message-ID: <20220204230234.GA226601@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <708b746c-1715-9d64-5a59-55c9ad81bd0a@nvidia.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 02, 2022 at 09:47:06AM +0530, Vidya Sagar wrote:
> On 2/2/2022 3:55 AM, Kenneth R. Crudup wrote:
> > On Wed, 2 Feb 2022, Vidya Sagar wrote:
> > > BTW, I see that the ASPM L1SS capability is supported by only
> > > two endpoints viz. KIOXIA's NVMe drive and Realtek's Card
> > > reader. None of the root ports seem to have the support. So, I'm
> > > wondering how was it even getting enabled in the first place
> > > earlier?
> > 
> > > (OR)
> > 
> > > was it the case that L1SS sub-states were never enabled earlier
> > > also and the issue was occurring without having ASPM L1SS
> > > enabled? (but with only L0s and L1 enabled??)
> > 
> > I'm not proficient enough in PCIe to be able to be sure of the
> > answers to those- what can/could I do to determine this?
>
> Nothing at this point, but could you please confirm that you are
> using the same system as before? if that is the case, then, I'm not
> sure how is it possible that the earlier patch which is also for
> saving/restoring L1SS registers could affect a system that doesn't
> even support L1SS.
> 
> Bjorn, any thoughts on this?

Do we have a theory on what might have caused the regression before?
Or at least something that is different this time around?

There's been a lot of discussion on this thread, so I'm going to
ignore this patch for now.  If you think it's good to go, please post
it again with the relevant Tested-bys and a note about why we think it
should work this time when it didn't last time.

Bjorn

> > > Also, I see that from 'before' and 'after' logs that for both
> > > NVMe and Card reader and their corresponding root ports, none of
> > > the ASPM states are enabled (not even L0s or L1).
> > > Did you set the policy to 'powersupersave' before hibernating
> > > the system?
> > 
> > Yeah:
> > 
> > CONFIG_PCIEASPM_POWER_SUPERSAVE=y
> > 
> > My laptop loses ~1.5%/hr in S3; I was trying anything I could to reduce that,
> > if possible.
> > 
> >          -Kenny
> > 
> > --
> > Kenneth R. Crudup / Sr. SW Engineer, Scott County Consulting, Orange County CA
> > 
