Return-Path: <linux-pci+bounces-23103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE5AA56581
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 11:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19FA918939F7
	for <lists+linux-pci@lfdr.de>; Fri,  7 Mar 2025 10:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4BC20D507;
	Fri,  7 Mar 2025 10:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Woi8Qtih"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEE993398B;
	Fri,  7 Mar 2025 10:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741343703; cv=none; b=qaT7hYmlsM5fkhhC4oBEQN+//YPNJJfcFomqYtP+zpTQ1MGXCZNZD9RGyWyYtJVYCPcE+eVwTgTPhhvdx8lWvs338p75Gg72hceWcL0MHK3mk/mwHvKjIJ02PqkdcnPgDvh74rj337RXf1h7ZwWulcDfued9PxQNsQcPt0UW9RM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741343703; c=relaxed/simple;
	bh=xjae9IY5NUoQoSh58YJCTzAFqEQ1hyZz6whVqzqCRPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FobLqxeaJx6fzMICRGOdxWvYpl/urxkzfBb/Skq/IXb9oAUGGFrDP9YW/saT7G8fIGxQI/P3uXUofIMSDPwXiH5+eySs2rZh5g3xijYy9V2V28k/1gEhuox16Q7XHV/pkWIcMDL2UlvAxVBNJf3UXSVJmzpRpjmLN9xJ3XlLoK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Woi8Qtih; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741343701; x=1772879701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xjae9IY5NUoQoSh58YJCTzAFqEQ1hyZz6whVqzqCRPg=;
  b=Woi8QtihHoirpS7OTVTxhsDNCQEkmQnIqEi8A6T8vHT8hLyXbxF+a57Z
   NRH1nbeiKqg7KCctXlv/xUTW5uAbz2wG1U6/amn+Hj6F6NDYjRczd4adu
   ygZ6LKyvTLiPLHHgnQjLjlLBocf1SBchiHCav4BC+cNPwo7q4fpZ6YM7e
   hGIIyBJVUd2gYql+Cy6ZvZVc34hUnLkCOUA1XhlDF/g/ySBnCVIOnsXZ2
   IpZvOA+aIjgpHBuWYOJmDNm01tFmV+0HbgjS/Ww4dZO5EpvkX5zdrBQ8q
   zjJ2mozNWfk0xNK2S+pxl9413aodk91JdO87u6U+pvelHrkurY6m3PF3q
   Q==;
X-CSE-ConnectionGUID: qvonheUWQOy+YlH/NnxqMw==
X-CSE-MsgGUID: V7f8n9FhTjK1HwDdd4ob+w==
X-IronPort-AV: E=McAfee;i="6700,10204,11365"; a="59945889"
X-IronPort-AV: E=Sophos;i="6.14,228,1736841600"; 
   d="scan'208";a="59945889"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Mar 2025 02:35:01 -0800
X-CSE-ConnectionGUID: hJ4L0/sIRFyP61Myb029pA==
X-CSE-MsgGUID: 1G8ulXDaR8WIdXvCYlOhcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119812746"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa007.jf.intel.com with ESMTP; 07 Mar 2025 02:34:58 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id CD1ED1FC; Fri, 07 Mar 2025 12:34:56 +0200 (EET)
Date: Fri, 7 Mar 2025 12:34:56 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Lukas Wunner <lukas@wunner.de>
Cc: Kenneth Crudup <kenny@panix.com>, Bjorn Helgaas <helgaas@kernel.org>,
	ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	Jian-Hong Pan <jhp@endlessos.org>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikl??vs Ko??es??ikovs <pinkflames.linux@gmail.com>,
	Andreas Noever <andreas.noever@gmail.com>,
	Michael Jamet <michael.jamet@intel.com>,
	Yehezkel Bernat <YehezkelShB@gmail.com>, linux-usb@vger.kernel.org
Subject: Re: diagnosing resume failures after disconnected USB4 drives (Was:
 Re: PCI/ASPM: Fix L1SS saving (linus/master commit 7507eb3e7bfac))
Message-ID: <20250307103456.GX3713119@black.fi.intel.com>
References: <20250213135911.GG3713119@black.fi.intel.com>
 <a8d6ca75-8f50-4c46-8c67-fcf20d870dcc@panix.com>
 <20250214162948.GJ3713119@black.fi.intel.com>
 <661459dd-67d0-4e1c-bb28-9adf1417f660@panix.com>
 <20250226084404.GM3713119@black.fi.intel.com>
 <Z77ak-4YsdAKXbHr@wunner.de>
 <20250226091958.GN3713119@black.fi.intel.com>
 <Z8YKXC1IXYXctQrZ@wunner.de>
 <20250304082314.GE3713119@black.fi.intel.com>
 <Z8nRI6xjGl3frMe5@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z8nRI6xjGl3frMe5@wunner.de>

On Thu, Mar 06, 2025 at 05:45:23PM +0100, Lukas Wunner wrote:
> On Tue, Mar 04, 2025 at 10:23:14AM +0200, Mika Westerberg wrote:
> > Unfortunately I still see the same hang. I double checked, with revert the
> > problem goes a way and with this patch I still see it.
> > 
> > Steps:
> > 
> > 1. Boot the system, nothing connected.
> > 2. Connect TBT 4 dock to the host.
> > 3. Connect TBT 3 NVMe to the TBT4 doc.
> > 4. Authorize both PCIe tunnels, verify devices are there.
> > 5. Enter s2idle.
> > 6. Unplug the TBT 4 dock from the host.
> > 7. Exit s2idle.
> 
> Thanks for testing.  Would you mind giving the below a spin?

Sure.

> I've realized this can likely be solved in a much easier way:
> 
> The ->resume_noirq callback is invoked while traversing down
> the hierarchy and the topmost slot which detects device replacement
> already marks everything below as disconnected.  Hence any nested
> hotplug ports can just skip the replacement check because they're
> disconnected as well.

Makes sense.

Tried the patch now and it solves the issue. Thanks!

Tested-by: Mika Westerberg <mika.westerberg@linux.intel.com>

> 
> -- >8 --
> 
> diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
> index ff458e6..997841c 100644
> --- a/drivers/pci/hotplug/pciehp_core.c
> +++ b/drivers/pci/hotplug/pciehp_core.c
> @@ -286,9 +286,12 @@ static int pciehp_suspend(struct pcie_device *dev)
>  
>  static bool pciehp_device_replaced(struct controller *ctrl)
>  {
> -	struct pci_dev *pdev __free(pci_dev_put);
> +	struct pci_dev *pdev __free(pci_dev_put) = NULL;
>  	u32 reg;
>  
> +	if (pci_dev_is_disconnected(ctrl->pcie->port))
> +		return false;
> +
>  	pdev = pci_get_slot(ctrl->pcie->port->subordinate, PCI_DEVFN(0, 0));
>  	if (!pdev)
>  		return true;

