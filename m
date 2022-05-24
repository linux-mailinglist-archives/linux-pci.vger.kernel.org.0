Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886EB532CF2
	for <lists+linux-pci@lfdr.de>; Tue, 24 May 2022 17:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234076AbiEXPHX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 May 2022 11:07:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237532AbiEXPHW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 May 2022 11:07:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547A936150
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2022 08:07:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8E67616F3
        for <linux-pci@vger.kernel.org>; Tue, 24 May 2022 15:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133C7C34115;
        Tue, 24 May 2022 15:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653404840;
        bh=JCNb9awn0OpXt5WR6R27pY+rl5t/pjdVOY4Xu6heYlA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hpRJxtQu1HXVj2pQ6y8YVLk3Jph6DPu5R/HJy1XrfXaYNq39cma2ymdI7UEcn10N5
         4TJlcXY89hiZdJc1Tm0ELYSnPOH9cxXMCpI5YJbr+dFV5WIi62f6shrC5bRlImI08P
         o2qUrJ2uKjYLVgdqlFI9fpo9cR5cvkGaOBz0qaJH+cFU5btU4jM69b8wM4JrU86JS/
         pJzr7zz+0IKcSQwnrJB/v66HvrREU1iDD3cj5eLGnkNSaznN5F+2uCZddx50QEdIlb
         AdEkrAtzd/Q0MpGtR9c97UxhLbPsDYKpvzUazYGeLsO24BYASBw+e2DUf6uYD/0r6y
         Gt5lakWsjr5tA==
Date:   Tue, 24 May 2022 10:07:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, robh@kernel.org, kishon@ti.com,
        kw@linux.com, bhelgaas@google.com
Subject: Re: AFK till mid-July
Message-ID: <20220524150718.GA243159@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220524105915.GA14773@lpieralisi>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 24, 2022 at 11:59:15AM +0100, Lorenzo Pieralisi wrote:
> Dear PCI developers,
> 
> I wanted to make everyone aware I will be AFK till mid-July and won't be
> able to carry out patches review and queuing as usual.
> 
> I notified Bjorn and Rob who will kindly help (best-effort) in my
> absence - please be patient and we will handle the backlog in the
> next few months.

I'm not as versed in the pci/controllers/ code as Rob and Lorenzo, so
it will take me longer to review things, and I apologize in advance.

When I *do* review patches there, one of my main tools is to compare
with other similar drivers.  If a driver is structured the same way as
others and uses the same naming conventions, that's a huge help to me.

I also pay attention to the mundane details like coding style, commit
logs (both content and formatting), subject lines, etc.  Patches that
look like they fit with prior history and style are also a big help to
me.

My goal is not just to be OCD about it, but to make drivers/pci/
generally uniform and more pleasant for those who come after us.
Commits are "write once, read many" things, so I want to optimize for
the readers, not the writer.

Old posting of hints, which is still relevant:
https://lore.kernel.org/r/20171026223701.GA25649@bhelgaas-glaptop.roam.corp.google.com
