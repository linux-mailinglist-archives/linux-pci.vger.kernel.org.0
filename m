Return-Path: <linux-pci+bounces-18519-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 986B19F35B0
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 17:19:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77B9816AA15
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 16:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5051531C2;
	Mon, 16 Dec 2024 16:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k6OW7+Xf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA1E113CA8A;
	Mon, 16 Dec 2024 16:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365824; cv=none; b=g2enszvPRRsgUUSx116G4eVHB1Yh5IuVg8thk3CNPDYAcKEIQPa/KTV39U+vBhDO1rjtq+/Gg4Bi7xnQkm49BYoFIk/51w6cKmfmW7+5zeScRzCP4LT2peBinPK+z94mvW4fWl3ihvglBfeAlJ3ou9SeGQRnbgVw2nbcFiWw6VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365824; c=relaxed/simple;
	bh=ZzSSIU1SFKodlKclhIS/dVP6XR4I/BvF1HqgLgp6GNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oogCZlDBuBV6SMJP7zh0ErRzxCXToqG+sJU6ONo26J6dvOvYT3KBBXBy9oN6p2Hi0NH0f20QEXvunYyA5ZUahWI/YQwP33eOg5h+AEWVpvNOtBzG5ZLhTRER8S5usY6NsjY+5eOYCEYobe1kPKuNQOPBzaI63JcSBS759o6u8W8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k6OW7+Xf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18362C4CED0;
	Mon, 16 Dec 2024 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734365823;
	bh=ZzSSIU1SFKodlKclhIS/dVP6XR4I/BvF1HqgLgp6GNQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k6OW7+Xfx5piyTev7QeiXeyMDrhTohgOeIIdYZbge1RYssteXEJpFBbHEjTy9L7YJ
	 dzFhwsSlcmwXqj/VsX+86ls2wN4pds31NJH2cb3f1fo1lObSySij5ESc6ERgRwRK6T
	 OHtHJWU3jwTFaeP0w1CJahNlHOR2yo7twhq3CZWfnMtU/+ToSh0RaA3Y7p5EWEPfm+
	 kN8oH3cs6EbLSAaEMS0sWJjPO0Bboobg7Vr2XRajW1BDvgOa7WwMC/M+GdSNLQ9F3x
	 mAiWh+HcCMd2xZwXHhutgNccb6lc/B+I8Es9JdNpzoRwFsBNiyH2wWMb1ifS2cWruY
	 RPkV2t27KY+sQ==
Date: Mon, 16 Dec 2024 17:16:54 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Dirk Behme <dirk.behme@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com,
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net,
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com,
	robh@kernel.org, daniel.almeida@collabora.com, saravanak@google.com,
	dirk.behme@de.bosch.com, j@jannau.net, fabien.parent@linaro.org,
	chrisi.schrefl@gmail.com, paulmck@kernel.org,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	rcu@vger.kernel.org
Subject: Re: [PATCH v6 00/16] Device / Driver PCI / Platform Rust abstractions
Message-ID: <Z2BSdhdmBlrJvxb8@pollux.localdomain>
References: <20241212163357.35934-1-dakr@kernel.org>
 <00dd07c9-21a6-4515-9b62-351c6aff2d1b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00dd07c9-21a6-4515-9b62-351c6aff2d1b@gmail.com>

On Fri, Dec 13, 2024 at 08:06:13AM +0100, Dirk Behme wrote:
> On 12.12.24 17:33, Danilo Krummrich wrote:
> > This patch series implements the necessary Rust abstractions to implement
> > device drivers in Rust.
> > 
> > This includes some basic generalizations for driver registration, handling of ID
> > tables, MMIO operations and device resource handling.
> > 
> > Those generalizations are used to implement device driver support for two
> > busses, the PCI and platform bus (with OF IDs) in order to provide some evidence
> > that the generalizations work as intended.
> > 
> > The patch series also includes two patches adding two driver samples, one PCI
> > driver and one platform driver.
> > 
> > The PCI bits are motivated by the Nova driver project [1], but are used by at
> > least one more OOT driver (rnvme [2]).
> > 
> > The platform bits, besides adding some more evidence to the base abstractions,
> > are required by a few more OOT drivers aiming at going upstream, i.e. rvkms [3],
> > cpufreq-dt [4], asahi [5] and the i2c work from Fabien [6].
> > 
> > The patches of this series can also be [7], [8] and [9].
> 
> With v6.13-rc2 and Fabien's regmap/regulator/I2C on top I gave it a
> try on x86 with qemu. Additionally cross compiled for arm64 and will
> try it on real hardware once I have it available. But previous
> versions of this series have been fine on that, already. No issues
> observed for running the samples and for the examples/KUnit. So:
> 
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks for testing all this, very much appreciated!

> 
> Many thanks!
> 
> Dirk

