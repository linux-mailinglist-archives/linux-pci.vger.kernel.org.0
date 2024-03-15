Return-Path: <linux-pci+bounces-4856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F1887D2EF
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 18:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C903E1C220C3
	for <lists+linux-pci@lfdr.de>; Fri, 15 Mar 2024 17:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C2114B5A6;
	Fri, 15 Mar 2024 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThLdkbyJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 491CF48CCC;
	Fri, 15 Mar 2024 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710524384; cv=none; b=ZnqJDvOz3YXgY1dO4vk8NOqIoxgSgigPtrQh+4aPKZdUHUCyEE8emH4u1f/XPusLFmP05BtXdsGaA6kix/Y2TU/slwt0jYEivCTR9PVqI4i7hwoc/yx67VkemYDWVvteGaEYtMBihPlwVtwW3tAzOWxUMfX0adeuYfnV/zzssXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710524384; c=relaxed/simple;
	bh=ai18tQCxEsVNBTB9pI+Y1iMrP4vEbIDkN2V9bYFwEuE=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=Ez4X+FMc16ueVkjgsEu0ASRhpJE+Py1Mj7ZK42mWmURBAUv7RWJkOubhaVLtnl+aG/VOw3PiqepgDwONykhrbNYVaduhb1ZxPUkeiE1AXwaTm+Kd5JUqDzWa8Xp8n57u01Ppn6k5pvz6WXjQl9DczDwzJwVoWfOs0AknfvdH8l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThLdkbyJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2CE9C433F1;
	Fri, 15 Mar 2024 17:39:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710524383;
	bh=ai18tQCxEsVNBTB9pI+Y1iMrP4vEbIDkN2V9bYFwEuE=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=ThLdkbyJzeqXntUTQRuID6VAibZEXVYVFM6dB+1fOnSd27f+XnR829DJjeNBCm1j+
	 9SpPaxsqxbCGOllpEII3ySsorrIjPgVrzX/wHagrArgmzxZhBRrcR2QwlhkoPceqUI
	 tmu8/g40EV8XycRGpPwTZDBbFeuTzVCzjNo63LGo35FhcgwAea7oYoFMqF/iKbHXsf
	 uv/pfWhvhEpCfbDqZi71Pxkh5qCKYEg4ug16RDXIQcOivHGLjbfLXsfX/gTn5AizNK
	 hWhFRYYPTHaN1Sw5kG2pATuVECNppdHAicbCp3u1EG2B0vOBFJlwjW+PzY6dkZGARD
	 GuECh3L6Y/4Mg==
Message-ID: <2688272d2763a36f401a08ca48c0eb24.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <104401da76cc$ccc772c0$66565840$@samsung.com>
References: <20240220084046.23786-1-shradha.t@samsung.com> <CGME20240220084120epcas5p1e8980539667c3d9da20f49fc645d8f4c@epcas5p1.samsung.com> <20240220084046.23786-2-shradha.t@samsung.com> <f00eed31-4baf-4d5c-934d-8223d1ab554d@moroto.mountain> <022301da6fbf$aae4f7e0$00aee7a0$@samsung.com> <9927a3356ce54c626ab4733844a4385b.sboyd@kernel.org> <104401da76cc$ccc772c0$66565840$@samsung.com>
Subject: RE: [PATCH v6 1/2] clk: Provide managed helper to get and enable bulk clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, mturquette@baylibre.com, jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, linux@armlinux.org.uk, m.szyprowski@samsung.com, manivannan.sadhasivam@linaro.org, pankaj.dubey@samsung.com, gost.dev@samsung.com
To: 'Dan Carpenter' <dan.carpenter@linaro.org>, Shradha Todi <shradha.t@samsung.com>
Date: Fri, 15 Mar 2024 10:39:41 -0700
User-Agent: alot/0.10

Quoting Shradha Todi (2024-03-15 04:34:44)
> >=20
> > Quoting Shradha Todi (2024-03-06 04:13:03)
> > > >
> > > > When clk_bulk_get_all() returns zero then we return success here.
> > > >
> > >
> > > Yes, we are returning success in case there are no clocks as well. In
> > > case there are no clocks defined in the DT-node, then it is assumed
> > > that the driver does not need any clock manipulation for driver
> > > operation. So the intention here is to continue without throwing
> > > error.
> >=20
> > Maybe we shouldn't even return the clks to the caller. Do you have any =
use for
> > the clk pointers?
>=20
> The intention to return the clk pointers was in the case where caller wan=
ts to
> manipulate a particular clock in certain conditions. They can obtain the =
clock pointer
> and use clk_set_parent, clk_set_rate on those particular clocks.
> But I understand that in that case users can use existing clk_bulk_get_al=
l() API.
> So, should I go ahead and send v7?
>=20

No, I think this is fine.

