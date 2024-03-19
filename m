Return-Path: <linux-pci+bounces-4913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB2988028B
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 17:40:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5B5CB2536D
	for <lists+linux-pci@lfdr.de>; Tue, 19 Mar 2024 16:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98AFC8E1;
	Tue, 19 Mar 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdqZzWPb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D08C120
	for <linux-pci@vger.kernel.org>; Tue, 19 Mar 2024 16:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710866438; cv=none; b=cTBk8qVWoPvskWLDkjU5PJXGHs5cRWa4U3WHdpkk/xzEy18Xm8g9GF3Vg3xpCrq2TJKmtX7L6aAHfLVoO1eZen1GO+zFzYvwQGr64R6x6Q9op39oSNLgN7YF5K5p4IlFvwi2ITXlBoPKZ+Calno4gbcR1qy//VaNhUbrvWEgDYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710866438; c=relaxed/simple;
	bh=emY6It1EvmMo+fwKRNUD+VenRXlX32ekVtzZK8fvFQs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCE+Nw0B6ROpKf2e+SZa4/t653UJVLLhuWAam7QKT9Bsnu1HRwNISicoger5VipnOBWvTbL1SO5qxMqnDAaQ9klsRboxSX3NF5ILmKEi+T73SlO2Fa82o7W8L/ZgARmMudEEAQBRDjWqmXCllpc8emIrvoCBCV6DnDuR71SPfOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LdqZzWPb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6481EC433F1;
	Tue, 19 Mar 2024 16:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710866438;
	bh=emY6It1EvmMo+fwKRNUD+VenRXlX32ekVtzZK8fvFQs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LdqZzWPb47xtmQgR/BwjNywYn6eLfbgu7sJ0JMV4E/yXZJMTiGhiagtZKe5VTBCzq
	 FfEYlqzUkEmrpYRatHBeqcSh1sl5Nu43TKn6nGH9gR0TFExvRKI8Jy3d40SU6saJEQ
	 EP+DCX3wsefTTY9RSD3vP8sdsx8Do407BCWrut5BmdTPG/V5Zn0OB0cmrhYhC1qXhH
	 6lN+8GzYiuNBdTLZU/kxGPJvRF/TDfG0Dawu8GW/7K8l4QAoolsTuoBH4+srRQJv+s
	 M4Y0HTXJKos9tzBlH8azWTmyulSV5IEQChImrqpZcuKuxbUt3KXM70LCSS1F3sofEe
	 s7wW1bY7448QA==
Date: Tue, 19 Mar 2024 17:40:33 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Message-ID: <ZfnAATqpYlssxrT3@ryzen>
References: <20240318193019.123795-1-cassel@kernel.org>
 <8194c85c-cdc8-431a-a2fc-50569475b160@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8194c85c-cdc8-431a-a2fc-50569475b160@app.fastmail.com>

Hello Arnd,

On Mon, Mar 18, 2024 at 09:02:21PM +0100, Arnd Bergmann wrote:
> On Mon, Mar 18, 2024, at 20:30, Niklas Cassel wrote:
> > diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
> > index 705029ad8eb5..cb6c9ccf3a5f 100644
> > --- a/drivers/misc/pci_endpoint_test.c
> > +++ b/drivers/misc/pci_endpoint_test.c
> > @@ -272,31 +272,59 @@ static const u32 bar_test_pattern[] = {
> >  	0xA5A5A5A5,
> >  };
> > 
> > +static int pci_endpoint_test_bar_memcmp(struct pci_endpoint_test *test,
> > +					enum pci_barno barno, int offset,
> > +					void *write_buf, void *read_buf,
> > +					int size)
> > +{
> > +	memset(write_buf, bar_test_pattern[barno], size);
> > +	memcpy_toio(test->bar[barno] + offset, write_buf, size);
> > +
> > +	/* Make sure that reads are performed after writes. */
> > +	mb();
> > +	memcpy_fromio(read_buf, test->bar[barno] + offset, size);
> 
> Did you see actual bugs without the barrier? On normal PCI
> semantics, a read will always force a write to be flushed first.

I'm aware that a Read Request must not pass a Posted Request under
normal PCI transaction ordering rules.
(As defined in PCIe 6.0, Table 2-42 Ordering Rules Summary)

I was more worried about the compiler or CPU reordering things:
https://github.com/torvalds/linux/blob/master/Documentation/memory-barriers.txt#L1876-L1878

I did try the patch without the barrier, and did not see any issues.


I did also see this comment:
https://github.com/torvalds/linux/blob/master/Documentation/memory-barriers.txt#L2785-L2790

Do you think that we need to perform any flushing after the memset(),
to ensure that the data written using memcpy_toio() is actually what
we expect it to me?


Kind regards,
Niklas

