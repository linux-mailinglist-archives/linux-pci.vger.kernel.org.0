Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253B9457A3A
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229782AbhKTAnT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhKTAnT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 19 Nov 2021 19:43:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3E6C061574;
        Fri, 19 Nov 2021 16:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=urZlEbTkjQhLgAccgLfTOfoJ3CLTZ0kDAX18zbfGvBo=; b=Gb0zpb7OHnaM49+RDqwwFAG9CH
        hSttlnXFabKy4hUX08xeDIaBuS3aZCcN7IgpxAzyOwaE2/phzUSxmurvmg9TdDHGhBovEMhHyoIXc
        P5TcOQUY7Q75Eau5Ue0BiP2tgk3Ok6lG3HNTirhW/QiDzne5vSJ9QIjKuOq+IIjOV7hw3MasKUYIv
        2JdxzNGBSxJv6NPE+WzHi978NonHMcESimvGWXGRiSqM/YfNMZ8dU1xEyaOnbnAkmtJemhppz9ggl
        czmL6Q8F2o2rVfBgAQYq10eyeE0tB8yT9qiSdNwuF7Z8X8HdanSQae2q52xev2a9AGXK9/5fj6dhN
        /nj38nrA==;
Received: from [2601:1c0:6280:3f0::aa0b]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1moEQM-00Br0C-5V; Sat, 20 Nov 2021 00:40:10 +0000
Subject: Re: [PATCH 22/23] cxl/mem: Introduce cxl_mem driver
To:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-23-ben.widawsky@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8eece50a-ffc6-700a-1613-4d45de37bdd2@infradead.org>
Date:   Fri, 19 Nov 2021 16:40:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211120000250.1663391-23-ben.widawsky@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 11/19/21 4:02 PM, Ben Widawsky wrote:
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 3aeb33bba5a3..f5553443ba2a 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -30,6 +30,21 @@ config CXL_PCI
>   
>   	  If unsure say 'm'.
>   
> +config CXL_MEM
> +	tristate "CXL.mem: Memory Devices"
> +	default CXL_BUS
> +        help
> +          The CXL.mem protocol allows a device to act as a provider of
> +	  "System RAM" and/or "Persistent Memory" that is fully coherent
> +	  as if the memory was attached to the typical CPU memory controller.
> +	  This is known as HDM "Host-managed Device Memory".
> +
> +	  Say 'y/m' to enable a driver that will attach to CXL.mem devices for
> +	  memory expansion and control of HDM. See Chapter 9.13 in the CXL 2.0
> +	  specification for a detailed description of HDM.
> +
> +	  If unsure say 'm'.

Hi Ben,

Both patch 20 and patch 22 add a "new" CXL_MEM config symbol.
Is one of them a typo?

thanks.
-- 
~Randy
