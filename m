Return-Path: <linux-pci+bounces-19691-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B953FA0C35B
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 22:14:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2BE318885C4
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 21:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60C31CACF3;
	Mon, 13 Jan 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G5oaJTcF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E211BD504;
	Mon, 13 Jan 2025 21:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736802863; cv=none; b=PZ+9e9mZGA823ZgyHHOhvYA/lgv4Mtce0FwZP7GsXmLuz6eFnWk6eBmI+wp6+cmwtL0jNL5v4UDUXoP/v6r351Cb9UQxN/iFH7hL9CR7rqvIscYz4rCJMP4UmEfGdgf0bwl7rmL3mKjmAw6DuRb/dGkqshC/C5LXjkToZ5xdjAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736802863; c=relaxed/simple;
	bh=gDVjIyupViTpLPklirSL7vMmnWCg3s/D6lSP9P/hdQc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qkSjfSyoemQPlxTh5izaaQUVQieN4IisntanwtqohZV+YVNUt7VUvbcN+p7J0CPsr9Qh6BPc6qXj+SnpLuC/r6KLkxY8BAi6DpxGDDdhpElroHmYxhP6QCcOdBcIAqBN9KPSi0yReLRlRqRswoW4oIZpZ672bUllXzqPbgeJFa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G5oaJTcF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 730F8C4CED6;
	Mon, 13 Jan 2025 21:14:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736802863;
	bh=gDVjIyupViTpLPklirSL7vMmnWCg3s/D6lSP9P/hdQc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=G5oaJTcFq5M3jNV++eaOd54kuVJ5pQNfaTo89sE0C2bDs/iHFwjjYh0sevVzjSeNl
	 nYpcpOSj2KdnRFs6HhPbK67oomSYO+mH29A1GnH28Q+ITnIp4sXRz4xVyakAQBBPBw
	 3UrH7cewXKklCZJLb5YE7ejzrzh/4TQrOqC5AUA2H2NdKx1U1CGJ3DMX+ay0dWyllf
	 C6a6DiFFOMa0cmbaUidBkmBkqCtyIqft7y961ocZ6ydGTXSuzWztvkEgM5XlM8VaL+
	 DS3tJGaSSGLNM26YAQLATdTz7YKb0J9v0s/M3R7nwROkXeK9YOiVDdivDNMoYxGDNW
	 GORX2gXhkukgQ==
Date: Mon, 13 Jan 2025 22:14:21 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Damien Le Moal <dlemoal@kernel.org>,
 Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH] PCI: dw-rockchip: Skip waiting for link up
User-Agent: K-9 Mail for Android
In-Reply-To: <20250113192720.GA414640@bhelgaas>
References: <20250113192720.GA414640@bhelgaas>
Message-ID: <5EFEAC8C-6BAA-46BC-9EED-F0D89952D3E5@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 13 January 2025 20:27:20 CET, Bjorn Helgaas <helgaas@kernel=2Eorg> wrot=
e:
>On Mon, Jan 13, 2025 at 11:59:34AM +0100, Niklas Cassel wrote:
>> The Root Complex specific device tree binding for pcie-dw-rockchip has =
the
>> 'sys' interrupt marked as required=2E
>>=20
>> The driver requests the 'sys' IRQ unconditionally, and errors out if no=
t
>> provided=2E
>>=20
>> Thus, we can unconditionally set use_linkup_irq before calling
>> dw_pcie_host_init()=2E
>>=20
>> This will skip the wait for link up (since the bus will be enumerated o=
nce
>> the link up IRQ is triggered), which reduces the bootup time=2E
>>=20
>> Signed-off-by: Niklas Cassel <cassel@kernel=2Eorg>
>
>Thanks!  I was just reviewing the addition of your dll_link_up IRQ
>handler, and was about to ask whether you wanted to set use_linkup_irq
>to avoid the wait, but here's the patch already :)

:)

>
>I think I'll sort out the branches so the dll_link_up IRQ handler,
>this patch, and the corresponding qcom change go on the same branch as
>Krishna's patch to skip waiting if pp->use_linkup_irq=2E

That sounds like a good idea=2E

Thank you!


Kind regards,
Niklas

>
>> ---
>>  drivers/pci/controller/dwc/pcie-dw-rockchip=2Ec | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip=2Ec b/drivers/=
pci/controller/dwc/pcie-dw-rockchip=2Ec
>> index 1170e1107508bd793b610949b0afe98516c177a4=2E=2E62034affb95fbb965aa=
d3cebc613a83e31c90aee 100644
>> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip=2Ec
>> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip=2Ec
>> @@ -435,6 +435,7 @@ static int rockchip_pcie_configure_rc(struct rockch=
ip_pcie *rockchip)
>> =20
>>  	pp =3D &rockchip->pci=2Epp;
>>  	pp->ops =3D &rockchip_pcie_host_ops;
>> +	pp->use_linkup_irq =3D true;
>> =20
>>  	return dw_pcie_host_init(pp);
>>  }
>>=20
>> ---
>> base-commit: 2adda4102931b152f35d054055497631ed97fe73
>> change-id: 20250113-rockchip-no-wait-403ffbc42313
>>=20
>> Best regards,
>> --=20
>> Niklas Cassel <cassel@kernel=2Eorg>
>>=20

