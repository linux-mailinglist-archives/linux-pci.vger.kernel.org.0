Return-Path: <linux-pci+bounces-4935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D52B880CE6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 09:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D5A31C21AC6
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 08:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01DF33CD0;
	Wed, 20 Mar 2024 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isDxulfI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE28933CCC;
	Wed, 20 Mar 2024 08:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710922731; cv=none; b=p9KF3ETXc2jqJX7w1wdBwJY6V4uDeJ5wpuIXJRzDOKh0rGKqVyDBca4lUyL/dNw3261oZ6b0cBq2cmZaYVdWg5yKP3TkKiIqG3xiaUsq1floTTjP4/lnIAjT4Wdc4vMLf+MEjNSGBHg7fDJAOHUcPp3OYMMyTQRiVl3OOYS2jbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710922731; c=relaxed/simple;
	bh=qPkN9E6b8SUh3Jfe6px/hgR01t6ClvlRlfbmqOmQkmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FMOhusI9kfS8W49ddcBXEUgbWZQVcaQqDJoXyPBImcykiU8uPO0FTMLlDQcGJ4UBtypPZ1IVHGv8ItZiQi5yovPC6Ls+gLf28hmOsSUAPRIEqQyaohrKWIMgOnJzQLw1HjS9+SZIbA+oMOKhbw79bycPSz2AQg3HAidbOAYsOFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isDxulfI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D9A5C433C7;
	Wed, 20 Mar 2024 08:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710922731;
	bh=qPkN9E6b8SUh3Jfe6px/hgR01t6ClvlRlfbmqOmQkmU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=isDxulfIyzdljTz66/ur7DrURNSFKF52SPS19OoCQbZLnk9axIxNTk7X0Fnrgj47J
	 09g61T17V/Tn4WKF541EW1oP1wJhD3d5tm/Rg0/Hd3U24gGvir6cSUZVf0iTFC1sgy
	 CuPfD4ZBQzYIJs3f3r+jua+NVXmgb+u5+J72t+kRH/B6wQ8JOeGzoCvMe1oFZvWQgH
	 iyEoPdNyDq6cwoVHjp/bhvcCZ/qe6pgCgFTnvs0qWmGQLyZOocSrKKs33OHCgEi+Kt
	 T2/0fq2d2aharchudbchah1r8j1T/Yja3xfWjQszQUeWi1NdRGIlhUbz2dot0JSXnP
	 UMXIRLwiXD8UQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rmrA2-0000000045f-0ivs;
	Wed, 20 Mar 2024 09:18:58 +0100
Date: Wed, 20 Mar 2024 09:18:58 +0100
From: Johan Hovold <johan@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH v4 0/5] arm64: dts: qcom: sc8280xp: PCIe fixes
 and GICv3 ITS enable
Message-ID: <Zfqb8jPK50vlqu5Q@hovoldconsulting.com>
References: <20240306095651.4551-1-johan+linaro@kernel.org>
 <171081652637.198276.6219023769904423414.b4-ty@kernel.org>
 <Zfk98hYPn7kiFGkt@hovoldconsulting.com>
 <9b475e13-96b9-4bce-8041-e0d8e5a332a1@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b475e13-96b9-4bce-8041-e0d8e5a332a1@linaro.org>

On Wed, Mar 20, 2024 at 09:09:02AM +0100, Krzysztof Kozlowski wrote:
> On 19/03/2024 08:25, Johan Hovold wrote:
> > On Mon, Mar 18, 2024 at 09:48:30PM -0500, Bjorn Andersson wrote:
> >> On Wed, 06 Mar 2024 10:56:46 +0100, Johan Hovold wrote:
> >>> This series addresses a few problems with the sc8280xp PCIe
> >>> implementation.

> >> Applied, thanks!
> >>
> >> [4/5] arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
> >>       commit: 2b621971554a94094cf489314dc1c2b65401965c
> > 
> > I noticed that you applied both of these for 6.10, but this one is a fix
> > that should go into 6.9.
> 
> Well, mixing fixes for different cycles in one patchset was always
> discouraged. In case of some subsystems you would receive clear
> response, that you must split fixes out of the patchset.
> 
> Fixes being first in the patchset would be probably accepted by the rest
> of subsystems, but putting it in the middle of the patchset is wrong.

Perhaps you should not comment before reading up on the history of this
series.

This was all intended for 6.9, but merging was stalled for a number of
reasons so here we are. The patches were also going in through different
trees, so patch 4/5 is the first Qualcomm SoC patch.

Johan

