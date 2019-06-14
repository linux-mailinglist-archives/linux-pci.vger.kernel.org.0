Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 111CC45D84
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jun 2019 15:09:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbfFNNJy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 09:09:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:50574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbfFNNJy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 09:09:54 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 226DA20850;
        Fri, 14 Jun 2019 13:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560517793;
        bh=mRmGyxYQIkQ13DLqdtwewdMiIqXGLpO2s27nnAvEusc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sDo8l+VCaLY0E2B0VcPOXJD86BMdLEtB6UFDeuGir9oVeofgXDhiiPtktK4q2ik2R
         R0MFFQ1HdF7sQmeP58ldE+asbCA3VnsDXDDCM0HuKuvUPj5H4SxLsetcui8lh3/Fw0
         TL/3RAWfIln0isDW92XF/+iA1mvmZL2GaHu7I6mA=
Date:   Fri, 14 Jun 2019 08:09:52 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RFC PATCH v2] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
Message-ID: <20190614130952.GQ13533@google.com>
References: <5783e36561bb77a1deb6ba67e5a9824488cc69c6.camel@kernel.crashing.org>
 <20190613190248.GH13533@google.com>
 <e6c7854ae360be513f6f43729ed6d4052e289376.camel@kernel.crashing.org>
 <CAKv+Gu95pQ7_OfLbEXHZ_bhYnqOgTBKCmTgqUY27un-Y708BgQ@mail.gmail.com>
 <d5d3e7b9553438482854c97e09543afb7de23eaa.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5d3e7b9553438482854c97e09543afb7de23eaa.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 14, 2019 at 06:36:32PM +1000, Benjamin Herrenschmidt wrote:
> Linux can't change the switch configuration. I may have mentioned
> earlier it has to do with platform sec policies. But that's not totally
> relevant, we shoudn't be changing resources anyway since in theory
> runtime FW might rely on where some system devices were assigned at
> boot. EFI fb is another example of that.

"We shouldn't be changing resources anyway" is not really useful
guidance.  I completely agree that we shouldn't change things
*unnecessarily*, but it's up to the OS to define what makes it
necessary -- it might be for rebalancing for hotplug, to make space
for SR-IOV, to respect user requests to increase alignment, etc.

IMO the real value of _DSM #5 is as a mechanism to advertise
dependencies runtime firmware has on devices, e.g., SMM firmware might
want to log errors to a PCI remote management device.  If the OS moved
that managment device, the SMM logging would itself cause errors.

> The biggest issue for me right now is that the spec says pretty much at
> _DSM #5 = 0 is equivalent to _DSM #5 absent, and Bjorn seems keen on
> having it this way, but for arm64, we specifically want to distinguish
> those 2 cases.

Nope, my opinion is exactly the opposite.  Sorry that I'm not
communicating this clearly.

It's true that the r3.2 spec *does* say _DSM #5 = 0 is equivalent to
the situation where it's absent, but that's based on the assumption
that the OS is never allowed to change PCI configuration.  I think
that assumption is complete nonsense and should be disregarded.

  _DSM #5 = 0: OS must preserve this device's BARs
	       (current spec says "OS must not ignore")

  _DSM #5 = 1: OS *may* change this device's BARs
	       (current spec says "OS may ignore")

Other than _DSM #5, there's no spec I'm aware of that restricts the
OS's ability to change BARs.  Therefore I think "_DSM #5 = 1" is
equivalent to _DSM #5 being absent, and in both cases the OS is free
to change BARs as it sees fit.

> Looking at the spec (and followup discussions for specs updates), I'm
> quite keen on treating _DSM #5 = 1 as "wipe out the resource for that
> endpoint/bridge and realloc something better. There are reasons for
> that, but we can probably discuss that later.

I disagree on the "wipe out all resources" part of this because we
have no idea how to realloc something better.  We should of course
look for problems (overlapping devices, etc) and fix them.  But
starting from scratch and reallocating won't reliably produce anything
different from the original, supposedly broken, configuration.

Bjorn
