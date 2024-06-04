Return-Path: <linux-pci+bounces-8230-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A83088FAD0E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 10:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D68B28366A
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2024 08:04:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 925E01420B0;
	Tue,  4 Jun 2024 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DF+sGa2p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB3B1419A9;
	Tue,  4 Jun 2024 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717488238; cv=none; b=HnOgqoJk0aeHbu4S3u08zt0iRbdKIkNxdxWt+MZCUEhCUSV0gRjoiHCMm2AA5430O9Up8KolfE9V3YM38N9EdthwJ+ILXeiuXigMqyzDOgm0a87ykA50/kt3vJrp7CXZ/8KLIc9tvOoupAU3ZqWdS4JHDw25LNRukB4K8TYaqD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717488238; c=relaxed/simple;
	bh=hS5nUAa9g7ZorrRtew4/tAjEsI5Ch0huE6nga4NOMu8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=m8w+WsjTRh12V5gi4uQ1Dx+4M5zgFpaZ2AHUkp3j+XEak4qNLx0SnHmve+23c+USA7YBJbzqeK8ZJkHf8HmZkOSI3paMGQWR6n8Q1oiBM8/2yGreIIFoe9URhyfm5Q3VkC/EQOm8jxTBgGWSxNMDtvGdUougVIZxfQY7SdHi4n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DF+sGa2p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 566A1C2BBFC;
	Tue,  4 Jun 2024 08:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717488237;
	bh=hS5nUAa9g7ZorrRtew4/tAjEsI5Ch0huE6nga4NOMu8=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=DF+sGa2pYyNP+iTOlgrtOhvHxVSGUtLjdfDQ8sotFDY7xv+HQzijqdZ/oyY7XAQtT
	 X7H+5wyZkJREUObo+MXRsoQEeVquQPS3pZdZIhQkC/ecUGvYvq/65tZmfySxduESLJ
	 yV4d0CJHomzNtsAxpn1rX2c+woISvvb+7fejZDwJsCW46ie2i+KDqHAemCvbVYMcIt
	 SYsP80I+jPNm87DFrXafgIE8qUnDoCm7o3KZu19Q5L0yTe4lO1pbwVtbGGkvf4rPNM
	 zgYNqvHByR74b+ZbYyA1InWe+THSu8lx28s+PCJr5tK2b1GCbH5FnFt3jRrDliuPdV
	 T1/jm4oMio4Mw==
From: Kalle Valo <kvalo@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: bhelgaas@google.com,  Imre Deak <imre.deak@intel.com>,  Jani Saarinen
 <jani.saarinen@intel.com>,  Dave Jiang <dave.jiang@intel.com>,
  linux-pci@vger.kernel.org,  linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 1/3] PCI: Revert the cfg_access_lock lockdep mechanism
References: <171711745834.1628941.5259278474013108507.stgit@dwillia2-xfh.jf.intel.com>
	<171711746402.1628941.14575335981264103013.stgit@dwillia2-xfh.jf.intel.com>
Date: Tue, 04 Jun 2024 11:03:54 +0300
In-Reply-To: <171711746402.1628941.14575335981264103013.stgit@dwillia2-xfh.jf.intel.com>
	(Dan Williams's message of "Thu, 30 May 2024 18:04:24 -0700")
Message-ID: <87h6e9t9qt.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Dan Williams <dan.j.williams@intel.com> writes:

> While the experiment did reveal that there are additional places that
> are missing the lock during secondary bus reset, one of the places that
> needs to take cfg_access_lock (pci_bus_lock()) is not prepared for
> lockdep annotation.
>
> Specifically, pci_bus_lock() takes pci_dev_lock() recursively and is
> currently dependent on the fact that the device_lock() is marked
> lockdep_set_novalidate_class(&dev->mutex). Otherwise, without that
> annotation, pci_bus_lock() would need to use something like a new
> pci_dev_lock_nested() helper, a scheme to track a PCI device's depth in
> the topology, and a hope that the depth of a PCI tree never exceeds the
> max value for a lockdep subclass.
>
> The alternative to ripping out the lockdep coverage would be to deploy a
> dynamic lock key for every PCI device. Unfortunately, there is evidence
> that increasing the number of keys that lockdep needs to track to be
> per-PCI-device is prohibitively expensive for something like the
> cfg_access_lock.
>
> The main motivation for adding the annotation in the first place was to
> catch unlocked secondary bus resets, not necessarily catch lock ordering
> problems between cfg_access_lock and other locks. Solve that narrower
> problem with follow-on patches, and just due to targeted revert for now.
>
> Fixes: 7e89efc6e9e4 ("PCI: Lock upstream bridge for pci_reset_function()")
> Reported-by: Imre Deak <imre.deak@intel.com>
> Closes: https://intel-gfx-ci.01.org/tree/drm-tip/Patchwork_134186v1/shard-dg2-1/igt@device_reset@unbind-reset-rebind.html
> Cc: Jani Saarinen <jani.saarinen@intel.com>
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

In our ath11k test box commit 7e89efc6e9e4 was causing random kernel
crashes. I tested patches 1-3 and did not see anymore crashes so:

Tested-by: Kalle Valo <kvalo@kernel.org>

Unfortunately I didn't realise to test patch 1 alone but I would assume
that's enough to fix the crashes. Please prioritise this patch so that
the regression in Linus' tree is fixed.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

