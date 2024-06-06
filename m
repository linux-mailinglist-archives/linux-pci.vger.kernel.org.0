Return-Path: <linux-pci+bounces-8394-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5B88FE403
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 12:16:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C60AB224CB
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 10:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4E7E187334;
	Thu,  6 Jun 2024 10:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xupm3txB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA46186E59;
	Thu,  6 Jun 2024 10:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668264; cv=none; b=FA2yYhIOHuRXYv4JocTxf4wnaXB0flYH/+bi5l5UqvMQS5N7cqSLq5RWxdddIjbpg/e7TrbWFmD6ry3GQygdLT7+KFHOCKL2kkQ3ezIkVlUs0zPBYuG7Hi0lhwm0mFrgJKqVsymPhOuouo9RZvrcOnpHUrsa9o+rVaO0SN8Jcic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668264; c=relaxed/simple;
	bh=u5hYPflaRr/VormFnPr2FfIJnLZmHcgxMUj0SUYPgTU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcBuyXOdGWyTWvTqoNUCmr01KpqTscEN/m+tAkMjoMiZuN9gV645kgVrEtJ+KimlU5MpK/wdU/FCzLHaNo8MklEM60gu8Ai+XZ0S39Acl06FKcIQGhGXnI3yPtT0sAEnXXh3y4H3tn5AxqxMAz7GCEBZT/xQwPuo8re2Vaq83HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xupm3txB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B139EC2BD10;
	Thu,  6 Jun 2024 10:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717668263;
	bh=u5hYPflaRr/VormFnPr2FfIJnLZmHcgxMUj0SUYPgTU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xupm3txB0/S56c2R9F9476VcX7Etz7PCGA1GMbO/ezEpEUF61xt2dBsGVwk2qkwXO
	 5xYmrECKnHcp9vkrL3D0Nph14c8NfP+Vn2behKODGy9qcKBT2zxD2ZjW7UbJx9/Rlg
	 ku7wO8mkPq0LLgKGYrOwGdBch1/FjcrblefGO5UcmR+ZDCQSd7cSa929q7R4HyEEHN
	 NKxgkuQ3YPqc23MLRPJch+c8fNQA+dgMK7eboo4cqwK3zPhwWlaQLzZ+CmwMiWCixB
	 SNtky9Q5yDB9fR8qDDv0bkp/zFI0ggjoquYfKVlLlpsJuTBkxQZCtPMB2vyHYAnzse
	 ZvmIYLJyOYqHw==
Date: Thu, 6 Jun 2024 13:04:18 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>, Dan Williams <dan.j.williams@intel.com>,
	bhelgaas@google.com, Imre Deak <imre.deak@intel.com>,
	Jani Saarinen <jani.saarinen@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, linux-pci@vger.kernel.org,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: Revert the cfg_access_lock lockdep mechanism
Message-ID: <20240606100418.GD13732@unreal>
References: <87h6e9t9qt.fsf@kernel.org>
 <20240604171121.GA730808@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240604171121.GA730808@bhelgaas>

On Tue, Jun 04, 2024 at 12:11:21PM -0500, Bjorn Helgaas wrote:
> On Tue, Jun 04, 2024 at 11:03:54AM +0300, Kalle Valo wrote:
> > Dan Williams <dan.j.williams@intel.com> writes:
> > 
> > > While the experiment did reveal that there are additional places that
> > > are missing the lock during secondary bus reset, one of the places that
> > > needs to take cfg_access_lock (pci_bus_lock()) is not prepared for
> > > lockdep annotation.
> > >
> > > Specifically, pci_bus_lock() takes pci_dev_lock() recursively and is
> > > currently dependent on the fact that the device_lock() is marked
> > > lockdep_set_novalidate_class(&dev->mutex). Otherwise, without that
> > > annotation, pci_bus_lock() would need to use something like a new
> > > pci_dev_lock_nested() helper, a scheme to track a PCI device's depth in
> > > the topology, and a hope that the depth of a PCI tree never exceeds the
> > > max value for a lockdep subclass.
> > >
> > > The alternative to ripping out the lockdep coverage would be to deploy a
> > > dynamic lock key for every PCI device. Unfortunately, there is evidence
> > > that increasing the number of keys that lockdep needs to track to be
> > > per-PCI-device is prohibitively expensive for something like the
> > > cfg_access_lock.
> > >
> > > The main motivation for adding the annotation in the first place was to
> > > catch unlocked secondary bus resets, not necessarily catch lock ordering
> > > problems between cfg_access_lock and other locks. Solve that narrower
> > > problem with follow-on patches, and just due to targeted revert for now.
> > >
> > > Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
> > > Reported-by: Imre Deak <imre.deak@intel.com>
> > > Closes: https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134186v1/shard-dg2-1/igt@device_reset@unbind-reset-rebind.html
> > > Cc: Jani Saarinen <jani.saarinen@intel.com>
> > > Cc: Dave Jiang <dave.jiang@intel.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > 
> > In our ath11k test box commit 7e89efc6e9e4 was causing random kernel
> > crashes. I tested patches 1-3 and did not see anymore crashes so:
> > 
> > Tested-by: Kalle Valo <kvalo@kernel.org>
> 
> Added to commit logs, thank you!
> 

Thanks,
Tested-by: Leon Romanovsky <leonro@nvidia.com>

