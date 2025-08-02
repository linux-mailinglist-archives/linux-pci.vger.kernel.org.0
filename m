Return-Path: <linux-pci+bounces-33329-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DD22B18E1A
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 12:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 241BF1AA3571
	for <lists+linux-pci@lfdr.de>; Sat,  2 Aug 2025 10:58:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AEF3214236;
	Sat,  2 Aug 2025 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D9JPvheG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B78DB672;
	Sat,  2 Aug 2025 10:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754132257; cv=none; b=TSgZPJ3nFC66x5XMQO6bLB1Bmex0y7X7auPj2V3bK8WJY1lzkBR5JD4f1HTrYUh0biIjhk8H1MpDttqPQmN8H9uj/KzJIS3byX/5D7RM70NTpqGQqhzCPyDO0amBl5zTB4Lvc+jaBi/J/6xurQeCTavdW49VQc1dQcHULKw9Wd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754132257; c=relaxed/simple;
	bh=clbgbsMt3khlBh1zo7AWnZlnjKpIprNMau6o2C0vF4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jMk0yOYpy6jVQbXcJ0UL+M5y1Jp9NlrhLHKyqNLwoKoNLnO92y2LH9UiIzLbA1mc1YgGxR2a9ntzzrMc2YyhshEjCnHZYq3iqvQaU1/2oHkRTqbhJdkJrYEK8/0sA15aNpbx7NCf6wcbP8m5lQtVlUKWGwNjikDI4n1oMC2X8+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D9JPvheG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EC5CC4CEEF;
	Sat,  2 Aug 2025 10:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754132256;
	bh=clbgbsMt3khlBh1zo7AWnZlnjKpIprNMau6o2C0vF4Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=D9JPvheG7cYRmX2iflebwiVrM21lynKOJviskGMzlLucWRDfGeY10kzCQ7Nb6yEA+
	 ZH8dzz6i35WN6zHCA9znezlsmhk6UdR4xIehp0phMfu+n84kvPs+TbSJ2SyUI4rWfG
	 eifAw1wagU2225fkXBdyjAEFhb8ala79rxxlzcUu4SGdFKBuIoh8eysZ7ninsOeQT+
	 jWuZ5pBOvM/oKjKOd6Fcy0cxz926AAJLBqYgkv+QsYzxfCvsc/gLmT8GKLaU5e0oI5
	 RVoPueIT6XmmO7UbYuxIuTY8ccwLtmSJ4kyRTu/UQdvaAYrrahsv8ov3AjtCcf8t2d
	 jwK8vW3poNJHA==
X-Mailer: emacs 30.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Arto Merilainen <amerilainen@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, aik@amd.com,
	linux-coco@lists.linux.dev, lukas@wunner.de, kvmarm@lists.linux.dev,
	Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 13/38] coco: host: arm64: Create a PDEV with rmm
In-Reply-To: <69c1bd48-c55b-4af1-a48b-1669102af1be@nvidia.com>
References: <20250728135216.48084-1-aneesh.kumar@kernel.org>
 <20250728135216.48084-14-aneesh.kumar@kernel.org>
 <69c1bd48-c55b-4af1-a48b-1669102af1be@nvidia.com>
Date: Sat, 02 Aug 2025 16:27:28 +0530
Message-ID: <yq5a8qk29ejr.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Arto Merilainen <amerilainen@nvidia.com> writes:

> On 28.7.2025 16.51, Aneesh Kumar K.V (Arm) wrote:
>
>> +static int pci_res_to_pdev_addr(struct rmi_pdev_addr_range *pdev_addr,
>> +				unsigned int naddr, struct resource *res,
>> +				unsigned int nres)
>> +{
>> +	int i, j;
>> +
>> +	for (i = 0, j = 0; i < naddr && j < nres; j++) {
>> +		if (res[j].flags & IORESOURCE_MEM) {
>> +			pdev_addr[i].base = res[j].start;
>> +			pdev_addr[i].top  = res[j].end;
>
> I think there is an off-by-one bug in res[j].end. As per the RMM 
> specification the base address is inclusive and the top address is 
> exclusive. Both res[j].start and res[j].end are inclusive, and hence
> res[j].end seems wrong.
>
>> +	/* use the rid and MMIO resources of the epdev */
>> +	params->rid_top = params->rid_base = rid;
>
> Similar issue here. As per the specification the rid_base is inclusive 
> and the rid_top exclusive.
>

Thanks for the review comments. I'll update the patch with the suggested changes.

-aneesh

