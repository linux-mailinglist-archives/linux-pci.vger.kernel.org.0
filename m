Return-Path: <linux-pci+bounces-38375-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F1FFBE4A89
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 18:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E4E524E1609
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 16:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973201DE8B5;
	Thu, 16 Oct 2025 16:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="0A7Gg9lh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E16A3BB48
	for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 16:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760633220; cv=none; b=SAeTQdTDfNX5LYmL50Xj7yYceRCPsTp3MvTMlSKS0D+BnLv0EvRtiCSwRa/ttVD1lxK+Br3CIUZPpRYiYE09FIRoFDNX3s9VnSe1DLn0VYCgagm1PWh0vv8ouFzM9I3BQFifJEmnuykpJ29FDpyFjqZ/EPVLSvZhoxdaZI81zsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760633220; c=relaxed/simple;
	bh=/8ULp8GNitp6ed8PeDWxV3ir/nSGEG1rxOOWV9OZqWQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hxit/tiLVhaGf07AeafoMHcRPOni0E6vA46wbJ2UlzX62OzxVQENz7BrWYQqy4HL0Pj9bh1nPj9BbaQITOVJ/A3gruOhj1BRn5RPDboRfTG81DKtBy5APKM9hF6KrBbOn2l8qsiawoop4TSSBn0+YlAK34ofLlKCl2OUCYZid78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=0A7Gg9lh; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-64e84414cfbso430792eaf.1
        for <linux-pci@vger.kernel.org>; Thu, 16 Oct 2025 09:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1760633217; x=1761238017; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WC9Kf4Woi10vxrnm+xt87b6ePjx84cYka09NWwjNNWA=;
        b=0A7Gg9lhFCuW9sMBiGBuBCWby4BhJtTI6e1ru5t1h/Sjf9+vApIhL3Uj2S9Eh5s5zO
         shfFQOyr/EWGKdWFlroW42BOfu6ljhknOhZSj3rYeN30I+OggdfYtx2eaxm37unbcz/a
         0vH4WvRmfN11HlLhCgbCttNuN/oA1Cq0gTF4LErAHa3MfhR6kvtM/c8GL4NuoYK7DTcD
         D/hL5MUHML1iesOwzBDvAdHZVszuFaAmYr2sJKxxSMazufnB24W2JFKHyDKb6mFhPSP+
         rrIIjw3UkowvQiQMnjyd2l+xN8J7Erf3DYtcu3+RI3b3KSLtNPYFiS2dvqodtRSVzmlH
         YxOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760633217; x=1761238017;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WC9Kf4Woi10vxrnm+xt87b6ePjx84cYka09NWwjNNWA=;
        b=n0AHUDu7jmR3hR/944QXoEzvyPW3BkhWlK8DalpxaNPHVzrY8wPTc8s5U9JwjeKBvZ
         SZTYMx0qBvkn7F0zyUwQdTyEG7FGqStyZ4Q5ty503OiVSAK6DyCx91R41lB+gtGIQ32J
         mhwWKW75fzvuuKFirmR2MfFiNNdbRUzOVo4t+bI93Y51R5LfVRMNLFc2q1kbLYJfwRQJ
         j7CHaGlA/BlnJ1tzZwN8Zb4dMF/ZSMC1O7sY8RpXLuZZL+vbdOyrFrCPbHI89UkPzeoH
         v9cSx8ONcYQkaNoVHnE23tpzZls+uvhyhmSe1xUpgR+0Xi9z7ClsvCX4ouWUk9vbczlk
         hXSA==
X-Forwarded-Encrypted: i=1; AJvYcCXgRXYwOmJCPOu9PWxz32Jl1nYkxS33eCXZqoAxTQ+PIKz5l1khSdPkvduHGDY9e8YzVfvnx6f2FTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfLvAwHbzn4vUI+tJZmNfDbAjWk7iOQVzHgcOqtcHyi8UMqnKk
	p/tq9rfNi3H438paJzUHoCbXhIJ8xeZ9bX8LJsaQ1Zy3guJmuYsyoGj3JV6TPkmtU4I=
X-Gm-Gg: ASbGncveuRtCKq8F2bqHUFhbsJ6Qx+xSf7YopukEM750eDwEOPjMK7p8mUkPDnXckd/
	ZfEbEmpJoGGEQkWLIr+rTP1dNoYv+BLe0by8LYzn/uEVBG9psTs7HSYUPjtljAdiSbAe91bxdoo
	rEPWcikQIChEwweJJdbA3QtewfTve+EHvy8BzOOjHXhCFn49WK/5syxK2kidHk8urZt+M2MaNvA
	PD1HC5glRMZPYOMFuP6GkL6DBVCs7Y+BrDthSnVCgLjMZAeIlZe+kKOEArBTGixi+qiJ/FBTyS9
	ocndNQhTtg6OrppHvPlezVc2JkGY0tPyUCtKdhc3DuIkXNXDQbASgvul9HqBSQ1MDxIOejsDJws
	JrjEwHxh8M3NqjZ4FRv5n9RPJ8UJ4CKZsXj0h2gzepY50UYAZxhIadQdD7iPQVcFMfaJzSX7uKo
	4OTsUR5kFEqfW+5w4w8nJ3qBqsjwiiYRQFePkVHuIAKCSduKg=
