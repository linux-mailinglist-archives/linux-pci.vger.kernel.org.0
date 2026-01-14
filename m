Return-Path: <linux-pci+bounces-44698-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF17D1C481
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 04:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DCF8F3040D3F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 03:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE49D2DEA86;
	Wed, 14 Jan 2026 03:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kkyEAjf3"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1F62D73A6
	for <linux-pci@vger.kernel.org>; Wed, 14 Jan 2026 03:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768362077; cv=none; b=iF6sJl99XHXNWSCB8V9eQyS0v5UHZMEXLvTTvMvIeN3fPhhXFXBE+BaPXhGcLSWtg8LeO+So1kKM2ONyGtfFr8/WvGjJXq5deXSvKGXc2D4rgLdCwxElCodckCse0gX637dVC7kbNmtkAZrqYjNfMa/2oHUZKmhhSNnsOUQjXss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768362077; c=relaxed/simple;
	bh=fuHX1gJvEHLXSbrpNZBA4M1RZiyGD+1HT2Iv1MurZ9o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xaf1QGlNa7eJXhno2LdDZs58EF0zeNKYtZst/wMAgqMtUZZhGbYbqXz4XQeGniAeeaLZ12vCladFxIS2UyQWhCUDvQ7jJngSdLVEseLGejsVmq3zOV058yoSUjyxXqSTsRuG6/tEJqbuZNqdVmGG3tigYqDB+R7uk15qSMoJS1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kkyEAjf3; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <977d29f6-4157-4fdb-b0d6-c24def482c06@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768362064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wzuS26H8SYTScmOx3++ZwcMsS+D3jzSzvm/KUyjaJik=;
	b=kkyEAjf3vAwmkpA6qQLnuaSZre5hBN1zivZR7feQaZvMwILYv8oANx8h+F6HDtKtMjlTGd
	gn0lxegePRhz+XBSWXtBXaiKo9+/Gdy9/KJsL/7dx5iYjqhXvnXEZ+zWcHtH+MjVlHKQFM
	4yb2rB8VCNXVTy1HzFsLEuwTZ+qx5q0=
Date: Wed, 14 Jan 2026 11:40:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v3 03/14] software node: Implement device_get_match_data
 fwnode callback
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 manivannan.sadhasivam@oss.qualcomm.com
Cc: Rob Herring <robh@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nicolas Schier <nicolas.schier@linux.dev>, Hans de Goede <hansg@kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mark Pearson <mpearson-lenovo@squebb.ca>,
 "Derek J. Clark" <derekjohn.clark@gmail.com>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>, Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>, linux-serial@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-bluetooth@vger.kernel.org, linux-pm@vger.kernel.org,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260110-pci-m2-e-v3-0-4faee7d0d5ae@oss.qualcomm.com>
 <20260110-pci-m2-e-v3-3-4faee7d0d5ae@oss.qualcomm.com>
 <aWSpFk9z0zpyKjr6@smile.fi.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sui Jingfeng <sui.jingfeng@linux.dev>
In-Reply-To: <aWSpFk9z0zpyKjr6@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 2026/1/12 15:56, Andy Shevchenko wrote:
> On Sat, Jan 10, 2026 at 12:26:21PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> 
>> Because the software node backend of the fwnode API framework lacks an
>> implementation for the .device_get_match_data function callback.
> 
> Maybe this is done on purpose. 


It is a *fact* that the broken swnode lacks an implementation for the 
.device_get_match_data stub.


Otherwise, If it is really done *on purpose*, the maintainers of swnode
backend probably shall document it in the source file *explicitly*.

Have you thought about this aspect?
> 

If it is sure thing, then it shouldn't start with "Maybe ..."


>> This makes it difficult to use(and/or test) a few drivers that originates
>> from DT world on the non-DT platform.
> 
> How difficult? 

The emphasis isn't on the 'difficult' word, it means 'inconvenience'

> DSA implementation went to the way of taking DT overlay
> approach. Why that one can't be applied here?


Software node as an complement of ACPI, Therefore should do the same.



DT overlay introduce extra overhead/side effects on the non-DT systems.

Besides, DT overlay requires the OS distribution(such as ubuntu) has the 
DT overlay config option selected.



> 
>> Implement the .device_get_match_data fwnode callback, which helps to keep
>> the three backends of the fwnode API aligned as much as possible. This is
>> also a fundamental step to make a few drivers OF-independent truely
>> possible.
>>
>> Device drivers or platform setup codes are expected to provide a software
>> node string property, named as "compatible". At this moment, the value of
>> this string property is being used to match against the compatible entries
>> in the of_device_id table. It can be extended in the future though.
> 
> I really do not want to see this patch

You can do that by dropping the maintainer-ship.

Your endless, bruth-force ranting on such a straight-forward thing 
doesn't make much sense, because that waste everybody's time.

> without very good justification


Justifications has been provided over and over again.

> (note, there were at least two attempts in the past to add this stuff

This exactly saying that the implementation is missing.

>   and no-one was merged, 

That's the reason why you see it at least the second time.

have you studied those cases?).
> 

The first one is not 100% correct.

