Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 829037DC04F
	for <lists+linux-pci@lfdr.de>; Mon, 30 Oct 2023 20:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjJ3TWh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Mon, 30 Oct 2023 15:22:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbjJ3TWh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Oct 2023 15:22:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C54DA9;
        Mon, 30 Oct 2023 12:22:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SK3421l21z6K64q;
        Tue, 31 Oct 2023 03:19:30 +0800 (CST)
Received: from localhost (10.48.147.130) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 30 Oct
 2023 19:22:30 +0000
Date:   Mon, 30 Oct 2023 19:22:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Yicong Yang <yangyicong@huawei.com>,
        <chengyou@linux.alibaba.com>, <kaishen@linux.alibaba.com>,
        <baolin.wang@linux.alibaba.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <rdunlap@infradead.org>,
        <mark.rutland@arm.com>, <zhuo.song@linux.alibaba.com>,
        <renyu.zj@linux.alibaba.com>
Subject: Re: [PATCH v9 3/4] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20231030192227.000039dc@Huawei.com>
In-Reply-To: <3b2f8b0f-ca94-400f-ae13-ac1de84591b1@linux.alibaba.com>
References: <20231020134230.53342-1-xueshuai@linux.alibaba.com>
        <20231020134230.53342-4-xueshuai@linux.alibaba.com>
        <20231023123202.GA3515@willie-the-truck>
        <cf72afb6-44c7-45f0-bfaa-6881f6782ebf@arm.com>
        <5b695595-d243-4ea5-97bb-f4c74398fc27@linux.alibaba.com>
        <20231026144428.00005db8@Huawei.com>
        <8f8a2e42-f6ed-4328-9457-5f986d761224@arm.com>
        <3b2f8b0f-ca94-400f-ae13-ac1de84591b1@linux.alibaba.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.48.147.130]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 27 Oct 2023 20:25:16 +0800
Shuai Xue <xueshuai@linux.alibaba.com> wrote:

> On 2023/10/27 00:52, Robin Murphy wrote:
> > On 26/10/2023 2:44 pm, Jonathan Cameron wrote:  
> >> On Tue, 24 Oct 2023 17:29:34 +0800
> >> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> >>  
> >>> + Will, Jonathan, Bjorn and Yicong for probe and hotplug handing.
> >>>  
> ...
> >>>>>> +
> >>>>>> +    dwc_pcie_pmu_hp_state = ret;
> >>>>>> +
> >>>>>> +    ret = platform_driver_register(&dwc_pcie_pmu_driver);
> >>>>>> +    if (ret)
> >>>>>> +        goto platform_driver_register_err;
> >>>>>> +
> >>>>>> +    dwc_pcie_pmu_dev = platform_device_register_simple(
> >>>>>> +                "dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
> >>>>>> +    if (IS_ERR(dwc_pcie_pmu_dev)) {
> >>>>>> +        ret = PTR_ERR(dwc_pcie_pmu_dev);
> >>>>>> +        goto platform_device_register_error;
> >>>>>> +    }  
> >>>>>
> >>>>> I'm a bit confused as to why you're having to create a platform device
> >>>>> for a PCI device -- is this because the main designware driver has already
> >>>>> bound to it? A comment here explaining why you need to do this would be
> >>>>> very helpful. In particular, is there any dependency on another driver
> >>>>> to make sure that e.g. config space accesses work properly? If so, we
> >>>>> probably need to enforce module load ordering or something like that.  
> >>>>
> >>>> AFAICS the platform device/driver serve no purpose other than being a hilariously roundabout way to run the for_each_pci_dev() loop in dwc_pcie_pmu_probe() upon module init, and to save explicitly freeing the PMU name/data. Furthermore the devres action for dwc_pcie_pmu_remove_cpuhp_instance() is apparently going for even more style points at module exit by not even relying on the corresponding .remove callback of the tenuous platform driver to undo what its .probe did, but (ab)using the device's devres list to avoid having to keep track of an explicit list of PMU instances at all.  
> >>>
> >>> You are right.  
> >>
> >> Also provides a (potential) parent for the PMU devices which is something
> >> we were trying to clean up for existing PMUs (which end up in the
> >> wrong directly in sysfs because they typically don't have parents).  
> > 
> > Surely the relevant PCI device would be an even more appropriate parent, though, since that's the true topology?
> >   
> 
> I see, I will add its parent.

Agreed - I hadn't it in my head that we didn't have a good mapping to a particular
PCIe device (based on some similarish hardware where the counters are shared across
multiple RPs) Here I guess it's fine to use the PCI device.

Jonathan

> 
> Thank you.
> Best Regards,
> Shuai
> 

