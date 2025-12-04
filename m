Return-Path: <linux-pci+bounces-42614-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5796FCA2E11
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 10:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63C94305F329
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 09:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71BCC3346AA;
	Thu,  4 Dec 2025 09:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NU38EzOr"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F96433122B
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764838815; cv=none; b=oyt1hv5KGher1856tAhTfyxxkDSuLEF6CL65Mar5txzq3G9nkHhceY3l6wPj2BzQ2BIPQ0/LC4PEADv88/3xNMQ3BjhlZUCabPuAlSXWsOLNg5wzgAV7doKzDcSqzjEQldiMecKY6+oMGPsefJGhqdF76UXtWDl32IjHGrof40g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764838815; c=relaxed/simple;
	bh=q+LoIUfzJ18p1AvuqPRtbQ36awNa8jT+GpAg4XKdlv8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DadZuCBCee+A9+EDMTMKfi3heYS+iz1BxSN2KuIwJhMGTHZ7qioYuWQ+teY+4eyhOtJuRRv0+jwvH4TSSLZBH1PkCHsI39N11eAxlHD4L3/66nP2t2ijkM6iwcJ7Gn/P71koyClDsr9WFwkIDmQnRzvT42P0hwqPpmsB5vcp9xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NU38EzOr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47774d3536dso6451065e9.0
        for <linux-pci@vger.kernel.org>; Thu, 04 Dec 2025 01:00:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764838811; x=1765443611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O0N1lMmbauFOWlZlRSXcG6h3Jmv0DRpHx+qvG3J8bOA=;
        b=NU38EzOrKXpV1QRnwNWD+ih4rHCjqevHViUcDUVHrBe2k8vplKxvUkMkMXYmq0EEO8
         Wb1Uf7FTnLpWR6fJdkP8HNZntWSzjAtKS3OC4O6vSkof6AWiisNwf9LSI03r+iaobv6Z
         LYtD0GBjp5uOBFCJhWwX9AYL+K/+RgfYCWVdpP3bXsw7+Gb8O9f7X+TkbxpccaKF1soJ
         UlMBG7MtHd1lftqdCS2MvMk8zZ7X/NHH2i/T6OKlarYnzFgs3UGFhM33JM0aBPk5R+oi
         h0Kxu7YtzGd4ESfXGYPX87JRacBCMe8vM7DjGFv5HQbTZ3WYegu6AOfCLtRKJnWv0Ide
         5OUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764838811; x=1765443611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O0N1lMmbauFOWlZlRSXcG6h3Jmv0DRpHx+qvG3J8bOA=;
        b=iG+E5gi1B6tgiDFJWU8riXQQelU+mWqAsm9ImOLYJMfpM7EeSikVAd+XIizmVlOt0s
         WL6+aHBJdJgYdAxcnDm5O/xJHyDrZLdI1OLzdlK9tD10lpkilPWDUAZMlQKW4fVMVtrV
         rxVrxbgUwt5QhQKA992UeeRY8V54PVWZlOGMslv85Nh1Be5Taun6UM+cVeR2fwbS36oa
         /WttT4fPxUnXpEIYaTe00Tv6Chp8wqta8VXF/pUq3w8/TNcmfjlkd44U4KDldU74ZfF9
         I46o4VnAMLf8hAZzoLxJlG3KThE2k3/IS44Y2UrdfQ7iiVVRW14k133CzfSM7zuexGS4
         zpzA==
X-Forwarded-Encrypted: i=1; AJvYcCXqIWIl3hfS/6XllAYNEl0wjJV6xEtGXYCOWGbyJK9nmR25XHoR6C5qInojk1ga3QuQ7f7RnFBPQ0A=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCtjDul1ubSJ1DKQcQtHXoJZwuGvOM6WXXHF4wljRDMIfiqXnQ
	BzjXNvv65YtHYVmJRPYgVkwcM9vCJWFVQVTYFMsuOYccfjwYY0mmBunV
