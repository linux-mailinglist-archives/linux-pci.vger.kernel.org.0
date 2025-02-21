Return-Path: <linux-pci+bounces-22024-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848F8A3FFE0
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 20:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 258773A7EA1
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 19:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C402512FE;
	Fri, 21 Feb 2025 19:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C1M88aNM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4461FBEB6;
	Fri, 21 Feb 2025 19:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740166747; cv=none; b=MvZinL9lD1wfxK1emuqlf4jTuYT2hvw+5d5c2Kxjv4ZejjsQkWUFGm73nw7xmHceVQjN/wBUOHiPIabL9qA91mFl8A4p34hg5q7nFGtG60uQaLYeDuMU1/KW296+wU4Qe+Rk589oebEskpOclkScit1deXV2s7GBdxt0U7s69Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740166747; c=relaxed/simple;
	bh=BH3WFspxGo2yGy/4z+nwK+niWQhW6cX9r26uo5byxoI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M7wDBuYVadClKGsyllbtpjiF33GTFXnOaxr4RDeEpZllQptBXT3YgzUjILSAJfJdxE7zaURQnmUofOtO0KsxIlX6bMg0pQapZoe0PUhQGp+AjSBVvtXi5HeXO0KWyFGy7Ec+o5TLIQuw31E2PvAbHoBiMl1QF+hU224LSkjzE90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C1M88aNM; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-38dcac27bcbso2253721f8f.0;
        Fri, 21 Feb 2025 11:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740166744; x=1740771544; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=+lg7YI8UWTEaXc8hJuz8pPloCdWidDKP4oBKmy+rdSA=;
        b=C1M88aNMWdNnkHd93flhh5jPC7hNA/o98SGH8E/5z4JWwH59FY7/N/VvqCnm1uWUSm
         AMebEkVswPH+vFk9z2sDbCuMH/NHFpLVFnyiJkLCbd6+LEDLWj2G3u/FCX5v6XXnHqB1
         v9ULzGRDnTWirSaUPclrxaJX6Mf2MPmpjB2WmwdsfieRoQ5X1BWyDPjtUhEV+KpXhpwr
         ck3EtZei/QyVjv2K9/kDX02x/4ltJ0Q6QNLBQWYF+eV+AE4HtSArnaCR0B4s6d4gihex
         CXAjUxeRpS9m8jMVbogplwuWWJCdvfNvw7ObWHzLEXQ4MlnoKLE51aYlo5qRHAE1a4us
         3cSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740166744; x=1740771544;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+lg7YI8UWTEaXc8hJuz8pPloCdWidDKP4oBKmy+rdSA=;
        b=O9ubkasHjGwTiDDvf+HxcPxn0bZAdM+RgIBiIWeoD1CRbBiISX5PFdta/AJ26xxaYv
         UASCrHNdVDMMRMydEbUJrytmWSoIS24+RyUzzg0sHCiveQZWCH8ngBdeTOK3MBHmixCr
         O/FuLSa0zcMDWE9Tus403Lpv9bAXt7HWL8K98RztzrfAowhLUQP2vdNc5wjJD2yfnvqo
         TXRxJFBhYZWkw6BPtoVg0M/fNRTveRTMhpJP5N87iHuqnZBlSRWXU+eylOxu/ZT3STIB
         eJBb4Vk31xG2LOS79tCPGscL5FHdwMfzQ6jGyGEQlNzt9NaSrdu/vA2BJowT5hnbm2z+
         DQMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWaoiZIAp7BakoaPcIaMKTJcULPHMII4Q32OUE/P0CMNPMTtkV7FxLmtMKP6QnzEr8tnGfbDsjaWpZn@vger.kernel.org, AJvYcCXYmzeK+jhLi/4E1gVPzS81TmoUHlXIT255/JZnrvA3IG0FPN5p8Kjr/lkmLHHWPmP59NvuDltvsfmsaqw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGcq59xFt+lNzjqhgP+gbXXZs83SX4zLY4VmO5PvvCas3fgPep
	w6z97L8iuLo4gA2vgVyc2ywWOEzXCLOV44v7bKlydcWf2vfj5mni
