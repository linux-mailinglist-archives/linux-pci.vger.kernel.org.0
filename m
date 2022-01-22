Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D12496CBA
	for <lists+linux-pci@lfdr.de>; Sat, 22 Jan 2022 15:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232815AbiAVOqK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 22 Jan 2022 09:46:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiAVOqJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 22 Jan 2022 09:46:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC974C06173B;
        Sat, 22 Jan 2022 06:46:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 080D760DED;
        Sat, 22 Jan 2022 14:46:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3472C004E1;
        Sat, 22 Jan 2022 14:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642862768;
        bh=ud+t0dBFtbGXTAeSHGtRbHQmpNVgLMkB+7Q5Tq5bKYM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Hzt2jMtwhe+NtGLqd11rmipGL1ZXOy+RSMYM4b6zdKJalc4NP9UviqVJVvO+R3RJX
         L+Pz6dQSOaGZqFrRCR2SkDtfK5dlDYZTbq9oi4h3wCe0WPtn3FDyjwUS/W/F8KFMmy
         tymNXhQ1sdQiNc5OBsJaDZjbgZXJNvU3ttv9dYCc=
Date:   Sat, 22 Jan 2022 15:46:05 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Rajat Jain <rajatja@google.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, rajatxjain@gmail.com,
        dtor@google.com, jsbarnes@google.com,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH] PCI: ACPI: Allow internal devices to be marked as
 untrusted
Message-ID: <YewYrQeHsJWpNI5p@kroah.com>
References: <20220120000409.2706549-1-rajatja@google.com>
 <20220121214117.GA1154852@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220121214117.GA1154852@bhelgaas>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jan 21, 2022 at 03:41:17PM -0600, Bjorn Helgaas wrote:
> [+cc Greg, Jean-Philippe, Mika, Pavel, Oliver, Joerg since they
> commented on previous "external-facing" discussion]
> 
> On Wed, Jan 19, 2022 at 04:04:09PM -0800, Rajat Jain wrote:
> > Today the pci_dev->untrusted is set for any devices sitting downstream
> > an external facing port (determined via "ExternalFacingPort" property).
> > This however, disallows any internal devices to be marked as untrusted.
> 
> This isn't stated quite accurately.  "dev->untrusted" is currently set
> only by set_pcie_untrusted(), when "dev" has an upstream bridge that
> is either external-facing or untrusted.
> 
> But that doesn't disallow or prevent internal devices from being
> marked as untrusted; it just doesn't implement that.
> 
> > There are use-cases though, where a platform would like to treat an
> > internal device as untrusted (perhaps because it runs untrusted
> > firmware, or offers an attack surface by handling untrusted network
> > data etc).

Who is making this policy decision?

> > This patch introduces a new "UntrustedDevice" property that can be used
> > by the firmware to mark any device as untrusted.

Is this in the ACPI standard?  If so, where?

This notion of "trust" for PCI devices is crazy, as I have stated a
number of times before.  But at least you are not trying to say kernel
code is trusted or not.

thanks,

greg k-h
