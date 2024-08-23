Return-Path: <linux-pci+bounces-12064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A555A95C434
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 06:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AFF11F235A4
	for <lists+linux-pci@lfdr.de>; Fri, 23 Aug 2024 04:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C05533EA72;
	Fri, 23 Aug 2024 04:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCy+FjUp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E511D52D;
	Fri, 23 Aug 2024 04:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724387377; cv=none; b=SDyP4sWi6VjUt3m/iII2PDyTkhrPZBPLtD41J5IuV3JPK0Vaad03TL9C507QYgQ6b7ArKXVtb2BKqMpeNvGE9mwxyWaGl75NnDIW4xCISnu4WnCa+nBXrXThiUiq+H40aKqT5GBXxCh7/yNzDmZDQIdZr/HdaKgaq6AH/TxP/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724387377; c=relaxed/simple;
	bh=UXfub7lxWQQk708n0yCS+LPs/EwBWlEj884ZhFNBNCU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=bwNN9Z9u1808leDwUl8qD070p6GxT+mspOcwOmSIpp51Nu2/2PL7oeXn5YTDwT7chYU95iU3DoChQY/C5rfNnRNbkoj8KnMfdJqf9VoqJFQD1Fnsoq8Jcj4Dv4WQcGj8oxTXZqm+iy1KHJKEHE10968bmr1HidGRG0kC4qnODVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCy+FjUp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20EB3C32786;
	Fri, 23 Aug 2024 04:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724387377;
	bh=UXfub7lxWQQk708n0yCS+LPs/EwBWlEj884ZhFNBNCU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
	b=QCy+FjUpqUv5OefnMvK/eNcAFXs2SRCtn13IGn3+VQe156jIinbaLugAAHjSqiG3K
	 qG0/Ptc3dFJGCOspwTmxQ11se+dZ7piWLTVr0hXW3eR9uKvHzruNq91ZowXFQeltPN
	 cVRK7Oc9Y83E2ohJ7z0Iy+69E3Hu7UuCx28KBXDEVOO61mkUJ/WUjRXLLRu5KHwBna
	 oMFPhGhgfV6tDejdYNBgEZGA5ATEE2A+Hg2HczM7zRYwUc1j+FvyQ8Ex0u5gyEuAv4
	 BLvQ29qdUnu1g0iBzKnKYMWzJtF/6o8hZk1c+8df7B8scuvTo65HqS0oqdPNdU8A9Z
	 Z6SxRSZB3aXUQ==
Message-ID: <80132627-5585-456b-a8b3-788d83808d3b@kernel.org>
Date: Thu, 22 Aug 2024 23:29:33 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/tsc: Use rdtsc_ordered() when RDTSCP or LFENCE_RDTSC
 are supported
From: Mario Limonciello <superm1@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: "open list : PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list : USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
 Daniel Drake <drake@endlessos.org>, Gary Li <Gary.Li@amd.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Mario Limonciello <mario.limonciello@amd.com>
References: <20240823042508.1057791-1-superm1@kernel.org>
 <20240823042508.1057791-3-superm1@kernel.org>
Content-Language: en-US
In-Reply-To: <20240823042508.1057791-3-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/22/24 23:25, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> On AMD processors the TSC has been reported drifting on and off for
> various platforms.  This has been root caused to becaused by out of order
> TSC and HPET counter values.  When the SoC supports RDTSCP or LFENCE_RDTSC
> use ordered tsc reads instead.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   arch/x86/include/asm/tsc.h | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/x86/include/asm/tsc.h b/arch/x86/include/asm/tsc.h
> index 94408a784c8e7..1c0cda1702bec 100644
> --- a/arch/x86/include/asm/tsc.h
> +++ b/arch/x86/include/asm/tsc.h
> @@ -24,6 +24,9 @@ static inline cycles_t get_cycles(void)
>   	if (!IS_ENABLED(CONFIG_X86_TSC) &&
>   	    !cpu_feature_enabled(X86_FEATURE_TSC))
>   		return 0;
> +	if (cpu_feature_enabled(X86_FEATURE_LFENCE_RDTSC) ||
> +	    cpu_feature_enabled(X86_FEATURE_RDTSCP))
> +		return rdtsc_ordered();
>   	return rdtsc();
>   }
>   #define get_cycles get_cycles

Sorry; this unrelated patch I didn't intend to include in the series, it 
was in my working directory by accident.  Please disregard it for now, 
but review the rest of the series.

Thanks!

