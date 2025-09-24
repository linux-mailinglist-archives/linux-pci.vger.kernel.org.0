Return-Path: <linux-pci+bounces-36842-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41C9BB98F0D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 10:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90F1189E6BE
	for <lists+linux-pci@lfdr.de>; Wed, 24 Sep 2025 08:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654A4289E0B;
	Wed, 24 Sep 2025 08:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="LpBW/jDl"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7261B423C;
	Wed, 24 Sep 2025 08:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758703236; cv=none; b=BX+HpuHIwlISczmq0nL4ZictgvcWUvwMQ/8NEA1X4Z+ZbxhS3zxdX8ox7tlHFmX89voiTAKZ/lP6ul2NedKNZBqMrsz18ZAdRGIpAN+aM9a2YzlZUdGygU7g46Owde3bk1nvNS6vjGaWpuWA87j9zsUSt8wb8C52jRXrDpjXARI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758703236; c=relaxed/simple;
	bh=GBBy8OfUbS037/v/HVudu6cAjDC718OOGqsKe4ghfXA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=lHyVv/WRIHHO+pZ88mDTsCvYebMjVHPMSYdKkB3hUKTK1NAoaLc5cYWkbDMAJY33V3wL71hTZtzM/D9xox5ZYDVO2peKbgsVQQk6Mz3VTKKicBA5pRIeosaYXat1JEJNfchtl3VkYi8O/JFkn7nBR3u1mCwBPgPLq9nwEfxLmW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=LpBW/jDl; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1758703232;
	bh=GBBy8OfUbS037/v/HVudu6cAjDC718OOGqsKe4ghfXA=;
	h=Date:Subject:From:To:References:In-Reply-To:From;
	b=LpBW/jDlmidfKvgjk/Z26EZJxIP98EgnR+TEYeFA7JUWlAv9iriMFLrqgjsczXMM0
	 Ik56f0Zb1kcH4wtkAqogIsPerYyhy0Wmw9er2p3GivQm3kU7Ix9XfhAS7u/b7oX31p
	 14fES58bZCzydYZt7j4n8WfsvrwwpKzoClzAOO9hdiIfA8lReMzYlMD9uLVVR3YUpk
	 cjykWly8FciQeHL+jbVoheOAZBE49jJ5N7y/z4G+U4hBpAjn3ze+kMnlFAslKlspR1
	 brIg2AxEDJk3cVhvfARAzf5k2gAVQxqmXbis/pOssJBX2LfjC9r9RairVB6KqQuH3C
	 6202ZCZIo+h7Q==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E76C817E0237;
	Wed, 24 Sep 2025 10:40:31 +0200 (CEST)
Message-ID: <18af5a93-e5b1-45fa-b942-47c6c3cd5ddb@collabora.com>
Date: Wed, 24 Sep 2025 10:40:31 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: PCI: mediatek-gen3: Add support for
 Airoha AN7583
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
 Ryder Lee <ryder.lee@mediatek.com>, Jianjun Wang
 <jianjun.wang@mediatek.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>,
 linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, upstream@airoha.com
References: <20250923190711.23304-1-ansuelsmth@gmail.com>
 <5613a7f0-c624-46ca-9c65-1b48b4e3e3bd@collabora.com>
Content-Language: en-US
In-Reply-To: <5613a7f0-c624-46ca-9c65-1b48b4e3e3bd@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 24/09/25 10:36, AngeloGioacchino Del Regno ha scritto:
> Il 23/09/25 21:06, Christian Marangi ha scritto:
>> Introduce Airoha AN7583 SoC compatible in mediatek-gen3 PCIe controller
>> binding.
>>
>> This differ from the Airoha EN7581 SoC by the fact that only one Gen3
>> PCIe controller is present on the SoC.
>>
>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>> ---
>> Changes v2:
>> - Fix alphabetical order
>>
>>   .../bindings/pci/mediatek-pcie-gen3.yaml      | 21 +++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml b/ 
>> Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
>> index 0278845701ce..1ca9594a9739 100644
>> --- a/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
>> +++ b/Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml
>> @@ -58,6 +58,7 @@ properties:
>>             - const: mediatek,mt8196-pcie
>>         - const: mediatek,mt8192-pcie
>>         - const: mediatek,mt8196-pcie
>> +      - const: airoha,an7583-pcie-gen3
> 
> In the previous review, I also asked you to change the compatible string to be
> consistent with the others.
> 
> airoha,an7583-pcie

I have just seen the other series where you add AN7583 to the GEN2 PCIe controller
driver; this means that this SoC has two controllers, one GEN2 and one GEN3.

The compatible string inconsistency is therefore acceptable.

Please, though - add this information in the commit message, saying that the new
string is inconsistent with the others and explain the reason.

After which,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



