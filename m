Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 575C2621DBF
	for <lists+linux-pci@lfdr.de>; Tue,  8 Nov 2022 21:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbiKHUho (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Nov 2022 15:37:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiKHUhn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 8 Nov 2022 15:37:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7FB05EFBB
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 12:37:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7988F61769
        for <linux-pci@vger.kernel.org>; Tue,  8 Nov 2022 20:37:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AB1C433C1;
        Tue,  8 Nov 2022 20:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667939861;
        bh=J3XX5ZCC/bikTJ1HQmQywaIKZQRDpjmyRxU2jMCcVtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lLtrc091bj5yN7uy7RmJgXE34SJM/vd3lA4sjuu755GUhlaNMUdWbqQ5z28Pw9EVc
         isajUVG7AUdNPxuIlDciqr63S/GYvny7Y6srsMdO3590DMil8LgWkDhlFM5CGckoeZ
         pxTdU6s1VZrdEAAa7eWqi8/6JcpyCyqWqo4DqMaM4KjdGVfqdr2VKrQ8pbThZFrLkw
         xHIX9qTVkHXlI7TCilwfKg8zwT9+HW/BU4IOrjgcPAiSgJzMyxYokHc2wErBG6ABjw
         UKai0v4K1IU/rIIA+LPVfdpOzmiJyyxKnsaaIxUVCGq8jqXeWCoqpScpEFLC3Ym/9Z
         5rLSbIAtgBK6A==
Date:   Tue, 8 Nov 2022 13:37:38 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     James Puthukattukaran <james.puthukattukaran@oracle.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-pci@vger.kernel.org
Subject: Re: [External] : Re: sysfs interface to force power off
Message-ID: <Y2q+EvzsMRkkrELK@kbusch-mbp>
References: <20221107204129.GA417338@bhelgaas>
 <0081d0f6-871f-3d07-1af7-0e8e41f5d983@oracle.com>
 <Y2p//Eqa9HGRmwWW@kbusch-mbp>
 <20221108201653.GA4919@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221108201653.GA4919@wunner.de>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 08, 2022 at 09:16:53PM +0100, Lukas Wunner wrote:
> On Tue, Nov 08, 2022 at 09:12:44AM -0700, Keith Busch wrote:
> > On Mon, Nov 07, 2022 at 04:14:54PM -0500, James Puthukattukaran wrote:
> > > 
> > > There is a path to disable the controller and that code ran but did
> > > not help. I checked wit the nvme folks and Keith mentioned that there
> > > might be an issue with the nvme queue management. Unfortunately, we
> > > can't try newer kernels in the field. So, looking for a way to just
> > > "shut off the device" when we have scenarios like this where we can't
> > > untangle the mess. 
> > 
> > Well, I didn't request you try new kernels in the field. I asked if you
> > could experiment with a newer one on a development machine to confirm if
> > the bug was fixed by some of the significant changes in this path so
> > that we could confirm a reason to port to stable. You're going to have
> > to change your kernel to fix this observation, so it would be worth the
> > effort to know if the changes being considered actually address the
> > problem.
> 
> Current mainline still contains this problematic sequence:
> 
>   nvme_reset_work()
>     nvme_wait_freeze()
>       blk_mq_freeze_queue_wait()
> 
> So I'm inclined to believe that the issue still persists, but I agree

Yeah, that sequence exists, but there are some subtle changes with how
the workqueues account for unquiesceing hardware queues that can affect
how a freeze can make forward progress.

> I think nvme_reset_work() is overly optimistic that resetting the drive
> succeeded.  It just freezes and unfreezes the I/O queue without checking
> for errors.

I'm not sure what you mean. An nvme reset is a CC.EN 0->1 transition,
and we definitely confirm that succeeds.

If you're referring to the 1->0 transition, that has to happen after the
initial freeze/quiesce steps, but whether or not that succeeds shouldn't
be relevant to the rest of the sequence: we're about to disable the
device at the PCI level.
 
> In particular, nvme_wait_freeze() should call the _timeout variant of
> blk_mq_freeze_queue_wait() and cope with failure of freezing.

That would indicate we have a mismatched freeze depth or a unbalanced
quiesce problem, so the timeout freeze would just mask the underlying
issue.
