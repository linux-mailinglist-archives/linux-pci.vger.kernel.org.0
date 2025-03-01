Return-Path: <linux-pci+bounces-22703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06A97A4AC76
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 16:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17A6F3B4CCE
	for <lists+linux-pci@lfdr.de>; Sat,  1 Mar 2025 15:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D2F21D5CC1;
	Sat,  1 Mar 2025 15:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qg+ZWlAO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6D533E1;
	Sat,  1 Mar 2025 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740841293; cv=none; b=of283wWCvNjfaeEsXquccmGpNOwfD2i5U9EW9JHOW6o8wgH1Zg96Iu4Z2wDKD/fV4DokE/uRuRbQQlvEo30Qge/YGffGuf7bd4BPJahfhfr7zQxtJ5b/fSllaWHUYGWCrpZrs9P6fKaHbgz55m/QDfdVLUnhvwD7ud0Y7ek5D5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740841293; c=relaxed/simple;
	bh=Q5jvdblVehq0RdjrHDo6V09Q7mjaeGtU1ZwRyVm2Ou8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zc8wHZUcNGLn+UjI6VGWFi55kO7u4Um2Z8PmeNYz78noQKVyqyDen6aUfZ9tS7mMPNyM4rHiXATCd23UhjFzA9yOJ2D9EKJz47QjxR27IBKQBe1yDllDXk1GHUQoGpzTM0uw7J5ijP6rzHTmjUqxs7Qq+ryV1PrYoqm7rLcO5tI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qg+ZWlAO; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390f5556579so666937f8f.1;
        Sat, 01 Mar 2025 07:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740841290; x=1741446090; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=zruMCqCIAH702liaPak4OKHfNTD0n8xmzIbwsUHEDVY=;
        b=Qg+ZWlAORMaLQyTqvmLWSYODkzQ1JSmghOhFeo9JfGftM2v0xSOz+oAvdoZmtga5oi
         ZHvAWOK54lw5QSJXGjY8z3SQ4A7ldPsHx1kcAscsL3hxeQVMGBmiJN8p281aoW11cRHr
         DTbg1uO5ubA3Ohsn5S8e4r9lsVN0CFPZsxJeMoCc/EOgWK2Vuv1+tQxTNt0OF+uy/l8a
         Ael1Q4deezmKVD1p26mPgjJC81UMsetCFZ0iNuHL5noaC4ebfTcd46ZpCxsRZBWUZhfe
         xSQtVys0o0KpdLd9mJJY7e8YVV2AvSdvulNc/IWvkFw5B68CmveCV/aceYIxgFehXvWK
         FdSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740841290; x=1741446090;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zruMCqCIAH702liaPak4OKHfNTD0n8xmzIbwsUHEDVY=;
        b=TJzLuzgVuIQa/zmkZZThseuQo/APId3WL19BY5/kMFZZIk8DyIZjXxlU2GCxiYk2L2
         ht5zhr9gz1GoYDBiFpvwrzvsY6n1OkuoAptPCNa8KGUMN3gRpaQoxn3jb7uiBaBj+w+z
         dkyxerG/zHAunKu8B/PTKpndMEJmBALOk0cJQp2H9N6Wf9RKvzkFP15tGGZTUByRKVmm
         ZOKAZa8IyfLDMsVMD/WYXisaeDfWKebtFg/IV+OPLtWRQBNHKRsWMtmpEXoGoIn/i3dF
         Y3ONy8zU2+ukYvEBwAaVPxuN46nAEaaO/1vb8SvahinorkZ64vtGdRA60/0gmdqyq1Pp
         wA0g==
X-Forwarded-Encrypted: i=1; AJvYcCVv9TjVDeSYqw6lq1SiciCyuvq9ykL/FxX0qTrTtby+lkwKc/3W2QCI4TbW8Ydcy4VY8u+bosdg5H3qaeY=@vger.kernel.org, AJvYcCWiOMWK11qXeetPakeksT7e6QYNwPp3tehsn/Z/Ukka237Yvv7kKoBjAplywImiNDwwD7YF9qhyJdNv@vger.kernel.org
X-Gm-Message-State: AOJu0YzvaoV6G3NrtvE9G/2cP9NJxajWgThzd+F0myZG4KsQA3sncSCW
	ov566jaz5WHjtmWBmuTZa63tNqddjj6vv1N6nM/pOBt/xNaEMiC3
