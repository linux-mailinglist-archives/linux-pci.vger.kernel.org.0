Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3CA41E82E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 09:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352435AbhJAHSd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Oct 2021 03:18:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:42394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1352430AbhJAHSd (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 1 Oct 2021 03:18:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD51D61268;
        Fri,  1 Oct 2021 07:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1633072609;
        bh=0AwT4s57SsmaSiU08cgPNAiFUVBKybKfyZaKCHWQPTg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=J7WVP8UAE7DTCVTGhG6UyS92juKOQG4yPLq3USsrvlqOR5C1fKQmNL3UYOIE23RPI
         iMCzitJj7vltJkk7SFQ06/rtFibcX6K3O93K4kVFpjHV1goLIWmZtI4fz/JAB+Hbph
         Ygxw+B8QQURQz3M3RJJLEQInGNXi5uyAtqIUPD/Q=
Date:   Fri, 1 Oct 2021 09:16:47 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, andriy.shevchenko@linux.intel.com,
        srinivas.pandruvada@intel.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] platform/x86: Add Intel Software Defined Silicon
 driver
Message-ID: <YVa13/iTdZR6xkiq@kroah.com>
References: <20211001012815.1999501-1-david.e.box@linux.intel.com>
 <20211001012815.1999501-6-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211001012815.1999501-6-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 30, 2021 at 06:28:15PM -0700, David E. Box wrote:
> Intel Software Defined Silicon (SDSi) is a post manufacturing mechanism for
> activating additional silicon features. Features are enabled through a
> license activation process.  The SDSi driver provides a per socket, ioctl
> interface for applications to perform 3 main provisioning functions:
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
> The ioctl operations perform function specific mailbox commands that
> forward the requests to SDSi hardware to perform authentication of the
> payloads and enable the silicon configuration (to be made available after
> power cycling).
> 
> The SDSi device itself is enumerated as an auxiliary device from the
> intel_extended_caps driver and as such has a build dependency on
> CONFIG_INTEL_EXTENDED_CAPS.
> 
> Link: https://github.com/intel/intel-sdsi
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

I do not see the "required" review that Intel developers need when
sending stuff to me.  What happened here?

thanks,

greg k-h
