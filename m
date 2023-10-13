Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54C227C8B15
	for <lists+linux-pci@lfdr.de>; Fri, 13 Oct 2023 18:35:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjJMQbx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Oct 2023 12:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232312AbjJMQbh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Oct 2023 12:31:37 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE588126;
        Fri, 13 Oct 2023 09:30:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 109A7C433C8;
        Fri, 13 Oct 2023 16:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697214627;
        bh=vh4TnsBJPXKkBZ4qGrkc49O31rDOcZhRMhVj+HGI4BY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=gviA7DdGJ83WDBASoN7ICKgep7rh2loHKxb5ZbwFtgn7zllg0pzEIh6pMoj1tyMr3
         4UUeA1TeUgH4Af1srPOkIn6Gnnxy8hxGKJE7T8wQ4XtvxgWp42Lc+dFdrSeFP71b2/
         CUCF3yQJSy6yXXzelSQcbbM4sLtJrLiZWin8Hfjg7mngS8XRN4vXy8CxagAG27gAHH
         0MDMHdtHU8YCb6qpeeLvrs/6OQkr8dt4a4Xkucdzh1wZiPqFEb/t2gIC+1OOYTvrlT
         N/ZrRnhtMCsXpDS+KBAr4VSBqlt1QOchk8svklSkIJmUoiTwR3TKGJT0SQZLSp95u4
         WUtS6hzwCy+4Q==
Date:   Fri, 13 Oct 2023 11:30:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
Subject: Re: [PATCH v7 3/4] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20231013163025.GA1116248@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2265967-5088-7f17-35e5-29bf1c85c15f@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Oct 13, 2023 at 11:46:44AM +0800, Shuai Xue wrote:
> 
> 
> On 2023/10/13 00:25, Bjorn Helgaas wrote:
> > On Thu, Oct 12, 2023 at 11:28:55AM +0800, Shuai Xue wrote:
> >> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
> >> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
> >> Core controller IP which provides statistics feature. The PMU is not a PCIe
> >> Root Complex integrated End Point(RCiEP) device but only register counters
> >> provided by each PCIe Root Port.

IIUC, the PMU is directly integrated into the Root Port: it's
discovered and operated via the Root Port config space.  If so, I
wouldn't bother mentioning RCiEP because there's no need to list all
the things it's *not*.

> >> To facilitate collection of statistics the controller provides the
> >> following two features for each Root Port:
> >>
> >> - Time Based Analysis (RX/TX data throughput and time spent in each
> >>   low-power LTSSM state)
> >> - Event counters (Error and Non-Error for lanes)
> >>
> >> Note, only one counter for each type and does not overflow interrupt.
> > 
> > Not sure what "does not overflow interrupt" means.  Does it mean
> > there's no interrupt generated when the counter overflows?
> 
> Yes, exactly. The rootport does NOT generate interrupt when the
> couter overflows.  I think the assumption hidden in this design is
> 64-bit counter will not overflow within observable time.
> 
> PCIe 5.0 slots can now reach anywhere between ~4GB/sec for a x1 slot
> up to ~64GB/sec for a x16 slot. The unit of counter is 16 byte.
> 
> 	2^64/(64/16*10^9)/60/60/24/365=146 years
> 
> so, the counter will not overflow within 146 years.

Certainly a reasonable assumption :)

But I'm confused about how many counters there are.  Clearly there are
two features ((1) time-based analysis and (2) event counters).

"One counter for each type" suggests there's one counter for
time-based analysis and a second counter for event counting, but from
dwc_pcie_pmu_event_add(), it looks like each Root Port might have a
single counter, and you can decide whether that counter is used for
time-based analysis or event counting, but you can't do both at the
same time?  And the event counting is for a single lane, not for the
link as a whole?

If so, I might word this as:

  Each Root Port contains one counter that can be used for either:

    - Time-Based Analysis (RX/TX data throughput and time spent in
      each low-power LTSSM state) or

    - Event counting (error and non-error events for a specified lane)

  There is no interrupt for counter overflow.

> >> +	  Enable perf support for Synopsys DesignWare PCIe PMU Performance
> >> +	  monitoring event on platform including the Yitian 710.
> > 
> > Should this mention Alibaba or T-Head?  I don't know how
> > Alibaba/T-Head/Yitian are all related.
> 
> The server chips, named Yitian 710, are custom-built by Alibaba Group's chip
> development business, T-Head.
> 
> 	  Enable perf support for Synopsys DesignWare PCIe PMU Performance
> 	  monitoring event on platform including the Alibaba Yitian 710.
> 
> Is this okay?

Perfect :)

Bjorn
