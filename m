Return-Path: <linux-pci+bounces-33578-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CC4B1DE3C
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 22:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 253617B55D6
	for <lists+linux-pci@lfdr.de>; Thu,  7 Aug 2025 20:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1123325F784;
	Thu,  7 Aug 2025 20:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A53dJri8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1584238D54;
	Thu,  7 Aug 2025 20:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754598255; cv=none; b=YYffMqvSBkwvKZDrnDfXUlV0ETGTcCHpcJkTGr7NcpMJitWaGeFSmwiEuvEFauwtglLQy3zCt8mivEgThFFDnK5cHY2GMsAlTlAIwPcSoPu5nz7+grrdIim7mZDwr0TsePPLUHxQlHdzO+0AOiYvmT9T/dK52T6Ca8V3EA3QpsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754598255; c=relaxed/simple;
	bh=w56Fm8QQWgdrpjsnEzkkPxBRYWWXw7L9fTHzBHniPQg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=VbDEES4y+FtBsPmuoZrGA98mV8wOoMUsWYxzUde3gSf7+gtcdyf0qQz6z9BKmdPkqqtjXM9ZWD4A+y5kosNZkuFOpyeFuqhI/qvV9E14449aVO1bbBsVOKNY1gw7DgbcbYhNX5EZ3ZtXueqltYVqOy1L5Khb+KuQjRwq0dSZtYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A53dJri8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AA68C4CEEB;
	Thu,  7 Aug 2025 20:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754598255;
	bh=w56Fm8QQWgdrpjsnEzkkPxBRYWWXw7L9fTHzBHniPQg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=A53dJri8niNA7EsnRET8LQvNeDhL0QB+E1iy0hZZ7DagU6tlIFxyDsXW2Ghk/RQak
	 Xxew23iOpsfI1BGUooyHB7FXmI7aK471m0oh0JkyqRXoXSUUQ5jN7NT5DH0dzDgjVa
	 4sYvPLTAhfrI3Jd2BxWcfrOt1g1USdxPE2geJTi/kOB6XE79nq4YYb8hbcTjLY1rld
	 I0/jlFicantyTwWvRGVKqCrb5qdm75AGVQSHpJMD76or1BI7G/Bih1+/tRHx/ngUSt
	 dyZcSz4Nbvsq2fqbyQzNDQ9K07rhln/iNFp9541MYB0Gt5abWo5knqZSqKSu1J0m2C
	 JHBn5JY/hdtcQ==
Date: Thu, 7 Aug 2025 15:24:13 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-coco@lists.linux.dev, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, bhelgaas@google.com, aik@amd.com,
	lukas@wunner.de
Subject: Re: [PATCH v4 03/10] PCI: Introduce pci_walk_bus_reverse(),
 for_each_pci_dev_reverse()
Message-ID: <20250807202413.GA61777@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250717183358.1332417-4-dan.j.williams@intel.com>

On Thu, Jul 17, 2025 at 11:33:51AM -0700, Dan Williams wrote:
> PCI/TSM, the PCI core functionality for the PCIe TEE Device Interface
> Security Protocol (TDISP), has a need to walk all subordinate functions of
> a Device Security Manager (DSM) to setup a device security context. A DSM
> is physical function 0 of multi-function or SRIOV device endpoint, or it is
> an upstream switch port.

s/SRIOV/SR-IOV/

> In error scenarios or when a TEE Security Manager (TSM) device is removed
> it needs to unwind all established DSM contexts.
> 
> Introduce reverse versions of PCI device iteration helpers to mirror the
> setup path and ensure that dependent children are handled before parents.

I really don't like these search and iterator interfaces.  I wish we
didn't need them like this because code that uses them becomes a
one-time thing that doesn't handle hotplug and has potential locking
and race issues.  But I assume you really do need these.

> +++ b/drivers/base/bus.c
> +static struct device *prev_device(struct klist_iter *i)
> +{
> +	struct klist_node *n = klist_prev(i);
> +	struct device *dev = NULL;
> +	struct device_private *dev_prv;
> +
> +	if (n) {
> +		dev_prv = to_device_private_bus(n);
> +		dev = dev_prv->device;
> +	}
> +	return dev;

I think this would be simpler as:

  if (!n)
    return NULL;

  dev_prv = to_device_private_bus(n);
  return dev_prv->device;

> +++ b/drivers/pci/bus.c
> +static int __pci_walk_bus_reverse(struct pci_bus *top,
> +				  int (*cb)(struct pci_dev *, void *),
> +				  void *userdata)
> +{
> +	struct pci_dev *dev;
> +	int ret = 0;
> +
> +	list_for_each_entry_reverse(dev, &top->devices, bus_list) {
> +		if (dev->subordinate) {
> +			ret = __pci_walk_bus_reverse(dev->subordinate, cb,
> +						     userdata);
> +			if (ret)
> +				break;
> +		}
> +		ret = cb(dev, userdata);
> +		if (ret)
> +			break;
> +	}
> +	return ret;

Why not:

  list_for_each_entry_reverse(...) {
    ...
    if (ret)
      return ret;
  }
  return 0;

