Return-Path: <linux-pci+bounces-23077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B610A55A4B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 23:59:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0CF21898A3D
	for <lists+linux-pci@lfdr.de>; Thu,  6 Mar 2025 22:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A08A927CB2B;
	Thu,  6 Mar 2025 22:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k5c1cCXW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9555A27CB33;
	Thu,  6 Mar 2025 22:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741301971; cv=none; b=eA8MyLnIcjs06eYBXfuyzE3TlvISkgUey/ErTDjLrOfrWmtjLK8lGtMO3yuVAJCZ6YNq0PhB5rDTngZ5p5fUb5HnqXnfBm9AffkHTo995PPhOfDagfO7dS1dOwquwFlr1ilanI/H4lfMGYtoO4QhpQEDh3wGF9i4XIk4LBXvOPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741301971; c=relaxed/simple;
	bh=MEVUv7kEvUWZsmt0XrtVqxj6H4KcAw6tjsmKoRb9jlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NxdBC4uYb7Zr3F58FX9iAp5vs4cTUN5NuiLWnu9k6EbtXIMfsEQt8TneWkVy07juwqEYiy9irDpo28YdjriTjYeQtvef0Zk8hW+VAVwV8La9MExALj+yFdwQfE4K8JMec2wQbBotk2aSS20YWMxcDIcyrv0f//XP4eMA6qW0wcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k5c1cCXW; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e4ebc78da5so2221542a12.2;
        Thu, 06 Mar 2025 14:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741301968; x=1741906768; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=chV7S+fzAA2Gau2Ic5aypqTe9OyWNi3Kgw8UANvm0UE=;
        b=k5c1cCXWV1k9Z6czGQ3VI57VQDvUQv6qVH1FxDCbZ+DmdJMpsd18w8Q+PrOFEawxoJ
         i3DfrQQamWRLgTlJl/PMM4AIh6mA9d+cJeP52hqiw6mXtaHDXzHD0Kt+EK3BKS9ITShy
         h2stvPW0cbOtLsGY7OMajVx8Rtu49E8UtIDQD36/GxjXzAtwdIJhLcTXPVGzv3ofKOPK
         e/xYf+4b9gmbVMqouKk+O7sH4lLveyovYvVRJ1XsA4LZOjd2a3eNW1tlMAWDxMfj5112
         YuRLJFnYUpTLCTMaawZ6hzb0nsBimDyfvtOHfiimjhK1rTw27O+oRdnQ0uK9dxu9WIJl
         Jz9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741301968; x=1741906768;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=chV7S+fzAA2Gau2Ic5aypqTe9OyWNi3Kgw8UANvm0UE=;
        b=g5RnTTFUdqAmUcFvH3h+a8uDFeBkyUE89n6jjh4zMUqyvRnTdeZC5hVpG+AF1wYI4v
         2cIq63ltOtFy7XmGEQi6JryKTr/MdbfijJdcaRkoANWpsBijicb7CBcGIFx82iez9zJt
         C19sXh+b0VlP6pHzhbn0jj9ooKe34eGgSdoqD1n3N147v8sso1oD+sNLAWsnHslbPFBD
         PMsFT33gcDXueb9GDCyzVtA4nKRT2YlQDg2ZGSuVTn89jC1r/6yqm9CM6oKLhosmsj53
         OQ1iq1GKF1cGNNWLCcR8Xhdfakt4SQMhgMGUE8QvrAR7XR5/pWtzX8hrCaNQ0/8MdrAF
         eJhw==
X-Forwarded-Encrypted: i=1; AJvYcCUxwmCCmKrXX33R57wQHnuJMfHiFEFKltiYGgCjbvXVfKyb3yIQvyWqP3wKSo9DuuW1jOe2hdnO@vger.kernel.org, AJvYcCWbWmro2CBVWxagJ9zpMfWhsWwOM4brSeGMdY/2IduFNwLZWiwf8IyoQj0M3KzyTmcdo0cGmWxoWZ2o4TY=@vger.kernel.org, AJvYcCWk5qqVbQ5BluNgaC/69Ut1EVw8DDulL3QR4mANHtwG5FL+knM0DMP3hCcgGcheOg2ukUmnq4uqqo6y@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ/dGAyBlWLYHH/pYaz2Z7cu1kX5pleyaZOCNChQWXDRJM14cn
	7+yaM/yNTUrUqtAjlwoxrc4z54hQpAgBExG1z188XpZTcm9fFHLj
