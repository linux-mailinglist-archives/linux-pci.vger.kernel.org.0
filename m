Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 488AF4714F4
	for <lists+linux-pci@lfdr.de>; Sat, 11 Dec 2021 18:35:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhLKRfg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Dec 2021 12:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbhLKRff (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Dec 2021 12:35:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB1DC061714;
        Sat, 11 Dec 2021 09:35:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E206DB80B2F;
        Sat, 11 Dec 2021 17:35:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A768C004DD;
        Sat, 11 Dec 2021 17:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639244132;
        bh=lwl+S4gBx9+MmP7cUVpbKcR9U30TwUBZItbC7aQoL7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Vn9vatHyt83ViQdCtuID65v/a0R2BHIeN8/U9ISQg579+OGH5HnC1AXqI+f49N9mh
         4sqZaGIVX9z9DVAIgzYLvYtU/exvPy2Gmpe8wzQSSZajglIIRFaSIjLWoC7Pzb5c1n
         E7NIw8FJ50uJic4XTVf1dRC2vtscyvlhhB4ZBxH7GoUWDiEa/QgNgGAw8LoQYuOfwj
         D+kszdFRl/EdC5fUkEha7TPAIT9CL3zZIq0muuYXaZZmEMjh4YqrsEQxeQsYmNbu24
         Einpl0t+ol+5/WydnilM5gzwBNvzAmxc8jElLEa28r8XMJfbg9ehW/AMXjxt8ir55G
         NkiLRit8FSfWA==
Date:   Sat, 11 Dec 2021 11:35:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v1 1/1] pci_ids: Keep Intel PCI IDs sorted by value
Message-ID: <20211211173530.GA397083@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211209195231.2785-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Dec 09, 2021 at 09:52:31PM +0200, Andy Shevchenko wrote:
> Keep Intel PCI IDs sorted by value.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Applied to pci/misc for v5.17, thanks!

There were a few Intel IDs that used upper-case hex; I lower-cased
them to match the rest.

