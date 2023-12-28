Return-Path: <linux-pci+bounces-1524-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 638AC81FC07
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 00:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95C491C214F7
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 23:41:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A5D10A06;
	Thu, 28 Dec 2023 23:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mztgYsb3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C8D10A01;
	Thu, 28 Dec 2023 23:41:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AB1C433C8;
	Thu, 28 Dec 2023 23:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703806891;
	bh=+SOMzSt6wOwrUHJ7V0j44ZJVizIkipIkwhX7yp1taLg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mztgYsb3QT/uHmioEvS54FdZrYaMHEEpagL7SZN0wM6HB+t9l3H9Gdwi1CWoPRws0
	 uEzB44IXpgO0KqajBGgbHj15Ft+hkk3c9vHFB0seJ7Iyb2AvWbsD85bHk37RUD09KQ
	 ZfAz+p5JkuZgVk9o2Rffac+rxtr8zCqmwEVJLgNIxUcBidufvMcEBIZWpWlRmgZuSL
	 sc92572rwThm3Tt/amU97tcrd2KcSVkyBJ1pbSdK9dfwJsFJzAQ0BPp8Xd/03BBs7E
	 crKSf2KLLwvwbYm07cYwtqz6vnwge8DHEoNQDWvG4KOHarRrvXQjSAxKwuVj89ICeG
	 v9GWgxRl8PYPQ==
Date: Thu, 28 Dec 2023 17:41:29 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: attreyee-muk <tintinm2017@gmail.com>
Cc: bhelgaas@google.com, corbet@lwn.net, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] Documentation/PCI: fix spelling mistake in
 boot-interrupts
Message-ID: <20231228234129.GA1559242@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231223184412.25598-1-tintinm2017@gmail.com>

[+cc Randy]

On Sun, Dec 24, 2023 at 12:14:13AM +0530, attreyee-muk wrote:
> Correct to “re-enabled” from “reenabled”.
> 
> Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>

I'm fine with this either way, so I squashed this together with the
"busses" patch and they're both on pci/misc for v6.8.

> ---
>  Documentation/PCI/boot-interrupts.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/PCI/boot-interrupts.rst b/Documentation/PCI/boot-interrupts.rst
> index 2ec70121bfca..931077bb0953 100644
> --- a/Documentation/PCI/boot-interrupts.rst
> +++ b/Documentation/PCI/boot-interrupts.rst
> @@ -61,7 +61,7 @@ Conditions
>  ==========
>  
>  The use of threaded interrupts is the most likely condition to trigger
> -this problem today. Threaded interrupts may not be reenabled after the IRQ
> +this problem today. Threaded interrupts may not be re-enabled after the IRQ
>  handler wakes. These "one shot" conditions mean that the threaded interrupt
>  needs to keep the interrupt line masked until the threaded handler has run.
>  Especially when dealing with high data rate interrupts, the thread needs to
> -- 
> 2.34.1
> 

