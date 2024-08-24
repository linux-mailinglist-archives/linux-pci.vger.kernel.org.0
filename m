Return-Path: <linux-pci+bounces-12151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3653A95DB78
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 06:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F1350B23F93
	for <lists+linux-pci@lfdr.de>; Sat, 24 Aug 2024 04:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157183987D;
	Sat, 24 Aug 2024 04:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lg9Tf/ws"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A27EAD0;
	Sat, 24 Aug 2024 04:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724473602; cv=none; b=qov95gxWrHfKlxo3KvAtSTsmHl9N/KrdvUulB+jMYXyTrjrPnqQk1hlrXshIDyhXT9Un/1IqupwgsEpTGcGSMxyFQxitk9v5YoSRxX3J8uJ1QnfL8cr6FZ9cBEBvZyDatcTj/N9Qk1c73GOVfYgTK7HMC3PPin7clTaMoytez3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724473602; c=relaxed/simple;
	bh=40GlEPNurYWTPJrHrKMNmjjvmAN4H33EaCA2SPTdpiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2XWqmy92POZQSQRfMv0sFyBCkS72ADoB6MbI589z74kTBl7XswgLOyVXoSImTvoxsp3guDvZ3cWC/Q2ojgVGAs1oX+GuEmAG6nLBzSfRDYMXvCi8MawpurgOKcS6QrnUskkM2XgxHR9GjUufIDgvgZDdTHJ13sIUz0devq/sHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lg9Tf/ws; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724473600; x=1756009600;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=40GlEPNurYWTPJrHrKMNmjjvmAN4H33EaCA2SPTdpiw=;
  b=lg9Tf/wsmK4/ioVGMljUcyC78GBlP7sHrhd2QwHpA/+Qb/rvbFf2Xs1d
   7XCQkv38bd3OfiNVcMyWtfXZ3dBAmwStaBzoyyF1+Sfmvvjvz/39j1Nxl
   fpHOHI1+DZmqlLKE1h6sxBc3m1v5ciOX9GGUTtjVotNWlMtHWpk3mmFb+
   76FMcynC69a43N6jt7OlR6WcFtTUXdq1O8De/nBYEwgHiYKS+pdqxkBZP
   PFRzv72SGI9KxYnkUkKRFRhdDvQM6BxF9NIyEahv0bY4TCkj7c95nWF2h
   Y4TSU22cZgKKXfjQFYBRxJ66mbArh1oZ6A+UEs/ht/2V7ZG3sJXFaAwLm
   Q==;
X-CSE-ConnectionGUID: aNIVscdIT2eCHjZq3vi+Cw==
X-CSE-MsgGUID: IWSzamgvTuiYHmJN65sHeQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="13188269"
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="13188269"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 21:26:39 -0700
X-CSE-ConnectionGUID: dqpdH3fxQnq9MiSUYdVs8Q==
X-CSE-MsgGUID: gPFp6PdTSbKwUx3ojwzGwg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,172,1719903600"; 
   d="scan'208";a="66938134"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 23 Aug 2024 21:26:37 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 631CA27C; Sat, 24 Aug 2024 07:26:35 +0300 (EEST)
Date: Sat, 24 Aug 2024 07:26:35 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	iommu@lists.linux.dev, Lukas Wunner <lukas@wunner.de>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] PCI: Detect and trust built-in Thunderbolt chips
Message-ID: <20240824042635.GM1532424@black.fi.intel.com>
References: <20240823-trust-tbt-fix-v4-1-c6f1e3bdd9be@chromium.org>
 <20240823211254.GA385934@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240823211254.GA385934@bhelgaas>

On Fri, Aug 23, 2024 at 04:12:54PM -0500, Bjorn Helgaas wrote:
> On Fri, Aug 23, 2024 at 04:53:16PM +0000, Esther Shimanovich wrote:
> > Some computers with CPUs that lack Thunderbolt features use discrete
> > Thunderbolt chips to add Thunderbolt functionality. These Thunderbolt
> > chips are located within the chassis; between the root port labeled
> > ExternalFacingPort and the USB-C port.
> 
> Is this a firmware defect?  I asked this before, and I interpret your
> answer of "ExternalFacingPort is not 100% accurate all of the time" as
> "yes, this is a firmware defect."  That should be part of the commit
> log and code comments.
> 
> We (of course) have to work around firmware defects, but workarounds
> need to be labeled as such instead of masquerading as generic code.
> 
> > These Thunderbolt PCIe devices should be labeled as fixed and trusted,
> > as they are built into the computer. Otherwise, security policies that
> > rely on those flags may have unintended results, such as preventing
> > USB-C ports from enumerating.
> > 
> > Detect the above scenario through the process of elimination.
> > 
> > 1) Integrated Thunderbolt host controllers already have Thunderbolt
> >    implemented, so anything outside their external facing root port is
> >    removable and untrusted.
> > 
> >    Detect them using the following properties:
> > 
> >      - Most integrated host controllers have the usb4-host-interface
> >        ACPI property, as described here:
> > Link: https://learn.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#mapping-native-protocols-pcie-displayport-tunneled-through-usb4-to-usb4-host-routers
> > 
> >      - Integrated Thunderbolt PCIe root ports before Alder Lake do not
> >        have the usb4-host-interface ACPI property. Identify those with
> >        their PCI IDs instead.
> > 
> > 2) If a root port does not have integrated Thunderbolt capabilities, but
> >    has the ExternalFacingPort ACPI property, that means the manufacturer
> >    has opted to use a discrete Thunderbolt host controller that is
> >    built into the computer.
> 
> Unconvincing.  If a Root Port has an external connector, is it
> impossible to plug in a Thunderbolt device to that connector?  I
> assume the wires from a Root Port could be traces on a PCB to a
> soldered-down Thunderbolt controller, OR could be wires to a connector
> where a Thunderbolt controller could be plugged in.  How could we tell
> the difference?

You are talking about soldered down controller vs. add-in card (e.g PCIe
slot)? We don't really distinguish those. The whole ExternalFacingPort
and the like IOMMU protection is meant for exposed hot-pluggable ports
on your laptop such as Type-C where a malicious charger for instance may
have a PCIe endpoint that steals your secrets. Not something that
requires dissasembly, opening the system cover and plugging in the
controller, connecting all the wires etc.

(We have also an additional "line of defence" in Linux because we do not
automatically create any PCIe tunnels and this is something user can
even disable completely [there is a flip in GNOME settings that disables
PCIe tunneling completely, which can be turned on whenever you are
travelling for instance]).

