Return-Path: <linux-pci+bounces-28853-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACAC0ACC5AE
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 13:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8958B162E46
	for <lists+linux-pci@lfdr.de>; Tue,  3 Jun 2025 11:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DC4613B280;
	Tue,  3 Jun 2025 11:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x9tbXX+X"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871C622AE65
	for <linux-pci@vger.kernel.org>; Tue,  3 Jun 2025 11:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748951024; cv=none; b=WB0mWtR9YY/XhY3Yhym31F9GvcHm6w126WOqbFAA5p6KT+1p2WxVnl82u57eQOGoXu0o7+xWCnczwCYXidPjvJmlzYF3hJiAS3IUAlEcmRo+0KqSKZsQOkWeboLEN9yXMh+HpPzV8a/FZL9vADWyz5XYtXKV28Nr1lGXz0qsrNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748951024; c=relaxed/simple;
	bh=PNBCbtHacciRjGJIUshcSY6wyXemX0p2lmL+yLw6v1g=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=i8GvPUL7x03EgRQxye2yZUMCN5osR0VCCXwM6EO5nLkZlZR9L3GN9S8Obr9BVhgL5hMt7czGaexpKoZBk0CJyeBvrd50WEqruMhfo9s+XrVju5/3Gycw9Zs8OYCz1HA/uBFkvbUg7YcWy8R8xrbTJFqHZfJ2y6mY6agyUVo3qIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x9tbXX+X; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-606b58241c9so1022141a12.3
        for <linux-pci@vger.kernel.org>; Tue, 03 Jun 2025 04:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748951021; x=1749555821; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ubw5qr1vqTEQqkyLWzcVCvsavrNjo50AY7n8fFMjQxc=;
        b=x9tbXX+XfH2nSEw133b2razXgHKNwcxaEeOyTFB8/3XIHosEkXOE7Xje2VQLhzDNUA
         ufU38/ry8olVOggfEyz3l0e7p6sJgxWQrQRXB+Vp50KWW1hbhX1A5jjgo1BECMCQxzUI
         DJ2wcnsQRlJdgxSBtooNDa0DGCK8teCuLUGyKfdXFhWM6Wkm10qAA6So9FPDTlAOfaYG
         R9702pF2pgieQzn4yDAf0rDkO2r21caXxeJvMV5li0HjE6WtmAgFHKFCygzSGgSQbQSr
         bVg3QmG2HW6qZAISH/fa6ziun7kvfnRLMaJDAuS9oC3icjh7NUZxqpQF0aELbNlrXd3n
         ALlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748951021; x=1749555821;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ubw5qr1vqTEQqkyLWzcVCvsavrNjo50AY7n8fFMjQxc=;
        b=bbz7Ssaos0MsvVwiTtfdFoyLKOJVbTDU97Qv8foquAds59d2OkzSzICVuxobaZb9tA
         ycRMOuH4Qy1YrmR54L1szBval5cw3A4knNwAfNPI8S2ndFrrMLUgS7mzJjysi13IknDj
         P6+Hoge5czqQZFrgHAuguqiQyNjyJ3tBP+8NLnW8jGS+UXrZVpq9NNUUK1x/uHsqalUN
         VRavb9KAuyIimUR09bmd4THfscRpepiCHFthWq1DoUOWMiuDbtUdHckskknve7eFKagh
         oGJkAkJ4GKJbAssZSlkgP5YHOqUHIvuiHavgLC8iLQlrRKu8LjrdbnCqsgv9L0oEpn21
         ThLw==
X-Forwarded-Encrypted: i=1; AJvYcCVxrQ1toO8/cgK0W5cehY3pcMSTL+yFJweqYI2113dcwflCcaByFNJtItIAaIjvi1oY2SzcQscYek4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzs5cZkJ0gOgav2tZ3aRYo1p/wzvXdwqCklkow0EsjSJJfkIsrr
	3OqgOBrt6NwCbkVz9LpfkYo+I+9QWLirfpEb50PFOnGckvfOg0AoP7oi7Uq3CcnoHrE=
