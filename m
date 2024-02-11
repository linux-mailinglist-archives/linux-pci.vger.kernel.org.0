Return-Path: <linux-pci+bounces-3331-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 889B185089C
	for <lists+linux-pci@lfdr.de>; Sun, 11 Feb 2024 11:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC93C1C20FA7
	for <lists+linux-pci@lfdr.de>; Sun, 11 Feb 2024 10:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E8C59B70;
	Sun, 11 Feb 2024 10:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JF3i2AmN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6F258231;
	Sun, 11 Feb 2024 10:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707647057; cv=none; b=jMNTJrO+54T4a0MMzy0uRw5/U5pjSBH8m2iZ/nJo+AsXp5mBx2l5tXk0ZM4p78+kfrQ6fBGdOhHa138fnOmM+7lEdXMB8iOTL4LQ04+OKCiGiuqijRkZcpRFnReWZK5u6JbQOk/tPD57Go1l080yJvFmCxQwiI2/9gXq7okaVDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707647057; c=relaxed/simple;
	bh=G9HaVw97O+LYW4l6xGCSfqbxt1JQDfTA/uIljpKPgyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ouSpWCZIrRDsd6T7CP9by5/hUYzh+OgVt5F8tbBjUpuV4rEh5UVihfJ1M8QlAriG7EiyLAm5OMrGC2kjBfCZkI42t7bhrtl/A+sMUKAzEACCdBGugNZsg77bd1DdO16u08K6pw7bfBD5lpLdJXrr39kdkpwIwsPxgFbQ1lG+JUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JF3i2AmN; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cf3ed3b917so28505481fa.1;
        Sun, 11 Feb 2024 02:24:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707647053; x=1708251853; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zckA8DZFW8+bg9rPpoe1KSTinRRqZY6mOlpa6NbcucI=;
        b=JF3i2AmNbnihlDmFz9Egd4nneX12KxIPNtcZPa2Z/bI0Ozp0qJ4HYGTePzsvPIEuXN
         uMQWnUQaulmq68U//5OgRHTsP2dzRPfxNfWtlUB9hYGarcKVRgJDSVguxFygP/avDiXS
         fprplNlE4gGfKttbaT4akG91+1N4ayyomdn420MIO0fsM6f950cm7ANtn76CpETiYjVb
         vtvt+ZKmzWwgSUMRLHuIPgQ2a21GZxt9yIG7+HTMHJGw3mqETkalCEIlVtMx5OXROwXF
         TprorQzsTS+Cq5Ba8GSqrIDQaSpWPEifovgbTDFiw9I1HAWV4ZETrQBIGIxIVoBUFNSR
         4K8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707647053; x=1708251853;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zckA8DZFW8+bg9rPpoe1KSTinRRqZY6mOlpa6NbcucI=;
        b=YcWKa2+EA4exxtDRUR2gtvY6rQJZCZWJBPHTVqdLXoEpKwyPpTn0KCAZ7QjgzZT5qL
         QrRfzZnS9weuoh3mLvQnLGRScHeieg73C5JTnzPXbi1Cia6132JXKl7Lf2R7Gh7lsF1J
         Jdog/7xhT3tFwbOGywvedTLEUjOSasTKC9/Dz049AWdh0hJM9FBjXytXOP39vWvxmjPZ
         66ElXWn+6phKD+OtxGzsTZqmCW7c9qwM2D+BzCKDvd9yja+pWbdSxyW7a//G3PJ0hXWt
         dVpdnWfpZVqO+hRuXrdnme9ZTHXNJqPcklwISLow5IzRCXNxiYec4aqRPsuPI8e0XnCJ
         K1lA==
X-Gm-Message-State: AOJu0Yx26Vog5gK4ArgfwOK1Tg7hTkCfdJxe/UNKDuubRuOzDC4bJfAC
	fsl0/EqGP2ZbJ4G3RyWK2napwRRE7azRrvoYLXYtxxORuiV8OQx1
