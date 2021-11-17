Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B6A4550A6
	for <lists+linux-pci@lfdr.de>; Wed, 17 Nov 2021 23:41:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241381AbhKQWoM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Nov 2021 17:44:12 -0500
Received: from mail-wr1-f46.google.com ([209.85.221.46]:36835 "EHLO
        mail-wr1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241317AbhKQWoK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Nov 2021 17:44:10 -0500
Received: by mail-wr1-f46.google.com with SMTP id s13so7619000wrb.3;
        Wed, 17 Nov 2021 14:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pP5j1KPa+oLLZIqN3V90YggZzRPPFSASRy8/v4Hg2Xk=;
        b=sBLEWH6kNkhwMIKF2333N44PWVlXw4p7dAMmednUGtLExYCScP/h2OsklBJOrzyJ5j
         MBMHS9+k/c0W65uIp6qcQ3TmomY1ffA8pjJV+DJ3EVaaG6kW3Q/oVvxsTrQl37Pc+0ow
         GXbL+64rR3taibNykG0pli3RKMncb+y+bmdMbNuq1D8gf/Fzf7/kFgwoIqC65DI5nllx
         XPRAUYIguWR+UiG6Pgw7n9kGVMJYs0FZcb5PACR+a0K4grRq4HAsuYx0N/7/15e6RUND
         fHzWAT7uLKXI5Fe629Hs3a3+GKX4pRgkz73ucphBMsndUr/ATTtav6MNDwoEgVMnKZq1
         X8hA==
X-Gm-Message-State: AOAM533WaHzYQk84Dj4q1NkpC6Rul/Geq7fHyIcMSSyH77ESVcH9hOt4
        9XTXhhxE/oyxUNoickPEuzu9i6rjyGkKHflt
X-Google-Smtp-Source: ABdhPJyT1T5Gg4V+cRYvQzUeFM1R+tPtJ1AW2UXpEHl/E/2ZzjyEm77ozQOIfFlLWtbqZ0Qs6reXiA==
X-Received: by 2002:a5d:6d0b:: with SMTP id e11mr24961989wrq.16.1637188870422;
        Wed, 17 Nov 2021 14:41:10 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id q4sm1151957wrs.56.2021.11.17.14.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 14:41:09 -0800 (PST)
Date:   Wed, 17 Nov 2021 23:41:08 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com
Subject: Re: [PATCH v11 2/2] drivers/perf: hisi: Add driver for HiSilicon
 PCIe PMU
Message-ID: <CAC52Y8Zc5oRRBDiZq+zQNGw2CbURN2SRsfW9ek_gw96qDHB1zw@mail.gmail.com>
References: <20211029093632.4350-1-liuqi115@huawei.com>
 <20211029093632.4350-3-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211029093632.4350-3-liuqi115@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Qi,

Thank you for working on this!  Looks really good!

Below a few tiny nitpicks that you are more than welcome to ignore, of
course, as these would have little weight on the final product, so to
speak.

> +struct hisi_pcie_pmu {
> +     struct perf_event *hw_events[HISI_PCIE_MAX_COUNTERS];
> +     struct hlist_node node;
> +     struct pci_dev *pdev;
> +     struct pmu pmu;
> +     void __iomem *base;
> +     int irq;
> +     u32 identifier;
> +     /* Minimum and maximum bdf of root ports monitored by PMU */
> +     u16 bdf_min;
> +     u16 bdf_max;
> +     int on_cpu;
> +};

Would the above "bdf" be the PCI addressing schema?  If so, then we could
capitalise the acronym to keep it consistent with how it's often referred
to in the PCI world.

[...]
> +static int __init hisi_pcie_module_init(void)
> +{
> +     int ret;
> +
> +     ret = cpuhp_setup_state_multi(CPUHP_AP_PERF_ARM_HISI_PCIE_PMU_ONLINE,
> +                                   "AP_PERF_ARM_HISI_PCIE_PMU_ONLINE",
> +                                   hisi_pcie_pmu_online_cpu,
> +                                   hisi_pcie_pmu_offline_cpu);
> +     if (ret) {
> +             pr_err("Failed to setup PCIe PMU hotplug, ret = %d.\n", ret);
> +             return ret;
> +     }

The above error message could be made to be a little more aligned in terms
of format with the other messages, thus it would be as follows:

  pr_err("Failed to setup PCIe PMU hotplug: %d.\n", ret);

Interestingly, there would be then no need to add the final dot (period) at
the end here, and that would be true everywhere else.

Again, thank you so much for working on this, it's very much appreciated!

Acked-by: Krzysztof Wilczyński <kw@linux.com>

        Krzysztof
