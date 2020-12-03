Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F6052CDA17
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 16:26:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727373AbgLCP0E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Dec 2020 10:26:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:58726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726820AbgLCP0D (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 10:26:03 -0500
Date:   Thu, 3 Dec 2020 09:25:20 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607009122;
        bh=t6uY6ro8Jkf/b2wDnMZ+UsDuM+Xx/9in/WQwjNSs57g=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=u/5ZqneflBgpH/J0WPKQMiC+LH9J+ai3mPOlIWHp59+o8tsRBJgzZiDzzydEr3Rkv
         deVpHeb3/gSZZPXEJRRPRbRrRGY9JaP8GhRrNUlYqBq2xI7gT4xi4IGs9erolFT6mY
         7zEZ7bs1Sp9uygmQTycQwcY0TewEZKqsQNPH4pi+tovI2v6hteMpGw5zmU8/BiP7UY
         brI5TnPCri/b98dDTmpVNGPVunYeOxYB+AzCY4Gq0yyT8acwzwYoAYQkv6/LCg5l/R
         oypADefLOyqgfyRIuldyzNfiJDHW1J8IgQ3XR1jcnLlZO9UyEKdHYzJKOFc3Psd6lp
         s6yt7DGusPWsQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Roper, Matthew D" <matthew.d.roper@intel.com>,
        "Pandey, Hariom" <hariom.pandey@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
Message-ID: <20201203152520.GA1554214@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160698518967.3553.11319067086667823352@jlahtine-mobl.ger.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 03, 2020 at 10:46:29AM +0200, Joonas Lahtinen wrote:
> Quoting Bjorn Helgaas (2020-12-02 22:22:53)
> > On Wed, Dec 02, 2020 at 05:21:58AM +0000, Surendrakumar Upadhyay, TejaskumarX wrote:
> > > Yes it fails all the tests which are allocating from this stolen
> > > memory bunch. For example IGT tests like "
> > > igt@kms_frontbuffer_tracking@-[fbc|fbcpsr].* |
> > > igt@kms_fbcon_fbt@fbc.* " are failing as they totally depend to work
> > > on stolen memory.
> 
> That's just because we have de-duped the stolen memory detection code.
> If it's not detected at the early quirks, it's not detected by the
> driver at all.
> 
> So if the patch is not merged to early quirks, we'd have to refactor the
> code to add alternative detection path to i915. Before that is done, the
> failures are expected.
> 
> > I'm sure that means something to graphics developers, but I have no
> > idea!  Do you have URLs for the test case source, outputs, dmesg log,
> > lspci info, bug reports, etc?
> 
> The thing is, the bug reports for stuff like this would only start to
> flow after Jasperlake systems are shipping widely and the less common
> OEMs start integrating it to into strangely behaving BIOSes. Or that
> is the assumption.
> 
> If it's fine to merge this through i915 for now with an Acked-by, like
> the previous patches, that'd be great. We can start a discussion on if
> the new platforms are affected anymore. But I'd rather not drop it
> before we have that understanding, as the previous problems have
> included boot time memory corruption.
> 
> Would that work?

Like I said, I'm not objecting if somebody else wants to apply this.

I'm just pointing out that there's a little bit of voodoo here because
it's not clear what makes a BIOS strangely behaving or what causes
boot-time memory corruption, and that means we don't really have any
hope of resolving this stream of quirk updates.

Bjorn
