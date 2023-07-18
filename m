Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEFAD75858B
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jul 2023 21:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjGRT2b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jul 2023 15:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229843AbjGRT2a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Jul 2023 15:28:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359F51992
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 12:28:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BE86F616E2
        for <linux-pci@vger.kernel.org>; Tue, 18 Jul 2023 19:28:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7CAC433C8;
        Tue, 18 Jul 2023 19:28:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689708501;
        bh=uHbLMHa62gIWGrW1CxCg09OZGLb4DWd2o9qcIdeWwqM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=RHkfzle4NyWUnsFZyyY1+GVDIHOgek6WGCD5/ToDrA8smwsM53MBjSN4q52tZyG/J
         PBRHgV1jlVhMGRb0PljFMe5tBkIdqIZn8DW7kqbsxRH++bS1yW73xOSTfgBL9tk3t7
         oFEJfWJm7C2oBl3dd2UsAjWUfQpc1TwsGym9nl9z0WQxOaWWjHDYooha8r/Ub+7LPE
         i0HuZ2dGGTJ8CGS5IRBrSPFoUh42R1G4NxSngJL5r9JxgLb1AA41k7w53YXadOKk1R
         OPKQ0sJ3KEq+srAqGBbJRroSRl32FhYLn6S8OULpX1akxPw8tHeZchzdobr/3G7xQI
         tqLXzLHkofxMA==
Date:   Tue, 18 Jul 2023 14:28:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Krzysztof Wilczynski <kw@linux.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-pci@vger.kernel.org, Radu Rendec <rrendec@redhat.com>
Subject: Re: Future of pci-mvebu
Message-ID: <20230718192819.GA490214@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230718192152.b4ic3nptfpsrrtui@pali>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 18, 2023 at 09:21:52PM +0200, Pali Rohár wrote:
> On Tuesday 18 July 2023 14:02:52 Bjorn Helgaas wrote:
> > On Tue, Jul 18, 2023 at 06:57:03PM +0200, Pali Rohár wrote:
> > > On Tuesday 18 July 2023 06:19:52 Bjorn Helgaas wrote:
> > > > On Tue, Jul 18, 2023 at 12:03:17AM +0200, Pali Rohár wrote:
> > > > > Hello, I have just one question. What do you want to do with pci-mvebu
> > > > > driver? It is already marked as broken for 3 kernel releases and I do
> > > > > not see any progress from anybody (and you rejected my fixes). How long
> > > > > do you want it to have marked as broken?
> > > > 
> > > > I don't think "depends on BROKEN" necessarily means that we plan to
> > > > remove the driver.  I think it just means that it's currently broken,
> > > > but we hope to fix it eventually.
> > > > 
> > > > I think the problem here is the regular vs chained interrupt handlers,
> > > > right?  Radu has been looking at that recently, too, so maybe we can
> > > > have another go at it.
> > > 
> > > I guess that this is the main issue as all other fixes and improvements
> > > are stalled. 
> > 
> > If these other things don't depend on this IRQ issue, maybe we could
> > still make progress on them?  Maybe post them again (rebasing to
> > v6.5-rc1 if necessary)?  Often I forget or miss things, so it doesn't
> > hurt to try again if you don't hear anything.
> 
> In past I (re)sent changes at least 3 times. And would not do it again.

Ouch, sorry.  How about links to them?

I browsed through the archives, and I did see a couple things that
apparently depended on the IRQ issue, but it wasn't obvious to me what
the others were.

Bjorn
