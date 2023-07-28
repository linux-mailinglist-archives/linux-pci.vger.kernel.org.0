Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13C7A76705F
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jul 2023 17:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236029AbjG1PUh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 28 Jul 2023 11:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233675AbjG1PUg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 28 Jul 2023 11:20:36 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6338130FC;
        Fri, 28 Jul 2023 08:20:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RCB7c40Wcz6839B;
        Fri, 28 Jul 2023 23:17:00 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 28 Jul
 2023 16:20:31 +0100
Date:   Fri, 28 Jul 2023 16:20:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     Yicong Yang <yangyicong@huawei.com>, <chengyou@linux.alibaba.com>,
        <kaishen@linux.alibaba.com>, <helgaas@kernel.org>,
        <will@kernel.org>, <baolin.wang@linux.alibaba.com>,
        <robin.murphy@arm.com>, <yangyicong@hisilicon.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <rdunlap@infradead.org>,
        <mark.rutland@arm.com>, <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v6 3/4] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20230728162030.00005e60@Huawei.com>
In-Reply-To: <12958abe-4bdb-8532-bf67-8e772ed2a9dd@linux.alibaba.com>
References: <20230606074938.97724-1-xueshuai@linux.alibaba.com>
        <20230606074938.97724-4-xueshuai@linux.alibaba.com>
        <31e2b012-3a29-d063-842d-e3f7736816e7@huawei.com>
        <20230727103929.00000544@Huawei.com>
        <12958abe-4bdb-8532-bf67-8e772ed2a9dd@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

...


> >>> +
> >>> +static int dwc_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
> >>> +{
> >>> +	struct dwc_pcie_pmu *pcie_pmu;
> >>> +	struct pci_dev *pdev;
> >>> +	int node;
> >>> +
> >>> +	pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
> >>> +	pdev = pcie_pmu->pdev;
> >>> +	node = dev_to_node(&pdev->dev);
> >>> +
> >>> +	if (node != NUMA_NO_NODE && cpu_to_node(pcie_pmu->oncpu) != node &&  
> > 
> > Perhaps worth a comment on when you might see node == NUMA_NO_NODE?
> > Beyond NUMA being entirely disabled, I'd hope that never happens and for that you
> > might be able to use a compile time check.
> > 
> > I wonder if this can be simplified by a flag that says if we are already in the
> > right node? Might be easier to follow than having similar dance in online and offline
> > to figure that out.  
> 
> Ok, I will add a comment for NUMA_NO_NODE. If no numa support, I think
> any CPU is fine to bind.

Agreed. I would add a comment on that being the intent.

> 
> pcie_pmu->on_cpu may be a good choise to be used as a flag, right? pcie_pmu->on_cpu
> will be set as -1 when pcie_pmu is allocated and then check in
> dwc_pcie_pmu_online_cpu() first.

I think you still want to know whether it's in the right node - as maybe
there are no local CPUs available at startup.

> 
> Then, the code will be:
> 
> static int dwc_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
> {
> 	struct dwc_pcie_pmu *pcie_pmu;
> 	struct pci_dev *pdev;
> 	int node;
> 
> 	pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
> 	/* If another CPU is already managing this PMU, simply return. */
> 	if (pcie_pmu->on_cpu != -1)
> 		return 0;
> 
> 	pdev = pcie_pmu->pdev;
> 	node = dev_to_node(&pdev->dev);
> 
> 	/* Select the first CPU if no numa support. */
> 	if (node == NUMA_NO_NODE)
> 		pcie_pmu->on_cpu = cpu;
> 	else if (cpu_to_node(pcie_pmu->on_cpu) != node &&
> 		 cpu_to_node(cpu) == node)
> 		dwc_pcie_pmu_migrate(pcie_pmu, cpu);
> 
> 	return 0;
> }
> > 
> >>> +static int __init dwc_pcie_pmu_init(void)
> >>> +{
> >>> +	int ret;
> >>> +
> >>> +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
> >>> +				      "perf/dwc_pcie_pmu:online",
> >>> +				      dwc_pcie_pmu_online_cpu,
> >>> +				      dwc_pcie_pmu_offline_cpu);
> >>> +	if (ret < 0)
> >>> +		return ret;
> >>> +
> >>> +	dwc_pcie_pmu_hp_state = ret;
> >>> +
> >>> +	ret = platform_driver_register(&dwc_pcie_pmu_driver);
> >>> +	if (ret) {
> >>> +		cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
> >>> +		return ret;
> >>> +	}
> >>> +
> >>> +	dwc_pcie_pmu_dev = platform_device_register_simple(
> >>> +				"dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
> >>> +	if (IS_ERR(dwc_pcie_pmu_dev)) {
> >>> +		platform_driver_unregister(&dwc_pcie_pmu_driver);    
> >>
> >> On failure we also need to remove cpuhp state as well.  
> > 
> > I'd suggest using gotos and a single error handling block. That
> > makes it both harder to forget things like this and easier to
> > compare that block with what happens in exit() - so slightly 
> > easier to review!  
> 
> Given that we have a appropriate way to tear down the PMUs via devm_add_action_or_reset(),
> I am going to remove the redundant probe/remove framework via platform_driver_{un}register().
> for_each probe process in __dwc_pcie_pmu_probe() will be move into dwc_pcie_pmu_init().
> Is it a better way?

I think I'd prefer to see a standard driver creation / probe flow even if you could in theory
avoid it.

Jonathan

> 
> Thank you very much for your valuable comments.
> 
> Best Regards,
> Shuai
> 
> 

