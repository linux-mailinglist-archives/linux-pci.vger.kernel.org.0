Return-Path: <linux-pci+bounces-14282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5233C99A213
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7356C1C23714
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 10:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44A8C212D1F;
	Fri, 11 Oct 2024 10:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Iw0mc2Uv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A2D1D0E15
	for <linux-pci@vger.kernel.org>; Fri, 11 Oct 2024 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728644135; cv=none; b=HEk+HgZ1nv3+EJG1jMEEAzKhcX+SsfKaQTZFI9rbBwBizNdcoSwSAdo0+EPxka0PUsMP0K2VLUrqFZleDrjlS3vzcDDmhD8UbX9llM/KTDzoGEZ3a3A7yiVfWf6BuJ0bXYcZ4eWR1YZQvW29nibGlYCPkW20jjkXPCokx5OgTFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728644135; c=relaxed/simple;
	bh=aiv1P3XsMpi60Lwg4YlepgeVi6cGICVmMaMjSJiY0Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ESjlDzimjJ5pStYhWezJAT0kxaKRqQlFX7Bbxwbnw1sH9tNKpZa8gbrg37yhgqnDGBccjN3tYxroB3tNDu4EDn7N3gT54Tti7BWvT6RBIdZxoS8IRdkg+jfSV1KsXW87plS9G5FDmOLKRhZ7duQSRAz9ZNthT/8sav8u5DrgwnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Iw0mc2Uv; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728644134; x=1760180134;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=aiv1P3XsMpi60Lwg4YlepgeVi6cGICVmMaMjSJiY0Hs=;
  b=Iw0mc2Uv+4nrl8AZ4+ZNHiIDE8Dy5s3XKuBT7hxBJR6/fJwYAs/FQYcD
   3fPhMkT4TQ/VmX78rXQSNUwde0Cj2j2k1FC9BJ8T1CHN+8/yuM6Z/XfJp
   IGlfFJvem0htTFkPYIkQ6iNfhKYmn9aTaRzO71HtSQxxHrOSdhjiwgamA
   pdUCHcq6fKPJcPTIjZbrRicNETZ/lsXl7xkc8Vk1FbnSLtVQmObO7Dsp8
   7CslIKXsExxrYAIQoVbSyrpKanKq/EDX6HeFJR7WwljTGQ6uLGb+kwzZJ
   iYBTTwGJcCRhgjiKfsq9IrF2EUJT1bGhpbztC39RdzEeAmA7E0gqLZkLa
   A==;
X-CSE-ConnectionGUID: W/RN+MxdQD+JYZztM/v6sA==
X-CSE-MsgGUID: MHwACe8JTqelsg59CgtcqA==
X-IronPort-AV: E=McAfee;i="6700,10204,11221"; a="31834901"
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="31834901"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2024 03:55:34 -0700
X-CSE-ConnectionGUID: 6ID5idnSSf2ThRB6v5rMDQ==
X-CSE-MsgGUID: Q2Web5X6TsKh0F2c/bnhlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,195,1725346800"; 
   d="scan'208";a="80888195"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa003.fm.intel.com with ESMTP; 11 Oct 2024 03:55:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 5C338184; Fri, 11 Oct 2024 13:55:29 +0300 (EEST)
Date: Fri, 11 Oct 2024 13:55:29 +0300
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Dennis Wassenberg <Dennis.Wassenberg@secunet.com>,
	Rafael Wysocki <rafael@kernel.org>,
	Alex Williamson <alex.williamson@redhat.com>,
	linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Mathias Krause <minipli@grsecurity.net>,
	Mark Pearson <mpearson-lenovo@squebb.ca>,
	Stuart Hayes <stuart.w.hayes@gmail.com>
Subject: Re: [PATCH] PCI: Fix use-after-free of slot->bus on hot remove
Message-ID: <20241011105529.GH275077@black.fi.intel.com>
References: <4bfd4c0e976c1776cd08e76603903b338cf25729.1728579288.git.lukas@wunner.de>
 <20241011054115.GG275077@black.fi.intel.com>
 <Zwj6Fycjyp6jlgY5@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zwj6Fycjyp6jlgY5@wunner.de>

On Fri, Oct 11, 2024 at 12:12:39PM +0200, Lukas Wunner wrote:
> On Fri, Oct 11, 2024 at 08:41:15AM +0300, Mika Westerberg wrote:
> > On Thu, Oct 10, 2024 at 07:10:34PM +0200, Lukas Wunner wrote:
> > > Dennis reports a boot crash on recent Lenovo laptops with a USB4 dock.
> > > 
> > > Since commit 0fc70886569c ("thunderbolt: Reset USB4 v2 host router") and
> > > commit 59a54c5f3dbd ("thunderbolt: Reset topology created by the boot
> > > firmware"), USB4 v2 and v1 Host Routers are reset on probe of the
> > > thunderbolt driver.
> > > 
> > > The reset clears the Presence Detect State and Data Link Layer Link Active
> > > bits at the USB4 Host Router's Root Port and thus causes hot removal of
> > > the dock.
> > 
> > Can't this happen also simply unplug at some part of the PCIe topology?
> > I don't think this is specific to TB/USB4.
> 
> The crash seems to occur because the boot-time invocation of
> pci_bus_add_devices() races with pciehp's pci_stop_and_remove_bus_device().
> 
> In principle, yes, on a non-USB4 system you could unplug the dock exactly
> when pci_bus_add_devices() is running and cause the same crash, even though
> the Host Router is not reset.  But that's very hard to reproduce.
> You need to unplug at just the right moment.
> 
> In this case however the reset of the Host Router seems to reliably
> reproduce the conditions to cause the crash, so I thought it's worth
> calling that out explicitly.  USB4 Host Routers are readily available
> in the field and becoming more and more commonplace, so chances that
> users experience the crash are high -- specifically if they're booting
> a USB4 system with attached Thunderbolt devices.

Yeah agree, makes sense.

