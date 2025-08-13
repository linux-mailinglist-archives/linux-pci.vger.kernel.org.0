Return-Path: <linux-pci+bounces-33986-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47732B253C9
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 21:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DC9A1C820E6
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 19:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542B22C1598;
	Wed, 13 Aug 2025 19:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nW0z0nSe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25197287263;
	Wed, 13 Aug 2025 19:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112649; cv=none; b=KOEKuTEz7vX8SoR9UzRYgJXYhgrpoxvo/wBz5yduOa7irgsi64//qQ3RsU9SwrM0g41anCkYbwhRUxspRAzlUd/v7sS9lY4Tv2yapDy58KoPlAlTpTe+fdoO9GRwiDu0RshB2wb2SO0BSMNj7x7IhSS6sXvuDhJUB2s5XuODet0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112649; c=relaxed/simple;
	bh=rDlKzG55XuEX8jU1UdbiT1DquMsLeP4vzWBKRtg/MpA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XjjoEFQxgL/r/uKBCudDDv81UtC6Ns+JctZF+muhgZj/C9b0hGLBU0TK6WBzdQ9JSSG9ruu/GsaaSAkI1u6lSEKsiE2hJdiBuVkTFJMyIS6ewCEId1uEjTWGxs8uh88dDpSrFCgd9N9GAJ0oKkS0yw073qIcim2WZeBUlRejERE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nW0z0nSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6735C4CEEB;
	Wed, 13 Aug 2025 19:17:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755112648;
	bh=rDlKzG55XuEX8jU1UdbiT1DquMsLeP4vzWBKRtg/MpA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=nW0z0nSeQijUCwxybMTish8HQBwNcm8vMODh7p+94JNHzaQ9xlIIdrbnd0jnDlL1F
	 SF/iq25piErqUGU9nelJbpAQzvnqLMxaafOUly2x4ZuuvO5zMUQNzv1fDkPiHRmRVt
	 /hIvkQpOFqmcrDV3g9ftm5JSVFQu4FGFu7lckFYApfbTbNVyJdv+9DiqyxNspJliWs
	 7IDddhqXOu47PO5t5LlgVHA7o6bDrg5vp+hAf/dX+8wzkN5LXCerSs915pXQ9GDl1d
	 /Wnb9SmiG0l2xVVgLB0UbYbeGU9mjM+u7Lv79nAP1SEDNbHbylx+OMU4xrknO5aXfg
	 0NyhFF7TCjhDQ==
Message-ID: <829069ca-0efb-4375-99bf-ccda52f74ac0@kernel.org>
Date: Wed, 13 Aug 2025 21:17:23 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 03/13] PCI: cadence: Add register definitions for
 HPA(High Perf Architecture)
To: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
 kw@linux.com, mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
 peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
 <20250813042331.1258272-4-hans.zhang@cixtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250813042331.1258272-4-hans.zhang@cixtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2025 06:23, hans.zhang@cixtech.com wrote:
>  static inline u32 cdns_pcie_read_sz(void __iomem *addr, int size)
>  {
>  	void __iomem *aligned_addr = PTR_ALIGN_DOWN(addr, 0x4);
> @@ -313,19 +410,17 @@ static inline void cdns_pcie_ep_disable(struct cdns_pcie_ep *ep)
>  #endif
>  
>  void cdns_pcie_detect_quiet_min_delay_set(struct cdns_pcie *pcie);
> -
>  void cdns_pcie_set_outbound_region(struct cdns_pcie *pcie, u8 busnr, u8 fn,
>  				   u32 r, bool is_io,
>  				   u64 cpu_addr, u64 pci_addr, size_t size);
> -
>  void cdns_pcie_set_outbound_region_for_normal_msg(struct cdns_pcie *pcie,
>  						  u8 busnr, u8 fn,
>  						  u32 r, u64 cpu_addr);
> -
>  void cdns_pcie_reset_outbound_region(struct cdns_pcie *pcie, u32 r);
>  void cdns_pcie_disable_phy(struct cdns_pcie *pcie);
> -int cdns_pcie_enable_phy(struct cdns_pcie *pcie);
> -int cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);
> +int  cdns_pcie_enable_phy(struct cdns_pcie *pcie);
> +int  cdns_pcie_init_phy(struct device *dev, struct cdns_pcie *pcie);

I don't understand how this (and many other pieces here) is related to
"add register definitions".

This is not a register definition.



Best regards,
Krzysztof

