Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 966003BC16D
	for <lists+linux-pci@lfdr.de>; Mon,  5 Jul 2021 18:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbhGEQOo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Jul 2021 12:14:44 -0400
Received: from ale.deltatee.com ([204.191.154.188]:40548 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbhGEQOo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Jul 2021 12:14:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=Q3YIK3t9z+fN5nGyXTdIuXppJPkxUCeL7c4AVzJi+kY=; b=l6HJ3DnwxZZU6aKXCzjaIRSBsT
        LbVWl7FbsPNed0mxfaZYeSjZ9c+8xrk+2OoGr0VRbICRVllqYNWNz6P3qI5F5Hbi/yJzxfC6qaXyS
        yOyg762Y2AC2DmygosBJ8ljHE2PFFwpGB/NqLv0FdY9n0GHIea2PFxVbdRewWp5Qfaxpo0Ckd70t3
        /05fNLEg6T9pgswty+tL7OVFlueljO2/Vpr0wEVGZWABzpXmcDWH2YSCi2mFUZjSKnh1DHadyrHNn
        JevsJ05ol0XwIxSLUv8X+oEfgDo9iidMUv0OITntKJuyIGvU4cnVPujmsLdCwWSMDnvqww98+xxsN
        vOlYnjhA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1m0RCQ-0002b1-IF; Mon, 05 Jul 2021 10:12:01 -0600
To:     Eric Dumazet <eric.dumazet@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, linux-pci@vger.kernel.org
References: <20210701095621.3129283-1-eric.dumazet@gmail.com>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <986ec985-a42c-9107-564d-5878a669388b@deltatee.com>
Date:   Mon, 5 Jul 2021 10:11:55 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210701095621.3129283-1-eric.dumazet@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, rafael@kernel.org, jglisse@redhat.com, gregkh@linuxfoundation.org, hch@lst.de, ira.weiny@intel.com, dan.j.williams@intel.com, edumazet@google.com, linux-kernel@vger.kernel.org, bhelgaas@google.com, eric.dumazet@gmail.com
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        MYRULES_URI_HASH,NICE_REPLY_A autolearn=no autolearn_force=no
        version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: finish RCU conversion of pdev->p2pdma
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-07-01 3:56 a.m., Eric Dumazet wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> While looking at pci_alloc_p2pmem() I found rcu protection
> was not properly applied there, as pdev->p2pdma was
> potentially read multiple times.
> 
> I decided to fix pci_alloc_p2pmem(), add __rcu qualifier
> to p2pdma field of struct pci_dev, and fix all
> other accesses to this field with proper rcu verbs.
> 
> Fixes: 1570175abd16 ("PCI/P2PDMA: track pgmap references per resource, not globally")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: "Jérôme Glisse" <jglisse@redhat.com>
> Cc: "Rafael J. Wysocki" <rafael@kernel.org>
> Cc: linux-pci@vger.kernel.org

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

For history, though, Dan had originally suggested the full RCU
protection is not necessary and it was only a barrier to force the NULL
check on teardown to resolve:

https://lore.kernel.org/nvdimm/CAPcyv4jZiK+OHjwNqDARv4g326AQZx7N_Lmxj1Zux_bX1T2CLQ@mail.gmail.com/

Things may have changed since then and other uses might be racing with
the teardown, so having it marked __rcu and fully protected sounds like
a good idea to me.

Logan
