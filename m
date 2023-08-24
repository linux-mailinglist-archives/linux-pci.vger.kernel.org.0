Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09647870BD
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 15:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbjHXNqA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 24 Aug 2023 09:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241572AbjHXNpo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 09:45:44 -0400
Received: from outpost1.zedat.fu-berlin.de (outpost1.zedat.fu-berlin.de [130.133.4.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CFC51FDD;
        Thu, 24 Aug 2023 06:45:28 -0700 (PDT)
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1qZAd5-002K93-PJ; Thu, 24 Aug 2023 15:44:07 +0200
Received: from p57bd925a.dip0.t-ipconnect.de ([87.189.146.90] helo=[192.168.178.81])
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1qZAd5-0034gd-9F; Thu, 24 Aug 2023 15:44:07 +0200
Message-ID: <41c52315484c6ba60db0be5a19128a6d78ffd02d.camel@physik.fu-berlin.de>
Subject: Re: [PATCH 03/14] sh: pci: Do PCI error check on own line
From:   John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Thu, 24 Aug 2023 15:44:06 +0200
In-Reply-To: <20230824132832.78705-4-ilpo.jarvinen@linux.intel.com>
References: <20230824132832.78705-1-ilpo.jarvinen@linux.intel.com>
         <20230824132832.78705-4-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.48.4 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.146.90
X-ZEDAT-Hint: PO
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2023-08-24 at 16:28 +0300, Ilpo Järvinen wrote:
> Instead of a if condition with a line split, use the usual error
> handling pattern with a separate variable to improve readability.
> 
> No functional changes intended.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  arch/sh/drivers/pci/common.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/sh/drivers/pci/common.c b/arch/sh/drivers/pci/common.c
> index 2fd2b77e12ce..f59e5b9a6a80 100644
> --- a/arch/sh/drivers/pci/common.c
> +++ b/arch/sh/drivers/pci/common.c
> @@ -53,15 +53,16 @@ int __init pci_is_66mhz_capable(struct pci_channel *hose,
>  	unsigned short vid;
>  	int cap66 = -1;
>  	u16 stat;
> +	int ret;
>  
>  	pr_info("PCI: Checking 66MHz capabilities...\n");
>  
>  	for (pci_devfn = 0; pci_devfn < 0xff; pci_devfn++) {
>  		if (PCI_FUNC(pci_devfn))
>  			continue;
> -		if (early_read_config_word(hose, top_bus, current_bus,
> -					   pci_devfn, PCI_VENDOR_ID, &vid) !=
> -		    PCIBIOS_SUCCESSFUL)
> +		ret = early_read_config_word(hose, top_bus, current_bus,
> +					     pci_devfn, PCI_VENDOR_ID, &vid);
> +		if (ret != PCIBIOS_SUCCESSFUL)
>  			continue;
>  		if (vid == 0xffff)
>  			continue;

Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913
