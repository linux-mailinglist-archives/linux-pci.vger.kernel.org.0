Return-Path: <linux-pci+bounces-30007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D6BFADE316
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 07:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A64C1899D93
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 05:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B4571714B7;
	Wed, 18 Jun 2025 05:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="AhWyVqsA"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C680155382;
	Wed, 18 Jun 2025 05:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750225140; cv=none; b=owAKXh63a7jcvRyzVIpAZD21MbrMK5iAG7Rsq9ns4DyCiVts83w7tMntiFK0FI4iS6wtzfjq7OX4pataAevYgJX/SPhheX/FeiE7w7zUzzJTkk5WO2cw/mC9oCy8DFJ2YleDhEp17S1/nD803kEIDzwo43d1+m044wT7TO+ODfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750225140; c=relaxed/simple;
	bh=M74KaXEkB7xVptKIShssQZ1N2d0tX1uMlJHUqumUNSU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pJOhJzsSyWfiwbmoPGyfEkcE6mNgWm4bA4PKaJgX/eYkANxnwjlVYn1hvc+nq1nx09ENvUflvSXAidKmeKaRm+VHlhT4K2RzahMlPOpms7RuQXXXOgjFi5WS4/9CWpdk3LRlKQko8pQRC6Hh19C/OTj8mLl0xOMZe1WvMDvMhTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=AhWyVqsA; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=0VfDKR79Vtwn5VxJOChmtPjWAJZfi4MTkhv0klH8VUU=; b=AhWyVqsA3j3LhyCrTsVnb6uTsn
	9r6eUym64zHlFvMOujpVErXmuxZQzBpGAHf1t8TqLy87/VyIOL9uzm/ZdUVdiz/B19k2KVu7Ye40r
	mbAeh0+vhywNjZniEURh0ncL8SIKwNm3DZU75mlqhPVHVZQY5qONFOShAFrwqXsxxwbGSEp2nsqis
	sqMQZI/VXqT+yY4NrSb1Srah+zvhVs4VmAgrGpwwANoFS+Qy4WjpXkCUfgvPrD2Dcw7GG3iyEJEJY
	l22KO9U5zP3AOTEuow7mmc/cEjcZVJnC4idkyj4mM2zRrVK9hm0cZbS8yFg3Hw7OO91YpFwVHUP90
	HxZfSLCw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uRlVg-000000096Bv-3dIB;
	Wed, 18 Jun 2025 05:38:56 +0000
Date: Tue, 17 Jun 2025 22:38:56 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Timothy Pearson <tpearson@raptorengineering.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	christophe leroy <christophe.leroy@csgroup.eu>,
	Naveen N Rao <naveen@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>
Subject: Re: [PATCH 3/8] powerpc/pseries/eeh: Export eeh_unfreeze_pe() and
 eeh_ops
Message-ID: <aFJQ8AtYlKx1t_ri@infradead.org>
References: <946966095.1309769.1750220559201.JavaMail.zimbra@raptorengineeringinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <946966095.1309769.1750220559201.JavaMail.zimbra@raptorengineeringinc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Tue, Jun 17, 2025 at 11:22:39PM -0500, Timothy Pearson wrote:
>  /* Platform dependent EEH operations */
>  struct eeh_ops *eeh_ops = NULL;
> +EXPORT_SYMBOL(eeh_ops);

Exporting ops vectors is generally a really bad idea.  Please build a
proper abstraction instead.

And use EXPORT_SYMBOL_GPL for any kind of low-level API.


