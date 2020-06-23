Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE74D204DDE
	for <lists+linux-pci@lfdr.de>; Tue, 23 Jun 2020 11:23:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731919AbgFWJXy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Jun 2020 05:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731912AbgFWJXx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jun 2020 05:23:53 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855BEC061573;
        Tue, 23 Jun 2020 02:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=n42uQFh17CdO0bIElKUPrWq2FZ0jIAeEhIRWnOCALuU=; b=uwd8NM91afP+YPwWO0zwWWECYF
        te8u/t4tum1nk/XdFbYYU/ZyLOoDRuEj5aRqUrDQO45/erMoawOMwOjZAioaX51dTXjKamd2vtar1
        BwImxnHqwdzY/Cn3tSKyaPRaLu5qOZaN3raDA/JXMB1lWSvLA0CizlO5iAw2HggPqtixMeGbsWSkX
        6dVuKdU+5Kd0bD+d11ZrppzcItzKCL1RDNMJfI3WYakzbXsT8gdXTqqrx/oszZNsZ4I38EvycrLEo
        IPLCOGE+0zxP6ZtLeSfgmZOK34uAzkwKfNT0mm8KxVPXQ03JH0+q0C3Br72eNHgo5bbEyQA9fvogA
        FakPkASw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jnf98-0000ln-Hf; Tue, 23 Jun 2020 09:23:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id CDE0F3003E5;
        Tue, 23 Jun 2020 11:23:12 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 65933237095E6; Tue, 23 Jun 2020 11:23:12 +0200 (CEST)
Date:   Tue, 23 Jun 2020 11:23:12 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nitesh Narayan Lal <nitesh@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        frederic@kernel.org, mtosatti@redhat.com, juri.lelli@redhat.com,
        abelits@marvell.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, rostedt@goodmis.org, mingo@kernel.org,
        tglx@linutronix.de, davem@davemloft.net, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, stephen@networkplumber.org,
        rppt@linux.vnet.ibm.com
Subject: Re: [Patch v2 3/3] net: Restrict receive packets queuing to
 housekeeping CPUs
Message-ID: <20200623092312.GC4781@hirez.programming.kicks-ass.net>
References: <20200622234510.240834-1-nitesh@redhat.com>
 <20200622234510.240834-4-nitesh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200622234510.240834-4-nitesh@redhat.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 22, 2020 at 07:45:10PM -0400, Nitesh Narayan Lal wrote:
> @@ -756,6 +757,13 @@ static ssize_t store_rps_map(struct netdev_rx_queue *queue,
>  		return err;
>  	}
>  
> +	hk_flags = HK_FLAG_DOMAIN | HK_FLAG_WQ;
> +	cpumask_and(mask, mask, housekeeping_cpumask(hk_flags));
> +	if (cpumask_weight(mask) == 0) {

We have cpumask_empty() for that, which is a much more efficient way of
testing the same.

> +		free_cpumask_var(mask);
> +		return -EINVAL;
> +	}
> +
>  	map = kzalloc(max_t(unsigned int,
>  			    RPS_MAP_SIZE(cpumask_weight(mask)), L1_CACHE_BYTES),
>  		      GFP_KERNEL);
> -- 
> 2.18.4
> 
