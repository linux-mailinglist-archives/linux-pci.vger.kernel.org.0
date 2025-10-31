Return-Path: <linux-pci+bounces-39904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F31F8C23E8C
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 09:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ED50B4E486A
	for <lists+linux-pci@lfdr.de>; Fri, 31 Oct 2025 08:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AAF310625;
	Fri, 31 Oct 2025 08:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c8s2JTEx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA61A3101AD
	for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 08:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761900664; cv=none; b=r7nUAXubUmQphmaqemaTZqFujFGhbXxa7lZ2irDjFJeJ6wJlMzogHoobejb276meXzXQ87EYx4FAI+iWmPUdqmpmggFR92ruIjs2Eu9Uw0XzxhyzKNIZyx1zSmHDlAjFd/ZGSAPYOyl6Wo518Z8gOwuKvgZrJ5x3Qk94oSd1OJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761900664; c=relaxed/simple;
	bh=ocbxgDBr/NQ05/9FVwt9PJ96thby+UU01iRLKbfPELo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=nWGXtjIcgZQpjf0RiLlhfaTUGyH6MXxZors93KJ9K9j9tdMTxCgxfmOhC99bVqI7l5wOpzPu+2Xl3WCPqFSAOyTnO34NDXfe2jCNLuePSXSYj9rEIISwzoFRjtnDPOr/adEMuEjm1a4qIV/aKr+pz4uf03tI5wtyFJF51iRtnGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c8s2JTEx; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4710a1f9e4cso16155305e9.0
        for <linux-pci@vger.kernel.org>; Fri, 31 Oct 2025 01:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1761900661; x=1762505461; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VdthYQx3fPupz9VTuX9fs9tD+q8rhp/J+8kdTaSyYGI=;
        b=c8s2JTExj8Ws05OQeZYAnUAwONuwTwKaXtRZDjDrBfgZ/olaJiyJkLMtc/BO5AAkio
         VAGWctUfvHR3V7QPoibQskrixYJ4LphmDH9vGRqH3N9fo1KirdCMQHOGPLGIzfKNy9eO
         nn10XHw6A8UyXoMePk4eeXZuk9D/Lb4aJWyTeEoykXte+g0XmD1f3VFlUp19QNXqm1Lf
         CXeD+9AskfMNPH7dBv/JQOUqwSXy2fQjv9xpuga7vNHbQYgnJb7vRdEfN+h5TXROR6Sj
         oTilv5hYCovu53J1iDOnL99yTav7Lf+P7U3Nh9MwH5f+Wntyrtv0ZPo8IIbCbgHEwWEH
         X2AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761900661; x=1762505461;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VdthYQx3fPupz9VTuX9fs9tD+q8rhp/J+8kdTaSyYGI=;
        b=M9uk8Ygb9mLId4IyvYB+R2l9m8Ww/V08AS+5rgPLpkDOOUgjtS9Y3zqfxAVGrqqXnS
         z/60sprYEWxAAtOnq1/Ga0+J1ZIXpCDjlA6wcvhh8YkeQ+TpCV6NXrIcQm6yOtF3OgIc
         REo0PYdV63dIk7W57YoNf907lHnxgugo461PMEd+eTcWc7Vh+NjTKvaqT8I6u3OVcmqy
         nRtafvONdKZOqYLdVx46TBqUc1/1UBKaMHi6E6M+cEtfXmTa4srB8g1mUtOS2EL1k64w
         AgyXZn5U4JRYwPhwapoq6KKamnOOwhSRr7wZevBPZbolrDUCP5D8RDtH3jTgQL8Yf/9K
         Psqg==
X-Forwarded-Encrypted: i=1; AJvYcCUHBcysQ0K0vG6KPTJExzPUsku54gZrSR6vHKWQLI6f96DLedb3xoyyXceXb9iwu8j8tv1kvUNbv+w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6nKfdZ0sQibPAeM3/HssSJ8+8YG8ErblUq2omlf4dbhsAE7C8
	4pdnCXTVzg8Vd9rjOCVjvzgxpRGDHGj7hlIa7RkUPZv0wF71fVsK/oA3WAGv8Gaa+YY=
