Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C0546D804
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 17:22:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhLHQZk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 11:25:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbhLHQZk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 11:25:40 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69776C061746;
        Wed,  8 Dec 2021 08:22:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id BB75DCE2213;
        Wed,  8 Dec 2021 16:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 219C4C00446;
        Wed,  8 Dec 2021 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638980525;
        bh=FnBm6pHrEInyoGl9hHMNdp7JFAy8nlMp6eKS4TSkJiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gXZ9btb1oMwm6WerzFbGZfBXRUC0u/4frB7LTNwqqLAs/LoJ6thqodJ20l2bwo54/
         48pkGlhI/32hmf000LNfZ/j/JT0DRQkxkAOOyVxc6qb22bpzi5FrvYGgCO4esP7c6x
         waUB/Yk4LGLuHw00Y2kQCmTfHTt83FEUK8+zX+gU=
Date:   Wed, 8 Dec 2021 17:22:02 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH RESEND V2 3/6] platform/x86/intel: Move intel_pmt from
 MFD to Auxiliary Bus
Message-ID: <YbDbql39x7Kw6iAC@kroah.com>
References: <20211208015015.891275-1-david.e.box@linux.intel.com>
 <20211208015015.891275-4-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211208015015.891275-4-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Dec 07, 2021 at 05:50:12PM -0800, David E. Box wrote:
> +static struct pci_driver intel_vsec_pci_driver = {
> +	.name = "intel_vsec",
> +	.id_table = intel_vsec_pci_ids,
> +	.probe = intel_vsec_pci_probe,
> +};

So when the PCI device is removed from the system you leak resources and
have dangling devices?

Why no PCI remove driver callback?

thanks,

greg k-h
