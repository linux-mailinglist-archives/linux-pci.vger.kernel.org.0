Return-Path: <linux-pci+bounces-8254-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3658FBA0E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 19:11:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40271C211DA
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 17:11:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 230AA148300;
	Tue,  4 Jun 2024 17:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HnS+rlV3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F108A146D6E;
	Tue,  4 Jun 2024 17:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717521084; cv=none; b=lVjNHVA2zEDeWQRwvHVRBZ4znhmOopVIeFj2Vej2ScOt1oHFqCNCTqRxAVr0/XBtc2RG+NIsat+jceWuRbcLBd7JomuXQAWo9vDWvKhLRLI4iJ5tqNUwbDp1SY4388FoTqSp3oEf2+pYGRNmkHFxcLrZth5bjyGJC7m+SfWptf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717521084; c=relaxed/simple;
	bh=QVWrmiQLsUU0GWwAK+Bb9M4f7QwhTLEcAJ5AgSI4RXA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=s1NBUuYVAjWaxxFOOVVppJy4+plghK66aPSQfl4U0V/Emhqf2Mm7HiMdr2dK/TsDH23S8ZwsOkEDnqelBj6Aja6YQJUL3jo+TEojfVE16W95GxOuXx2bmlwBfMgsg9KuBM3r0o5NK0QbUWKMyJXuCK5eid+WKeAu4vQ+MGVVkkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HnS+rlV3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D18C2BBFC;
	Tue,  4 Jun 2024 17:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717521083;
	bh=QVWrmiQLsUU0GWwAK+Bb9M4f7QwhTLEcAJ5AgSI4RXA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HnS+rlV37+gbi2r1Nn6pm/iDG98s5oB8Jx3PNZAUFBszOsUmTBdCwkK4H0sVNW5GQ
	 I+Z5KS55q9k/OmgZ9vp9R8oyGxkfFuOpqsEXLjjPeLHuPBaYFctSb6n79BqlEIdeqO
	 4dVCQBcdu24cp5F70jcP8l0DKHJhQH1dX+k0Am2IyobBVgQf66J95ckrd258XEQFRP
	 TY0f5RrLIS0AP/WOmUxLHYo5fyxJgM5wr/S+yZWxu+Sc51w7UyIakxgb/oei5RS4x5
	 3cG25VOKav9nFlO4C6R3xBwN6bXWCfCkkDcE8aRFmbzfowtM7DG7w/yGXKY9LIDRNH
	 X+l8dFSj3cVQw==
Date: Tue, 4 Jun 2024 12:11:21 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>, bhelgaas@google.com,
	Imre Deak <imre.deak@intel.com>,
	Jani Saarinen <jani.saarinen@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: Revert the cfg_access_lock lockdep mechanism
Message-ID: <20240604171121.GA730808@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87h6e9t9qt.fsf@kernel.org>

On Tue, Jun 04, 2024 at 11:03:54AM +0300, Kalle Valo wrote:
> Dan Williams <dan.j.williams@intel.com> writes:
> 
> > While the experiment did reveal that there are additional places that
> > are missing the lock during secondary bus reset, one of the places that
> > needs to take cfg_access_lock (pci_bus_lock()) is not prepared for
> > lockdep annotation.
> >
> > Specifically, pci_bus_lock() takes pci_dev_lock() recursively and is
> > currently dependent on the fact that the device_lock() is marked
> > lockdep_set_novalidate_class(&dev->mutex). Otherwise, without that
> > annotation, pci_bus_lock() would need to use something like a new
> > pci_dev_lock_nested() helper, a scheme to track a PCI device's depth in
> > the topology, and a hope that the depth of a PCI tree never exceeds the
> > max value for a lockdep subclass.
> >
> > The alternative to ripping out the lockdep coverage would be to deploy a
> > dynamic lock key for every PCI device. Unfortunately, there is evidence
> > that increasing the number of keys that lockdep needs to track to be
> > per-PCI-device is prohibitively expensive for something like the
> > cfg_access_lock.
> >
> > The main motivation for adding the annotation in the first place was to
> > catch unlocked secondary bus resets, not necessarily catch lock ordering
> > problems between cfg_access_lock and other locks. Solve that narrower
> > problem with follow-on patches, and just due to targeted revert for now.
> >
> > Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
> > Reported-by: Imre Deak <imre.deak@intel.com>
> > Closes: https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134186v1/shard-dg2-1/igt@device_reset@unbind-reset-rebind.html
> > Cc: Jani Saarinen <jani.saarinen@intel.com>
> > Cc: Dave Jiang <dave.jiang@intel.com>
> > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> In our ath11k test box commit 7e89efc6e9e4 was causing random kernel
> crashes. I tested patches 1-3 and did not see anymore crashes so:
> 
> Tested-by: Kalle Valo <kvalo@kernel.org>

Added to commit logs, thank you!

