Return-Path: <linux-pci+bounces-33228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E793B16F4E
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 12:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F5D316F349
	for <lists+linux-pci@lfdr.de>; Thu, 31 Jul 2025 10:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A7CB2BDC2B;
	Thu, 31 Jul 2025 10:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kYOsmPY2"
X-Original-To: linux-pci@vger.kernel.org
Received: from sinmsgout03.his.huawei.com (sinmsgout03.his.huawei.com [119.8.177.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED57746E;
	Thu, 31 Jul 2025 10:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=119.8.177.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753957030; cv=none; b=LkXhk5H+UZwS22NZ/2KHHIkMpssDVBaLE+nqjbg7Yf2FhH+lJiJoj8y3MNGDoRAc86aDaXBwjMJWyS1bDdu7GAmjC1uP99W60+ujxutNNKJqu0cuODGdbMTA7dLhggBcduFi4FafFx+/v6GQRW/Vlt1+REZri6zQAB2/j7uPwwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753957030; c=relaxed/simple;
	bh=1ge10SimQgClwKzIPVT8dLGvqbktLvZclq3HaYeWrlw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASEGjlU8LOhasqv61cVsRxoO+bHoX4koQSZLE1uHaNJbN1ZXEXwUX6cJWXZ2AE/pO95RxGB24XisQnrloSU23Npzni7D/9bX+azJ9VDRIE6GNOD0WT1dOFxaQKNWRedDdT0m4QH1HYZq2e3qBHwYZswDZ51QE8m/7+BWaRfUS9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kYOsmPY2; arc=none smtp.client-ip=119.8.177.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=elVMsWjrXDTFJwMh0ONTgI3nc4OnW+eMijfTpCVJyec=;
	b=kYOsmPY2snO9PX46f1o4SYGURcTdTmBNTzUAdw1KMcrmXyuDbTl00ESC6oSt9s6hnonj1HZQk
	bBQchkFwKEIXdszWEkjERdR/4gffGTYSCCl3GA8zKKXSLFt2hCS/HJgh2Y+KJ2VIVZJP+YeV1i0
	RWznSPQGusCWEtWjI+gBtyo=
Received: from frasgout.his.huawei.com (unknown [172.18.146.36])
	by sinmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4bt4hy1XsXzMktC;
	Thu, 31 Jul 2025 18:15:30 +0800 (CST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bt4hQ0tQgz6J66k;
	Thu, 31 Jul 2025 18:15:02 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B07331402F4;
	Thu, 31 Jul 2025 18:17:00 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 31 Jul
 2025 12:16:59 +0200
Date: Thu, 31 Jul 2025 11:16:58 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
CC: <linux-coco@lists.linux.dev>, <kvmarm@lists.linux.dev>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <aik@amd.com>,
	<lukas@wunner.de>, Samuel Ortiz <sameo@rivosinc.com>, Xu Yilun
	<yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>, "Suzuki K
 Poulose" <Suzuki.Poulose@arm.com>, Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>, Marc Zyngier <maz@kernel.org>,
	Will Deacon <will@kernel.org>, Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 37/38] coco: guest: arm64: Add support for
 fetching device measurements
Message-ID: <20250731111658.00006492@huawei.com>
In-Reply-To: <20250728135216.48084-38-aneesh.kumar@kernel.org>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
	<20250728135216.48084-38-aneesh.kumar@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 28 Jul 2025 19:22:14 +0530
"Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:

> Fetch device measurements using RSI_RDEV_GET_MEASUREMENTS.
> 
> Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
One completely trivial comment.

J
> diff --git a/drivers/virt/coco/arm-cca-guest/rsi-da.c b/drivers/virt/coco/arm-cca-guest/rsi-da.c
> index 64034d220e02..6222b10964ee 100644
> --- a/drivers/virt/coco/arm-cca-guest/rsi-da.c
> +++ b/drivers/virt/coco/arm-cca-guest/rsi-da.c

> @@ -213,6 +245,13 @@ int rsi_device_lock(struct pci_dev *pdev)
>  		return -EIO;
>  	}
>  
> +	ret = rhi_get_report(vdev_id, RHI_DA_OBJECT_MEASUREMENT,
> +			     &dsm->measurements, &dsm->measurements_size);
> +	if (ret) {
> +		pci_err(pdev, "failed to get device certificate from the host (%lu)\n", ret);
> +		return -EIO;
> +	}
> +
>  	return ret;

return 0;  Always good to make it explicit when it can't take any other values.
Looks like that belong sin an earlier patch though based on this snippet.


>  }


