Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD4576240C
	for <lists+linux-pci@lfdr.de>; Tue, 25 Jul 2023 23:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjGYVAB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Jul 2023 17:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbjGYVAA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Jul 2023 17:00:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C84F1BC3;
        Tue, 25 Jul 2023 13:59:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BEA2618E8;
        Tue, 25 Jul 2023 20:59:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37684C433C8;
        Tue, 25 Jul 2023 20:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690318797;
        bh=YU0pkJ3KyW8TbBxYB6lwKUSa3sLNGB7MlyMIuPOKFlM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ka/nj/+taMK5OcYk3J849CMQvxscIG9oBJz93rvlhlGJL9fTiWLvodAT4S5vZ0Gq8
         fNlntMfIJg6j6epRcJP6uSbc1psVZnI+4iW25l0NK257wDyNwAOGVaSyCY/YE5O3+C
         O7Zcx+vuy9LVfotYLeeg/Gb6gZIOrVqGBbwKlQZtFggqnJQC2W8Lo3msrV3nvUSn9H
         iX7VszdshA+Qs5rHJRxnhQ/EbPo/Q9g7Xe5w9BXFyvkCdPDq/VfmS+npVxZ8uX+9rB
         sTbPulJdkDcrM3tUEFnMSHal1d+8q/iHH5VUgD9/UjTt998orvbmtpZrdIxkg6uA8Q
         oo+Vt9OLXoQNA==
Date:   Tue, 25 Jul 2023 15:59:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Shuai Xue <xueshuai@linux.alibaba.com>, chengyou@linux.alibaba.com,
        kaishen@linux.alibaba.com, yangyicong@huawei.com, will@kernel.org,
        baolin.wang@linux.alibaba.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v6 0/4] drivers/perf: add Synopsys DesignWare PCIe PMU
 driver support
Message-ID: <20230725205955.GA665326@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724101807.000012bf@Huawei.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 24, 2023 at 10:18:07AM +0100, Jonathan Cameron wrote:
> On Mon, 24 Jul 2023 10:34:08 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> > On 2023/7/10 20:04, Shuai Xue wrote:
> > > On 2023/6/16 16:39, Shuai Xue wrote:  
> > >> On 2023/6/6 15:49, Shuai Xue wrote:  

> > >>> This patchset adds the PCIe Performance Monitoring Unit (PMU) driver support
> > >>> for T-Head Yitian 710 SoC chip. Yitian 710 is based on the Synopsys PCI Express
> > >>> Core controller IP which provides statistics feature.

> ...
> Really a question for Bjorn I think, but here is my 2 cents...
> 
> The problem here is that we need to do that fundamental redesign of the
> way the PCI ports drivers work.  I'm not sure there is a path to merging
> this until that is done.  The bigger problem is that I'm not sure anyone
> is actively looking at that yet.  I'd like to look at this (as I have
> the same problem for some other drivers), but it is behind various
> other things on my todo list.
> 
> Bjorn might be persuaded on a temporary solution, but that would come
> with some maintenance problems, particularly when we try to do it
> 'right' in the future.  Maybe adding another service driver would be
> a stop gap as long as we know we won't keep doing so for ever. Not sure.

I think the question here is around the for_each_pci_dev() in
__dwc_pcie_pmu_probe()?  I don't *like* that because of the
assumptions it breaks (autoload doesn't work, hotplug doesn't work),
but:

  - There are several other drivers that also do this,
  - I don't have a better suggest for any of them,
  - It's not a drivers/pci thing, so not really up to me anyway,

so I don't have any problem with this being merged as-is, as long as
you can live with the limitations.

I don't think this series does anything to work around those
limitations, i.e., it doesn't make up fake device IDs for module
loading or fake events for hotplug, so it seems like we could improve
the implementation later if we ever have a way to do it.

Bjorn