X-Gm-Gg: ASbGnctCrEv/9bttOGK3u1Y/PeR5OdtiRaU5+UAcY875zGc4S2juN+xq7Wkw0YOAXpg
	GiPi13QfBfXhvm9QHrGnMUcCnvPMqfAIJW5u016ijxrut3zPEkXqHI6ScDCJFucXjryin38JSC3
	x9sNT7UprD0qqqaDaLmi2tWUxoEU050W81onr5VZdf2uA2WHj9fiJ/5O6xfOYzm+O/BzyyHyWq9
	qNUZ/dUPvLDHvUoVFClLosWGw9BBcPQeUYTNK+UNvpL542LScIavKU9Ri72CfuI6drJkwOOLo/h
	iXQreQQa0v0tQuC8LQHal2y9eBJ5XlZuaDoM8LsKtzMi5H3TVfNrj48FzuKvHmESvjhuDG8ZDTq
	a6NKpbd3tEz6t7GALNaAVbAKB5O7tuk9X2RLW3OWwzILr5s0lTwct8ye4nT8m6hd2HOEFQlior6
	p9o0szIjkGHoG1eXxKWCNwAC3xpAsn3vo=
X-Google-Smtp-Source: AGHT+IGNt+rcUXXDE2/tSfoeosjfXFmq0hNxVqQmghrCvjV5b5hPC+hZwkVkwDNJVUDNXRC+9bNXPA==
X-Received: by 2002:a5d:47c2:0:b0:390:e59d:fae9 with SMTP id ffacd0b85a97d-390ec7d2dd4mr5718403f8f.27.1740841289363;
        Sat, 01 Mar 2025 07:01:29 -0800 (PST)
Received: from ?IPV6:2a02:3100:a9db:600:159b:603:111e:5ffd? (dynamic-2a02-3100-a9db-0600-159b-0603-111e-5ffd.310.pool.telefonica.de. [2a02:3100:a9db:600:159b:603:111e:5ffd])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-390e47a72d5sm8720211f8f.31.2025.03.01.07.01.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Mar 2025 07:01:28 -0800 (PST)
Message-ID: <3854b3b6-365c-459e-ae97-ba88c804599e@gmail.com>
Date: Sat, 1 Mar 2025 16:02:33 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] r8169: enable
 RTL8168H/RTL8168EP/RTL8168FP/RTL8125/RTL8126 LTR support
