Return-Path: <linux-pci+bounces-42367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AB16FC9798A
	for <lists+linux-pci@lfdr.de>; Mon, 01 Dec 2025 14:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8D484E1CD3
	for <lists+linux-pci@lfdr.de>; Mon,  1 Dec 2025 13:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFF5E313520;
	Mon,  1 Dec 2025 13:26:22 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00DF30FC35
	for <linux-pci@vger.kernel.org>; Mon,  1 Dec 2025 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764595582; cv=none; b=C4FxQrnrd/dVWBeuX3mUrDpA2ZyzsMG+FrN296aoDOq0OkP34wzdLglo1yQZb//zSYC6kj4O37OFa71rAzg0z0M9zoVEDiOP2T92y5UuZdOSLxszaSoXBMT6BBtYNPuV+PLdc8NOBfrQmA41nA12gbNN/WioDKsHujjBI8XyW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764595582; c=relaxed/simple;
	bh=sokggr8bO/LgBuyGjRQJCRAZyeKmO4+IyJXkOVOAZqk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m7FGmtywFbC1jjJvJBZymsY3kPf+0PVMX3+SdyhIOspGOmXlo3Vfuue6oEa76E/J3LynhMhd+B2VoCVHEDR9pNZHMNimNUf3luImdvNiE4VO8Gmi50VlOAwgJQeOtrEUVYyvpl3pzk5iOMqcN4E315f7QAP8xWlE4H8nhlBHDQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A47AA2C0525E;
	Mon,  1 Dec 2025 14:26:17 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 71B1710A84; Mon,  1 Dec 2025 14:26:17 +0100 (CET)
Date: Mon, 1 Dec 2025 14:26:17 +0100
From: Lukas Wunner <lukas@wunner.de>
To: "guanghuifeng@linux.alibaba.com" <guanghuifeng@linux.alibaba.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	kanie <kanie@linux.alibaba.com>,
	alikernel-developer <alikernel-developer@linux.alibaba.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: Re: [PATCH] PCI: Fix PCIe SBR dev/link wait error
Message-ID: <aS2XeetaEW1RoWus@wunner.de>
References: <20251124104502.777141-1-guanghuifeng@linux.alibaba.com>
 <20251124235858.GA2726643@bhelgaas>
 <a4a2a5ee-1f4e-4560-b8cf-c9c10ae475dd.guanghuifeng@linux.alibaba.com>
 <aS1oArFHeo9FAuv-@wunner.de>
 <969657a9-ea6b-44a8-a06c-c2af52212493@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <969657a9-ea6b-44a8-a06c-c2af52212493@linux.alibaba.com>

On Mon, Dec 01, 2025 at 08:56:10PM +0800, guanghuifeng@linux.alibaba.com wrote:
> 2025/12/1 18:03, Lukas Wunner :
> > It seems highly unusual that the different functions of the same physical
> > device require different delays until they're accessible.  I don't think
> > we can accept such a sweeping change wholesale without more details,
> > so please share what the topology looks like (lspci -tv), what devices are
> > involved (lspci -vvv) and which device requires extra wait time for some
> > of its functions.

Could you please provide the details I asked for above?

Thanks,

Lukas