X-Google-Smtp-Source: AGHT+IGuEWd+8F+VovYJZ3CHXCt5CGxSvLqiDDTdefEfbr49E3wJzWtW8JNbm3BgbVjhnWchRkMr+Q==
X-Received: by 2002:a05:6808:3a0b:b0:441:d465:7474 with SMTP id 5614622812f47-443a30e1b7emr249948b6e.33.1760633217480;
        Thu, 16 Oct 2025 09:46:57 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:86b5:623:b364:9913? ([2600:8803:e7e4:500:86b5:623:b364:9913])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-441d5f7ebdbsm3144632b6e.18.2025.10.16.09.46.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Oct 2025 09:46:57 -0700 (PDT)
Message-ID: <cc21a74c-905f-4223-95a8-d747ef763081@baylibre.com>
Date: Thu, 16 Oct 2025 11:46:56 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/3] PM: runtime: Introduce
 PM_RUNTIME_ACQUIRE_OR_FAIL() macro
To: Takashi Iwai <tiwai@suse.de>, "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 Dhruva Gole <d-gole@ti.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 Linux ACPI <linux-acpi@vger.kernel.org>,
 Dan Williams <dan.j.williams@intel.com>,
 "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
References: <3925484.kQq0lBPeGt@rafael.j.wysocki>
 <3324926.5fSG56mABF@rafael.j.wysocki> <20251016133854.00003669@huawei.com>
 <CAJZ5v0iOgbkJbdRzgrBUaaYL+S_8BZD7XuXdK5vs2gMG3ug1KA@mail.gmail.com>
 <87ikge7v01.wl-tiwai@suse.de>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <87ikge7v01.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/16/25 9:59 AM, Takashi Iwai wrote:
> On Thu, 16 Oct 2025 15:46:08 +0200,
> Rafael J. Wysocki wrote:
>>
>> On Thu, Oct 16, 2025 at 2:39 PM Jonathan Cameron
>> <jonathan.cameron@huawei.com> wrote:
>>>
>>> On Wed, 15 Oct 2025 16:02:02 +0200
>>> "Rafael J. Wysocki" <rafael@kernel.org> wrote:
>>>
>>>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>
>>>> There appears to be an emerging pattern in which guard
>>>> pm_runtime_active_try is used for resuming the given device and
>>>> incrementing its runtime PM usage counter if the resume has been
>>>> successful, that is followed by an ACQUIRE_ERR() check on the guard
>>>> variable and if that triggers, a specific error code is returned, for
>>>> example:
>>>>
>>>>       ACQUIRE(pm_runtime_active_try, pm)(dev);
>>>>       if (ACQUIRE_ERR(pm_runtime_active_try, &pm))
>>>>               return -ENXIO
>>>>
>>>> Introduce a macro called PM_RUNTIME_ACQUIRE_OR_FAIL() representing the
>>>> above sequence of statements that can be used to avoid code duplication
>>>> wherever that sequence would be used.
>>>>
>>>> Use this macro right away in the PCI sysfs code where the above pattern
>>>> is already present.
>>>>
>>>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>> ---
>>>>
>>>> Admittedly, the new macro is slightly on the edge, but it really helps
>>>> reduce code duplication, so here it goes.
>>>
>>> Fully agree with the 'on the edge'.
>>>
>>> This looks somewhat like the some of the earlier attempts to come up with
>>> a general solution before ACQUIRE().  Linus was fairly clear on his opinion of
>>> a proposal that looked a bit similar to this
>>> cond_guard(mutex_intr, return -EINTR, &mutex);
>>>
>>> https://lore.kernel.org/all/CAHk-=win7bwWhPJ=iuW4h-sDTqbX6v9_LJnMaO3KxVfPSs81bQ@mail.gmail.com/
>>>
>>> +CC a few people who might have better memories of where things went than I do.
>>>
>>> The solution you have here has the benefit of clarity that all it can do is
>>> return the error code.
>>
>> Well, I could call the macro PM_RUNTIME_ACQUIRE_OR_RETURN_ERROR(), but
>> FAIL is just shorter. :-)
>>
>> Seriously though, the odd syntax bothers me, but it has come from
>> looking at the multiple pieces of code that otherwise would have
>> repeated exactly the same code pattern including the guard name in two
>> places and the pm variable that has no role beyond guarding.
> 
> While I see the benefit of simplification, IMO, embedding a code
> flow control inside the macro argument makes it really harder to
> follow.
> 
> Is the problem about the messy ACQUIRE_ERR() invocation?  If so, it
> could be replaced with something shorter (and without extra type),
> e.g. replace 
> 	ret = ACQUIRE_ERR(pm_runtime_active_try, &pm);
> with
> 	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> 
> Since all runtime PM guard usage is to the same object, we can have a
> common macro.
> 
> Also, in the past, I thought of a macro like below that stores the
> error code in the given variable ret:
> 
> #define __guard_cond_ret(_name, _var, _ret, _args)	\
> 	CLASS(_name, _var)(_args);			\
> 	(_ret) = __guard_err(_name)(&_var)
> #define guard_cond_ret(_name, _ret, _args) \
> 	__guard_cond_ret(_name, __UNIQUE_ID(guard), _ret, _args)
> 
> ... so that it'd work for runtime PM like:
> 
> 	int ret;
> 
> 	guard_cond_ret(pm_runtime_active, ret)(dev);
> 	if (ret)
> 		return ret;
> 	
> Of course, a clear drawback is that the assignment of ret isn't
> obvious, but the code flow isn't skewed much in this way.
> 
> 
> thanks,
> 
> Takashi

FWIW, a while back, I suggested something like this where ret was
a parameter rather than a return value [1]. Linus did not seem to
be a fan (said it was "disgusting syntax").

[1]: https://lore.kernel.org/all/CAHk-=whn07tnDosPfn+UcAtWHBcLg=KqA16SHVv0GV4t8P1fHw@mail.gmail.com/



