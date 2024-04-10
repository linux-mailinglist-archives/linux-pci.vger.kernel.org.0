Return-Path: <linux-pci+bounces-6041-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8A389FC97
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 18:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 093DB1C21C5A
	for <lists+linux-pci@lfdr.de>; Wed, 10 Apr 2024 16:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A74D0179671;
	Wed, 10 Apr 2024 16:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jT74nrU5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 165CF15F3F1;
	Wed, 10 Apr 2024 16:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712765587; cv=none; b=hx3BqmpWQrjYKu/HZurU1oisDOA8IIB35A49wyPiln0IWzRnE1A6j20BrQasnj6rsfpmTFb6YK2xZ//Q6ESJ/ZbRHmNOI+7Y6X462BwawVoYN2Zg/+bpv+JUb3MRUN8nHgq2jqTXdzT3CzFp4N4X0rQ/Nw644ZGLVnKG4tx452c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712765587; c=relaxed/simple;
	bh=FQCYN6IqaR3axpJN1TW2Hx67diOfXeWRYKQJ0xq71j4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rOY4hX9uQ1zM6/UhSobL9s8gbc9hyM8KgrGTz2n6PFisi/+RG0OHjWw41hH4plMRNKXJpTvCKnI/t5bXNbUrDZzEx0h9WZ4LXP14L/EOzU7caKlvOGs9RQtSbtcBaz921Ra69+qs542WPFI8lSC2HMe82d2sNQSRbfhk3Upf3oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jT74nrU5; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5a7d6bc81c6so4898648eaf.2;
        Wed, 10 Apr 2024 09:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712765585; x=1713370385; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WD4ah+6AHBgHczyWQvPumlZfTe3vXiDmawFaF5dvJH8=;
        b=jT74nrU5aAw3ghIC9lGCLYli1VrbQGslVxGGOAkluTme6oQEVmgyVEmNtfikDL5+RX
         xohRC5YJ1zjmNG83GYfD444tBOC/mEsOZyq7MPWhtDIiJwrLOk/6oY5gnR1uy3CMfOsx
         s0c6XwglrY08Fkk6fmqB55lC4ISJu+UF5irtOgMvl5hKKhWCXg/k6mcUvsP8y4b5W9gn
         OS+HbbHoY0cFs704UboPGKaLeSnzALW5VrVQX0UXjzzHMRuc2twvnqEp0Iw3WT+uvGM4
         2Qhv5ZGWKM7l/AKKnNNaygr4+BCP77qOHrYhGIaBV/glrVP5Q7JGLYbpxFrZbzbffAnq
         08hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712765585; x=1713370385;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WD4ah+6AHBgHczyWQvPumlZfTe3vXiDmawFaF5dvJH8=;
        b=iDbnv2+rH5x3Qzamwm5+XnMcvMZJ5QVax4MqRB3a+qLvqMwtQAyxfXNyBYyRAcl1UC
         CbH+tUvEKGfSfAZHxkQlalUNkSj+ykQJWAU5WnrV3pn+3BKu2+daprR3OsO9Nd3+SzuM
         PZPO1mUJcHtEureYD6b8k+wS9a30qJ0Eeh20xLoxsA4MAM2nDHO87aPQYNn5MiBF06OT
         ALMLyYOvuAPF14eG9lDTr5LZQb7u50nHMniIKZoCfAxkqW8D7Z8c9qI71msikQP76c6V
         Rmd2EV+OeVm3+8t3efzXygjTukYSc2XdgPjUvWaC0z7+qQmuh5ot29Bz4EJ+54D26cR9
         AEEg==
X-Forwarded-Encrypted: i=1; AJvYcCVRKf4WAtsbd2uCrwznmeET3ztLApvt1nufKJcY0AVIe6c0lrglFL7CXM/fnLRMXss2fmqUOd8+B7gtBZFHKrHMPAScvPIHqsuAQddp
X-Gm-Message-State: AOJu0YwyyAkCbYUxIqAF/kgLrjoj6Sy5ZPb85woF0l+zthTKTGStZ4Ha
	dQNkbV2tE4hLqdbykAN0kt0n2k3cgx9zZanoIelFmB9NMZvQ0eUN
