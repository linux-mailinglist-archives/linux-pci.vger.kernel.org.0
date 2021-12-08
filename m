Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A78246D80D
	for <lists+linux-pci@lfdr.de>; Wed,  8 Dec 2021 17:24:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbhLHQ2J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Dec 2021 11:28:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236757AbhLHQ2I (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Dec 2021 11:28:08 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C20A7C061746;
        Wed,  8 Dec 2021 08:24:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 0D66ACE2217;
        Wed,  8 Dec 2021 16:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CD4EC00446;
        Wed,  8 Dec 2021 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1638980673;
        bh=SmpUb8pQKAosOLfT1/noujmv2wKXUQ70vjh2C2TVP+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p9KdOcqq+YCjTOOQmaYm4JfnXk29L1agRnpqYxzhAXNXjXsfSyrdsqLCaXl5vvrVN
         G/ZLgPG1H4mgd10ZZeCFpQaikA+SmWDMsvXHuRRUymIdAadFD/TfRBt/ktGIYwz6xn
         VBQOCPDyLUiNXUc+y9AiysmWu/ZffaEDzQR/Exio=
Date:   Wed, 8 Dec 2021 17:24:30 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     lee.jones@linaro.org, hdegoede@redhat.com, bhelgaas@google.com,
        andriy.shevchenko@linux.intel.com, srinivas.pandruvada@intel.com,
        mgross@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH RESEND V2 4/6] platform/x86: Add Intel Software Defined
 Silicon driver
Message-ID: <YbDcPipY/SbV3Gvs@kroah.com>
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

There is no code at this link :(

