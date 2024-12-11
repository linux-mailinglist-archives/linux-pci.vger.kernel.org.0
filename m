Return-Path: <linux-pci+bounces-18175-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C009ED6F4
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 21:01:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B99FD282D1A
	for <lists+linux-pci@lfdr.de>; Wed, 11 Dec 2024 20:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7EB20B7F8;
	Wed, 11 Dec 2024 20:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="EKV225Ll"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5219D20B203
	for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 20:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733947306; cv=none; b=L7hlRaeJmsrk2lAWy07YsJwPLZqKJSGSgEUcKssNhjnrUbAnjipmYDeAjmjXlQyVpsQ3YE59Kk4SKcZRZj28GMs1FSCHqvPOAiwr8wf5+gzQ6MxElf6wNW7zFMnW4SVaHf851mp/ZTW0dUlDHcS+VpeBxemRdC5W3gTOgzsfxkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733947306; c=relaxed/simple;
	bh=F0M8NGa4GfHUrZooP1Zinaaxwf3Co2ffNjNkg35UMTc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iU7rwhNz/Bp4KfjQCjFgbWDTcFrEl7GMQ4xqoGPsagG2lxlD0wsvaWPNPNQ/29N6a7vWVW7qoPoQST2rB5RNo45tKNzW926kH7mLSFIHVGbDB7S+kAgf9+Eg+rn0cadyDYvRZnmT02w99dqPdwCRO3VhP9ef3vG1weoEi8+p54M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=EKV225Ll; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4676e708aeaso28517561cf.1
        for <linux-pci@vger.kernel.org>; Wed, 11 Dec 2024 12:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733947303; x=1734552103; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=RF+SgaA8A4yu1/WtuO/9GkUtQsQvHRuIDWUMOSCXiAk=;
        b=EKV225LlIVMUZItRLdA7G6ugsy1JEul2f98IrubU45RkiYqY2DL8urr+GVjFduWfif
         qBFvOG1Z1IJIfOmMtkN8aU5cQqirgYFOheeQ4Tuck51zqWebAYvXCWrZxXDD6VPlIsFb
         rD2lWFFRbb8yQI7mDbCCcZ6ZN4i6lnZUSa4iY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733947303; x=1734552103;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RF+SgaA8A4yu1/WtuO/9GkUtQsQvHRuIDWUMOSCXiAk=;
        b=rJ0CDMBUVoptgbRVjT73YRnPbXkn/2/FXH9sE2qxo8BWQjWAToUCu0UpvdzxwpT/xW
         Rn8QAxvYBB8VMEr4F1h6O3VMI4KrU3zv1h7CEmCgDT3wQa+2OxGxVkSz8X0MjnN66tg1
         oG3Sniunhg7uHEwG/o4YF6d8edcPqkGgPe4bOwQ/EYhqoACgK6A25adBXSVxqpBMlvoY
         3khgwlKDvdwxegkykUfAMp+j7Q3dRtfQeigGqPXflnnN244rbCgeZTkGONIU2t3/Khzc
         45lb9vVT3xzhntUofYlSJCxAL2XGczznsAPxELOyj79tC0aCkd4yULIPHaBKXhjNJ7aL
         sg+A==
X-Forwarded-Encrypted: i=1; AJvYcCWYM4I4/qDExJclkkuaFhzaPIL4dO35ufkrGtLB4Rt5QI//rkk/fQlRjucpPu5qju/QMD0A9dodelk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PTcKQMBSydUJU7JzbTl/wW4tsQ4kct8unCDSzzY5yEs4Ssn6
	zRNnM9wxZHG0uN+5R1Y0mDnLc8lQirm1fd4ZViMo8Iz9KvLTzeoNaYAvMhmVsA==
X-Gm-Gg: ASbGncvq9O10JLrgxiQZG4if/AlwAzfDb1awYKERdwUB5p+rDIKzK+HYHUwFgNfqw3q
	vHgdLEiGdosuUAszAFN08vtDucOk2f+/7eojgVeUBBZL4zPAOihuZEAdGN73fKMxx/v1PjI8+Id
	oGW6oFUCG8mMtA9pj1CUuzVj4ONf2Ac1bgySJvPPLcS6XxUJOHx/XYQ39d4vFjj+tpH8U4jLjj6
	snfMLIA4OV7gUrmZ0qRDO+JkxSIZ89fQ/OvhYrz5FzLcep3lIKWhWRXlCfAGe8Rivy82PWyB43j
	D84l3BW+MDoEWuc=
X-Google-Smtp-Source: AGHT+IH1EItEhDF0PhWzxH0hzNi2adGVkl/4FI0Nh7NmAubh3vPiMk36HkqtIjpl2KFJLYurfshIMQ==
X-Received: by 2002:ac8:7f42:0:b0:467:59a3:b44a with SMTP id d75a77b69052e-467962a741dmr12907131cf.56.1733947303166;
        Wed, 11 Dec 2024 12:01:43 -0800 (PST)
