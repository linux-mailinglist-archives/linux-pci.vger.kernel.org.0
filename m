Return-Path: <linux-pci+bounces-23738-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6977DA61070
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 12:55:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57DA3BC292
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 11:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 228771FCFDB;
	Fri, 14 Mar 2025 11:54:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE68635A;
	Fri, 14 Mar 2025 11:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953298; cv=none; b=YvBNFI8GvmPcQIclw2GrwSTd6L2dFTnv1ZogGghq4PDcDPSiqYPi3N1oUmD0qW2M+ZZ8noLlJKXi9NpRwFL+dYkc+FflFcv0a0Hpo9e30hzia+w0R0LCi7s015khIWK/sUTV1TMrQThE5Y0DthMaa9hHn7uKWRaNXuQxl2DCkx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953298; c=relaxed/simple;
	bh=ujXCNmb3soiv158J2dofpbfmDTJEFnQWHbM9oC1cpcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=q3IuwRndTBLXsyxhKz4XemfpbDgJ/NKE2IexnicpHvTGJgU/WmtbeLxdqOCaYGWryxxHCO9Aslytm1/Mcc35QpYcgz5ZTduKDjpqJ57FQ43uMhMvhf4O5bg8eV/qzH8I1o12dKOizYjq9dL/dBIQARM/IjkTbCiludCIzWbZvSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.43] (g43.guest.molgen.mpg.de [141.14.220.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1345161E64856;
	Fri, 14 Mar 2025 12:54:23 +0100 (CET)
Message-ID: <dd9d62d5-54fc-4e7e-8508-1b8e22ac28d5@molgen.mpg.de>
Date: Fri, 14 Mar 2025 12:54:22 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux logs new warning `gpio gpiochip0:
 gpiochip_add_data_with_key: get_direction failed: -22`
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, brgl@bgdev.pl,
 linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, regressions@lists.linux.dev
References: <9ded85ef-46f1-4682-aabd-531401b511e5@molgen.mpg.de>
 <CAMRc=McJpGMgaUDM2fHZUD7YMi2PBMcWhDWN8dU0MAr911BvXw@mail.gmail.com>
 <36cace3b-7419-409d-95a9-e7c45d335bef@molgen.mpg.de>
 <CAMRc=Mf-ObnFzau9OO1RvsdJ-pj4Tq2BSjVvCXkHgkK2t5DECQ@mail.gmail.com>
 <a8c9b81c-bc0d-4ed5-845e-ecbf5e341064@molgen.mpg.de>
 <CAMRc=MdNnJZBd=eCa5ggATmqH4EwsGW3K6OgcF=oQrkEj_5S_g@mail.gmail.com>
 <CACRpkdZbu=ii_Aq1rdNN_z+T0SBRpLEm-aoc-QnWW9OnA83+Vw@mail.gmail.com>
 <Z78ZK8Sh0cOhMEsH@black.fi.intel.com> <Z78bUPN7kdSnbIjW@black.fi.intel.com>
 <CACMJSevxA8pC2NTQq3jcKCog+o02Y07gVgQydo19YjC9+5Gs6Q@mail.gmail.com>
 <Z78jjr8LMa165CZP@smile.fi.intel.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <Z78jjr8LMa165CZP@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andy, dear Bartosz,


Am 26.02.25 um 15:22 schrieb Andy Shevchenko:
> On Wed, Feb 26, 2025 at 03:14:24PM +0100, Bartosz Golaszewski wrote:
>> On Wed, 26 Feb 2025 at 14:47, Andy Shevchenko wrote:
>>> On Wed, Feb 26, 2025 at 03:37:47PM +0200, Andy Shevchenko wrote:
>>>> On Tue, Feb 25, 2025 at 10:25:00PM +0100, Linus Walleij wrote:
>>>>> On Mon, Feb 24, 2025 at 9:51 AM <brgl@bgdev.pl> wrote:
>>>>>
>>>>>> In any case: Linus: what should be our policy here? There are some pinctrl
>>>>>> drivers which return EINVAL if the pin in question is not in GPIO mode. I don't
>>>>>> think this is an error. Returning errors should be reserved for read failures
>>>>>> and so on. Are you fine with changing the logic here to explicitly default to
>>>>>> INPUT as until recently all errors would be interpreted as such anyway?
>>>>>
>>>>> Oh hm I guess. There was no defined semantic until now anyway. Maybe
>>>>> Andy has something to say about it though, it's very much his pin controller.
>>>>
>>>> Driver is doing correct things. If you want to be pedantic, we need to return
>>>> all possible pin states (which are currently absent from GPIO get_direction()
>>>> perspective) and even though it's not possible to tell from the pin muxer
>>>> p.o.v. If function is I2C, it's open-drain, if some other, it may be completely
>>>> different, but pin muxer might only guesstimate the state of the particular
>>>> function is and I do not think guesstimation is a right approach.
>>>>
>>>> We may use the specific error code, though. and document that semantics.
>>>
>>> Brief looking at the error descriptions and the practical use the best (and
>>> unique enough) choice may be EBADSLT.
>>
>> In any case, I proposed to revert to the previous behavior in
>> gpiochip_add_data() in my follow-up series so the issue should soon go
>> away.
> 
> Yes, I noted. The above is a material to discuss. We can make that semantics
> documented and strict and then one may filter out those errors if/when
> required.

I am still seeing this with 6.14.0-rc6-00022-gb7f94fcf5546. Do you know, 
if the reverts are going to be in the final 6.14 release?


Kind regards,

Paul

