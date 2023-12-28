Return-Path: <linux-pci+bounces-1523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B2A4B81FC05
	for <lists+linux-pci@lfdr.de>; Fri, 29 Dec 2023 00:40:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5720E1F226AD
	for <lists+linux-pci@lfdr.de>; Thu, 28 Dec 2023 23:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CF6310A05;
	Thu, 28 Dec 2023 23:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kuhoeQpG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067B710A01;
	Thu, 28 Dec 2023 23:40:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B1ADC433C8;
	Thu, 28 Dec 2023 23:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703806807;
	bh=lX8LFyhqw9wmzGJrWM7h13SUGOfPjsFkZCkEPnpdFm8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=kuhoeQpG2cpmJLkO8ELuzxrBTH6GWDkT+GgHCaEEf3vpBe2byaPewhch4sofJ+9qj
	 NmkVaTQ1+avm89/bjev6m91Q9ZfFoeOaeVapszTr+2C7WbRoaWOqVlGs2Sf8mZdB0U
	 5teyAArmU3QwGPTA3356+hK5/J1/GLD+hblo8pxhujzdcXqAQ2hhlKed9Wh2tCVs5X
	 M6jTyERtjeDIsdYXUkOpHhmXnFaqz4ZUQ+P56vPxAVS6XZ6FZb6+hudO/ZJXFSUBuY
	 NO6+eePM3W38LlhXsccZxyXPFKQy/z7aNFl86vtMF2gn0EGv51Gd8uL53HmLSz5Vky
	 D6agd1I6B74Mw==
Date: Thu, 28 Dec 2023 17:40:05 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: attreyee-muk <tintinm2017@gmail.com>
Cc: bhelgaas@google.com, corbet@lwn.net, linux-pci@vger.kernel.org,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/PCI: fix spelling mistake in msi-howto
Message-ID: <20231228234005.GA1559156@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231223184720.25645-1-tintinm2017@gmail.com>

On Sun, Dec 24, 2023 at 12:17:20AM +0530, attreyee-muk wrote:
> Correct the spelling of "buses" from "busses" in msi-howto.rst
> 
> Signed-off-by: Attreyee Mukherjee <tintinm2017@gmail.com>

Applied with Randy's ack to pci/misc for v6.8, thanks.

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
> -- 
> 2.34.1
> 

