Return-Path: <linux-pci+bounces-17946-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AFF2C9E974E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 14:38:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E117816387E
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B08841B0410;
	Mon,  9 Dec 2024 13:36:12 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E971E1A2390;
	Mon,  9 Dec 2024 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751372; cv=none; b=sqVgf80R6q2xKf31lyG4a37KiQieNLgZdVzNZ891JgbRb4oEp0CTVnqKVg12TNdxZL5QCKzxu65Nljhclsa1Ak3jbjL4t1hsSsM2Xoh5mSNYzyMn9dlCe+sPZ3CgjzxDKdkM5gvZg1CPUNgTcBqq47vG3esds9DR0fVJvbv9zPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751372; c=relaxed/simple;
	bh=wq1DDZAezV9QO/2CMZxmkf3konmwXSONzuqbFui9jhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fgcu90JUQyqlTtgsj3pLJWFG/ydOMtAa0JWnxWlzNt6Kk+BZYukhLIUvVgQ+dx6PR1K3uJWaphDwuoktHkMGm1g+uXXScf7YgprKSmnaBpBxdwiaVCnltF38mlCB2/rHBp0AeyChlaqDNlg2q/bu0tzwkRPIa++OprYBqxmrqWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id C93D268D13; Mon,  9 Dec 2024 14:36:06 +0100 (CET)
Date: Mon, 9 Dec 2024 14:36:06 +0100
From: Christoph Hellwig <hch@lst.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, andersson@kernel.org,
	konradybcio@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by
 the user
Message-ID: <20241209133606.GA18172@lst.de>
References: <20241205232900.GA3072557@bhelgaas> <20241206014934.GA3081609@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241206014934.GA3081609@bhelgaas>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Dec 05, 2024 at 07:49:34PM -0600, Bjorn Helgaas wrote:
> Oops, I think I got this part backwards.  The patch uses PCI PM if
> d3cold_allowed is set, and it's set by default, so it does what you
> need for the Qualcomm platform *without* user intervention.
> 
> But I guess using the flag allows users in other situations to force
> use of NVMe power management by clearing d3cold_allowed via sysfs.
> Does that mean some unspecified other platforms might only work
> correctly with that user intervention?

Still seems awkward to overload fields like this.

The istory here is the the NVMe internal power states are significantly
better for the SSDs.  It avoid shutting down the SSD frequently, which
creates a lot of extra erase cycles and reduces life time.  It also
prevents the SSD from performing maintainance operations while the host
system is idle, which is the perfect time for them.  But the idea of
putting all periphals into D3 is gaining a lot of ground because it
makes the platform vendors life a lot simpler at the cost of others.