Received: from [10.28.17.173] ([192.19.144.250])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-467583c1b6asm43931021cf.44.2024.12.11.12.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Dec 2024 12:01:42 -0800 (PST)
Message-ID: <f0a734d9-6bf6-4d28-b30b-99b6be9f62dc@broadcom.com>
Date: Wed, 11 Dec 2024 15:01:40 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v4 06/10] PCI: brcmstb: Enable external MSI-X if available
To: Stanimir Varbanov <svarbanov@suse.de>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Jim Quinlan <jim2101024@gmail.com>,
 Nicolas Saenz Julienne <nsaenz@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Andrea della Porta <andrea.porta@suse.com>,
 Phil Elwell <phil@raspberrypi.com>, Jonathan Bell <jonathan@raspberrypi.com>
References: <20241025124515.14066-1-svarbanov@suse.de>
 <20241025124515.14066-7-svarbanov@suse.de>
Content-Language: en-US
From: James Quinlan <james.quinlan@broadcom.com>
Autocrypt: addr=james.quinlan@broadcom.com; keydata=
 xsBNBFa+BXgBCADrHC4AsC/G3fOZKB754tCYPhOHR3G/vtDmc1O2ugnIIR3uRjzNNRFLUaC+
 BrnULBNhYfCKjH8f1TM1wCtNf6ag0bkd1Vj+IbI+f4ri9hMk/y2vDlHeC7dbOtTEa6on6Bxn
 r88ZH68lt66LSWEciIn+HMFRFKieXwYGqWyc4reakWanRvlAgB8R5K02uk9O9fZKL7uFyolD
 7WR4/qeHTMUjyLJQBZJyaMj++VjHfyXj3DNQjFyW1cjIxiLZOk9JkMyeWOZ+axP/Aoe6UvWl
 Pg7UpxkAwCNHigmqMrZDft6e5ORXdRT163en07xDbzeMr/+DQyvTgpYst2CANb1y4lCFABEB
 AAHNKEppbSBRdWlubGFuIDxqYW1lcy5xdWlubGFuQGJyb2FkY29tLmNvbT7CwO8EEAEIAJkF
 AmNo/6MgFAAAAAAAFgABa2V5LXVzYWdlLW1hc2tAcGdwLmNvbYwwFIAAAAAAIAAHcHJlZmVy
 cmVkLWVtYWlsLWVuY29kaW5nQHBncC5jb21wZ3BtaW1lCAsJCAcDAgEKAhkBBReAAAAAGRhs
 ZGFwOi8va2V5cy5icm9hZGNvbS5uZXQFGwMAAAADFgIBBR4BAAAABBUICQoACgkQ3G9aYyHP
 Y/47xgf/TV+WKO0Hv3z+FgSEtOihmwyPPMispJbgJ50QH8O2dymaURX+v0jiCjPyQ273E4yn
 w5Z9x8fUMJtmzIrBgsxdvnhcnBbXUXZ7SZLL81CkiOl/dzEoKJOp60A7H+lR1Ce0ysT+tzng
 qkezi06YBhzD094bRUZ7pYZIgdk6lG+sMsbTNztg1OJKs54WJHtcFFV5WAUUNUb6WoaKOowk
 dVtWK/Dyw0ivka9TE//PdB1lLDGsC7fzbCevvptGGlNM/cSAbC258qnPu7XAii56yXH/+WrQ
 gL6WzcRtPnAlaAOz0jSqqOfNStoVCchTRFSe0an8bBm5Q/OVyiTZtII0GXq11c7ATQRWvgV4
 AQgA7rnljIJvW5f5Zl6JN/zJn5qBAa9PPf27InGeQTRiL7SsNvi+yx1YZJL8leHw67IUyd4g
 7XXIQ7Qog83TM05dzIjqV5JJ2vOnCGZDCu39UVcF45oCmyB0F5tRlWdQ3/JtSdVY55zhOdNe
 6yr0qHVrgDI64J5M3n2xbQcyWS5/vhFCRgBNTDsohqn/4LzHOxRX8v9LUgSIEISKxphvKGP5
 9aSst67cMTRuode3j1p+VTG4vPyN5xws2Wyv8pJMDmn4xy1M4Up48jCJRNCxswxnG9Yr2Wwz
 p77WvLx0yfMYo/ednfpBAAaNPqzQyTnUKUw0mUGHph9+tYjzKMx/UnJpzQARAQABwsGBBBgB
 AgErBQJWvgV5BRsMAAAAwF0gBBkBCAAGBQJWvgV4AAoJEOa8+mKcd3+LLC4IAKIxCqH1yUnf
 +ta4Wy+aZchAwVTWBPPSL1xJoVgFnIW1rt0TkITbqSPgGAayEjUvUv5eSjWrWwq4rbqDfSBN
 2VfAomYgiCI99N/d6M97eBe3e4sAugZ1XDk1TatetRusWUFxLrmzPhkq2SMMoPZXqUFTBXf0
 uHtLHZ2L0yE40zLILOrApkuaS15RVvxKmruqzsJk60K/LJaPdy1e4fPGyO2bHekT9m1UQw9g
 sN9w4mhm6hTeLkKDeNp/Gok5FajlEr5NR8w+yGHPtPdM6kzKgVvv1wjrbPbTbdbF1qmTmWJX
 tl3C+9ah7aDYRbvFIcRFxm86G5E26ws4bYrNj7c9B34ACgkQ3G9aYyHPY/7g8QgAn9yOx90V
 zuD0cEyfU69NPGoGs8QNw/V+W0S/nvxaDKZEA/jCqDk3vbb9CRMmuyd1s8eSttHD4RrnUros
 OT7+L6/4EnYGuE0Dr6N9aOIIajbtKN7nqWI3vNg5+O4qO5eb/n+pa2Zg4260l34p6d1T1EWy
 PqNP1eFNUMF2Tozk4haiOvnOOSw/U6QY8zIklF1N/NomnlmD5z063WrOnmonCJ+j9YDaucWm
 XFBxUJewmGLGnXHlR+lvHUjHLIRxNzHgpJDocGrwwZ+FDaUJQTTayQ9ZgzRLd+/9+XRtFGF7
 HANaeMFDm07Hev5eqDLLgTADdb85prURmV59Rrgg8FgBWw==
