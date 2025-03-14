Return-Path: <linux-pci+bounces-23741-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FFFBA6110E
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 13:27:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99F488253C
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1572D1FECD3;
	Fri, 14 Mar 2025 12:26:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62951CBE8C;
	Fri, 14 Mar 2025 12:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741955183; cv=none; b=KbacmWN6Wa24w9u6gdo0NKSPMXpl9aR9VuPfmAPzGUbQ/LpiDySldm3TKbbdSJ8Wu96aPJrWxKChydFAS+cDGARwa6t/L2JPGXKI/4Xo9fKb5XHjJjvFOIk6ETghMib/LyPn/dw6tt79Dh17OupAFp6qXDJUlUAlbpdU8fZjdC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741955183; c=relaxed/simple;
	bh=CTOADkKaiXL14ofE1ctHaZx6+5tXRWKRi8L0z3hb+x8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bwMpoCNpLoEOlQZ01VQmgNvYzCRAP+Az/afXlvQ8AoYIRq5IYjSWvFcPkCffzi4Eia6Ckw2EoTz8TOXhQHTCIVBr19ZqSLWMsWabi+prGEr7TrpW9titrq69mr6rFJyHxWNEIk+/sgu+Zo5Uz1KdiYNnT1BAhjcUf6C/diAS4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.43] (g43.guest.molgen.mpg.de [141.14.220.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 87A6F61E647AE;
	Fri, 14 Mar 2025 13:25:52 +0100 (CET)
Message-ID: <cb12d8d3-229c-4ef9-b585-778772b34ac7@molgen.mpg.de>
Date: Fri, 14 Mar 2025 13:25:52 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux logs new warning `gpio gpiochip0:
 gpiochip_add_data_with_key: get_direction failed: -22`
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linux-pci@vger.kernel.org,
 regressions@lists.linux.dev
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
 <dd9d62d5-54fc-4e7e-8508-1b8e22ac28d5@molgen.mpg.de>
 <CAMRc=Mez_3F0NifXLb18_XNH+-Q7D47HVOrYNt37EWsO9z0zgg@mail.gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <CAMRc=Mez_3F0NifXLb18_XNH+-Q7D47HVOrYNt37EWsO9z0zgg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Bartosz,


Am 14.03.25 um 13:19 schrieb Bartosz Golaszewski:
> On Fri, Mar 14, 2025 at 12:54 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
>>>>>
>>>>> Brief looking at the error descriptions and the practical use the best (and
>>>>> unique enough) choice may be EBADSLT.
>>>>
>>>> In any case, I proposed to revert to the previous behavior in
>>>> gpiochip_add_data() in my follow-up series so the issue should soon go
>>>> away.
>>>
>>> Yes, I noted. The above is a material to discuss. We can make that semantics
>>> documented and strict and then one may filter out those errors if/when
>>> required.
>>
>> I am still seeing this with 6.14.0-rc6-00022-gb7f94fcf5546. Do you know,
>> if the reverts are going to be in the final 6.14 release?
> 
> linux-next should probably be a better point of reference. I'm about
> to send out my PR to Linus so it'll be in 6.14-rc7 alright.

Awesome. Thank you!


Kind regards,

Paul

