Return-Path: <linux-pci+bounces-9939-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 834CE92A608
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 17:46:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 050EAB20B0E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 15:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AD51411E7;
	Mon,  8 Jul 2024 15:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxjh3HJN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D387F1EA6F;
	Mon,  8 Jul 2024 15:46:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720453599; cv=none; b=tiRrqP11dlONwJR3s5lgcKmSetI6s78piU2XJYGBBNQ8Gk2Ktkkh2Fj+qAEy/yRKu4Ps0Qpa2fwstGbYCF3NczpGttsT9LBCzUDwsRxy3RMf/gASenBPGspiz1KX4IOS3CXDOzYOShImh+ajd5hNEgbO+Zu4sm6urDEgO8aEMlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720453599; c=relaxed/simple;
	bh=5YlED3eojCPyxdbMnaXUCWC34VX7tNeqn4YeTXySpSY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIrDZe8XG4He178hADPniEXLu4FI7fChJAUlWMU4ZmOINNIdhRk1MCLNhOjzRbhXj46ul02Sjda/NtmdSFmTinxmzo6SfehbvJL+aogvcWATHNbVom3HdXPg48dr+cIZu3PPXeUNYiyJ+TiZF2H5X1aHZbo2PfQUfcjObX1Eoo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxjh3HJN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E4B1C32786;
	Mon,  8 Jul 2024 15:46:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720453599;
	bh=5YlED3eojCPyxdbMnaXUCWC34VX7tNeqn4YeTXySpSY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Qxjh3HJNIxyvG2AbjKc+btkfqiwTVxjyMzTXdKoiBRRuxpuztHP+q8ILVB8EsUePq
	 l0lU+AmOudBFzxvaFXraGRC0b+8EU1sBgY1oCUKqg/t+69vgrpcFVrAPNeXwmUCb0g
	 EC4DJsLCwpwyeRLdGsuihhQQCJmhVh75HnHPs0CKo6bummT0wQZgKmiVSZUzHfIizk
	 /WA/K86lKsYL2AxLjP7Prq5QsfJRoyTYQJU1FVjHD2PKwGK4GEPnuyE7/8AwJEIFRm
	 Axrto4L7leARObxmMOceXxl282FaVcjXZsZ2XQJer5uGqrotFqlHA8ypUqzIWHyffy
	 rCkHYS2WZF6KA==
Message-ID: <664619a9-c80f-4f81-b302-b9c5258b5e0e@kernel.org>
Date: Mon, 8 Jul 2024 10:46:37 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
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
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20240708154401.GD5745@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/8/2024 10:44, Manivannan Sadhasivam wrote:
> On Mon, Jul 08, 2024 at 05:34:29PM +0200, Bartosz Golaszewski wrote:
>> On Mon, 8 Jul 2024 at 17:29, Mario Limonciello <superm1@kernel.org> wrote:
>>>
>>> On 7/8/2024 3:33, Krzysztof Wilczyński wrote:
>>>> [...]
>>>>>> If there aren't any objections, I will take this via the PCI tree, and add
>>>>>> the missing tags.  So, no need to send a new version of this patch.
>>>>>>
>>>>>> Thank you for the work here!  Appreciated.
>>>>>>
>>>>>>           Krzysztof
>>>>>
>>>>> I don't think you can take it via the PCI tree as it depends on the
>>>>> changes that went via the new pwrseq tree (with Bjorn's blessing).
>>>>
>>>> Aye.
>>>>
>>>>> Please leave your Ack here and I will take it with the other PCI
>>>>> pwrctl changes.
>>>>
>>>> Sounds good!  With that...
>>>>
>>>> Acked-by: Krzysztof Wilczyński <kw@linux.com>
>>>>
>>>>> After the upcoming merge window we should go back to normal.
>>>>
>>>> Thank you!
>>>>
>>>>        Krzysztof
>>>
>>> FWIW this other patch makes it quieter too.
>>>
>>> https://lore.kernel.org/linux-pci/20240702180839.71491-1-superm1@kernel.org/
>>
>> I had applied it previously but backed it out in favor of the new one.
>>
> 
> That sounds sensible. The patch referenced above still causes
> of_platform_populate() to be called on non-OF platforms, which is not optimal.

But couldn't I just as well have CONFIG_OF enabled in my kconfig and get 
the same new noise?

> 
> - Mani
> 


