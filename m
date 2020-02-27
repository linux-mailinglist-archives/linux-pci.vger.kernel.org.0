Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42188172BBE
	for <lists+linux-pci@lfdr.de>; Thu, 27 Feb 2020 23:49:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgB0Wtd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Feb 2020 17:49:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:47160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726845AbgB0Wtc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Feb 2020 17:49:32 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D0C79246A1;
        Thu, 27 Feb 2020 22:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582843772;
        bh=9yKc/e6VcXVqziF8urj2FFyiwuVGnAgdVsS7OTQTt3w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=BKL6tO98C/MKfs1ioY0s9UzQGIQAfNKkkDI59ybMMbUeR5ZDsBi3N/CqTWAATMVJS
         Az5R5T59PHMPa6DR6p7X6+DU/AhBTxeqlqkapmz/Q+VO7DGxDLnR890A9x0Bzm2m5k
         blRRYgxQfTuR8Rmb7ephwImEtxmuhvDZ4lNLgxO8=
Date:   Thu, 27 Feb 2020 16:49:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     tglx@linutronix.de, corbet@lwn.net, mingo@redhat.com, bp@alien8.de,
        x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kar.hin.ong@ni.com, sassmann@kpanic.de
Subject: Re: [PATCH v2 0/2] pci: Add boot interrupt quirk mechanism for Xeon
 chipsets
Message-ID: <20200227224930.GA158759@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200220192930.64820-1-sean.v.kelley@linux.intel.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 20, 2020 at 11:29:28AM -0800, Sean V Kelley wrote:
> Changes since v1 [1]:
> 
> - Correct Documentation section title for 6300ESB chipset.
> (Jonathan Derrick)
> 
> - Use consistent abbreviations in comments for IO-APIC and Core IO.
> (Andy Shevchenko)
> 
> - Retained Reviewed-by tag due to no technical changes.
> 
> [1]: https://lore.kernel.org/lkml/20200214213313.66622-1-sean.v.kelley@linux.intel.com/
> 
> Bjorn, I'm open for it to go to stable as well.
> 
> --
> 
> When IRQ lines on secondary or higher IO-APICs are masked (e.g.,
> Real-Time threaded interrupts), many chipsets redirect IRQs on
> this line to the legacy PCH and in turn the base IO-APIC in the
> system. The unhandled interrupts on the base IO-APIC will be
> identified by the Linux kernel as Spurious Interrupts and can
> lead to disabled IRQ lines.
> 
> Disabling this legacy PCI interrupt routing is chipset-specific and
> varies in mechanism between chipset vendors and across generations.
> In some cases the mechanism is exposed to BIOS but not all BIOS
> vendors chose to pick it up. With the increasing usage of RT as it
> marches towards mainline, additional issues have been raised with
> more recent Xeon chipsets.
> 
> This patchset disables the boot interrupt on these Xeon chipsets where
> this is possible with an additional mechanism. In addition, this
> patchset includes documentation covering the background of this quirk.
> 
> 
> Sean V Kelley (2):
>   pci: Add boot interrupt quirk mechanism for Xeon chipsets
>   Documentation:PCI: Add background on Boot Interrupts
> 
>  Documentation/PCI/boot-interrupts.rst | 153 ++++++++++++++++++++++++++
>  Documentation/PCI/index.rst           |   1 +
>  drivers/pci/quirks.c                  |  80 ++++++++++++--
>  3 files changed, 227 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/PCI/boot-interrupts.rst

Applied to pci/interrupts for v5.7.  I added a stable tag.

Thanks a lot; this is really a nice piece of work!
