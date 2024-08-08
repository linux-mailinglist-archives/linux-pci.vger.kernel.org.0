Return-Path: <linux-pci+bounces-11473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E472F94B636
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 07:22:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 124511C22AA8
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 05:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC8E13D501;
	Thu,  8 Aug 2024 05:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eMlLmrLE"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50BC612C81F;
	Thu,  8 Aug 2024 05:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723094560; cv=none; b=Bke7iVnZKFl6G1E9ZtJ08/s39XfL0TduhTTcqff81mAf5NKDBW10SxbJyFtqV2+OLDZjCmkgFqYsMdMSKIDpffTdGIL8yqn5ufMfAceP1MLFgXmXB06GEJ1zkI8isjfsUHB5OGtNzBNOOLAXF7ly//b5maE9/DxZaMIGQz0vG90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723094560; c=relaxed/simple;
	bh=OR9sMnXhltK5Nzt6J/HOUDA9VXJNDusH9+iC2H7NInU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JC9ZK/J/YEojTfDXowsjAbTBbCfzAhqzBzCYi5vzkYT6xDpfrtvpK+KrRsBBx27CyoLG5zukU8vjYrZJ01OiCB8yJB7OJbwVsLjUcsoBOivN++3f+wibJ63PEPSXVAUFiwT1d+suJzkoAusFguOIqEAZBBllAN5SCznmjVbJr50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eMlLmrLE; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723094559; x=1754630559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OR9sMnXhltK5Nzt6J/HOUDA9VXJNDusH9+iC2H7NInU=;
  b=eMlLmrLEItC5/vQaeAgjYxySCDeByTs7R1g2udQVuBRd6sZ1EI82r7s9
   eQYKoSsiWxal+XlCG4RbiF6v+Ew8YmrooNGGJ2s3xSbQIkVcnI7uO3z1q
   WCaTIoCKBJdm/0ZGWu1E4bFlKKhu0CP98QnUm7qkmooulEhQ3i9vq+17E
   e1UUc1D9zEyeFlFivIRpPKmBowl9TrGZfcTBVd/SD84fgb57YzgBojs+O
   ENZSnprchs3w4YMiyXrDvlbE42bnAujqFkV5sfudgxhn4KhyeOFBeZ3D8
   DJpFkbrOkIBWJ3XSHVRpKiP6h34VAXWK1VYl8ThdlJXvDFqy1Y+vJQvZn
   g==;
X-CSE-ConnectionGUID: dO/0CJYJR0Kd0xkQoaOQvQ==
X-CSE-MsgGUID: AIjFWZ0VTHeK9HyxzRJG4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="31774401"
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="31774401"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 22:22:38 -0700
X-CSE-ConnectionGUID: /dCktr84QOuGGRQWTzad4w==
X-CSE-MsgGUID: z6tVcbHdSi2+cVnKK5TcLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,272,1716274800"; 
   d="scan'208";a="80328287"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa002.fm.intel.com with ESMTP; 07 Aug 2024 22:22:35 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id E81BF206; Thu, 08 Aug 2024 08:22:33 +0300 (EEST)
Date: Thu, 8 Aug 2024 08:22:33 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Esther Shimanovich <eshimanovich@chromium.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Rajat Jain <rajatja@google.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: Detect and trust built-in TBT chips
Message-ID: <20240808052233.GI1532424@black.fi.intel.com>
References: <20240806-trust-tbt-fix-v1-1-73ae5f446d5a@chromium.org>
 <20240806220406.GA80520@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240806220406.GA80520@bhelgaas>

On Tue, Aug 06, 2024 at 05:04:06PM -0500, Bjorn Helgaas wrote:
> > +static bool pcie_is_tunneled(struct pci_dev *pdev)
> > +{
> > +	struct pci_dev *parent, *root;
> > +
> > +	parent = pci_upstream_bridge(pdev);
> > +	/* If pdev doesn't have a parent, then there's no way it is tunneled.*/
> > +	if (!parent)
> > +		return false;
> > +
> > +	root = pcie_find_root_port(pdev);
> > +	/* If pdev doesn't have a root, then there's no way it is tunneled.*/
> > +	if (!root)
> > +		return false;
> > +
> > +	/* Internal PCIe devices are not tunneled. */
> > +	if (!root->external_facing)
> > +		return false;
> > +
> > +	/* Anything directly behind a "usb4-host-interface" is tunneled. */
> > +	if (pcie_has_usb4_host_interface(parent))
> > +		return true;
> > +
> > +	/*
> > +	 * Check if this is a discrete Thunderbolt/USB4 controller that is
> > +	 * directly behind the non-USB4 PCIe Root Port marked as
> > +	 * "ExternalFacingPort". These PCIe devices are used to add Thunderbolt
> > +	 * capabilities to CPUs that lack integrated Thunderbolt.
> > +	 * These are not behind a PCIe tunnel.
> 
> I need more context to be convinced that this is a reliable heuristic.
> What keeps somebody from plugging a discrete Thunderbolt/USB4
> controller into an external port?

In case of integrated host controller the above function returns true for
anything connected behind its tunneled PCIe root ports so if you plug in
a discrete controller into that it will be treated as tunneled and gets
full IOMMU mappings.

In case of discrete host controller there are two ways. With USB4 the above
function finds "usb4-host-interface" firmware description and returns
true the discrete controller you plug in will be treated as tunneled and
gets full IOMMU mappings.

With non-USB4 (that's Thunderbolt 3 and below) discrete host controller we
have root->external_facing true (it is marked with "ExternalFacingPort"
firmware property) the check below fails because the discrete controller
you plug in is not directly under that so it will be treated as tunneled
and gets full IOMMU mappings.

>  Maybe this just needs a sentence or
> two from Lukas's (?) helpful intro to tunneling?
> 
> > +	if (pcie_switch_directly_under(root, pdev))
> > +		return false;
> > +
> > +	/* PCIe devices after the discrete chip are tunneled. */
> > +	return true;
> > +}

