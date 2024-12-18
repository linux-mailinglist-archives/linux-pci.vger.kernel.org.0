Return-Path: <linux-pci+bounces-18713-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E8989F6A1F
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 16:35:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86F3B7A2D43
	for <lists+linux-pci@lfdr.de>; Wed, 18 Dec 2024 15:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEFC1B0422;
	Wed, 18 Dec 2024 15:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="k6XM9zP/"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DAD13212A;
	Wed, 18 Dec 2024 15:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734536107; cv=none; b=uKp+NA5a/I4j71F/Kkoni9zG1h1jU6d7Gsyib3MWgEHemkw48USva1c019Tipo0EOp6pCvbIBQpqFSRf4krf5MqLfYABrBSSA2I6q8qdAoazmXe8IAI9PMczj0+AuJkvJsufAi/FPzjWCo7N1HXNjWsiT4fik8GhUNJNXfS7Z/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734536107; c=relaxed/simple;
	bh=DG5Uydk1Hvw8FVpZxUIigNGD17tSbGmGCQHmGMHwuqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NFpc458R+2ExjfL3DuI7Gawo7hJhZH5dgtn8ShlbBXUR1UtOtxwxaAMyRWsBakDbj7fyaSLNmbxk6D+PjiQkEVdT04xGDtd7obvVE1Dzl59XI5iM9A778IYVVucnUFA2dqPIiK4Ur5t58Up0PEI+D3wde+3zjw9wedXruhFh2JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=k6XM9zP/; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734536103;
	bh=DG5Uydk1Hvw8FVpZxUIigNGD17tSbGmGCQHmGMHwuqQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k6XM9zP/gM9gkkcCyB8vtKl1bj9B4jIrcwvsd3dYbF2nvbO4pbGcEnHC8H8P3OL6b
	 jn2kxmChKvWi7HYpjviQbH5mI9nK6e+7ruMMAwe4PQvFmAazo95WpqDBquFKKnihXA
	 JxOPh0CNTyc9BLNdrY9PkycApngwiUd5Rg+vXiM6fGW4aYHkw3WMYUeCTsJ+bnlbKY
	 HIZJTCYMq02O44AcL31+TY570HZsPK08P6eDtuEVzEKhpnxXwTfr8tV/W3lrx4NHv0
	 6UASO5v/CodOvaFYljIT59x9FlFhYC/USq0GSCLPG8O7kto0ucfLHw8OPsqZSpCxsR
	 Pd5Rg8+lnWK5w==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B0E4D17E3784;
	Wed, 18 Dec 2024 16:35:02 +0100 (CET)
Message-ID: <54598909-979a-40b6-aa68-78ad87105088@collabora.com>
Date: Wed, 18 Dec 2024 16:35:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/3] soc: mediatek: pwrap: Switch to
 devm_clk_bulk_get_all_enabled()
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Matthias Brugger <matthias.bgg@gmail.com>, Jingoo Han
 <jingoohan1@gmail.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org
References: <20241217-clk_bulk_ena_fix-v5-0-aafbbb245155@collabora.com>
 <20241217-clk_bulk_ena_fix-v5-1-aafbbb245155@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241217-clk_bulk_ena_fix-v5-1-aafbbb245155@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 17/12/24 22:41, Cristian Ciocaltea ha scritto:
> The helper devm_clk_bulk_get_all_enable() missed to return the number of
> clocks stored in the clk_bulk_data table referenced by the clks
> argument and, therefore, will be dropped.
> 
> Use the newly introduced devm_clk_bulk_get_all_enabled() variant
> instead, which is consistent with devm_clk_bulk_get_all() in terms of
> the returned value:
> 
>   > 0 if one or more clocks have been stored
>   = 0 if there are no clocks
>   < 0 if an error occurred
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>


Stephen, sorry for missing the discussion about needing an ack on older versions -
Cristian just pointed that out to me.

Anyway, if you want to take this one with patch [3/3] I'm fine with that, so

Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


Cheers!