X-Gm-Gg: ASbGncuQ+jpuNmlA9CPJYijdZeYtXIdpbYltKXee500heycpyYjcQBVwb/0znz73V2Q
	vL8ZDMHr6sPJrTEL/7K9Y7+Gnv9R9CE6BoI+4WX0M2zeKYIF/sxNqesY6cyLa4Mr5BeO31SI8Lw
	1hYJONqhrtDdEq0Lvw6FTrGbJlKz2IsboNpROfxkGPHy0lJMfsWcMj+fdZM1URo3YKFDWZxMOKv
	uFTk6jgzvwWnpSqDNEWsavFC4y35OHzbTm1v9wLS0XtQMVi4EjqOdb1k7OzvqU5OjCl+jDxoBhb
	cbKh0b3u4hgVVr3X8DLyWNM0XG9UA1AqSEYiV8qwnGlBs2eUrkLKmQ1fxvV89zSiGccBSeYaHaP
	jD7IAUPpnOTwQCCT8kr/4otLhMGO/INFpK4Vk2OaXyXHiIQWpAhKnZ+iov55QynW7WtjELZe+u2
	8PKsfP/T6uo14YMxLpFHbQB+rO3aaXp8vZYRcsyJID6v+EA3n7NWjFmQotbMgkbH8=
X-Google-Smtp-Source: AGHT+IHgzS/nF5S0MzMHbXjLp8vWzcH8CRZAK3FVflgVJ4Dnpp781CewdMABTPZNC2jy/zYIIniiPg==
X-Received: by 2002:a05:600c:524f:b0:471:c72:c7f8 with SMTP id 5b1f17b1804b1-477308b6117mr24385315e9.21.1761900660929;
        Fri, 31 Oct 2025 01:51:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:cad:2140:d967:2bcf:d2d0:b324? ([2a01:e0a:cad:2140:d967:2bcf:d2d0:b324])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477289adc18sm86749505e9.6.2025.10.31.01.51.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Oct 2025 01:51:00 -0700 (PDT)
Message-ID: <59baecc0-bc28-4411-bf83-37ff9e7dd193@linaro.org>
Date: Fri, 31 Oct 2025 09:50:59 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
To: Linnaea Lavia <linnaea-von-lavia@live.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: FUKAUMI Naoki <naoki@radxa.com>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20251029171542.GA1566240@bhelgaas>
 <DM4PR05MB10270506AAC1FCE53C4915CC2C7F8A@DM4PR05MB10270.namprd05.prod.outlook.com>
