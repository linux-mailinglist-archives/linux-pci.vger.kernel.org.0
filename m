Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE687187D7
	for <lists+linux-pci@lfdr.de>; Wed, 31 May 2023 18:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229514AbjEaQ4G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 31 May 2023 12:56:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjEaQ4F (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 31 May 2023 12:56:05 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8A03BE;
        Wed, 31 May 2023 09:56:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7533461597;
        Wed, 31 May 2023 16:56:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 928B4C4339B;
        Wed, 31 May 2023 16:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685552163;
        bh=5Q+EdMzh/OPsDaBAUFWrZ15Js9jdbpqY6IvL32TdOck=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=nP6xNKIBHLsYQhpkuVVK8f7l9YtWdRK3Al9ksT3IQdBcYhOxjRdo6e41UVxLViPbI
         gaiM8BoCy9/6yjE5vZcmO5/qDX5kL4M6nLkgfhozYpxOIeKgGcBKpR8ps5tkmPKwCM
         di+BZdXLddt/YkIBgU3kqc7OkTT3qTqDQGHM9lH2eAYZA1GVPbj39RmMY5F108Oihb
         zDC3nhh7TFmZnoc+ma/BtzSLW+o33lVfiH64COcP7na4kAlVmIQXYdmiyyX8p9Bag5
         nC3gywto8lmzPU3bqvelNq132OyTpo+6jodKCc+GggtvVuqR+Ohrlovt1La6vKK76W
         mANf69aUGP46w==
Date:   Wed, 31 May 2023 11:56:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>
Cc:     linux-pci@vger.kernel.org, netdev@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh@kernel.org>,
        Claudiu Manoil <claudiu.manoil@nxp.com>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH pci] PCI: don't skip probing entire device if first fn OF
 node has status = "disabled"
Message-ID: <ZHd8Ig7LzHqseAnq@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530231509.4bybb5nw4xyxxq2m@skbuf>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 31, 2023 at 02:15:09AM +0300, Vladimir Oltean wrote:
> On Tue, May 30, 2023 at 05:27:24PM -0500, Bjorn Helgaas wrote:
> > Ah, you're right, sorry I missed that.  Dispensing with the SERDES
> > details would make this more obvious.
> 
> Lesson learned. When I had just gotten out of college, every time I asked
> the coworkers in my company what they're up to, I was amazed by them just
> proceeding to tell me all the nitty gritty details of what they're doing
> and debugging, like I was supposed to understand or care for that matter.
> "Dude, can't you just paint the high level idea without using dorky words?"
> Now I'm one of them...

Haha :)  Communication is the hardest part!

> > Seems like something in pci_set_of_node() or a quirk could do whatever
> > you need to do.
> 
> Could you help me out with a more detailed hint here? I'm not really
> familiar with the PCI core code. You probably mean to suggest leaving a
> stateful flag somewhere, though I'm not exactly sure where that is, that
> would reach pci_scan_slot() enough to be able to alter its decision.

What bad things happen without this patch?  I guess we enumerate
Function 0 but in some cases it's not useful?  That in itself wouldn't
be a disaster; there are lots of things we enumerate but don't use.
But in this case, maybe a driver would claim Function 0 but it
wouldn't work as expected?

Bjorn
