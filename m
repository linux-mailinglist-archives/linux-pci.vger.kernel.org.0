Return-Path: <linux-pci+bounces-12970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 959A1972CDF
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 11:05:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEB21F26016
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 09:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0325918859E;
	Tue, 10 Sep 2024 09:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="fc6+luku";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="BJYPBWuF"
X-Original-To: linux-pci@vger.kernel.org
Received: from a7-32.smtp-out.eu-west-1.amazonses.com (a7-32.smtp-out.eu-west-1.amazonses.com [54.240.7.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436FA186E4B;
	Tue, 10 Sep 2024 09:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.240.7.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725959140; cv=none; b=ZQMQ8OpNRqAuBKPkUKXmhwdwgZE8YgrgSdTyXRZITyuLzCw75qMQhgMSbOmCIsAZYXOnjVKWuFbkd4IBdg29wAelQjfm/+CEGfgDMymWyl1Z9com3ikiAODMIrVJ0RWtxIogsVsmxldrSeKSdwqZGsee+PU5QG9/o6AqpKs+lMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725959140; c=relaxed/simple;
	bh=e4E2QhibonUrb1as7MzSa4GR+pgL2He6HwaENBXi7to=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lYr3KPYH/03IDF9X0UsJemqhyGC+pq1zjA8wieAIKZz2wHYOjbcQJHDtz6Z2O5Ifnq9mT7uGi1lE9kWMARR6KJBECqJ4RVpAzkPeRyQG71VtZftKy9y3o9LZOkl9ZcN7ldWcO081mETxDP/5lH3VEk1rxOcpARtf6aw2E7YxR6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=amazonses.collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=fc6+luku; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=BJYPBWuF; arc=none smtp.client-ip=54.240.7.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazonses.collabora.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=4232tfv5ebdrjdwkr5zzm7kytdkokgug; d=collabora.com; t=1725959137;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=e4E2QhibonUrb1as7MzSa4GR+pgL2He6HwaENBXi7to=;
	b=fc6+luku6MrEhrDUHytMjT4jSVkMAo5tyKr9F5VdtIWuegF2xO/n2RUrUzEziERJ
	W0I6OM6WAd5wcwKpqzkt8m9BVYxOsfqgrPHetjVgp9nlWN4Glu6DCjtDwB9C61IvGKd
	kO9mdOiBGww6ppt4HQdSquJ/1vzb7ih8GabjhrLDGtRlNB7JmQHvK8z+vBY2EvRImdp
	WxAgAgpFapf7gl9GOQDHVo3bhWy44uoS3teNdDKxTvHzR9zjZQcpNJy1XhGOUWe5L8h
	vVTkH4jIRi5gqq7EW5IJ+7K5nJspazyjsiQI1leh4NQZvr3JhDf4qkyDZshLa8ByDnH
	7tHsJEdHzg==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=uku4taia5b5tsbglxyj6zym32efj7xqv; d=amazonses.com; t=1725959137;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Feedback-ID;
	bh=e4E2QhibonUrb1as7MzSa4GR+pgL2He6HwaENBXi7to=;
	b=BJYPBWuF8Cw+HNGvI2d33pqsPo7cTFTfIb7Q74Ywmhy4h19IeWWantrd/4LlKuGx
	JYVXmrw4cYsQuQWcXJpxSaeA4ivgLmgoyE0xfMu3nau0I3BC6+as5hP4IfvYVBQ069O
	k+YWbQX9ggfKZxsWkoguYpGAo8iVe1Ul75CtAKQs=
Message-ID: <01020191db2e68dd-f46a7a3b-61d3-4f99-a449-5c9b86d667cb-000000@eu-west-1.amazonses.com>
Date: Tue, 10 Sep 2024 09:05:37 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] PCI: mediatek-gen3: Support limiting link speed and
 width
To: linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com, jianjun.wang@mediatek.com, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
	matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	kernel@collabora.com
References: <20240806094816.92137-1-angelogioacchino.delregno@collabora.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240806094816.92137-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Feedback-ID: ::1.eu-west-1.YpP9ZbxnARFfy3Cb5pfsLd/pdsXBCNK0KEM7HforL4k=:AmazonSES
X-SES-Outgoing: 2024.09.10-54.240.7.32

Il 06/08/24 11:48, AngeloGioacchino Del Regno ha scritto:
> This series adds support for limiting the PCI-Express link speed
> (or PCIe gen restriction) and link width (number of lanes) in the
> pcie-mediatek-gen3 driver.
> 
> The maximum supported pcie gen is read from the controller itself,
> so defining a max gen through platform data for each SoC is avoided.
> 
> Both are done by adding support for the standard devicetree properties
> `max-link-speed` and `num-lanes`.
> 
> Please note that changing the bindings is not required, as those do
> already allow specifying those properties for this controller.
> 
> AngeloGioacchino Del Regno (2):
>    PCI: mediatek-gen3: Add support for setting max-link-speed limit
>    PCI: mediatek-gen3: Add support for restricting link width
> 
>   drivers/pci/controller/pcie-mediatek-gen3.c | 76 ++++++++++++++++++++-
>   1 file changed, 74 insertions(+), 2 deletions(-)
> 

Gentle ping for this series.

Thanks,
Angelo.

