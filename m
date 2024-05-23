Return-Path: <linux-pci+bounces-7774-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C56A8CCFD7
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 12:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDF81F20F10
	for <lists+linux-pci@lfdr.de>; Thu, 23 May 2024 10:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AAE13CF96;
	Thu, 23 May 2024 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VpQ7NcXe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E0654FA9
	for <linux-pci@vger.kernel.org>; Thu, 23 May 2024 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716458569; cv=none; b=ZrHVW3Z9eeIF2Xl2wV6Vv6YrZ70KlUGob/c+X0GJUsICfUvOq7JbUI4K0Xce7ZTXeyeondrumYc8l77xI6SfQK27YDuKySkwGIUjYkUAaHKv4QBteoWXoCt5ENLVngf6uH+GDBjrvJ6hOXCx1/8ddNobiFr3zZkMYU5pHmt8lwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716458569; c=relaxed/simple;
	bh=Guae2wHlodr7gGZaTlQUvj1RR+7PjND97DXaqJ3ykoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gPkOnmJOEmUqVn5e+Jof2LJjVWRuRTpRKJ7RVx5OvsYZn8hoU7L5bDg0D8wEslG6zhmfVMndAI2cQenJsEz5jJBc1LX3v7LzIiErm22lq3CJ6IQZiiFvG2fNBcfwhy46kpqYEKwWiJkXVLOo2okqepJ7zcuNkFnQhqk72Pzs0BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VpQ7NcXe; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51fcb7dc722so1703373e87.1
        for <linux-pci@vger.kernel.org>; Thu, 23 May 2024 03:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716458566; x=1717063366; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+DtF00AwPLtjMSDGEHCKeNGWuI3HSO+43wTk/AqWTE4=;
        b=VpQ7NcXeE9UWijwHzQec3sV0Bks8bvUSx6qESM51jES+C3zDKQjA58dydaYSSk8e/E
         4NHwqPOMSzof/ZqytSLVLFwLBFYhooXuPN6X740VFg3hMP39xinkBJjnc8bxgTk/GkXd
         UFkXjdIRlNlDvmB0X18fZM5YfmS//8n8Tgn0kKW4i5joC/kvS2n+feyAxgYxp9s4NM/Q
         xRHrYOEU1lSETnBIrHKE7nXTYx2EdN6zHqjX7BEBhyKkiOHqu82R8pQkXufakPb4o0Jp
         GSNc3/F1oqs9P97auF5fhcs/mK8jS8z33NcFrgwBkE5pR0tnaVUoicBTNh1hXKAl/INK
         ZUjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716458566; x=1717063366;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+DtF00AwPLtjMSDGEHCKeNGWuI3HSO+43wTk/AqWTE4=;
        b=B44sLj+IHoboxulXyuPtdSsgcbE9ui82ljTbrtsUcTAiebpRp4VjBORMegnhAiW56t
         HDJqsCvu4r+vvv3jskLAuK6wP3xBBLkd5l2+72vOklzjQquzYeJuK8kUbHsFePrpvxwJ
         x8z9j5JjEtyfB/KGHJo4F9vnpOftOqmknpYxCRr6kRrqs3FMVlGbQDQSn7FJNupj/DYB
         4L0YmP2wInRqlqwMBVto33lja5ds4QGaBSoj/IoMe7j05cx91qFeEUjNG87HmWgtj3dv
         hXHNtMZrPRv7jCURdI/lW8gFtC/3YkdA17UZs8er9ThnhR/4883hQG1H/NqA97m7d8KN
         jcOQ==
X-Gm-Message-State: AOJu0YwChBv7vEIvXovQ/lLUGtXBkCgZJDvwNm2xznvr9kmWc3ves/T9
	Sspqem3PJZ+v0wKnUmeDIjJY/SyphqiIaRii4svY0cEmRFlKnv6V
X-Google-Smtp-Source: AGHT+IHxHo0c8CYkTEkrYg20hYgnEQN7tZjNM3cYLNUGb6AzX6+RLPc3SFnEGXHSw84YWymWw8YgKg==
X-Received: by 2002:a05:6512:3da7:b0:51f:3e41:efd8 with SMTP id 2adb3069b0e04-527ef024c97mr729003e87.1.1716458565857;
        Thu, 23 May 2024 03:02:45 -0700 (PDT)
Received: from mobilestation ([178.176.56.174])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-521f38d8b44sm5349601e87.209.2024.05.23.03.02.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 03:02:45 -0700 (PDT)
Date: Thu, 23 May 2024 13:02:42 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Shyam Saini <shyamsaini@linux.microsoft.com>
Cc: linux-pci@vger.kernel.org, jingoohan1@gmail.com, 
	gustavo.pimentel@synopsys.com, Sergey.Semin@baikalelectronics.ru, code@tyhicks.com, 
	okaya@kernel.org, srivatsa@csail.mit.edu, apais@linux.microsoft.com, 
	vijayb@linux.microsoft.com, tballasi@linux.microsoft.com, bboscaccy@linux.microsoft.com
