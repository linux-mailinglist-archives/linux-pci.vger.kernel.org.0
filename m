Return-Path: <linux-pci+bounces-13998-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 250EF995661
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 20:23:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0552288C2A
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2024 18:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9E620ADDB;
	Tue,  8 Oct 2024 18:23:50 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C081FA25F
	for <linux-pci@vger.kernel.org>; Tue,  8 Oct 2024 18:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728411830; cv=none; b=RdMCIaes05nfl17sjLi/A3+zr98KdB3Xx66jVkPAvptWDXB9hvl0omo+AYuxAdYBjiGbz7Xuz81aDlSI+N92FBVY61qis6REBXBpdVanRxN0/n6A5K3uqUZJ0OmxQDkcQ1Ibthw80COyeW2q0fz/DhA8OpZ4/SSYPQtx1Oc8qyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728411830; c=relaxed/simple;
	bh=6vkSPXhqGiGPM6MWZPDUzrT+gDJA72eCOiSi6E7q7Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ih8ylexDB4ZasmmAxMfnLydwmvBQP8HVkgaGgeQ9U64lnwueJUFsxLVwB8N5K7qR44Q0/W54rWn54PzgFIeSZFMF7yuGt+TfoDkr0yH7UtO0816EJMBA6d7DWvaVgTi4cKpkD8hM3ObwdKqquN8rBAXEWj+71XX/gFbTWRcjhVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id E69B428013805;
	Tue,  8 Oct 2024 20:23:43 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C32CA2B6478; Tue,  8 Oct 2024 20:23:43 +0200 (CEST)
Date: Tue, 8 Oct 2024 20:23:43 +0200
From: Lukas Wunner <lukas@wunner.de>
To: "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>
Cc: "Wassenberg, Dennis" <Dennis.Wassenberg@secunet.com>,
	"kbusch@kernel.org" <kbusch@kernel.org>,
	"ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"mpearson-lenovo@squebb.ca" <mpearson-lenovo@squebb.ca>,
	"Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
	"minipli@grsecurity.net" <minipli@grsecurity.net>
Subject: Re: UAF during boot on MTL based devices with attached dock
Message-ID: <ZwV4r8zAcFuJnzH8@wunner.de>
References: <6de4b45ff2b32dd91a805ec02ec8ec73ef411bf6.camel@secunet.com>
 <c394a3f07bfb7240a2c32fa6d467ea1a03547881.camel@secunet.com>
 <68de3ca4-a624-8b02-8f6d-889deb61495d@linux.intel.com>
 <233b9645e201556422dea79f71262d115c687fcb.camel@secunet.com>
 <Zv6gT96pHg2Jglxv@wunner.de>
 <Zv-dIHDXNNYomG2Y@wunner.de>
 <bdc3963903e7c4aeec7c34ac0d46c4368152a8c2.camel@secunet.com>
 <ZwU6ijD8I5hzMv9X@wunner.de>
 <20241008163732.GT275077@black.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008163732.GT275077@black.fi.intel.com>

On Tue, Oct 08, 2024 at 07:37:32PM +0300, mika.westerberg@linux.intel.com wrote:
> On Tue, Oct 08, 2024 at 03:58:34PM +0200, Lukas Wunner wrote:
> > Finally, I'd appreciate if you could send me dmesg output with the
> > refcounting fix applied.  As said before, the MTL Thunderbolt controller
> > claims that the link and slot presence bits are cleared, so it
> > de-enumerates everything attached via Thunderbolt.  I'm wondering
> > if it then re-enumerates the Thunderbolt-attached devices so they're
> > actually usable?
> > 
> > I'm hoping Mika can clarify with Intel Thunderbolt CoE whether this
> > is a hardware issue in MTL that can e.g. be fixed through a firmware
> > or BIOS update.
> 
> I think here it happens because we reset the host router when the driver
> probes so all the BIOS CM created tunnels will be torn down as well.

Okay this seems to have been introduced by 0fc70886569c ("thunderbolt:
Reset USB4 v2 host router").

Is that a good idea though?  What if the machine was booted from a
Thunderbolt-attached drive?  At least on Macs that has been supported
since day 1.  I'd assume that it may cause issues if the connection to
the drive on which the root partition resides is forcefully torn down
and re-established?

Thanks,

Lukas

