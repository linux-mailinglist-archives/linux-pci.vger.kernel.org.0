Return-Path: <linux-pci+bounces-20212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DF1A1861F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 21:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C114188BEC7
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jan 2025 20:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53B31F540D;
	Tue, 21 Jan 2025 20:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXTbDmS6"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D691B808;
	Tue, 21 Jan 2025 20:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737491477; cv=none; b=GBZjLSJyRvUJX5TEFHM6YykWMAKp6FfrypiN6wMc6lZZMhn4e+PoGn+b6fQQqdhAmm+A9KeV0EAg7xnpsqhG8bitCKT6NGwsC45t1TUI9Ex6bhg+8nLLJRypr+BLD6REGHl5uyx2S5SSA3sdeMEosAacldnGAQozt3H4HtOaiaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737491477; c=relaxed/simple;
	bh=0hsTeL52tYYLd7VdgM+3sSM1hLDtf1kuV0EiPZWb700=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=UsUIsGnQ8+PBu3PpAYAhSE0j+MPiZPdtInqeNG/BGfs5OcATJhAGyQl2bl1hbWC0P5zzp1RjcUheHuzjKopILiAlAJSJLuWkBpDf5Nrnv8SsrNaQgIuoGLvrczsJr6mnxlHdDrLZETVOIt03cIaaCvptNLUR++H99QKbVszE3dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXTbDmS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C49C4CEDF;
	Tue, 21 Jan 2025 20:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737491475;
	bh=0hsTeL52tYYLd7VdgM+3sSM1hLDtf1kuV0EiPZWb700=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=nXTbDmS6GaaV7QGWAruZCOp1Ub9BW0NOmTPEAQIjK2swERHP0Ae9EAg/0s8UEepee
	 TTz8K4YRrL2tiL+B+ByrAAPs4XvmMXWHRCZu8AOm5VroZYRaHnpCjRxaRenddy0lCY
	 wMqnpK1EdQlPyN8dIsiI+v1RV/GwDVm3PvgJ+GS9u/4EuMJaUGdte4BON76TjHSBv7
	 J8iGYBxWPE5lwXPZNzcb0aoosxGOLSf3DEbTS/d6wbfSAPh3rcwLhADsqCQP0ccQap
	 XNLxt1Tk3t2kxTzYG+Yf6IwlKs+GlqS1t7WeWx/dXzc4OF/EpNBp92mygE0ZrUtz9y
	 alcOTWgicLHBA==
Date: Tue, 21 Jan 2025 21:31:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jon Hunter <jonathanh@nvidia.com>, Hans Zhang <18255117159@163.com>,
 manivannan.sadhasivam@linaro.org
