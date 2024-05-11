Return-Path: <linux-pci+bounces-7372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95BDE8C2F8D
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 06:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249C2284665
	for <lists+linux-pci@lfdr.de>; Sat, 11 May 2024 04:38:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53AA717571;
	Sat, 11 May 2024 04:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZC2qgs7E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C14802;
	Sat, 11 May 2024 04:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715402318; cv=none; b=V7hGH3UFBQX/VB7TRivrAesVCBsA4ddMFbIbZo+GRY1uuhlw0rFFRdR8MfnoJ3/SZGshsBXkbAn5x/QA7ek5kTPueDLOdT7I2uer8SxEyKKConWN/7gAtzXobeChTGqilgrjuHP93NTC0uCgNxhBjfVi/LTmnRt9xxS86iXjLUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715402318; c=relaxed/simple;
	bh=D097T7KeQGj0egkwFaBZUMJcAfmdFRgqPt+llN0sCiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqN9YnIbfBEdikFJi/oMqi+xDBe0EK+TI0Up1/KaKDJWtQuJCuqYb7Ql6PP/hiY7a69RHB/nZIkNkeZjhgXH5xV9JOlq1SeZh10NIYrvsotSByijW1bgWfZmdcwRtnHeUjy15QU6iMZ/xa+KprUa1eyZ40oBUboFEI5c51NuSa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZC2qgs7E; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715402316; x=1746938316;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D097T7KeQGj0egkwFaBZUMJcAfmdFRgqPt+llN0sCiQ=;
  b=ZC2qgs7E2E4VdQZJ5OG7CX2TCjafuXGnXBSTRr0nvSUd+UXvtOts18mz
   StBdf9aAwATmBnqt+xzxXYpzSJTuZjBIg1tqLXjL2ljff0gnXz1fII9h7
   lp4VnxyNNMIBT6bqoPjer08Ce9l+Zz9xttfdCL405P6TgWoQHh06NKcSG
   qwJ7L9cTylQFkbAOEWpW+PiVvtxeSiF7/7K60kKDVz3a1UpalvZbHbCOT
   ok17aSbB3so65l3r2CXIOtJQR0sxfuwOcFaaOmma2L+xCDA4FnJsF0tvc
   Jyy1OyyfiYxNnGREUevc41H0blaoHuGAEPfWsPYbwxA5FV6aIHSugVqo9
   A==;
X-CSE-ConnectionGUID: 76ZgFiMaTv2XUQ82w+3VpA==
X-CSE-MsgGUID: nxaZhaclTFesCzta8JrhgQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11069"; a="11563670"
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="11563670"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 21:38:35 -0700
X-CSE-ConnectionGUID: iIFkOrjpSPeRKh0WmN5AWg==
X-CSE-MsgGUID: xTCZ96exT/uOfTUumPxtGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,153,1712646000"; 
   d="scan'208";a="34498979"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa003.jf.intel.com with ESMTP; 10 May 2024 21:38:33 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 992DE142; Sat, 11 May 2024 07:38:32 +0300 (EEST)
Date: Sat, 11 May 2024 07:38:32 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Lukas Wunner <lukas@wunner.de>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v4] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <20240511043832.GD4162345@black.fi.intel.com>
References: <7d68a112-0f48-46bf-9f6d-d99b88828761@amd.com>
 <20240423053312.GY112498@black.fi.intel.com>
 <7197b2ce-f815-48a1-a78e-9e139de796b7@amd.com>
 <20240424085608.GE112498@black.fi.intel.com>
 <CA+Y6NJFyi6e7ype6dTAjxsy5aC80NdVOt+Vg-a0O0y_JsfwSGg@mail.gmail.com>
 <Zi0VLrvUWH6P1_or@wunner.de>
 <CA+Y6NJE8hA+wt+auW1wJBWA6EGMc6CGpmdExr3475E_Yys-Zdw@mail.gmail.com>
 <ZjsKPSgV39SF0gdX@wunner.de>
 <20240510052616.GC4162345@black.fi.intel.com>
 <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+Y6NJF2Ex6Rwxw0a5V1aMY2OH4=MP5KTtat9x9Ge7y-JBdapw@mail.gmail.com>

Hi,

On Fri, May 10, 2024 at 11:44:12AM -0400, Esther Shimanovich wrote:
> Thank you Lukas and Mika!
> This is very useful and helpful!
> I am setting up two alternative builds with both of your suggested
> approaches and will test on devices once I get back into the office,
> hopefully around next week.
> 
> > +       /*
> > +        * Any integrated Thunderbolt 3/4 PCIe root ports from Intel
> > +        * before Alder Lake do not have the above device property so we
> > +        * use their PCI IDs instead. All these are tunneled. This list
> > +        * is not expected to grow.
> > +        */
> > +       if (pdev->vendor == PCI_VENDOR_ID_INTEL) {
> > +               switch (pdev->device) {
> > +               /* Ice Lake Thunderbolt 3 PCIe Root Ports */
> > +               case 0x8a1d:
> > +               case 0x8a1f:
> > +               case 0x8a21:
> > +               case 0x8a23:
> > +               /* Tiger Lake-LP Thunderbolt 4 PCIe Root Ports */
> > +               case 0x9a23:
> > +               case 0x9a25:
> > +               case 0x9a27:
> > +               case 0x9a29:
> > +               /* Tiger Lake-H Thunderbolt 4 PCIe Root Ports */
> > +               case 0x9a2b:
> > +               case 0x9a2d:
> > +               case 0x9a2f:
> > +               case 0x9a31:
> > +                       return true;
> > +               }
> > +       }
> > +
> 
> Something I noticed is that the list of root ports you have there does
> not include [8086:02b4] or [8086:9db4], the  Comet Lake and
> Whiskey/Cannon Point root ports that I saw on the laptops I tested on.
> Those laptops do not have the usb4-host-interface property. This makes
> me think that the patch won't work as is.

They are not integrated Thunderbolt PCIe root ports.

They should be "matched" with the second "rule" that looks for a
discrete controller directly behind an ExternalFacing PCIe root port.

