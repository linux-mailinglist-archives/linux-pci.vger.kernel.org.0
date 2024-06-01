Return-Path: <linux-pci+bounces-8156-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94C418D6FF5
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 15:11:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 358571F21C75
	for <lists+linux-pci@lfdr.de>; Sat,  1 Jun 2024 13:11:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 746971509AC;
	Sat,  1 Jun 2024 13:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="gkR1vG4P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EF841509A1;
	Sat,  1 Jun 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717247493; cv=none; b=YNC7DkyT5teHESq5mPiPNqZMg1P/hmPpyLgRKGFhU7AdZbb5QfComtK/vU5ewZ78nXWzZpodytb6sJPhN5UQWaNvLQGB6cprQi4ZeQ3Ll3KzPEOTz6pxnUebW0stsFUuimxwrrUNAXIaHMZ/mk4oOXOLirh+VHcoJL0B66/bSGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717247493; c=relaxed/simple;
	bh=1azJbmKafXYpI7cPrs4sh/5oeftQgPo4X4g1HEFMTDI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmUJs/aW/EzHkHC/LRHwuUUn/5XCAq8rt5F9a8z4Lmtb5ZaIK1WoSD9+wp0YqIliejxkn+ehrSe6zer3sgnPjC8s2B+6kNGs4E1/EHaEXubKmAf9YlZ7bCwutmxekU91KasyrcwJHR/3s4lXnyOK/Ba83U41VHh/ZqpiwH06U1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=gkR1vG4P; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1717247440; x=1717852240; i=markus.elfring@web.de;
	bh=1azJbmKafXYpI7cPrs4sh/5oeftQgPo4X4g1HEFMTDI=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=gkR1vG4PWxoV0wY+ljRZqKsbe8ownQbLIekqm0gF/RdpoxNT7ZPf0PMj74VXYCkV
	 WoBnYOowP8AEsvKwIXx0EFA5n1FwefIyiiSh2UhsTmkqy9I+x7x0tMTZgT28youFM
	 mPQnFv2EfcYWykUCRMXbYTy26/qgqtRCafT40qdArO9iZyzCj9VzN2ki0mg7bu0mK
	 qAwhPljOHpt42F7VA3rQJ5OlpP4wFXiuojnCvjiOnDOVtanQV9Dri6cysZESU7QMJ
	 DR1F38tES2ivM9n2b3TnpbhMHaSIkg2KJAhfc4dcLtKGs4ywduOB5CRDqrvjWetQc
	 CYxxpyCA8IVLvMTFPg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M8T7K-1s8yeW1qYC-009vic; Sat, 01
 Jun 2024 15:10:40 +0200
Message-ID: <e4e9a26f-720a-4648-a099-be9193af1734@web.de>
Date: Sat, 1 Jun 2024 15:10:29 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] PCI: xilinx-nwl: Add phy support
To: Sean Anderson <sean.anderson@linux.dev>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 Dan Carpenter <dan.carpenter@linaro.org>, Michal Simek
 <michal.simek@amd.com>, Thippeswamy Havalige <thippeswamy.havalige@amd.com>
References: <20240531161337.864994-1-sean.anderson@linux.dev>
 <20240531161337.864994-7-sean.anderson@linux.dev>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240531161337.864994-7-sean.anderson@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rr0oyNIhZsSYRmKnkOucR9Hnu5e7lA1H5g6+bgs5JjeJyKuLq0b
 gfn+X2lblMLkvd1RN6itUqIcqLUJwWcrcKx1TlJMfYtpeR2mBz0DeCdoxpOEXRCBTv5i/gG
 bMiulP3G/MO/ora81oPn2M3noj4QrQjrRGuYvK5gvn2RPbhnJjkMLwaubArX2DSPv2gEFkY
 fn5kg+YVa3D9hu+VmBYKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zmel7gxYK9M=;CsezFhwRd1YgwkDWyl9LkM6gLr3
 y7Ltp5b/BFj82tGPE7dpM7Ig10am/QTbVDxOQVlqrKQeVkzSTRKiuGOVvHzCaW2piTZF6hMb5
 8kzWVUwdFodYkbrhxswldnpMokKLkJkhZ/M2x5r3JpZ8oixxJ8rPxU/5/3W4b5LuxntS/Lph2
 XH/kYKdMU4Xfs9scU7YDmU+FbaqLXVwedllqd0/3NvrobDgOpZLbh3eJltqNSWvaSzlvvvywK
 /omG1LnxbCxe8Vt0FOgSakA9c/IaZv1wvS5JCXDjJYRheOgWq90ZqetRsXh9h2IF5n32rJhG8
 j7+I/uivkmFY8iL1I/Ap/xYe8ieXC563DKFqqIpxxuq0cr9Z3MFdXv5uyE0vbmMASCASZDE+v
 U7TkkuwVLnYAzBcq1VjmXF+pffV1Im+mxX0vsll8Wrhw884LoYGYQOj/mwTyQgs8PNhiUuz/f
 DoBSgWk8rJM981Mu7WjKobo0NeQGPGlZwsIUQIQxY3L4CHRptzFoE5/B2jJ3OUUoiXiW7wd5c
 0YfU61UnaCscPK/pfu5qMo8LCMvKfgKdpL18j5JQGWM2JLKTSzKvI0tqmvhEtEtE3EQ292u1d
 Ll/wR97QZ4hbcaGrx0hNo4zadgzcMWZz4OXrdn8yThcgLOjQhzycF0mko7l0r3qJeaUMDjQSx
 EPi8Vx+BGd7NTT6yLJ615Ehy+JN3xeiZvChFzMrHYXtLMBzfI1cHx/eRKrJN8Yt4LwTe/qVKR
 giHVSacz/SVXEOQqML6eyV1IdDDbbh0uNgLj19kKx/wYeIUhoLsu1eojJfFl8aM37HlbcUKkr
 27/mdZf03Z8KxcztQp0hyriCscZ/YVMXrlEZNq82LHsoU=

> Add support for enabling/disabling PCIe phys. We can't really do
> anything about failures in the disable/remove path, so just print an
> error.

You propose to extend the exception handling.
Does such information indicate a need for another tag =E2=80=9CFixes=E2=80=
=9D?


Would you become more interested in the application of scope-based resourc=
e management?

Regards,
Markus

