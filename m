Return-Path: <linux-pci+bounces-25955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E500A8A962
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 22:34:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27A683BB281
	for <lists+linux-pci@lfdr.de>; Tue, 15 Apr 2025 20:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3041DE2DB;
	Tue, 15 Apr 2025 20:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcPa9EBO"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2351537A7
	for <linux-pci@vger.kernel.org>; Tue, 15 Apr 2025 20:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744749237; cv=none; b=tzP0nOpmUSMAMdztcL3Ub3b2xb6YoR0jJVmtAw84Jc9YiiSL+1cGT6wTsYfqEU+YzglCU7chje3gKr0uQWAN+WGfSZyvswbHTzwctflGDA4Bic1R2Q2Yl/GNJOVbNEVbSze1mrhCc8A2P2yY11ztDx4kQanNPan8mM4qZo8jf5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744749237; c=relaxed/simple;
	bh=vXq9qooyUmlpj8gsQpqPhROskHMfszbYE/WIvBfPBYI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=myT/bg20j1qS+b6LUL72Kd/Obn4AU12ZUz9snyElecgQhxJ/VXYaQ3Uvlt4fdBxd6LrwbMncKMg4sxzlxBNsLg9gnghMc2RaGWiKBnwTFf81PZhIn8y3GBxl93tlkU+sTokNbhfIfZEG9cK2GY+aBvMB5mT7M65scvQm53pa1no=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcPa9EBO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B50AC4CEE7;
	Tue, 15 Apr 2025 20:33:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744749236;
	bh=vXq9qooyUmlpj8gsQpqPhROskHMfszbYE/WIvBfPBYI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JcPa9EBOBOo1e+uoHC6L4cdnw6dF3hdE62OzxrtvbzsWApGvR18Pr6NV7C+TCcAa1
	 iCq326JKQp9SwhpHjpCL3P2FoUM3HlBEQpa8wgCGr2CimXhy6gqboXkEUznwGGte8H
	 QW0WD13CDSe9D1dnsbHyB6Y2fLqq2qzcy1Uyc2rC5Q9yVs0fvcyW77yA5vSkDgjXiG
	 v3jbOugUSiuEiHKpdLkmKBcQ0BaTJJwO3AmD5ssBA9yQOT6DOKQ4KEDsOIZ2wwdIr5
	 tbMYIcPFqSftaOp3XaByqHekNxYM0kyko9rGcXOu6dFUH0oQB6dqhyvzfILdLi/Ckd
	 BkQdW6Dcho7Ww==
Date: Tue, 15 Apr 2025 15:33:54 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: hotplug: Drop superfluous #include directives
Message-ID: <20250415203354.GA34031@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c19e25bf2cefecc14e0822c6a9bb3a7f546258bc.1744640331.git.lukas@wunner.de>

On Mon, Apr 14, 2025 at 04:25:21PM +0200, Lukas Wunner wrote:
> In February 2003, historic commit
> 
>   https://git.kernel.org/tglx/history/c/280c1c9a0ea4
>   ("[PATCH] PCI Hotplug: Replace pcihpfs with sysfs.")
> 
> removed all invocations of __get_free_page() and free_page() from the
> PCI hotplug core without also removing the #include <linux/pagemap.h>
> directive.
> 
> It removed all invocations of kern_mount(), mntget() and mntput()
> without also removing the #include <linux/mount.h> directive.
> 
> It removed all invocations of lookup_hash()
> without also removing the #include <linux/namei.h> directive.
> 
> It removed all invocations of copy_to_user() and copy_from_user()
> without also removing the #include <linux/uaccess.h> directive.
> 
> These #include directives are still unnecessary today, so drop them.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>

Applied to pci/hotplug for v6.16, thanks!

> ---
>  drivers/pci/hotplug/pci_hotplug_core.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
> index d8c5856..210f93d 100644
> --- a/drivers/pci/hotplug/pci_hotplug_core.c
> +++ b/drivers/pci/hotplug/pci_hotplug_core.c
> @@ -20,13 +20,9 @@
>  #include <linux/types.h>
>  #include <linux/kobject.h>
>  #include <linux/sysfs.h>
> -#include <linux/pagemap.h>
>  #include <linux/init.h>
> -#include <linux/mount.h>
> -#include <linux/namei.h>
>  #include <linux/pci.h>
>  #include <linux/pci_hotplug.h>
> -#include <linux/uaccess.h>
>  #include "../pci.h"
>  #include "cpci_hotplug.h"
>  
> -- 
> 2.43.0
> 

