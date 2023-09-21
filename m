Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A14FB7A9EC6
	for <lists+linux-pci@lfdr.de>; Thu, 21 Sep 2023 22:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbjIUUML (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Sep 2023 16:12:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbjIUULs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Sep 2023 16:11:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0444EFD
        for <linux-pci@vger.kernel.org>; Thu, 21 Sep 2023 10:22:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7F9FC58335;
        Thu, 21 Sep 2023 16:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695313633;
        bh=ni9QrQuh/sOoonctopzroRA9c1b83VxY5L4jnz7Nf7I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ezDengTOd9jiHgn7jWdQeip/VVrL7Zr5E+BMokFD2pCDS132ktyzwdl47x7QBLSUI
         Aq1QB5g84+aaUmZmqOCRPdSQWImbsPafKgK4fYskZkgO0N8mL0oO8QOTAMNL2omJTs
         5Ljg8PCQMDto2ueGODSLOO3EF2OWnFt3voxMy2m9NmTqVlQRWyZ9/s0atBlpOpZkaS
         W6FL9wW/3QhaU7RSjNiSqCjo92JCTk7ZTlqjlo0AixDpIY1yMTyMd6SjRrhnnncDL4
         lOsAcaBS9te3X/vKIoe29AW+OSegi5PYqE4Ypiy5GmJg+l0/oizzLZNtaqeVql0Ydq
         8+rXWTtMpDH4A==
Date:   Thu, 21 Sep 2023 11:27:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     linux-pci@vger.kernel.org
Subject: Re: Make Bjorn's life easier (and grease the path of your patch)
Message-ID: <20230921162710.GA334709@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921151401.GA25512@wunner.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 21, 2023 at 05:14:01PM +0200, Lukas Wunner wrote:
> On Thu, Oct 26, 2017 at 05:37:01PM -0500, Bjorn Helgaas wrote:
> ...

> I'm not sure where to insert the Closes tag, checkpatch wants it immediately
> after the Reported-by, but since Closes is like Link, I'd assume that you'd
> prefer it to precede the Reported-by.

I'd put it where checkpatch wants it.

> I've pointed other folks to your message so that they know which guidelines
> to observe when submitting to linux-pci.  I'd like to encourage you to
> update it and (if you like) add it to the tree as a maintainer profile
> (see Documentation/maintainer/maintainer-entry-profile.rst) so that it's
> even easier to find.

Yeah, I guess that makes sense.  I consider that periodically but I
always hate the fact that we have a dozen different places for
contributors to look for different people's preferences, and I feel
like my preferences are mostly just generic or obvious guidance, so I
hesitate to add another place.

E.g., should we really have to write down that "if the whole file fits
in 80 columns, and your patch adds 100-character lines, you're doing
something wrong"?

But I guess that's just my hubris, and my preferences are not obvious
to everybody else, and having them buried in an old email is not a
real solution, so I should probably just give up and make a maintainer
profile ;)

Bjorn
