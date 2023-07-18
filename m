Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042A17585B3
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 21:41:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbjGRTlE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 15:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbjGRTlE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 15:41:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6575B198D
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 12:41:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 034AC60AE3
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 19:41:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43417C433C8;
        Tue, 18 Jul 2023 19:41:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689709262;
        bh=6Wyk8ZVCsXytrEOYKTdjc4uXQTdilH4eSQUTFcRGjU0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fIsZfXtluP4sbWZx5/c9J9KErE8GxklLowoisFwl6BxPs2RKoajg01NFSE0F9SK7r
         zqIKO6JbqZBYQ7OqgvaqhwFCc8/ifbYmifmDStB5obNkiRAb6TYuavubBOcNOkclsN
         FhoDY9ss3fSg7pJSx8puaiK6v+h6fFPyEBiuxVOc+/wUlRNQCOnJcrBw7+RHetgFyl
         aDmpPy0dWfTAiz8iMeJNbd3ZLfEN8NjjEISs6QQRU9+U08a8miexFmbwPjxLccwnLX
         DYEyXoLRCZqjG05fiEBB5ATp3bLI7VnD0GsB7ErcFAUe4uyriYoMt+5tkfFEJ8N7wh
         AZKY88YSxhmyg==
Received: by pali.im (Postfix)
        id 8DB7F71F; Tue, 18 Jul 2023 21:40:59 +0200 (CEST)
Date:   Tue, 18 Jul 2023 21:40:59 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, Radu Rendec <rrendec@redhat.com>
Subject: Re: Future of pci-mvebu
Message-ID: <20230718194059.vx4srarn52mnvez2@pali>
References: <20230718192152.b4ic3nptfpsrrtui@pali>
 <20230718192819.GA490214@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718192819.GA490214@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 18 July 2023 14:28:19 Bjorn Helgaas wrote:
> On Tue, Jul 18, 2023 at 09:21:52PM +0200, Pali Rohár wrote:
> > On Tuesday 18 July 2023 14:02:52 Bjorn Helgaas wrote:
> > > On Tue, Jul 18, 2023 at 06:57:03PM +0200, Pali Rohár wrote:
> > > > On Tuesday 18 July 2023 06:19:52 Bjorn Helgaas wrote:
> > > > > On Tue, Jul 18, 2023 at 12:03:17AM +0200, Pali Rohár wrote:
> > > > > > Hello, I have just one question. What do you want to do with pci-mvebu
> > > > > > driver? It is already marked as broken for 3 kernel releases and I do
> > > > > > not see any progress from anybody (and you rejected my fixes). How long
> > > > > > do you want it to have marked as broken?
> > > > > 
> > > > > I don't think "depends on BROKEN" necessarily means that we plan to
> > > > > remove the driver.  I think it just means that it's currently broken,
> > > > > but we hope to fix it eventually.
> > > > > 
> > > > > I think the problem here is the regular vs chained interrupt handlers,
> > > > > right?  Radu has been looking at that recently, too, so maybe we can
> > > > > have another go at it.
> > > > 
> > > > I guess that this is the main issue as all other fixes and improvements
> > > > are stalled. 
> > > 
> > > If these other things don't depend on this IRQ issue, maybe we could
> > > still make progress on them?  Maybe post them again (rebasing to
> > > v6.5-rc1 if necessary)?  Often I forget or miss things, so it doesn't
> > > hurt to try again if you don't hear anything.
> > 
> > In past I (re)sent changes at least 3 times. And would not do it again.
> 
> Ouch, sorry.  How about links to them?

Some of them are in my git tree:
https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=pci-mvebu-pending

> I browsed through the archives, and I did see a couple things that
> apparently depended on the IRQ issue, but it wasn't obvious to me what
> the others were.
> 
> Bjorn
