Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3A4A54D1ED
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 21:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344540AbiFOTrd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 15:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346653AbiFOTrb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 15:47:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB9AB16;
        Wed, 15 Jun 2022 12:47:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7D6A612E3;
        Wed, 15 Jun 2022 19:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 294CFC3411F;
        Wed, 15 Jun 2022 19:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655322449;
        bh=JSAZG6VVbEmLFwyoQO3PWN18odfJR3UCi5LMy1uYvfY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CtVvrckVarhPo7oTjYmAW3NHC9L/7f4Le+mupFetN5dvRZfQzha8MoPmmEIBEtNsN
         7Z4E7YTO+RyuE2Ikz85uyf4oImzzt+kc+3iS9gytL4vrmtcm3oBLCBOcWfA05us8rW
         iMtSwouoWnuBNksnQWmRVkWP2VgdjSXUSAk5ZUUyVrIyFg6xzOd/JtoCoCOb09Nnfj
         y1uHJcxAvwTl6EZ1ViLhdv88GqoH6DkDil/xYNYBoD+JgwdDMElXToSErUPEydaEAv
         meRSoAXvlwMpqywG1NS5QueUyZjK6JrRYHi6lti7t0MD0/vJ1mAtKgZwN052IElMPZ
         OX+PErleg9eww==
Date:   Wed, 15 Jun 2022 14:47:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mstowe@redhat.com" <mstowe@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Message-ID: <20220615194727.GA1022614@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220614040044.rypyclhqfv5w4xy7@shindev>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 14, 2022 at 04:00:45AM +0000, Shinichiro Kawasaki wrote:
> On Jun 14, 2022 / 02:38, Chaitanya Kulkarni wrote:
> > Shinichiro,
> > 
> > On 6/13/22 19:23, Keith Busch wrote:
> > > On Tue, Jun 14, 2022 at 01:09:07AM +0000, Shinichiro Kawasaki wrote:
> > >> (CC+: linux-pci)
> > >> On Jun 11, 2022 / 16:34, Yi Zhang wrote:
> > >>> On Fri, Jun 10, 2022 at 10:49 PM Keith Busch <kbusch@kernel.org> wrote:
> > >>>>
> > >>>> And I am not even sure this is real. I don't know yet why
> > >>>> this is showing up only now, but this should fix it:
> > >>>
> > >>> Hi Keith
> > >>>
> > >>> Confirmed the WARNING issue was fixed with the change, here is
> > >>> the log:
> > >>
> > >> Thanks. I also confirmed that Keith's change to add
> > >> __ATTR_IGNORE_LOCKDEP to dev_attr_dev_rescan avoids the fix, on
> > >> v5.19-rc2.
> > >>
> > >> I took a closer look into this issue and found The deadlock
> > >> WARN can be recreated with following two commands:
> > >>
> > >> # echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/rescan
> > >> # echo 1 > /sys/bus/pci/devices/0000\:00\:09.0/remove
> > >>
> > >> And it can be recreated with PCI devices other than NVME
> > >> controller, such as SCSI controller or VGA controller. Then
> > >> this is not a storage sub-system issue.
> > >>
> > >> I checked function call stacks of the two commands above. As
> > >> shown below, it looks like ABBA deadlock possibility is
> > >> detected and warned.
> > > 
> > > Yeah, I was mistaken on this report, so my proposal to suppress
> > > the warning is definitely not right. If I run both 'echo'
> > > commands in parallel, I see it deadlock frequently. I'm not
> > > familiar enough with this code to any good ideas on how to fix,
> > > but I agree this is a generic pci issue.
> > 
> > I think it is worth adding a testcase to blktests to make sure
> > these future releases will test this.
> 
> Yeah, this WARN is confusing for us then it would be valuable to
> test by blktests not to repeat it. One point I wonder is: which test
> group the test case will it fall in? The nvme group could be the
> group to add, probably.
> 
> Another point I wonder is other kernel test suite than blktests.
> Don't we have more appropriate test suite to check PCI device
> rescan/remove race ? Such a test sounds more like a PCI bus
> sub-system test than block/storage test.

I'm not aware of such a test, but it would be nice to have one.

Can you share your qemu config so I can reproduce this locally?

Thanks for finding and reporting this!

Bjorn
