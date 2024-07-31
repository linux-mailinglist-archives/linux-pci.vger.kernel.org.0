Return-Path: <linux-pci+bounces-11053-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95123943006
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 15:27:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E21C6B21850
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716051B0123;
	Wed, 31 Jul 2024 13:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="OG0plAhm"
X-Original-To: linux-pci@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15B51B14E9
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 13:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722432418; cv=none; b=KdIituujzfs8A5pKu+q+jjr+5bt0/LlKE5M9woxBqti3dxVgQODkJNiM9vngVQF6UKcm2RoH2EycbW6uyIndX7Td/PXBWfXZMPg1RKYsfKFvUsV/5cvWR61tGz8z0sBNYsIwWRNJ1eFrk6jMDEuLJiVp2/3wIEKWWjjp1/NNqBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722432418; c=relaxed/simple;
	bh=1pxyHklx0dZzFSCAeZVxv961y39cas8ZzxrfAZ7wGCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S2snpxxIvb41ZrJS32IKFxnhpM8fytFzadq7AQK4aW2qUVYNLs9uFm+9xYyDsXKpMsYkwVZyG7g2d1tcB8GwIw56CDJWTnNRVMzF4W5f5JnqL/Gj1e2Ablnnh6RsgTjlFcgbmgHEqBh2ORk05N9lJcGMx3vbI0fzTBol89KDmS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=OG0plAhm; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2e697d0f-d1bb-443d-890f-0e1d953e8c1f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1722432413;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AKzWt3W/M/Jxmp/25NUe1y1cnbKsZzftAQcvAh5wFbU=;
	b=OG0plAhmNY53TGlp7kLA5wSaRDpgFtsO0ib67rPc9P1tEO60NJP/4xiZqLpVMr/UsAjrZs
	1Zn7i3TIRFxZDosuygt7/ssCdfMb/BH1NvG8PJhN/JbP1gb1DV7HpJqpGnCG8bhhBKltSX
	OCVES6xTHObPmSS59nRT2RfJVyP7mSk=
Date: Wed, 31 Jul 2024 14:26:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next V3 0/3] mlx5 PTM cross timestamping support
To: Tariq Toukan <tariqt@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 John Stultz <jstultz@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Frederic Weisbecker <frederic@kernel.org>, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Carolina Jubran <cjubran@nvidia.com>, Bar Shapira <bshapira@nvidia.com>,
 Rahul Rameshbabu <rrameshbabu@nvidia.com>
References: <20240730134055.1835261-1-tariqt@nvidia.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240730134055.1835261-1-tariqt@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 30/07/2024 14:40, Tariq Toukan wrote:
> Hi,
> 
> This is V3. You can find V2 as part of a larger series here:
> https://lore.kernel.org/netdev/d1dba3e1-2ecc-4fdf-a23b-7696c4bccf45@gmail.com/T/
> 
> This patchset by Rahul and Carolina adds PTM (Precision Time Measurement)
> support to the mlx5 driver.
> 
> PTM is a PCI extended capability introduced by PCI-SIG for providing an
> accurate read of the device clock offset without being impacted by
> asymmetric bus transfer rates.
> 
> The performance of PTM on ConnectX-7 was evaluated using both real-time
> (RTC) and free-running (FRC) clocks under traffic and no traffic
> conditions. Tests with phc2sys measured the maximum offset values at a 50Hz
> rate, with and without PTM.
> 
> Results:
> 
> 1. No traffic
> +-----+--------+--------+
> |     | No-PTM | PTM    |
> +-----+--------+--------+
> | FRC | 125 ns | <29 ns |
> +-----+--------+--------+
> | RTC | 248 ns | <34 ns |
> +-----+--------+--------+
> 
> 2. With traffic
> +-----+--------+--------+
> |     | No-PTM | PTM    |
> +-----+--------+--------+
> | FRC | 254 ns | <40 ns |
> +-----+--------+--------+
> | RTC | 255 ns | <45 ns |
> +-----+--------+--------+
> 
> 
> Series generated against:
> commit 1722389b0d86 ("Merge tag 'net-6.11-rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net")
> 
> Thanks,
> Tariq.
> 
> V3:
> - Rebased on latest. As a result, had to replace the call to the recently
>    removed function convert_art_ns_to_tsc().
> - Added more CCs to the series per Jakub's feedback.
> - Added perf numbers.
> 
> 
> Carolina Jubran (1):
>    net/mlx5: Add support for enabling PTM PCI capability
> 
> Rahul Rameshbabu (2):
>    net/mlx5: Add support for MTPTM and MTCTR registers
>    net/mlx5: Implement PTM cross timestamping support
> 
>   drivers/net/ethernet/mellanox/mlx5/core/fw.c  |  1 +
>   .../ethernet/mellanox/mlx5/core/lib/clock.c   | 91 +++++++++++++++++++
>   .../net/ethernet/mellanox/mlx5/core/main.c    |  6 ++
>   include/linux/mlx5/device.h                   |  7 +-
>   include/linux/mlx5/driver.h                   |  2 +
>   include/linux/mlx5/mlx5_ifc.h                 | 43 +++++++++
>   6 files changed, 149 insertions(+), 1 deletion(-)
> 

For the series:

Tested-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

