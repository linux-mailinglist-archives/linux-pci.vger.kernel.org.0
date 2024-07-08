Return-Path: <linux-pci+bounces-9944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0983A92A6B1
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 18:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AFF1B2236A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 16:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8244778C99;
	Mon,  8 Jul 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k86mSvuD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C73C1EA6F;
	Mon,  8 Jul 2024 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720454474; cv=none; b=NLwOhPG/4uB2iZMSi2k5Ytb9ard83wWi1Qn3iLOd99tBe7YDzRDZVOg8/0kRAmRxvxV/Oda8GOeA/7dhyz07pAv64fT9RD+M8fLTb+o6SNqGOGwBhXa4fFZrve3mkgWq/y0gDlppMaIciskrCO5v5FN7esxsii73fHdaeOp4Fgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720454474; c=relaxed/simple;
	bh=I0c/LK8KrZzZFHZcOEqRu28OsPSObo3IAzNk0eUwkQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ML051E38YmLcsRSEoD2YmnClSxLqVBYnwg6sk3jf0OQc+JfJtU6gnfUdBzkoYi9wcu4OHFiG25RXra44hMwF7Gj6Cn5Qd0lszJaNRLZwenoj8Now165btEPuzeb8cYGMac2/r4GwYZ9cH6xx4NNbnZBAuE5r9/zNKiMsqkUSXdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k86mSvuD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A995C116B1;
	Mon,  8 Jul 2024 16:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720454474;
	bh=I0c/LK8KrZzZFHZcOEqRu28OsPSObo3IAzNk0eUwkQ4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=k86mSvuDac5y3aLfYN7mRyoU0IBxkdcBVw1ZKegWSjWlcCMtgxdVOXIxvc3mKrZp8
	 t9h/DhnBaKdKNdeNhxx/W34Gfj1cdDSdAFGHqUpuK7/heTNIBAEVaM5FQrf+KqeHvf
	 CmnxWL5o50kwp4x8QmZGmDkkXUHyIXdee1ELMdDvtffUyxUSc7NPeTVs51RVlhfUT4
	 mBvwq21FzWzRnqL1CSzsEdxJfagGi2vZF8tvGMM6kcSiqpEnOcf4LKW61TnZPmT6VF
	 UBggMeX8fDz2QN9FCPuWgrWIBIJP8DwUaHl1jMfspTctSSTS03D+B4bj3X7QYwuxEg
	 NCc+HcBq11DJw==
Message-ID: <81a93b15-2791-4eec-8164-f141fae9a5f1@kernel.org>
Date: Mon, 8 Jul 2024 11:01:12 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Lukas Wunner <lukas@wunner.de>, Bert Karwatzki <spasswolf@web.de>,
 caleb.connolly@linaro.org, bhelgaas@google.com, amit.pundir@linaro.org,
 neil.armstrong@linaro.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Praveenkumar Patil <PraveenKumar.Patil@amd.com>
References: <20240707183829.41519-1-spasswolf@web.de>
 <Zoriz1XDMiGX_Gr5@wunner.de> <20240708003730.GA586698@rocinante>
 <CACMJSevHmnuDk8hpK8W+R7icySmNF8nT1T9+dJDE_KMd4CbGNg@mail.gmail.com>
 <20240708083317.GA3715331@rocinante>
 <6e57dbc0-f47a-464e-af6b-abd45c450dc6@kernel.org>
 <CACMJSetAKtPp_Gua2S7m_+aC-f9HSUyfF1YoHUPdtcibLtQxpA@mail.gmail.com>
 <20240708154401.GD5745@thinkpad>
 <664619a9-c80f-4f81-b302-b9c5258b5e0e@kernel.org>
 <CAMRc=Mf2pE5JVHzcntO5b+5so_=ekuHGzrY=xJpKatURJFpGZA@mail.gmail.com>
 <8838b5c3-0c51-42f6-9842-186139822be7@kernel.org>
 <CAMRc=MdHSsctXYor2ycWqRJHCUciweRTie_TjW9h0yfN7wZhOA@mail.gmail.com>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <CAMRc=MdHSsctXYor2ycWqRJHCUciweRTie_TjW9h0yfN7wZhOA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/8/2024 10:58, Bartosz Golaszewski wrote:
> On Mon, Jul 8, 2024 at 5:53 PM Mario Limonciello <superm1@kernel.org> wrote:
>>
>> On 7/8/2024 10:49, Bartosz Golaszewski wrote:
>>
>>>
>>> If you have CONFIG_OF enabled then of_platform_populate() will go the
>>> normal path and actually try to populate sub-nodes of the host bridge
>>> node. If there are no OF nodes (not a device-tree system) then it will
>>> fail.
>>>
>>> Bart
>>
>> So how about keep both patches then?
> 
> No, it doesn't make sense. If CONFIG_OF is enabled then -ENODEV is a
> valid error. I was wrong to apply the previous patch as it would lead
> to hiding actual errors on OF-enabled systems.
> 
> Bart

Got it; thanks.

