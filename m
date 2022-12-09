Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F123648A5F
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 22:52:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbiLIVwP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 16:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbiLIVwO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 16:52:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06C4E96574;
        Fri,  9 Dec 2022 13:52:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95F0A6234F;
        Fri,  9 Dec 2022 21:52:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CED66C433D2;
        Fri,  9 Dec 2022 21:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670622733;
        bh=rCgoEKsboTnL4Z1WodJeBu08+BLRkSWIVTHZ3gPfK7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=T0qoK928jpTta9mAhw0BQnzrBzkKsvseRYnTin/0INEIzInZVay2nZaE1nFVvAXBr
         YrB0Y4+88P3LgBGI4QUzXTl704cEbl8cLc3PYpNXQGj2GA69uuO2xkeTP7ItzWtwvI
         WkwAA9ixLnfAnVFc4QytL8xw4k3axU2d5ngmFvim0a8/lRvsSxe+pPFmhmdp2iyc8v
         PDVPuUCbHuA9l0Fj4Ryx12IRyJCMigieJnCh7XpyBBBtnLGrvZJmIgBmhI62LW+eWF
         ngeqL+mGPseDeC8yN77oEKEpe+QWFNhd1EfcyAHz3VthHomfiyudAXE2rNvK47UOOI
         qRxI69y4DkCMQ==
Date:   Fri, 9 Dec 2022 15:52:11 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>,
        Florent DELAHAYE <kernelorg@undead.fr>,
        Konrad J Hambrick <kjhambrick@gmail.com>,
        Matt Hansen <2lprbe78@duck.com>,
        Benoit =?iso-8859-1?Q?Gr=E9goire?= <benoitg@coeus.ca>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        mumblingdrunkard@protonmail.com, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 4/4] x86/PCI: Fix log message typo
Message-ID: <20221209215211.GA1736471@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5OqPSV2RDdkAITE@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 11:35:57PM +0200, Andy Shevchenko wrote:
> On Fri, Dec 09, 2022 at 02:51:31PM -0600, Bjorn Helgaas wrote:
> > On Fri, Dec 09, 2022 at 08:43:06PM +0200, Andy Shevchenko wrote:
> > > On Thu, Dec 08, 2022 at 01:03:41PM -0600, Bjorn Helgaas wrote:
> 
> ...
> 
> > > Wondering if we can change printk(KERN_LVL) to pr_lvl() in this file.
> > 
> > Sure!  How about this?
> 
> LGTM, you can add
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> to it if you wish.

Done, thanks!

> >     Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> 
> I prefer @linux.intel.com.

Oops, sorry, I should have known that.  I had copied that from
the From: line of your email
(https://lore.kernel.org/r/Y5OBupWBghHfvG/h@smile.fi.intel.com)

Bjorn