Content-Language: en-US, fr
Autocrypt: addr=neil.armstrong@linaro.org; keydata=
 xsBNBE1ZBs8BCAD78xVLsXPwV/2qQx2FaO/7mhWL0Qodw8UcQJnkrWmgTFRobtTWxuRx8WWP
 GTjuhvbleoQ5Cxjr+v+1ARGCH46MxFP5DwauzPekwJUD5QKZlaw/bURTLmS2id5wWi3lqVH4
 BVF2WzvGyyeV1o4RTCYDnZ9VLLylJ9bneEaIs/7cjCEbipGGFlfIML3sfqnIvMAxIMZrvcl9
 qPV2k+KQ7q+aXavU5W+yLNn7QtXUB530Zlk/d2ETgzQ5FLYYnUDAaRl+8JUTjc0CNOTpCeik
 80TZcE6f8M76Xa6yU8VcNko94Ck7iB4vj70q76P/J7kt98hklrr85/3NU3oti3nrIHmHABEB
 AAHNKk5laWwgQXJtc3Ryb25nIDxuZWlsLmFybXN0cm9uZ0BsaW5hcm8ub3JnPsLAkQQTAQoA
 OwIbIwULCQgHAwUVCgkICwUWAgMBAAIeAQIXgBYhBInsPQWERiF0UPIoSBaat7Gkz/iuBQJk
 Q5wSAhkBAAoJEBaat7Gkz/iuyhMIANiD94qDtUTJRfEW6GwXmtKWwl/mvqQtaTtZID2dos04
 YqBbshiJbejgVJjy+HODcNUIKBB3PSLaln4ltdsV73SBcwUNdzebfKspAQunCM22Mn6FBIxQ
 GizsMLcP/0FX4en9NaKGfK6ZdKK6kN1GR9YffMJd2P08EO8mHowmSRe/ExAODhAs9W7XXExw
 UNCY4pVJyRPpEhv373vvff60bHxc1k/FF9WaPscMt7hlkbFLUs85kHtQAmr8pV5Hy9ezsSRa
 GzJmiVclkPc2BY592IGBXRDQ38urXeM4nfhhvqA50b/nAEXc6FzqgXqDkEIwR66/Gbp0t3+r
 yQzpKRyQif3OwE0ETVkGzwEIALyKDN/OGURaHBVzwjgYq+ZtifvekdrSNl8TIDH8g1xicBYp
 QTbPn6bbSZbdvfeQPNCcD4/EhXZuhQXMcoJsQQQnO4vwVULmPGgtGf8PVc7dxKOeta+qUh6+
 SRh3vIcAUFHDT3f/Zdspz+e2E0hPV2hiSvICLk11qO6cyJE13zeNFoeY3ggrKY+IzbFomIZY
 4yG6xI99NIPEVE9lNBXBKIlewIyVlkOaYvJWSV+p5gdJXOvScNN1epm5YHmf9aE2ZjnqZGoM
 Mtsyw18YoX9BqMFInxqYQQ3j/HpVgTSvmo5ea5qQDDUaCsaTf8UeDcwYOtgI8iL4oHcsGtUX
 oUk33HEAEQEAAcLAXwQYAQIACQUCTVkGzwIbDAAKCRAWmrexpM/4rrXiB/sGbkQ6itMrAIfn
 M7IbRuiSZS1unlySUVYu3SD6YBYnNi3G5EpbwfBNuT3H8//rVvtOFK4OD8cRYkxXRQmTvqa3
 3eDIHu/zr1HMKErm+2SD6PO9umRef8V82o2oaCLvf4WeIssFjwB0b6a12opuRP7yo3E3gTCS
 KmbUuLv1CtxKQF+fUV1cVaTPMyT25Od+RC1K+iOR0F54oUJvJeq7fUzbn/KdlhA8XPGzwGRy
 4zcsPWvwnXgfe5tk680fEKZVwOZKIEuJC3v+/yZpQzDvGYJvbyix0lHnrCzq43WefRHI5XTT
 QbM0WUIBIcGmq38+OgUsMYu4NzLu7uZFAcmp6h8g
Organization: Linaro
In-Reply-To: <DM4PR05MB10270506AAC1FCE53C4915CC2C7F8A@DM4PR05MB10270.namprd05.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/31/25 06:34, Linnaea Lavia wrote:
> On 10/30/2025 1:15 AM, Bjorn Helgaas wrote:
>> On Wed, Oct 29, 2025 at 06:50:46PM +0800, Linnaea Lavia wrote:
>>> On 10/29/2025 6:16 AM, Bjorn Helgaas wrote:
>>
>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>> index 214ed060ca1b..9cd12924b5cb 100644
>>>> --- a/drivers/pci/quirks.c
>>>> +++ b/drivers/pci/quirks.c
>>>> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>>>     * disable both L0s and L1 for now to be safe.
>>>>     */
>>>>    DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
>>>>    /*
>>>>     * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>>>
>>> I have applied the patch on 6.18-rc3 but it's still trying to enable ASPM for some reasons.
>>
>> Sorry, my fault, I should have made that fixup run earlier, so the
>> patch should be this instead:
>>
>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>> index 214ed060ca1b..4fc04015ca0c 100644
>> --- a/drivers/pci/quirks.c
>> +++ b/drivers/pci/quirks.c
>> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>    * disable both L0s and L1 for now to be safe.
>>    */
>>   DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
> 
> L1 still got enabled

<snip>

> 
> The card works just fine. I'm thinking the ASPM issue is probably from the glue driver reporting the link to be down when it's really just in low power state.

You're probbaly right, the meson_pcie_link_up() not only checks the LTSSM but also the speed, which is probably wrong.

Can you try removing the test for speed ?

-                 if (smlh_up && rdlh_up && ltssm_up && speed_okay)
+                 if (smlh_up && rdlh_up && ltssm_up)

The other drivers just checks the link, and some only the smlh_up && rdlh_up. So you can also probably drop ltssm_up aswell.

Neil