X-Gm-Gg: ASbGncvxBUh23nOdxgSRfkzau3y2nfDG31SigeyRFAinllyJ08Ccz6VEWcVyA3cQd47
	AhpNBZIzm/w462hJRthi95H9e3ZY5er8Q9nz7EWsjlRrRlnbnzAurTnjs8x1UwMio1ZOK+odT8h
	blgBv41SmMCecfv/q4yXObhFlQK9uL9EGnUM93Hhqwhg9Ky+cd+UFTWTmk3sj4N81tGD0Q5+TQH
	QT8e7v8uE+TtE2+z+WQYQBPJI7390CotLbwZe1d7oW/wuLMvtn3vrksbCTic9QktxSjHukAwmCQ
	slbuQsO9Tq7PNwv/E5lEwf6oNEHzZPrVOtr4Zku7d+Q74cfZ2acYn+ZayCUW
X-Google-Smtp-Source: AGHT+IGnG6VIuLl9nqDMaZzRwmhoM9nz6ogi2ZgDE95nbti3Gup7V8oVPqG3h7hrx+FWDi59W2Bv6g==
X-Received: by 2002:a05:6402:5106:b0:604:e33f:e5c0 with SMTP id 4fb4d7f45d1cf-605b7b6b7ccmr12087155a12.30.1748951020735;
        Tue, 03 Jun 2025 04:43:40 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.247])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60567169810sm7354284a12.78.2025.06.03.04.43.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jun 2025 04:43:40 -0700 (PDT)
Message-ID: <a4a5855c-6d58-4fc5-85d7-4727d27efbe0@linaro.org>
Date: Tue, 3 Jun 2025 12:43:38 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 William McVicker <willmcvicker@google.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
 <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
 <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org>
 <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com>
 <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
 <f6ee05f7-174b-76d4-3dbe-12473f676e4d@linux.intel.com>
 <867e47dc-9454-c00f-6d80-9718e5705480@linux.intel.com>
 <a56284a4-755d-4eb4-ba77-9ea30e18d08f@linaro.org>
 <7e882cfb-a35a-bab0-c333-76a4e79243b6@linux.intel.com>
 <f2d149c6-41a4-4a9a-9739-1ea1c4b06f4b@linaro.org>
 <19ccc09c-1d6b-930e-6ed6-398b34020ca1@linux.intel.com>
 <c1c0bacd-7842-4e9e-aec4-66eb481aa43f@linaro.org>
 <f8f15489-8b31-4672-9fb9-161c7c4599dc@linaro.org>
Content-Language: en-US
In-Reply-To: <f8f15489-8b31-4672-9fb9-161c7c4599dc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/3/25 11:48 AM, Tudor Ambarus wrote:
> 
> 
> On 6/3/25 11:36 AM, Tudor Ambarus wrote:
>>
>>
>> On 6/3/25 9:13 AM, Ilpo Järvinen wrote:
>>> So please test if this patch solves your problem:
>>
>> It fails in a different way, the bridge window resource never gets
>> assigned with the proposed patch.
>>
>> With the patch applied: https://termbin.com/h3w0
> 
> above is no revert and with the proposed fix. It also contains the
> prints https://termbin.com/g4zn
> 
> It seems the prints in pbus_size_mem are not longer hit, likely because
> of the new condition added: ``!pdev_resources_assignable(dev) ||``,
> pci_dev_for_each_resource() finishes without doing anything.
> 
>> With the blamed commit reverted: https://termbin.com/3rh6
> 

I think I found the inconsistency.

__pci_bus_assign_resources()
	pbus_assign_resources_sorted()
		pdev_sort_resources(dev, &head);

But pdev_sort_resources() is called with a newly LIST_HEAD(head), not
with realloc_head, thus the resources never get sorted.

pdev_sort_resources() exits early at
	``if (!pdev_resources_assignable(dev))``



