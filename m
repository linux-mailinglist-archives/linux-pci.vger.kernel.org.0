Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2365E7F06
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 17:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbiIWPyg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 11:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiIWPyf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 11:54:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FA0E1449F3;
        Fri, 23 Sep 2022 08:54:27 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MYxWd70s8z67Q1L;
        Fri, 23 Sep 2022 23:53:17 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 23 Sep 2022 17:54:25 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Fri, 23 Sep
 2022 16:54:24 +0100
Date:   Fri, 23 Sep 2022 16:54:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
CC:     <will@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <rdunlap@infradead.org>,
        <robin.murphy@arm.com>, <mark.rutland@arm.com>,
        <baolin.wang@linux.alibaba.com>, <zhuo.song@linux.alibaba.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCH v1 2/3] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <20220923165423.00007dc6@huawei.com>
In-Reply-To: <d4edc6f4-e56f-4a19-3c34-b65d4903bfc0@linux.alibaba.com>
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
        <20220917121036.14864-3-xueshuai@linux.alibaba.com>
        <20220922165820.000017b6@huawei.com>
        <d4edc6f4-e56f-4a19-3c34-b65d4903bfc0@linux.alibaba.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


> 
> >   
> >> +#define RP_NUM_MAX				32 /* 2die * 4RC * 4Ctrol */  
> > 
> > This driver is 'almost' generic. So if you an avoid defines based on a particular
> > platform that's definitely good!  
> 
> Good idea. How about defining RP_NUM_MAX as 64? As fars as I know,
> some platfrom use 2 sockets, 2 die per socket.
> Then 2 sockets * 2 dies * 4 Root Complex * 4 root port.

Setting a reasonable maximum is fine - but make sure the code then fails with
a suitable error message if there are more!


> >> +#define DWC_PCIE_LANE_SHIFT			4
> >> +#define DWC_PCIE_LANE_MASK			GENMASK(9, 4)
> >> +
> >> +#define DWC_PCIE_EVENT_CNT_CTRL			0x8
> >> +#define DWC_PCIE__CNT_EVENT_SELECT_SHIFT	16  
> > 
> > Why double __?  If point is , then
> > naming works better
> > DWC_PCIE_EVENT_CNT_CTRL_REG
> > DWC_PCIE_EVENT_CNT_CTRL_EV_SELECT_MSK etc  
> 
> Yes, I point to use double `__` to indicate it is a field of register,
> as CMN and CCN drivers do. I also considered naming with REG explicitly,
> but the macro is so long that I often have to wrap code into multilines.
> Any way, it's fine to rename if you still suggest to do so.

I don't particularly mind.  This convention was new to me.


> >> +struct dwc_pcie_pmu_priv {
> >> +	struct device *dev;
> >> +	u32 pcie_ctrl_num;
> >> +	struct dwc_pcie_info_table *pcie_table;
> >> +};
> >> +
> >> +#define DWC_PCIE_CREATE_BDF(seg, bus, dev, func)	\
> >> +	(((seg) << 24) | (((bus) & 0xFF) << 16) | (((dev) & 0xFF) << 8) | (func))  
> > 
> > Superficially this looks pretty standard.  Why is is DWC specific?  
> 
> You are right, it is not DWC specific.
> 
> I found a similar definition in arch/ia64/pci/pci.c .
> 
> 	#define PCI_SAL_ADDRESS(seg, bus, devfn, reg)		\
> 	(((u64) seg << 24) | (bus << 16) | (devfn << 8) | (reg))
> 
> Should we move it into a common header first?

Maybe. The bus, devfn, reg part is standard bdf, but I don't think
the PCI 6.0 spec defined a version with the seg in the upper bits.
I'm not sure if we want to adopt that in LInux.

> >   
> >> +		pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &header);
> >> +		/* Is the device part of a DesignWare Cores PCIe Controller ? */  
> > 
> > Good question... This code doesn't check that.  VSEC ID is matched only with
> > the Vendor ID of the devices - unlike DVSEC where this would all be nice
> > and local.  
> 
> I think a similar fashion is
> 
> 	u16 pci_find_vsec_capability(struct pci_dev *dev, u16 vendor, int cap)
> 
> As you see, I don't want to limit this driver to a specific vendor, like
> Alibaba (0x1ded), because this driver is generic to all DesignWare Cores PCIe
> Controller. Therefore, dwc_pcie_find_ras_des_cap_position does not check vendor
> like pci_find_vsec_capability.

You can't do that because another vendor could use the same VSEC ID for
an entirely different purpose. They are only valid in combination with the device VID.

The only way this can work is with a list of specific vendor ID / VSEC pairs for
known devices.

