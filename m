Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D479183AAF
	for <lists+linux-pci@lfdr.de>; Thu, 12 Mar 2020 21:37:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgCLUhA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Mar 2020 16:37:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:34012 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725268AbgCLUhA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 12 Mar 2020 16:37:00 -0400
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A74082067C;
        Thu, 12 Mar 2020 20:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584045419;
        bh=Ufrs0NrxPRpAXMAHKSK7UC+Qag5UGe1br16eZilZ6GE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=cFy0DYaTnVfy9zSCJ4tZwxeYmUh9YwFvLPx5N56vblSaDRqsG/LhI/Em2XHoqFdGz
         gTxnKGk8O0tinDj4CC8ZB+7S/EECEULbXVwX4MiMjwOPAtzrI79hxwu2xUviuC+P3d
         B/qyq2ztpdkTgD0qW+BvPOIrPMLn1KSyl+kLXD6w=
Date:   Thu, 12 Mar 2020 15:36:57 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     will@kernel.org, mark.rutland@arm.com, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxarm@huawei.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC] perf:Add driver for HiSilicon PCIe PMU
Message-ID: <20200312203657.GA175613@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1584014816-1908-1-git-send-email-liuqi115@huawei.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use "git log --oneline drivers/perf" to see the convention, and update
subject to follow suit.  At least add a space in "perf:Add".

On Thu, Mar 12, 2020 at 08:06:56PM +0800, Qi Liu wrote:
> From: Qi liu <liuqi115@huawei.com>
> 
> PCIe PMU Root Complex Integrate End Point(IEP) device is
> supported to sample bandwidth, latency, buffer occupation,
> bandwidth utilization etc.
> Each PMU IEP device monitors multiple root ports, and each
> IEP is registered as a pmu in /sys/bus/event_source/devices,
> so users can select the target IEP, and use filter to select
> root port, function and event.
> Filtering options are:
> event:    - select the event.
> subevent: - select the subevent.
> port:     - select target root port.
> func:     - select target EP device under the port.

The above *looks* like it's supposed to be three separate paragraphs;
please add blank lines between them.

s/Integrate/Integrated/

I assume this is a vendor-specific device; if so, please mention the
vendor so it doesn't look like something generic.

> Example: hisi_pcie_00_14_00/event=0x08,subevent=0x04,   \
> port=0x05,func=0x00/ -I 1000
> 
> PMU IEP device is described by its bus, device and function,
> target root port is 0x05 and target EP under it is function
> 0x00. Subevent 0x04 of event 0x08 is sampled.
> 
> Note that in this RFC:
> 1. PCIe PMU IEP hardware is still in development.
> 2. Perf common event list is undetermined, and name of these
> events still need to be discussed.
> 3. port filter could only select one port each time.
> 4. There are two possible schemes of pmu registration, one is
> register each root port as a pmu, it is easier for users to
> select target port. The other one is register each IEP as pmu,
> for counters are per IEP, not per root port, the second scheme
> describes hardware PMC much more reasonable, but need to add
> "port" filter option to select port. We use the second one in
> this RFC.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>  drivers/perf/Kconfig             |  10 +
>  drivers/perf/Makefile            |   1 +
>  drivers/perf/pci/Makefile        |   2 +
>  drivers/perf/pci/hisi_pcie_pmu.c | 887 +++++++++++++++++++++++++++++++++++++++
>  include/linux/cpuhotplug.h       |   1 +
>  5 files changed, 901 insertions(+)
>  create mode 100644 drivers/perf/pci/Makefile
>  create mode 100644 drivers/perf/pci/hisi_pcie_pmu.c
> 
> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
> index 09ae8a9..047022b 100644
> --- a/drivers/perf/Kconfig
> +++ b/drivers/perf/Kconfig
> @@ -114,6 +114,16 @@ config THUNDERX2_PMU
>  	   The SoC has PMU support in its L3 cache controller (L3C) and
>  	   in the DDR4 Memory Controller (DMC).
>  
> +config PCIE_PMU

This config symbol is too generic for a vendor-specific device.

> +	tristate "PCIE PERF PMU"
> +	depends on ARM64
> +	default m
> +	help
> +	   Provide support for 1630 PCIe performance monitoring unit (PMU)
> +	   IEP devices.
> +	   Adds the PCIe PMU into perf events system for monitoring latency,
> +	   bandwidth etc.

> +static int hisi_pcie_pmu_irq_register(struct pci_dev *pdev,
> +				      struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	int irq, ret;
> +
> +	irq = pci_irq_vector(pdev, HISI_PCIE_EVENT_IRQ_VECTOR);
> +	ret = request_irq(irq, hisi_pcie_pmu_irq, IRQF_SHARED,
> +			  pcie_pmu->dev_name, pcie_pmu);
> +	if (ret)
> +		return ret;
> +
> +	pcie_pmu->irq = irq;
> +	return ret;

  return 0;

> +}

> +static int hisi_pcie_init_pmu(struct pci_dev *pdev,
> +			      struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	char *name;
> +	int ret;
> +
> +	hisi_get_pcie_pmu(pdev, pcie_pmu);
> +
> +	ret = cpuhp_state_add_instance(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
> +				       &pcie_pmu->node);
> +	if (ret) {
> +		pci_err(pdev, "Error %d registering hotplug;\n", ret);
> +		return ret;
> +	}
> +
> +	/*
> +	 * domain_id is 0x00 means continuous domain, we use bdf num to
> +	 * select IEP. Otherwise, use domain_id + bdf.

I don't see what this comment applies to.  Nothing in this function
uses "domain_id".  In fact, pcie_pmu->domain_id is set but never used
anywhere.

> +	 */
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
> +			      "hisi_pcie_%x_%x_%x", pcie_pmu->bus_id,
> +			      pcie_pmu->device_id, pcie_pmu->func_id);

> +static int hisi_pcie_pmu_probe(struct pci_dev *pdev,
> +			       const struct pci_device_id *id)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu;
> +	int ret;
> +
> +	pcie_pmu = devm_kzalloc(&pdev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
> +	if (!pcie_pmu)
> +		return -ENOMEM;
> +
> +	pci_set_drvdata(pdev, pcie_pmu);
> +	ret = hisi_pcie_init_dev(pdev);
> +	if (ret)
> +		return ret;
> +
> +	ret = hisi_pcie_init_pmu(pdev, pcie_pmu);
> +	if (ret)
> +		return ret;
> +
> +	return ret;

This is the same as:

  return hisi_pcie_init_pmu(pdev, pcie_pmu);

> +}
