Return-Path: <linux-pci+bounces-1320-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AFFF81D64C
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 20:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09EB51F21C96
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 19:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15FB412E5E;
	Sat, 23 Dec 2023 19:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="3MFpejYE"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A46D12E63;
	Sat, 23 Dec 2023 19:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=DeP/1AZ/38nN87rEPWPcyw9koEzebHDvVMmn0yr4JU0=; b=3MFpejYEjpRUOjz3unIDK9FLhx
	FAtS3UVuoBYAU1MjilQSwcOiNdiPeQx5fzeHU2om9yN6IePetYGEd9gJ1jcH9SkoYF9EJd6niLUGg
	FKD2zpRtRhBb98W+BGOMe7M3N96oWZmmRFyFHJS4ioQlYHO9AU3XggD6MLVqeUlvvpqJzgi8PlAp6
	TigqilEAzT81ybIwjaV39CMxzHGR8le5tOASQHe8gzhNERh4MsuK4GYe+vvGcXA9WljPG6GWn1rpA
	PVn9LFJmgCasYhoeIC1/c71TtLFCvikdGnAtD+Z8hO2mZ2zYK865JUhldVGkuepejO1NAh42bXbI2
	4gJ+RKVw==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rH7fR-008O6w-11;
	Sat, 23 Dec 2023 19:28:13 +0000
Message-ID: <6026d9b5-dd6f-43f8-acc7-9cc77bdb3df3@infradead.org>
Date: Sat, 23 Dec 2023 11:28:12 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/PCI: fix spelling mistake in
 boot-interrupts
Content-Language: en-US
To: attreyee-muk <tintinm2017@gmail.com>, bhelgaas@google.com, corbet@lwn.net
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231223184412.25598-1-tintinm2017@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231223184412.25598-1-tintinm2017@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 12/23/23 10:44, attreyee-muk wrote:
> Correct to “re-enabled” from “reenabled”.
> 
> Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>

Is "reenabled" confusing? I don't have a problem with it, but
one web page [1] says that it's OK to use "re-" if not having
the hyphen can be confusing.

[1] https://www.grammarbook.com/blog/hyphens/hyphens-with-the-prefix-re/

OTOH, some web sites say the "reenable" is OK, at least as an
alternative spelling.

Thanks.

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

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