X-Gm-Gg: ASbGncsIuX5l/B6xh2NG0UoUYY+1epmggPs10/FQub641tdBtGQ0Ttw2MD5rIcHhsrG
	ccG9QFraT/tr9UnwS7LeTGosBv49Hph2SO3GQh5WwN3ziU8hIJgcMAogcuSGti7Zi5nOtl/aQQ+
	6mhqmZ9srKL2HzfSNgtX4Y2J09MUardNkj9UQi7NYF2YrwWwUCdddPwtOfo7dRjUGrG0oe4j78u
	c0LeK+S2gUzAdP9FI6bj0txgzhCDnhZs9VgZChYYp3N9iozKx0ksvLUEEty59y+5JPQy8n0zCbt
	QgpkebXSPcQbYLz+/4hKHOACe+TPiXSxvTu0Vr+IcUm1lG4pBeaP+9/b6usaSyQkG7mlomhc/MR
	5qM7xSUB9FrHAQ9T09peTtIlgnRnD9wDaCcdiQHuJ+D5087tam0xYP7Z0rJzSfvIKagf2vGEKWy
	w3HkdcFJGpVrDH
X-Google-Smtp-Source: AGHT+IHkXL5wAOD/SMTvw/+F62cT789FbQ3is8nBiXilI9clcxgi/7AIxMeDFuW71rrOuThPF/XckA==
X-Received: by 2002:a05:6000:401e:b0:38d:d414:124d with SMTP id ffacd0b85a97d-38f6160faedmr7260007f8f.19.1740166743734;
        Fri, 21 Feb 2025 11:39:03 -0800 (PST)
Received: from ?IPV6:2a02:3100:b29e:900:9dc2:647a:dfc:6311? (dynamic-2a02-3100-b29e-0900-9dc2-647a-0dfc-6311.310.pool.telefonica.de. [2a02:3100:b29e:900:9dc2:647a:dfc:6311])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-439b02ce60asm27361405e9.7.2025.02.21.11.39.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Feb 2025 11:39:02 -0800 (PST)
Message-ID: <36d6094d-cc7c-4965-92ce-a271165a400a@gmail.com>
Date: Fri, 21 Feb 2025 20:39:51 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/3] r8169: enable
 RTL8168H/RTL8168EP/RTL8168FP/RTL8125/RTL8126 LTR support
To: ChunHao Lin <hau@realtek.com>, nic_swsd@realtek.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, Bjorn Helgaas <bhelgaas@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20250221071828.12323-439-nic_swsd@realtek.com>
 <20250221071828.12323-441-nic_swsd@realtek.com>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <20250221071828.12323-441-nic_swsd@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21.02.2025 08:18, ChunHao Lin wrote:
> This patch will enable RTL8168H/RTL8168EP/RTL8168FP/RTL8125/RTL8126 LTR
> support on the platforms that have tested with LTR enabled.
> 

Where in the code is the check whether platform has been tested with LTR?

