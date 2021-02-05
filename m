Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2C1A3113A9
	for <lists+linux-pci@lfdr.de>; Fri,  5 Feb 2021 22:38:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbhBEVhR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Feb 2021 16:37:17 -0500
Received: from mail.kernel.org ([198.145.29.99]:47482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231428AbhBEVgU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 5 Feb 2021 16:36:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FE2C64E33;
        Fri,  5 Feb 2021 21:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612560937;
        bh=DdV3puJoIUAMr/s6VqcnsjHVLLZz7/hEuNVUg6uEqr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WXnQygslAGdhYtulbGoXQfpbVV/FeclcekjvL8cf+D8iASdgvOPxyxEk69aWMGkyl
         V5dakCYY6z8qn+ecFQsCHas1R1Ehinr8O7G2+ql7hTazhivhxDC1a0Z2hnbk3Q8ztx
         aRNNdfY9gA1ga7sv9Uvhcal/BbnV41qSH/ipXJdr8KRKc8Ohrlz7lT4Sy6LfRcGxAZ
         +AAZFmG+I6pR04d6pvkA6fijtxVxSdiQxoZC3D1KG3Nca7OvklvojZWeLoY5Zi7jNW
         WKRO0HDf+ZCcD+FkobmlxUMK6Pthil9WmSn4lBBcZbdH/bD7O6/1p5invJ/UoMvQ5e
         hVME0bM7OFXRQ==
Date:   Fri, 5 Feb 2021 13:35:34 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Andrey Grodzovsky <Andrey.Grodzovsky@amd.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "s.miroshnichenko@yadro.com" <s.miroshnichenko@yadro.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Antonovitch, Anatoli" <Anatoli.Antonovitch@amd.com>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: Avoid MMIO write access after hot unplug [WAS - Re: Question
 about supporting AMD eGPU hot plug case]
Message-ID: <20210205213534.GA2657326@dhcp-10-100-145-180.wdc.com>
References: <20210205194541.GA191443@bjorn-Precision-5520>
 <c216efcc-6c81-8a7e-a823-1ddb62ebddb7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c216efcc-6c81-8a7e-a823-1ddb62ebddb7@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 05, 2021 at 03:42:01PM -0500, Andrey Grodzovsky wrote:
> On 2/5/21 2:45 PM, Bjorn Helgaas wrote:
> > On Fri, Feb 05, 2021 at 11:08:45AM -0500, Andrey Grodzovsky wrote:
> > > 
> > > For user mappings, including MMIO mappings, we have a reliable
> > > approach where we invalidate device address space mappings for all
> > > user on first sign of device disconnect and then on all subsequent
> > > page faults from the users accessing those ranges we insert dummy
> > > zero page into their respective page tables. It's actually the
> > > kernel driver, where no page faulting can be used such as for user
> > > space, I have issues on how to protect from keep accessing those
> > > ranges which already are released by PCI subsystem and hence can be
> > > allocated to another hot plugging device.
> > 
> > That doesn't sound reliable to me, but maybe I don't understand what
> > you mean by the "first sign of device disconnect."
> 
> See functions drm_dev_enter, drm_dev_exit and drm_dev_unplug in drm_derv.c
> 
> > At least from a PCI
> > perspective, the first sign of a surprise hot unplug is likely to be
> > an MMIO read that returns ~0.
> 
> We set drm_dev_unplug in amdgpu_pci_remove and base all later checks
> with drm_dev_enter/drm_dev_exit on this

It sounds like you are talking about an orderly notified unplug rather
than a surprise hot unplug. If it's a surprise, the code doesn't get to
fence off future MMIO access until well after the address range is
already unreachable.
