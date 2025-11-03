Return-Path: <linux-pci+bounces-40096-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C538C2ADBE
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 10:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CB618917F6
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 09:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302E62F9DA5;
	Mon,  3 Nov 2025 09:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vwsbUTRC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE38A2ECD27
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 09:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762163512; cv=none; b=uwdoqKVdiuI4v3XXOx9I3jDN/vN06AGOLBFJ+Am5vuAm7cBtGoetoOVljrRbawpK6W1ath6sK4QcqOfk7G3SqIfO+/z2a3p9oDqFmrYQQ0ZYBhq9Ug001jE3ZMtyWdLv9Oaq91TUjUFVZBRTy/mQFOHlRAKm6whK4woTjElXmw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762163512; c=relaxed/simple;
	bh=EJC38eDcg8YuReUlyukja+BTyZmSRBBRZUGSphXgMno=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rxDs20PeiJFuTqrrNAEjF+phosS2du5AaN3a2t+cmnwOS1oRqVxawZjdsBtpl986z279NmKDfojCoE/78tRPIHB765L21NGsKXiTCUqBPcWkZzjTxv3kJHFB/eBsA70qGwADDNwKODWgHUw5feJWSoNcLjhOPS5ow6NzYK8b8lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vwsbUTRC; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-429c8632fcbso1205154f8f.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 01:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762163506; x=1762768306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kzABgnbeDb8pzSGXIXK4gzoaq75SDM4C57TYmZw9FyM=;
        b=vwsbUTRChgMb/iG4GxAW02rQ/bgcLtI2bVUOMK892ZJ7cmsph+/jtJov0zrS1OsTzS
         v4fRfAA2YSJX4y96V2NLq4nNVL5evgASMGYWW2o7yn7zNfjIfKg3gPIJOrPdCy1eVpYh
         y1LwzobVdpi/8FoCLfj2mRYnCwI9dBx14kwDBJDQHeNVpWFouDjpOTHt0FD89xCsJ3rs
         cebW2vyIqbBSRDcuDrzUzmxQNI6ChCLNKv5M3jlwSAwyAUMXS8Fos2LdHjmNt/xEZ9+o
         AKhlZopdqRHz99KeAqzPLI3SQpRQTjV51kH8HgBsLrwdy7DeeGwDdTZ5A7AWVQ5xY/sg
         au/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762163506; x=1762768306;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:references:cc:to:subject:reply-to:from:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=kzABgnbeDb8pzSGXIXK4gzoaq75SDM4C57TYmZw9FyM=;
        b=Z5ax7YU3wIN0Zy3eTM+EzwbPB7p8cZpvnZMq8icTIGJCwtgFbpGNOR6wCNEG3/tjkM
         frfayHkKSYjINBfF7HpTcEHZUYRQgxNDzymWWUXRVlUGPmpxl/sgbIIMObg+jI75d6JV
         qXM/hUI7GP8S+fvmgAoSLKmRrOifBy693QxGk4b3gfHlCiwngwxGHYsAbVeknvCKudhs
         eF3BsM0hmSUPKlDi+iZJ1abJQ8DGBGUKBSvp/UIg8F0V1T+ybsxr4HYVww41kpOmWLtg
         shxaBCfscq2BgsOvFaXRwSzgOrEjHllFcUjjhdzG1AtRc7LLgD0/m096o3skQAmTiqPT
         Fv5A==
X-Forwarded-Encrypted: i=1; AJvYcCVrhoKesHAipRQS2z6Hf3QcMmqQxKdu4pRwXklhmitbZngLfE/7T4oCWnPFngoluC/xzU7SNGfdLl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxE88NyE/muWHpJ4nJxX2KOg7l54ZaTiXEU56HHo9mdqa5gvzwJ
	EwveKAnB8LgtWybrDPGT/emrFd6xZ+H9EYGJD+VpWp6kSLuF23h94I0ykkbsRXJ7jYU=
X-Gm-Gg: ASbGncsHhl+Co4gBH9zul8Frkp/6hfpwqX8eMKDrbWBlFSqizRbgP//wH2ZCoXvRD8X
	TIVlpZIimRA92gHT3V1BG6BvpaLbncnsaWmiBkgJe+JA3PSwaBTda7Jx9MJ2/BqfS5Pc60rxHyL
	o9GwRMdE5YFbSseLILJl9gKf7AF0DeL6So33e3q5G1YK033PqZg0Jcnb2f+Xsc+bLH1mIuM0XjV
	8zf34cJm4orzljQXHKERJUmLFl8l50Buyym2K4eHlZCDNXEYcBzhqcpBEgPbxhr0i8Orlqpi/3G
	4NcSlHgkCmANYU542ik1UxOsZUeIQC6gUIvdcZyPI8Wn3baIdGJ1NeBnRKWoVLug5azNynhEyna
	KPwt/rtZBWdm1kYmogrHJnkI7iNwmIlCYZZVlBBlOTCMOQqevevVgHovJU3FYjqav24/c38u9Nf
	v8YZumSQ013Un8u2YKJP5zgPBKcB5ElQ4kmQ==
