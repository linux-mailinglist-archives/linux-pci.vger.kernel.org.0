Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3877C3A3714
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 00:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbhFJW2A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Jun 2021 18:28:00 -0400
Received: from ale.deltatee.com ([204.191.154.188]:38362 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231151AbhFJW17 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Jun 2021 18:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=VrA153MK/tuxQoc8FB6bcVxMGuksBkUH2etJY1B7azY=; b=o9ULBMduI3BcivBGi3diQZURPA
        I8pqvox1eiC+7//vKhh+wp0WH4/ckvZarPfhISMTTmIMKzV8cfKEwWh5BN6D5xtIOj5t0OcYiK9ar
        SlldcHp/UDclQNaowfMDl8+mMVDmB622GEXGHSWDpLxFn88Xsq9ATEC2ZrpfgtVlJ4Dbd0ioyBtOf
        87cnfhz7zAfNOIrvkBkrkt/cBj7CKLQdXsF9CBgQcFvGRPHJ8CDZcBiJyqy20tuGvLgskyMEouLcL
        HbI0yokrFVakn0H+F6lRl5kI3/AzwylFcrMsFtAqiK5yf3xAbLhDP5U9bg16LSM6+C0WK35V5Xkf9
        kVJ25TEA==;
Received: from s0106a84e3fe8c3f3.cg.shawcable.net ([24.64.144.200] helo=[192.168.0.10])
        by ale.deltatee.com with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lrT7b-0007bn-Hu; Thu, 10 Jun 2021 16:25:56 -0600
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>
References: <20210610220541.GA2779926@bjorn-Precision-5520>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <ad142e90-86f1-4749-898f-702ae2b7cf51@deltatee.com>
Date:   Thu, 10 Jun 2021 16:25:53 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610220541.GA2779926@bjorn-Precision-5520>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 24.64.144.200
X-SA-Exim-Rcpt-To: ddutile@redhat.com, jhubbard@nvidia.com, christian.koenig@amd.com, jgg@ziepe.ca, dan.j.williams@intel.com, hch@lst.de, sbates@raithlin.com, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, helgaas@kernel.org
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH v1 1/6] PCI/P2PDMA: Rename upstream_bridge_distance() and
 rework documentation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org




On 2021-06-10 4:05 p.m., Bjorn Helgaas wrote:
> The new text is:
> 
>   If there are two virtual functions of the same device behind the same
>   bridge port then PCI_P2PDMA_MAP_BUS_ADDR and a distance of 2 will be
>   returned (one step down to the PCIe switch, then one step back to the
>   same device).
> 
> I *think* this includes two functions of the same multi-function
> device, or two virtual functions of the same device, right?  In both
> cases, the two devices are obviously behind the same bridge port.

Yes, that's correct, if it's the same device it must be behind the same
bridge port; so dropping the "behind the same bridge port" is a good idea.

> 
> Is this usage of "down to the PCIe switch" the common usage in P2PDMA?
> I normally think of going from an endpoint to a switch as being "up"
> toward the CPU.  But PCIe made it all confusing by putting downstream
> ports at the upstream end of links and vice versa.

Good point. I've been casually saying "down to", but you are right "up"
makes a lot more sense given the downstream/upstream terminology.

> We also have a bit of a mix in terminology between "bridge," "switch,"
> "bridge port."  I'd probably write something like:
> 
>   If they are two functions of the same device behind the same bridge,
>   return PCI_P2PDMA_MAP_BUS_ADDR and a distance of 2 (one hop up to
>   the bridge, then one hop back down to another function of the same
>   device).
> 
> No need to repost for this; just let me know what you think and I can
> tweak accordingly.

What you've written sounds good to me, but I might have just dropped the
"behind the same bridge" entirely given your feedback above.

Thanks!

Logan