Subject: Re: [PATCH] drivers: pci: dwc: dynamically set pci region limit
Message-ID: <hxluc6qth4temdyxloekbhoy4iielyvxmmhp3u47qwtcxb5t5v@v5hdzvqmrsyv>
References: <20240523001046.1413579-1-shyamsaini@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240523001046.1413579-1-shyamsaini@linux.microsoft.com>

On Wed, May 22, 2024 at 05:10:46PM -0700, Shyam Saini wrote:
> commit 89473aa9ab26 ("PCI: dwc: Add iATU regions size detection procedure")
> hardcodes the pci region limit to 4G.

In what part does it _harcode_ the region limit to 4G? The procedure
_auto-detects_ the actual iATU region limits. The limits aren't
hardcoded.  The upper bound is 4G for DW PCIe IP-core older than
v4.60. If the IP-core is younger than that the upper bound will be
determined by the CX_ATU_MAX_REGION_SIZE IP-core synthesize parameter.
The auto-detection procedure is about the CX_ATU_MAX_REGION_SIZE
parameter detection.

> This causes regression on
> systems with PCI memory region higher than 4G.

I am sure it doesn't. If it did we would have got multiple bug-reports
right after the patch was merged into the mainline kernel repo. So
please provide a comprehensive description of the problem you have.

> 
> Fix this by dynamically setting pci region limit based on maximum
> size of memory ranges in the PCI device tree node.

It seems to me that your patch is an attempt to workaround some
problem you met. Give more insight about the problem in order to find
a proper fix. The justification you've provided so far seems incorrect.

Note you can't use the ranges DT-property specified on your platform
to determine the actual iATU regions size, because the later entity is
a primary/root parameter of the PCIe controller. The DT-node memory
ranges could be defined with a size greater than the actual iATU
region size. In that case the address translation logic will be broken
in the current driver implementation. AFAICS from the DW PCIe IP-core
HW-manuals the IO-transaction will be passed further to the PCIe bus with
no address translated and with the TLP fields filled in with the data
retrieved on the application interface (XALI/AXI):

"3.10.5.6 No Address Match Result Overview: When there is no address
match then the address is untranslated but the TLP header information
(for fields that are programmable) comes from the relevant fields on
the application transmit interface XALI* or AXI slave."

That isn't what could be allowed, because it may cause unpredictable
results up to the system crash, for instance, if the TLPs with the
untranslated TLPs reached a device they weren't targeted to.

If what you met in your system was a memory range greater than the
permitted iATU region limit, a proper fix would have been to allocate
a one more iATU region for the out of bounds part of the memory range.

-Serge(y)

> 
> Fixes: 89473aa9ab26 ("PCI: dwc: Add iATU regions size detection procedure")
> Signed-off-by: Shyam Saini <shyamsaini@linux.microsoft.com>
> ---
>  drivers/pci/controller/dwc/pcie-designware.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 250cf7f40b85..9b8975b35dd9 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -783,6 +783,9 @@ static void dw_pcie_link_set_max_link_width(struct dw_pcie *pci, u32 num_lanes)
>  void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  {
>  	int max_region, ob, ib;
> +	struct dw_pcie_rp *pp = &pci->pp;
> +	struct resource_entry *entry;
> +	u64 max_mem_sz = 0;
>  	u32 val, min, dir;
>  	u64 max;
>  
> @@ -832,10 +835,25 @@ void dw_pcie_iatu_detect(struct dw_pcie *pci)
>  		max = 0;
>  	}
>  
> +	resource_list_for_each_entry(entry, &pp->bridge->windows) {
> +		if (resource_type(entry->res) != IORESOURCE_MEM)
> +			continue;
> +		max_mem_sz = (max_mem_sz < resource_size(entry->res)) ?
> +						resource_size(entry->res) : max_mem_sz;
> +	}
> +
> +	if (max_mem_sz <= SZ_4G)
> +		pci->region_limit = (max << 32) | (SZ_4G - 1);
> +	else if ((max_mem_sz > SZ_4G) && (max_mem_sz <= SZ_8G))
> +		pci->region_limit = (max << 32) | (SZ_8G - 1);
> +	else if ((max_mem_sz > SZ_8G) && (max_mem_sz <= SZ_16G))
> +		pci->region_limit = (max << 32) | (SZ_16G - 1);
> +	else
> +		pci->region_limit = (max << 32) | (SZ_32G - 1);
> +
>  	pci->num_ob_windows = ob;
>  	pci->num_ib_windows = ib;
>  	pci->region_align = 1 << fls(min);
> -	pci->region_limit = (max << 32) | (SZ_4G - 1);
>  
>  	dev_info(pci->dev, "iATU: unroll %s, %u ob, %u ib, align %uK, limit %lluG\n",
>  		 dw_pcie_cap_is(pci, IATU_UNROLL) ? "T" : "F",
> -- 
> 2.34.1
> 
> 