In-Reply-To: <20241025124515.14066-7-svarbanov@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/25/24 08:45, Stanimir Varbanov wrote:
> On RPi5 there is an external MIP MSI-X interrupt controller
> which can handle up to 64 interrupts.
>
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
> v3 -> v4:
>   - no changes.
>
>   drivers/pci/controller/pcie-brcmstb.c | 63 +++++++++++++++++++++++++--
>   1 file changed, 59 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c01462b07eea..af01a7915c94 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1318,6 +1318,52 @@ static int brcm_pcie_start_link(struct brcm_pcie *pcie)
>   	return 0;
>   }
>   
> +static int brcm_pcie_enable_external_msix(struct brcm_pcie *pcie,
> +					  struct device_node *msi_np)
> +{
> +	struct inbound_win inbound_wins[PCIE_BRCM_MAX_INBOUND_WINS];
> +	u64 msi_pci_addr, msi_phys_addr;
> +	struct resource r;
> +	int mip_bar, ret;
> +	u32 val, reg;
> +
> +	ret = of_property_read_reg(msi_np, 1, &msi_pci_addr, NULL);
> +	if (ret)
> +		return ret;
> +
> +	ret = of_address_to_resource(msi_np, 0, &r);
> +	if (ret)
> +		return ret;
> +
> +	msi_phys_addr = r.start;
> +
> +	/* Find free inbound window for MIP access */
> +	mip_bar = brcm_pcie_get_inbound_wins(pcie, inbound_wins);
> +	if (mip_bar < 0)
> +		return mip_bar;
> +
> +	mip_bar += 1;
> +	reg = brcm_bar_reg_offset(mip_bar);
> +
> +	val = lower_32_bits(msi_pci_addr);
> +	val |= brcm_pcie_encode_ibar_size(SZ_4K);
> +	writel(val, pcie->base + reg);
> +
> +	val = upper_32_bits(msi_pci_addr);
> +	writel(val, pcie->base + reg + 4);
> +
> +	reg = brcm_ubus_reg_offset(mip_bar);
> +
> +	val = lower_32_bits(msi_phys_addr);
> +	val |= PCIE_MISC_UBUS_BAR1_CONFIG_REMAP_ACCESS_EN_MASK;
> +	writel(val, pcie->base + reg);
> +
> +	val = upper_32_bits(msi_phys_addr);
> +	writel(val, pcie->base + reg + 4);

Hi Stan,

It looks like all this is doing is setting up an identity-mapped inbound 
window, is that correct?  If so, couldn't you get the same effect by 
adding an identity-mapped dma-range in the PCIe DT node?

Jim Quinlan  Broadcom STB/CM

> +
> +	return 0;
> +}
> +
>   static const char * const supplies[] = {
>   	"vpcie3v3",
>   	"vpcie3v3aux",
> @@ -1879,11 +1925,20 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>   		goto fail;
>   	}
>   
> -	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
> -	if (pci_msi_enabled() && msi_np == pcie->np) {
> -		ret = brcm_pcie_enable_msi(pcie);
> +	if (pci_msi_enabled()) {
> +		msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
> +		const char *str;
> +
> +		if (msi_np == pcie->np) {
> +			str = "internal MSI";
> +			ret = brcm_pcie_enable_msi(pcie);
> +		} else {
> +			str = "external MSI-X";
> +			ret = brcm_pcie_enable_external_msix(pcie, msi_np);
> +		}
> +
>   		if (ret) {
> -			dev_err(pcie->dev, "probe of internal MSI failed");
> +			dev_err(pcie->dev, "enable of %s failed\n", str);
>   			goto fail;
>   		}
>   	}



