Return-Path: <linux-pci+bounces-18962-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 405589FAD9D
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 12:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B391637E4
	for <lists+linux-pci@lfdr.de>; Mon, 23 Dec 2024 11:18:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5260119597F;
	Mon, 23 Dec 2024 11:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="J7hYJXfB"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 772C6191F9E;
	Mon, 23 Dec 2024 11:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734952719; cv=none; b=cEfHep0oPAloEj4DnszOg7m6vW+tEchXanSi1vD8vUuysFUf3Y/fe/XFiFA/YzoN+5buQz13/Otek0GhRaL4RovCaH98byDJ+o+1MhChVUygn67inSW7UkBiJSHRtEh9ou5zmGJ/SPtgZDmgGyVZJK7kLISh7+QF7IEK5Qyla28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734952719; c=relaxed/simple;
	bh=QLyQ/40bE76H9VbgLGGDBjS5cTe4R2nX1hxnkHzKGJw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QaKFmkcKlec0N1RLeSSSGfrFgB2RA8/fTKw5mWRZ5qSUaagmCNWPCPPMC3capXlGxTxdiMygebTId4JMwgvF8IAsNdHrTBPitHhVgJnM18xsWzYkwCPV7K2RQPzHknbah0t9Ooy1AQJjYdld9cdBVlnostKpeok+YXm1E029Qqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=J7hYJXfB; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1734952715;
	bh=QLyQ/40bE76H9VbgLGGDBjS5cTe4R2nX1hxnkHzKGJw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=J7hYJXfBjYVrWELRFDnGBJnAomHjbvIsewnpSzJohdUUQKO3lHlUM0Vb/x8pbChXa
	 xLE6hUGr+zusf6JujWwc97jg8+CmZcssCJr3FRS9MiMsTcacmKeHSrRHFKSGcot9kN
	 k2Ggkos3l4hgHFOhiuuFMJU6l1Kh6Aqwry9/4KhVlAIwVnJ9kBMBVWjZ6fZ+JchJw7
	 4QBGG0lCEs0mrAiGbeglBnmB50ZPZvPsrjndeHrBcNZYl8VfP0LByIXItXUt+auHii
	 +4NcUz2WoDgCAXSGl9RbR6PLi4pHA38ovcK/ZolYZNTqcSwedovHvJq4llEBztK9kF
	 WHwZdaPSQz55Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id EB21917E12AC;
	Mon, 23 Dec 2024 12:18:34 +0100 (CET)
Message-ID: <b9c6820d-249d-41fe-a605-acab74afe88a@collabora.com>
Date: Mon, 23 Dec 2024 12:18:34 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: mediatek-gen3: Enable async probe by default
To: Douglas Anderson <dianders@chromium.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, Rob Herring <robh@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org
References: <20241220145205.1.Ibf2563896c3b1fc133bb46d3fc96ad0041763922@changeid>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20241220145205.1.Ibf2563896c3b1fc133bb46d3fc96ad0041763922@changeid>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 20/12/24 23:52, Douglas Anderson ha scritto:
> Like other PCIe drivers, the mediatek-gen3 driver has a fairly slow
> probe. Turn on async probe since there's no reason to block the rest
> of the system.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


