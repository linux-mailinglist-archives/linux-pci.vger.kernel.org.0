Return-Path: <linux-pci+bounces-3769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 540C085BD94
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 14:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4E7BB20D54
	for <lists+linux-pci@lfdr.de>; Tue, 20 Feb 2024 13:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1C056BB3C;
	Tue, 20 Feb 2024 13:48:54 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AEF6A351;
	Tue, 20 Feb 2024 13:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.175.24.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708436934; cv=none; b=XwkFbYIhUCOWPndzRB+FMvJuViLwxCOT8Tcy1BIv9CPAZ6XxdZn48WqISqtBjqNrc63WfTusVxd09YEq0QJYtiBzk2uKN1H+qPO6jYKC5ckPmSNWO2C5kswUcZ3ROMBT3VWU+XuCKXS9Ew4GHofZE0IfbFJln7zSIdyJ+zmwNdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708436934; c=relaxed/simple;
	bh=Yl/icjLDZM808VaGxQ+Hf9C0/O8MQvl2Zfavr53DyuQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XzQXVNsRcuxCY7WcWE5Z9chBjtWs3nQu21b1H+FzudFdgoPaVe2L/H88yscFST948KXgimiwQ+G2MpPmAY/C/gQS913h1TarMUpLXH9CtarfupwBk3KrXylJegwXhS9IU1rG2U32GsJM6DR9VBlDL/o2yAMzNcGMzPkZq8DShdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de; spf=pass smtp.mailfrom=alpha.franken.de; arc=none smtp.client-ip=193.175.24.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=alpha.franken.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alpha.franken.de
Received: from uucp by elvis.franken.de with local-rmail (Exim 3.36 #1)
	id 1rcQUF-0007OM-00; Tue, 20 Feb 2024 14:48:43 +0100
Received: by alpha.franken.de (Postfix, from userid 1000)
	id DDBEAC04A2; Tue, 20 Feb 2024 14:36:43 +0100 (CET)
Date: Tue, 20 Feb 2024 14:36:43 +0100
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: Serge Semin <Sergey.Semin@BAIKALELECTRONICS.ru>
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Alexey Malahov <Alexey.Malahov@BAIKALELECTRONICS.ru>,
	Arnd Bergmann <arnd@arndb.de>, linux-mips@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-hwmon@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] MAINTAINERS: Add maintainer for MIPS Baikal-T1
 platform code
Message-ID: <ZdSq66XhxrqgyNBy@alpha.franken.de>
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

applied to mips-next.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]

