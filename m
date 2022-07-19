Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C81957A9D8
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 00:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239227AbiGSWbe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 18:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiGSWbd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 18:31:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819F24F68F;
        Tue, 19 Jul 2022 15:31:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BDD1EB81D9E;
        Tue, 19 Jul 2022 22:31:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2EFC341C6;
        Tue, 19 Jul 2022 22:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658269889;
        bh=xBsNiIMMI61ZsRhK57QPnpQXFAF/uUru2IBPm5xDOok=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=GbLLdxnBasZ3J/VmbW+T8dRYdw9CQMZkQYGqgazvzzSFoSto0ODn6h90z31OnWSgE
         IYFjNcrZtInWYCrGCb4dupQxh4o93Vo9XI7Deoi4eVAzVjFX2eYR/D9FPaIT8IpXMY
         WA5y4i0cyPtbyvQEv4cma09lCLZppj2WiWn7u9DM7csbuDCBxSWBt6ypmiU11VHU0A
         l41argqGFJ1/+1oC/xX9HDvKLBFd12G5/TRW/9A/ZLwKTXezANSisqTJgFx/JLWxUu
         0jEisI4+5ths/C8bOTQ4Kt8NrGWWr7qR9IMMDZ105T4slXJrWtw2jJGJrA8eYKPsOC
         kHskSWaoqzN+g==
Date:   Tue, 19 Jul 2022 17:31:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Yi Zhang <yi.zhang@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mstowe@redhat.com" <mstowe@redhat.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Xiao Yang <yangx.jy@fujitsu.com>,
        Keith Busch <kbusch@kernel.org>
Subject: Re: blktests failures with v5.19-rc1
Message-ID: <20220719223127.GA1585747@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220719045036.h273puvs3cibafix@shindev>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 19, 2022 at 04:50:36AM +0000, Shinichiro Kawasaki wrote:
> On Jun 15, 2022 / 17:16, Keith Busch wrote:
> > On Wed, Jun 15, 2022 at 02:47:27PM -0500, Bjorn Helgaas wrote:
> > > On Tue, Jun 14, 2022 at 04:00:45AM +0000, Shinichiro Kawasaki wrote:
> > > > 
> > > > Yeah, this WARN is confusing for us then it would be valuable to
> > > > test by blktests not to repeat it. One point I wonder is: which test
> > > > group the test case will it fall in? The nvme group could be the
> > > > group to add, probably.
> > > > 
> > > > Another point I wonder is other kernel test suite than blktests.
> > > > Don't we have more appropriate test suite to check PCI device
> > > > rescan/remove race ? Such a test sounds more like a PCI bus
> > > > sub-system test than block/storage test.
> > > 
> > > I'm not aware of such a test, but it would be nice to have one.
> > > 
> > > Can you share your qemu config so I can reproduce this locally?
> > > 
> > > Thanks for finding and reporting this!
> > 
> > This ought to be reproducible with any pci device that can be
> > removed. Since we initially observed with nvme, you can try with
> > such a device. A quick way to get one appearing in qemu is to add
> > parameters:
> > 
> >         -drive id=n,if=none,file=null-co://,format=raw \
> > 	-device nvme,serial=foobar,drive=n
> 
> Did you have chance to reproduce the WARN? Recently, it was reported
> again [1] and getting attention.

I have not paid any attention to this yet.  From what I can tell, the
problem was discovered by a test case (i.e., not reported by a
real-world user), it is not a recent regression, we haven't identified
a commit that introduced the problem, and we do not have a potential
fix for it.  Obviously it needs to be fixed and I'm not trying to
minimize the problem; I just want to calibrate it against everything
else.

> [1] https://lore.kernel.org/linux-block/4ed3028b-2d2f-8755-fec2-0b9cb5ad42d2@fujitsu.com/
> 
> -- 
> Shin'ichiro Kawasaki
