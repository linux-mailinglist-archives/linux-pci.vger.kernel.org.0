Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD7012701E2
	for <lists+linux-pci@lfdr.de>; Fri, 18 Sep 2020 18:16:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgIRQPg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Sep 2020 12:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726269AbgIRQPO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Sep 2020 12:15:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483E4C0613CE;
        Fri, 18 Sep 2020 09:15:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=67/LJuN1v7jqK9yEQqm5kjJLGJHidKzcy2YeicH9l8s=; b=rcxE1zOOSWuj1E7aHS2iL7rEb+
        wfImjsWXEMzQKI2KN7AOpMpdBc2QYOJa2uKsNX5xNgUXFPUfG+TiuBpMRpL7zpQoHlhfvnMcgjyrX
        74Tpj6LjKm4ZwnbLfA2dHQ7cunchcCZNEXjHhwbhuFWFIPvXQFtK5D2QaFnbuE5yHaEtKP+RSFtKA
        X1dSUmaFQMt/9+NJtgfAcXu/As3aq1nlKgZG4wSowu006Rc9qHSSkSsv7YOE+Or4csW92/0yc265s
        5H4ynYMicjg+KKyYnKIUUxKvCThsrsdTkWadTt4rzBaeOJy3xWX0+pOWRRkM2fYcCfCb91+5cAYCJ
        l8Zy+Xtg==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kJJ2R-0005Gj-Nl; Fri, 18 Sep 2020 16:15:07 +0000
Subject: Re: [PATCH v5 14/17] NTB: Add support for EPF PCI-Express
 Non-Transparent Bridge
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
 <20200918064227.1463-15-kishon@ti.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <93b651aa-23e5-9249-6b22-fef65806b007@infradead.org>
Date:   Fri, 18 Sep 2020 09:15:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200918064227.1463-15-kishon@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 9/17/20 11:42 PM, Kishon Vijay Abraham I wrote:
> diff --git a/drivers/ntb/hw/epf/Kconfig b/drivers/ntb/hw/epf/Kconfig
> new file mode 100644
> index 000000000000..6197d1aab344
> --- /dev/null
> +++ b/drivers/ntb/hw/epf/Kconfig
> @@ -0,0 +1,6 @@
> +config NTB_EPF
> +	tristate "Generic EPF Non-Transparent Bridge support"
> +	depends on m
> +	help
> +	  This driver supports EPF NTB on configurable endpoint.
> +	  If unsure, say N.

Hi,
Why is this driver restricted to 'm' (loadable module)?
I.e., it cannot be builtin.

thanks.
-- 
~Randy

