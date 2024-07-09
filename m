Return-Path: <linux-pci+bounces-9971-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CD392AE5E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 04:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E63C31C21DD9
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 02:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC783612D;
	Tue,  9 Jul 2024 02:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJTFvf0B"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 159633A29C;
	Tue,  9 Jul 2024 02:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720493828; cv=none; b=a+YKt37iP5zQwej83SOuKul0+pTpdtHDc7EETC+T/477DE6cbyoOZuxNRSO7gMGa3rkvR9IvYHdz7IVRXmkgHIm2D358Q2poSyFJVRM4Ch4WCU7U7B+TPoN9Nq7TFXsfPglcgjsVgIiNlEOkZ8qA4s4Ya7+MI0uCujb6fOtMD7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720493828; c=relaxed/simple;
	bh=L4KvOLHA9APNyAatBQSWMGun+WkqibNGe1IIFkU3g1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i8G3Rw3shNNdxmiF7f02t3R0B9/ZzdZr9mA1AoWRmvM0eAKwilF5p5Ux0/k10LcXT2W4AqYupgDauCdBh24I+9yq56BJCGQNNKIvPBpxlXYHtyPIdt2uH2BDfEJ+L2M5y8OdAI2065Z/7dpbMNfPl0JcFqpoYb7+ABoPPEe6oXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJTFvf0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20843C116B1;
	Tue,  9 Jul 2024 02:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720493827;
	bh=L4KvOLHA9APNyAatBQSWMGun+WkqibNGe1IIFkU3g1M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kJTFvf0BvektW9iHALrfIGynBQq3arEi0n0dtny0Wolco0jDKblApjyZgjjwHIbrd
	 wqBltwIW8POIay2xibWNM0rR1iPrF87KKYQ82J6OicGQeILAguPYmonDQoSg1SP4of
	 NPoETE7RQtRwfstO7BcMTwk4K7s3+b+YWNUD3iKJ0ZDDynjc/fPrbU3Z3oA2mXtwRq
	 1W4N2TPNGL5hbjj5GQsJ3GLB2FE+OWQrWbzsNXlTwgq/LItfsg88rz8N4PaMqApm36
	 RZxw42FQGP/CvapHoJPer/2JrmbWk4RjdupEdlzssohwFSNHHGl1Tx6SbaTJ+SiHi3
	 spy+8h5f4MbXQ==
Message-ID: <bf238892-4d53-4732-a138-11aa6af1dbe3@kernel.org>
Date: Mon, 8 Jul 2024 21:57:06 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI/PM: Avoid D3cold for HP Spectre x360 Convertible
 15-ch0xx PCIe Ports
To: superm1@kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc: "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>, Tony Murray <murraytony@gmail.com>
References: <20240629001743.1573581-1-superm1@kernel.org>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20240629001743.1573581-1-superm1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/28/2024 19:17, superm1@kernel.org wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> HP Spectre x360 Convertible 15-ch0xx is an Intel Kaby Lake-G system that
> contains an AMD Polaris Radeon dGPU.
> Attempting to use the dGPU fails with the following sequence:
> 
>    amdgpu 0000:01:00.0: not ready 1023ms after resume; waiting
>    amdgpu 0000:01:00.0: not ready 2047ms after resume; waiting
>    amdgpu 0000:01:00.0: not ready 4095ms after resume; waiting
>    amdgpu 0000:01:00.0: not ready 8191ms after resume; waiting
>    amdgpu 0000:01:00.0: not ready 16383ms after resume; waiting
>    amdgpu 0000:01:00.0: not ready 32767ms after resume; waiting
>    amdgpu 0000:01:00.0: not ready 65535ms after resume; giving up
>    amdgpu 0000:01:00.0: Unable to change power state from D3cold to D0, device inaccessible
>    [drm:atom_op_jump [amdgpu]] *ERROR* atombios stuck in loop for more than 20secs aborting
> 
> The issue is that the Root Port the dGPU is connected to can't handle the
> transition from D3cold to D0 so the dGPU can't properly exit runtime PM.
> 
> The existing logic in pci_bridge_d3_possible() checks for systems that are
> newer than 2015 to decide that D3 is safe, but this system appears not to
> work properly.
> 
> Add the system to bridge_d3_blacklist to prevent D3cold from being used.
> 
> Reported-and-tested-by: Tony Murray <murraytony@gmail.com>
> Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/3389
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>   drivers/pci/pci.c | 11 +++++++++++
>   1 file changed, 11 insertions(+)
> 
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 35fb1f17a589..65e3a550052f 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -2965,6 +2965,17 @@ static const struct dmi_system_id bridge_d3_blacklist[] = {
>   			DMI_MATCH(DMI_BOARD_VERSION, "95.33"),
>   		},
>   	},
> +	{
> +		/*
> +		 * Changing power state of root port dGPU is connected fails
> +		 * https://gitlab.freedesktop.org/drm/amd/-/issues/3229
> +		 */
> +		.ident = "HP Spectre x360 Convertible 15-ch0xx",
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "HP"),
> +			DMI_MATCH(DMI_BOARD_NAME, "83BB"),
> +		},
> +	},
>   #endif
>   	{ }
>   };

Bjorn,

Ping on this one.  It's a trivial quirk that Tony and I already root 
caused on Gitlab, I'd hope this can be squeezed in.

Thanks,