To: Hau <hau@realtek.com>, nic_swsd <nic_swsd@realtek.com>,
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com"
 <pabeni@redhat.com>, Bjorn Helgaas <bhelgaas@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20250221071828.12323-439-nic_swsd@realtek.com>
 <20250221071828.12323-441-nic_swsd@realtek.com>
 <36d6094d-cc7c-4965-92ce-a271165a400a@gmail.com>
 <1544e50b9e4c4ee6a6d8ba6a777c2f07@realtek.com>
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
In-Reply-To: <1544e50b9e4c4ee6a6d8ba6a777c2f07@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24.02.2025 17:33, Hau wrote:
>>
>> External mail : This email originated from outside the organization. Do not
>> reply, click links, or open attachments unless you recognize the sender and
>> know the content is safe.
>>
>>
>>
>> On 21.02.2025 08:18, ChunHao Lin wrote:
>>> This patch will enable RTL8168H/RTL8168EP/RTL8168FP/RTL8125/RTL8126
>>> LTR support on the platforms that have tested with LTR enabled.
>>>
>>
>> Where in the code is the check whether platform has been tested with LTR?
>>
> LTR is for L1,2. But L1 will be disabled when rtl_aspm_is_safe() return false. So LTR needs rtl_aspm_is_safe()
> to return true.
> 
>>> Signed-off-by: ChunHao Lin <hau@realtek.com>
>>> ---
>>>  drivers/net/ethernet/realtek/r8169_main.c | 108
>>> ++++++++++++++++++++++
>>>  1 file changed, 108 insertions(+)
>>>
>>> diff --git a/drivers/net/ethernet/realtek/r8169_main.c
>>> b/drivers/net/ethernet/realtek/r8169_main.c
>>> index 731302361989..9953eaa01c9d 100644
>>> --- a/drivers/net/ethernet/realtek/r8169_main.c
>>> +++ b/drivers/net/ethernet/realtek/r8169_main.c
>>> @@ -2955,6 +2955,111 @@ static void rtl_disable_exit_l1(struct
>> rtl8169_private *tp)
>>>       }
>>>  }
>>>
>>> +static void rtl_set_ltr_latency(struct rtl8169_private *tp) {
>>> +     switch (tp->mac_version) {
>>> +     case RTL_GIGA_MAC_VER_70:
>>> +     case RTL_GIGA_MAC_VER_71:
>>> +             r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcdd2, 0x8c09);
>>> +             r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcdd4, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcde8, 0x887a);
>>> +             r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcdec, 0x8c09);
>>> +             r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcdf0, 0x8a62);
>>> +             r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcdf4, 0x883e);
>>> +             r8168_mac_ocp_write(tp, 0xcdf6, 0x9003);
>>> +             break;
>>> +     case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
>>> +             r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcdd2, 0x889c);
>>> +             r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcdd4, 0x8c30);
>>> +             r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcde8, 0x883e);
>>> +             r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcdec, 0x889c);
>>> +             r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcdf0, 0x8C09);
>>> +             r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
>>> +             break;
>>> +     case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_53:
>>> +             r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
>>> +             r8168_mac_ocp_write(tp, 0xcdd2, 0x883c);
>>> +             r8168_mac_ocp_write(tp, 0xcdd4, 0x8c12);
>>> +             r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
>>> +             break;
>>> +     default:
>>> +             break;
>>> +     }
>>> +}
>>> +
>>> +static void rtl_reset_pci_ltr(struct rtl8169_private *tp) {
>>> +     struct pci_dev *pdev = tp->pci_dev;
>>> +     u16 cap;
>>> +
>>> +     pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &cap);
>>> +     if (cap & PCI_EXP_DEVCTL2_LTR_EN) {
>>> +             pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
>>> +                                        PCI_EXP_DEVCTL2_LTR_EN);
>>> +             pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
>>> +                                      PCI_EXP_DEVCTL2_LTR_EN);
>>
>> I'd prefer that only PCI core deals with these registers (functions like
>> pci_configure_ltr()). Any specific reason for this reset? Is it something which
>> could be applicable for other devices too, so that the PCI core should be
>> extended?
>>
> It is for specific platform. On that platform driver needs to do this to let LTR works.
> 
>> +Bjorn and PCI list, to get an opinion from the PCI folks.
>>
>>> +     }
>>> +}
>>> +
>>> +static void rtl_enable_ltr(struct rtl8169_private *tp) {
>>> +     switch (tp->mac_version) {
>>> +     case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
>>> +             r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);
>>> +             r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));
>>> +             r8168_mac_ocp_modify(tp, 0xe032, 0x0000, BIT(14));
>>> +             break;
>>> +     case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
>>> +     case RTL_GIGA_MAC_VER_52 ... RTL_GIGA_MAC_VER_53:
>>> +             r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));
>>> +             RTL_W8(tp, 0xb6, RTL_R8(tp, 0xb6) | BIT(0));
>>> +             fallthrough;
>>> +     case RTL_GIGA_MAC_VER_51:
>>> +             r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);
>>> +             r8168_mac_ocp_write(tp, 0xe02c, 0x1880);
>>> +             r8168_mac_ocp_write(tp, 0xe02e, 0x4880);
>>> +             break;
>>> +     default:
>>> +             return;
>>> +     }
>>> +
>>> +     rtl_set_ltr_latency(tp);
>>> +
>>> +     /* chip can trigger LTR */
>>> +     r8168_mac_ocp_modify(tp, 0xe032, 0x0003, BIT(0));
>>> +
>>> +     /* reset LTR to notify host */
>>> +     rtl_reset_pci_ltr(tp);
>>> +}
>>> +
>>> +static void rtl_disable_ltr(struct rtl8169_private *tp) {
>>> +     switch (tp->mac_version) {
>>> +     case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_71:
>>> +             r8168_mac_ocp_modify(tp, 0xe032, 0x0003, 0);
>>> +             break;
>>> +     default:
>>> +             break;
>>> +     }
>>> +}
>>> +
>>>  static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp,
>>> bool enable)  {
>>>       u8 val8;
>>> @@ -2971,6 +3076,8 @@ static void rtl_hw_aspm_clkreq_enable(struct
>> rtl8169_private *tp, bool enable)
>>>                   tp->mac_version == RTL_GIGA_MAC_VER_43)
>>>                       return;
>>>
>>> +             rtl_enable_ltr(tp);
>>> +
>>>               rtl_mod_config5(tp, 0, ASPM_en);
>>>               switch (tp->mac_version) {
>>>               case RTL_GIGA_MAC_VER_70:
>>> @@ -4821,6 +4928,7 @@ static void rtl8169_down(struct rtl8169_private
>>> *tp)
>>>
>>>       rtl8169_cleanup(tp);
>>>       rtl_disable_exit_l1(tp);
>>> +     rtl_disable_ltr(tp);
>>
>> Any specific reason why LTR isn't configured just once, on driver load?
>>
> It is for device compatibility, I will check internally to see if we can remove it.
> 
Thanks. Complementing what I wrote before:
I would understand that reconfiguring LTR may be needed after a hw reset, when chip
"forgets" settings. But is there a reason to disable the internal LTR config?
IOW: What could happen if we omit rtl_disable_ltr()?

> 
>>>       rtl_prepare_power_down(tp);
>>>
>>>       if (tp->dash_type != RTL_DASH_NONE)
> 


