Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49A96181983
	for <lists+linux-pci@lfdr.de>; Wed, 11 Mar 2020 14:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729528AbgCKNVD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Mar 2020 09:21:03 -0400
Received: from mga12.intel.com ([192.55.52.136]:30445 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729345AbgCKNVC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 11 Mar 2020 09:21:02 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 11 Mar 2020 06:21:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,541,1574150400"; 
   d="scan'208";a="389260038"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
  by orsmga004.jf.intel.com with ESMTP; 11 Mar 2020 06:20:56 -0700
Received: from andy by smile with local (Exim 4.93)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1jC1IA-008k0b-2U; Wed, 11 Mar 2020 15:20:58 +0200
Date:   Wed, 11 Mar 2020 15:20:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Guan Xuetao <gxt@pku.edu.cn>, Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pragat Pandya <pragat.pandya@gmail.com>,
        linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: fix pointers to io-mapping.rst and io_ordering.rst
 files
Message-ID: <20200311132058.GO1922688@smile.fi.intel.com>
References: <c0205119db4fef536272cb0a183b6c14c2c8bf4c.1583927470.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c0205119db4fef536272cb0a183b6c14c2c8bf4c.1583927470.git.mchehab+huawei@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 11, 2020 at 12:51:17PM +0100, Mauro Carvalho Chehab wrote:
> Those files got moved, but cross-references still point to the
> wrong places.

FWIW,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: fcd680727157 ("Documentation: Add io-mapping.rst to driver-api manual")
> Fixes: d1ce350015d8 ("Documentation: Add io_ordering.rst to driver-api manual")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  Documentation/PCI/pci.rst                        | 2 +-
>  Documentation/translations/zh_CN/io_ordering.txt | 4 ++--
>  arch/unicore32/include/asm/io.h                  | 2 +-
>  include/linux/io-mapping.h                       | 2 +-
>  4 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/PCI/pci.rst b/Documentation/PCI/pci.rst
> index 6864f9a70f5f..8c016d8c9862 100644
> --- a/Documentation/PCI/pci.rst
> +++ b/Documentation/PCI/pci.rst
> @@ -239,7 +239,7 @@ from the PCI device config space. Use the values in the pci_dev structure
>  as the PCI "bus address" might have been remapped to a "host physical"
>  address by the arch/chip-set specific kernel support.
>  
> -See Documentation/io-mapping.txt for how to access device registers
> +See Documentation/driver-api/io-mapping.rst for how to access device registers
>  or device memory.
>  
>  The device driver needs to call pci_request_region() to verify
> diff --git a/Documentation/translations/zh_CN/io_ordering.txt b/Documentation/translations/zh_CN/io_ordering.txt
> index 1f8127bdd415..7bb3086227ae 100644
> --- a/Documentation/translations/zh_CN/io_ordering.txt
> +++ b/Documentation/translations/zh_CN/io_ordering.txt
> @@ -1,4 +1,4 @@
> -Chinese translated version of Documentation/io_ordering.txt
> +Chinese translated version of Documentation/driver-api/io_ordering.rst
>  
>  If you have any comment or update to the content, please contact the
>  original document maintainer directly.  However, if you have a problem
> @@ -8,7 +8,7 @@ or if there is a problem with the translation.
>  
>  Chinese maintainer: Lin Yongting <linyongting@gmail.com>
>  ---------------------------------------------------------------------
> -Documentation/io_ordering.txt 的中文翻译
> +Documentation/driver-api/io_ordering.rst 的中文翻译
>  
>  如果想评论或更新本文的内容，请直接联系原文档的维护者。如果你使用英文
>  交流有困难的话，也可以向中文版维护者求助。如果本翻译更新不及时或者翻
> diff --git a/arch/unicore32/include/asm/io.h b/arch/unicore32/include/asm/io.h
> index 3ca74e1cde7d..bd4e7c332f85 100644
> --- a/arch/unicore32/include/asm/io.h
> +++ b/arch/unicore32/include/asm/io.h
> @@ -27,7 +27,7 @@ extern void __uc32_iounmap(volatile void __iomem *addr);
>   * ioremap and friends.
>   *
>   * ioremap takes a PCI memory address, as specified in
> - * Documentation/io-mapping.txt.
> + * Documentation/driver-api/io-mapping.rst.
>   *
>   */
>  #define ioremap(cookie, size)		__uc32_ioremap(cookie, size)
> diff --git a/include/linux/io-mapping.h b/include/linux/io-mapping.h
> index 837058bc1c9f..b336622612f3 100644
> --- a/include/linux/io-mapping.h
> +++ b/include/linux/io-mapping.h
> @@ -16,7 +16,7 @@
>   * The io_mapping mechanism provides an abstraction for mapping
>   * individual pages from an io device to the CPU in an efficient fashion.
>   *
> - * See Documentation/io-mapping.txt
> + * See Documentation/driver-api/io-mapping.rst
>   */
>  
>  struct io_mapping {
> -- 
> 2.24.1
> 

-- 
With Best Regards,
Andy Shevchenko


