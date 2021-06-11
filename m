Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D373A4B40
	for <lists+linux-pci@lfdr.de>; Sat, 12 Jun 2021 01:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbhFKXf5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 19:35:57 -0400
Received: from mail-wm1-f43.google.com ([209.85.128.43]:35393 "EHLO
        mail-wm1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbhFKXf5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Jun 2021 19:35:57 -0400
Received: by mail-wm1-f43.google.com with SMTP id k5-20020a05600c1c85b02901affeec3ef8so9564701wms.0;
        Fri, 11 Jun 2021 16:33:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Z2zlmHj+1HcVsICU+2gdJrF/4o7OgOCN/FyHrCzGZ6g=;
        b=pLLVtIyg5sIEWCzB8C4qKBzG/fFWwcDsAZJm35I8bEEwZqYRN+qXhQSn7Z33mQPf+i
         q5ARARdwMGdjduzz37ujN3IJE/PGdPsOC+7+OSjVr3Zs8Rrrdhvel1ayWBGH3cpFAgiS
         jCh+jZtMYlaEgWxBgnJBe9tWWwMs6qEWMmHvGOxspQUznf+eOabjA1dR0c9KHukE9dCU
         6LThNkzWDb+hRUB6hspBhNSigWIHtFe1WxO5SOxX8eyrd9FVcyNo4Lgj9yGIji2O0xX2
         hi4+ctGtO6izD1dtcOGxVE+OgsQs/VwUCXxidfstL1vnXkGhBrUXYqZFiSwkHuwLhG+u
         ymGg==
X-Gm-Message-State: AOAM531chuivuQIFg2cA9I2HcpX+pAI+GmWzNQTlIavnX2NgD/+86SN8
        A6AVn39YIfMP3DN0UjoF4xo=
X-Google-Smtp-Source: ABdhPJzZbySWhRyOkrWp6EOaPa7zyUyPkaWhFMgfEwdFMTM6Jbyt9M95x8X/q/432QsPVybj8D6RFw==
X-Received: by 2002:a7b:c192:: with SMTP id y18mr22530884wmi.65.1623454437589;
        Fri, 11 Jun 2021 16:33:57 -0700 (PDT)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id x7sm8838753wre.8.2021.06.11.16.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 16:33:56 -0700 (PDT)
Date:   Sat, 12 Jun 2021 01:33:55 +0200
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     will@kernel.org, mark.rutland@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH v6 2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe
 PMU
Message-ID: <20210611233355.GA183580@rocinante>
References: <1622467951-32114-1-git-send-email-liuqi115@huawei.com>
 <1622467951-32114-3-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1622467951-32114-3-git-send-email-liuqi115@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Qi,

Thank you for sending the patch over!

[...]
> +/*
> + * This driver adds support for PCIe PMU RCiEP device. Related
> + * perf events are bandwidth, bandwidth utilization, latency
> + * etc.
> + *
> + * Copyright (C) 2021 HiSilicon Limited
> + * Author: Qi Liu<liuqi115@huawei.com>
> + */

A small nitpick: missing space between your name and the e-mail address.

[...]
> +static ssize_t hisi_pcie_event_sysfs_show(struct device *dev,
> +				   struct device_attribute *attr, char *buf)
> +{
> +	struct dev_ext_attribute *eattr;
> +
> +	eattr = container_of(attr, struct dev_ext_attribute, attr);
> +
> +	return sysfs_emit(buf, "config=0x%lx\n", (unsigned long)eattr->var);
> +}

I am not that familiar with the perf drivers, thus I might be completely
wrong here, but usually for sysfs objects a single value is preferred,
so that this "config=" technically would not be needed, unless this is
somewhat essential to the consumers of this attribute to know what the
value is?  What do you think?

[...]
> +static ssize_t hisi_pcie_identifier_show(struct device *dev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "0x%x\n", pcie_pmu->identifier);
> +}

What about using the "%#x" formatting flag?  It would automatically
added the "0x" prefix, etc.

> +static ssize_t hisi_pcie_bus_show(struct device *dev,
> +				  struct device_attribute *attr, char *buf)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(dev_get_drvdata(dev));
> +
> +	return sysfs_emit(buf, "0x%02x\n", PCI_BUS_NUM(pcie_pmu->bdf_min));
> +}

Same as above, what about "%#02x"?

