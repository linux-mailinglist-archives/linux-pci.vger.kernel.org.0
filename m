Return-Path: <linux-pci+bounces-5031-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADC22887719
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 06:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9A84B220A0
	for <lists+linux-pci@lfdr.de>; Sat, 23 Mar 2024 05:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9D84683;
	Sat, 23 Mar 2024 05:09:25 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B7A3212;
	Sat, 23 Mar 2024 05:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711170565; cv=none; b=MovkC4AnAZrebs91YFZL++cqLWhz3ONXExmOwXsUGXVvG09FhVT93NFI6j8EJRARuQBhwFUJwJGPgqLC/+ZcDxggz+4f2HNlOXTMAohd+WsemHF0x48XfGqlrj0AvFgJ1Gh3faKJWKGx1C4tr1GrY+nArPcbXDO2xqcU8OdczE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711170565; c=relaxed/simple;
	bh=Bz+BwAwF9/MUn2JT3vMXmq5s1XW6WopM8fpAwngl7Iw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKtA1EFS9BhCPUm94IqR40M2vlC9O88IxCD+WFBZzV/FMsL6YMTHK6PwE40q8ypq0vEA7hiRX96t7B9cpb+DDoEacsM9YshKi+lkgsO3TNNxi7FwmCXqzr9XlS5zQy49a8Pf7OU2ng1pqUNtR4J5f5fn7U7puBuMw4xuqKgORnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9E2932800BB2D;
	Sat, 23 Mar 2024 06:09:13 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 82B9251FE31; Sat, 23 Mar 2024 06:09:13 +0100 (CET)
Date: Sat, 23 Mar 2024 06:09:13 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
	linux-leds@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/NPEM: Add Native PCIe Enclosure Management
 support
Message-ID: <Zf5j-bi9tjk5NclI@wunner.de>
References: <20240312100816.000071ec@linux.intel.com>
 <20240322195612.GA1372991@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240322195612.GA1372991@bhelgaas>

On Fri, Mar 22, 2024 at 02:56:12PM -0500, Bjorn Helgaas wrote:
> Straw man proposal:
> 
>   - Update this patch so we use NPEM if the device advertises it.
> 
>   - If/when Linux support for the _DSM is added, we use the _DSM when
>     present.  If a device advertises NPEM but no _DSM applies to it,
>     we use native NPEM for it.

I've recommended to Mariusz to go the extra mile and add _DSM support
(through an npem_ops abstraction layer for register access, with _DSM
support simply consisting of an additional npem_ops declaration that
gets used if the _DSM is present).  He's currently busy implementing it.

So that forthcoming version of the series should give Stuart something
to test and hopefully settle the discussion. :)

Thanks,

Lukas

