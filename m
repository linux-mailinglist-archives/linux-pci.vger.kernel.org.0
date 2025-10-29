Return-Path: <linux-pci+bounces-39689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 733F4C1C4D8
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 17:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9574E18800EF
	for <lists+linux-pci@lfdr.de>; Wed, 29 Oct 2025 16:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8AC2F5A26;
	Wed, 29 Oct 2025 16:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="zKXYuAmA"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout02.his.huawei.com (sinmsgout02.his.huawei.com [119.8.177.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE362F2914;
	Wed, 29 Oct 2025 16:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761756861; cv=none; b=qXn8hPn1v+YPibgxWk6+pxKnC8U2qJvdbyj9zLFu8y3/DdADHCfwMEZ+jOqpjr0NEVGRtpwAo90F13p4+5bQ/gquoS8MpmYiJwOU6Lx4d2NvUChjJckfbdCWbNYAu5274OBkTeouXU7UINTPmURFykcCInOcpSUToF6hJooww6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761756861; c=relaxed/simple;
	bh=cqMOhgJNEJRGWDHyeQNSDCAzBFBytooZvZF7oJrv4YM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrAJqi/6zatDwbT0Tc8emJlN1+foWIFt7yeZCRWqREv3A8r5cSIXwnRWTOU19u3rTHrR1XdUgnfqrU96yNZtUNDEImxiUYahL8mstBlOPjajfNhCDNnfjcoVYh3A/9WorlH62kHUjgPhaxN53eJCGu1cMRYqPkHmmHulaAkItAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=zKXYuAmA; arc=none smtp.client-ip=119.8.177.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=m2jSDZVK5vTMEmTMmE/pg6ZtWZC0lCPNthsEXNeUeCs=;
	b=zKXYuAmAksPcURPrpFxMTt8CoCLiyYUiJZLpqU4WU6CZFcLZFPm4JtKtjj5octcqLd62JA0pP
	ZAcTw2KnxB0MKj3FfqZl18XofBkU+AxLhbF/LXBogz5yj6yo3KNJCecug0Mx7KP60d0iUjcat7r
	NRxTySbW8xpQU03tsMOMHjU=
Received: from frasgout.his.huawei.com (unknown [172.18.146.35])
	by sinmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cxYGT5HWYz1vnt7;
	Thu, 30 Oct 2025 00:53:21 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cxYBt6m3Cz6M4Zj;
	Thu, 30 Oct 2025 00:50:14 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D8E2A140371;
	Thu, 30 Oct 2025 00:54:05 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 29 Oct
 2025 16:54:04 +0000
Date: Wed, 29 Oct 2025 16:54:03 +0000
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<dan.j.williams@intel.com>, <aik@amd.com>, <lukas@wunner.de>, Samuel Ortiz
	<sameo@rivosinc.com>, Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe
	<jgg@ziepe.ca>, Suzuki K Poulose <Suzuki.Poulose@arm.com>, Steven Price
	<steven.price@arm.com>, Bjorn Helgaas <helgaas@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>, Will Deacon
	<will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [PATCH RESEND v2 03/12] coco: guest: arm64: Drop dummy RSI
 platform device stub
Message-ID: <20251029165403.00000178@huawei.com>
In-Reply-To: <20251027095602.1154418-4-aneesh.kumar@kernel.org>
References: <20251027095602.1154418-1-aneesh.kumar@kernel.org>
	<20251027095602.1154418-4-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Mon, 27 Oct 2025 15:25:53 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> The SMCCC firmware driver now creates the `arm-smccc` platform device
> and also creates the CCA auxiliary devices once the RSI ABI is
> discovered. This makes the arch-specific arm64_create_dummy_rsi_dev()
> helper redundant. Remove the arm-cca-dev platform device registration
> and let the SMCCC probe manage the RSI device.
> 
> systemd match on platform:arm-cca-dev for confidential vm detection [1].
> Losing the platform device registration can break that. Keeping this
> removal in its own change makes it easy to revert if that regression
> blocks the rollout.
> 
> [1] https://lore.kernel.org/all/4a7d84b2-2ec4-4773-a2d5-7b63d5c683cf@arm.com
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
Fair enough keeping it separate for now I guess.
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>

(and I see from that thread I did look at the RFC but clearly forgot all
 about it :( )
> ---
>  arch/arm64/kernel/rsi.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/arch/arm64/kernel/rsi.c b/arch/arm64/kernel/rsi.c
> index 5d711942e543..1b716d18b80e 100644
> --- a/arch/arm64/kernel/rsi.c
> +++ b/arch/arm64/kernel/rsi.c
> @@ -158,18 +158,3 @@ void __init arm64_rsi_init(void)
>  
>  	static_branch_enable(&rsi_present);
>  }
> -
> -static struct platform_device rsi_dev = {
> -	.name = "arm-cca-dev",
> -	.id = PLATFORM_DEVID_NONE
> -};
> -
> -static int __init arm64_create_dummy_rsi_dev(void)
> -{
> -	if (is_realm_world() &&
> -	    platform_device_register(&rsi_dev))
> -		pr_err("failed to register rsi platform device\n");
> -	return 0;
> -}
> -
> -arch_initcall(arm64_create_dummy_rsi_dev)


