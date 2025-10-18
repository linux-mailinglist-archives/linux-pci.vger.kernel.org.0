Return-Path: <linux-pci+bounces-38552-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54128BEC7EF
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 07:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FD0C427E69
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 05:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D3E1DFE0B;
	Sat, 18 Oct 2025 05:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcEHkju8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E025227;
	Sat, 18 Oct 2025 05:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760764059; cv=none; b=OtJ11gAZ4ljbR53D+WzfyCzVlThlFZnZYKJqMEwTXZv/DCpga12zyqXnZrsenCLYiU4AD0POK/kX3LW7tTwf30FHsCBKVEhoDBZ9o6RXTZUbrToxdd+t4xXKfa+6BZqsaAAN2+vwr+dogAejeMF8fLQfBHZmhxuvhoc6YnFYwSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760764059; c=relaxed/simple;
	bh=7HQHgRhKu2K+O3M8/DReLJ1cTm/7JJq+iftVZzfodks=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=s0asMNn4R7XjZbHNcEeJ22aOsuVBz6DV99OHdCz6JqcpQxI5f58L1qWlWaFUpnNsMggnDjUYdy1PIeUBchSuAsfk7tXqIb10nozJ/chrrU2hfnk6WoX5XJM/USoY0Pq8guVFFTUVxTptQqCvaZ4sSlzVd1Tnh7Vr4g6BtI4yoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcEHkju8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 591CFC4CEF8;
	Sat, 18 Oct 2025 05:07:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760764059;
	bh=7HQHgRhKu2K+O3M8/DReLJ1cTm/7JJq+iftVZzfodks=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=jcEHkju89gP9MlVd3XBTlA+BScjCk+KCEnMgkB4zIPwOOC0l/A5XDJPg5jj/NflSA
	 Z7ysfdXwfMUqMTe5iGk+EQWG7ZtpW4kvZNGnOARN+E7motMWAkmFFkMPhEqPCtwmra
	 1tk+HuLpFxzT4CzhyKXN8Dy5TWW/tkz40UmdVW8ZARYMhjVLnBySZw+vaY0R2G+zjC
	 TUPKDLDxcJINO6nvFyaTLMKTo/GjKXoGiNwQ9LhAM0eukm9VX8f3GMkYldjruOPyse
	 6rgf4ZX7k8VksAgHMcXyCBhEywUPHV3Rjl9q83Q46IcDI5Tp6OsgE4+c881I3IYC5C
	 X89baa+iOWsAw==
Date: Sat, 18 Oct 2025 07:07:35 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Shawn Lin <shawn.lin@rock-chips.com>, Kever Yang <kever.yang@rock-chips.com>,
 Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
 Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
 Diederik de Haas <diederik@cknow-tech.com>, stable@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3=5D_PCI=3A_dw-rockchip=3A_Pre?=
 =?US-ASCII?Q?vent_advertising_L1_Substates_support?=
User-Agent: Thunderbird for Android
In-Reply-To: <20251017164558.GA1034609@bhelgaas>
References: <20251017164558.GA1034609@bhelgaas>
Message-ID: <54FD6159-AE45-432B-8F0E-4654721D16A6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17 October 2025 18:45:58 CEST, Bjorn Helgaas <helgaas@kernel=2Eorg> wrot=
e:

(snip)

>>=20
>> Thus, prevent advertising L1 Substates support until proper driver supp=
ort
>> is added=2E
>
>I think Mani is planning a change so we don't try to enable L1
>Substates by default, which should avoid the regression even without a
>patch like this=2E

Sounds good, I suggested the same:
https://lore=2Ekernel=2Eorg/linux-pci/aO9tWjgHnkATroNa@ryzen/


>
>That will still leave the existing CONFIG_PCIEASPM_POWER_SUPERSAVE=3Dy
>and sysfs l1_1_aspm problems=2E

Indeed, which is why I think that this patch is v6=2E18 material=2E


>
>And we'll need to figure out a way to allow L1=2Ex to be enabled based
>on 'supports-clkreq' and possibly other info=2E  That would likely be
>v6=2E19 material since it's new functionality=2E

I agree=2E


Kind regards,
Niklas