X-Google-Smtp-Source: AGHT+IHI4ioHp+AFK0pCBgd1+OsciRLs4AaBA2U7IPrzAi+HZrr//ufjuw7eGBXOAXE8rH1S4TMUdw==
X-Received: by 2002:a05:6000:460a:b0:429:c989:ceb9 with SMTP id ffacd0b85a97d-429c989d6f1mr5585823f8f.51.1762163506013;
        Mon, 03 Nov 2025 01:51:46 -0800 (PST)
Received: from [192.168.27.65] (home.rastines.starnux.net. [82.64.67.166])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c1405fffsm19355129f8f.45.2025.11.03.01.51.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Nov 2025 01:51:45 -0800 (PST)
Message-ID: <f0cdf43e-2569-4f24-b337-03d8e430c0cf@linaro.org>
Date: Mon, 3 Nov 2025 10:51:46 +0100
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
To: Bjorn Helgaas <helgaas@kernel.org>,
 Linnaea Lavia <linnaea-von-lavia@live.com>
Cc: FUKAUMI Naoki <naoki@radxa.com>,
 "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
 Kevin Hilman <khilman@baylibre.com>,
 Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <20251031161323.GA1688975@bhelgaas>
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
In-Reply-To: <20251031161323.GA1688975@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Bjorn,

