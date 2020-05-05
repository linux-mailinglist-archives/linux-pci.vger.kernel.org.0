Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2E541C4C69
	for <lists+linux-pci@lfdr.de>; Tue,  5 May 2020 04:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgEECx3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 22:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726641AbgEECx3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 22:53:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BEC7C061A0F;
        Mon,  4 May 2020 19:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=Y3ucUufDJXa4wGxZg++Bu9qVc2KiHeUm+zqaAO3Vyx8=; b=D4b6t3k/hBqIq0aHYoLQW/IHZn
        lJedJwQm8V3skgopLearo0zFBCCpHnks3h066Pwh5hjn5UASwA3T2gEqtAD3R63Z1/TWmyLEaISzj
        49h3GYbOwz4PGBpG2MFjttNUXF7aTI1fFOh9Kh5GF4+9JouTVAWHNp6JxBfgiAH2E/CwO1kv6QcOM
        MyDCm8S5m78jx1oNS5um1MdlR2MtcPoNc6EUdVbn+KWVYVgCHLCTAQBkQCQLxib3WgBzt+U5abWQd
        QlAQS6XZxWLG/NvAPVK7rPvLwuJ3opgWvEYBgmzJs780HXYcQJ5m0pdK3koTT5J62iSCm86dsfmQE
        Dot1vIOQ==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jVni4-0007Qf-Vs; Tue, 05 May 2020 02:53:29 +0000
Subject: Re: [PATCH 2/3] mfd: Intel Platform Monitoring Technology support
To:     "David E. Box" <david.e.box@linux.intel.com>, bhelgaas@google.com,
        andy@infradead.org, alexander.h.duyck@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Alexander Duyck <alexander.h.duyck@linux.intel.com>
References: <20200505013206.11223-1-david.e.box@linux.intel.com>
 <20200505023149.11630-1-david.e.box@linux.intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <531eb6c8-7403-5380-af40-dca229467e6e@infradead.org>
Date:   Mon, 4 May 2020 19:53:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200505023149.11630-1-david.e.box@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 5/4/20 7:31 PM, David E. Box wrote:
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 0a59249198d3..c673031acdf1 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -632,6 +632,16 @@ config MFD_INTEL_MSIC
>  	  Passage) chip. This chip embeds audio, battery, GPIO, etc.
>  	  devices used in Intel Medfield platforms.
>  
> +config MFD_INTEL_PMT
> +	tristate "Intel Platform Monitoring Technology support"
> +	depends on PCI
> +	select MFD_CORE
> +	help
> +	  The Intel Platform Monitoring Technology (PMT) is an interface that
> +	  provides access to hardware monitor registers. This driver supports
> +	  Telemetry, Watcher, and Crashlog PTM capabilities/devices for

What is PTM?


> +	  platforms starting from Tiger Lake.
> +
>  config MFD_IPAQ_MICRO
>  	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
>  	depends on SA1100_H3100 || SA1100_H3600


-- 
~Randy

