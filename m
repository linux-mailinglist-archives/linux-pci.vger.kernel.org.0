Return-Path: <linux-pci+bounces-5075-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FE7088A276
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 14:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4AFE1F2BFAD
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 13:38:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D4514534F;
	Mon, 25 Mar 2024 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVMaR91s"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A62A140E22;
	Mon, 25 Mar 2024 07:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353457; cv=none; b=Soixs3TvbUoiRXBGq/EU9lSg39D+wx+/2b6Yv/6we7vZcdwmjsclBCBM0TdahleH58y/BrC/Y+V1VlWl5wLprJMa5n3uMmvuO08bNV4UoCZSpUhxodLW2LpzDqqX+2gWpUX3ITZ8GtoUlsGKcn8ppb00j1kNpC8NCPa+ATwtjjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353457; c=relaxed/simple;
	bh=Iv4hkwt46h9EaA2apPE9unVfn8/1YRhzMcUGEgF3bCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dDiFGLeqqCTh7VKEOkZm8sp80Thq8zvjlsCwL/LFXUeTbSU8KMO8L/2jdFs2qUzugUhJbUHJy55b8uDs5QbSooFN0RONd8/YGlcVGsNymBQuR9nmW3IdkILBESobrm+EHVSdqdWKif4rQmJUefwy2ntcNhkYIaKYWDGO805hcl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVMaR91s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6DA7C433F1;
	Mon, 25 Mar 2024 07:57:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711353457;
	bh=Iv4hkwt46h9EaA2apPE9unVfn8/1YRhzMcUGEgF3bCI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YVMaR91sAyMsf+83sS+mU0WnAFvMYVE80PzkL8GEJOHxhLOE0yVXnXu1DBnP9zYRP
	 jVBwwHNkr+50hgfpJbcQZS6p0zH7qPSNwAOxLPtm+d5Y9LQQn2U5HlUNWRq1Ko0KZT
	 TfcCkZ1I3sSydRUVNNzroqitzjchqYnnjNTYeiIPtXOZV1V5AzfhES8knpLBfPAhXa
	 iDgT28v1SzvChiSKdDHTSW+4kAmJvU3lb6eG4gWu1VMYO8j3m2GUXIC+qfa3TTQ/oG
	 gm88NmiN+g8kh7X1QTkir6QErUyZZaCLPmqHKyq12wI5QxIG7SGx47t20rLqViiy9c
	 P0jiR4XLK5AJg==
Message-ID: <5ae1b76b-03fa-433b-8d5a-62cc985cac42@kernel.org>
Date: Mon, 25 Mar 2024 16:57:34 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ata: pata_cs5520: Remove not needed call to
 pci_enable_device_io
Content-Language: en-US
To: Heiner Kallweit <hkallweit1@gmail.com>,
 Sergey Shtylyov <s.shtylyov@omp.ru>, Niklas Cassel <cassel@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-ide@vger.kernel.org,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <370ff61c-1ae0-41ca-95fc-6c45e1b8791d@gmail.com>
 <5068d0ce-2140-4d3f-b305-e8f0d61eed1f@gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <5068d0ce-2140-4d3f-b305-e8f0d61eed1f@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/24/24 02:14, Heiner Kallweit wrote:
> A few lines earlier pcim_enable_device() is called, which includes
> the functionality of pci_enable_device_io(). Therefore we can safely
> remove the call to pci_enable_device_io().
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>

Looks OK to me.

Acked-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


