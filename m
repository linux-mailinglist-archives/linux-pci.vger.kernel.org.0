Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30FC9648991
	for <lists+linux-pci@lfdr.de>; Fri,  9 Dec 2022 21:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiLIUeh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Dec 2022 15:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbiLIUef (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Dec 2022 15:34:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7570A0F8C;
        Fri,  9 Dec 2022 12:34:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9ABC0B82910;
        Fri,  9 Dec 2022 20:34:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A44C433D2;
        Fri,  9 Dec 2022 20:34:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670618071;
        bh=wF/qJ8p4Dt1qyWYoPb64JOwvPm2FZXbvLGZy18g2B4M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=D8F41nFcKUPH88ZiN36MH+J39qBZ1KyyRA/tO2+7W+tNezWtceZkT8Qnv4mf2ySUX
         tEEbOE9GC7xboypRIYLrXUfXqITLt2fgaORdhUClbVRZz5aliimXgsXr8AHdbbJg45
         wKvVvrMrKantXbRFty1yUDr1VkrOSUXAhojeRxDO9T6DReN7WKHvKoMSbcJvPWChuX
         bzsplxc802BwJNW5a8UgSzc2HBiQWAhEP31KIJsYta7xrn6K8ECcRiRwZvQe8TcLnX
         aauBjD+PZHHOVh3yJstRYoXLREvKKWPfaOSHZKawoAzi7B4YlK1/PnD3EqOaYWjFLP
         GYHd6mb11XDgw==
Date:   Fri, 9 Dec 2022 14:34:28 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@intel.com>
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
Subject: Re: [PATCH v2 3/4] x86/PCI: Tidy E820 removal messages
Message-ID: <20221209203428.GA1721600@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y5OBfjKXFc5d88i1@smile.fi.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Dec 09, 2022 at 08:42:06PM +0200, Andy Shevchenko wrote:
> On Thu, Dec 08, 2022 at 01:03:40PM -0600, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > These messages:
> > 
> >   clipped [mem size 0x00000000 64bit] to [mem size 0xfffffffffffa0000 64bit] for e820 entry [mem 0x0009f000-0x000fffff]
> > 
> > aren't as useful as they could be because (a) the resource is often
> > IORESOURCE_UNSET, so we print the size instead of the start/end and (b) we
> > print the available resource even if it is empty after removing the E820
> > entry.
> > 
> > Print the available space by hand to avoid the IORESOURCE_UNSET problem and
> > only if it's non-empty.  No functional change intended.
> 
> ...
> 
> > +			if (avail->end > avail->start)
> > +				pr_info("resource: remaining [mem %#010llx-%#010llx] available\n",
> > +					(unsigned long long) avail->start,
> > +					(unsigned long long) avail->end);
> 
> Is there any point why we do not use %pa for resource_size_t parameters?

Only my ignorance :)  Thanks for pointing that out; I changed it to
this and added a comment about why:


--- a/arch/x86/kernel/resource.c
+++ b/arch/x86/kernel/resource.c
@@ -42,8 +42,16 @@ static void remove_e820_regions(struct resource *avail)
 
 		resource_clip(avail, e820_start, e820_end);
 		if (orig.start != avail->start || orig.end != avail->end) {
-			pr_info("clipped %pR to %pR for e820 entry [mem %#010Lx-%#010Lx]\n",
-				 &orig, avail, e820_start, e820_end);
+			pr_info("resource: avoiding allocation from e820 entry [mem %#010Lx-%#010Lx]\n",
+				e820_start, e820_end);
+			if (avail->end > avail->start)
+				/*
+				 * Use %pa instead of %pR because "avail"
+				 * is typically IORESOURCE_UNSET, so %pR
+				 * shows the size instead of addresses.
+				 */
+				pr_info("resource: remaining [mem %pa-%pa] available\n",
+					&avail->start, &avail->end);
 			orig = *avail;
 		}
 	}
