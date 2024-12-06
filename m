Return-Path: <linux-pci+bounces-17864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADE9A9E7642
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 17:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6996B288C28
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 16:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B3120628F;
	Fri,  6 Dec 2024 16:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nekQRKo/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2818C206282;
	Fri,  6 Dec 2024 16:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733503100; cv=none; b=Zxxnh7qlnGQPyZkO6HOUBNSM02X4nd4LaiFUd5cuLK5ZQltzBiiYge97NW1qafT/k+VLDtgB94ssyRRBnw2hKPA+rJdOYeDDRqEoWMhAYk83ResSEjqJCnne2lwZWEw2PQliWSavpkATVbJ1UQdeM81Z+6c/9ujdiNdmHaSco64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733503100; c=relaxed/simple;
	bh=8HjIVg8Q7AA5TKAQZ/UOH+7uuqAsH+wKs9KM11XZzhw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p6W6kYqV/Xku/cRZ5B4hK0pBk1vfZu8Bp5aQHdgQhKJWZQkFowUKzGcySW8ydaDOGywS8dopSar/NsZSqzu59KK74zeV4HVzWfU9oOirdeEe4lVDOk+dS0JH/4zT4baWt5lpQ4ruAHFirxL+QgUVK+IdsYN4Sa4PG1u4AIDpxPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nekQRKo/; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-29e65257182so1360477fac.2;
        Fri, 06 Dec 2024 08:38:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733503098; x=1734107898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OUtyIe7GyZ1qnAGrnhHO6jZfnl/bJDmJX9w6y5HU/x0=;
        b=nekQRKo/k6WMACYvJP6Q/d0jEM75wBKVKrxVTvi7Q57B7yF9AhxAnBgdyRWQME5pFD
         /2hYcG/IJ3UyDJc4sxl6z6ItkOaindxMDgvoPk/TKqC2NKVaNjQbh7DX013z/ycB9WCC
         ZMCCUXMSaIzkAvDP/KSClQmDK97RbounfvzdhmkPEZZdntcs0g8+L9Px2bcn7ohE37SS
         xTXQDoPXjJe0AfNCwZ/2sEekh5NM5HrJ2zTyjKjyWPX9oaoktCCx4upI/ANHu2cmD1Zd
         96svJk+ssvx8xgwsdBOCQsti8ft4N3lGup3XxEYX6rYS8CVZiBj74NfH8XzxUeLDQrJ5
         Hqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733503098; x=1734107898;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OUtyIe7GyZ1qnAGrnhHO6jZfnl/bJDmJX9w6y5HU/x0=;
        b=UuTaC3bnJW0BIKJ6Bb/9QhjL/IQs5YSYUfVYTgWOJxhR0oV7BmF6NnekfdBcXyd9Ez
         QiwbqEuRyCfEm7aT+06m22D4dlmAK1LwuPzcORR4PpMKHGwrT2Lyti0S9zrsYnx4Fjob
         nz35B80dd2H0q5/LlvgSfHxNCh1hhOPQ9qka7URRmq7kk7zpPWhjqr9v21CoPLFRiev9
         tn7a4+GuiHtvYFCDsjEn4uQPZJiRzuwXrY82MAPjHEm+D0Odxt+tgNTFycvGOUSFg4Rv
         Y8SYfQkC+2Nh0qDmpTCzJptdRrwqj3ZyZ3Hj4crjZvdBfI99mcqcdNjiwB6fEeK6r7MS
         pulw==
X-Forwarded-Encrypted: i=1; AJvYcCW+1zxwX93POZgyfRP3lFTMFWUa4+bexJvVGpJu5uyLznW42qHipPvXYSBp4nIgPAV0/vUS+MczbUBS@vger.kernel.org, AJvYcCWF+LfqmCdx7Yt9QRSqZtVft8oTmgy+DjbtxEy18cg+7YNaGyhaoUy+qzhv7Wf37587iktP8kQASrruyoo=@vger.kernel.org, AJvYcCX8kbaGRtxK1Xhnugqiz2gyTymHvaryyRQWFAlut416RYBOFpMPUSrKxFIZuhOkP4wuVjSSQl/QSdQI@vger.kernel.org, AJvYcCXq6recn+bSzwKMkiIwNi37aMGEePeOGPQZ1EeOVTqdrW85QWB7pB/xNTA5vHocYrNoZbyHsFgz9BcN3Ma4bkC+XJ6Xcg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7V0MWS+uzS0ovE3uW6dZaSErh4zhMxVXUh1if9RMrTFZzuQwr
	njD5Fgn3ZdFf68/4mQMokcx9qKW5Y+t5C9pvykUnh3ze0kKfA2n1
X-Gm-Gg: ASbGncufMeXEvB7Eo6rlxpnf8XUcDTKgx2c5Qm4iNo3cMO4Iyi2uyKES47sptLNfbDl
	q4KdbYIemCpI8oen5O/Bw6UHNLhiqscIhIFtr7o5ssOqUnDuxCHoN0sGTwLMOoV1BG7GDHXTm9h
	+WDH2FsDoHRirKbll4/IrkfyEdzaAkLPdA7y5vZqqACPkA5HSamyBes7d3EsUxSjXZdMuYDKRYW
	K3r1uJB+vlaslt/Lk1G1UmyIv4fMf4I+6jvwZ9xaiuFppBfttWpRnbs+7nx5haFpzIyQqogWIlT
	8XYxCUb7oR0IZL9jEXs0oC8=
X-Google-Smtp-Source: AGHT+IGoXYPM0I+mAe7yUjNA6q2L0/CNK+6uzHAQbo7IsFfUj+O/131z1tjwI2LRhsUFPH0ZokM00g==
X-Received: by 2002:a05:6870:8991:b0:29e:554b:f47d with SMTP id 586e51a60fabf-29f734d39cbmr4506172fac.27.1733503097310;
        Fri, 06 Dec 2024 08:38:17 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd157b0171sm2872334a12.66.2024.12.06.08.38.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2024 08:38:16 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <82d7c96a-af68-4c7f-acb8-e4a883098a2e@roeck-us.net>
Date: Fri, 6 Dec 2024 08:38:13 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/16] x86/amd_nb, hwmon: (k10temp): Simplify
 amd_pci_dev_to_node_id()
To: Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 Tony Luck <tony.luck@intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>, Jean Delvare <jdelvare@suse.com>,
 Clemens Ladisch <clemens@ladisch.de>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
 Hans de Goede <hdegoede@redhat.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Naveen Krishna Chatradhi <naveenkrishna.chatradhi@amd.com>,
 Suma Hegde <suma.hegde@amd.com>
Cc: linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
 linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org,
 platform-driver-x86@vger.kernel.org
References: <20241206161210.163701-1-yazen.ghannam@amd.com>
 <20241206161210.163701-10-yazen.ghannam@amd.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <20241206161210.163701-10-yazen.ghannam@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/6/24 08:12, Yazen Ghannam wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> amd_pci_dev_to_node_id() tries to find the AMD node ID of a device by
> searching and counting devices.
> 
> The AMD node ID of an AMD node device is simply its slot number minus
> the AMD node 0 slot number.
> 
> Simplify this function and move it to k10temp.c.
> 
> [Yazen: Update commit message and simplify function]
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> Co-developed-by: Yazen Ghannam <yazen.ghannam@amd.com>
> Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>

I assume this patch will be applied together with the series.
With that in mind:

Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter


