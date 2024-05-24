Return-Path: <linux-pci+bounces-7819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 114FF8CE829
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 17:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BD9B22A10
	for <lists+linux-pci@lfdr.de>; Fri, 24 May 2024 15:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6404E12C558;
	Fri, 24 May 2024 15:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="n7IxgBTS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7012C462;
	Fri, 24 May 2024 15:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716564999; cv=none; b=F1RCM7z5x68yc+ig0vRhYRyDCvnVeYOhsZ8M0FCUWM12u/lSvBGVv3uyNLWe/9ofND1m+YKgfGBNwLntC+c8zGtZGrdxstAtML5VsEoV+iuK7RD4HaLvolMgOH4lHx0y3PGJUL8K9QRhmeKevPMyU5j+T2GFxrJMU77P8mrmxmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716564999; c=relaxed/simple;
	bh=BTkrqG5m/TTiVu6LqJP5g2aggKorDUogMn333Zc5T6M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KIyJxzGppw4ZY1zryckQ9uGnjc8RHNuxf20KbeOqvwvmi5egO1Oeb3mJRCs8/OlZuHbjsKjHLW+J3U57UJ8FTa7QlOlzaJBoYdvQvGAZza+U8IbyHYdXCjfRaa982Gu3AwrRU05LUwvfnCXvxGqzdBcmcQcF8XvrTKChXXvWDVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=n7IxgBTS; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716564943; x=1717169743; i=markus.elfring@web.de;
	bh=EgHVt4XXKFDHUxcOb8J/XG57mTgDTrmuiUOaJp+R4ME=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=n7IxgBTSf+tr3P1HeACzL6MdWey6JSwkcy5D6it6Q2xFqxxwcLpRKsjgCnmYII4E
	 tmHvAjw4gJ4XvozXycpkuCK8/q5+Y+sAs0hKRnr5Z4ssTCTeO7bainwf0a2eFUCZI
	 tfMhwBDDW/Wh/xdGebO1ip3mdB92S88Bn8f4VZMuZ8lIekZ49mxVjO6S6A9wEk+Yu
	 c8CFvQb9ON2i2TBaD8o2ja1qfccUuPJvkLPgwkhogU0Fa/VQnMWz0IugpCyIG2y1g
	 y/rprAMxO3eLAncHAoyodzINV+EUimmLEafBhPNApptqBAYmBiiA42r07L9rq16v0
	 uftn/l8SdO3+GIODbg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MRW2R-1rpxfe2uAP-00NRSf; Fri, 24
 May 2024 17:35:43 +0200
Message-ID: <986ff09f-212c-4905-ab06-35f85e20e9cf@web.de>
Date: Fri, 24 May 2024 17:35:42 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] PCI: xilinx-nwl: Add phy support
To: Sean Anderson <sean.anderson@linux.dev>,
 linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 kernel-janitors@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Rob Herring <robh@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
 Michal Simek <michal.simek@amd.com>, Michal Simek <michal.simek@xilinx.com>,
 Thippeswamy Havalige <thippeswamy.havalige@amd.com>