On 10/31/25 17:13, Bjorn Helgaas wrote:
> On Fri, Oct 31, 2025 at 08:26:42PM +0800, Linnaea Lavia wrote:
>> On 10/31/2025 4:50 PM, Neil Armstrong wrote:
>>> On 10/31/25 06:34, Linnaea Lavia wrote:
>>>> On 10/30/2025 1:15 AM, Bjorn Helgaas wrote:
>>>>> On Wed, Oct 29, 2025 at 06:50:46PM +0800, Linnaea Lavia wrote:
>>>>>> On 10/29/2025 6:16 AM, Bjorn Helgaas wrote:
>>>>>
>>>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>>>> index 214ed060ca1b..9cd12924b5cb 100644
>>>>>>> --- a/drivers/pci/quirks.c
>>>>>>> +++ b/drivers/pci/quirks.c
>>>>>>> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>>>>>>      * disable both L0s and L1 for now to be safe.
>>>>>>>      */
>>>>>>>     DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>>>>>>> +DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
>>>>>>>     /*
>>>>>>>      * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
>>>>>>
>>>>>> I have applied the patch on 6.18-rc3 but it's still trying to enable ASPM for some reasons.
>>>>>
>>>>> Sorry, my fault, I should have made that fixup run earlier, so the
>>>>> patch should be this instead:
>>>>>
>>>>> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
>>>>> index 214ed060ca1b..4fc04015ca0c 100644
>>>>> --- a/drivers/pci/quirks.c
>>>>> +++ b/drivers/pci/quirks.c
>>>>> @@ -2524,6 +2524,7 @@ static void quirk_disable_aspm_l0s_l1(struct pci_dev *dev)
>>>>>     * disable both L0s and L1 for now to be safe.
>>>>>     */
>>>>>    DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x1080, quirk_disable_aspm_l0s_l1);
>>>>> +DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_SYNOPSYS, 0xabcd, quirk_disable_aspm_l0s_l1);
>>>>
>>>> L1 still got enabled
> 
> Is that based on the output below?
> 
>    [    5.445853] [     T48] pci 0000:00:00.0: Disabling ASPM L0s/L1
>    [    5.560448] [     T48] pci 0000:01:00.0: ASPM: default states L1
> 
> If so, this doesn't necessarily mean L1 was enabled.  It means the
> quirk marked the 00:00.0 Root Port so we shouldn't ever enable L0s or
> L1, and when we enumerated 01:00.0, we set its default ASPM state to
> L1.
> 
> But I don't *think* L1 should actually be enabled unless we can enable
> it for both 00:00.0 and 01:00.0, and the quirk should mean that we
> can't enable it for 00:00.0.
> 
> This muddle of "capable" (per Link Capabilities) vs "disabled" (either
> the Link Control shows disabled, or software said "don't ever use L1")
> is part of what makes aspm.c so confusing.
> 
>>>> The card works just fine. I'm thinking the ASPM issue is
>>>> probably from the glue driver reporting the link to be down when
>>>> it's really just in low power state.
>>>
>>> You're probably right, the meson_pcie_link_up() not only checks
>>> the LTSSM but also the speed, which is probably wrong.
>>>
>>> Can you try removing the test for speed ?
>>>
>>> -                 if (smlh_up && rdlh_up && ltssm_up && speed_okay)
>>> +                 if (smlh_up && rdlh_up && ltssm_up)
>>>
>>> The other drivers just checks the link, and some only the smlh_up
>>> && rdlh_up. So you can also probably drop ltssm_up aswell.
>>
>> I can confirm that removing the check for ltssm_up and speed_okay
>> made ASPM work.
> 
> I don't think meson_pcie_link_up() should have the loop in it, so the
> ltssm_up and speed_okay checks, the loop, the delay, and the timeout
> message should probably all be removed.  That method is supposed to be
> a simple true/false check, and any waiting required should be done in
> dw_pcie_wait_for_link().
> 
> The link was clearly up when we discovered 01:00.0, so the "wait
> linkup timeout" messages from meson_pcie_link_up() after that must be
> from dw_pcie_link_up() being called via the .map_bus() call in
> pci_generic_config_read() or pci_generic_config_write().
> 
> When meson_pcie_link_up() returns false in those config accessors,
> the config accesses will fail (they won't even be attempted), so we'll
> see things like this:
> 
>    pci 0000:01:00.0: BAR 0: error updating (0xfc700004 != 0xffffffff)
> 
> and "Unknown header type 7f" from lspci.
> 
> Can you drop the ASPM quirk patch and instead try the
> meson_pcie_link_up() patch below on top of v6.18-rc3?
> 
>> We still need a solution to the original issue that's preventing the
>> controller from being initialized.
>>
>> My kernel has the following patch applied, but I think it's not
>> suitable for upstream as this changes device tree bindings for PCIe
>> controller on meson.
> 
> I assume the original issue is this:
> 
>    meson-pcie fc000000.pcie: error -EBUSY: can't request region for resource [mem 0xfc000000-0xfc3fffff]
> 
> and you confirmed that it wasn't fixed by a1978b692a39 ("PCI: dwc: Use
> custom pci_ops for root bus DBI vs ECAM config access"), which
> appeared in v6.18-rc3?
> 
> If it's still broken in v6.18-rc3, and the dtsi and
> meson_pcie_get_mems() patch below makes it work, we have more work to
> do, and maybe Krishna has some ideas.
> 
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> index dcc927a9da80..ca455f634834 100644
>> --- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> +++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
>> @@ -138,7 +138,7 @@ pcie: pcie@fc000000 {
>>   			reg = <0x0 0xfc000000 0x0 0x400000>,
>>   			      <0x0 0xff648000 0x0 0x2000>,
>>   			      <0x0 0xfc400000 0x0 0x200000>;
>> -			reg-names = "elbi", "cfg", "config";
>> +			reg-names = "dbi", "cfg", "config";
>>   			interrupts = <GIC_SPI 221 IRQ_TYPE_LEVEL_HIGH>;
>>   			#interrupt-cells = <1>;
>>   			interrupt-map-mask = <0 0 0 0>;
>> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
>> index 787469d1b396..404c4d9e1900 100644
>> --- a/drivers/pci/controller/dwc/pci-meson.c
>> +++ b/drivers/pci/controller/dwc/pci-meson.c
>> @@ -109,10 +109,6 @@ static int meson_pcie_get_mems(struct platform_device *pdev,
>>   {
>>   	struct dw_pcie *pci = &mp->pci;
>> -	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
>> -	if (IS_ERR(pci->dbi_base))
>> -		return PTR_ERR(pci->dbi_base);
>> -
>>   	mp->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
>>   	if (IS_ERR(mp->cfg_base))
>>   		return PTR_ERR(mp->cfg_base);
> 
> diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
> index 787469d1b396..13685d89227a 100644
> --- a/drivers/pci/controller/dwc/pci-meson.c
> +++ b/drivers/pci/controller/dwc/pci-meson.c
> @@ -338,40 +338,10 @@ static struct pci_ops meson_pci_ops = {
>   static bool meson_pcie_link_up(struct dw_pcie *pci)
>   {
>   	struct meson_pcie *mp = to_meson_pcie(pci);
> -	struct device *dev = pci->dev;
> -	u32 speed_okay = 0;
> -	u32 cnt = 0;
> -	u32 state12, state17, smlh_up, ltssm_up, rdlh_up;
> +	u32 state12;
>   
> -	do {
> -		state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
> -		state17 = meson_cfg_readl(mp, PCIE_CFG_STATUS17);
> -		smlh_up = IS_SMLH_LINK_UP(state12);
> -		rdlh_up = IS_RDLH_LINK_UP(state12);
> -		ltssm_up = IS_LTSSM_UP(state12);
> -
> -		if (PM_CURRENT_STATE(state17) < PCIE_GEN3)
> -			speed_okay = 1;
> -
> -		if (smlh_up)
> -			dev_dbg(dev, "smlh_link_up is on\n");
> -		if (rdlh_up)
> -			dev_dbg(dev, "rdlh_link_up is on\n");
> -		if (ltssm_up)
> -			dev_dbg(dev, "ltssm_up is on\n");
> -		if (speed_okay)
> -			dev_dbg(dev, "speed_okay\n");
> -
> -		if (smlh_up && rdlh_up && ltssm_up && speed_okay)
> -			return true;
> -
> -		cnt++;
> -
> -		udelay(10);
> -	} while (cnt < WAIT_LINKUP_TIMEOUT);
> -
> -	dev_err(dev, "error: wait linkup timeout\n");
> -	return false;
> +	state12 = meson_cfg_readl(mp, PCIE_CFG_STATUS12);
> +	return IS_SMLH_LINK_UP(state12) && IS_RDLH_LINK_UP(state12);
>   }
>   
>   static int meson_pcie_host_init(struct dw_pcie_rp *pp)

This change looks fine, please submit it so I can CI test it.

Thanks,
Neil

