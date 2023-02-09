Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB57690CB6
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 16:16:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230351AbjBIPQq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 10:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231296AbjBIPQj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 10:16:39 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E817D63126;
        Thu,  9 Feb 2023 07:16:10 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCL1P2JGpz6J7YD;
        Thu,  9 Feb 2023 23:11:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 15:16:04 +0000
Date:   Thu, 9 Feb 2023 15:16:03 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 12/18] cxl: Add helpers to calculate pci latency for the
 CXL device
Message-ID: <20230209151603.00005b53@Huawei.com>
In-Reply-To: <167571666898.587790.4824622451425607591.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571666898.587790.4824622451425607591.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

On Mon, 06 Feb 2023 13:51:10 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The latency is calculated by dividing the FLIT size over the bandwidth. Add
> support to retrieve the FLIT size for the CXL device and calculate the
> latency of the downstream link.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

I'd like to see some approx numbers in this patch description. What
sort of level is each component?  Hard to be sure the neglected parts
don't matter without that sort of back of the envelope numbers.

Jonathan

> ---
>  drivers/cxl/core/pci.c |   67 ++++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlpci.h   |   14 ++++++++++
>  2 files changed, 81 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index a24dac36bedd..54ac6f8825ff 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -633,3 +633,70 @@ void read_cdat_data(struct cxl_port *port)
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
> +
> +static int pcie_speed_to_mbps(enum pci_bus_speed speed)
> +{
> +	switch (speed) {
> +	case PCIE_SPEED_2_5GT:
> +		return 2500;
> +	case PCIE_SPEED_5_0GT:
> +		return 5000;
> +	case PCIE_SPEED_8_0GT:
> +		return 8000;
> +	case PCIE_SPEED_16_0GT:
> +		return 16000;
> +	case PCIE_SPEED_32_0GT:
> +		return 32000;
> +	case PCIE_SPEED_64_0GT:
> +		return 64000;
> +	default:
> +		break;
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int cxl_pci_mbits_to_mbytes(struct pci_dev *pdev)
> +{
> +	int mbits;
> +
> +	mbits = pcie_speed_to_mbps(pcie_get_speed(pdev));
> +	if (mbits < 0)
> +		return mbits;
> +
> +	return mbits >> 3;
> +}
> +
> +static int cxl_get_flit_size(struct pci_dev *pdev)
> +{
> +	if (cxl_pci_flit_256(pdev))
> +		return 256;
> +
> +	return 66;
> +}
> +
> +/**
> + * cxl_pci_get_latency - calculate the link latency for the PCIe link
> + * @pdev - PCI device
> + *
> + * CXL Memory Device SW Guide v1.0 2.11.4 Link latency calculation
> + * Link latency = LinkPropagationLatency + FlitLatency + RetimerLatency
> + * LinkProgationLatency is negligible, so 0 will be used
> + * RetimerLatency is assumed to be neglibible and 0 will be used
> + * FlitLatency = FlitSize / LinkBandwidth
> + * FlitSize is defined by spec. CXL v3.0 4.2.1.
> + * 68B flit is used up to 32GT/s. >32GT/s, 256B flit size is used.
> + * The FlitLatency is converted to pico-seconds.
> + */
> +long cxl_pci_get_latency(struct pci_dev *pdev)
> +{
> +	long bw, flit_size;
> +
> +	bw = cxl_pci_mbits_to_mbytes(pdev);
> +	if (bw < 0)
> +		return bw;
> +
> +	flit_size = cxl_get_flit_size(pdev);

So, if latency optimized, it's 128 bytes (approx)

> +	return flit_size * 1000000L / bw;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_pci_get_latency, CXL);
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 920909791bb9..d64a3e0458ab 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -62,8 +62,22 @@ enum cxl_regloc_type {
>  	CXL_REGLOC_RBI_TYPES
>  };
>  
> +/*
> + * CXL v3.0 6.2.3 Table 6-4
> + * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
> + * mode, otherwise it's 68B flits mode.
> + */
> +static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
> +{

As per other branch of thread, I'd like to see 68 byte confirmed by checking
the flex bus dvsec.  Sure it should always match your assumption (as we shouldn't
be in normal PCI at this stage) but we might be if this code gets called
in other paths from current intent.


> +	u32 lnksta2;
> +
> +	pcie_capability_read_dword(pdev, PCI_EXP_LNKSTA2, &lnksta2);
> +	return lnksta2 & BIT(10);
> +}
> +
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
>  void read_cdat_data(struct cxl_port *port);
> +long cxl_pci_get_latency(struct pci_dev *pdev);
>  #endif /* __CXL_PCI_H__ */
> 
> 

