Return-Path: <linux-pci+bounces-25009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 672A1A76717
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 15:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72183AA9E1
	for <lists+linux-pci@lfdr.de>; Mon, 31 Mar 2025 13:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB0F1E3793;
	Mon, 31 Mar 2025 13:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="u2Txhu/p";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="lc/nK/HG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9221DED47;
	Mon, 31 Mar 2025 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743428901; cv=none; b=TOdfVov5vnVPV0D1ZMzWQTVTdV8INgP4AWuEQYP/EvZfqT5c+Yuc4x8gdKxTLiu3OaJDAAvT1eAM6dboH0Tts85HuNrc+uxYO4ieLa0Tmg/nXqe5H26Q6R/kY7uha8gzOLjLH+3qXWhhGQCGhPHlUfmFSChyx1FCwE4/G/WuiKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743428901; c=relaxed/simple;
	bh=a6YbF51RquKYdM00wX8FTZ5Fe+kgtZnlAWuuyURxYFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G/UhIxaireauZ2U1KDrEsc/wsS5yHI3cFHvfz2MAFL7IKLtI3VEo7mbCUbnr3gZrLlKXzAjyW+VffnuDP1+99vOhIlLg5bo3KKkEY2Ib7Ku5pW8uiMyqm+jZ7UuIgWOcqf9KbMaOlcQoZIHKjd3wBob4/JgMpbZChoGNTEcQdRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=u2Txhu/p; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=lc/nK/HG; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4ZRCBh03Zpz9sbC;
	Mon, 31 Mar 2025 15:48:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743428892;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RqYvmo1+63hE4DUnTOfQUG6qgRimzlpGgLI65lJ95Q=;
	b=u2Txhu/pFD+mb7d5yvwNb99Axh74qUezDKL4vtc1Q5s+TVMQ1Z1UDvF0UHRp9ubC9Q7J84
	SghQtkFciAjeCQDE4DFFVGEvU4taVNyjCkOta/FM4VdIB13a6H7Rh1MPIeiHzuZv74wYtC
	IpW68WP3P8Tj668HnQpwAsvtc+udLouWLpSqPXmKpxVqdGRT906dB83ajzNy/N0aNgx0fx
	QgwkXjDYrt5vULK0n2kcuEBTd8vU7Q0fyZdDnS4AH4BYJFzWntT3unGIhA5dtwBICN7HJT
	muq214yZd32J1vW3YgOrnzyapyv6StNJqF7i96asDmZQEqTyVbrbUf6owOGLSQ==
Message-ID: <daed453d-5b52-4bb6-810d-9195491e04c0@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1743428889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9RqYvmo1+63hE4DUnTOfQUG6qgRimzlpGgLI65lJ95Q=;
	b=lc/nK/HGdnYy1zFMmImCHE0GuW93KXWyGIwHwRKiNopDIwcV9lkCL3azV9QutivFu25zKM
	clU1gVg0vXBzuHDBOBEK/vi7DVXBN1pfxccqN8T8P/IaA8l63tYg4fmJanyRWihi6ASwRn
	ZNqpgUO0EM+stOy2jJJE0B3237qSC1qQrCrCAwVQf1R5t/wcJfj122/PaY1OBnX5awfKF7
	4ypNczXQHG3b44NNN5Iy78OjPQt9calfabsOOoB04Y7ZhY6ttCVoZruNX6VJdn9AbOasS1
	vrVP27Y8id7goZGEfpGcMTjcfNLjdJNiJt2KfQV2kGtpNXStAc9PEha0TRhS+A==
Date: Mon, 31 Mar 2025 15:48:04 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/4] arm64: dts: renesas: r8a779g3: Add Renesas R-Car V4H
 Sparrow Hawk board support
To: "Rob Herring (Arm)" <robh@kernel.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
 Conor Dooley <conor+dt@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Kever Yang <kever.yang@rock-chips.com>, Aradhya Bhatia <a-bhatia1@ti.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 linux-renesas-soc@vger.kernel.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 linux-kernel@vger.kernel.org, Junhao Xie <bigfoot@classfun.cn>
References: <20250330195715.332106-1-marek.vasut+renesas@mailbox.org>
 <174342765546.2641812.18254954916877172569.robh@kernel.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <174342765546.2641812.18254954916877172569.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 307f491e7583be5091d
X-MBO-RS-META: 3a3a1xx19f3anshqfe6z94mdr4ak1cfq
X-Rspamd-Queue-Id: 4ZRCBh03Zpz9sbC

On 3/31/25 3:32 PM, Rob Herring (Arm) wrote:

Hi,

> My bot found new DTB warnings on the .dts files added or changed in this
> series.
> 
> Some warnings may be from an existing SoC .dtsi. Or perhaps the warnings
> are fixed by another series. Ultimately, it is up to the platform
> maintainer whether these warnings are acceptable or not. No need to reply
> unless the platform maintainer has comments.
> 
> If you already ran DT checks and didn't see these error(s), then
> make sure dt-schema is up to date:
> 
>    pip3 install dtschema --upgrade
> 
> 
> This patch series was applied (using b4) to base:
>   Base: attempting to guess base-commit...
>   Base: tags/next-20250328 (exact match)
> 
> If this is not the correct base, please add 'base-commit' tag
> (or use b4 which does this automatically)
> 
> New warnings running 'make CHECK_DTBS=y for arch/arm64/boot/dts/renesas/' for 20250330195715.332106-1-marek.vasut+renesas@mailbox.org:
> 
> arch/arm64/boot/dts/renesas/r8a779g0-white-hawk.dtb: pcie@e65d0000: clock-names: ['core', 'ref'] is too short
> 	from schema $id: http://devicetree.org/schemas/pci/rcar-gen4-pci-host.yaml#
I believe this will be fixed by input from Krzysztof on 1/4 which I 
already added to V2 , thanks !

