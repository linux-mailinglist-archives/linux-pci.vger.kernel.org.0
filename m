Return-Path: <linux-pci+bounces-19415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5DAA040EF
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 14:36:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0FBE1887366
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 13:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428631DE2C3;
	Tue,  7 Jan 2025 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mUuKgjgt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A1918CBFC;
	Tue,  7 Jan 2025 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257003; cv=none; b=K+SnYnMna0J1I9bv1B7ZI8QZ/OeMPMu65Rs5ogQSaRDFgzaAshdFLLaFXF6jf4QyioJ+g7goFlUON3pk53EgiwsSqXyq+BRM/Hl8lA25tRp1ZuESBP56ws63VAO4gIMR2BuAlGJ334GzDBlUfq61L0PM+xturXIP7nXXtxaYs8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257003; c=relaxed/simple;
	bh=l3IJuD/shp89OM31zlFcztlZ3fPZYz7SSWllnGf/pIA=;
	h=Date:From:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I5CUmFrQARZSWAJH5MhbsWwC16bt0ir17pSIhzN5ZJUbLdyOrOruvNrPmUlj8u1cmJtaM90GThweyMlAUv3ftOrohvMo2x+9j9VGvWPZbDRy0J4RUT8NHaK/k1wDuJlTSn1tan36zuEGz6G9fkjcNaydDlHhYZHF4sKkam514Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUuKgjgt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97F26C4CED6;
	Tue,  7 Jan 2025 13:36:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736257002;
	bh=l3IJuD/shp89OM31zlFcztlZ3fPZYz7SSWllnGf/pIA=;
	h=Date:From:Cc:Subject:References:In-Reply-To:From;
	b=mUuKgjgtOAWrZ/ZYEjvE1qu0rKx0gznDCpvgQfvuFx46IDG+9hDjwnVr1rwVHFJcl
	 HC2R/1qx21JiT2dmC9MXaerPgW5jTDMpwFvLYJMtpE6d8DaRmcHZ15FVZKzche13p7
	 NxjlePQiv0Pp6Ob1UoaNbzk6cEPq4GYC/cZfJxF2p+RfmoLhh5Hw+8DhQHTJ0BaKcK
	 QhrJ03Xt5QxWmk1ZnIUU8aR2df24dgzXNtCbtG4eucSHo2fYbI8hMHv+JZFMubJiC4
	 FzjvHKptEQciMFTxcN563XrJZDb5XtWNe7tZie1cj1a4wSIdkPJ3KFCx1UGlIhssSS
	 qTEVpTCB+dcQA==
Date: Tue, 7 Jan 2025 14:36:37 +0100
From: Niklas Cassel <cassel@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <Z30t5diuUrCNY55Z@ryzen>
References: <20250104151652.1652181-1-18255117159@163.com>
 <Z3vDLcq9kWL4ueq7@ryzen>
 <d79d5a72-d1b0-4442-a0a3-e53516726204@163.com>
 <Z30CywAKGRYE_p28@ryzen>
 <96b3a0f7-f144-4f2a-9f84-82c31d8ec23e@163.com>
 <Z30RFBcOI61784bI@ryzen>
 <270783b7-70c6-49d5-8464-fb542396e2dd@163.com>
 <Z30UXDVZi3Re_J9p@ryzen>
 <b2781922-d536-453f-b593-880674fc8b01@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2781922-d536-453f-b593-880674fc8b01@163.com>

On Tue, Jan 07, 2025 at 08:09:48PM +0800, Hans Zhang wrote:
> Hi Niklas,
> 
> The robot has been compiled with CONFIG_PHYS_ADDR_T_64BIT=y, so
> resource_size_t=u64
> 
> 
> include/linux/types.h
> 
> #ifdef CONFIG_PHYS_ADDR_T_64BIT
> typedef u64 phys_addr_t;
> #else
> typedef u32 phys_addr_t;
> #endif
> 
> typedef phys_addr_t resource_size_t;
> 
> 
> Is my understanding wrong? Could you correct me, please? Thank you very
> much.

I see. That is correct.


> 
> config: i386-randconfig-003-20250101 (https://download.01.org/0day-ci/archive/20250101/202501011917.ugP1ywJV-lkp@intel.com/config)
> 
> 
> I compiled it as a KO module for an experiment.
> __umoddi3 and __udivdi3 is similar to __udivmoddi4.
> 
> u64 bar_size;
> 
> iters = bar_size / buf_size;
> remain = bar_size % buf_size;

I think that I am an idiot (I'm the one who wrote this code).

A BAR size is always a power of two.

So I don't see how there can ever be a remainer...

buf_size = min(SZ_1M, bar_size);

If the BAR size is <= 1MB, there will be 1 iteration, no remainder.

If the BAR size is > 1MB, there will be more than one iteration,
but the size will always be evenly divisible by 1MB, so no remainder.

This should probably be two patches:
patch 1/2:
@@ -316,12 +317,6 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
                                                 write_buf, read_buf, buf_size))
                        return false;
 
-       remain = bar_size % buf_size;
-       if (remain)
-               if (pci_endpoint_test_bar_memcmp(test, barno, buf_size * iters,
-                                                write_buf, read_buf, remain))
-                       return false;
-
        return true;
 }


patch 2/2:
@@ -283,10 +283,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
 static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
                                  enum pci_barno barno)
 {
-       int j, bar_size, buf_size, iters, remain;
+       int j, buf_size, iters;
        void *write_buf __free(kfree) = NULL;
        void *read_buf __free(kfree) = NULL;
        struct pci_dev *pdev = test->pdev;
+       resource_size_t bar_size;
 
        if (!test->bar[barno])
                return false;



The error:
drivers/misc/pci_endpoint_test.c:315: undefined reference to `__udivmoddi4'
sounds like the compiler is using a specialized instruction to do both div
and mod in one. By removing the mod in patch 1/2, I expect that patch 2/2
will no longer get this error.


Kind regards,
Niklas

