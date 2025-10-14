Return-Path: <linux-pci+bounces-38090-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD60EBDB5D6
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 23:10:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 280D5580642
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 21:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F7C30BF52;
	Tue, 14 Oct 2025 21:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GW8wcMO5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FEB3002AF;
	Tue, 14 Oct 2025 21:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760476214; cv=none; b=Xbx3HuiQLv1KLBdM7ttCNEPg/yGyrQvjVAOLSSYonqmaabIQhlowDLHBkfTdTGEo4WyM+vEbQoVPHfcEnmz9sN9EjEC/WdTuCzUH1pwJSpO/lRuyeH7FBURg19Ef7Eoha8o76gcgvNt36I16d982Yz6DKfSsux0RCfHzxpzqmz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760476214; c=relaxed/simple;
	bh=Ro01wh06YC/uZxh8Xf1i50wfyiFHP8EhydOBit2DCIA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=be/flFp+iRsb8eigu8xI97ESMxkjewkmSCy4HWvMJ9OMRpNiHcLcu65OUiH0Ml6nrrQ4JFfuGO4ePqRqFFztk3Z8U5g2CJiWrYo9dOQnQ/pqbJPTlxo44SUKhhml3w7sTaxm6D19+oR9r7r5whAO9Bjcf3sjyJTBD50n5Ld01n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GW8wcMO5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC86C4CEE7;
	Tue, 14 Oct 2025 21:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760476212;
	bh=Ro01wh06YC/uZxh8Xf1i50wfyiFHP8EhydOBit2DCIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=GW8wcMO5W09zp1zy1d9huR1auo0p1Vy9a7N/T7y1/wJ1g0pMn9VwIMZ8ZFCtInzBl
	 MWmgLiCGX33oeoDlRQMoUXtopr2TKUpMUcir9sPyxyESh9JLGHALMYykMcX+s49sr6
	 UaqbGcuq5TA5EIHVUwS32PDz6PoZsfhfs4nfdpkMSwtEd/UkoE2mjhQJM3boJ3BgmR
	 dqi2PnaPi0Shr2zo28PO9TK8hWCGc0CQI7qWTmrwk2cMt6jN+N4L+ND7L2Cc+KMhBz
	 P9Scq6Zuztb0NhfvQQ5dipbHILYe3Cg286c9SQG0zh3J5wepM+WoKWqbCh5vSyAjjh
	 fhU5ISJrj45vg==
Date: Tue, 14 Oct 2025 16:10:11 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Huacai Chen <chenhuacai@loongson.cn>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
	Jianmin Lv <lvjianmin@loongson.cn>,
	Xuefeng Li <lixuefeng@loongson.cn>,
	Huacai Chen <chenhuacai@gmail.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, stable@vger.kernel.org
Subject: Re: [PATCH Resend] PCI: Limit islolated function probing on bus 0
 for LoongArch
Message-ID: <20251014211011.GA907236@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251014074100.2149737-1-chenhuacai@loongson.cn>

On Tue, Oct 14, 2025 at 03:41:00PM +0800, Huacai Chen wrote:
> We found some discrete AMD graphics devices hide funtion 0 and the whole
> is not supposed to be probed.
> 
> Since our original purpose is to allow integrated devices (on bus 0) to
> be probed without function 0, we can limit the islolated function probing
> only on bus 0.

s/islolated/isolated/ (multiple)
s/funtion/function/

I suppose this fixes some problem where:

  - An AMD GPU is on some bus other than 00
  - The GPU has no function 0
  - Without function 0, we normally don't probe other functions
  - a02fd05661d7 means we *do* probe other functions on LoongArch
  - Therefore we find some non-0 function we're not supposed to find

If that's the case, what bad thing happens?  Is there some dmesg hint
we can include in the commit log?

I suppose this means such devices are potentially broken for s390 and
jailhouse as well?

> Cc: stable@vger.kernel.org
> Fixes: a02fd05661d73a8 ("PCI: Extend isolated function probing to LoongArch")

a02fd05661d7 (12-char SHA1 is conventional)

> -static inline bool hypervisor_isolated_pci_functions(void)
> +static inline bool hypervisor_isolated_pci_functions(int bus)
>  {
>  	if (IS_ENABLED(CONFIG_S390))
>  		return true;
>  
> -	if (IS_ENABLED(CONFIG_LOONGARCH))
> -		return true;
> +	if (IS_ENABLED(CONFIG_LOONGARCH)) {
> +		if (bus == 0)

I don't really like this embedded assumption that the root bus is bus
00.  That's not necessarily the case; we have many host bridges that
lead to a bus other than 00.

> +			return true;
> +	}
>  
>  	return jailhouse_paravirt();
>  }
> -- 
> 2.47.3
> 

