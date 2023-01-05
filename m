Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1719C65F325
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 18:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231206AbjAERvK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 12:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234449AbjAERvJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 12:51:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AB11C43F;
        Thu,  5 Jan 2023 09:51:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA2ED619EB;
        Thu,  5 Jan 2023 17:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9B88C433EF;
        Thu,  5 Jan 2023 17:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1672941067;
        bh=59bZNOt1x6/Jbg96nKL7QY/U4jPQXFSnz9gEyfFtdiQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=uIvaeRKZ18cEoPn/Do/GgNdkEk+J+tyoHUA89kiEOmKm79fw+GGoJnstth5GSj5mP
         9sYYqYfcFrgffRKLqYxqFf0qrL2a0LXhFgke9ssotMbATP1YnR1yGS9kglAdRefSWS
         9ka61n5fdGY3rjP0+dH0R5MeSnTa4u019LmD1Dh7zOKXtTuuFGQYmxs4rb5+mmPr7H
         EjZLFL6qWjUezOeWmfs//tJPepQHOj60EP6lAfRX2fV0ZDGZW8J21U90YNninS+lQ2
         mo1JwsOP+CkiE+7t77w/lLUgXYaZ+QTfYtIcmBOx6K6vhfsKqA56L7MtBDkBSVY8N9
         LqHCR1kCbiUDg==
Date:   Thu, 5 Jan 2023 11:51:05 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tony Luck <tony.luck@intel.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, bhelgaas@google.com,
        hdegoede@redhat.com, kernelorg@undead.fr, kjhambrick@gmail.com,
        2lprbe78@duck.com, nicholas.johnson-opensource@outlook.com.au,
        benoitg@coeus.ca, mika.westerberg@linux.intel.com,
        wse@tuxedocomputers.com, mumblingdrunkard@protonmail.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        david.e.box@intel.com, yunying.sun@intel.com
Subject: Re: Bug report: the extended PCI config space is missed with 6.2-rc2
Message-ID: <20230105175105.GA1155450@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7cL8pIqLrwv2z7+@agluck-desk3.sc.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 05, 2023 at 09:42:10AM -0800, Tony Luck wrote:
> On Wed, Jan 04, 2023 at 09:45:11AM -0600, Bjorn Helgaas wrote:
> > My understanding is that EfiMemoryMappedIO tells the OS to map the
> > area for use by runtime services, but is not intended to prevent the
> > OS from using the area.  Some platforms use EfiMemoryMappedIO for PCI
> > host bridge apertures, and of course the OS needs to use those.
> > 
> > If your firmware folks disagree and think Linux should be able to
> > figure this out differently, I would love to have a conversation about
> > how to do this.
> 
> It seems that 07eab0901ede ("efi/x86: Remove EfiMemoryMappedIO from E820 map")
> is also the cause of breakage for drivers/edac/sb_edac.c. It is broken
> in v6.2-rc2 and reverting this commit makes it work again.
> 
> This ancient driver probably plays fast and loose with how it ought to
> access extended PCIe config space ... but it needs to do this to read various
> memory controller configuration registers to do address translation from
> a system physical address to a DIMM address.

Hi Tony, can you share a dmesg log?  Does it look like the same thing
Kan reported, where the ECAM space is reported only via an
EfiMemoryMappedIO region and is not otherwise reserved by firmware?

Bjorn
