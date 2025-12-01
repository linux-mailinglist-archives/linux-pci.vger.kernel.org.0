Return-Path: <linux-pci+bounces-42378-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51C6C98355
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 17:18:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73DD23A2D68
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 16:18:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FFC30BBBD;
	Mon,  1 Dec 2025 16:18:20 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A815191F98
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 16:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764605900; cv=none; b=N61gpVAh+OVj+CQT/62CZnBXlv55z4hpHFP7zIfb+qo60C5eqzou1nC6NuWOJwG8htPeN0Jy1GrXjKxihTx5gVAznkiIo58fQ1JeGmV7mUmrQkfwoq3QAfiJzLgUh70za8JRAkXHDpPimmo6P5CFxVX72i4A40s96DPO/engZZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764605900; c=relaxed/simple;
	bh=oMuKzwEnVGAv2Q9Mi+YH6skz7WjAHcLeSl+jSz0/AJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DemxO+XWTarHRxajoDzwn/JeawseXyRrNgNkixSFwdGEU9xZ3ofVQzLXzEMr6Yd+Xt7jj/NPRq1GKGMJ9RmFKbnZ5QAyKqKHtwr4Kf3z/6PiJTq0192qValVj3UHZcrOpUy2oTH+qhW2LoUNsT7dMdWQ6M3ieTSKbYMlgSnvURo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 4ABA22C06AAD;
	Mon,  1 Dec 2025 17:18:09 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 44E6510B02; Mon,  1 Dec 2025 17:18:09 +0100 (CET)
Date: Mon, 1 Dec 2025 17:18:09 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	kanie <kanie@linux.alibaba.com>,
	alikernel-developer <alikernel-developer@linux.alibaba.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] PCI: Fix PCIe SBR dev/link wait error
Message-ID: <aS2_wccsS1rjiqQS@wunner.de>
References: <20251124104502.777141-1-guanghuifeng@linux.alibaba.com>
 <20251124235858.GA2726643@bhelgaas>
 <a4a2a5ee-1f4e-4560-b8cf-c9c10ae475dd.guanghuifeng@linux.alibaba.com>
 <aS1oArFHeo9FAuv-@wunner.de>
 <969657a9-ea6b-44a8-a06c-c2af52212493@linux.alibaba.com>
 <aS2XeetaEW1RoWus@wunner.de>
 <238d7010-b54a-49cc-b5d0-e8422f59310f@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <238d7010-b54a-49cc-b5d0-e8422f59310f@linux.alibaba.com>

On Mon, Dec 01, 2025 at 10:46:00PM +0800, guanghuifeng@linux.alibaba.com wrote:
> 在 2025/12/1 21:26, Lukas Wunner 写道:
> > On Mon, Dec 01, 2025 at 08:56:10PM +0800, guanghuifeng@linux.alibaba.com wrote:
> > > 2025/12/1 18:03, Lukas Wunner :
> > > > It seems highly unusual that the different functions of the same
> > > > physical device require different delays until they're accessible.
> > > >  I don't think we can accept such a sweeping change wholesale without
> > > > more details, so please share what the topology looks like (lspci -tv),
> > > > what devices are involved (lspci -vvv) and which device requires
> > > > extra wait time for some of its functions.
> 
> 1. Currently, there are significant differences in reset recovery times
> among some PCIe multifunction devices, especially when the functions and
> complexities vary greatly, including some devices used for testing purposes.

Which devices are we talking about exactly?  For internal test devices,
upstream changes to accomodate to quirks are usually frowned upon.
Because the expectation is that those changes can be kept in local
downstream kernel trees and products that actually ship to customers
do not exhibit those quirks.

> 2. Furthermore, similar implementations exist in various commercial devices
> (with vastly different functions), such as the multifunction devices
> (including VGA, audio functions, etc.) mentioned in the following link:
> 
> https://forums.developer.nvidia.com/t/nvidia-rtx-5090-not-detected-by-nvidia-smi-on-ubuntu-server-24-04/327409?page=2

I've looked at that forum discussion and it seems there's an issue with
Resizeable BAR support on certain Nvidia cards, but I'm not seeing
anything on that page relating to functions taking longer than
others to come out of reset.  So this doesn't seem to be related to
the present patch.

Thanks,

Lukas

