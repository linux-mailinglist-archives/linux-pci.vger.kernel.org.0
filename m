Return-Path: <linux-pci+bounces-18237-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C17929EE265
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 10:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B023281DC3
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 09:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788E820E305;
	Thu, 12 Dec 2024 09:14:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9993220E00A;
	Thu, 12 Dec 2024 09:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733994871; cv=none; b=plmgh+rBpsWOngIRNIJIddYgbU53OU8AK/daxLkY4AQU+U6ST5110fh/PJcxbusjGvxuhUKRMGpuAzWXOGuo+nGDey1qtWzyZXaQwEK0ov9gQ5X3zYI+xkP+/zdvbZcneZ/eBqaq90uj+5NlGwMvaYaqfSyCj4GpE8o3Pf73Q2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733994871; c=relaxed/simple;
	bh=Ni5+y7mYS2eNtxGPryySzIT+0eLJilUawatrYEIdxZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sVN5/ORsWLCj62njuX0F3zXHScYs7UROhMfVPVBbY96VaoBsl4rRTAf6kICrhmp8UGRz/VnGUE13iEqTglqdfdrvHUEZopsZIuZoyJ7RIXR1Kh2MsiOObTIwgxu2DVNHge0UbTxg20rTI8tghHVp2ofFVyBLnFzT8qKminArdeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id C79BA3000A463;
	Thu, 12 Dec 2024 10:08:30 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id AF9083CFE40; Thu, 12 Dec 2024 10:08:30 +0100 (CET)
Date: Thu, 12 Dec 2024 10:08:30 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Niklas Schnelle <niks@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Wilczy??ski <kw@linux.com>,
	"Maciej W . Rozycki" <macro@orcam.me.uk>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Alexandru Gagniuc <mr.nuke.me@gmail.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
	Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Amit Kucheria <amitk@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] PCI/portdrv: Disable bwctrl service if port is fixed at
 2.5 GT/s
Message-ID: <Z1qoDmF6urJDN5jh@wunner.de>
References: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>
 <Z1gSZCdv3fwnRRNk@wunner.de>
 <70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org>
 <Z1lF468L8c84QJkD@wunner.de>
 <dc6e677f-4c19-dd25-8878-8eae9154cff4@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dc6e677f-4c19-dd25-8878-8eae9154cff4@linux.intel.com>

On Wed, Dec 11, 2024 at 03:07:38PM +0200, Ilpo Järvinen wrote:
> I recall taking note of this inconsistency in some lspci dumps I've from 
> Mika (but forgot it until now). So I'm afraid it might be more widespread 
> than just TR.

Oh you did?  Interesting.  After re-reading the spec I'm convinced now
that we're doing this wrong and that we should honor the Max Link Speed
instead of blindly deeming all set bits in the Link Capabilities 2
Register as supported speeds:

https://lore.kernel.org/r/e3386d62a766be6d0ef7138a001dabfe563cdff8.1733991971.git.lukas@wunner.de/

@Niklas, could you test if this is sufficient to avoid the issue?
Or do we still need to stop instantiating the bandwidth controller
if more than one speed is supported?

Thanks!

Lukas

