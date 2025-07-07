Return-Path: <linux-pci+bounces-31640-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78035AFBC0A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 21:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC99F179F0A
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 19:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0F85262FDC;
	Mon,  7 Jul 2025 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZ6nCszk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC41820ED
	for <linux-pci@vger.kernel.org>; Mon,  7 Jul 2025 19:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751918348; cv=none; b=DTgfFsZzIm+7rCSi8qQXXHpASqUQeGKp3dTZRuqtptaP7jRVFPQFRsWPP3XWHlblP5LghjBI7wKqEMUDCYem6xLqMRQNjKEOH7EO7pRPaDqxfCTzXWWrECAxSrZ4jeNECrt8PYAwwsQ/dqB2SaysnwTKby/zCt2EDDkm3C8KKnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751918348; c=relaxed/simple;
	bh=KLdZwtKfrec+U7MskLidIO3mJWXJrjuV0rCgpkxzxXg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KV3IHjXvaZgjYFcIXFMJlZYGcEFsSlZCVowx8I5AG6eBh5KH7MCGUsY8UEyh695K0C3WQgpnsFN9WTfN+LCAuOEn0p827g6fcrZh0xck2c57holN6I2jz2lIv/zy2XphOQE32FV697niOOuWUKJG5N1/ZiPUrbb3HN6cWyUY6RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZ6nCszk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D11FEC4CEE3;
	Mon,  7 Jul 2025 19:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751918348;
	bh=KLdZwtKfrec+U7MskLidIO3mJWXJrjuV0rCgpkxzxXg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qZ6nCszkQGC1q5L3BJSpXzMozFLWQi2q7fXYBJ++Ke9g/XXojC3oj5F2BwoziFQ44
	 9oDnu+51iAjHejuBdX1pioBTz+qjOzwCtpRGIJrg5KDUUXih30vgg4g0ZmMNet+p9K
	 1X7KtRn4eDdR40Er/bQh2yA4a7KbHgfa7TXpUlT8dn0aKctx7/0obIe5A5xFQsZuOd
	 2hm0W39eiP2W2ou0iJD83e0hxXHJ7D9bZMP30R1qU+HbyayTya4PIa3WVb4Y58cHn2
	 bF3ZCFNaPX4de5feXyNtjq8HK61m1Irc56TF7tfcRqV5iQlxMAbgbs3RqrNaAttyEC
	 LZgBBnErWRqrg==
Date: Mon, 7 Jul 2025 22:59:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Yishai Hadas <yishaih@nvidia.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH rdma-next 1/8] pci/tph: Expose
 pcie_tph_get_st_table_size()
Message-ID: <20250707195903.GB592765@unreal>
References: <bb2b18f612dc99bb46c9f5c2690013aeddeacca8.1751907231.git.leon@kernel.org>
 <20250707194049.GA2096181@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707194049.GA2096181@bhelgaas>

On Mon, Jul 07, 2025 at 02:40:49PM -0500, Bjorn Helgaas wrote:
> On Mon, Jul 07, 2025 at 08:03:01PM +0300, Leon Romanovsky wrote:
> > From: Yishai Hadas <yishaih@nvidia.com>
> > 
> > Expose pcie_tph_get_st_table_size() to be used by drivers as will be
> > done in the next patch from the series.
> 
> This series doesn't actually use pcie_tph_get_st_table_size().

It is in use in patch [PATCH mlx5-next 3/8] net/mlx5: Add support for device steering tag
https://lore.kernel.org/all/dc4c7f6ba34e6beaf95a3c4f9c2e122925be97c9.1751907231.git.leon@kernel.org/

> 
> Subject line convention would be "PCI/TPH: Expose ..."

Sure, I can fix when applying it.

Thanks

