Return-Path: <linux-pci+bounces-5948-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0E789DE27
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 17:11:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 660C9294DB5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 15:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92C71353E3;
	Tue,  9 Apr 2024 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZgKtS4n1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913771350F8;
	Tue,  9 Apr 2024 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675142; cv=none; b=HQK7SQMavg60OheFhLbFAP0cpnRR7RPnQXU7gLwPPca5EUpBjUJjrM4e1h8eES6fDNYNpbnnIex+nPyvwLDLA8orbO6X2qdXR5AnPukWGRKo/Lu2xsyhGWDkQzR77dlSNUCRf1qzKuQZKRLZjiXt9LNW2/GPFdXGW1SYngn6+fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675142; c=relaxed/simple;
	bh=DnW+ZSd/0xQo4qbfGefRwTZhZVybrqtZp9WDgqwtlGM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=V3cxRFihEVhvOpI/kPevWgYGWQZsdt64+O6L3W/Bony3gF4YLaN3R0DwmXi3swL9Gxer1e689sw5NjJeWAd5ao3wq3DGvw5LroTooq8ONqIwRnkeb8xoXw0s19qCr8/6wRHrTeqzKR5HnE3EshEGtGThxLmB/Vid0Bh8Pd3T2Eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZgKtS4n1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1D4C433C7;
	Tue,  9 Apr 2024 15:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712675142;
	bh=DnW+ZSd/0xQo4qbfGefRwTZhZVybrqtZp9WDgqwtlGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ZgKtS4n1+nQp8F9cpC5UJ9eZTULQAh8lQ1AmHr1/4oKt+HYOfCFfJVWkBFa1ZXr8d
	 zG7kSwYO3VBtLLwM4WYvUejamVOHJOvzixgKu4jsyV/1Y3UXBWA7TzKWe3+hcn3gxC
	 +c/zQz7whynWT67di3X6gCurD502l3NohiXYhHsmaEMSXHkczw/H8yJRQwpVBnQ1bJ
	 zwTzjSFi1xOvtgJ3qscnI4jUQT8XD64z0oICLrZ/kpthM+pbH6M9O4lVYGvO+vnyw2
	 1cJmpKlkKtPdJkCyqPPryKKudjcjBwEI1PE3/MJBN5yGiyRPNWrEXpjEZz8sKJv9YT
	 uhhi1Zx35m/YA==
Date: Tue, 9 Apr 2024 10:05:40 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Kobayashi,Daisuke" <kobayashi.da-06@fujitsu.com>
Cc: kobayashi.da-06@jp.fujitsu.com, linux-cxl@vger.kernel.org,
	y-goto@fujitsu.com, linux-pci@vger.kernel.org, mj@ucw.cz,
	dan.j.williams@intel.com
Subject: Re: [PATCH v4 3/3] cxl/pci: Add sysfs attribute for CXL 1.1 device
 link status
Message-ID: <20240409150540.GA2076036@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240409073528.13214-4-kobayashi.da-06@fujitsu.com>

On Tue, Apr 09, 2024 at 04:35:28PM +0900, Kobayashi,Daisuke wrote:
> Add sysfs attribute for CXL 1.1 device link status to the cxl pci device.
> 
> In CXL1.1, the link status of the device is included in the RCRB mapped to
> the memory mapped register area. Critically, that arrangement makes the link
> status and control registers invisible to existing PCI user tooling.

Idle thought: PCIe does define RCRB, even pre-CXL.  Maybe the PCI core
should be enhanced to comprehend RCRB directly?

> +static ssize_t rcd_link_status_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct cxl_port *port;
> +	struct cxl_dport *dport;
> +	struct device *parent = dev->parent;
> +	struct pci_dev *parent_pdev = to_pci_dev(parent);
> +
> +	port = cxl_pci_find_port(parent_pdev, &dport);
> +	if (!port)
> +		return -EINVAL;
> +
> +	return sysfs_emit(buf, "%x\n", dport->rcrb.rcd_lnkstatus);

Is it really what you want to capture PCI_EXP_LNKSTA once at
enumeration-time and expose that static value forever?  I assume
status bits can change over time, so I would naively expect that you
want the *current* value, not just a value from the distant past.

Bjorn

