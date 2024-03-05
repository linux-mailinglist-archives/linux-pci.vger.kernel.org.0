Return-Path: <linux-pci+bounces-4532-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE5587265E
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 19:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFB1E285584
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 18:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63D7018622;
	Tue,  5 Mar 2024 18:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIgPdnMI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35B8017BD4;
	Tue,  5 Mar 2024 18:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709662467; cv=none; b=kiXeLYAhEXEw8sjiCOO5dRra2MgmBcs7Qb83DRRDlBFIV8jAzq6v2bO4bqZDITA5y2nUwD5BOuKj0zb+psGLa6OT9xXKAsrPoCLfKMzqUoThx0iyTdoDS+4RbwQLxCeiijrBICEccsJwGGUin9m6MqPQj68diuayQxxycjd5/S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709662467; c=relaxed/simple;
	bh=mnwUYin+wWG/5bm2UhgbjUnJX5XJYCmfDtF0BnRjVFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LyanE5FAILFCUECoH6M+o/T08npHOFgrMneQzBEOvK2Qs1+1DaDQ12wAt9pzezVx9eLgmSuaLB3wkwklUuNzAN9+WOAE5FpwYfmcn1gcNqZkonYgh9hBlRBg3tH6pCzcBFcFPcft77NouHYUImZB7MZqTQ8vxHTHaABwsPWlr5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIgPdnMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5B5C433F1;
	Tue,  5 Mar 2024 18:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709662466;
	bh=mnwUYin+wWG/5bm2UhgbjUnJX5XJYCmfDtF0BnRjVFQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=PIgPdnMIq+XljxNgkyHces7Cj6VHkEC9Q2shkEPwWWaHNM+2f+0AYrTWGi0dMKAv9
	 g8bAsC9RauqJJxtQWadwW2+Ev78wqIs/RnjP7cVwZfVxq26Zffs9NhmbARrCo1wRfQ
	 5dwWpxmw7sq51EnjeVhdTg9xEdxpKlA70wVNDLpin6ZuWqv3fkjWLokT7bRKp+aHy0
	 jG0q71N/pK+55qXcM2HiLZKJt9bHFeyptoKD8cloob6aYFbfWcWIgacQLQbXGGVBAk
	 Jw4A9RxRlDBb2Odf32fTUUdyoGHiTb7ovWCcbphkXUIEcRDljf2QZIf/dYuJCYaHes
	 RSd1W9LJhxJ6Q==
Date: Tue, 5 Mar 2024 12:14:25 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PCI <linux-pci@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Linux PM <linux-pm@vger.kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ricky Wu <ricky_wu@realtek.com>,
	Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v1] PM: runtime: PCI: Drain runtime-idle callbacks before
 driver removal
Message-ID: <20240305181425.GA541296@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5761426.DvuYhMxLoT@kreacher>

On Tue, Mar 05, 2024 at 11:45:38AM +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> A race condition between the .runtime_idle() callback and the .remove()
> callback in the rtsx_pcr PCI driver leads to a kernel crash due to an
> unhandled page fault [1].
> 
> The problem is that rtsx_pci_runtime_idle() is not expected to be
> running after pm_runtime_get_sync() has been called, but the latter
> doesn't really guarantee that.  It only guarantees that the suspend
> and resume callbacks will not be running when it returns.
> 
> However, if a .runtime_idle() callback is already running when
> pm_runtime_get_sync() is called, the latter will notice that the
> runtime PM status of the device is RPM_ACTIVE and it will return right
> away without waiting for the former to complete.  In fact, it cannot
> wait for .runtime_idle() to complete because it may be called from that
> callback (it arguably does not make much sense to do that, but it is not
> strictly prohibited).
> 
> Thus in general, whoever is providing a .runtime_idle() callback, they
> need to protect it from running in parallel with whatever code runs
> after pm_runtime_get_sync().  [Note that .runtime_idle() will not start
> after pm_runtime_get_sync() has returned, but it may continue running
> then if it has started earlier already.]
> 
> One way to address that race condition is to call pm_runtime_barrier()
> after pm_runtime_get_sync() (not before it, because a nonzero value of
> the runtime PM usage counter is necessary to prevent runtime PM
> callbacks from being invoked) to wait for the runtime-idle callback to
> complete should it be running at that point.  A suitable place for
> doing that is in pci_device_remove() which calls pm_runtime_get_sync()
> before removing the driver, so it may as well call pm_runtime_barrier()
> subsequently, which will prevent the race in question from occurring,
> not just in the rtsx_pcr driver, but in any PCI drivers providing
> runtime-idle callbacks.
> 
> Link: https://lore.kernel.org/lkml/20240229062201.49500-1-kai.heng.feng@canonical.com/ # [1]
> Reported-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> Tested-by: Ricky Wu <ricky_wu@realtek.com>
> Cc: All applicable <stable@vger.kernel.org>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Applied with Kai-Feng's ack to pci/pm for v6.9, thank you very much!

> ---
>  drivers/pci/pci-driver.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> Index: linux-pm/drivers/pci/pci-driver.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pci-driver.c
> +++ linux-pm/drivers/pci/pci-driver.c
> @@ -473,6 +473,13 @@ static void pci_device_remove(struct dev
>  
>  	if (drv->remove) {
>  		pm_runtime_get_sync(dev);
> +		/*
> +		 * If the driver provides a .runtime_idle() callback and it has
> +		 * started to run already, it may continue to run in parallel
> +		 * with the code below, so wait until all of the runtime PM
> +		 * activity has completed.
> +		 */
> +		pm_runtime_barrier(dev);
>  		drv->remove(pci_dev);
>  		pm_runtime_put_noidle(dev);
>  	}
> 
> 
> 