> 
> Do you mean to use DVSEC instead? I try to read out DVSEC with lspci:
> 
>     # lspci -vvv
>     b0:00.0 PCI bridge: Alibaba (China) Co., Ltd. M1 Root Port (rev 01) (prog-if 00 [Normal decode])
>     [...snip...]
>         Capabilities: [374 v1] Vendor Specific Information: ID=0002 Rev=4 Len=100 <?>
>         Capabilities: [474 v1] Vendor Specific Information: ID=0001 Rev=1 Len=038 <?>
>         Capabilities: [4ac v1] Data Link Feature <?>
>         Capabilities: [4b8 v1] Designated Vendor-Specific: Vendor=0001 ID=0000 Rev=1 Len=64 <?>
>         Capabilities: [4fc v1] Vendor Specific Information: ID=0005 Rev=1 Len=018 <?>
> 
> How can we tell it's a DesignWare Cores PCIe Controller?

Gah. This is what DVSEC was defined to solve. It lets you have a common
vendor defined extended capability defined by a vendor, independent of the
VID of a given device.  With a VSEC you can't write generic code.

> 
> 
> >> +		if (PCI_VNDR_HEADER_ID(header) == DWC_PCIE_VSEC_ID &&
> >> +		    PCI_VNDR_HEADER_REV(header) == DWC_PCIE_VSEC_REV) {
> >> +			*pos = vsec;
> >> +			return 0;
> >> +		}
> >> +	}
> >> +
> >> +	return -ENODEV;
> >> +}
> >> +
> >> +static int dwc_pcie_pmu_discover(struct dwc_pcie_pmu_priv *priv)
> >> +{
> >> +	int val, where, index = 0;
> >> +	struct pci_dev *pdev = NULL;
> >> +	struct dwc_pcie_info_table *pcie_info;
> >> +
> >> +	priv->pcie_table =
> >> +	    devm_kcalloc(priv->dev, RP_NUM_MAX, sizeof(*pcie_info), GFP_KERNEL);
> >> +	if (!priv->pcie_table)
> >> +		return -EINVAL;
> >> +
> >> +	pcie_info = priv->pcie_table;
> >> +	while ((pdev = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL &&
> >> +	       index < RP_NUM_MAX) {  
> > 
> > This having a driver than then walks the pci topology to find root ports and add
> > extra stuff to them is not a clean solution.
> > 
> > The probing should be driven from the existing PCI driver topology.
> > There are a bunch of new features we need to add to ports in the near future
> > anyway - this would just be another one.
> > Same problem exists for CXL CPMU perf devices - so far we only support those
> > on end points, partly because we need a clean way to probe them on pci ports.
> > 
> > Whatever we come up with there will apply here as well.  
> 
> I see your point. Any link to reference?

No, though hopefully we'll get to some sort of plan in the branch of this thread
that Bjorn comment in.

> 
> >   
> >> +		if (!pci_dev_is_rootport(pdev))
> >> +			continue;
> >> +
> >> +		pcie_info[index].bdf = dwc_pcie_get_bdf(pdev);
> >> +		pcie_info[index].pdev = pdev;  
> > Probably want a sanity check this has a vendor ID appropriate the VSEC you are about
> > to look for.  
> 
> If I check the vendor ID here or in dwc_pcie_find_ras_des_cap_position, this driver
> will only work for Alibaba as I mentioned before.

Agreed. Unfortunately that's all you can do safely as VSEC IDs are not a global
namespace.



> 
> >> +
> >> +	ret = dwc_pcie_pmu_write_dword(pcie_info, DWC_PCIE_EVENT_CNT_CTRL, val);
> >> +	if (ret)
> >> +		pci_err(pcie_info->pdev, "PCIe write fail\n");
> >> +
> >> +	return ret;
> >> +}  
> > 
> > ...
> >   
> >> +
> >> +static int dwc_pcie_pmu_read_base_time_counter(struct dwc_pcie_info_table
> >> +					       *pcie_info, u64 *counter)
> >> +{
> >> +	u32 ret, val;
> >> +
> >> +	ret = dwc_pcie_pmu_read_dword(pcie_info,
> >> +				      DWC_PCIE_TIME_BASED_ANALYSIS_DATA_REG_HIGH,
> >> +				      &val);
> >> +	if (ret) {
> >> +		pci_err(pcie_info->pdev, "PCIe read fail\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	*counter = val;
> >> +	*counter <<= 32;  
> > 
> > This looks like you could get ripping between the upper and lower dwords.
> > What prevents that? Perhaps a comment to say why that's not a problem?  
> 
> The Time-based Analysis Data which contains the measurement results of
> RX/TX data throughput and time spent in each low-power LTSSM state is 64 bit.
> The data is provided by two 32 bit registers so I rip them together. I will
> add a comment here in next verison.

If I understand correctly the only safe way to read this is in a try / retry loop.
Read the upper part, then the lower part, then reread the upper part.
If the upper part is unchanged you did not get ripping across the two registers.
If it changes, try again.

> 
> >   
> >> +
> >> +	ret = dwc_pcie_pmu_read_dword(pcie_info,
> >> +				      DWC_PCIE_TIME_BASED_ANALYSIS_DATA_REG_LOW,
> >> +				      &val);
> >> +	if (ret) {
> >> +		pci_err(pcie_info->pdev, "PCIe read fail\n");
> >> +		return ret;
> >> +	}
> >> +
> >> +	*counter += val;
> >> +
> >> +	return ret;
> >> +}  
> > ...
> > 
> >> +
> >> +	ret = perf_pmu_register(&pcie_pmu->pmu, name, -1);
> >> +	if (ret) {
> >> +		pci_err(pcie_info->pdev, "Error %d registering PMU @%x\n", ret,
> >> +				 pcie_info->bdf);
> >> +		return ret;
> >> +	}
> >> +
> >> +	pcie_info->pmu_is_register = DWC_PCIE_PMU_HAS_REGISTER;  
> > 
> > As below. I think you can drop this state info.  
> 
> Please see my confusion bellow.
> 
> >   
> >> +
> >> +	return ret;
> >> +}
> >> +
> >> +static int dwc_pcie_pmu_remove(struct platform_device *pdev)
> >> +{
> >> +	struct dwc_pcie_pmu_priv *priv = platform_get_drvdata(pdev);
> >> +	int index;
> >> +	struct dwc_pcie_pmu *pcie_pmu;
> >> +
> >> +	for (index = 0; index < priv->pcie_ctrl_num; index++)
> >> +		if (priv->pcie_table[index].pmu_is_register) {
> >> +			pcie_pmu = &priv->pcie_table[index].pcie_pmu;
> >> +			perf_pmu_unregister(&pcie_pmu->pmu);
> >> +		}
> >> +	return 0;
> >> +}
> >> +
> >> +static int dwc_pcie_pmu_probe(struct platform_device *pdev)
> >> +{
> >> +	int ret = 0;  
> > 
> > Initialized in all paths where it is used. Compiler should be able to tell
> > that so I doubt you need this to be set to 0 here.  
> 
> Agree, will leave it as uninitialized.
> 
> >   
> >> +	int pcie_index;
> >> +	struct dwc_pcie_pmu_priv *priv;
> >> +
> >> +	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> >> +	if (!priv)
> >> +		return -ENOMEM;
> >> +	priv->dev = &pdev->dev;
> >> +	platform_set_drvdata(pdev, priv);
> >> +
> >> +	/* If PMU is not support on current platform, keep slient */
> >> +	if (dwc_pcie_pmu_discover(priv))
> >> +		return 0;
> >> +
> >> +	for (pcie_index = 0; pcie_index < priv->pcie_ctrl_num; pcie_index++) {
> >> +		struct pci_dev *rp = priv->pcie_table[pcie_index].pdev;
> >> +
> >> +		ret = __dwc_pcie_pmu_probe(priv, &priv->pcie_table[pcie_index]);
> >> +		if (ret) {
> >> +			dev_err(&rp->dev, "PCIe PMU probe fail\n");
> >> +			goto pmu_unregister;
> >> +		}
> >> +	}
> >> +	dev_info(&pdev->dev, "PCIe PMUs registered\n");  
> > 
> > Noise in the logs.  There are lots of ways to know if we reached this point
> > so this adds no value.  
> 
> Got it, will drop this out in next version.
> 
> >   
> >> +
> >> +	return 0;
> >> +
> >> +pmu_unregister:
> >> +	dwc_pcie_pmu_remove(pdev);  
> > 
> > I'd much rather see the unwind here directly so we can clearly see that it undoes
> > the result of errors in this function.  That removes the need to use the
> > is_registered flag in the remove() function simplifying that flow as well.  
> 
> Do you mean that if perf_pmu_register fails, then jump to pmu_unregister lable directly?
> How can we tell which PMU diveice fails to reigister?

pcie_index will be set to the index of the PMU device that failed - so loops backwards
from that removing them.


> 
.
> 
> >   
> >> +};
> >> +
> >> +static int __init dwc_pcie_pmu_init(void)
> >> +{
> >> +	int ret;
> >> +
> >> +	ret = platform_driver_register(&dwc_pcie_pmu_driver);
> >> +
> >> +	if (ret)
> >> +		return ret;
> >> +
> >> +	dwc_pcie_pmu_dev =
> >> +	    platform_device_register_simple(DEV_NAME, -1, NULL, 0);  
> > 
> > I'd normally expect to see the device created as a result of firmware
> > description (ACPI DSDT / or Device tree)
> > It is unusual to create a 'real' device directly in the driver
> > init - that's normally reserved for various fake / software devices.  
> 
> I see your concerns. You mentioned that
> 
>    > The probing should be driven from the existing PCI driver topology.  
> 
> Should we add a fake device in firmware or drive from PCI driver topology?

Ah. I was reviewing backwards so when I wrote this hadn't realized you walk
the PCI topology.   PCI driver topology is the right solution here.

> 
> Thank you.
> 
> Best Regards,
> Shuai
> 

