Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE5723B3027
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 15:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232047AbhFXNh6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 09:37:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58458 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232017AbhFXNhq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 09:37:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C60B613DC;
        Thu, 24 Jun 2021 13:35:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624541726;
        bh=Im8AJ/xzLG5igrCZBPvx/X/s8SqGh6KWTqyck17cCoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JMLHRQ28OMZLW0wpvUm9Xlwqyt9Io+/duHqoiOloEkUkX/Z+6wqU/OyjDHWs6Lntt
         5QIdEoOiCKJecySIuqaNnTytjdIkfTjeATJDukQ/7TLjS1RN5+KZWhulco76hoOX9F
         U6o29EcMkWGSpT+pTyVkK77jJjZVWw2k/R93MySk=
Date:   Thu, 24 Jun 2021 15:35:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     rafael@kernel.org, rafael.j.wysocki@intel.com, will@kernel.org,
        robin.murphy@arm.com, joro@8bytes.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        bhelgaas@google.com, robdclark@chromium.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        quic_c_gdjako@quicinc.com, iommu@lists.linux-foundation.org,
        sonnyrao@chromium.org, saiprakash.ranjan@codeaurora.org,
        linux-mmc@vger.kernel.org, vbadigan@codeaurora.org,
        rajatja@google.com, saravanak@google.com, joel@joelfernandes.org,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] drivers: base: Add the concept of "pre_probe" to
 drivers
Message-ID: <YNSKHAiS3qIOwDVA@kroah.com>
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.1.Id4ee5788c993294f66542721fca7719c00a5d8f3@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621165230.1.Id4ee5788c993294f66542721fca7719c00a5d8f3@changeid>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 21, 2021 at 04:52:43PM -0700, Douglas Anderson wrote:
> Right now things are a bit awkward if a driver would like a chance to
> run before some of the more "automatic" things (pinctrl, DMA, IOMMUs,
> ...) happen to a device. This patch aims to fix that problem by
> introducing the concept of a "pre_probe" function that drivers can
> implement to run before the "automatic" stuff.
> 
> Why would you want to run before the "automatic" stuff? The incentive
> in my case is that I want to be able to fill in some boolean flags in
> the "struct device" before the IOMMU init runs. It appears that the
> strictness vs. non-strictness of a device's iommu config is determined
> once at init time and can't be changed afterwards. However, I would
> like to avoid hardcoding the rules for strictness in the IOMMU
> driver. Instead I'd like to let individual drivers be able to make
> informed decisions about the appropriateness of strictness
> vs. non-strictness.
> 
> The desire for running code pre_probe is likely not limited to my use
> case. I believe that the list "qcom_smmu_client_of_match" is hacked
> into the iommu driver specifically because there was no real good
> framework for this. For the existing list it wasn't _quite_ as ugly as
> my needs since the decision could be made solely on compatible string,
> but it still feels like it would have been better for individual
> drivers to run code and setup some state rather than coding up a big
> list in the IOMMU driver.
> 
> Even without this patch, I believe it is possible for a driver to run
> before the "automatic" things by registering for
> "BUS_NOTIFY_BIND_DRIVER" in its init call, though I haven't personally
> tested this. Using the notifier is a bit awkward, though, and I'd
> rather avoid it. Also, using "BUS_NOTIFY_BIND_DRIVER" would require
> drivers to stop using the convenience module_platform_driver() helper
> and roll a bunch of boilerplate code.
> 
> NOTE: the pre_probe here is listed in the driver structure. As a side
> effect of this it will be passed a "struct device *" rather than the
> more specific device type (like the "struct platform_device *" that
> most platform devices get passed to their probe). Presumably this
> won't cause trouble and it's a lot less code to write but if we need
> to make it more symmetric that's also possible by touching more files.

No, please please no.

If a bus really wants to do crud like this, it can do it in it's own
probe callback, the driver core doesn't need to mess with this.

If you need to mess with iommu values in struct device, again, do that
in the bus core for the devices on that specific bus, that's where those
values are supposed to be set anyway, right?

If the iommu drivers need to be run before a specific bus is
initialized, then fix that there, the driver core does not need to care
about this at all.

so a big NACK on this one, sorry.

greg k-h
