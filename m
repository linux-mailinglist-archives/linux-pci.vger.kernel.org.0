Return-Path: <linux-pci+bounces-9368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 974A591A2CF
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 11:42:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1BEF7B22551
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 09:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B2113A3FC;
	Thu, 27 Jun 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JpnRge+R"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77B51386C6;
	Thu, 27 Jun 2024 09:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481328; cv=none; b=TfptcNdUrvAzQveNWOlXZtStes8OujKM7eBN4aS8wX5fIiUeJlzihBnrOCqn0pU4/KO+/eEer8+kcW69uOWxOyHve6A2xRk6PBBxpq/cBcgB/nUzvALfY+3hX9br9FQbXMv0Jkt3vjdHrrdyqJoBPgqR9y/FvlUYMlFanHHYph8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481328; c=relaxed/simple;
	bh=tZr32JHQklyrO/9FeqwAvSJq70aIA76d1jSLaHhjQuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+FafUzM6oGj2K2fFtYDtWaibn7CSsTpxLYfIzU7aDgdmjgjmyqI3Ke+0MZ4sImxnOGSlPiAPZhy7/OgH1e6m6nidAdxpx3wafh79AEwPOpABnxGHiQeNNALXcIL5xFrv8CBk5/aQyNE/NJrjHiBsy/R9Cy2K/M/1Ws0xaeHq5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JpnRge+R; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719481324;
	bh=tZr32JHQklyrO/9FeqwAvSJq70aIA76d1jSLaHhjQuE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JpnRge+RBdRcIE+ZfC/9DC81jJry0CQlpqbFofktI2uNRxO4UW1PJkPiFUPcqOQmZ
	 oegpF5/O9EWQKd+FvIR1xzpQI1oE2K3Sm2bMh+u+iiUFgE4SBM8ouyb7VXe+oaH3p9
	 OZZbFj14roY0AQLrgealstIWkFROOJhKKuBBo2YThOjyjQs+yHE6aDqt/mAK6O8Ota
	 QxN2lVrYJ2ke8YJzImgdUyHvMpNHGCY71sA7V3G198mrOXbhZ8DijhGRM19WdQaBQj
	 1nafRFnDnTlAGdcw/YY2dgUvjUk/uelixm88ooiLF3RIqxNAqDDEJC5HxSlrr9LKIU
	 opPQfkWF4QHoQ==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E5BB0378211B;
	Thu, 27 Jun 2024 09:42:03 +0000 (UTC)
Message-ID: <f6f0a4d4-3455-49a3-8e61-8e11ba186ac1@collabora.com>
Date: Thu, 27 Jun 2024 11:42:03 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/4] PCI: mediatek-gen3: Rely on reset_bulk APIs for
 PHY reset lines
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com, jianjun.wang@mediatek.com, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 devicetree@vger.kernel.org, nbd@nbd.name, dd@embedd.com, upstream@airoha.com
References: <cover.1719475568.git.lorenzo@kernel.org>
 <b4603cb7c259d94de5a69508dd2aea46b25e385b.1719475568.git.lorenzo@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <b4603cb7c259d94de5a69508dd2aea46b25e385b.1719475568.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/06/24 10:12, Lorenzo Bianconi ha scritto:
> Use reset_bulk APIs to manage PHY reset lines. This is a preliminary
> patch in order to add Airoha EN7581 PCIe support.
> 
> Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



