Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAC4746D807
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 17:23:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbhLHQ0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 11:26:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:39434 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbhLHQ0r (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 11:26:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 054ADB8218D;
        Wed,  8 Dec 2021 16:23:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17266C00446;
        Wed,  8 Dec 2021 16:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638980592;
        bh=Qx16wH8UrnkDF93JHRoMnbl1vvNEPLKXoFyCVGMyZvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BYt6Mg567BFx/T9gLfXr9WjTFfkJ10A5n0X5F+ZKSAkYrXbT4mLDNbDihJ95XNl67
         pm5vA87ObgWbC05R1c5ZtnHcmsNhSQUADdDBgyaepJhzTiYoKGIy09VmYiLL4jOO3u
         vLpPVJwlbri5sw8cwu0DMG4iRW0dZRWQJT/Heg8g=
Date:   Wed, 8 Dec 2021 17:23:10 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH RESEND V2 4/6] platform/x86: Add Intel Software Defined
 Silicon driver
Message-ID: <YbDb7hhIxww8Mmal@kroah.com>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
 <20211208015015.891275-5-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208015015.891275-5-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 07, 2021 at 05:50:13PM -0800, David E. Box wrote:
> Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> activating additional silicon features. Features are enabled through a
> license activation process.  The SDSi driver provides a per socket, sysfs
> attribute interface for applications to perform 3 main provisioning
> functions:
> 
> 1. Provision an Authentication Key Certificate (AKC), a key written to
>    internal NVRAM that is used to authenticate a capability specific
>    activation payload.
> 
> 2. Provision a Capability Activation Payload (CAP), a token authenticated
>    using the AKC and applied to the CPU configuration to activate a new
>    feature.
> 
> 3. Read the SDSi State Certificate, containing the CPU configuration
>    state.
> 
> The operations perform function specific mailbox commands that forward the
> requests to SDSi hardware to perform authentication of the payloads and
> enable the silicon configuration (to be made available after power
> cycling).
> 
> The SDSi device itself is enumerated as an auxiliary device from the
> intel_vsec driver and as such has a build dependency on CONFIG_INTEL_VSEC.
> 
> Link: https://github.com/intel/intel-sdsi
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Reviewed-by: Mark Gross <markgross@kernel.org>
> ---
> V2
>   - Use sysfs_emit() in guid_show()
>   - Fix language in ABI, suggested by Bjorn
>   - Fix wrong directory name in ABI doc
> 
>  .../ABI/testing/sysfs-driver-intel_sdsi       |  77 +++
>  MAINTAINERS                                   |   5 +
>  drivers/platform/x86/intel/Kconfig            |  12 +
>  drivers/platform/x86/intel/Makefile           |   2 +
>  drivers/platform/x86/intel/sdsi.c             | 571 ++++++++++++++++++
>  drivers/platform/x86/intel/vsec.c             |  12 +-
>  6 files changed, 678 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel_sdsi
>  create mode 100644 drivers/platform/x86/intel/sdsi.c

Again, no release functions?

odd.

