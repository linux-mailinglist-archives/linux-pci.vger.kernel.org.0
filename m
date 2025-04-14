Return-Path: <linux-pci+bounces-25835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FE47A88301
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 15:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A810A171BD1
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 13:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EE3A2E338B;
	Mon, 14 Apr 2025 13:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="RHNBEhgh"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F53429962C;
	Mon, 14 Apr 2025 13:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637363; cv=none; b=MpItyg0OrlC1GmwB2xrwEGiDQH3t1Z15REttkDTeIBFT/Am1Um/k045Lzjx/zOHpubmmTP3G1XM7APzt4qLSHrgVqkXsEUwsf5M/t1+qS6ohJZmLeVqfsZ19im/0Q8jcfz2y/2y6riAlf3fbroajDiH2Ki4fUmL1aoSWSPHreqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637363; c=relaxed/simple;
	bh=wIGlb0JgOuwiC6IqQEg85pvZ6euhKuAbSysd3/Caak8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jDS8ltfbhvlbdZckyZygpyDmIwUAUvbHJFfcoIjgufOpx+MJ3NAcWtWvPISLejZtcFhkvojHRUIeFI5t/DrtfK1vPAA0eyBZ1fI9kbyobTNTGlEgK731+v1GrUqXVed3W3u7LUfV/FS1lt95xV1pEGshXDZSkqzsNf3Tp6/Z6UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=RHNBEhgh; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1744637356; bh=wIGlb0JgOuwiC6IqQEg85pvZ6euhKuAbSysd3/Caak8=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=RHNBEhghIQYVkI1o3nhkC8zttax0ME5Ix9OJQmq4Dui0DaQPuUUVnmDCC2nXXeP5m
	 tQOltPwFaBOGi0Wq0bQyaYEw78JKlsTxUFCOCUXASqCqcz+vG1wkzigHfozd/gu18l
	 fQD0ZZNTO06uHZhVjNeDeJUvbtvrM6sel6T2SID0=
Date: Mon, 14 Apr 2025 15:29:16 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Mammedov <imammedo@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
Subject: Re: [PATCH 1/1] PCI: Restore assigned resources fully after release
Message-ID: <3vbkz6o375yu6dybgxpzuazqivibvdpbx64hp6bqauinquhltf@tupmqb2p3abp>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Mammedov <imammedo@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20250403093137.1481-1-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250403093137.1481-1-ilpo.jarvinen@linux.intel.com>

Hello,

On Thu, Apr 03, 2025 at 12:31:37PM +0300, Ilpo Järvinen wrote:
> PCI resource fitting code in __assign_resources_sorted() runs in
> multiple steps. A resource that was successfully assigned may have to
> be released before the next step attempts assignment again. The
> assign+release cycle is destructive to a start-aligned struct resource
> (bridge window or IOV resource) because the start field is overwritten
> with the real address when the resource got assigned.
> 
> Properly restore the resource after releasing it. The start, end, and
> flags fields must be stored into the related struct pci_dev_resource in
> order to be able to restore the resource to its original state.
> 
> Reported-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: 96336ec70264 ("PCI: Perform reset_resource() and build fail list in sync")
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Tested-by: Guenter Roeck <linux@roeck-us.net>

I've tested this on Orange Pi 5+ where it fixed a regression, too.

Tested-by: Ondrej Jirman <megi@xff.cz>

Thank you,
	Ondrej

> ---
>  drivers/pci/setup-bus.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> 
> base-commit: 7d06015d936c861160803e020f68f413b5c3cd9d
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 54d6f4fa3ce1..e994c546422c 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -187,6 +187,9 @@ static void pdev_sort_resources(struct pci_dev *dev, struct list_head *head)
>  			panic("%s: kzalloc() failed!\n", __func__);
>  		tmp->res = r;
>  		tmp->dev = dev;
> +		tmp->start = r->start;
> +		tmp->end = r->end;
> +		tmp->flags = r->flags;
>  
>  		/* Fallback is smallest one or list is empty */
>  		n = head;
> @@ -545,6 +548,7 @@ static void __assign_resources_sorted(struct list_head *head,
>  		pci_dbg(dev, "%s %pR: releasing\n", res_name, res);
>  
>  		release_resource(res);
> +		restore_dev_resource(dev_res);
>  	}
>  	/* Restore start/end/flags from saved list */
>  	list_for_each_entry(save_res, &save_head, list)