X-Gm-Gg: ASbGnctbRBANp0dcFCBaKThjuXdUosE8mYYAPLYHpr1onVFr/0DQViUF6IefVCr7J3b
	NEN+S6h85jseporIGy4iudtpILGghk8AAPnW2JYIheN97Lk2nmmRcz7ALIl3JTTwy7Gfb0T6Ot9
	fvIZ3m1FylIM859kMkJsjXESTpwwCpYM/uOSph+hu4VWmWOk4yxuc6Mntz6zgF0F8FQave/21PH
	RM7lvCgjl3KopEK31LucB0SJL9lJm+071U/8WBHrlZkd6cMyeYaP6D0B2H+Fw4cd7KoyLyeFlRA
	7eqyKxHTWrzvPflQzU4PHLrLP4wh5QdQd93Rti+EvZ0BAIOT+ioAqXjaRjQAB8gtc/dOrSuaCkc
	ujZct5IzDBy7jWGmXl+vf7EerukdSJgfx8QxKUZ9ivCOVaIK39nhPSu9xcZ85T4e6V8wAcENdZs
	dqZBd77Y3XSEyOk/QEYU+dQwk/LnhCkqK64Oj1
X-Google-Smtp-Source: AGHT+IFQn++9U/ESA/OJsB0mJ5tnr07300S0qIrgsTlThMgcR5RwG+W1bWFil9+SRlpFgBOxUg6++g==
X-Received: by 2002:a05:6402:35c7:b0:5e0:9390:f0d2 with SMTP id 4fb4d7f45d1cf-5e5e248f10amr852338a12.20.1741301967659;
        Thu, 06 Mar 2025 14:59:27 -0800 (PST)
Received: from ?IPV6:2a02:3100:a5b0:7900:4d9a:9929:21ea:7180? (dynamic-2a02-3100-a5b0-7900-4d9a-9929-21ea-7180.310.pool.telefonica.de. [2a02:3100:a5b0:7900:4d9a:9929:21ea:7180])
        by smtp.googlemail.com with ESMTPSA id 4fb4d7f45d1cf-5e5c74a8e0asm1568321a12.39.2025.03.06.14.59.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Mar 2025 14:59:26 -0800 (PST)
Message-ID: <9d8efb09-5c27-4934-a273-98c0ff57a48a@gmail.com>
Date: Fri, 7 Mar 2025 00:00:38 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Add PCI quirk to disable L0s ASPM state for RTL8125
 2.5GbE Controller
To: Bjorn Helgaas <helgaas@kernel.org>, hans.zhang@cixtech.com
Cc: bhelgaas@google.com, cix-kernel-upstream@cixtech.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Peter Chen <peter.chen@cixtech.com>, ChunHao Lin <hau@realtek.com>,
 nic_swsd@realtek.com, netdev@vger.kernel.org