X-Google-Smtp-Source: AGHT+IG/Y+vymfS1k32/vI0JC93GeK6g/gBGreL7xJWAvtaCUCYhRfqQxaQr0neJDl0OsLUybZhCPA==
X-Received: by 2002:a2e:b0f4:0:b0:2d0:be75:5fcb with SMTP id h20-20020a2eb0f4000000b002d0be755fcbmr2920815ljl.6.1707647053004;
        Sun, 11 Feb 2024 02:24:13 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVLLewjw1xDZZbPa1Ls7XWMl049vg34MboYDrwod/8Q6ET3Wi9yFgYI5oW7Vkj4DHW9ilA4KZfiFszIzchMUIkCGqth/6i+K5ZpWgXIuOZkCruZvVk2eO6RJMwe0ydWmWlnuIyZj7fh7u+esBR0e6w9ntI9RKV2SET/Vbyn/bBGlp5mPh6H9ZnVi6hGyY8etr6wZtvLq//VMGR0pRY4pBBxkZT7HCaQdtPWnilNp7HLEmrttmo5w+o7lAUxd2wkIkyD3xmJm18LwGMOn+sHJaCM3AEGAzHEVRNSSOPkF2PP3a/kY5Vz6zyxvEnbv0c+lLTh5hAwjm7Si3N42l8hZXdCQWrm5OrsPgCSZYZHYPI=
Received: from mobilestation ([85.249.21.200])
        by smtp.gmail.com with ESMTPSA id h23-20020a2e3a17000000b002d0d0d06fcfsm856271lja.103.2024.02.11.02.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Feb 2024 02:24:12 -0800 (PST)
Date: Sun, 11 Feb 2024 13:24:08 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Serge Semin <Sergey.Semin@baikalelectronics.ru>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>, Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org, kernel-janitors@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MAINTAINERS: Add maintainer for MIPS Baikal-T1
 platform code
Message-ID: <ytmxjd7qeaj32qtenodhzir3qlfjxcfs44n7s32bflhwbw6psj@nbm4gsvvfmkk>
References: <20231122170506.27267-1-Sergey.Semin@baikalelectronics.ru>
 <20231122170506.27267-4-Sergey.Semin@baikalelectronics.ru>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122170506.27267-4-Sergey.Semin@baikalelectronics.ru>

On Wed, Nov 22, 2023 at 08:04:52PM +0300, Serge Semin wrote:
> Add myself as a maintainer of the MIPS Baikal-T1 platform-specific
> drivers. The arch-code hasn't been submitted yet, but will be soon enough.
> Until then it's better to have the already available drivers marked as
> maintained.
> 
> Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>

Thomas, kind ping to merge this in. Thanks.

-Serge(y)

> ---
>  MAINTAINERS | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 52ee905c50f4..a56e241608ae 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14491,6 +14491,17 @@ F:	arch/mips/
>  F:	drivers/platform/mips/
>  F:	include/dt-bindings/mips/
>  
> +MIPS BAIKAL-T1 PLATFORM
> +M:	Serge Semin <fancer.lancer@gmail.com>
> +L:	linux-mips@vger.kernel.org
> +S:	Supported
> +F:	Documentation/devicetree/bindings/bus/baikal,bt1-*.yaml
> +F:	Documentation/devicetree/bindings/clock/baikal,bt1-*.yaml
> +F:	drivers/bus/bt1-*.c
> +F:	drivers/clk/baikal-t1/
> +F:	drivers/memory/bt1-l2-ctl.c
> +F:	drivers/mtd/maps/physmap-bt1-rom.[ch]
> +
>  MIPS BOSTON DEVELOPMENT BOARD
>  M:	Paul Burton <paulburton@kernel.org>
>  L:	linux-mips@vger.kernel.org
> -- 
> 2.42.1
> 
> 

