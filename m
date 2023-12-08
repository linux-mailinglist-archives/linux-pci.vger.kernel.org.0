Return-Path: <linux-pci+bounces-693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6769C80A9E4
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 17:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20C422815FF
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 16:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D81137151;
	Fri,  8 Dec 2023 16:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QM1NsINW"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C9C32C7A
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 16:59:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FB13C433C7;
	Fri,  8 Dec 2023 16:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702054741;
	bh=eiIkYohQvLRZ7T9nKH8cVSI0MoBXH5iTtMsNaJC4QI4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QM1NsINWpZdMdNybhh1yZtOAE/xP1PzlgpHDm4i/CSRH2tmo8EbDH66HO1ihlgMFS
	 SNxNGD7K+oMa2VpaqFvYySILkuvql3gogkpequKU0iggrp6qjrogBQjFrNpUpL5DUD
	 zmYsIm6fC8ChcMtdkwbs6KvLQpqo9cjWTjnZWLAq+DCB2320QvRwCMNpB2uYMvJTW6
	 lVbyTiPb+hXHwaUZiF3uXpk7UDiUg4sdA9mOi9AsFovgmTT6CqLzKAaO0VnQOXYWeO
	 CObmUsM8212XRHuvlqvoFNB0UEomozs0WS2y+iubXo7upbd0+5G3nLC6KK+uILWBSW
	 HtzknWvt1GOxQ==
Date: Fri, 8 Dec 2023 10:59:00 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Martin Mares <mj@ucw.cz>, linux-pci@vger.kernel.org,
	Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: Re: [PATCH v2 1/1] lspci: Add PCIe 6.0 data rate (64 GT/s) also to
 LnkCap2
Message-ID: <20231208165900.GA797060@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231208101307.2566-1-ilpo.jarvinen@linux.intel.com>

[+cc Gustavo (author of 5bdf63b6b1bc), just FYI in case you're
interested in picking up this change for your use]

On Fri, Dec 08, 2023 at 12:13:07PM +0200, Ilpo Järvinen wrote:
> While commit 5bdf63b6b1bc ("lspci: Add PCIe 6.0 data rate (64 GT/s)
> support") added 64 GT/s support to some registers, LnkCap2 Supported
> Link Speeds Vector was not included.
> 
> Add PCIe 6.0 data rate bit check also into
> cap_express_link2_speed_cap().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> 
> v2:
> - Corrected the commit hash in the changelog
> 
>  ls-caps.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/ls-caps.c b/ls-caps.c
> index fce9502bd29a..2c99812c4ed2 100644
> --- a/ls-caps.c
> +++ b/ls-caps.c
> @@ -1191,8 +1191,10 @@ static const char *cap_express_link2_speed_cap(int vector)
>     * permitted to skip support for any data rates between 2.5GT/s and the
>     * highest supported rate.
>     */
> -  if (vector & 0x60)
> +  if (vector & 0x40)
>      return "RsvdP";
> +  if (vector & 0x20)
> +    return "2.5-64GT/s";
>    if (vector & 0x10)
>      return "2.5-32GT/s";
>    if (vector & 0x08)
> -- 
> 2.30.2
> 