References: <20250305222016.GA316198@bhelgaas>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 xsFNBF/0ZFUBEAC0eZyktSE7ZNO1SFXL6cQ4i4g6Ah3mOUIXSB4pCY5kQ6OLKHh0FlOD5/5/
 sY7IoIouzOjyFdFPnz4Bl3927ClT567hUJJ+SNaFEiJ9vadI6vZm2gcY4ExdIevYHWe1msJF
 MVE4yNwdS+UsPeCF/6CQQTzHc+n7DomE7fjJD5J1hOJjqz2XWe71fTvYXzxCFLwXXbBiqDC9
 dNqOe5odPsa4TsWZ09T33g5n2nzTJs4Zw8fCy8rLqix/raVsqr8fw5qM66MVtdmEljFaJ9N8
 /W56qGCp+H8Igk/F7CjlbWXiOlKHA25mPTmbVp7VlFsvsmMokr/imQr+0nXtmvYVaKEUwY2g
 86IU6RAOuA8E0J5bD/BeyZdMyVEtX1kT404UJZekFytJZrDZetwxM/cAH+1fMx4z751WJmxQ
 J7mIXSPuDfeJhRDt9sGM6aRVfXbZt+wBogxyXepmnlv9K4A13z9DVLdKLrYUiu9/5QEl6fgI
 kPaXlAZmJsQfoKbmPqCHVRYj1lpQtDM/2/BO6gHASflWUHzwmBVZbS/XRs64uJO8CB3+V3fa
 cIivllReueGCMsHh6/8wgPAyopXOWOxbLsZ291fmZqIR0L5Y6b2HvdFN1Xhc+YrQ8TKK+Z4R
 mJRDh0wNQ8Gm89g92/YkHji4jIWlp2fwzCcx5+lZCQ1XdqAiHQARAQABzSZIZWluZXIgS2Fs
 bHdlaXQgPGhrYWxsd2VpdDFAZ21haWwuY29tPsLBjgQTAQgAOBYhBGxfqY/yOyXjyjJehXLe
 ig9U8DoMBQJf9GRVAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHLeig9U8DoMSycQ
 AJbfg8HZEK0ljV4M8nvdaiNixWAufrcZ+SD8zhbxl8GispK4F3Yo+20Y3UoZ7FcIidJWUUJL
 axAOkpI/70YNhlqAPMsuudlAieeYZKjIv1WV5ucNZ3VJ7dC+dlVqQdAr1iD869FZXvy91KhJ
 wYulyCf+s4T9YgmLC6jLMBZghKIf1uhSd0NzjyCqYWbk2ZxByZHgunEShOhHPHswu3Am0ftt
 ePaYIHgZs+Vzwfjs8I7EuW/5/f5G9w1vibXxtGY/GXwgGGHRDjFM7RSprGOv4F5eMGh+NFUJ
 TU9N96PQYMwXVxnQfRXl8O6ffSVmFx4H9rovxWPKobLmqQL0WKLLVvA/aOHCcMKgfyKRcLah
 57vGC50Ga8oT2K1g0AhKGkyJo7lGXkMu5yEs0m9O+btqAB261/E3DRxfI1P/tvDZpLJKtq35
 dXsj6sjvhgX7VxXhY1wE54uqLLHY3UZQlmH3QF5t80MS7/KhxB1pO1Cpcmkt9hgyzH8+5org
 +9wWxGUtJWNP7CppY+qvv3SZtKJMKsxqk5coBGwNkMms56z4qfJm2PUtJQGjA65XWdzQACib
 2iaDQoBqGZfXRdPT0tC1H5kUJuOX4ll1hI/HBMEFCcO8++Bl2wcrUsAxLzGvhINVJX2DAQaF
 aNetToazkCnzubKfBOyiTqFJ0b63c5dqziAgzsFNBF/0ZFUBEADF8UEZmKDl1w/UxvjeyAeX
 kghYkY3bkK6gcIYXdLRfJw12GbvMioSguvVzASVHG8h7NbNjk1yur6AONfbUpXKSNZ0skV8V
 fG+ppbaY+zQofsSMoj5gP0amwbwvPzVqZCYJai81VobefTX2MZM2Mg/ThBVtGyzV3NeCpnBa
 8AX3s9rrX2XUoCibYotbbxx9afZYUFyflOc7kEpc9uJXIdaxS2Z6MnYLHsyVjiU6tzKCiVOU
 KJevqvzPXJmy0xaOVf7mhFSNQyJTrZpLa+tvB1DQRS08CqYtIMxRrVtC0t0LFeQGly6bOngr
 ircurWJiJKbSXVstLHgWYiq3/GmCSx/82ObeLO3PftklpRj8d+kFbrvrqBgjWtMH4WtK5uN5
 1WJ71hWJfNchKRlaJ3GWy8KolCAoGsQMovn/ZEXxrGs1ndafu47yXOpuDAozoHTBGvuSXSZo
 ythk/0EAuz5IkwkhYBT1MGIAvNSn9ivE5aRnBazugy0rTRkVggHvt3/7flFHlGVGpBHxFUwb
 /a4UjJBPtIwa4tWR8B1Ma36S8Jk456k2n1id7M0LQ+eqstmp6Y+UB+pt9NX6t0Slw1NCdYTW
 gJezWTVKF7pmTdXszXGxlc9kTrVUz04PqPjnYbv5UWuDd2eyzGjrrFOsJEi8OK2d2j4FfF++
 AzOMdW09JVqejQARAQABwsF2BBgBCAAgFiEEbF+pj/I7JePKMl6Fct6KD1TwOgwFAl/0ZFUC
 GwwACgkQct6KD1TwOgxUfg//eAoYc0Vm4NrxymfcY30UjHVD0LgSvU8kUmXxil3qhFPS7KA+
 y7tgcKLHOkZkXMX5MLFcS9+SmrAjSBBV8omKoHNo+kfFx/dUAtz0lot8wNGmWb+NcHeKM1eb
 nwUMOEa1uDdfZeKef/U/2uHBceY7Gc6zPZPWgXghEyQMTH2UhLgeam8yglyO+A6RXCh+s6ak
 Wje7Vo1wGK4eYxp6pwMPJXLMsI0ii/2k3YPEJPv+yJf90MbYyQSbkTwZhrsokjQEaIfjrIk3
 rQRjTve/J62WIO28IbY/mENuGgWehRlTAbhC4BLTZ5uYS0YMQCR7v9UGMWdNWXFyrOB6PjSu
 Trn9MsPoUc8qI72mVpxEXQDLlrd2ijEWm7Nrf52YMD7hL6rXXuis7R6zY8WnnBhW0uCfhajx
 q+KuARXC0sDLztcjaS3ayXonpoCPZep2Bd5xqE4Ln8/COCslP7E92W1uf1EcdXXIrx1acg21
 H/0Z53okMykVs3a8tECPHIxnre2UxKdTbCEkjkR4V6JyplTS47oWMw3zyI7zkaadfzVFBxk2
 lo/Tny+FX1Azea3Ce7oOnRUEZtWSsUidtIjmL8YUQFZYm+JUIgfRmSpMFq8JP4VH43GXpB/S
 OCrl+/xujzvoUBFV/cHKjEQYBxo+MaiQa1U54ykM2W4DnHb1UiEf5xDkFd4=