CC: kw@linux.com, kishon@kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 rockswang7@gmail.com,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>
Subject: Re: [v11 2/2] misc: pci_endpoint_test: Fix overflow of bar_size
User-Agent: K-9 Mail for Android
In-Reply-To: <7474af29-2995-48f6-830b-a23dad2d2bd1@nvidia.com>
References: <20250109094556.1724663-1-18255117159@163.com> <20250109094556.1724663-3-18255117159@163.com> <7474af29-2995-48f6-830b-a23dad2d2bd1@nvidia.com>
Message-ID: <87FA054A-053E-4E73-94D7-CB9F4F655053@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 21 January 2025 18:46:43 CET, Jon Hunter <jonathanh@nvidia=2Ecom> wrote=
:
>Hi Hans,
>
>On 09/01/2025 09:45, Hans Zhang wrote:
>> With 8GB BAR2, running pcitest -b 2 fails with "TEST FAILED"=2E
>>=20
>> The return value of the `pci_resource_len` interface is not an integer=
=2E
>> Using `pcitest` with an 8GB BAR2, the bar_size of integer type will
>> overflow=2E
>>=20
>> Change the data type of bar_size from integer to resource_size_t, to fi=
x
>> the above issue=2E
>>=20
>> Signed-off-by: Hans Zhang <18255117159@163=2Ecom>
>> Suggested-by: Niklas Cassel <cassel@kernel=2Eorg>
>> Reviewed-by: Niklas Cassel <cassel@kernel=2Eorg>
>> ---
>> Changes since v10:
>> https://lore=2Ekernel=2Eorg/linux-pci/20250108080951=2E1700230-3-182551=
17159@163=2Ecom/
>>=20
>> - Replace do_div with the div_u64 API=2E
>>=20
>> Changes since v8-v9:
>> https://lore=2Ekernel=2Eorg/linux-pci/20250104151652=2E1652181-1-182551=
17159@163=2Ecom/
>>=20
>> - Split the patch=2E
>>=20
>> Changes since v4-v7:
>> https://lore=2Ekernel=2Eorg/linux-pci/20250102120222=2E1403906-1-182551=
17159@163=2Ecom/
>>=20
>> - Fix 32-bit OS warnings and errors=2E
>> - Fix undefined reference to `__udivmoddi4`
>>=20
>> Changes since v3:
>> https://lore=2Ekernel=2Eorg/linux-pci/20241221141009=2E27317-1-18255117=
159@163=2Ecom/
>>=20
>> - The patch subject were modified=2E
>>=20
>> Changes since v2:
>> https://lore=2Ekernel=2Eorg/linux-pci/20241220075253=2E16791-1-18255117=
159@163=2Ecom/
>>=20
>> - Fix "changes" part goes below the --- line
>> - The patch commit message were modified=2E
>>=20
>> Changes since v1:
>> https://lore=2Ekernel=2Eorg/linux-pci/20241217121220=2E19676-1-18255117=
159@163=2Ecom/
>>=20
>> - The patch subject and commit message were modified=2E
>> ---
>>   drivers/misc/pci_endpoint_test=2Ec | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/misc/pci_endpoint_test=2Ec b/drivers/misc/pci_endp=
oint_test=2Ec
>> index f78c7540c52c=2E=2E0f6291801078 100644
>> --- a/drivers/misc/pci_endpoint_test=2Ec
>> +++ b/drivers/misc/pci_endpoint_test=2Ec
>> @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pc=
i_endpoint_test *test,
>>   static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
>>   				  enum pci_barno barno)
>>   {
>> -	int j, bar_size, buf_size, iters;
>> +	int j, buf_size, iters;
>>   	void *write_buf __free(kfree) =3D NULL;
>>   	void *read_buf __free(kfree) =3D NULL;
>>   	struct pci_dev *pdev =3D test->pdev;
>> +	resource_size_t bar_size;
>>     	if (!test->bar[barno])
>>   		return false;
>> @@ -307,7 +308,7 @@ static bool pci_endpoint_test_bar(struct pci_endpoi=
nt_test *test,
>>   	if (!read_buf)
>>   		return false;
>>   -	iters =3D bar_size / buf_size;
>> +	iters =3D div_u64(bar_size, buf_size);
>>   	for (j =3D 0; j < iters; j++)
>>   		if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * j,
>>   						 write_buf, read_buf, buf_size))
>
>
>This change breaks building the kernel with GCC v7 and I see =2E=2E=2E
>
>ERROR: modpost: "__aeabi_uldivmod" [drivers/misc/pci_endpoint_test=2Eko] =
undefined!
>ERROR: modpost: "__aeabi_ldivmod" [drivers/misc/pci_endpoint_test=2Eko] u=
ndefined!
>
>I know that this is an old GCC version, but this is a farm builder and th=
e kernel still indicates that GCC v5=2E1 is still supported [0]=2E
>

Hmm=2E=2E div_u64() should work on gcc 5=2E1=2E

Out of curiosity, is there any difference if you add:

#include <linux/math64=2Eh>
to
drivers/misc/pci_endpoint_test=2Ec ?


Kind regards,
Niklas

