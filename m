Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B62C33B3056
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 15:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbhFXNps (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 09:45:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:33594 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230296AbhFXNps (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 09:45:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3206861057;
        Thu, 24 Jun 2021 13:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624542208;
        bh=hRckpi5VkGxaL5vSwwKHDFfALYzxZOvFQpIv1uvauvM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eR3j4tJEMffYTFhMXxw8pGFP6btHuKW2ZhmD8KKSMaMEzBtVCdpcqPosqKFjRmEVd
         LXyeDZI72LtPpFTuZvyvtgeaqF9kS2ljg9CnXKPOLkIEsFKADjtBzZqvasU41av9VU
         IiIbZy9TQkz1lTNN8seLd6Wv7OoDi4t//kz/qBKY=
Date:   Thu, 24 Jun 2021 15:43:26 +0200
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
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] mmc: sdhci-msm: Request non-strict IOMMU mode
Message-ID: <YNSL/r+fOz6KMuwI@kroah.com>
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.6.Icde6be7601a5939960caf802056c88cd5132eb4e@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621165230.6.Icde6be7601a5939960caf802056c88cd5132eb4e@changeid>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 21, 2021 at 04:52:48PM -0700, Douglas Anderson wrote:
> IOMMUs can be run in "strict" mode or in "non-strict" mode. The
> quick-summary difference between the two is that in "strict" mode we
> wait until everything is flushed out when we unmap DMA memory. In
> "non-strict" we don't.
> 
> Using the IOMMU in "strict" mode is more secure/safer but slower
> because we have to sit and wait for flushes while we're unmapping. To
> explain a bit why "non-strict" mode is unsafe, let's imagine two
> examples.
> 
> An example of "non-strict" being insecure when reading from a device:
> a) Linux driver maps memory for DMA.
> b) Linux driver starts DMA on the device.
> c) Device write to RAM subject to bounds checking done by IOMMU.
> d) Device finishes writing to RAM and signals transfer is finished.
> e) Linux driver starts unmapping DMA memory but doesn't flush.

Why doesn't it "flush"?

> f) Linux driver validates that the data in memory looks sane and that
>    accessing it won't cause the driver to, for instance, overflow a
>    buffer.
> g) Device takes advantage of knowledge of how the Linux driver works
>    and sneaks in a modification to the data after the validation but
>    before the IOMMU unmap flush finishes.
> h) Device has now caused the Linux driver to access memory it
>    shouldn't.

So you are now saying we need to not trust hardware?  If so, that's a
massive switch for how the kernel needs to work right?

And what driver does f) and allows g) to happen?  That would be a normal
bug anyway, why not just fix the driver?

> An example of "non-strict" being insecure when writing to a device:
> a) Linux driver writes data intended for the device to RAM.
> b) Linux driver maps memory for DMA.
> c) Linux driver starts DMA on the device.
> d) Device reads from RAM subject to bounds checking done by IOMMU.
> e) Device finishes reading from RAM and signals transfer is finished.
> f) Linux driver starts unmapping DMA memory but doesn't flush.

Why does it not flush?

What do you mean by "flush"

> g) Linux driver frees memory and returns it to the pool.

What pool?

> h) Memory is allocated for another purpose.

Allocated by what?

We have memory allocators that write over the data when freed, why not
just use this if you are concerned about this type of issue?

> i) Device takes advantage of the period of time before IOMMU flush to
>    read memory that it shouldn't have had access to.

What memory would that be?

And if you really care about these issues, are you not able to take the
"hit" for the flush all the time as that is a hardware thing, not a
software thing.  Why not just always take advantage of that, no driver
changes needed?

And this isn't going to work, again, because the "pre_probe" isn't going
to be acceptable, sorry.

greg k-h
