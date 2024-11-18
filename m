Return-Path: <linux-pci+bounces-17045-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6679D1112
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 13:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74B9D28184F
	for <lists+linux-pci@lfdr.de>; Mon, 18 Nov 2024 12:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5251974FA;
	Mon, 18 Nov 2024 12:58:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CB6A190468;
	Mon, 18 Nov 2024 12:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731934704; cv=none; b=BVXzSGGVa+rUhqxBAmMUy1+RnJVjJWRk0Cda4GaW5B9wuIJNZnpYNFBNMoXPp6Spjxq5ISHW88XdNg3cevumi9VTAOUjj3/NpyMoooCq993KnXFaApxmsAaXPIQKNa8inoSXaOwVN5lfM1d4We6w5PF1aCJPauxStc5Bxfym9eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731934704; c=relaxed/simple;
	bh=70AquGBTZ3QUUHrW9NFyNKBZcJBL8kKZRsrCGtoiQpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y52M0p2d+bAz8yYX3NRzgBHMouUU+uJEPgQ9EJJiCkolrSm3XBU1V4aNCa1jLJb1AfxGmd980D8M4jrYrf2+GlaGBgpwM6OOj4natgSOQ26IEXHIMU8Vew8AHLaefd+gE6R+34yqSXwq1yl7a8haUtyXWqY2y9w4+7j5WbCYrxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1FBD468D09; Mon, 18 Nov 2024 13:58:18 +0100 (CET)
Date: Mon, 18 Nov 2024 13:58:17 +0100
From: Christoph Hellwig <hch@lst.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Acked-by@lst.de:"Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241118125817.GA28046@lst.de>
References: <20241118082344.8146-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241118082344.8146-1-manivannan.sadhasivam@linaro.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Nov 18, 2024 at 01:53:44PM +0530, Manivannan Sadhasivam wrote:
> PCI core allows users to configure the D3Cold state for each PCI device
> through the sysfs attribute '/sys/bus/pci/devices/.../d3cold_allowed'. This
> attribute sets the 'pci_dev:d3cold_allowed' flag and could be used by users
> to allow/disallow the PCI devices to enter D3Cold during system suspend.
>
> So make use of this flag in the NVMe driver to shutdown the NVMe device
> during system suspend if the user has allowed D3Cold for the device.
> Existing checks in the NVMe driver decide whether to shut down the device
> (based on platform/device limitations), so use this flag as the last resort
> to keep the existing behavior.

Umm, what?  The documentation of this attribute says:

"d3cold_allowed is bit to control whether the corresponding PCI
 device can be put into D3Cold state.  If it is cleared, the
 device will never be put into D3Cold state.  If it is set, the
 device may be put into D3Cold state if other requirements are
 satisfied too.  Reading this attribute will show the current
 value of d3cold_allowed bit. Writing this attribute will
 the value of d3cold_allowed bit."

Which honestly already sounds rather non-specific, but everything but
a mandate for drivers to act on it.

The only place currently checking it is pci_dev_check_d3cold in the
PCI core, which is used to set the bridge_d3 attibute.

So blindly using it in a driver to force a different PM strategy feels
completely wrong.  Even if the attrite should have that effect it
needs to happen through a well documented PCI or PM layer helper and
open coded like this.


