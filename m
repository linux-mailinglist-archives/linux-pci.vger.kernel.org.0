Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD0E5BA366
	for <lists+linux-pci@lfdr.de>; Fri, 16 Sep 2022 02:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIPADS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Sep 2022 20:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIPADR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Sep 2022 20:03:17 -0400
X-Greylist: delayed 2037 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 15 Sep 2022 17:03:15 PDT
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C567B52DF7
        for <linux-pci@vger.kernel.org>; Thu, 15 Sep 2022 17:03:15 -0700 (PDT)
Received: from [128.177.82.146] (helo=srivatsab-a02.vmware.com)
        by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1oYyID-000q2X-RC;
        Thu, 15 Sep 2022 19:29:13 -0400
To:     Liang He <windhl@126.com>, jgross@suse.com,
        virtualization@lists.linux-foundation.org
Cc:     wangkelin2023@163.com, jan.kiszka@siemens.com,
        Thomas Gleixner <tglx@linutronix.de>,
        jailhouse-dev@googlegroups.com, mark.rutland@arm.com,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20220915022343.4001331-1-windhl@126.com>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH] jailhouse: Hold reference returned from of_find_xxx API
Message-ID: <f7316f94-433f-d191-0379-423c22bec129@csail.mit.edu>
Date:   Thu, 15 Sep 2022 16:29:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220915022343.4001331-1-windhl@126.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


[ Adding author and reviewers of commit 63338a38db95 ]

On 9/14/22 7:23 PM, Liang He wrote:
> In jailhouse_paravirt(), we should hold the reference returned from
> of_find_compatible_node() which has increased the refcount and then
> call of_node_put() with it when done.
> 
> Fixes: 63338a38db95 ("jailhouse: Provide detection for non-x86 systems")
> Signed-off-by: Liang He <windhl@126.com>
> Signed-off-by: Kelin Wang <wangkelin2023@163.com>
> ---
>  include/linux/hypervisor.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
> index 9efbc54e35e5..7fe1e8c6211c 100644
> --- a/include/linux/hypervisor.h
> +++ b/include/linux/hypervisor.h
> @@ -27,7 +27,11 @@ static inline void hypervisor_pin_vcpu(int cpu)
>  
>  static inline bool jailhouse_paravirt(void)
>  {
> -	return of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> +	struct device_node *np = of_find_compatible_node(NULL, NULL, "jailhouse,cell");
> +
> +	of_node_put(np);
> +
> +	return np;
>  }
>  

Thank you for the fix, but returning a pointer from a function with a
bool return type looks odd. Can we also fix that up please?


Regards,
Srivatsa
VMware Photon OS
