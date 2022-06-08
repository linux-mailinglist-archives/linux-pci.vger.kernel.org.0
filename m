Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE70543B15
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 20:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbiFHSKD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 14:10:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbiFHSKC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 14:10:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2252CCBB;
        Wed,  8 Jun 2022 11:10:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 553CD61BA9;
        Wed,  8 Jun 2022 18:10:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BE1C3411D;
        Wed,  8 Jun 2022 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654711799;
        bh=SL+p50vdC56GXV52nZanm0Gl56oWFXJJxn/dx2xsIP8=;
        h=Date:From:To:Subject:In-Reply-To:From;
        b=DKJ+y+SAcKGHeFyigdlJMfYWDlfjebdHXpy1/81X4/AeXrkFRcNEmKeRLCBVGxZqg
         N5ULAbSIJSrXgrmLPIIHJLeDQZVLZSPbZ6DSc1Z2H2oRLg3JWNSRhPJ0iCtpPtrYWT
         NuRr5fmDLWKlwJ63P8toNPjmir6LO/nxm1Mj2wp8cszo1lW9B59GPU4VQHsb6CCe46
         HSUz+5Ux833qbNPrmy8jAmyM+Nwu/QvGvHxfsqmkv/MDlJeT2J1/edq9l4Wg2BUS26
         Rf0rSd2YnAOgxZNmNFZip9o3L8hF/yUGyuO9Gtss+MWaaE6SrzbktqIpZlbbRS+y2G
         CvHV8a7G1MfuQ==
Date:   Wed, 8 Jun 2022 13:09:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 0/2] video: fbdev: Convert from PCI to generic power
 management
Message-ID: <20220608180956.GA407517@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YqDNuhopLfpHkTS7@phenom.ffwll.local>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 08, 2022 at 06:26:34PM +0200, Daniel Vetter wrote:
> On Tue, Jun 07, 2022 at 06:11:10PM -0500, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > PCI-specific power management (pci_driver.suspend and pci_driver.resume) is
> > deprecated.  If drivers implement power management, they should use the
> > generic power management framework, not the PCI-specific hooks.
> > 
> > No fbdev drivers actually implement PCI power management, but there are a
> > cirrusfb has some commented-out references to it and skeletonfb has
> > examples of it.  Remove these.
> 
> Is this holding up some cleanup on your side and so would be easier to
> merge these through the pci tree? If so
> 
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> 
> for merging through your tree. Otherwise I guess Helge will get around to
> pile them up for 5.20 (or 6.0) eventually.

No particular rush and nothing depending on these.

I added your ack to my local branch and if nothing happens for a
while, I'll merge them via my tree.

Bjorn