X-Google-Smtp-Source: AGHT+IG8kseDukhMLLg4zaEnxqa7XZcV89fTCiN8y3vTuHgCKPjxUjwFtcJutGdwfyAsrnnkZ4P62A==
X-Received: by 2002:a05:6871:7801:b0:22a:582a:9bcc with SMTP id oy1-20020a056871780100b0022a582a9bccmr3234482oac.53.1712765585061;
        Wed, 10 Apr 2024 09:13:05 -0700 (PDT)
Received: from [192.168.20.112] (76-251-167-31.lightspeed.austtx.sbcglobal.net. [76.251.167.31])
        by smtp.gmail.com with ESMTPSA id vq10-20020a056871a08a00b0022eac68988esm3172220oab.20.2024.04.10.09.13.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 09:13:04 -0700 (PDT)
Message-ID: <037179a4-5e7e-47cf-b0c2-ed6035df6041@gmail.com>
Date: Wed, 10 Apr 2024 11:13:03 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: Add a quirk for preventing D3 on a bridge
To: Mario Limonciello <mario.limonciello@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 Eric Heintzmann <heintzmann.eric@free.fr>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
References: <20240307163709.323-1-mario.limonciello@amd.com>
Content-Language: en-US
From: Mario Limonciello <superm1@gmail.com>
In-Reply-To: <20240307163709.323-1-mario.limonciello@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/7/24 10:37, Mario Limonciello wrote:
> Hewlett-Packard HP Pavilion 17 Notebook PC/1972 is an Intel Ivy Bridge
> system with a muxless AMD Radeon dGPU.  Attempting to use the dGPU fails
> with the following sequence:
> 
> ```
> ACPI Error: Aborting method \AMD3._ON due to previous error (AE_AML_LOOP_TIMEOUT) (20230628/psparse-529)
> radeon 0000:01:00.0: not ready 1023ms after resume; waiting
> radeon 0000:01:00.0: not ready 2047ms after resume; waiting
> radeon 0000:01:00.0: not ready 4095ms after resume; waiting
> radeon 0000:01:00.0: not ready 8191ms after resume; waiting
> radeon 0000:01:00.0: not ready 16383ms after resume; waiting
> radeon 0000:01:00.0: not ready 32767ms after resume; waiting
> radeon 0000:01:00.0: not ready 65535ms after resume; giving up
> radeon 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
> radeon 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
> ```
> 
> The issue is that the root port the dGPU is connected to can't handle
> the transition from D3cold to D0 so the dGPU can't properly exit runpm.
> 
> The existing logic in pci_bridge_d3_possible() checks for systems that
> are newer than 2015 to decide that D3 is safe.  This would nominally work
> for an Ivy Bridge system (which was discontinued in 2015), but this system
> appears to have continued to receive BIOS updates until 2017 and so this
> existing logic doesn't appropriately capture it.
> 
> Add the system to bridge_d3_blacklist to prevent port pm from being used.
> 
> Reported-and-tested-by: Eric Heintzmann <heintzmann.eric@free.fr>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3229
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/pci/pci.c | 12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index c3585229c12a..9d5d08a420f1 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -3102,6 +3102,18 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
>   			DMI_MATCH(DMI_BOARD_VERSION, "Continental Z2"),
>   		},
>   	},
> +	{
> +		/*
> +		 * Changing power state of root port dGPU is connected fails
> +		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3229
> +		 */
> +		.ident = "Hewlett-Packard HP Pavilion 17 Notebook PC/1972",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "Hewlett-Packard"),
> +			DMI_MATCH(DMI_BOARD_NAME, "1972"),
> +			DMI_MATCH(DMI_BOARD_VERSION, "95.33"),
> +		},
> +	},
>   #endif
>   	{ }
>   };

Bjorn,

Ping on this quirk.

