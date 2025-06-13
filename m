Return-Path: <linux-pci+bounces-29725-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E4668AD8EB8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 16:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006171BC4673
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 14:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E39B519CD01;
	Fri, 13 Jun 2025 13:52:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7FD156F5E;
	Fri, 13 Jun 2025 13:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749822774; cv=none; b=Ok3J17SDVAdo1rO+NuVE9lNo4Hhphxfqzp3nYlAjqIqD5/ewltmCTn2Jmp+q4lh4J0o04+xj4U0lQaYZLibQUa7lfJXRsh2mzOcN+da1WJPmw/9FceLRE0J2enT82go1QDCqbFZWFxCG3tHwmX2C8c8MrrU0XzGcIdnM1//AuMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749822774; c=relaxed/simple;
	bh=cWb5O919iJ5GUz1RPBsizB20JDHxE/ASBUV9zv+N5lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dcRnjrc7AdI/QdB/w/nssfAoHCTjIVd0hYD72f+fq75DkbSJVjVhZZBOodUeybgVmSqavlXg+gfZLOHnm+ZhV+UM2OtyNBvZj3YiSIgRLWU93+/qsjSo1wWcG/YIlLktVBrROCeXS5Gax92tPEKeUa36wiSxGgbV7OeDL8W5Oxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 0866620091AE;
	Fri, 13 Jun 2025 15:45:36 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id E75D669ABA; Fri, 13 Jun 2025 15:45:35 +0200 (CEST)
Date: Fri, 13 Jun 2025 15:45:35 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: grwhyte@linux.microsoft.com, linux-pci@vger.kernel.org,
	shyamsaini@linux.microsoft.com, code@tyhicks.com, Okaya@kernel.org,
	bhelgaas@google.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] PCI: Reduce FLR delay to 10ms for MSFT devices
Message-ID: <aEwrfy63cvBLr5yc@wunner.de>
References: <20250611000552.1989795-1-grwhyte@linux.microsoft.com>
 <ccclacbxzdarqy27wlwqqcsogbrodwwslt7t5sp64xvqpa3wsl@xs5cllh7a6ft>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ccclacbxzdarqy27wlwqqcsogbrodwwslt7t5sp64xvqpa3wsl@xs5cllh7a6ft>

On Fri, Jun 13, 2025 at 05:12:48PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 11, 2025 at 12:05:50AM +0000, grwhyte@linux.microsoft.com wrote:
> > Add a new flr_delay member of the pci_dev struct to allow customization of
> > the delay after FLR for devices that do not support immediate readiness
> > or readiness time reporting. The main scenario this addresses is VF
> > removal and rescan during runtime repairs and driver updates, which,
> > if fixed to 100ms, introduces significant delays across multiple VFs.
> > These delays are unnecessary for devices that complete the FLR well
> > within this timeframe.
> > 
> 
> I don't think it is acceptable to *reduce* the standard delay just
> because your device completes it more quickly. Proper way to reduce
> the timing would be to support FRS as you said, but we cannot have
> arbitrary delays for random devices.

To be fair, we already have that for certain devices:

The quirk delay_250ms_after_flr() is referenced by three different
Vendor ID / Device ID combos and *lengthens* the delay after FLR.

It's probably difficult to justify rejecting custom delays for
certain MANA devices, even though we allowed them for three other
devices.

The proposed patch introduces a generic solution which avoids
further cluttering up pci_dev_reset_methods[] with extra entries,
so I think it's an approach worth considering.

There are a bunch of nits in the proposed patches, such as "pci"
not being capitalized, but the general approach seems fine to me.

Thanks,

Lukas

