Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76E867CABA6
	for <lists+linux-pci@lfdr.de>; Mon, 16 Oct 2023 16:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjJPOiK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Oct 2023 10:38:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPOiJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Oct 2023 10:38:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12BCFB9;
        Mon, 16 Oct 2023 07:38:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BCDEC433C7;
        Mon, 16 Oct 2023 14:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697467087;
        bh=I4NzxPNcEzkn00WTlYgKFrsJkje8b0dreIMdCi7RT94=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=DrEkikmhBQrIANHZg5CzSDNJQo082/3eXl1zS7Ed1phG6li8P/T0U2HVFv1djx8OL
         6h2cfCZfU5QRuldC1yqNvO2JrHmd302/znP/Q9Mcn3oZxbICAAzo9dwSid26cyx5Vy
         aJ1jOuBkbmBVbzOjzto2/yfigYQDMTX+8r03WYmPWL9PfjUUt0tHcLEHaX0s7Puepj
         pRV4+BlOhhFaz1jia/15rIa4aSiIAtw//vbWu3NLe3tiv3cMmwRiAtOV9u3bJ2T9mO
         d9h4Ih6E+5QTvQHvAemBmX0FxFvRfh6P6IrEDrALYOz524Jm/WjsKj8/Uotpxn9aQi
         JhazDIoLA+a6g==
Date:   Mon, 16 Oct 2023 09:38:05 -0500
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
Message-ID: <20231016143805.GA1207929@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4147832a-1f24-5993-dfb6-59f420a17481@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Oct 16, 2023 at 11:00:13AM +0800, Shuai Xue wrote:
> On 2023/10/14 00:30, Bjorn Helgaas wrote:
> > On Fri, Oct 13, 2023 at 11:46:44AM +0800, Shuai Xue wrote:
> >> On 2023/10/13 00:25, Bjorn Helgaas wrote:
> >>> On Thu, Oct 12, 2023 at 11:28:55AM +0800, Shuai Xue wrote:
> >>>> This commit adds the PCIe Performance Monitoring Unit (PMU)
> >>>> driver support for T-Head Yitian SoC chip. Yitian is based on
> >>>> the Synopsys PCI Express Core controller IP which provides
> >>>> statistics feature. The PMU is not a PCIe Root Complex
> >>>> integrated End Point(RCiEP) device but only register counters
> >>>> provided by each PCIe Root Port.

> @@ -447,10 +447,10 @@ static int dwc_pcie_pmu_event_add(struct perf_event *event, int flags)
>  	u32 ctrl;
> 
>  	/* Only one counter and it is in use */
> -	if (pcie_pmu->event)
> +	if (pcie_pmu->event[type])
>  		return -ENOSPC;
> 
> -	pcie_pmu->event = event;
> +	pcie_pmu->event[type] = event;

OK, makes good sense (probably update the comment also, e.g., "one
counter of each type").

>  }
> > If so, I might word this as:
> > 
> >   Each Root Port contains one counter that can be used for either:
> > 
> >     - Time-Based Analysis (RX/TX data throughput and time spent in
> >       each low-power LTSSM state) or
> > 
> >     - Event counting (error and non-error events for a specified lane)
> > 
> >   There is no interrupt for counter overflow.
> 
> Based on above, I change the word to:
> 
> 	To facilitate collection of statistics the controller provides the
> 	following two features for each Root Port:
> 
> 	- one 64-bit counter for Time Based Analysis (RX/TX data throughput and
> 	  time spent in each low-power LTSSM state) and
> 	- one 32-bit counter for Event counting (error and non-error events for
> 	  a specified lane)
> 
> 	Note: There is no interrupt for counter overflow.

Beautiful, that's very clear.

Bjorn