References: <20240520145402.2526481-7-sean.anderson@linux.dev>
 <89d6acd5-5008-4db3-927c-d267be7b9302@web.de>
 <ad8da38a-5e3d-4f79-8744-66acf73703af@linux.dev>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ad8da38a-5e3d-4f79-8744-66acf73703af@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gJUJXEMKQUFiGMbz3M0ULlfnyt+9fEzK7WHHYjcz9PovLiekA76
 3fzZ94GZ7nQqGyDmFujanLgy9qs89MbW4Os4YDoKEN00r5QVjF90AxH1vrQnuohvhK1fK7u
 pWMeSZdqsoN/S4ufLdKyUAaVcOg7mpGxr7aVW+eVoxb6DABUNfd2Rjavhepc6lfYBzOCdUB
 qZ+VoW4fGZxSFkH28HPww==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:MffDudX7RIU=;LNJIor3P3ZYNHqEcGfIy6j9Lgy6
 0ofHhn7tENA9tLTqn5f0/ErUO2saZZAXoqkaUVV2vMXi9g614R+lzhHND5AlbkWRQ5P+XffbM
 LPqvQdqUuvpr+7ThPrU03huvlxdt/lzBxHGUIsEqKoUTEZaW0MEuJCwqrgnO8AnqugT0toa8N
 K/pQ/b2nMNH5MTUvg6URusq+HGAmAVSijgS4lAcqGpanTAzxQgIG6k5+P6EK54Cm097x36fTM
 Jrm/Tz07jXCg6BAG4mTamJEkXL59La8c61pCrANqdFHzIe+KatTb5KUL4qcNfcUTxB4uJThu3
 o5st+PwGb9sKVYJYi1TRb7Nm+GuRXpGbZK61sY/7b44cy2TuTP3S3o5IMJ31aQ4N2jn9u8kDT
 s49f7AT1Fdz/WQ92/7ktxlGornX9FwHV8+OZS2zXbweDoCWd1qfy1vmff5QCsV9peTTt6Of1z
 aHGerICR3unzQbW0Ni8S6JfBBTiPtZJIqw6DvCpLJ3QReoggZqc3QvyBDJPqE9Ez3pQEHnfio
 Gwwfpc1asFqPfsUywG0aN5mAwieHazvvmclqmRJaKTxXmNZWZvXhrrLFeKf0VrnyZa5YlLCkJ
 ojIxClLIlECffR5lGba9gi2T46dKk7anjNOsgIicHL6n5JutVaWGCd4p4246+/yy9Y8azy3M/
 8jY90GG0ZV0tEFboR0EaOszFd0Mldfi5ZRE1ozu672KL/X7Sn5R5RDZT9kU7su/T2akSXs2HQ
 MFbnICx8g9x8bzwYA3vfN0ncYxLVLWRiifIROUw9uYaSuEj7YuizJxUNs0EXvXjcJQEfL2yp9
 EynXqyShjC90/zScnvTJUGKTLPVv1qGNFun7EKSamaJdU=

>> =E2=80=A6
>>> +++ b/drivers/pci/controller/pcie-xilinx-nwl.c
>> =E2=80=A6
>>> @@ -818,12 +876,15 @@ static int nwl_pcie_probe(struct platform_device=
 *pdev)
>>>  		err =3D nwl_pcie_enable_msi(pcie);
>>>  		if (err < 0) {
>>>  			dev_err(dev, "failed to enable MSI support: %d\n", err);
>>> -			goto err_clk;
>>> +			goto err_phy;
>>>  		}
>>>  	}
>>>
>>>  	err =3D pci_host_probe(bridge);
>>>
>>> +err_phy:
>>> +	if (err)
>>> +		nwl_pcie_phy_disable(pcie);
>>>  err_clk:
>>>  	if (err)
>>>  		clk_disable_unprepare(pcie->clk);
>>
>> I got the impression that some source code adjustments should be perfor=
med
>> in another separate update step for this function implementation.
>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree=
/Documentation/process/submitting-patches.rst?h=3Dv6.9#n81
>>
>> You propose to extend the exception handling here.
>> Does such information indicate a need for another tag =E2=80=9CFixes=E2=
=80=9D?
>
> Huh? I am only disabling what I enabled...

* Was a resource deactivation accidentally missing in a previous release
  of this software component?

* Can repeated checks be avoided a bit more by a design approach which we =
tried
  to clarify for the update step =E2=80=9C[PATCH v3 5/7] PCI: xilinx-nwl: =
Clean up clock
  on probe failure/removal=E2=80=9D?
  https://lore.kernel.org/lkml/bb9e239f-902b-4f52-a5e9-98c29b360418@linux.=
dev/


Regards,
Markus

