Return-Path: <linux-pci+bounces-17922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 513A39E9288
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 12:35:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C856516140B
	for <lists+linux-pci@lfdr.de>; Mon,  9 Dec 2024 11:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2259321D019;
	Mon,  9 Dec 2024 11:34:58 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DCBC21B8E7;
	Mon,  9 Dec 2024 11:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733744098; cv=none; b=H80ii8amkT+Yordbyj+v0oaHfQyXw/qdHSvc6No1U7PWprPeyMsEe4z2eB63DlBV6i3UzA01GOs9hWVoMW10yoEsfjPWlBSpS3dHOe+ZX4YNNI6bnRpV4WvgRJakkc3UVpTsfHuMSxl+I45IdKtRYQxGMFv1NEFM9ScWVuD0TIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733744098; c=relaxed/simple;
	bh=7yj+ho3eGntuJsIADyxqGayzAvC2M/QWCJcLVACYVsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z+mvzozKI9ncQwAghnN4QLgBZiSAAcmG+2WxAgqIB7PlqWFE+A0psuwgM7yyskyAi0UOltd4q3RL/q+hAdnzLvARPD624cPxyxx5SaO3m5vMRicVQuxpcTD+gzQ8NoAd5MP386Zy5krMQfqc5AgvhZyAfBJtGH3CsS9esbXurng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aee8e.dynamic.kabel-deutschland.de [95.90.238.142])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 84D0861E6476B;
	Mon, 09 Dec 2024 12:34:09 +0100 (CET)
Message-ID: <7c4f3165-df86-47e1-9fc4-7087accf4a68@molgen.mpg.de>
Date: Mon, 9 Dec 2024 12:34:08 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2] e1000e: Fix real-time
 violations on link up
To: Gerhard Engleder <gerhard@engleder-embedded.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, Gerhard Engleder <eg@keba.com>,
 Vitaly Lifshits <vitaly.lifshits@intel.com>, linux-pci@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20241208184950.8281-1-gerhard@engleder-embedded.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20241208184950.8281-1-gerhard@engleder-embedded.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

[Cc: +PCI folks]

Dear Gerhard,


Thank you for your patch.


Am 08.12.24 um 19:49 schrieb Gerhard Engleder:
> From: Gerhard Engleder <eg@keba.com>
> 
> From: Gerhard Engleder <eg@keba.com>

The from line is present twice. No idea, if git is going to remove both.

> Link down and up triggers update of MTA table. This update executes many
> PCIe writes and a final flush. Thus, PCIe will be blocked until all writes
> are flushed. As a result, DMA transfers of other targets suffer from delay
> in the range of 50us. This results in timing violations on real-time
> systems during link down and up of e1000e.
> 
> A flush after a low enough number of PCIe writes eliminates the delay
> but also increases the time needed for MTA table update. The following
> measurements were done on i3-2310E with e1000e for 128 MTA table entries:
> 
> Single flush after all writes: 106us
> Flush after every write:       429us
> Flush after every 2nd write:   266us
> Flush after every 4th write:   180us
> Flush after every 8th write:   141us
> Flush after every 16th write:  121us
> 
> A flush after every 8th write delays the link up by 35us and the
> negative impact to DMA transfers of other targets is still tolerable.
> 
> Execute a flush after every 8th write. This prevents overloading the
> interconnect with posted writes.
> 
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> CC: Vitaly Lifshits <vitaly.lifshits@intel.com>
> Link: https://lore.kernel.org/netdev/f8fe665a-5e6c-4f95-b47a-2f3281aa0e6c@lunn.ch/T/
> Signed-off-by: Gerhard Engleder <eg@keba.com>
> ---
> v2:
> - remove PREEMPT_RT dependency (Andrew Lunn, Przemek Kitszel)
> ---
>   drivers/net/ethernet/intel/e1000e/mac.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/e1000e/mac.c b/drivers/net/ethernet/intel/e1000e/mac.c
> index d7df2a0ed629..7d1482a9effd 100644
> --- a/drivers/net/ethernet/intel/e1000e/mac.c
> +++ b/drivers/net/ethernet/intel/e1000e/mac.c
> @@ -331,8 +331,13 @@ void e1000e_update_mc_addr_list_generic(struct e1000_hw *hw,
>   	}
>   
>   	/* replace the entire MTA table */
> -	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--)
> +	for (i = hw->mac.mta_reg_count - 1; i >= 0; i--) {
>   		E1000_WRITE_REG_ARRAY(hw, E1000_MTA, i, hw->mac.mta_shadow[i]);
> +
> +		/* do not queue up too many writes */

Maybe make the comment more elaborate?

> +		if ((i % 8) == 0 && i != 0)
> +			e1e_flush();
> +	}
>   	e1e_flush();
>   }


Kind regards,

Paul

