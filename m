Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9FC57E8BA
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 23:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiGVVNf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Jul 2022 17:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiGVVNe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Jul 2022 17:13:34 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECA9B504E;
        Fri, 22 Jul 2022 14:13:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC061B82B1C;
        Fri, 22 Jul 2022 21:13:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46E77C341C7;
        Fri, 22 Jul 2022 21:13:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658524411;
        bh=Msfql5pg85Ax6GZuIhAfLpJ9yluJf279FymZfm9pLYE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=a7h7pC3Q21q8A7UeiC8kGfMcTAWnUU42P7avg0TJkl6C/w+lszyRY4z/9g7JVv2o4
         hU2iqB4gdzpt9e9Q/gAJO+QRRxSfpi+YYEaism01NVZ6KJQ34JILv1/i0tvWbdCNS5
         qWUZlXbHN6sXLsWMHoVONhMTMJ4Pri/TVwKhXF0x4gwjadGlgHQeAkYEG3kzOXZ4mp
         qsUxETQWSLZeV6hWgi53OON/6sA4DRqVRwuvdjqBKBgnT+Lt5mBjWbAJuvcAH9KG+u
         Q77Oeuhs6TYhlhwIS2JqioBcfHLEJqD+GB32KlDHQsf7J5Tb1QXrEUtEWFxnD1MbP8
         lp+SbYYzoWE9w==
Date:   Fri, 22 Jul 2022 16:13:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Pierre Morel <pmorel@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/5] PCI: Extend isolated function probing to s390
Message-ID: <20220722211329.GA1935284@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220628143100.3228092-5-schnelle@linux.ibm.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jun 28, 2022 at 04:30:59PM +0200, Niklas Schnelle wrote:
> Like the jailhouse hypervisor s390's PCI architecture allows passing
> isolated PCI functions to an OS instance. As of now this is was not
> utilized even with multi-function support as the s390 PCI code makes
> sure that only virtual PCI busses including a function with devfn 0 are
> presented to the PCI subsystem. A subsequent change will remove this
> restriction.
> 
> Allow probing such functions by replacing the existing check for
> jailhouse_paravirt() with a new hypervisor_isolated_pci_functions()
> helper.
> 
> Cc: Jan Kiszka <jan.kiszka@siemens.com>
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> ---
>  drivers/pci/probe.c        | 2 +-
>  include/linux/hypervisor.h | 8 ++++++++
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index a18e07e6a7df..156dd13594b8 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2667,7 +2667,7 @@ int pci_scan_slot(struct pci_bus *bus, int devfn)
>  			 * a hypervisor which passes through individual PCI
>  			 * functions.
>  			 */
> -			if (!jailhouse_paravirt())
> +			if (!hypervisor_isolated_pci_functions())
>  				break;
>  		}
>  		fn = next_fn(bus, dev, fn);
> diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
> index fc08b433c856..33b1c0482aac 100644
> --- a/include/linux/hypervisor.h
> +++ b/include/linux/hypervisor.h
> @@ -32,4 +32,12 @@ static inline bool jailhouse_paravirt(void)
>  
>  #endif /* !CONFIG_X86 */
>  
> +static inline bool hypervisor_isolated_pci_functions(void)
> +{
> +	if (IS_ENABLED(CONFIG_S390))
> +		return true;
> +	else
> +		return jailhouse_paravirt();

It looks kind of wasteful that jailhouse_paravirt() searches the DT
for "jailhouse,cell" several times when I think that's an unchanging
property.

Obviously you didn't add that in this series, and s390 avoids that
cost anyway.  But the jailhouse folks might consider optimizing it
somehow.

> +}
> +
>  #endif /* __LINUX_HYPEVISOR_H */
> -- 
> 2.32.0
> 
