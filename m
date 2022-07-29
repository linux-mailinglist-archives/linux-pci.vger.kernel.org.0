Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E75584DC9
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jul 2022 11:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235534AbiG2JFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jul 2022 05:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbiG2JFm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jul 2022 05:05:42 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D2D177A65;
        Fri, 29 Jul 2022 02:05:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6A75ECE2586;
        Fri, 29 Jul 2022 09:05:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2401C433C1;
        Fri, 29 Jul 2022 09:05:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659085537;
        bh=wvE5EHGmPigV4oD45oTwiHHUQ4e3yEtd8+Rek83/iZI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u4XFhk2DKQ9ZhFdCgE/O1FOABLAVZrwk5XV7UmcIVw0wNVMKeJ8oCvvhbPIuruugH
         lVJ16TpQyhX33sT2ppx+Igx96tQu+Ozi3VhO8Fp70k/RFxgMPRPKZr5MSGiWsvJ9GD
         Wn1kY+HYPAecHr7gurrqG2aWeXQUfEWMgIiVr7Ps=
Date:   Fri, 29 Jul 2022 11:05:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     yangyicong@hisilicon.com, alexander.shishkin@linux.intel.com,
        leo.yan@linaro.org, james.clark@arm.com, will@kernel.org,
        robin.murphy@arm.com, acme@kernel.org, peterz@infradead.org,
        corbet@lwn.net, mathieu.poirier@linaro.org, mark.rutland@arm.com,
        jonathan.cameron@huawei.com, john.garry@huawei.com,
        helgaas@kernel.org, lorenzo.pieralisi@arm.com,
        suzuki.poulose@arm.com, joro@8bytes.org,
        shameerali.kolothum.thodi@huawei.com, mingo@redhat.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-perf-users@vger.kernel.org,
        iommu@lists.linux-foundation.org, iommu@lists.linux.dev,
        linux-doc@vger.kernel.org, prime.zeng@huawei.com,
        liuqi115@huawei.com, zhangshaokun@hisilicon.com,
        linuxarm@huawei.com, bagasdotme@gmail.com
Subject: Re: [PATCH v11 2/8] hwtracing: hisi_ptt: Add trace function support
 for HiSilicon PCIe Tune and Trace device
Message-ID: <YuOi3i0XHV++z1YI@kroah.com>
References: <20220721130116.43366-1-yangyicong@huawei.com>
 <20220721130116.43366-3-yangyicong@huawei.com>
 <YuKZKGKMz+UcbETM@kroah.com>
 <33f372f6-36bf-f84e-bca0-86347fa4d579@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <33f372f6-36bf-f84e-bca0-86347fa4d579@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 29, 2022 at 03:29:14PM +0800, Yicong Yang wrote:
> >> +	/*
> >> +	 * Handle the interrupt on the same cpu which starts the trace to avoid
> >> +	 * context mismatch. Otherwise we'll trigger the WARN from the perf
> >> +	 * core in event_function_local().
> >> +	 */
> >> +	WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
> >> +				 cpumask_of(cpu)));
> > 
> > If this hits, you just crashed the machine :(
> > 
> 
> We'll likely to have a calltrace here without crash the machine and reboot in
> most time, unless user has set panic_on_warn.

Again, please do not use WARN_ON for this, please read:
	https://elixir.bootlin.com/linux/v5.19-rc8/source/include/asm-generic/bug.h#L74

If you want a traceback (what would you do with that?), then call the
function to give you that.  Don't crash people's boxes.

> > Please properly recover from errors if you hit them, like this.  Don't
> > just give up and throw a message to userspace and watch the machine
> > reboot with all data lost.
> > 
> > Same for the other WARN_ON() instances here.  Handle the error and
> > report it properly up the call chain.
> > 
> 
> The driver use WARN_ON() in two places, once in pmu::start() and another in cpu teardown's
> callback, both when the irq_set_affinity() failed. This is common to behave so when driver
> fails to set irq affinity in pmu::start() and cpu_teardown():

Don't repeat broken patterns please.

> yangyicong@ubuntu:~/mainline_linux/linux/drivers$ grep -rn WARN_ON ./ | grep irq_set_affinity
> ./perf/arm_smmuv3_pmu.c:649:    WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(target)));
> ./perf/arm_smmuv3_pmu.c:895:    WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
> ./perf/arm-ccn.c:1214:          WARN_ON(irq_set_affinity(ccn->irq, cpumask_of(dt->cpu)));
> ./perf/qcom_l2_pmu.c:796:       WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(cpu)));
> ./perf/qcom_l2_pmu.c:834:       WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(target)));
> ./perf/arm_dmc620_pmu.c:624:    WARN_ON(irq_set_affinity(irq->irq_num, cpumask_of(target)));
> ./perf/fsl_imx8_ddr_perf.c:674: WARN_ON(irq_set_affinity(pmu->irq, cpumask_of(pmu->cpu)));
> ./perf/xgene_pmu.c:1793:        WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
> ./perf/xgene_pmu.c:1826:        WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
> ./perf/hisilicon/hisi_pcie_pmu.c:658:           WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(cpu)));
> ./perf/hisilicon/hisi_pcie_pmu.c:684:   WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(target)));
> ./perf/hisilicon/hisi_uncore_pmu.c:495: WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(cpu)));
> ./perf/hisilicon/hisi_uncore_pmu.c:528: WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(target)));

Great, you can fix all of these up as well any time :)

thanks,

greg k-h
