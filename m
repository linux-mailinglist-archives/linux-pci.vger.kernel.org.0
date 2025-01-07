Return-Path: <linux-pci+bounces-19401-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37327A03DCE
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 12:33:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A4223A4EA4
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 11:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4659D193062;
	Tue,  7 Jan 2025 11:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xa06xBUY"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC1680BFF;
	Tue,  7 Jan 2025 11:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736249626; cv=none; b=H7vJ4pw0Boqsqx3PlNUG1Id4Xft9u6/SHKorB3/lJR2Cxg4dnvIbBxZWKyYRSiOBF0vmyNzT5eS0Yg+C4B6cM/9mQbwdtTVntO0WKzBo0vSrdTnGJAVMcw3OXBXMUDvgOffDsssNOnIe6DyGEb++2+fagsOGMT6w5UNWSziv7x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736249626; c=relaxed/simple;
	bh=ksruuDZx3xVvjNieC2+9EyxiYTolra0b6ZDoZFT6Mbw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YyrIalFxpq8y3hOPgodgxGa3SynXiBLlILxCS7Lq6m7kO+NRA5wov1HfgdbmGItWh6FjiLLtlGK6xVnRfRpcPY+WvpoiQFXWMVfk4c3JdrNaLPZXVyg6a8JCGTR8GlcSkCF2wrzkZNDpyfQKMBHvJcQZlo/uxIYNP92dTdetXB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xa06xBUY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D1CC4CED6;
	Tue,  7 Jan 2025 11:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736249625;
	bh=ksruuDZx3xVvjNieC2+9EyxiYTolra0b6ZDoZFT6Mbw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xa06xBUYd9d7GAUFabsR8Bjy/TzG+A5SmsiZy/9JGxHCxDti3kT9Z3aa3SKp9MU+5
	 yB5AnOp8nztGSr/enJkr3m21R7WwtQ8xVlyFkQFZWvZfdPxl0KdXVFsd0TpB/UjpmA
	 lqB6w92ge76JoAp4Ws3WmT9lm7O6DeDzllVUZttxvydUGYRu09m/+d0awhQ0W6+tvY
	 gb6pqUO27f/LH3HDAqdjILDmMOj6LfH6aUnsMO5orvnnYmEILmGP8ruHH49s5tMoLV
	 FjbtdZU/5ulvFbrLPAdJKfqAB5/LOgeUe8aFj3rjTW1P/0OYKXGJNhrnqF6S+lca7H
	 g14XyKtSSdKvA==
Date: Tue, 7 Jan 2025 12:33:40 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <Z30RFBcOI61784bI@ryzen>
References: <20250104151652.1652181-1-18255117159@163.com>
 <Z3vDLcq9kWL4ueq7@ryzen>
 <d79d5a72-d1b0-4442-a0a3-e53516726204@163.com>
 <Z30CywAKGRYE_p28@ryzen>
 <96b3a0f7-f144-4f2a-9f84-82c31d8ec23e@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96b3a0f7-f144-4f2a-9f84-82c31d8ec23e@163.com>

On Tue, Jan 07, 2025 at 07:27:24PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/1/7 18:32, Niklas Cassel wrote:
> > > > > ---
> > > > >    drivers/misc/pci_endpoint_test.c | 12 +++++++++---
> > > > >    1 file changed, 9 insertions(+), 3 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > > > > index 3aaaf47fa4ee..50d4616119af 100644
> > > > > --- a/drivers/misc/pci_endpoint_test.c
> > > > > +++ b/drivers/misc/pci_endpoint_test.c
> > > > > @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> > > > >    static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> > > > >    				  enum pci_barno barno)
> > > > >    {
> > > > > -	int j, bar_size, buf_size, iters, remain;
> > > > >    	void *write_buf __free(kfree) = NULL;
> > > > >    	void *read_buf __free(kfree) = NULL;
> > > > >    	struct pci_dev *pdev = test->pdev;
> > > > > +	int j, buf_size, iters, remain;
> > > > > +	resource_size_t bar_size;
> > > 
> > > Fix resource_size_t to u64 bar_size.
> > > u64 bar_size;
> > > 
> > > > >    	if (!test->bar[barno])
> > > > >    		return false;
> > > > > @@ -307,13 +308,18 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> > > > >    	if (!read_buf)
> > > > >    		return false;
> > > > > -	iters = bar_size / buf_size;
> > > > > +	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT)) {
> > > > > +		remain = do_div(bar_size, buf_size);
> > > > > +		iters = bar_size;
> > > > > +	} else {
> > > > > +		iters = bar_size / buf_size;
> > > > > +		remain = bar_size % buf_size;
> > > > > +	}
> > > 
> > > Removed IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT), Execute the following code.
> > > 
> > > remain = do_div(bar_size, buf_size);
> > > iters = bar_size;
> > 
> > Perhaps keep it as resource_size_t and then cast it to u64 in the do_div()
> > call?
> 
> 
> Hi Niklas,
> 
> resource_size_t bar_size;
> remain = do_div((u64)bar_size, buf_size);
> 
> It works for the arm platform.
> 
> arch/arm/include/asm/div64.h
> static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
> {
> 	register unsigned int __base      asm("r4") = base;
> 	register unsigned long long __n   asm("r0") = *n;
> 	register unsigned long long __res asm("r2");
> 	unsigned int __rem;
> 	asm(	__asmeq("%0", "r0")
> 		__asmeq("%1", "r2")
> 		__asmeq("%2", "r4")
> 		"bl	__do_div64"
> 		: "+r" (__n), "=r" (__res)
> 		: "r" (__base)
> 		: "ip", "lr", "cc");
> 	__rem = __n >> 32;
> 	*n = __res;
> 	return __rem;
> }
> #define __div64_32 __div64_32
> 
> #define do_div(n, base) __div64_32(&(n), base)
> 
> 
> For X86 platforms, do_div is a macro definition, and the first parameter
> does not define its type. If the macro definition is replaced directly, an
> error will be reported in the ubuntu20.04 release.

What is the error?

We don't need to use do_div().
The current code that does normal / and % works fine on both
32-bit and 64-bit if you just do:

 static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
                                  enum pci_barno barno)
 {
-       int j, bar_size, buf_size, iters, remain;
+       int j, buf_size, iters, remain;
        void *write_buf __free(kfree) = NULL;
        void *read_buf __free(kfree) = NULL;
        struct pci_dev *pdev = test->pdev;
+       u64 bar_size;

No?


Kind regards,
Niklas