[...]
> +static bool hisi_pcie_pmu_valid_filter(struct perf_event *event,
> +				       struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	u32 subev_idx = hisi_pcie_get_subevent(event);
> +	u32 event_idx = hisi_pcie_get_event(event);
> +	u32 requester_id = hisi_pcie_get_bdf(event);
> +
> +	if (subev_idx > HISI_PCIE_SUBEVENT_MAX ||
> +	    event_idx > HISI_PCIE_EVENT_MAX) {
> +		pci_err(pcie_pmu->pdev,
> +			"Max event index and max subevent index is: %d, %d.\n",
> +			HISI_PCIE_EVENT_MAX, HISI_PCIE_SUBEVENT_MAX);
> +		return false;
> +	}

Was this error message above intended to be a debug message?  It's a bit
opaque in terms what the error actually is here.  We might need to clear
it up a little.

[...]
> +static bool hisi_pcie_pmu_validate_event_group(struct perf_event *event)
> +{
> +	struct perf_event *sibling, *leader = event->group_leader;
> +	int counters = 1;

How big this counter could become?

Would it ever be greater than HISI_PCIE_MAX_COUNTERS?  I am asking, as
if it would be ever greater, then perhaps unsigned int would be better
to use, and if not, then perhaps something smaller than int?  What do
you think, does this even make sense to change?

[...]
> +static int hisi_pcie_pmu_event_init(struct perf_event *event)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = to_pcie_pmu(event->pmu);
> +
> +	event->cpu = pcie_pmu->on_cpu;
> +
> +	if (event->attr.type != event->pmu->type)
> +		return -ENOENT;
> +
> +	/* Sampling is not supported. */
> +	if (is_sampling_event(event) || event->attach_state & PERF_ATTACH_TASK)
> +		return -EOPNOTSUPP;
> +
> +	if (!hisi_pcie_pmu_valid_filter(event, pcie_pmu)) {
> +		pci_err(pcie_pmu->pdev, "Invalid filter!\n");
> +		return -EINVAL;
> +	}

[...]
> +/*
> + * The bandwidth, latency, bus utilization and buffer occupancy features are
> + * calculated from data in HISI_PCIE_CNT and extended data in HISI_PCIE_EXT_CNT.
> + * Other features are obtained only by HISI_PCIE_CNT.
> + * So data and data_ext are processed in this function to get performanace
> + * value like, bandwidth, latency, etc.
> + */

A small typo in the world "performance" above.

[...]
> +static u64 hisi_pcie_pmu_get_performance(struct perf_event *event, u64 data,
> +					 u64 data_ext)
> +{
> +#define CONVERT_DW_TO_BYTE(x)	(sizeof(u32) * (x))

I would move this macro at the top alongside other constants and macros,
as here it makes the code harder to read.  What do you think?

[...]
> +static int hisi_pcie_pmu_irq_register(struct pci_dev *pdev,
> +				      struct hisi_pcie_pmu *pcie_pmu)
> +{
> +	int irq, ret;
> +
> +	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
> +	if (ret < 0) {
> +		pci_err(pdev, "Failed to enable MSI vectors, ret = %d!\n", ret);
> +		return ret;
> +	}

This is a nitpick, so feel free to ignore it, but what do you think of
changing this (and also other messages alike) message to be, for
example:

  pci_err(pdev, "Failed to enable MSI vectors: %d\n", ret);

Why?  I personally don't find displaying a return code/value followed by
a punctuation easy to read, especially when looking through a lot of
lines and other messages in the kernel ring buffer.

[...]
> +
> +	irq = pci_irq_vector(pdev, 0);
> +	ret = request_irq(irq, hisi_pcie_pmu_irq,
> +			  IRQF_NOBALANCING | IRQF_NO_THREAD, "hisi_pcie_pmu",
> +			  pcie_pmu);
> +	if (ret) {
> +		pci_err(pdev, "Failed to register irq, ret = %d!\n", ret);
> +		pci_free_irq_vectors(pdev);
> +		return ret;
> +	}

It would be "IRQ" in the error message above.

[...]
> +static int hisi_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *node)
> +{
> +	struct hisi_pcie_pmu *pcie_pmu = hlist_entry_safe(node,
> +					 struct hisi_pcie_pmu, node);
> +	unsigned int target;
> +
> +	/* Nothing to do if this CPU doesn't own the PMU */
> +	if (pcie_pmu->on_cpu != cpu)
> +		return 0;
> +
> +	/* Choose a new CPU from all online cpus. */
> +	target = cpumask_first(cpu_online_mask);
> +	if (target >= nr_cpu_ids) {
> +		pci_err(pcie_pmu->pdev, "There is no cpu to set!\n");
> +		return 0;
> +	}

To be consistent, it would be "CPUs" and "CPU" in the above.

[...]
> +static struct device_attribute hisi_pcie_pmu_bus_attr =
> +	__ATTR(bus, 0444, hisi_pcie_bus_show, NULL);
[...]
> +static struct device_attribute hisi_pcie_pmu_cpumask_attr =
> +	__ATTR(cpumask, 0444, hisi_pcie_cpumask_show, NULL);
[...]
> +static struct device_attribute hisi_pcie_pmu_identifier_attr =
> +	__ATTR(identifier, 0444, hisi_pcie_identifier_show, NULL);

Would it be at possible for any of the above __ATTR() macros to be
replaced with the DEVICE_ATTR_RO() macro?  Or perhaps with __ATTR_RO()
if the other one would be a good fit?

[...]
> +static int hisi_pcie_init_dev(struct pci_dev *pdev)
> +{
> +	int ret;
> +
> +	ret = pci_enable_device(pdev);
> +	if (ret) {
> +		pci_err(pdev, "Failed to enable pci device, ret = %d.\n", ret);
> +		return ret;
> +	}
> +
> +	ret = pci_request_mem_regions(pdev, "hisi_pcie_pmu");
> +	if (ret < 0) {
> +		pci_err(pdev, "Failed to request pci mem regions, ret = %d.\n",
> +			ret);
> +		pci_disable_device(pdev);
> +		return ret;
> +	}

It would be "PCI" in both error messages above.

[...]
> +static int __init hisi_pcie_module_init(void)
> +{
> +	int ret;
> +
> +	ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
> +				      "AP_PERF_ARM_HISI_PCIE_PMU_ONLINE",
> +				      hisi_pcie_pmu_online_cpu,
> +				      hisi_pcie_pmu_offline_cpu);
> +	if (ret) {
> +		pr_err("Failed to setup PCIE PMU hotplug, ret = %d.\n", ret);
> +		return ret;
> +	}

It would be "PCIe" in the error message above.

	Krzysztof
