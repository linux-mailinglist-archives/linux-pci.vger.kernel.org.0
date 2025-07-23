Return-Path: <linux-pci+bounces-32797-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AC7B0F2A6
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 14:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38421AC089B
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 12:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28CD42E611F;
	Wed, 23 Jul 2025 12:55:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52F92E62BF;
	Wed, 23 Jul 2025 12:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753275339; cv=none; b=Olj5j+5i3Oz9kmSadWISBp3t9RxWCbxRxKQy1HGfEl6CDx0wixiUzvCPVckaI0z4u2xcCRPeqNZ5++ize0dlP2uaFxIBSLsBkoNy+iXdzkGaKBNZyDL89+XiMj/fIBFC6eNAg2zB/Ku7m/8ZYZjSfYp9KiTKXObVT/gdGlMbOCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753275339; c=relaxed/simple;
	bh=etpnUlcxzPSIr+c+AJdJsU8DIfsQMe11YjoWD4zU+aw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F4AfznjN8inufOQ00HWR0e1r7+Rav6EdndOQZF2pg9YhGcGuxQxqrBF6LaJkAiJloGqLjYcM4onSq8iGyM4tNimM3DrCxMV9dm/Amc9O1PZi8R/rDVxHcmbg1DUUVj3OFsLRFUPoxqnnTJdN4AaA4lu6/8Bn8g2MPiPI1kkAEUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id A36AA2C01622;
	Wed, 23 Jul 2025 14:55:28 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 704E924CC4C; Wed, 23 Jul 2025 14:55:28 +0200 (CEST)
Date: Wed, 23 Jul 2025 14:55:28 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Shuan He <heshuan@bytedance.com>,
	kwilczynski@kernel.org
Subject: Re: [PATCH] PCI: Remove redudant calls to
 pci_create_sysfs_dev_files() and pci_proc_attach_device()
Message-ID: <aIDbwNdWgtKcrfF_@wunner.de>
References: <20250723111124.13694-1-manivannan.sadhasivam@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250723111124.13694-1-manivannan.sadhasivam@oss.qualcomm.com>

On Wed, Jul 23, 2025 at 04:41:24PM +0530, Manivannan Sadhasivam wrote:
> Both pci_create_sysfs_dev_files() and pci_proc_attach_device() are called
> from pci_bus_add_device(). Calling these APIs from other places is prone to
> a race condition as nothing prevents the callers from racing against
> each other.
> 
> Moreover, the proper place to create SYSFS and PROCFS entries is during
> the 'pci_dev' creation. So there is no real need to call these APIs
> elsewhere.

The raison d'être for the call to pci_create_sysfs_dev_files() in
pci_sysfs_init() is that PCI_ROM_RESOURCEs may appear after device
enumeration but before the late_initcall stage:

https://lore.kernel.org/r/20231019200110.GA1410324@bhelgaas/

Your patch will regress those platforms.

The proper solution is to make the resource files in sysfs static
and call sysfs_update_group() from pci_sysfs_init().

Krzysztof has an old branch where he started working on this:

https://github.com/kwilczynski/linux/commits/kwilczynski/sysfs-static-resource-attributes/

Thanks,

Lukas