X-Gm-Gg: ASbGncvo3H4oMJ6o5Xdi/QY6AXnW+KwoSK2zrp59iiUm0VaVRuz+9//UfE/rTBKxIkW
	75s0ii8tDDWGA5NNg5j2NHq8frO0VTSE9/suy+UNSyj1d/FTuzfun/Qs0khm442dXJWmUZnLCvD
	KcL8C+33bbwv8/3Lh3QRaqFGlU4aEoIgiiYqBjuX93iKFb3WedMhy4V7PvWoEAkk6wd565eM31G
	t+ItHCIBQUk0ODU9Aqz7Gzib0pcN5WLTAy5pmGyafL3yZkjOKd+r7kCQv8Vah4ilbu584KtOuZM
	xQ/+9kt4m67wbFCdDIwa2pI9Tv68kM9iQ7oyj7T6qMDVb6672kRPiwr8/1akZrskAKBVbbwIrid
	fKBFDrWK6GChn1nIqN/2VghP30ekPAVxPyIetlUYFBeJx/EwEGdNGnAKrhknCqbTbfdysnYltzV
	PXDrtyFi2y1lN3yGIGVEO6PcBFVLOwlvmwf5Q=
X-Google-Smtp-Source: AGHT+IEZI+dBTeR4Ak8g8nW+sjyLOTD0PlMW1hfxTxArztZFbDdkrdMe37KP4yjwsiEfaEvbmxRqVw==
X-Received: by 2002:a05:600c:4504:b0:477:a289:d854 with SMTP id 5b1f17b1804b1-4792eb223a2mr26071405e9.5.1764838809635;
        Thu, 04 Dec 2025 01:00:09 -0800 (PST)
