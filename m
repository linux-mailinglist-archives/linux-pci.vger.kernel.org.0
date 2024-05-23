Return-Path: <linux-pci+bounces-7799-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 296B08CDB3A
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 22:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 96779B21446
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 20:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3910584A4A;
	Thu, 23 May 2024 20:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nnLPKUm3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D37535D4;
	Thu, 23 May 2024 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716495113; cv=none; b=ZWDk8WSpVfCmImBffSxqy6R3qGSrMnbPr1DBMTJt6nd96lLjHgJ1CVpuvDPW+NvUekso4JYyjkxTNzYc9s3qWy5/8aAKiAn8w99W0RN1EPinXloDIBX5w35KLTk2Z4k9ywWNN4npLaHFpMz4IR4eeHHelx6A1doDnyRE8ZAzcrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716495113; c=relaxed/simple;
	bh=L5ewnBm0au4zZRec8wsDmkwZlTUy33ekVhMp0k9H0PI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y2ZqMJe+JdPZYFQorkQ0W9nFVTGTtGn/NtJMxs+VQgHXjtQqjBaHRyv+ciA84a9Hm/Cq0pVWfYr3KlNwMdYH/JU6XpOxzHGjILgm1HDuGf5i/D/Wc5ugh+uAChQhYELFZG3LPYtvTHy72iMhknDQGXayONyQgYjBKWWzWKNGc7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nnLPKUm3; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716495082; x=1717099882; i=markus.elfring@web.de;
	bh=pRrt2wpGj4VAOvQxf86gbLUKPEBUjoc/oQDX1mcPMrM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=nnLPKUm3Vpg1qLjBxzKs6SigfIsLW45WZfv7tTykVIbZJZxpRxmD57UIc+8apu2Q
	 GWV92ch6xSylxKrwvbWOQ+IR4UgH6+4PBxlYnNccYINYlklchd+8d0ZYrp7Q/9/mu
	 LVhXqP3N4Qxeo+xZY0LX6VNOa15KDq3PvY6Xj9ayi3oqcM0wVfmSNxaTtzkfEdpNY
	 ROdJk1wAhDAWKg7nup7ueR8ogHP71e7eaxmQXBiQi/Nw/eT6GT8K9cFigtLwjLB3R
	 BvsUiugkaxu3Zm1N2Z+N43k7skalpHsoFsGvwkcVeQtRHOItMjGiwmSTW+ii2gq7h
	 /K3PI6Lu251O5e1/Jg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.82.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqIB7-1sveY51FAJ-00nOnm; Thu, 23
 May 2024 22:11:22 +0200
Message-ID: <f541195e-7963-4970-9a1d-a3298226cdd5@web.de>
Date: Thu, 23 May 2024 22:11:20 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/7] PCI: xilinx-nwl: Clean up clock on probe
 failure/removal
To: Sean Anderson <sean.anderson@linux.dev>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <michal.simek@xilinx.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>
References: <20240520145402.2526481-6-sean.anderson@linux.dev>
 <4a43cda4-dfa4-4156-b616-75e740f6fd64@web.de>
 <bb9e239f-902b-4f52-a5e9-98c29b360418@linux.dev>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <bb9e239f-902b-4f52-a5e9-98c29b360418@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZfN0L4J/We1nysj/Tw4/FcDusZldTB3WhkeTmZfE668DhHbNZkY
 HOoeea/+aF1NKZetF41Uc9H+RW7VLFjgc7x7o6UUkCopGRHsnpbeznyyfJUbr3TXUM8MJ/z
 A8NenrGIAYjkotL14h15DYSBzFEtS3lpiEbPCZl2CHXS10ckSR7/C2wVxAeE4eMxytSx6tk
 ZywcrqoJnql1tcrThId1Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ylFft9ZDubI=;jo1fRE94B8Xtowztpq0sPRbsVf8
 1cr8nbdQN6GH688tqhMolPOOrpbgXQ59MikyI8c8RC5vdyJKqXsJ7EoLxLg+9DtQOxcmA8MvV
 wXtxqQ3m7Bzf8U1VXtn76lzcqOVUyUXMiHYHh3pn3KjksRDD8FgR9/apQgyZNifYO7FfHJ0My
 exLJzCmoFnWgCRpajwcFOOo0BXbXEGKEVZtLEo0d5rORAFirrXB1yHdohIFD+d9oSMCWYD5pO
 9YlBRRG6Y4HvgN9lkNA8yH4UUirUks/OEXaf2SPos8GCHRClQdiotaTUsK5j1FC4woB0Nkrnx
 PeIAVkuaJFqBdg69iRoAnk0aaDOkju03tjUQEw7s0LDPEMnwD1SjXgsK4D5qOdEOIUtFUBRoS
 sqVkKSHmeP6gWoN52EaYWPlsTFD0tTZkxaNBh7k5ltiIYKrXJiZENcPFzAGhaDs5qlxjINA90
 WMNhhJCJxSoCtTasXjN7Ia00uVC1FJXwSzQdfKqYnU/Lh5Xe8L2PyS2oEcN24+By7bkz5z87B
 EU/TRHkzH9joFtEk3YENeO6UobvGZOpEWsoJgTXCvfsAs4bP0KgAkFnNrckdPDq3KB18HLsCQ
 Pf5RhlqzaAjjkRp2OHtaNvg9qsDAMA90BTmnyo1t6y2xxEOYP+5qLhtR8w8FdI/FyajmLiNtb
 Q2oqlY1FeuycdXtU0J9OCtheAVL7aKijHsytMFt2fJZJAQK6wNnUVhKAFSCXmGdHqaV6NYGPr
 xaXARvKzsAQSTtwxmwllV8yHT4H2lmRHjs7+RTQRIdEG9Ojn9WvYsBY5J29ojiKJ6HpT3hj01
 UvWotxE2nBivOnnbCVgM4D8I5v60M2mP7XPhLqiMHZoe8=

>> =E2=80=A6
>>> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
>> =E2=80=A6
>>> @@ -817,11 +818,23 @@ static int nwl_pcie_probe(struct platform_device=
 *pdev)
>>>  		err =3D nwl_pcie_enable_msi(pcie);
>>>  		if (err < 0) {
>>>  			dev_err(dev, "failed to enable MSI support: %d\n", err);
>>> -			return err;
>>> +			goto err_clk;
>>>  		}
>>>  	}
>>>
>>> -	return pci_host_probe(bridge);
>>> +	err =3D pci_host_probe(bridge);
>>> +
>>> +err_clk:
>>> +	if (err)
>>> +		clk_disable_unprepare(pcie->clk);
>>
>> I suggest to use the label =E2=80=9Cdisable_unprepare_clock=E2=80=9D di=
rectly before this function call
>> (in the if branch) so that a duplicate check would be avoided after som=
e error cases.
>
> Well if you want to avoid a check, we can just do
>
> err =3D pci_host_probe(bridge);
> if (!err)
> 	return 0;
>
> err_clk:
> 	...

This design variant can also be reasonable.

Do any preferences matter here for label name selections?

Regards,
Markus

