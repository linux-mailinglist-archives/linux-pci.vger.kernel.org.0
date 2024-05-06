Return-Path: <linux-pci+bounces-7103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A498BC874
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 09:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D6D9B20B6D
	for <lists+linux-pci@lfdr.de>; Mon,  6 May 2024 07:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 646BF2B9BB;
	Mon,  6 May 2024 07:38:08 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8ED18EA5;
	Mon,  6 May 2024 07:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981088; cv=none; b=TD7e6TIv1r/0Dg9wkQ1NauuPUebXJPCfRexN104wItjJJQ2cirNG437kqyr96wl8VIBTlrzO+D3RbjQ/pBHwHiMtGJGpCHH27tIPhSXYlaf5QRBdvbk6QNiPhmacRwGrY8zRI6OWWj/QEPhpvbcEogD1bahyJainif6dS5d+Ndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981088; c=relaxed/simple;
	bh=R3LC5Ph+l1MAs++SI3snWMs2ree0ccbWLYXlPJJxWhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OzBJeZ4aNiRLUvfe5dver/0G78S0k7yGS6Pjbd9XHFztZBQn4gZ0tN4eOhyPUz+xhXlqiGjUuoyOD41ySHyBPW2Ub7Wrtv6ZIg72u6qxzplTY7xLJIegg51ml/ozFb6riwdqo4ypmkXlhQxxF7WuIWCCRg+0YBZ3He3BkIvxCtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id D2BB6101E6801;
	Mon,  6 May 2024 09:29:20 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 7D7191F80AA; Mon,  6 May 2024 09:29:20 +0200 (CEST)
Date: Mon, 6 May 2024 09:29:20 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Yazen Ghannam <yazen.ghannam@amd.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Bowman Terry <terry.bowman@amd.com>,
	Hagan Billy <billy.hagan@amd.com>,
	Simon Guinot <simon.guinot@seagate.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH] PCI: pciehp: Clear LBMS on hot-remove to prevent link
 speed reduction
Message-ID: <ZjiG0JJC4iS_9VHb@wunner.de>
References: <20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240424033339.250385-1-Smita.KoralahalliChannabasappa@amd.com>

On Wed, Apr 24, 2024 at 03:33:39AM +0000, Smita Koralahalli wrote:
> Clear Link Bandwidth Management Status (LBMS) if set, on a hot-remove event.
> 
> The hot-remove event could result in target link speed reduction if LBMS
> is set, due to a delay in Presence Detect State Change (PDSC) happening
> after a Data Link Layer State Change event (DLLSC).
> 
> In reality, PDSC and DLLSC events rarely come in simultaneously. Delay in
> PDSC can sometimes be too late and the slot could have already been
> powered down just by a DLLSC event. And the delayed PDSC could falsely be
> interpreted as an interrupt raised to turn the slot on. This false process
> of powering the slot on, without a link forces the kernel to retrain the
> link if LBMS is set, to a lower speed to restablish the link thereby
> bringing down the link speeds [2].
> 
> According to PCIe r6.2 sec 7.5.3.8 [1], it is derived that, LBMS cannot
> be set for an unconnected link and if set, it serves the purpose of
> indicating that there is actually a device down an inactive link.
> However, hardware could have already set LBMS when the device was
> connected to the port i.e when the state was DL_Up or DL_Active. Some
> hardwares would have even attempted retrain going into recovery mode,
> just before transitioning to DL_Down.
> 
> Thus the set LBMS is never cleared and might force software to cause link
> speed drops when there is no link [2].

Is this an issue introduced by commit a89c82249c37 ("PCI: Work around
PCIe link training failures")?

If so, could you add a Fixes tag?

I might be mistaken but my impression is that we're seeing a lot of
fallout as a result of that commit.

Thanks,

Lukas

