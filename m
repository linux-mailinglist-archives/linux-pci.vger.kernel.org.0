Return-Path: <linux-pci+bounces-37187-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64FDBBA8D33
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 12:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D040E189ABB5
	for <lists+linux-pci@lfdr.de>; Mon, 29 Sep 2025 10:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E509F2FABFA;
	Mon, 29 Sep 2025 10:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="btlpg6Oc"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C5129E110;
	Mon, 29 Sep 2025 10:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759140660; cv=none; b=gAIfLbqyU75MB2QbSRKlSxqfZJTjSfx8gd4SbRdvFIYa0GlqfiEuddybpvXLG+kqdTWi50OTMQeiOvZHF5uaVxPjXjKlZjJXy2oCoJOH7quPMdsuWTnRDrKb8DUjluLt5V2vrV/+RScLW9zK6IeYSO30a1zvjiZEjms/BR69fRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759140660; c=relaxed/simple;
	bh=oOq/K7RTeSRws70Trwj2HjoDrovM9ft5yZ0P7I05xrw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fO4eDVzOQFgj8hOEg4TWoj7WlEneehjn91IG3BDUxM655cLJa5Dt4eYDFChGOispCXKvO75HYguY6+nM7H7k+BqJJRsL3DDjdsJwEE9UHdW04EIbtxHR3WsEY6IxKGTXQirEgU5EuBCrsBDigJYfqA+exCT3JvFdzt5YjOWOjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=btlpg6Oc; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1759140651;
	bh=oOq/K7RTeSRws70Trwj2HjoDrovM9ft5yZ0P7I05xrw=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=btlpg6OccvX6sm6yAdU5r0isl8r5hNC5dQcMow5Y2wBFpXXp86cTCxmNF9X3EgQWb
	 8uuWVuphWoD0MNJ+LaWccoPE5Y8z+AUvQj9b8FaF8mJg+met5EfmkAZJbmcUwOKoK8
	 V148lh+aYG0nk8zV/AFgVbHDaQE1mW4lFuuPIc6MHZ/za4FHTkLM6MVrxx6XpvIJGJ
	 gp1OXGDV+hWRaDwg52EQ8jAviSp9gPBqp3vvruYgdEvqYrwJ2uzWQ5VvjTl3xnaFP5
	 K9ZRRf91E9rdcW5mMPI0NUl35ac/5H+zQMrQg6iONIts417VRJL10H/SqCv2L2DrHX
	 /38M5hwnFc9oQ==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7F60817E003B;
	Mon, 29 Sep 2025 12:10:50 +0200 (CEST)
Message-ID: <38e03c8d-a038-474a-b62a-897694299642@collabora.com>
Date: Mon, 29 Sep 2025 12:10:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/4] ARM: dts: mediatek: drop wrong syscon hifsys
 compatible for MT2701/7623
To: Christian Marangi <ansuelsmth@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, linux-pci@vger.kernel.org,
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 upstream@airoha.com
References: <20250925162332.9794-1-ansuelsmth@gmail.com>
 <20250925162332.9794-2-ansuelsmth@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20250925162332.9794-2-ansuelsmth@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 25/09/25 18:23, Christian Marangi ha scritto:
> The syscon compatible for the hifsys node for Mediatek MT2701/MT7623 SoC
> was wrongly added following the pattern of other clock node but it's
> actually not needed as the register are not used by other device on the
> SoC.
> 
> On top of this it does against the schema for hifsys amnd cause
> dtbs_check warning.
> 
> Drop the "syscon" compatible to mute the warning and reflect the
> compatible property described in the mediatek,mt2701-hifsys.yaml schema.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



