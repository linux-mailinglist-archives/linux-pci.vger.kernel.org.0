Return-Path: <linux-pci+bounces-9369-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C1191A2D0
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 11:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6E4284803
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 09:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F20021386C6;
	Thu, 27 Jun 2024 09:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3E0lvpcu"
X-Original-To: linux-pci@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FFAB13AD04;
	Thu, 27 Jun 2024 09:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719481329; cv=none; b=hpMGZHwwTgf5IDRw3/eWs5lCPI+nr2f2xjKjIdKDHWO/yq6Wp4Q0DvS6+gqG/s8Dc1emoKJVrgH9BYJRiAdneUwIOm6C+aTLYk4ajDmYu5Pt4j0KotW35RX9k2H+5vW48qMGbEYb0du7BUAPbLnQuNzdIYJzJ2Yu5QJd+GV4b70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719481329; c=relaxed/simple;
	bh=SHwLopLsuJIvSoRHrncD2LhBaww5jF0LXUvXBdkPh1U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NuK1KVCunaO+5JsKInF5nEuFkn2jIPzcW81bkaLCziRt47CRycAufrMQ0C4mK8o52F0EAZTpd+hfHzIjpPyXLFxvkVQeR7YnKM0UP/nJCaY0m2lU7zVDd7SuSnzfsZPh05FABmMECoa5C5hzzbtDP3yT5kIfvhxtNcrOosUYLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3E0lvpcu; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1719481326;
	bh=SHwLopLsuJIvSoRHrncD2LhBaww5jF0LXUvXBdkPh1U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=3E0lvpcuKE3e8QWwPBbxCTgvq4PKGcEBnxcp5hOp+6ajKdBlRNPdDaoS3hHrqhDQ7
	 nzW/fNe8tpWt/LIzd6UbZ1XNDoA69KO+gO/J9V67FivqK1L36aWuw3VQeRNFRd5dAZ
	 p8NIH49Zi2UUhYPUSIKOTQtlHvxvrFLeFqHry0gBriPY+9tQKcNEjWoYL2q277JNgA
	 vDMTW+dkhAS+McRw/WDHQA5VJme406aOrY74HP6hC+Xoxtr9ZA/1Mb8rpIm9Pjlfbo
	 fTYi4vMa+0Es7GH9cZZsfZkvnn14hBXyPB7ayfQCtoJLLlLNUPedma4V+iNOUp3gs9
	 X3VFPzVcRWnhg==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 12E3E37821B3;
	Thu, 27 Jun 2024 09:42:06 +0000 (UTC)
Message-ID: <512e50d7-50ae-411c-bccd-656a74d740a3@collabora.com>
Date: Thu, 27 Jun 2024 11:42:05 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] PCI: mediatek-gen3: Add mtk_gen3_pcie_pdata data
 structure
To: Lorenzo Bianconi <lorenzo@kernel.org>, linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com, jianjun.wang@mediatek.com, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 linux-mediatek@lists.infradead.org, lorenzo.bianconi83@gmail.com,
 linux-arm-kernel@lists.infradead.org, krzysztof.kozlowski+dt@linaro.org,
 devicetree@vger.kernel.org, nbd@nbd.name, dd@embedd.com, upstream@airoha.com
References: <cover.1719475568.git.lorenzo@kernel.org>
 <62c00de24f702260ba0da93008277e95f471a2ab.1719475568.git.lorenzo@kernel.org>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <62c00de24f702260ba0da93008277e95f471a2ab.1719475568.git.lorenzo@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 27/06/24 10:12, Lorenzo Bianconi ha scritto:
> Introduce mtk_gen3_pcie_pdata data structure in order to define
> multiple callbacks for each supported SoC. This is a preliminary
> patch to introduce EN7581 PCIe support.
> 
> Tested-by: Zhengping Zhang <zhengping.zhang@airoha.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