> ---
>  include/linux/pci_ids.h | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
> index 86678588d191..306201cb9aff 100644
> --- a/include/linux/pci_ids.h
> +++ b/include/linux/pci_ids.h
> @@ -2738,12 +2738,6 @@
>  #define PCI_DEVICE_ID_INTEL_82801EB_11	0x24db
>  #define PCI_DEVICE_ID_INTEL_82801EB_12	0x24dc
>  #define PCI_DEVICE_ID_INTEL_82801EB_13	0x24dd
> -#define PCI_DEVICE_ID_INTEL_ESB_1	0x25a1
> -#define PCI_DEVICE_ID_INTEL_ESB_2	0x25a2
> -#define PCI_DEVICE_ID_INTEL_ESB_4	0x25a4
> -#define PCI_DEVICE_ID_INTEL_ESB_5	0x25a6
> -#define PCI_DEVICE_ID_INTEL_ESB_9	0x25ab
> -#define PCI_DEVICE_ID_INTEL_ESB_10	0x25ac
>  #define PCI_DEVICE_ID_INTEL_82820_HB	0x2500
>  #define PCI_DEVICE_ID_INTEL_82820_UP_HB	0x2501
>  #define PCI_DEVICE_ID_INTEL_82850_HB	0x2530
> @@ -2758,14 +2752,15 @@
>  #define PCI_DEVICE_ID_INTEL_82915G_IG	0x2582
>  #define PCI_DEVICE_ID_INTEL_82915GM_HB	0x2590
>  #define PCI_DEVICE_ID_INTEL_82915GM_IG	0x2592
> +#define PCI_DEVICE_ID_INTEL_ESB_1	0x25a1
> +#define PCI_DEVICE_ID_INTEL_ESB_2	0x25a2
> +#define PCI_DEVICE_ID_INTEL_ESB_4	0x25a4
> +#define PCI_DEVICE_ID_INTEL_ESB_5	0x25a6
> +#define PCI_DEVICE_ID_INTEL_ESB_9	0x25ab
> +#define PCI_DEVICE_ID_INTEL_ESB_10	0x25ac
>  #define PCI_DEVICE_ID_INTEL_5000_ERR	0x25F0
>  #define PCI_DEVICE_ID_INTEL_5000_FBD0	0x25F5
>  #define PCI_DEVICE_ID_INTEL_5000_FBD1	0x25F6
> -#define PCI_DEVICE_ID_INTEL_82945G_HB	0x2770
> -#define PCI_DEVICE_ID_INTEL_82945G_IG	0x2772
> -#define PCI_DEVICE_ID_INTEL_3000_HB	0x2778
> -#define PCI_DEVICE_ID_INTEL_82945GM_HB	0x27A0
> -#define PCI_DEVICE_ID_INTEL_82945GM_IG	0x27A2
>  #define PCI_DEVICE_ID_INTEL_ICH6_0	0x2640
>  #define PCI_DEVICE_ID_INTEL_ICH6_1	0x2641
>  #define PCI_DEVICE_ID_INTEL_ICH6_2	0x2642
> @@ -2777,6 +2772,11 @@
>  #define PCI_DEVICE_ID_INTEL_ESB2_14	0x2698
>  #define PCI_DEVICE_ID_INTEL_ESB2_17	0x269b
>  #define PCI_DEVICE_ID_INTEL_ESB2_18	0x269e
> +#define PCI_DEVICE_ID_INTEL_82945G_HB	0x2770
> +#define PCI_DEVICE_ID_INTEL_82945G_IG	0x2772
> +#define PCI_DEVICE_ID_INTEL_3000_HB	0x2778
> +#define PCI_DEVICE_ID_INTEL_82945GM_HB	0x27A0
> +#define PCI_DEVICE_ID_INTEL_82945GM_IG	0x27A2
>  #define PCI_DEVICE_ID_INTEL_ICH7_0	0x27b8
>  #define PCI_DEVICE_ID_INTEL_ICH7_1	0x27b9
>  #define PCI_DEVICE_ID_INTEL_ICH7_30	0x27b0
> @@ -2941,16 +2941,16 @@
>  #define PCI_DEVICE_ID_INTEL_SBRIDGE_BR		0x3cf5	/* 13.6 */
>  #define PCI_DEVICE_ID_INTEL_SBRIDGE_SAD1	0x3cf6	/* 12.7 */
>  #define PCI_DEVICE_ID_INTEL_IOAT_SNB	0x402f
> -#define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
> -#define PCI_DEVICE_ID_INTEL_5100_19	0x65f3
> -#define PCI_DEVICE_ID_INTEL_5100_21	0x65f5
> -#define PCI_DEVICE_ID_INTEL_5100_22	0x65f6
>  #define PCI_DEVICE_ID_INTEL_5400_ERR	0x4030
>  #define PCI_DEVICE_ID_INTEL_5400_FBD0	0x4035
>  #define PCI_DEVICE_ID_INTEL_5400_FBD1	0x4036
> -#define PCI_DEVICE_ID_INTEL_IOAT_SCNB	0x65ff
>  #define PCI_DEVICE_ID_INTEL_EP80579_0	0x5031
>  #define PCI_DEVICE_ID_INTEL_EP80579_1	0x5032
> +#define PCI_DEVICE_ID_INTEL_5100_16	0x65f0
> +#define PCI_DEVICE_ID_INTEL_5100_19	0x65f3
> +#define PCI_DEVICE_ID_INTEL_5100_21	0x65f5
> +#define PCI_DEVICE_ID_INTEL_5100_22	0x65f6
> +#define PCI_DEVICE_ID_INTEL_IOAT_SCNB	0x65ff
>  #define PCI_DEVICE_ID_INTEL_82371SB_0	0x7000
>  #define PCI_DEVICE_ID_INTEL_82371SB_1	0x7010
>  #define PCI_DEVICE_ID_INTEL_82371SB_2	0x7020
> -- 
> 2.33.0
> 
