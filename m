Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0891C9F6D3
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2019 01:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726091AbfH0XY5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 19:24:57 -0400
Received: from lekensteyn.nl ([178.21.112.251]:39565 "EHLO lekensteyn.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725997AbfH0XY4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 19:24:56 -0400
X-Greylist: delayed 2697 seconds by postgrey-1.27 at vger.kernel.org; Tue, 27 Aug 2019 19:24:56 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lekensteyn.nl; s=s2048-2015-q1;
        h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=W755SOjG26JPvvqPajc576xDrzJZD3HASrkXEzOzrLI=;
        b=MGqMIq0TngzkjMrWN5ZznKdYTGRhaljhOyJFFa+R6hRDSBkhAifGf90vBV7+/zirmtsd3rsBO7SNclUcIx4Ll+F04TZC+iFvDmAoaACRWQHBYBgEZLtyWil+tRQAHg8XJbBxWywM2XkqUw4d9tkv/vzoVzu/uhwNF+mn1UrtZBwxqfo15hEPadoZ5cHaV731KoG5hJUWNqx3k+44s1x3UbPVj0B9O9n05yQtgvFYhx6wZEE7DIb6UomxHiUuML0NEXDEzmHBZLQ1TKArcthzqo5Sg5EAlCehV9qcbpKL+pryg5irvWfM/IcTpr+iChvGGYkX2FQdT2psvHeRGqGU5Q==;
Received: by lekensteyn.nl with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <peter@lekensteyn.nl>)
        id 1i2k81-0001HF-Ng; Wed, 28 Aug 2019 00:39:54 +0200
Date:   Tue, 27 Aug 2019 23:39:51 +0100
From:   Peter Wu <peter@lekensteyn.nl>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Dave Airlie <airlied@redhat.com>
Subject: Re: [PATCH 1/2] PCI: Add a helper to check Power Resource
 Requirements _PR3 existence
Message-ID: <20190827223951.GA27744@al>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
 <s5hr2567hrd.wl-tiwai@suse.de>
 <0379E973-651A-442C-AF74-51702388F55D@canonical.com>
 <20190827221321.GA9987@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190827221321.GA9987@google.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Spam-Score: -0.0 (/)
X-Spam-Status: No, hits=-0.0 required=5.0 tests=NO_RELAYS=-0.001 autolearn=unavailable autolearn_force=no
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 27, 2019 at 05:13:21PM -0500, Bjorn Helgaas wrote:
> [+cc Peter, Mika, Dave]
> 
> https://lore.kernel.org/r/20190827134756.10807-1-kai.heng.feng@canonical.com
> 
> On Wed, Aug 28, 2019 at 12:58:28AM +0800, Kai-Heng Feng wrote:
> > at 23:25, Takashi Iwai <tiwai@suse.de> wrote:
> > > On Tue, 27 Aug 2019 15:47:55 +0200,
> > > Kai-Heng Feng wrote:
> > > > A driver may want to know the existence of _PR3, to choose different
> > > > runtime suspend behavior. A user will be add in next patch.
> > > > 
> > > > This is mostly the same as nouveau_pr3_present().
> > > 
> > > Then it'd be nice to clean up the nouveau part, too?
> > 
> > nouveau_pr3_present() may call pci_d3cold_disable(), and my intention is to
> > only check the presence of _PR3 (i.e. a dGPU) without touching anything.
> 
> It looks like Peter added that code with 279cf3f23870
> ("drm/nouveau/acpi: use DSM if bridge does not support D3cold").
> 
> I don't understand the larger picture, but it is somewhat surprising
> that nouveau_pr3_present() *looks* like a simple predicate with no
> side-effects, but in fact it disables the use of D3cold in some cases.

The reason for disabling _PR3 from that point on is because mixing the
ACPI firmware code that uses power resources (_PR3) with the legacy
_DSM/_PS0/_PS3 methods to manage power states could break as that
combination is unlikely to be supported nor tested by firmware authors.

If a user sets /sys/bus/pci/devices/.../d3cold_allowed to 0, then the
pci_d3cold_disable call ensures that this action is remembered and
prevents power resources from being used again.

For example, compare this power resource _OFF code:
https://github.com/Lekensteyn/acpi-stuff/blob/b55f6bdb/dsl/Clevo_P651RA/ssdt3.dsl#L454-L471

with this legacy _PS0/_PS3 code:
https://github.com/Lekensteyn/acpi-stuff/blob/b55f6bdb/dsl/Clevo_P651RA/ssdt7.dsl#L113-L142

The power resource code checks the "MSD3" variable to check whether a
transition to OFF is required while the legacy _PS3 checks "DGPS". The
sequence PG00._OFF followed by _DSM (to to change "OPCE") and _PS3 might
trigger some device-specific code twice and could lead to lockups
(infinite loops polling for power state) or worse. I am not sure if I
have ever tested this scenario however.

> If the disable were moved to the caller, Kai-Heng's new interface
> could be used both places.

Moving the pci_d3cold_disable call to the caller looks reasonable to me.
After the first patch gets merged, nouveau could use something like:

    *has_pr3 = pci_pr3_present(pdev);
    if (*has_pr3 && !pdev->bridge_d3) {
        /*
         * ...
         */
        pci_d3cold_disable(pdev);
        *has_pr3 = false;
    }


For the 1/2 patch,
Reviewed-by: Peter Wu <peter@lekensteyn.nl>
-- 
Kind regards,
Peter Wu
https://lekensteyn.nl
