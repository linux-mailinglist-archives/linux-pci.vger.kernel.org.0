Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 036D95BB681
	for <lists+linux-pci@lfdr.de>; Sat, 17 Sep 2022 07:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbiIQFZo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Sep 2022 01:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIQFZn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Sep 2022 01:25:43 -0400
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D6072870
        for <linux-pci@vger.kernel.org>; Fri, 16 Sep 2022 22:25:40 -0700 (PDT)
Received: from c-24-17-218-140.hsd1.wa.comcast.net ([24.17.218.140] helo=srivatsab-a02.vmware.com)
        by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.95)
        (envelope-from <srivatsa@csail.mit.edu>)
        id 1oZQKc-001ohd-JP;
        Sat, 17 Sep 2022 01:25:34 -0400
Subject: Re: [PATCH v2] jailhouse: Hold reference returned from of_find_xxx
 API
To:     Liang He <windhl@126.com>, jgross@suse.com,
        virtualization@lists.linux-foundation.org
Cc:     wangkelin2023@163.com, jailhouse-dev@googlegroups.com,
        mark.rutland@arm.com, jan.kiszka@siemens.com,
        andy.shevchenko@gmail.com, robh+dt@kernel.org,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        Thomas Gleixner <tglx@linutronix.de>
References: <20220916090051.4096328-1-windhl@126.com>
From:   "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Message-ID: <0069849b-e6c7-5c9b-4b52-5aa6e4a328e4@csail.mit.edu>
Date:   Fri, 16 Sep 2022 22:25:31 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20220916090051.4096328-1-windhl@126.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ Adding author and reviewers of commit 63338a38db95 again ]

On 9/16/22 2:00 AM, Liang He wrote:
> In jailhouse_paravirt(), we should hold the reference returned from
> of_find_compatible_node() which has increased the refcount and then
> call of_node_put() with it when done.
> 
> Fixes: 63338a38db95 ("jailhouse: Provide detection for non-x86 systems")
> Signed-off-by: Liang He <windhl@126.com>
> Co-developed-by: Kelin Wang <wangkelin2023@163.com>
> Signed-off-by: Kelin Wang <wangkelin2023@163.com>

Reviewed-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>

> ---
> 
>  v2: use proper return type not the 'np' pointer
> 
>  include/linux/hypervisor.h | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/hypervisor.h b/include/linux/hypervisor.h
> index 9efbc54e35e5..f11eec57ea63 100644
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
> +	return np ? true : false;
>  }
>  
>  #endif /* !CONFIG_X86 */
>

Regards,
Srivatsa
VMware Photon OS