In-Reply-To: <20250305222016.GA316198@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05.03.2025 23:20, Bjorn Helgaas wrote:
> [+cc r8169 maintainers, since upstream r8169 claims device 0x8125]
> 
> On Wed, Mar 05, 2025 at 02:30:35PM +0800, hans.zhang@cixtech.com wrote:
>> From: Hans Zhang <hans.zhang@cixtech.com>
>>
>> This patch is intended to disable L0s ASPM link state for RTL8125 2.5GbE
>> Controller due to the fact that it is possible to corrupt TX data when
>> coming back out of L0s on some systems. This quirk uses the ASPM api to
>> prevent the ASPM subsystem from re-enabling the L0s state.
> 
> Sounds like this should be a documented erratum.  Realtek folks?  Or
> maybe an erratum on the other end of the link, which looks like a CIX
> Root Port:
> 
>   https://admin.pci-ids.ucw.cz/read/PC/1f6c/0001
> 
> If it's a CIX Root Port defect, it could affect devices other than
> RTL8125.
> 
>> And it causes the following AER errors:
>>   pcieport 0003:30:00.0: AER: Multiple Corrected error received: 0003:31:00.0
>>   pcieport 0003:30:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
>>   pcieport 0003:30:00.0:   device [1f6c:0001] error status/mask=00001000/0000e000
>>   pcieport 0003:30:00.0:    [12] Timeout
>>   r8125 0003:31:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Transmitter ID)
>>   r8125 0003:31:00.0:   device [10ec:8125] error status/mask=00001000/0000e000
>>   r8125 0003:31:00.0:    [12] Timeout
>>   r8125 0003:31:00.0: AER:   Error of this Agent is reported first
> 
> Looks like a driver name of "r8125", but I don't see that upstream.
> Is this an out-of-tree driver?
> 
Yes, this refers to Realtek's out-of-tree r8125 driver.
As stated by Hans, with the r8169 in-tree driver the issue doesn't occur.

>> And the RTL8125 website does not say that it supports L0s. It only supports
>> L1 and L1ss.
>>
>> RTL8125 website: https://www.realtek.com/Product/Index?id=3962
> 
> I don't think it matters what the web site says.  Apparently the
> device advertises L0s support via Link Capabilities.
> 
>> Signed-off-by: Hans Zhang <hans.zhang@cixtech.com>
>> Reviewed-by: Peter Chen <peter.chen@cixtech.com>
>> ---
>>  drivers/pci/quirks.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 82b21e34c545..5f69bb5ee3ff 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2514,6 +2514,12 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
>>  DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
>>  
>> +/*
>> + * The RTL8125 may experience data corruption issues when transitioning out
>> + * of L0S. To prevent this we need to disable L0S on the PCIe link.
>> + */
>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_REALTEK, 0x8125, quirk_disable_aspm_l0s);
>> +
>>  static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>  {
>>  	pci_info(dev, "Disabling ASPM L0s/L1\n");
>>
>> base-commit: 99fa936e8e4f117d62f229003c9799686f74cebc
>> -- 
>> 2.47.1
>>


