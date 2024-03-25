Return-Path: <linux-pci+bounces-5077-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9A688A27A
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 14:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6811C38A19
	for <lists+linux-pci@lfdr.de>; Mon, 25 Mar 2024 13:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1FA1411E0;
	Mon, 25 Mar 2024 10:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lLsIXyvI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCB7155A32
	for <linux-pci@vger.kernel.org>; Mon, 25 Mar 2024 07:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353514; cv=none; b=Kc+jNYGS6M5i9DnTICBte/uLCBWLYeynpsZmoFHWZeF9Y97hrSTeobEwqipF/veayQdSSNJ5HJ5EuuqlSVlQiRoM0KEQRwsg3iJLaBUSeHcLyVv9eiirEL3N8SesIcSuk4FZ/TblFJhuqrU0bQ5kQZIKK37j8BLgZpRbEZRHmI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353514; c=relaxed/simple;
	bh=hdLsHRL6aztnL13dewCAp4QsyaMN9Ql4GldsquJZCXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o2AICt0BG0gZddJPTfIsGvKbGq4zUJaDItYbioyV37gFePquvSH+paWR9924qbl0YfKv4Yoc7s+fkCAcQYoQzpUIXs76AZgkSxkLHk3y7dWYFa2jU/3r4n65WT7tegcjO9SjyXnJ+f3YAkr/OUnksjEABQo+1JkeUe1kfMvBn6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lLsIXyvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CB54C433C7;
	Mon, 25 Mar 2024 07:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711353514;
	bh=hdLsHRL6aztnL13dewCAp4QsyaMN9Ql4GldsquJZCXM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lLsIXyvIAQG8o3ZW/YD09uSGKs9c5vHr4+V+jjg9PkrdDTf2URMIYx2z7BBMgr4Mm
	 MAFKr0aXcG+aKofsZlT57FKhbHpWuXW9noDgue54Bx1mfTyGHE9wWY4kKTVjzHwRcL
	 JExMx2wxf+tDLTUsRiDli2/8fKRaZcakBa1x7AHH56cNHxJOxkuLyr6BTrqSrsuH/c
	 20HgO/G08InQfUgBjaao7jDJm8XnioK0lwx6Jk5UsvPoPBiu3oDFLCaDuwDagpNAld
	 xdzZVfNdATV+j4bBJm27Fgn+vEEAMwvSwBxs6SFu+77PdeToxmY1XEt+DHsSZzMZ83
	 ZiSMCwUDQoF3w==
Date: Mon, 25 Mar 2024 08:58:29 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v4] misc: pci_endpoint_test: Use
 memcpy_toio()/memcpy_fromio() for BAR tests
Message-ID: <ZgEupfggnrC3D6Em@ryzen>
References: <20240322164139.678228-1-cassel@kernel.org>
 <8dcb72ed-ee39-4fd6-a157-b7d889f35056@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8dcb72ed-ee39-4fd6-a157-b7d889f35056@linux.intel.com>

Hello Kuppuswamy, Dan,

On Fri, Mar 22, 2024 at 10:03:12AM -0700, Kuppuswamy Sathyanarayanan wrote:
> > +
> >  static bool pci_endpoint_test_bar(struct pci_endpoint_test *test,
> >  				  enum pci_barno barno)
> >  {
> > -	int j;
> > -	u32 val;
> > -	int size;
> > +	int j, bar_size, buf_size, iters, remain;
> > +	void *write_buf __free(kfree) = NULL;
> > +	void *read_buf __free(kfree) = NULL;
> 
> Please check the following cleanup doc. Recommendation is to avoid above __free(kfree) = NULL declarations and directly define write_buf/read_buf.
> 
> https://lore.kernel.org/lkml/171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com/T/#m05d71a668ff0fad46c2055dbdcde55d7381780b7

I don't think that the docs say that using:
void *ptr __free(kfree) = NULL;
is always an anti-pattern.

"If other cleanup helpers appeared in such a function that depended on
@dev being live to complete their unwind then using the
"struct obj_type *obj __free(...) = NULL" style is an anti-pattern that
potentially causes a use-after-free bug."

I think it says that it is an anti-pattern IFF there are two cleanup
helpers in a function AND they have have a inter-dependency.

This patch just adds a single cleanup helper, so there can be no
inter-dependency problem.

This pattern is common in Linus's current tree, see e.g.
$ git grep -C 3 -E "__free(.*) = NULL"

If this was a problem, I don't think we would have seen
100 different instances of this pattern.

In other words, I think this patch is fine.

Dan, please correct me if I'm wrong.


Kind regards,
Niklas

