Return-Path: <linux-pci+bounces-9246-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 632B0916E0F
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 18:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9415C1C23384
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jun 2024 16:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5769D16F913;
	Tue, 25 Jun 2024 16:26:14 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7500D171E41;
	Tue, 25 Jun 2024 16:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719332774; cv=none; b=syeTg6VudffnTddHzTytfNO9P8F+F7bmcNNJR3mE3a15o9NrcaW14MtMyI2zwNF45q4mbEsfXXXQQtNWqzsaIgkyifRvjZvd1OMoTNF5/ehlo6GeYY1J0krw7xGVIE3P9xuYlqaPWf7ym7nxAc5skpGejWX2OiZsn49nZ2GZa4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719332774; c=relaxed/simple;
	bh=oy+bElgkbcQmzHj7fmn/6KbrN65wi3Xoq/EADV3ygto=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CRIR/FKS7ZIEmi8KjXb0Uw+3EZFx1E7J27GR2jPL7G+0qvCaDUrV82mo1Ru0a59BmTi9E4gn+8tqfAjiTCvS8xg/Tnh8ikMigmrUMYL++Qp3dbRet1zpj0Fo/B1dD3wQ17AbfThLhmbyLXbtIK2LRhg50xQ5joLdvAolF0eK05c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id A73F830010DF5;
	Tue, 25 Jun 2024 18:26:00 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 910484BC19; Tue, 25 Jun 2024 18:26:00 +0200 (CEST)
Date: Tue, 25 Jun 2024 18:26:00 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Vidya Sagar <vidyas@nvidia.com>
Cc: corbet@lwn.net, bhelgaas@google.com, galshalom@nvidia.com,
	leonro@nvidia.com, jgg@nvidia.com, treding@nvidia.com,
	jonathanh@nvidia.com, mmoshrefjava@nvidia.com, shahafs@nvidia.com,
	vsethi@nvidia.com, sdonthineni@nvidia.com, jan@nvidia.com,
	tdave@nvidia.com, linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] PCI: Extend ACS configurability
Message-ID: <ZnrvmGBw-Ss-oOO6@wunner.de>
References: <20240523063528.199908-1-vidyas@nvidia.com>
 <20240625153150.159310-1-vidyas@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240625153150.159310-1-vidyas@nvidia.com>

On Tue, Jun 25, 2024 at 09:01:50PM +0530, Vidya Sagar wrote:
> Add a kernel command-line option 'config_acs' to directly control all the
> ACS bits for specific devices, which allows the operator to setup the
> right level of isolation to achieve the desired P2P configuration.

An example wouldn't hurt, here and in kernel-parameters.txt.


> ACS offers a range of security choices controlling how traffic is
> allowed to go directly between two devices. Some popular choices:
>   - Full prevention
>   - Translated requests can be direct, with various options
>   - Asymmetric direct traffic, A can reach B but not the reverse
>   - All traffic can be direct
> Along with some other less common ones for special topologies.

I'm wondering whether it would make more sense to let users choose
between those "higher-level" options, instead of giving direct access
to bits (and thus risking users to choose an incorrect setting).

Also, would it be possible to automatically change ACS settings
when enabling or disabling P2PDMA?

The representation chosen here (as a command line option) seems
questionable:

We're going to add more user-controllable options going forward.
E.g., when introducing IDE, we'll have to let user space choose
whether encryption should be enabled for certain PCIe devices.
That's because encryption isn't for free, so can't be enabled
opportunistically.  (The number of crypto engines on a CPU is
limited and enabling encryption consumes energy.)

What about exposing such user configurable settings with sysctl?
The networking subsystem has per-interface sysctl settings,
we could have per-PCI-device settings.

So just like this...

net.ipv4.conf.default.arp_accept = 0
net.ipv4.conf.eth0.arp_accept = 0
net.ipv4.conf.eth1.arp_accept = 0

... we could have...

pci.0000:03:00.0.acs = full_prevention
pci.0000:03:00.0.ide = 1
pci.0000:03:01.0.acs = all_traffic
pci.0000:03:01.0.ide = 0

This isn't hard to do, just call register_sysctl() for each device
on enumeration and unregister_sysctl_table() on pci_destroy_dev().

Thanks,

Lukas

