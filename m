Return-Path: <linux-pci+bounces-18345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FC69EFD8F
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 21:40:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C36C28AD58
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 20:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD071B6CE9;
	Thu, 12 Dec 2024 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GoFdOJx1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300671B395E;
	Thu, 12 Dec 2024 20:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734036011; cv=none; b=FJjOUG+PTEFsFAoHHik2AmFEJnUCo8uBgGL8QOKeZk1aGW01JOqKiqMmNmMgvtIf9gTimAnrRX7s5lzJfnAHXn0g/g8N0gMoZZNnc5B9aHSINyrwZxNWAlO68WNCHzEno2298uHbgyxv+Q5UcxkK6eg3YodOnAQkcbHPEer6I70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734036011; c=relaxed/simple;
	bh=yCBovi8zvajxpMbVBUDS3OPWKLUmsVCW+gKOUZe2o1Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SRplHLfiMTsKZcSvC8bnIe6bJlaJIPbPlbs4qe1ELnYLRsSfVyjmKwqorZ7Y7fhpJbeYD9EKrAtcpMOjacqh1rv2lKEThaTA11fHMFLSuuQYvXA8Lwit0Ah5IIIQ3NiOX4yZN5yvTRzqRUWKK3EV9VX4pp0JEeKDs7H33231qlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GoFdOJx1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD397C4CECE;
	Thu, 12 Dec 2024 20:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734036011;
	bh=yCBovi8zvajxpMbVBUDS3OPWKLUmsVCW+gKOUZe2o1Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GoFdOJx1ReK5brUOc8fzSMBSFQ7jaAPFl1BD4mucX9TukNRNwqfcPzYmoJM9Tk1F2
	 WRtlxeb5cFpW9ad1g0CJO9+u+/9y/5wI8eVMGHzz6KCD1TzyFqseI364p85JegrwiV
	 pq1JD6r342b5om6ZDh+JdvbAxCA+v0Ma9rP3wd9CVmZyhtWji2/T7ggoKb8A1bXBXT
	 1pML7o5d/wr+e/5RArQEe64y1H8MrNH3uSFPsw4HXQXW1JSVvLqaLBg00YrR981JE1
	 zEk/NbZP2Sn1uj2hcy360Fvzx6yV0ouAVxDLzhzNqtLiB3p42kUwWRfw71b2aduTWe
	 fH6rFC4YltzEg==
Message-ID: <1dcc3ca74c3fbb3b4a1adcafb648dfd2501310f1.camel@kernel.org>
Subject: Re: [PATCH] PCI/portdrv: Disable bwctrl service if port is fixed at
 2.5 GT/s
From: Niklas Schnelle <niks@kernel.org>
To: Lukas Wunner <lukas@wunner.de>, Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Bjorn
 Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Rob Herring
 <robh@kernel.org>, Krzysztof Wilczy??ski	 <kw@linux.com>, "Maciej W .
 Rozycki" <macro@orcam.me.uk>, Jonathan Cameron	
 <Jonathan.Cameron@huawei.com>, Alexandru Gagniuc <mr.nuke.me@gmail.com>, 
 Krishna chaitanya chundru	 <quic_krichai@quicinc.com>, Srinivas Pandruvada	
 <srinivas.pandruvada@linux.intel.com>, "Rafael J . Wysocki"
 <rafael@kernel.org>, 	linux-pm@vger.kernel.org, Smita Koralahalli	
 <Smita.KoralahalliChannabasappa@amd.com>, LKML
 <linux-kernel@vger.kernel.org>,  Daniel Lezcano
 <daniel.lezcano@linaro.org>, Amit Kucheria <amitk@kernel.org>, Zhang Rui
 <rui.zhang@intel.com>,  Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Mika Westerberg	
 <mika.westerberg@linux.intel.com>
Date: Thu, 12 Dec 2024 21:40:04 +0100
In-Reply-To: <Z1rX1BgdsPHIHOv4@wunner.de>
References: <20241207-fix_bwctrl_thunderbolt-v1-1-b711f572a705@kernel.org>
	 <Z1gSZCdv3fwnRRNk@wunner.de>
	 <70829798889c6d779ca0f6cd3260a765780d1369.camel@kernel.org>
	 <Z1lF468L8c84QJkD@wunner.de>
	 <dc6e677f-4c19-dd25-8878-8eae9154cff4@linux.intel.com>
	 <Z1qoDmF6urJDN5jh@wunner.de>
	 <97bbbdecb8c65cfa2625b47aa2585a7417ddcb81.camel@linux.ibm.com>
	 <Z1rX1BgdsPHIHOv4@wunner.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-12-12 at 13:32 +0100, Lukas Wunner wrote:
> On Thu, Dec 12, 2024 at 10:17:21AM +0100, Niklas Schnelle wrote:
> > On Thu, 2024-12-12 at 10:08 +0100, Lukas Wunner wrote:
> > > After re-reading the spec I'm convinced now
> > > that we're doing this wrong and that we should honor the Max Link Spe=
ed
> > > instead of blindly deeming all set bits in the Link Capabilities 2
> > > Register as supported speeds:
> > >=20
> > > https://lore.kernel.org/r/e3386d62a766be6d0ef7138a001dabfe563cdff8.17=
33991971.git.lukas@wunner.de/
> > >=20
> > > @Niklas, could you test if this is sufficient to avoid the issue?
> > > Or do we still need to stop instantiating the bandwidth controller
> > > if more than one speed is supported?
> >=20
> > Yes, I will test this but will only get to do so tonight (UTC +2).
>=20
> Hey, no worries.  We're not on the run!
>=20
> > If it's not sufficient I think we could use the modified
> > pcie_get_supported_speeds() to check if only one link speed is
> > supported, right?
>=20
> pcie_get_supported_speeds() is used to fill in the supported_speeds
> field in struct pci_dev.
>=20
> And that field is used in a number of places (exposure of the max link
> speed in sysfs, delay handling in pci_bridge_wait_for_secondary_bus(),
> link tuning in radeon/amdgpu drivers, etc).

Side question. If this is used in radeon/amdgpu could detecting the
thunderbolt port's max link speed as 2.5 GT/s cause issues for external
GPUs?

