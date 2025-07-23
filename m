Return-Path: <linux-pci+bounces-32811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5BAB0F43B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 15:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48F51C23775
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 13:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6711915530C;
	Wed, 23 Jul 2025 13:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q+Khs9RO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8DC8F58;
	Wed, 23 Jul 2025 13:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278030; cv=none; b=W7tk6O2wopVYXMH54XbINl5phjlODaglzwfUirLBJtPunB+ib9sxV/0kXdU/VdEjRxe4BCTcFZzuB+XrFUn7zrEWR4GD/WjvO/lzNTD94UV/fZ0YVq1jSfcG4IZalbSHOrN350wIFnXWBX92VWZ9rqX43pmor7irjfn6seAl5ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278030; c=relaxed/simple;
	bh=iLHnqpDTeJAfb5yeXS6fdMZjCsdlDVXAemtjpExcZzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DWM4ElDq7m00xCiXrR0fvGNv3gkRLC4Zf9+voo9hOc0HuMZ1jHWFUmt209f0MeHCOJgUgCQGl05jkH4evA3pfnEH3Q+I+ulvH3V6Ps1Bqn5IxM5AdZSkA+IW+HuDXQkq4Y2r5Su7l3q4SFB4mvsTlcbc9ylELuDH+1VRyck/2zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q+Khs9RO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 130B7C4CEE7;
	Wed, 23 Jul 2025 13:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753278029;
	bh=iLHnqpDTeJAfb5yeXS6fdMZjCsdlDVXAemtjpExcZzU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q+Khs9RO6b6OdcjiLl+LyBiDvtc6l/0UzOjWJ4Ef0liPQCs/T3KRQ1oiJ+RZHWweZ
	 /LUGfc5J1sWhQ24SMxUVOBeTPmJmMqFB39ISzL6L5t/L+li/j4lkr87YM19tXbke8w
	 tQPuNbLGwHZQRzRbPqwLCsOwIa1T+oLJyhGN0T88oSf6wxBlIEZizo6omGpBYkK9NW
	 8psWza3X+Sqwo0dF4o68/YH5AO1II43lQ5Zb298wJc6zDChQAeDxsk1n0U4UfrjZjr
	 cGujKs+0FffCbLX4HNYQhLmSHb0EJbKrXb6EtE3vifMLUreMAH4ZMyCpeHQgJSfMcf
	 CbbPnm+RERXZg==
Date: Wed, 23 Jul 2025 19:10:22 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	bhelgaas@google.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Shuan He <heshuan@bytedance.com>, kwilczynski@kernel.org
Subject: Re: [PATCH] PCI: Remove redudant calls to
 pci_create_sysfs_dev_files() and pci_proc_attach_device()
Message-ID: <d2ty2hr5jqmlqwkdnd252ctix4xqmxtonx6wqyq3oj5f3j3cpf@yuibbj5owarp>
References: <20250723111124.13694-1-manivannan.sadhasivam@oss.qualcomm.com>
 <aIDbwNdWgtKcrfF_@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aIDbwNdWgtKcrfF_@wunner.de>

On Wed, Jul 23, 2025 at 02:55:28PM GMT, Lukas Wunner wrote:
> On Wed, Jul 23, 2025 at 04:41:24PM +0530, Manivannan Sadhasivam wrote:
> > Both pci_create_sysfs_dev_files() and pci_proc_attach_device() are called
> > from pci_bus_add_device(). Calling these APIs from other places is prone to
> > a race condition as nothing prevents the callers from racing against
> > each other.
> > 
> > Moreover, the proper place to create SYSFS and PROCFS entries is during
> > the 'pci_dev' creation. So there is no real need to call these APIs
> > elsewhere.
> 
> The raison d'être for the call to pci_create_sysfs_dev_files() in
> pci_sysfs_init() is that PCI_ROM_RESOURCEs may appear after device
> enumeration but before the late_initcall stage:
> 
> https://lore.kernel.org/r/20231019200110.GA1410324@bhelgaas/
> 
> Your patch will regress those platforms.
> 

Ok, thanks for the pointer. I was not aware of this issue.

> The proper solution is to make the resource files in sysfs static
> and call sysfs_update_group() from pci_sysfs_init().
> 
> Krzysztof has an old branch where he started working on this:
> 
> https://github.com/kwilczynski/linux/commits/kwilczynski/sysfs-static-resource-attributes/
> 

I had a chat with Krzysztof offline and he promised me that he will revive this
effort (thanks Krzysztof!).

- Mani

-- 
மணிவண்ணன் சதாசிவம்

