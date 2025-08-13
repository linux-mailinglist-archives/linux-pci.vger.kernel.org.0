Return-Path: <linux-pci+bounces-33984-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 167F5B253C4
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 21:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AE331C2277D
	for <lists+linux-pci@lfdr.de>; Wed, 13 Aug 2025 19:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46633309DC3;
	Wed, 13 Aug 2025 19:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YIoA4XqU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19CBA302CC9;
	Wed, 13 Aug 2025 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755112472; cv=none; b=YGmP8WU89oAtlajAv5XqKyN56L3JUB8mOpjY0C9asQIaW2pld8xJx85UDitE/KvJZxLBHSNc9ArGTZQhv/B/bh8+SOQQeZ4TLyQ20j0KBXiNEgzZX6uCBrS1GlQ11UgOuEdy8v+ovXkDJofhUpOhDi1odNLwdHGJ/Kx38lRPDKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755112472; c=relaxed/simple;
	bh=nUClwhJtYwKNTD3BTsheIIfynM23uke2nnMDKR/dw/U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jsqx6Z2FzYPYjoBxh4pcmLcTn282L3Fq7hzetHLA7aJ+kN5or0iJR40KVp2zQAJ6xHQQ3Yue0Ae/SldKCBB6hI5/VlmQ2jL0/vwRrmMmxsZLwFBoaALGRB2zPdQ3sQ/ZqP6ZNBSckueCbaHIZENrN7U9/uJ3WMtKbRVcOdlToXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YIoA4XqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1816C4CEEB;
	Wed, 13 Aug 2025 19:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755112470;
	bh=nUClwhJtYwKNTD3BTsheIIfynM23uke2nnMDKR/dw/U=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YIoA4XqUTpNXnhExVqrRUPly6tQOKOqKHcG8aMyooQ5oKHr6J3Zwu8qFjaArX6zRk
	 krLSk8qYhwTEerYES5U/cRYpaHtAPNK12j/HB9WkmdRbPeVp1zXLOCA4VXidKjD7RQ
	 xpoLw/lRqD0sGZ0p2wEZ5wG/FqbmQh6Nxr7C6CPQzvtf29Zv1T8QFV7Q55URl6e56W
	 QUPSGfCHgrYchLeQbi2HFtvQJTiaclLJO0B8MD+nMnVLdInQUffigozt20Y62qdgLE
	 eJwOKoQZXBwEagDHf/7KJQseI+FjAQqKBIYha532TQwaLKAh1hsjBGXx0RdwX06mYX
	 ua34sV6YCgnFw==
Message-ID: <cc4f69b3-4d9b-4a6f-a296-61ab5ffb9565@kernel.org>
Date: Wed, 13 Aug 2025 21:14:24 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/13] Enhance the PCIe controller driver for next
 generation controllers
To: hans.zhang@cixtech.com, bhelgaas@google.com, lpieralisi@kernel.org,
 kw@linux.com, mani@kernel.org, robh@kernel.org, kwilczynski@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org
Cc: mpillai@cadence.com, fugang.duan@cixtech.com, guoyin.chen@cixtech.com,
 peter.chen@cixtech.com, cix-kernel-upstream@cixtech.com,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250813042331.1258272-1-hans.zhang@cixtech.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20250813042331.1258272-1-hans.zhang@cixtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/08/2025 06:23, hans.zhang@cixtech.com wrote:
> From: Hans Zhang <hans.zhang@cixtech.com>
> 
> ---
> Dear Maintainers,
> 
> This series is Cadence's HPA PCIe IP and the Root Port driver of our
> CIX sky1. Please help review. Thank you very much.
> ---
> 
> Enhances the exiting Cadence PCIe controller drivers to support
> HPA (High Performance Architecture) Cadence PCIe controllers.
> 
> The patch set enhances the Cadence PCIe driver for HPA support.
> The header files are separated out for legacy and high performance
> register maps, register address and bit definitions. The driver
> read register and write register functions for HPA take the
> updated offset stored from the platform driver to access the registers.
> As part of refactoring of the code, few new files are added to the
> driver by splitting the existing files.
> This helps SoC vendor who change the address map within PCIe controller
> in their designs. Setting the menuconfig appropriately will allow
> selection between RP and/or EP PCIe controller support. The support
> will include Legacy and HPA for the selected configuration.
> 
> The TI SoC continues to be supported with the changes incorporated.
> 
> The changes address the review comments in the previous patches where
> the need to move away from "ops" pointers used in current implementation
> and separate out the Legacy and HPA driver implementation was stressed.
> 
> The scripts/checkpatch.pl has been run on the patches with and without
> --strict. With the --strict option, 4 checks are generated on 2 patch,
> which can be ignored. There are no code fixes required for these checks.
> All other checks generated by ./scripts/checkpatch.pl --strict can be 
> ignored.
> 
> ---
> Changes for v7
>         - Rebase to v6.17-rc1.
>         - Fixed the error issue of cix,sky1-pcie-host.yaml make dt_binding_check.
>         - CIX SKY1 Root Port driver compilation error issue: Add header
>           file, Kconfig select PCI_ECAM.
> 

Where are lore links to all previous versions?

Best regards,
Krzysztof

