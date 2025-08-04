Return-Path: <linux-pci+bounces-33345-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 751A1B19AE4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 06:50:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E543B5AEF
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 04:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DC161A83F9;
	Mon,  4 Aug 2025 04:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmkWlnDh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F1810E4;
	Mon,  4 Aug 2025 04:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754283049; cv=none; b=CaQORttuXUtIYh4q1RAYBXy/BL1m8wBABtW2Yjkzw15OaZg3SIDdQ7PlHzPOVi6LyXZyV/9YbWwFQxQ1VrhQwbus982yhnH7oLINGZDmjfL9K88rrteJcq2dYB7slzeIegiPFOSVQR7fJrz4YkhRbsv8oyXo7cpCJSP7VUQb+YI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754283049; c=relaxed/simple;
	bh=lH4buzDNUXIHUwd/vEAcXsWRPckSNqm7+MzMh4iVkzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bl//fYQd9YVYqAslQy0bonLIf9IkXSj9yPt52YpI37Bfhxgey1iRz5VCFGkvhkhjM5k8Zfwi0mj6HxxzM1ox0gtmRcyfntL2wP+x/S3mblPWUMvLebNptzfKyRRPtEvcyNtjQZzxDhrLLNtcXeIDciER6itRx8IxVokrSe67VsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmkWlnDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34B8C4CEE7;
	Mon,  4 Aug 2025 04:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754283048;
	bh=lH4buzDNUXIHUwd/vEAcXsWRPckSNqm7+MzMh4iVkzs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=qmkWlnDhmyORK08CG1GGDF2d3jo3LDjJVrgPAtHOvaYTQpdowKCsROXj+R3h12a/T
	 d/WdxXkuCcLflY4sx52O0UINvEDCXQQkOYnM/Y1DH7ES6Ljsh0bEegf22MOhZ7lEnC
	 8X97EmW8+NMH0WaVq83YonaFFjw0csk47HVxYkQ7xPGxXe5WFF1zZZtowR7a8BnxX5
	 lYErMEqPPscBNZk50TwzsK4g9wkENTxrYZi+ao1uOwiAwfE2YyPt0vgBuB4Iek3pQa
	 5RJECIpKwu0/OvI7P2pQ+1V/6Zh7lKxwvZ6QGHKO60zkDXyC+vflxxKBqzdzH2NzgX
	 T2jhamAvI9gxg==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 24/38] arm64: CCA: Register guest tsm callback
In-Reply-To: <20250730152613.00006693@huawei.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-25-aneesh.kumar@kernel.org>
 <20250730152613.00006693@huawei.com>
Date: Mon, 04 Aug 2025 10:20:41 +0530
Message-ID: <yq5att2n8zby.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonathan Cameron <Jonathan.Cameron@huawei.com> writes:

> On Mon, 28 Jul 2025 19:22:01 +0530
> "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
>
>> Register the TSM callback if the DA feature is supported by RSI.
>>=20
>> Additionally, adjust the build order so that the TSM class is created
>> before the arm-cca-guest driver initialization.
>>=20
>> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
> See below.
>
>> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
>> index bf9ea99e2aa1..ef06c083990a 100644
>> --- a/arch/arm64/kernel/rsi.c
>> +++ b/arch/arm64/kernel/rsi.c
>> @@ -15,6 +15,7 @@
>>  #include <asm/rsi.h>
>>=20=20
>>  static struct realm_config config;
>> +static unsigned long rsi_feat_reg0;
>>=20=20
>>  unsigned long prot_ns_shared;
>>  EXPORT_SYMBOL(prot_ns_shared);
>> @@ -22,6 +23,12 @@ EXPORT_SYMBOL(prot_ns_shared);
>>  DEFINE_STATIC_KEY_FALSE_RO(rsi_present);
>>  EXPORT_SYMBOL(rsi_present);
>>=20=20
>> +bool rsi_has_da_feature(void)
>> +{
>> +	return !!u64_get_bits(rsi_feat_reg0, RSI_FEATURE_REGISTER_0_DA);
>
> !! not needed.
>
>> +}
>> +EXPORT_SYMBOL_GPL(rsi_has_da_feature);
>
>
>> diff --git a/drivers/virt/coco/arm-cca-guest/arm-cca.c b/drivers/virt/co=
co/arm-cca-guest/arm-cca.c
>> index 547fc2c79f7d..3adbbd67e06e 100644
>> --- a/drivers/virt/coco/arm-cca-guest/arm-cca.c
>> +++ b/drivers/virt/coco/arm-cca-guest/arm-cca.c
>> @@ -1,6 +1,6 @@
>
>>  static int cca_guest_probe(struct platform_device *pdev)
>>  {
>>  	int ret;
>> @@ -200,11 +256,22 @@ static int cca_guest_probe(struct platform_device =
*pdev)
>>  		return -ENODEV;
>>=20=20
>>  	ret =3D tsm_report_register(&arm_cca_tsm_report_ops, NULL);
>> -	if (ret < 0)
>> +	if (ret < 0) {
>>  		pr_err("Error %d registering with TSM\n", ret);
>> +		goto err_out;
>> +	}
>>=20=20
>>  	ret =3D devm_add_action_or_reset(&pdev->dev, unregister_cca_tsm_report=
, NULL);
>> +	if (ret < 0) {
>> +		pr_err("Error %d registering devm action\n", ret);
>> +		unregister_cca_tsm_report(NULL);
>> +		goto err_out;
>> +	}
>> +
>> +	if (rsi_has_da_feature())
>> +		ret =3D cca_tsm_register(pdev);
> Why do we not need to call unregister_cca_tsm_report()
> if this fails?
>

`tsm_report` and DA are independent functionalities. I=E2=80=99ll update the
guest probe to return success so that `tsm_report` remains available
even if the DA tsm registration fails.

-aneesh

