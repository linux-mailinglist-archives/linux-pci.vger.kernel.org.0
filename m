Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51DB82701F5
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 18:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgIRQSB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 12:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgIRQSB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 12:18:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503CAC0613CE;
        Fri, 18 Sep 2020 09:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=pMf3yFiIumdNcekeEz4Oor/d6RhvmD0GihZ6qnHJHTY=; b=X4vERyHqnHEBEA94wF51qqW4HX
        NghotAlu3GSor0pxZlvBGiNHhbRiNdC+NjJDY4gArxz+EQUb3Q3FMg3dbMRZhdvSQtuAswZWTTp2/
        T4L2vgVfjT/fQsbGttNjeAMsOEO+XCxpWTnlvq4WVVpXsXoQWIhIFtLA6Y66rhs4JZ8S9Lzen/gF8
        G24akz24Y6oR5qETilCtbC0nH3dpd6HdyZeSghodHIqRU9I/zwIN7FLro4RHyCHaTrqUJkHKAoLYG
        ZEluqruYgGD8oIGk0KLS9Uj3GNXuzmb6RRfluQqNZ+mArW3/cZr3FmyuntTySR2v+b/wpvpTU8ef0
        Z7x+YLlA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJJ5D-0005VP-4v; Fri, 18 Sep 2020 16:17:59 +0000
Subject: Re: [PATCH v5 12/17] PCI: endpoint: Add EP function driver to provide
 NTB functionality
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>,
        Tom Joseph <tjoseph@cadence.com>, Rob Herring <robh@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-ntb@googlegroups.com
References: <20200918064227.1463-1-kishon@ti.com>
 <20200918064227.1463-13-kishon@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <31985ad8-2e9b-99d8-55ef-4ae90103e499@infradead.org>
Date:   Fri, 18 Sep 2020 09:17:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918064227.1463-13-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/17/20 11:42 PM, Kishon Vijay Abraham I wrote:
> diff --git a/drivers/pci/endpoint/functions/Kconfig b/drivers/pci/endpoint/functions/Kconfig
> index 8820d0f7ec77..55ac7bb2d469 100644
> --- a/drivers/pci/endpoint/functions/Kconfig
> +++ b/drivers/pci/endpoint/functions/Kconfig
> @@ -12,3 +12,15 @@ config PCI_EPF_TEST
>  	   for PCI Endpoint.
>  
>  	   If in doubt, say "N" to disable Endpoint test driver.
> +
> +config PCI_EPF_NTB
> +	tristate "PCI Endpoint NTB driver"
> +	depends on PCI_ENDPOINT
> +	help
> +	   Select this configuration option to enable the NTB driver
> +	   for PCI Endpoint. NTB driver implements NTB controller
> +	   functionality using multiple PCIe endpoint instances. It
> +	   can support NTB endpoint function devices created using
> +	   device tree.

Indent help text with one tab + 2 spaces...
according to coding-style.rst.


> +
> +	   If in doubt, say "N" to disable Endpoint NTB driver.


thanks.
-- 
~Randy

