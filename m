Return-Path: <linux-pci+bounces-40011-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8AEC27E2F
	for <lists+linux-pci@lfdr.de>; Sat, 01 Nov 2025 13:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA8FD189B048
	for <lists+linux-pci@lfdr.de>; Sat,  1 Nov 2025 12:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E097E2E0904;
	Sat,  1 Nov 2025 12:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b="hVxDDM/g"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9023823BD01;
	Sat,  1 Nov 2025 12:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762000870; cv=pass; b=fC+kCYqsM2asGktoaI9nsbPobz4w0HTZwq9VK+L8JjVnRF36wMU4mtS+Obbes2WBPkrQmLJfWDdsNBvAwupSlmq5n0F0TT0GB3ZmWzgXG4zlFUTc9s6j5hknmYlCbB1mFi/6dnjBPPuFfJXdf3Qbj76zvSL2APx3um69shrlD3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762000870; c=relaxed/simple;
	bh=Xx4k/fa+z5oSv3/s6q/fkvdh6lOYHQhINeo6yjxMnCM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=X2kfL1u9nkQgcjWMa7NgpheN9rzmyoO3Wyn9Mfn29cUgoFteCZaaDam12VeiW+whAddZmGDBLSsIKZAFUJqithEmTeON7s3Sh8lYubVhlo2uB4EKh2ltIvjEjNloy8nKC3kKe48q3KNHjIN19j0ZlUZ29uyy8EbMeW2uFoScvb4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=sjoerd@collabora.com header.b=hVxDDM/g; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1762000821; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=A7QggDksDzCmseQYSFGx/xof5FXoKWhxWCF1voGnOqira6R7CpXcFOe0adxPrhAfq46N1HjN76y4RmHjG2MKHWqbGxvwsMyJVal7+yN2yaVxHACMWl+iV2XKLZ756ZfiGeB7GPOMfmO5c2NiDuOqi33nIosp10r5BtTbdXDjSu0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1762000821; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wX50N1iHvuUcfFTPrDTk6BLpkXD7It4diuWw8d34XeY=; 
	b=IRfmqhYlU29u+cfbSc2SPpAMwbA9jqEXzZ2q6s4FAq/fo8xrlDQSrLa8qvj+KfyhxxoqqjfejRhYxARtTv0si7j9gCxYbC/wfSsPcXJeow/Nupy5oK9uEUoQqa+vx/v1KKRRxXaopfS8uW9e92K+MwM/7lXIx+A+HLzbpKdLB3Y=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=sjoerd@collabora.com;
	dmarc=pass header.from=<sjoerd@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1762000821;
	s=zohomail; d=collabora.com; i=sjoerd@collabora.com;
	h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
	bh=wX50N1iHvuUcfFTPrDTk6BLpkXD7It4diuWw8d34XeY=;
	b=hVxDDM/gqRw68T07nRuvdrHGupRkXhOU8RexT1UeP+9bS+r2KO4yzzfNJKjP+80C
	7ABb6CAL4qYLI3lXalMwKyt2SNufHOI19Bfnb3DH6aWQUjo7eCQ7Z9iLnS5/At0SWAQ
	DMYA4onW8qA2XN4liLwbv9J0ttSlgEbygWhi/Tro=
Received: by mx.zohomail.com with SMTPS id 1762000816267360.6637248664106;
	Sat, 1 Nov 2025 05:40:16 -0700 (PDT)
Message-ID: <548101c6c887299b3c39f294e376c782e0bd2160.camel@collabora.com>
Subject: Re: [PATCH 13/15] arm64: dts: mediatek: mt7981b: Add wifi memory
 region
From: Sjoerd Simons <sjoerd@collabora.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,  Matthias Brugger
 <matthias.bgg@gmail.com>, Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang	
 <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>, Lorenzo
 Pieralisi <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>,  Manivannan Sadhasivam	 <mani@kernel.org>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul	 <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Lee Jones	 <lee@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"	
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski	
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo Bianconi	
 <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>
Cc: kernel@collabora.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org, 
	linux-phy@lists.infradead.org, netdev@vger.kernel.org, Daniel Golle
	 <daniel@makrotopia.org>, Bryan Hinton <bryan@bryanhinton.com>
Date: Sat, 01 Nov 2025 13:40:06 +0100
In-Reply-To: <9bf32a56-b67f-488a-8719-3f97d85533d3@collabora.com>
References: <20251016-openwrt-one-network-v1-0-de259719b6f2@collabora.com>
	 <20251016-openwrt-one-network-v1-13-de259719b6f2@collabora.com>
	 <9bf32a56-b67f-488a-8719-3f97d85533d3@collabora.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-7 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ZohoMailClient: External

On Thu, 2025-10-16 at 13:28 +0200, AngeloGioacchino Del Regno wrote:
> Il 16/10/25 12:08, Sjoerd Simons ha scritto:
> > Add required memory region for the builtin wifi block. Disable the bloc=
k
> > by default as it won't function properly without at least pin muxing.
> >=20
> > Signed-off-by: Sjoerd Simons <sjoerd@collabora.com>
>=20
> You should split this commit in two:
> =C2=A0 - Add wifi memory region
> =C2=A0 - Disable wifi by default

Will split.

> Regarding the second commit, you have to re-enable the wifi node in all o=
f
> the currently supported MT7981b devices, including:
> =C2=A0 - Xiaomi AX3000T
> =C2=A0 - Cudy WR3000 V1
>=20
> While I agree that without pin muxing the wifi may not properly work, it =
is
> unclear whether the aforementioned devices are pre-setting the pinmux in =
the
> bootloader before booting Linux.
>=20
> In case those do, you'd be "breaking" WiFi on two routers here.

Wifi will never have worked on those upstream; The driver hits an unconditi=
onal -EINVAL during probe
due to the  missing memory-region this patch adds. I'll make sure to note t=
hat in the new disable
patch.

--=20
Sjoerd Simons <sjoerd@collabora.com>

