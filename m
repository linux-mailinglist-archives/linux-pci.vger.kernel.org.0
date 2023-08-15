Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C117677D68F
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 01:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240555AbjHOXPi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 19:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240565AbjHOXPW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 19:15:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1EFBB3;
        Tue, 15 Aug 2023 16:15:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5449260F0A;
        Tue, 15 Aug 2023 23:15:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8248BC433C7;
        Tue, 15 Aug 2023 23:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692141320;
        bh=pa2nvZfQw/bdnEHOh3aiTLrBqJ4/hUwiSG2TjOGJLQg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=c4c9Gl+MoIkUJ+7vUF6e87lxuQumIH4uoBbaCKDZS6AsNOCP1d23AqczDntDGSheX
         K7MUydOcC7kHIuRM7sXHY0ZuFV+aYc4mnpNAllllNW3VRHFs/yhWhaTrXb4bE0BzwO
         9zepIF0W5oFdayEF4tyOCB6/mO8TZ+0X70Fzfa3fsUwaRwpxLAgDG6nKIJUIL0SRGl
         xW6wZFitUH4Xo04qLa9xu+0WXOMBcKifSelsUBScE7XsweU4kdE6Oy+LOJ8qoxh85r
         SxGQNb7WUPUvFWEJ/GD4pf0AYK7RFnKS/wZyBX9+XqZ8yvYPTMTC8m4h0TX4pBUCQO
         jXSKwH+654o5Q==
Date:   Tue, 15 Aug 2023 18:15:17 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     deloptes <emanoil.kotsev@deloptes.org>
Cc:     linux-pci@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: SSD SATA 3.3 and Broadcom / LSI SAS1068E PCI-Express Fusion-MPT
 SAS
Message-ID: <20230815231517.GA271814@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ubgv7c$43t$1@ciao.gmane.io>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 16, 2023 at 12:46:03AM +0200, deloptes wrote:
> Bjorn Helgaas wrote:
> ...

> > I think some controllers have a BIOS setup user interface; have you
> > poked around in there?
> 
> I have not seen the bios of the machine for many years. I was looking
> forward to plug it to a console, so that I can reboot remotely, but for
> some reason it was not possible. It was may be 5y ago. I will definitely
> double check this, allthough there will be nothing regarding SATA3.3 there
> as these were build many years before SATA3.3 saw daylight.

I saw some mention about BIOS knobs that controlled the minimum
acceptable SATA link speed or something; that's the kind of thing I
wondered about.

> As mentioned in the other posting I will attach those SSDs directly to the
> mobo. There are 6 SATA ports there. I think this is the best approach.
> But you know curiosity is a force you can not resist, so I still want to
> know why?! :)

Haha, yeah, I know!  I noticed in your response to Sathya that you're
running a 4.19.288 kernel, which is really, really old.  If it's
practical, the first thing I would try is booting a current kernel,
e.g., v6.4, on the chance that something has been fixed since v4.19.
I didn't try to compare the mptsas driver to see if it has changed
since then, so I don't know whether it's likely.

Bjorn
