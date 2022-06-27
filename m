Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC1D755DB34
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236535AbiF0OCP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Jun 2022 10:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236355AbiF0OCO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Jun 2022 10:02:14 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DBE10578;
        Mon, 27 Jun 2022 07:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BpEvF0BzklG8G9XjSPP96oVb/MAS3WNPpABfNhe5u5s=; b=ZV1HzTDRRvvaBT0EJFa4US4l4F
        GHea9PgpyHfJqxTevWsYuYnrsgtVy9qh9+rPGLXlDi5Dei3SciLj7YfCl/o2/O0HsBqJyMkC8xkpl
        Xh88cl/xkod+OM8+U/Is97UoRJr0ObUiAcWofUjeB19Rlil3RdV67Z1VcUj+rBVZERJSYgoYMr/J5
        C2eaahpLR+mgEQZZ+g3OvEQsT6JBsMs7TxjWMNjL3aklnutRHkh5j/FOUPM6Az+bLYno2OoY+j769
        mHTtQqN4tzH8GcVbCiF20H4rKSiqdZGeH04LYb9DpDLA3iVBjz098WeniRwPEEBbD7+dR9dHW5XzL
        l8+9JBmg==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o5pJ1-00BPhR-AX; Mon, 27 Jun 2022 14:01:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id DC4D230040C;
        Mon, 27 Jun 2022 16:01:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id BE20C29BEB0F7; Mon, 27 Jun 2022 16:01:31 +0200 (CEST)
Date:   Mon, 27 Jun 2022 16:01:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, yangyicong@hisilicon.com,
        helgaas@kernel.org, lorenzo.pieralisi@arm.com,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        jonathan.cameron@huawei.com, robin.murphy@arm.com,
        leo.yan@linaro.org, mark.rutland@arm.com, will@kernel.org,
        joro@8bytes.org, shameerali.kolothum.thodi@huawei.com,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iommu@lists.linux-foundation.org, prime.zeng@huawei.com,
        liuqi115@huawei.com, james.clark@arm.com,
        zhangshaokun@hisilicon.com, linuxarm@huawei.com,
        alexander.shishkin@linux.intel.com, acme@kernel.org
Subject: Re: [PATCH v9 0/8] Add support for HiSilicon PCIe Tune and Trace
 device
Message-ID: <Yrm4O+AFbgnoBVba@hirez.programming.kicks-ass.net>
References: <20220606115555.41103-1-yangyicong@hisilicon.com>
 <af6723f1-c0c5-8af5-857c-af9280e705af@huawei.com>
 <Yrms2cI05O2yZRKU@kroah.com>
 <e737393a-56dd-7d24-33d3-e935b14ba758@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e737393a-56dd-7d24-33d3-e935b14ba758@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 27, 2022 at 09:25:42PM +0800, Yicong Yang wrote:
> On 2022/6/27 21:12, Greg KH wrote:
> > On Mon, Jun 27, 2022 at 07:18:12PM +0800, Yicong Yang wrote:
> >> Hi Greg,
> >>
> >> Since the kernel side of this device has been reviewed for 8 versions with
> >> all comments addressed and no more comment since v9 posted in 5.19-rc1,
> >> is it ok to merge it first (for Patch 1-3 and 7-8)?
> > 
> > I am not the maintainer of this subsystem, so I do not understand why
> > you are asking me :(
> > 
> 
> I checked the log of drivers/hwtracing and seems patches of coresight/intel_th/stm
> applied by different maintainers and I see you applied some patches of intel_th/stm.
> Should any of these three maintainers or you can help applied this?

I was hoping Mark would have a look, since he knows this ARM stuff
better than me. But ISTR he's somewhat busy atm too. But an ACK from the
CoreSight people would also be appreciated.

And Arnaldo usually doesn't pick up the userspace perf bits until the
kernel side is sorted.
