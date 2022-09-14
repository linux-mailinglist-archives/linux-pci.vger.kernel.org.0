Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385CC5B8CB7
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 18:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiINQTu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 12:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiINQTr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 12:19:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D03F6617D
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 09:19:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7941361983
        for <linux-pci@vger.kernel.org>; Wed, 14 Sep 2022 16:19:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09F8C433D6;
        Wed, 14 Sep 2022 16:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663172384;
        bh=gzUz6nLHWQZhe8Dhgb2CKpo8EjdQxRqjM4YKtKzAeJs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iKoEajK9zwe1BZx5Y66B80lEUD5vPlEaNXGlRT9jY8eExIxAGQlN85nciFJyfiSj3
         bLd+pTI0N2p5mpfoNgADS4vS7T3jgHJJ/yMsHXclQN01mES192C3k9utBFWAUyHyV4
         Zcd6Svl60DO4mlIdBJ+Ri3KWSyPg5pW5JAxRFxTl5sslvlEoH+rljQUtFiFwSV+ldm
         /2q+9BEvFn4Vz3IYdGg0tN6cjrUMgKaMWvSVravhkGFAS1bdDkWHgxTNC17H8nMrr0
         i6Sdmj+FMeGNcU02sPY/vFowkzOKAZH/tClx0BbucPC6X4szPGb/IJEUy2b0jPDTTD
         H+uR92Z8GG6Yw==
Date:   Wed, 14 Sep 2022 11:19:42 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Daniel Gomez <daniel@qtec.com>
Cc:     "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
Subject: Re: PCI/MSI: kernel NULL pointer dereference
Message-ID: <20220914161942.GA686189@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH1Ww+TydyHo+CADnX2Rn8XfDd9coSZj03hxNfCwMg4t1qP+bw@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 08, 2022 at 04:30:28PM +0200, Daniel Gomez wrote:
> On Thu, 8 Sept 2022 at 15:44, Deucher, Alexander
> <Alexander.Deucher@amd.com> wrote:
> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: Thursday, September 8, 2022 8:13 AM
> > > To: Daniel Gomez <daniel@qtec.com>
> > > Cc: linux-pci@vger.kernel.org; Thomas Gleixner <tglx@linutronix.de>;
> > > Deucher, Alexander <Alexander.Deucher@amd.com>; Koenig, Christian
> > > <Christian.Koenig@amd.com>
> > > Subject: Re: PCI/MSI: kernel NULL pointer dereference
> > >
> > > On Thu, Sep 08, 2022 at 12:41:00PM +0200, Daniel Gomez wrote:
> > > > Hi,
> > > >
> > > > I have the following error whenever I remove the fglrx module from the
> > > > latest 6.0-rc4.
> > >
> > > You bisected to 93296cd1325d; I don't see a commit with a "Fixes:"
> > > that references that.  If you can reproduce this with an in-tree driver, we can
> > > certainly fix it, but it's harder for an out-of-tree driver.
> I understand, thanks. I tried with radeon but rmmod it is not possible
> once it's loaded.

A brute-force way to debug this would be to add logging to entry
points in msi.c so you can see what MSI-related interfaces fglrx uses
and in what order.  Then you may be able to make a trivial module that
does something similar that we could use as a test case so we could
duplicate the failure and verify a fix.

Bjorn
