Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A19368708A
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 22:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjBAVnU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Feb 2023 16:43:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjBAVnT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Feb 2023 16:43:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EC9DEC57;
        Wed,  1 Feb 2023 13:43:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F09DBB822BB;
        Wed,  1 Feb 2023 21:43:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C076C433EF;
        Wed,  1 Feb 2023 21:43:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675287795;
        bh=n5zwfnJq/0k7NqmhaM7dDS0iPBkLiQGnHNC0chJvoyo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=LbLSy0ip7DQZscgc8KHtS0nzvggLwtqJ5rHcAlvuMqiMbPxZXB6Ysfe/NlR/fII8y
         yuf/fl/Aj7+BjiG8cy/KpwOE1SlIfxUlyTYFv+yCONgj6sNQCl27z7FjkjF2otAAV9
         SwGjr74/6Sip7yBA3gaVKK2FpHyeV98wV2kEUDjbxlNjhXby6fMOeHK1OC5CEQ1ShF
         5UXxJag6TMquAS1jvsYi7vCsew4jNCkIDIdJh06j08892/Zrw5FTy5RTk3Z5TSTAjm
         oNS8Quy6fDI2xiC7po2qgXO2sss9f/XAFjvQ8vrB/+jNMUwZpvVaGTUh+8qurEStGR
         s0pMk8QNoEGxg==
Date:   Wed, 1 Feb 2023 15:43:13 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Mad Horse <equu@openmail.cc>
Cc:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org,
        linux-pci@vger.kernel.org, robh@kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org
Subject: Re: [PATCH 2/3] wifi: ath9k: stop loading incompatible DT cal data
Message-ID: <20230201214313.GA1898614@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 01, 2023 at 11:02:59AM +0800, Mad Horse wrote:
> 在 2023/1/18 03:46, Bjorn Helgaas 写道:

> > Suggest structure like this (flesh out with the relevant DT property
> > names, etc):
> >
> >   For PCI ath9k devices, load calibration data only if there is a DT
> >   node corresponding to the device with XXX ...
> >
> > More details: https://chris.beams.io/posts/git-commit/
> >
> Thanks for pointing it out. The commit log of the last two patch has
> been reworded with required content, and sent to the current thread
> earlier.

Thanks.  Sending updated version as replies to the original series
posting makes it hard to keep track of what's happening.  Better if
you send a "v2" series of *all* the patches, even if some of them
haven't changed.  There are a few hints here, although it's not very
explicit:

  https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?id=v6.1#n633

Also, you use multiple email addresses, and if you can figure out how
to at least make the display names the same, it will make the
conversation easier to follow.  Here's what it looks like in mutt:

  - Jan  7  9:14 Mad Horse       [PATCH] pci: Add functions ...
  - Jan 10  9:24 To Mad Horse    ├─>
  - Jan 17  4:01 Mad Horse       ├─>[PATCH 1/3] PCI: of: Match ...
  - Jan 17  4:02 Mad Horse       ├─>[PATCH 2/3] wifi: ath9k: stop ...
  - Jan 17  4:02 Mad Horse       ├─>[PATCH 3/3] wifi: ath10k: only ...
  - Jan 17  4:29 Mad Horse       ├─>[PATCH 1/3] PCI: of: Match pci ...
  - Jan 17  3:27 Edward Chow     ├─>[PATCH 1/3] PCI: of: Match pci ...
  - Jan 17  3:28 Edward Chow     ├─>[PATCH 3/3] wifi: ath10k: only ...
  - Jan 21  4:00 persmule@gmail. ├─>[PATCH 2/3] wifi: ath9k: stop ...
  - Jan 21  4:06 persmule@gmail. ├─>[PATCH 3/3] wifi: ath10k: only ...
  - Jan 17  3:27 Edward Chow     └─>[PATCH 2/3] wifi: ath9k: stop ...
  - Jan 17 13:46 To Edward Chow    └─>
  - Jan 31 21:02 Mad Horse           └─>

This also shows the problem with updated versions in the same thread.
I can work out that "Jan 17 1/3", "Jan 21 2/3", and "Jan 21 3/3" are
supposed to be the newest versions, but tools like patchwork and b4
are not smart enough to do that, so it's really hard to apply this.

If you just post an updated series, e.g.,

  [PATCH v2 0/3] PCI: ...
  |-> [PATCH v2 1/3] PCI: of: Match ...
  |-> [PATCH v2 1/3] PCI: of: Match ...
  |-> [PATCH v2 1/3] PCI: of: Match ...

then everything will be nice and clean and easy to review and apply.

Bjorn
