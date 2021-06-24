Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 431F23B3039
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 15:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230087AbhFXNkl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 09:40:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:59912 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229878AbhFXNkk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 24 Jun 2021 09:40:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3923361002;
        Thu, 24 Jun 2021 13:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624541900;
        bh=+IAFywe/fQNi3yGadTzdfNAMDo97W+pVUgJlXiEOuT8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Zgrt8sAOUKv4aq0TAmi/6ugV5pAIMt9nN5X2GqMqbVzBs0rIDqvfl9v3Rw1sNMKsl
         cRDDLduiEb/vFKo2y+shFY6Vy4cmO6ixmrSknVR0tUeE958MWQGMl6xMx87iTN1jxp
         Om9wOnn1JosUsE5Xd3Ttb53ewALmoSYK+bzQ7qmc=
Date:   Thu, 24 Jun 2021 15:38:18 +0200
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
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/6] PCI: Indicate that we want to force strict DMA for
 untrusted devices
Message-ID: <YNSKyu/a8S3Qywbc@kroah.com>
References: <20210621235248.2521620-1-dianders@chromium.org>
 <20210621165230.3.I7accc008905590bb2b46f40f91a4aeda5b378007@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210621165230.3.I7accc008905590bb2b46f40f91a4aeda5b378007@changeid>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 21, 2021 at 04:52:45PM -0700, Douglas Anderson wrote:
> At the moment the generic IOMMU framework reaches into the PCIe device
> to check the "untrusted" state and uses this information to figure out
> if it should be running the IOMMU in strict or non-strict mode. Let's
> instead set the new boolean in "struct device" to indicate when we
> want forced strictness.
> 
> NOTE: we still continue to set the "untrusted" bit in PCIe since that
> apparently is used for more than just IOMMU strictness. It probably
> makes sense for a later patchset to clarify all of the other needs we
> have for "untrusted" PCIe devices (perhaps add more booleans into the
> "struct device") so we can fully eliminate the need for the IOMMU
> framework to reach into a PCIe device.

It feels like the iommu code should not be messing with pci devices at
all, please don't do this.

Why does this matter?  Why wouldn't a pci device use "strict" iommu at
all times?  What happens if it does not?  Why are PCI devices special?

greg k-h