> Signed-off-by: ChunHao Lin <hau@realtek.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 108 ++++++++++++++++++++++
>  1 file changed, 108 insertions(+)
> 
> diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
> index 731302361989..9953eaa01c9d 100644
> --- a/drivers/net/ethernet/realtek/r8169_main.c
> +++ b/drivers/net/ethernet/realtek/r8169_main.c
> @@ -2955,6 +2955,111 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
>  	}
>  }
>  
> +static void rtl_set_ltr_latency(struct rtl8169_private *tp)
> +{
> +	switch (tp->mac_version) {
> +	case RTL_GIGA_MAC_VER_70:
> +	case RTL_GIGA_MAC_VER_71:
> +		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd2, 0x8c09);
> +		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd4, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcde8, 0x887a);
> +		r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdec, 0x8c09);
> +		r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdf0, 0x8a62);
> +		r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdf4, 0x883e);
> +		r8168_mac_ocp_write(tp, 0xcdf6, 0x9003);
> +		break;
> +	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:
> +		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd2, 0x889c);
> +		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd4, 0x8c30);
> +		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcde8, 0x883e);
> +		r8168_mac_ocp_write(tp, 0xcdea, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdec, 0x889c);
> +		r8168_mac_ocp_write(tp, 0xcdee, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdf0, 0x8C09);
> +		r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);
> +		break;
> +	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_53:
> +		r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdda, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcddc, 0x9003);
> +		r8168_mac_ocp_write(tp, 0xcdd2, 0x883c);
> +		r8168_mac_ocp_write(tp, 0xcdd4, 0x8c12);
> +		r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
> +static void rtl_reset_pci_ltr(struct rtl8169_private *tp)
> +{
> +	struct pci_dev *pdev = tp->pci_dev;
> +	u16 cap;
> +
> +	pcie_capability_read_word(pdev, PCI_EXP_DEVCTL2, &cap);
> +	if (cap & PCI_EXP_DEVCTL2_LTR_EN) {
> +		pcie_capability_clear_word(pdev, PCI_EXP_DEVCTL2,
> +					   PCI_EXP_DEVCTL2_LTR_EN);
> +		pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
> +					 PCI_EXP_DEVCTL2_LTR_EN);

I'd prefer that only PCI core deals with these registers (functions like
pci_configure_ltr()). Any specific reason for this reset? Is it something
which could be applicable for other devices too, so that the PCI core
should be extended?

+Bjorn and PCI list, to get an opinion from the PCI folks.

> +	}
> +}
> +
> +static void rtl_enable_ltr(struct rtl8169_private *tp)
> +{
> +	switch (tp->mac_version) {
> +	case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_71:
> +		r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);
> +		r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));
> +		r8168_mac_ocp_modify(tp, 0xe032, 0x0000, BIT(14));
> +		break;
> +	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:
> +	case RTL_GIGA_MAC_VER_52 ... RTL_GIGA_MAC_VER_53:
> +		r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));
> +		RTL_W8(tp, 0xb6, RTL_R8(tp, 0xb6) | BIT(0));
> +		fallthrough;
> +	case RTL_GIGA_MAC_VER_51:
> +		r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);
> +		r8168_mac_ocp_write(tp, 0xe02c, 0x1880);
> +		r8168_mac_ocp_write(tp, 0xe02e, 0x4880);
> +		break;
> +	default:
> +		return;
> +	}
> +
> +	rtl_set_ltr_latency(tp);
> +
> +	/* chip can trigger LTR */
> +	r8168_mac_ocp_modify(tp, 0xe032, 0x0003, BIT(0));
> +
> +	/* reset LTR to notify host */
> +	rtl_reset_pci_ltr(tp);
> +}
> +
> +static void rtl_disable_ltr(struct rtl8169_private *tp)
> +{
> +	switch (tp->mac_version) {
> +	case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_71:
> +		r8168_mac_ocp_modify(tp, 0xe032, 0x0003, 0);
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>  {
>  	u8 val8;
> @@ -2971,6 +3076,8 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
>  		    tp->mac_version == RTL_GIGA_MAC_VER_43)
>  			return;
>  
> +		rtl_enable_ltr(tp);
> +
>  		rtl_mod_config5(tp, 0, ASPM_en);
>  		switch (tp->mac_version) {
>  		case RTL_GIGA_MAC_VER_70:
> @@ -4821,6 +4928,7 @@ static void rtl8169_down(struct rtl8169_private *tp)
>  
>  	rtl8169_cleanup(tp);
>  	rtl_disable_exit_l1(tp);
> +	rtl_disable_ltr(tp);

Any specific reason why LTR isn't configured just once, on driver load?

>  	rtl_prepare_power_down(tp);
>  
>  	if (tp->dash_type != RTL_DASH_NONE)


