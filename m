Return-Path: <linux-pci+bounces-42086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 77042C872EC
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 22:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5E3034EA677
	for <lists+linux-pci@lfdr.de>; Tue, 25 Nov 2025 21:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7E8C2DF146;
	Tue, 25 Nov 2025 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtpeZ+Lx"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE5227FB34;
	Tue, 25 Nov 2025 21:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764104601; cv=none; b=TToHxUTmJiD9fovoiA+47+QUoRAJz5B8QfzxBMvfbYg8FkmCi/C5ClDqkuH7hrA9FfGqVvAGnZ0R2abdGBxq3tG5r5N6o1y49atGJnbvXvIpR+AJqjyiOAmQ54xnb0wOxwvDaXfJ5EW97mH1w8I5EuoQma3+PbdcQ+Ds5VTa2Wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764104601; c=relaxed/simple;
	bh=Id26wiJS3ZBzN4+TDSno8bnwLN/spJCiR/oQ+uP7xFI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=px/x6LxkiU9KwOW+hFpmXsm0DPM29VYZFiqBLMJZaNWzZXwuruUzTeYUxG4HKYYHsKhHTC7JjTs3SKVIIF0ZbF0pSgPH6viallfsqlxKSyMU6emrYH3s1I/qlcsmUb3la6tGX3vpSQ04zJuM7vjECeDkfFAeQTma/eXM1lLghj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtpeZ+Lx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F089C4CEF1;
	Tue, 25 Nov 2025 21:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764104601;
	bh=Id26wiJS3ZBzN4+TDSno8bnwLN/spJCiR/oQ+uP7xFI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZtpeZ+Lx8V1B8GTqX/dBXV5m00Zb7+3qS+ZrBfoDreM5YZ5nZoia3wfywfmTvDVN3
	 jK9FPaSFcHqs+02t30dAcDrdBw2cPSKSA4N5taB5a95Az8x+cAFmkHPWJL4u2YHgrm
	 rDKpQLzsyiqplS/wSS2Ddg0JucCgMCbmv4QT+TCf2VRyMFTdBzL/eyAm9SZg0Ezyui
	 O4s+RxHxmLkYcLi88xy/+suwyASuMbj2Ws7onXeCxZpXLSNk1rnUDo3sSLAjeXZZmm
	 p8x1Dsv+6xSp/7/GLzOVMY0f+0f7m0qW04W/8D8IkKVwFc7rvTW+LFJuxslp4T2Crp
	 xWg+gtsj987Bw==
Date: Tue, 25 Nov 2025 15:03:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Riana Tauro <riana.tauro@intel.com>,
	"Sean C. Dardis" <sean.c.dardis@intel.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alek Du <alek.du@intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: Universal error recoverability of devices
Message-ID: <20251125210319.GA2767956@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1763483367.git.lukas@wunner.de>

On Wed, Nov 19, 2025 at 09:50:00AM +0100, Lukas Wunner wrote:
> This series intends to replace commit 1dc302f7fccc ("PCI: Ensure error
> recoverability at all times") on the pci/err topic branch:
> 
> https://git.kernel.org/pci/pci/c/1dc302f7fccc
> 
> The commit is assigning "dev->state_saved = false" in pci_bus_add_device()
> and during review there were requests to explain the assignment more
> clearly in a code comment.
> 
> However the assignment is (only) necessitated by missing assignments in
> pci_legacy_suspend() and pci_pm_freeze(), so I propose to instead add
> *those* assignments (patch [1/3]) and thus avoid the need for the
> assignment in pci_bus_add_device(), together with its code comment.
> 
> Furthermore the commit is *removing* an assignment in pci_device_add().
> I am separating that out to new patch [2/3].
> 
> So patch [3/3] is identical to the commit, but without the addition
> of an assignment in pci_bus_add_device() and without the removal
> of an assignment in pci_device_add().
> 
> I am looking into improving the documentation on pci_save_state()
> in a separate series.
> 
> Lukas Wunner (3):
>   PCI/PM: Reinstate clearing state_saved in legacy and !pm codepaths
>   PCI/PM: Stop needlessly clearing state_saved on enumeration and thaw
>   PCI/ERR: Ensure error recoverability at all times
> 
>  drivers/pci/bus.c        | 3 +++
>  drivers/pci/pci-driver.c | 6 ++++--
>  drivers/pci/pci.c        | 3 ---
>  drivers/pci/probe.c      | 2 --
>  4 files changed, 7 insertions(+), 7 deletions(-)

Applied on pci/err for v6.19, thanks!

