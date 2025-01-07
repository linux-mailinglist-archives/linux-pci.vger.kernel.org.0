Return-Path: <linux-pci+bounces-19393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1516BA03C80
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 11:34:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C4547A304A
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 10:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C831EBA0C;
	Tue,  7 Jan 2025 10:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OCVd+1Mo"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D8F51EB9ED;
	Tue,  7 Jan 2025 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736245969; cv=none; b=L8DRIGQX7PohTJ1PcVRrtq53F7azDMI7QTJheSDRrhhlWJdCuj2vmwA5Y9OcVKtCypU9fAkWn3bdROHZuHlwSGnQp05b6BRHO1mbYitaGgN0z1M0jjYfIPrOp72lfyoombLidSwclLZbgqTXk09rUcGQAXTvP98iib3juLuUg6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736245969; c=relaxed/simple;
	bh=1UPGn1o/HbHq6t8MNeWoCPLCe/bBs6iGU2ajKJEWu0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BorxNGEPyLURyACjy+JNrKU5Pv75G0FuiDZQiaOq/Mrg1VL1lwD305lDzc7XlJjK5zL41UUUyrra5hsWk1swz90v8Ee91HN3fFL5TyvIZ/hXBR7s6Etd4VBhFqf2YtA1defz9WctWBbKpkAHVQMMVWhAJhklyuBrR23NiilEaHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OCVd+1Mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE7BEC4CED6;
	Tue,  7 Jan 2025 10:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736245968;
	bh=1UPGn1o/HbHq6t8MNeWoCPLCe/bBs6iGU2ajKJEWu0I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OCVd+1MoAkXSxAe2lJWG0M6MwjTChv4qATT55XfTdIs0HhAFSCn9vY4x+ex9VU9a/
	 di10jXBK8/IKE9/ZGar8BfUZezz9TBUrtAmLacpDRFsstYxDB4dZP+bAop+aZ7KGfY
	 lZW1Br3kRpg5u0dZK+o+KfwwXaasgVKORfcUZa/rz9dTchM8T9kB0Bgrll+IckuJYU
	 T7xQjFjcGL5673Q51u3gFnD5G6VpyYN4o1SBIsD6KZ63jhL5srK9umfL0UKdjfAwk/
	 jJd7Bz9OKLD+H/43tUc7zzYesu3USy0O2YqhIKanzI62q2Sy0lChttStowbal78QHH
	 hYlvu1H9Zg4Qw==
Date: Tue, 7 Jan 2025 11:32:43 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>
Cc: manivannan.sadhasivam@linaro.org, kw@linux.com, kishon@kernel.org,
	arnd@arndb.de, gregkh@linuxfoundation.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	rockswang7@gmail.com
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
Message-ID: <Z30CywAKGRYE_p28@ryzen>
References: <20250104151652.1652181-1-18255117159@163.com>
 <Z3vDLcq9kWL4ueq7@ryzen>
 <d79d5a72-d1b0-4442-a0a3-e53516726204@163.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d79d5a72-d1b0-4442-a0a3-e53516726204@163.com>

Hello Hans,

On Mon, Jan 06, 2025 at 11:32:33PM +0800, Hans Zhang wrote:
> 
> 
> On 2025/1/6 19:49, Niklas Cassel wrote:
> > Doing a:
> > $ git grep -A 10 "IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT"
> > does not show very many hits, which suggests that this is not the proper
> > way to solve this.
> > 
> > I don't know the proper solution to this. How is resource_size_t handled
> > in other PCI driver when being built on with 32-bit PHYS_ADDR_T ?
> > 
> > Can't you just cast the resource_size_t to u64 before doing the division?
> 
> Hi Niklas,
> 
> Modify as follows, if you have no opinion, I will fix the next version.
> 
> > > ---
> > >   drivers/misc/pci_endpoint_test.c | 12 +++++++++---
> > >   1 file changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > > index 3aaaf47fa4ee..50d4616119af 100644
> > > --- a/drivers/misc/pci_endpoint_test.c
> > > +++ b/drivers/misc/pci_endpoint_test.c
> > > @@ -280,10 +280,11 @@ static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> > >   static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> > >   				  enum pci_barno barno)
> > >   {
> > > -	int j, bar_size, buf_size, iters, remain;
> > >   	void *write_buf __free(kfree) = NULL;
> > >   	void *read_buf __free(kfree) = NULL;
> > >   	struct pci_dev *pdev = test->pdev;
> > > +	int j, buf_size, iters, remain;
> > > +	resource_size_t bar_size;
> 
> Fix resource_size_t to u64 bar_size.
> u64 bar_size;
> 
> > >   	if (!test->bar[barno])
> > >   		return false;
> > > @@ -307,13 +308,18 @@ static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> > >   	if (!read_buf)
> > >   		return false;
> > > -	iters = bar_size / buf_size;
> > > +	if (IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT)) {
> > > +		remain = do_div(bar_size, buf_size);
> > > +		iters = bar_size;
> > > +	} else {
> > > +		iters = bar_size / buf_size;
> > > +		remain = bar_size % buf_size;
> > > +	}
> 
> Removed IS_ENABLED(CONFIG_PHYS_ADDR_T_64BIT), Execute the following code.
> 
> remain = do_div(bar_size, buf_size);
> iters = bar_size;

Perhaps keep it as resource_size_t and then cast it to u64 in the do_div()
call?


Kind regards,
Niklas

