Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DBA466104
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 10:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbhLBKCI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Dec 2021 05:02:08 -0500
Received: from mail-ed1-f46.google.com ([209.85.208.46]:39880 "EHLO
        mail-ed1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357198AbhLBKA6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Dec 2021 05:00:58 -0500
Received: by mail-ed1-f46.google.com with SMTP id w1so113864843edc.6;
        Thu, 02 Dec 2021 01:57:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=en+Opy31MVytWWQD7G7uESibRnRhr5heljRq+Tgyh3k=;
        b=oPgKGvqFeJeSvqCNO3WSNpJoYQ9qSLzPxDb4Z1/CV4g3TBvpxI1qg2oM7vruqV2soD
         MlU2VKe+Tk6aQXySZ9nSdS0aqRcr2Jn1E6fM2hJ6KQ8UndG1gZR/eOejsOnoyX2EXloN
         Nk2Mwjma0lV9je4CBc29TAM34yOfub5ibQUy1xrlzEUc+9P+5JwLDS0eEl09PALTkxor
         fPIGO6SGGxKP+B8kpR4S6rQru61rmtGxpfBz3Jt+0o+X0C/jCRG3ORqrYzujqUAQdr6f
         cvaQAKJGIPYalt4XZLhf6b7+P4UmooSjoInraQAQEts3wOkknhMBcHUHjuxJimawppIB
         aqAA==
X-Gm-Message-State: AOAM530AR4frB4GlBAkm3vn1xpfczxP545uHkZ561RdMB5mjyjPO/aOI
        QVNy2TTgW0VLT5oJyAvnCSQ=
X-Google-Smtp-Source: ABdhPJw6nmoGzRg2kEWm4EnXCY7RMccJAoIb40B+fUyn9zp8V8Br3ohmm71FaGOTtg+ckZXf623FnQ==
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr16405018edd.113.1638439054291;
        Thu, 02 Dec 2021 01:57:34 -0800 (PST)
Received: from rocinante ([95.155.85.46])
        by smtp.gmail.com with ESMTPSA id z22sm2035051edd.78.2021.12.02.01.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 01:57:33 -0800 (PST)
Date:   Thu, 2 Dec 2021 10:57:32 +0100
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     will@kernel.org, mark.rutland@arm.com, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linuxarm@huawei.com,
        zhangshaokun@hisilicon.com
Subject: Re: [PATCH v13 0/2] drivers/perf: hisi: Add support for PCIe PMU
Message-ID: <YaiYjHRrX+XfTic8@rocinante>
References: <20211202080633.2919-1-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211202080633.2919-1-liuqi115@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Qi,

[...]
> Changes since v12:
> - Modify the printout message of cpuhotplug to standard.
> - Link: https://lore.kernel.org/linux-arm-kernel/20211130120450.2747-1-liuqi115@huawei.com/
> 
> Changes since v11:
> - Address the comments from Krzysztof, drop all the final dot and change bdf in comment to BDF.
> - Link: https://lore.kernel.org/linux-arm-kernel/20211029093632.4350-1-liuqi115@huawei.com/
> 
> Changes since v10:
> - Drop the out of date comment according to Jonathan's review.
> - Link: https://lore.kernel.org/linux-arm-kernel/20210915074524.18040-1-liuqi115@huawei.com/
> 
> Changes since v9:
> - Add check in hisi_pcie_pmu_validate_event_group to count counters accurently .
> - Link: https://lore.kernel.org/linux-arm-kernel/20210818051246.29545-1-liuqi115@huawei.com/
> 
> Changes since v8:
> - Remove subevent parameter in attr->config.
> - Check the counter scheduling constraints when accepting an event group.
> - Link: https://lore.kernel.org/linux-arm-kernel/20210728080932.72515-1-liuqi115@huawei.com/
> 
> Changes since v7:
> - Drop headerfile cpumask.h and cpuhotplug.h.
> - Rename events in perf list: bw->flux, lat->delay, as driver doesn't
>   process bandwidth and average latency data.
> - Link: https://lore.kernel.org/linux-arm-kernel/1624532384-43002-1-git-send-email-liuqi115@huawei.com/
> 
> Changes since v6:
> - Move the driver to drivers/perf/hisilicon.
> - Treat content in PMU counter and ext_counter as different PMU events, and
>   export them separately.
> - Address the comments from Will and Krzysztof.
> - Link: https://lore.kernel.org/linux-arm-kernel/1622467951-32114-1-git-send-email-liuqi115@huawei.com/
> 
> Changes since v5:
> - Fix some errors when build under ARCH=xtensa.
> - Link: https://lore.kernel.org/linux-arm-kernel/1621946795-14046-1-git-send-email-liuqi115@huawei.com/
> 
> Changes since v4:
> - Replace irq_set_affinity_hint() with irq_set_affinity().
> - Link: https://lore.kernel.org/linux-arm-kernel/1621417741-5229-1-git-send-email-liuqi115@huawei.com/
> 
> Changes since v3:
> - Fix some warnings when build under 32bits architecture.
> - Address the comments from John.
> - Link: https://lore.kernel.org/linux-arm-kernel/1618490885-44612-1-git-send-email-liuqi115@huawei.com/
> 
> Changes since v2:
> - Address the comments from John.
> - Link: https://lore.kernel.org/linux-arm-kernel/1617959157-22956-1-git-send-email-liuqi115@huawei.com/
> 
> Changes since v1:
> - Drop the internal Reviewed-by tag.
> - Fix some build warnings when W=1.
> - Link: https://lore.kernel.org/linux-arm-kernel/1617788943-52722-1-git-send-email-liuqi115@huawei.com/
> Qi Liu (2):
>   docs: perf: Add description for HiSilicon PCIe PMU driver
>   drivers/perf: hisi: Add driver for HiSilicon PCIe PMU

Thank you!  Solid work here!  Much appreciated.

	Krzysztof
