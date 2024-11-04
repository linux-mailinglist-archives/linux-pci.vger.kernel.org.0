Return-Path: <linux-pci+bounces-15951-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B79BB574
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 14:10:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DEEA1C210B8
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2024 13:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BEC1B81C1;
	Mon,  4 Nov 2024 13:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="GbGCE6C8"
X-Original-To: linux-pci@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D691B6CFB;
	Mon,  4 Nov 2024 13:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730725829; cv=none; b=lyRnO+PT8WZtCSBYf2MPL8bFS31D4D5+RJjT8KDoBJs64YPauR/jnpYW6X0VRgmt16YwBDufQhaWdA5W2fgDmXNCGix1KrMnsu5hZz21ksTlT2R5S6bBPN2xa1CKU5oby60BqCHdtitWXm7fTpQCA2RHCoQa9nqjDI843ZgDti0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730725829; c=relaxed/simple;
	bh=9HrB0hRfb9MPWXWPeZXQEXRRgtlF7QfDTCZF/aQwKS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfrIXc+jXmpZcP9PJlqG4nbXQa6in6pJdUYw2He6RzDFi/GEKJeRKVSRQcFbYBRmoxrII/8Q5mlTfyiKsPkbfUa58Rm+rh29H6VMMt3WJvTvNsoa06MVLr91ThuxKZf3gRO/4+UsBoSoS0PmAYw5b3DwHi5udKgjQ/e8V6B9ikQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=GbGCE6C8; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1730725823;
	bh=9HrB0hRfb9MPWXWPeZXQEXRRgtlF7QfDTCZF/aQwKS8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GbGCE6C8wudOGBSfu79muvMfKAR2yVIJY6fKZ3raaCqVJIaEX6fTCGnObJv5S9xT/
	 LVcV69AQ/8Ic/fjsFUkOGpfUa3ye/hkVUzvgxHf635JfVvPj5givJN5R5OfiwMp2og
	 oaMIEKQMW9AhQOWlVCztjeRseIPGGqaMZNn1ZUxi0LSKrqvvhbl+PFidY8kbPL9EkL
	 gzC73UaJQr/1jJgT+Q1E8BDKjvymTZgHsGT1U2WBKNzN2cyPugLZUWGYIekG3XEJFQ
	 Ni+VH9w3FQR2vuUZVrhyehfa3m76omIpOFcT3SmARcIwp93kKL4J75Yj1VI9Y74iFI
	 1uM9UR5RxPozA==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3BBBB17E3630;
	Mon,  4 Nov 2024 14:10:23 +0100 (CET)
Message-ID: <f8ca0f82-2851-40d9-983b-2a143b44263a@collabora.com>
Date: Mon, 4 Nov 2024 14:10:22 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] PCI: mediatek-gen3: Add support for setting
 max-link-speed limit
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org
Cc: ryder.lee@mediatek.com, jianjun.wang@mediatek.com, lpieralisi@kernel.org,
 robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com,
 linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
 fshao@chromium.org, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
References: <20241104114935.172908-1-angelogioacchino.delregno@collabora.com>
 <20241104114935.172908-2-angelogioacchino.delregno@collabora.com>
 <D5DF0QIO2UZQ.29U999LYCC05M@rocinante>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <D5DF0QIO2UZQ.29U999LYCC05M@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Il 04/11/24 14:06, Krzysztof Wilczyński ha scritto:
> Hello,
> 
>> +	if (err > 0) {
> 
> You could drop > 0 here.
> 

I have no strong opinions about that, would be fine for me.

>> +		/* Get the maximum speed supported by the controller */
>> +		max_speed = mtk_pcie_get_controller_max_link_speed(pcie);
>> +
>> +		/* Set max_link_speed only if the controller supports it */
>> +		if (max_speed >= 0 && max_speed <= err) {
>> +			pcie->max_link_speed = err;
>> +			dev_dbg(pcie->dev,
>> +				"Max controller link speed Gen%d, override to Gen%u",
>> +				max_speed, pcie->max_link_speed);
>> +		}
>> +	}
> 
> I wonder if this debug message would be better served as a warning to let
> the user know that the speed has been overridden due to the platform
> limitation.  Thoughts?
> 
> Also, there is no need to sent a new series if you fine with the
> suggestions.  I will mend the code on the branch when applying.
> 

A warning seems to be a bit too much and would appear like something to worry
about (or something unintended)...

Perhaps a dev_info() would work better here?

Thanks,
Angelo

> 	Krzysztof




