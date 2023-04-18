Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDC36E6DD3
	for <lists+linux-pci@lfdr.de>; Tue, 18 Apr 2023 23:05:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231483AbjDRVFj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Apr 2023 17:05:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjDRVFj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 18 Apr 2023 17:05:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261C67ED6
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 14:05:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3BF261E4E
        for <linux-pci@vger.kernel.org>; Tue, 18 Apr 2023 21:05:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE17C433D2;
        Tue, 18 Apr 2023 21:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681851937;
        bh=8V8yyJMftGMuQ3iawWmSnehxGc0t5Yn+JIvTdQBiBb0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=AIWDSZYG9c69xDwf8RWtOlP5IfdTW9KWDz59GIncmzDnHGYkU6oGZldouaqjwILWQ
         S0aECPGISrubgeH4jsF5g/M9UU5EVwmOJsVIhtuqjyUNanDBcjfbGJ/oAZY0mrLbv0
         OAGGUeHgdeLq2bo/VJuJzEUH3b1qrGJRUFDD7rvpjlpLp3jg4q2uiEMCZHUAnAO3D8
         8EXUuRMyrubc/PIxFd3qtTVOx+egwoL+57D/wogtDBOxy7oxhI1w5Q2nd9bYL1LgFQ
         be/mnkQrGlROoJwn/cPIYPZaR7HKcF/K7F3+Z6kCbEU3iflFWNLK87F/b4poPyqsQD
         eit/fFRBpMV5g==
Date:   Tue, 18 Apr 2023 16:05:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [pci:next] BUILD SUCCESS 1fdef2055d8690d6f29d08d6d506bb7fba708488
Message-ID: <20230418210535.GA160787@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418192126.GA27233@wunner.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 09:21:26PM +0200, Lukas Wunner wrote:
> Hi Bjorn,
> 
> On Sat, Apr 15, 2023 at 02:07:33PM +0800, kernel test robot wrote:
> > tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git next
> > branch HEAD: 1fdef2055d8690d6f29d08d6d506bb7fba708488  Merge branch 'pci/controller/rcar'
> 
> Just a heads-up that the pci/hotplug branch has not been merged
> into pci/next.
> 
> It thus doesn't get linux-next coverage at the moment and won't
> make it into v6.4-rc1 if your pull will be based on current
> pci/next.
> 
> I double-checked all the other branches but pci/hotplug is the
> only one missing.
> 
> Not sure if that's intentional, but probably not, so thought I'd
> let you know. :)

Thanks for the reminder, I included it now.  There will be a few more
changes before v6.4-rc1, too.