Received: from [10.221.198.188] ([165.85.126.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4792b02e7fbsm33545725e9.2.2025.12.04.01.00.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Dec 2025 01:00:09 -0800 (PST)
Message-ID: <affc62bb-a824-4433-b746-45bb8dd3654b@gmail.com>
Date: Thu, 4 Dec 2025 11:00:07 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/mlx5: Fix double unregister of HCA_PORTS
 component
To: Gerd Bayer <gbayer@linux.ibm.com>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shay Drory <shayd@nvidia.com>, Simon Horman <horms@kernel.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bjorn Helgaas <helgaas@kernel.org>,
 Niklas Schnelle <schnelle@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20251202-fix_lag-v1-1-59e8177ffce0@linux.ibm.com>
Content-Language: en-US
From: Tariq Toukan <ttoukan.linux@gmail.com>
In-Reply-To: <20251202-fix_lag-v1-1-59e8177ffce0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 02/12/2025 13:12, Gerd Bayer wrote:
> Clear hca_devcom_comp in device's private data after unregistering it in
> LAG teardown. Otherwise a slightly lagging second pass through
> mlx5_unload_one() might try to unregister it again and trip over
> use-after-free.
> 
> On s390 almost all PCI level recovery events trigger two passes through
> mxl5_unload_one() - one through the poll_health() method and one through
> mlx5_pci_err_detected() as callback from generic PCI error recovery.
> While testing PCI error recovery paths with more kernel debug features
> enabled, this issue reproducibly led to kernel panics with the following
> call chain:
> 
>   Unable to handle kernel pointer dereference in virtual kernel address space
>   Failing address: 6b6b6b6b6b6b6000 TEID: 6b6b6b6b6b6b6803 ESOP-2 FSI
>   Fault in home space mode while using kernel ASCE.
>   AS:00000000705c4007 R3:0000000000000024
>   Oops: 0038 ilc:3 [#1]SMP
> 
>   CPU: 14 UID: 0 PID: 156 Comm: kmcheck Kdump: loaded Not tainted
>        6.18.0-20251130.rc7.git0.16131a59cab1.300.fc43.s390x+debug #1 PREEMPT
> 
>   Krnl PSW : 0404e00180000000 0000020fc86aa1dc (__lock_acquire+0x5c/0x15f0)
>              R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
>   Krnl GPRS: 0000000000000000 0000020f00000001 6b6b6b6b6b6b6c33 0000000000000000
>              0000000000000000 0000000000000000 0000000000000001 0000000000000000
>              0000000000000000 0000020fca28b820 0000000000000000 0000010a1ced8100
>              0000010a1ced8100 0000020fc9775068 0000018fce14f8b8 0000018fce14f7f8
>   Krnl Code: 0000020fc86aa1cc: e3b003400004        lg      %r11,832
>              0000020fc86aa1d2: a7840211           brc     8,0000020fc86aa5f4
>             *0000020fc86aa1d6: c09000df0b25       larl    %r9,0000020fca28b820
>             >0000020fc86aa1dc: d50790002000       clc     0(8,%r9),0(%r2)
>              0000020fc86aa1e2: a7840209           brc     8,0000020fc86aa5f4
>              0000020fc86aa1e6: c0e001100401       larl    %r14,0000020fca8aa9e8
>              0000020fc86aa1ec: c01000e25a00       larl    %r1,0000020fca2f55ec
>              0000020fc86aa1f2: a7eb00e8           aghi    %r14,232
> 
>   Call Trace:
>    __lock_acquire+0x5c/0x15f0
>    lock_acquire.part.0+0xf8/0x270
>    lock_acquire+0xb0/0x1b0
>    down_write+0x5a/0x250
>    mlx5_detach_device+0x42/0x110 [mlx5_core]
>    mlx5_unload_one_devl_locked+0x50/0xc0 [mlx5_core]
>    mlx5_unload_one+0x42/0x60 [mlx5_core]
>    mlx5_pci_err_detected+0x94/0x150 [mlx5_core]
>    zpci_event_attempt_error_recovery+0xcc/0x388
> 
> Fixes: 5a977b5833b7 ("net/mlx5: Lag, move devcom registration to LAG layer")
> Signed-off-by: Gerd Bayer <gbayer@linux.ibm.com>
> ---
> Hi Shay et al,
> 
> while checking for potential regressions by Lukas Wunner's recent work
> on pci_save/restore_state() for the recoverability of mlx5 functions I
> consistently hit this bug. (Bjorn has queued this up for 6.19, according
> to [0] and [1])
> 
> Apparently, the issue is unrelated to Lukas' work but can be reproduced
> with master. It appears to be timing-sensitive, since it shows up only
> when I use s390's debug_defconfig, but I think needs fixing anyhow, as
> timing can change for other reasons, too.
> 
> I've spotted two additional places where the devcom reference is not
> cleared after calling mlx5_devcom_unregister_component() in
> drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c that I have not
> addressed with a patch, since I'm unclear about how to test these
> paths.
> 
> Thanks,
> Gerd
> 
> [0] https://lore.kernel.org/all/cover.1760274044.git.lukas@wunner.de/
> [1] https://lore.kernel.org/linux-pci/cover.1763483367.git.lukas@wunner.de/
> ---
>   drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> index 3db0387bf6dcb727a65df9d0253f242554af06db..8ec04a5f434dd4f717d6d556649fcc2a584db847 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c
> @@ -1413,6 +1413,7 @@ static int __mlx5_lag_dev_add_mdev(struct mlx5_core_dev *dev)
>   static void mlx5_lag_unregister_hca_devcom_comp(struct mlx5_core_dev *dev)
>   {
>   	mlx5_devcom_unregister_component(dev->priv.hca_devcom_comp);
> +	dev->priv.hca_devcom_comp = NULL;
>   }
>   
>   static int mlx5_lag_register_hca_devcom_comp(struct mlx5_core_dev *dev)
> 
> ---
> base-commit: 4a26e7032d7d57c998598c08a034872d6f0d3945
> change-id: 20251202-fix_lag-6a59b39a0b3c
> 
> Best regards,

Thanks for your patch.
Acked-by: Tariq Toukan <tariqt@nvidia.com>


