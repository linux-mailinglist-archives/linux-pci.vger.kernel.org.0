Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906675B0F18
	for <lists+linux-pci@lfdr.de>; Wed,  7 Sep 2022 23:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiIGV0z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 7 Sep 2022 17:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiIGV0y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 7 Sep 2022 17:26:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A64ECB2769;
        Wed,  7 Sep 2022 14:26:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6488CB81ED5;
        Wed,  7 Sep 2022 21:26:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2EE4C433D6;
        Wed,  7 Sep 2022 21:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662586011;
        bh=6pTepJ3oeIprLS4jKNueGfIkkF3Dt0U1u/bTrZo1byA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NlQKyVswE4LE9ey6AEdaLIXxDgZifJE6y4KB48xeTuD2qFTy7lDbTzJIA+/bEA5BZ
         fUHMlNhKlTNysc+rtS1rRMla1MdpLtoABCtBvtGYfgzX7zms8vHxCG3Hf9wX4RoQ1n
         EiaYTA3G3ODyL2cVNpNgYcexysW388boWGDK9b01sf6c2XBTRCItQwqhLnywHFl137
         zjBFuBW+fm9HecdJr6VgA2kGT/9ooq9qPU0c6d577VXlA/iO4KsOAX//LiaF3Q/C72
         tCEWiGH6/jsej1oaYo7j93akwsKSomtANh4BrC5HFKnx70yb5uG7DqepVVuo4x4PF5
         UMSHU/SbVfx8A==
Date:   Wed, 7 Sep 2022 16:26:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     William McVicker <willmcvicker@google.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, kernel-team@android.com,
        Sajid Dalvi <sdalvi@google.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] PCI/PM: Switch D3Hot delay to also use usleep_range
Message-ID: <20220907212649.GA152425@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxfgp9DgYc3XU602@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 07, 2022 at 12:07:03AM +0000, William McVicker wrote:
> On 09/02/2022, Bjorn Helgaas wrote:

> >    static void pci_dev_d3_sleep(struct pci_dev *dev)
> >    {
> >         unsigned int delay_ms = max(dev->d3hot_delay, pci_pm_d3hot_delay);
> >         unsigned int upper;
> > 
> >         if (delay_ms) {
> >                 /* 20% upper bound, 1ms minimum */
> >                 upper = max(DIV_ROUND_CLOSEST(delay_ms, 5), 1U)
> >                 usleep_range(delay_ms * USEC_PER_MSEC,
> >                              (delay_ms + upper) * USEC_PER_MSEC);
> >         }
> >    }
> > 
> > Since the Intel quirk is for 120ms, a 20% upper bound would make the
> > range 120-144ms.  Would that be a problem?  Those chips are ancient;
> > the list is untouched since it was added in 2006.  The point of
> > usleep_range() is to allow the scheduler to coalesce the wakeup with
> > other events, so it seems unlikely we'd ever wait the whole 144ms.  I
> > vote for optimizing the readability over sleep/resume time for
> > already-broken chips.
> 
> I'm totally fine with this, but I don't really know what the impact
> would be to those old Intel chips.

Worst-case, a few more ms to wakeup.  Since we're starting with a huge
120ms *per device* delay, I think that's acceptable.  Let's do this.

Bjorn
