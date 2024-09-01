Return-Path: <linux-pci+bounces-12561-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA6BA96758F
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 10:26:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82BC282553
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 08:26:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 104D3143879;
	Sun,  1 Sep 2024 08:26:03 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FDC2E651;
	Sun,  1 Sep 2024 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725179163; cv=none; b=Ol3K28NzXvJ0TW9uEj3ifovIBL9eaz2Jp4+9GtbRKpS3dRc0nv6PTZZZSrEAnYse2Ot4+C62aHJGvCMs1DnlSIbB2f5C31Eam//cj1ckQazuiYduhAUREpUhijBzsdpOxj5TYW6p3Fpmsz466KbYxrOOQbeOlHetApLMErSyh1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725179163; c=relaxed/simple;
	bh=e7PHvjSgVOrHNvH+bPaDJqaVfKDrurZeLMHuR1frPp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CyFV3k6kgcrg54TLus7TWZkM4zHLfYYk0DxWbDbC2wuo5U4K+q/yvm6OPHiHwBm/bLaN9rziuS8jqkBXk+rNo2e90qbfno9KD3Y/cxYiAsrdDlOBzDOv48r6clrIjNN0qRl/rVRJtEl7ngc8i2hhGvR55ORncKvWHhagGPCBosc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 61E51100D9438;
	Sun,  1 Sep 2024 10:25:51 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 1E16D11B173; Sun,  1 Sep 2024 10:25:51 +0200 (CEST)
Date: Sun, 1 Sep 2024 10:25:51 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Tony Hutter <hutter2@llnl.gov>
Cc: bhelgaas@google.com, minyard@acm.org, linux-pci@vger.kernel.org,
	openipmi-developer@lists.sourceforge.net,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: Introduce Cray ClusterStor E1000 NVMe slot LED
 driver
Message-ID: <ZtQlD7PPE4TUhZf4@wunner.de>
References: <40c7776f-b168-4cbe-a352-122e56fe7b31@llnl.gov>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40c7776f-b168-4cbe-a352-122e56fe7b31@llnl.gov>

On Tue, Aug 27, 2024 at 02:03:48PM -0700, Tony Hutter wrote:
> Add driver to control the NVMe slot LEDs on the Cray ClusterStor E1000.
> The driver provides hotplug attention status callbacks for the 24 NVMe
> slots on the E1000.  This allows users to access the E1000's locate and
> fault LEDs via the normal /sys/bus/pci/slots/<slot>/attention sysfs
> entries.  This driver uses IPMI to communicate with the E1000 controller to
> toggle the LEDs.

The PCISIG has converged on the NPEM interface (PCIe r6.2 sec 6.28 and
7.9.19) to control LEDs on storage enclosures.  We're in the process of
upstreaming that:

https://lore.kernel.org/all/20240814122900.13525-1-mariusz.tkaczyk@linux.intel.com/

Of course proprietary interfaces such as the Cray one are still
upstreamable as long as you're willing to maintain them.

The NPEM implementation linked above models each LED as a led_classdev.
I'd suggest following that instead of using the legacy "attention"
interface in sysfs.  Overloading the {set,get}_attention_status()
callbacks like you're doing here is not acceptable upstream IMO.

You need to be careful about the lifetime of the pci_dev below which
you're adding led_classdevs (or of which you're modifying the
{set,get}_attention_status() callbacks) because pci_devs can be removed
via sysfs at any time.

Basically what you need to do is find the pci_dev in craye1k_new_smi()
and acquire a reference on it with pci_dev_get().  Install a bus notifier
so that you get notified when the pci_dev is removed.  In the notifier,
you need to remove the ledclass_devs and release the reference on the
pci_dev with pci_dev_put().  See here for an example how to add a
notifier for pci_bus_type:

https://github.com/l1k/linux/commit/d2d5296785c7

The statistics should live in debugfs instead of regular sysfs.

The command line options should likewise live in debugfs.
New command line options are generally ill received because the
expectation is that everything is configured correctly automatically
without the user having to fiddle with command line options.

Please add documentation for the user space ABI you're introducing to
Documentation/ABI/testing/sysfs-bus-pci.

The MODULE_SOFTDEP("pre: pciehp") doesn't really make any sense
because pciehp is always builtin or disabled, but never modular.

Thanks,

Lukas

