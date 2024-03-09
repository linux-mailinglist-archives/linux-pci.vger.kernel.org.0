Return-Path: <linux-pci+bounces-4686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24D17876E45
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 01:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C62F02820C6
	for <lists+linux-pci@lfdr.de>; Sat,  9 Mar 2024 00:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53027A29;
	Sat,  9 Mar 2024 00:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlYQNAi/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EB39EA4;
	Sat,  9 Mar 2024 00:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709945455; cv=none; b=mor5tXienrzC8lkcyIgNxam+sOuYMTrL0nNmSCvSbHabkw//cJNuvzLFVjXpZZJBMC4TFIa0Rba3hfhnfs+Zk/I3gSItRwKZ8xm5YQmDhVcUeiktHIeKr8kqv5ULNiyvmxeQ7E3NlLi14blREQYN73IE2lovUA5FBS3ym5NZTKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709945455; c=relaxed/simple;
	bh=lya7UhJlIblLkow5pi+zWUxuCvJx0mWepCjyI5q74Hw=;
	h=Message-ID:Content-Type:MIME-Version:In-Reply-To:References:
	 Subject:From:Cc:To:Date; b=IrqxUpvxfQiEaq+T9GMWutIjBEtOQNILCaRvAGbeUoAEvk3Qf9AtgyMQqMKfuxGesdUcQRT9l8y2PDZYKXeqVWfHbMKp9zpawuCWONtVdecjqh0WkzLuJU2yu58AlsPprIAutjHbgGmzMM+tZNndjKlak2Z8Xl4A1YMTD1J4nlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlYQNAi/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883E4C433C7;
	Sat,  9 Mar 2024 00:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709945454;
	bh=lya7UhJlIblLkow5pi+zWUxuCvJx0mWepCjyI5q74Hw=;
	h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
	b=AlYQNAi/w+AqpTz7UMH96zryBdO4Ut6giOEm5bqpeG4djkFZMNssmyPhzGzgWYyHl
	 AqcIsihdf2byK4CIHEI2xRmtqB2ry66/N20TaX1Tvq1i5RbIGtcDF3NbcMcCViompc
	 94Sgf5jSkIz768wtCVsoh4I7eUdZpOaJ5/afdxHn5o04ghQhtO0ZNd40eMbnKOSw/8
	 BG9HIUx8JC9T4uI/GVpAwGfM7PsMzNE3JrRLiln9ThXUgjdCuRzJYcYaomgi5OePtj
	 uu85M6C55SmLdFWrlHkVfjD1pqr5k3YWYd32Xw4oTqOZXtBWqlBHEOrnqQ+cdECQli
	 TJnbP80exRjEA==
Message-ID: <9927a3356ce54c626ab4733844a4385b.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <022301da6fbf$aae4f7e0$00aee7a0$@samsung.com>
References: <20240220084046.23786-1-shradha.t@samsung.com> <CGME20240220084120epcas5p1e8980539667c3d9da20f49fc645d8f4c@epcas5p1.samsung.com> <20240220084046.23786-2-shradha.t@samsung.com> <f00eed31-4baf-4d5c-934d-8223d1ab554d@moroto.mountain> <022301da6fbf$aae4f7e0$00aee7a0$@samsung.com>
Subject: RE: [PATCH v6 1/2] clk: Provide managed helper to get and enable bulk clocks
From: Stephen Boyd <sboyd@kernel.org>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, mturquette@baylibre.com, jingoohan1@gmail.com, lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, linux@armlinux.org.uk, m.szyprowski@samsung.com, manivannan.sadhasivam@linaro.org, pankaj.dubey@samsung.com, gost.dev@samsung.com
To: 'Dan Carpenter' <dan.carpenter@linaro.org>, Shradha Todi <shradha.t@samsung.com>
Date: Fri, 08 Mar 2024 16:50:52 -0800
User-Agent: alot/0.10

Quoting Shradha Todi (2024-03-06 04:13:03)
> >=20
> > When clk_bulk_get_all() returns zero then we return success here.
> >=20
>=20
> Yes, we are returning success in case there are no clocks as well. In cas=
e there
> are no
> clocks defined in the DT-node, then it is assumed that the driver does no=
t need
> any
> clock manipulation for driver operation. So the intention here is to cont=
inue
> without
> throwing error.

Maybe we shouldn't even return the clks to the caller. Do you have any
use for the clk pointers?

