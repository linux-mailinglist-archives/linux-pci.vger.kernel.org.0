Return-Path: <linux-pci+bounces-5039-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFB5887BD9
	for <lists+linux-pci@lfdr.de>; Sun, 24 Mar 2024 07:23:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D039E1C20F49
	for <lists+linux-pci@lfdr.de>; Sun, 24 Mar 2024 06:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA2E1426B;
	Sun, 24 Mar 2024 06:23:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9321A38EB;
	Sun, 24 Mar 2024 06:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711261424; cv=none; b=hwDBtyZeQekHPWtxDdv8rx2/vGdBVfW0ppdngM40lJJUnkcTFB6KbXe6BFK1BumB61+7+xDf+nSVLZhej61H4XgyDoD+UA7q4VK3AA/WV3FZZvD0U/rGotcvCseDtwEieX7xxVLqpdaRf+yBU0Ir35PAJ3/UWHYJESFyYdGEO9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711261424; c=relaxed/simple;
	bh=xKf9YqC0cOax9MfVOOKhHtECwOyzX1d8Jmc9K64UGZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DyBVfwf54t40hw/RnYxnrR4+kkhWxkPz6sJA67eJ8Cll3C5FJnp8dutH6pzcDHq83y6BdR49Respo+QN/iflC8PEppf4izEEjQqu2tYzDqmTmIMhPSSxwnLFYhnVkTtgC+hFxCOdpcFJidrlVqSwfy1T/5JZ1Z6Gp1dED/ALtBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 657EC2800BBCD;
	Sun, 24 Mar 2024 07:23:31 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 50E954AB00; Sun, 24 Mar 2024 07:23:31 +0100 (CET)
Date: Sun, 24 Mar 2024 07:23:31 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Matthew Wilcox <willy@infradead.org>,
	Peter Zijlstra <peterz@infradead.org>,
	torvalds@linux-foundation.org, Bjorn Helgaas <bhelgaas@google.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH] cleanup: Add usage and style documentation
Message-ID: <Zf_G46LtLPKJFdVB@wunner.de>
References: <171097196970.1011049.9726486429680041876.stgit@dwillia2-xfh.jf.intel.com>
 <20240322090630.GA40102@noisy.programming.kicks-ass.net>
 <65fdd7ae82934_4a98a29429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zf8_RYHW7QmCzl2-@casper.infradead.org>
 <65ff7a88e93fb_2690d29429@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ff7a88e93fb_2690d29429@dwillia2-mobl3.amr.corp.intel.com.notmuch>

On Sat, Mar 23, 2024 at 05:57:45PM -0700, Dan Williams wrote:
> Hmm, how about split the difference and teach scripts/kernel-doc to treat
> Peter's preferred markup for a C code example as a synonym, i.e.
> effectively a search and replace of a line with only:
> 
> 	Ex.
> 
> ...with:
> 
> 	.. code-block:: c
> 
> ...within a kernel-doc DOC: section?
> 
> Might be easier said the done as I stare down a pile of perl. Maybe a
> perl wrangler will come along and take pity on this patch.

On line 757, there are two regexes...

    #
    # Regexes used only here.
    #
    my $sphinx_literal = '^[^.].*::$';
    my $sphinx_cblock = '^\.\.\ +code-block::';

...which are (only) used immediately below in output_highlight_rst().

Amend those regexes to also match "Ex.", e.g.

    my $sphinx_cblock = '^\.\.\ +(code-block::|Ex\.)';

Alternatively, add another variable definition and match against it
in output_highlight_rst().

A third alternative is to use the "::" syntax in lieu of
".. code-block:: c" in your C source file, if that causes
less eyesore for Peter. ;)

Thanks,

Lukas

