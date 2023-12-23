Return-Path: <linux-pci+bounces-1319-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9F281D644
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 20:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D81511F21CB2
	for <lists+linux-pci@lfdr.de>; Sat, 23 Dec 2023 19:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 935D412E63;
	Sat, 23 Dec 2023 19:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="G4FW24Ex"
X-Original-To: linux-pci@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C377C14F62;
	Sat, 23 Dec 2023 19:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=bRLpzdTf4eP01ezZZbOp5iMx6vc++e4xQlNDveXlmv4=; b=G4FW24Exlise4J0+5CQMoM+SQu
	eZoeZu+8GthVNw2JizSGuG4voe7XdcEtG7tOv90Co69UxwPO44c+ZAI7VwLIJmSGR72cqqwYw4e1q
	MzHtlqjdCqPZiEutX4CNJbw5ighqoF5eLqlRI+j138qvSxjNZpD8qp7JoQx/l3Hs8oDTZk7Lt4ZI4
	Dq5R9kYASbhyUBQVFFr1ISQ7qAWohTNM0efqX5fIo/9zUdGG8o8HkhS7gq7H8JJIQydtt2LYJE1ON
	ZPB5Vq4sxZaNIGbXlLpQ4KwksJsrlwZkDM6Fkh0HfMoEnHobqNlabL39Sz/sbRPeVoPl+8jvZE/vX
	7vS1Wo3A==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rH7cZ-008Njc-38;
	Sat, 23 Dec 2023 19:25:16 +0000
Message-ID: <520e15c0-9815-4bd1-b4b9-17a79d49938e@infradead.org>
Date: Sat, 23 Dec 2023 11:25:15 -0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation/PCI: fix spelling mistake in msi-howto
Content-Language: en-US
To: attreyee-muk <tintinm2017@gmail.com>, bhelgaas@google.com, corbet@lwn.net
Cc: linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231223184720.25645-1-tintinm2017@gmail.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231223184720.25645-1-tintinm2017@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/23/23 10:47, attreyee-muk wrote:
> Correct the spelling of "buses" from "busses" in msi-howto.rst
> 
> Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>

OK.
Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/PCI/msi-howto.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/PCI/msi-howto.rst b/Documentation/PCI/msi-howto.rst
> index c9400f02333b..783d30b7bb42 100644
> --- a/Documentation/PCI/msi-howto.rst
> +++ b/Documentation/PCI/msi-howto.rst
> @@ -236,7 +236,7 @@ including a full 'lspci -v' so we can add the quirks to the kernel.
>  Disabling MSIs below a bridge
>  -----------------------------
>  
> -Some PCI bridges are not able to route MSIs between busses properly.
> +Some PCI bridges are not able to route MSIs between buses properly.
>  In this case, MSIs must be disabled on all devices behind the bridge.
>  
>  Some bridges allow you to enable MSIs by changing some bits in their

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

