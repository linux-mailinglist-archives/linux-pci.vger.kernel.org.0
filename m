Return-Path: <linux-pci+bounces-2980-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBE084691F
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 08:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 903DB1C251D6
	for <lists+linux-pci@lfdr.de>; Fri,  2 Feb 2024 07:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0411775B;
	Fri,  2 Feb 2024 07:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Uamen+kW"
X-Original-To: linux-pci@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857F617BA8;
	Fri,  2 Feb 2024 07:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858247; cv=none; b=D6xbimbqqDSKD52IE1w/sE17IEaAw/CDaA1oXSHBV0lq2RxnoHtEimlr36MZDcPG4KTbBzHrrsv+pZ6W1ZJqrnE9SuRCFDwoJZoldUDM1yI/Ce+gD+gWgK0SWDVEQtgyF3egV7r3A1eCwnFPFa9NLcwLbsQ7Xiuwrd1mXuI4e98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858247; c=relaxed/simple;
	bh=h4Hp9Xzm/YT6xUNfO+jL+JGLsKAcnkgFgcS2QV41hM0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JM7FIzoSKiextgWr8UxpBSUw2e9QZTeUzp+DyDSsMPa/cYfD4w/mkgO1nYv/TvUVE47cw3W5lXT1YqiPvoQhRK9O+IRWmiEwr9veWNOMLvzzsSaoC2Oq+OGlpOP2kiO2EQDA/2i/DvUDzUopl2n/axwPPJfgBfvYf6u4MlhDFI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Uamen+kW; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 3A9B420B2000; Thu,  1 Feb 2024 23:17:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A9B420B2000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706858246;
	bh=VrfVzgkHK9RQktBAOnodKa9BkvUSa49XaF41iL55nWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Uamen+kW6PMS4UNg3mO8vg0xS24Q3nHFdcoXqfnpt2G3o5HzRBrgarc1aQBh2FkAm
	 Of/hWRSteCAuh7PaMdFtK8ldI4XjrFYJdAVckBSwuq/QX3+11WImJwY2tFoPf5rcD3
	 WtmYMKXSmTIAK5C8QKNKZhiYauw3QVHrFJoF45Bk=
Date: Thu, 1 Feb 2024 23:17:26 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, decui@microsoft.com
Subject: Re: [PATCH] PCI/sysfs: Fix race in pci sysfs creation
Message-ID: <20240202071726.GA14505@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1702093576-30405-1-git-send-email-ssengar@linux.microsoft.com>
 <5736414.DvuYhMxLoT@steina-w>
 <20231212082805.GA3521@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240104053803.GA16954@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20240120064156.GA3130@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240120064156.GA3130@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Fri, Jan 19, 2024 at 10:41:56PM -0800, Saurabh Singh Sengar wrote:
> On Wed, Jan 03, 2024 at 09:38:03PM -0800, Saurabh Singh Sengar wrote:
> > On Tue, Dec 12, 2023 at 12:28:05AM -0800, Saurabh Singh Sengar wrote:
> > > On Tue, Dec 12, 2023 at 08:19:11AM +0100, Alexander Stein wrote:
> > > > Hi Saurabh,
> > > > 
> > > > thanks for the patch.
> > > > 
> > > > Am Samstag, 9. Dezember 2023, 04:46:16 CET schrieb Saurabh Sengar:
> > > > > Currently there is a race in calling pci_create_resource_files function
> > > > > from two different therads, first therad is triggered by pci_sysfs_init
> > > > > from the late initcall where as the second thread is initiated by
> > > > > pci_bus_add_devices from the respective PCI drivers probe.
> > > > > 
> > > > > The synchronization between these threads relies on the sysfs_initialized
> > > > > flag. However, in pci_sysfs_init, sysfs_initialized is set right before
> > > > > calling pci_create_resource_files which is wrong as it can create race
> > > > > condition with pci_bus_add_devices threads. Fix this by setting
> > > > > sysfs_initialized flag at the end of pci_sysfs_init and direecly call the
> > > > 
> > > > Small typo here: direecly -> directly
> > > > 
> > > > > pci_create_resource_files function from it.
> > > > > 
> > > > > There can be an additional case where driver probe is so delayed that
> > > > > pci_bus_add_devices is called after the sysfs is created by pci_sysfs_init.
> > > > > In such cases, attempting to access already existing sysfs resources is
> > > > > unnecessary. Fix this by adding a check for sysfs attributes and return
> > > > > if they are already allocated.
> > > > > 
> > > > > In both cases, the consequence will be the removal of sysfs resources that
> > > > > were appropriately allocated by pci_sysfs_init following the warning below.
> > > > 
> > > > I'm not sure if this is the way to go. Unfortunately I can't trigger this 
> > > > error on my imx6 platform at the moment (apparently timing is off).
> > > > But reading [1] again, the most expressive way is that pci_bus_add_devices() 
> > > > needs to wait until pci_sysfs_init() has passed.
> > > 
> > > (I correct my self a bit in my earlier reply)
> > > The problem with waiting is that sysfs entries will be created by pci_sysfs_init
> > > already and when pci_bus_add_devices try to create it will observe that the
> > > entries are already existing and in such case PCI code will remove the sysfs
> > > entries created by pci_sysfs_init. Resulting system will be having no sysfs
> > > entries.
> > 
> > 
> > Hi Alexander,
> > Have you got time to check this ? Please let me know if you think there is any
> > concern left with this patch.
> 
> Hi PCI Maintainers,
> 
> If there is no objection, can we take this patch in ?
> 

ping

> 
> Regards,
> Saurabh
> 
> 
> 
> 

