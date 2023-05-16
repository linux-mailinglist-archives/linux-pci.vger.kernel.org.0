Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFE8F7056F4
	for <lists+linux-pci@lfdr.de>; Tue, 16 May 2023 21:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229535AbjEPTT7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 May 2023 15:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjEPTT6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 May 2023 15:19:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC90C7AB8;
        Tue, 16 May 2023 12:19:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8200263E45;
        Tue, 16 May 2023 19:19:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E817C433D2;
        Tue, 16 May 2023 19:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684264796;
        bh=H7hBEmw3Z3LoaI9KQBlQHHYtNoDMB9M+8qVjdKRbuio=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=U/uowP+R8HvoDRhWN0BTTHjsMrX84zavErJ+nQDYb5WuMFFdx1/01SDuAHkd3wL7t
         DZY5xi8YMVkjIgc0P5XxFfhbAfiz1jskUTDhxLpHhDa3iAvjAlL/sZtmQTq7Wf8TrY
         LpDYD8HaleZTv8PnLbpmPO1+6O03QIrc2lqhvK7teXFay3M6gcteNGlDO2cHNRj2A8
         X1gnUzBEhLpc7UZ1xxG4/htMeZvk1v10OSf4y1fqtayKfXKu0w2FpCCGmK37gYqDnM
         OdwweI7apqpeLjLLN7aOKD9xVDCzela8Qt9HMVKmoNHk2uN4veFEH3YrKX825PowL7
         ZweX7MQH+sqBw==
Date:   Tue, 16 May 2023 14:19:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Shuai Xue <xueshuai@linux.alibaba.com>
Cc:     yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com
Subject: Re: [PATCH v4 3/4] drivers/perf: add DesignWare PCIe PMU driver
Message-ID: <ZGPXWzwrZPZTIMJd@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516130110.59632-4-xueshuai@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 16, 2023 at 09:01:09PM +0800, Shuai Xue wrote:
> ...

> +#include <linux/pci.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cpuhotplug.h>
> +#include <linux/cpumask.h>
> +#include <linux/device.h>
> +#include <linux/errno.h>
> +#include <linux/kernel.h>
> +#include <linux/list.h>
> +#include <linux/perf_event.h>
> +#include <linux/platform_device.h>
> +#include <linux/smp.h>
> +#include <linux/sysfs.h>
> +#include <linux/types.h>

Typically in alpha order.

> +#define DWC_PCIE_VSEC_RAS_DES_ID		0x02
> +
> +#define DWC_PCIE_EVENT_CNT_CTL			0x8

Add a blank line here.

> +/*
> + * Event Counter Data Select includes two parts:

> +#define DWC_PCIE_EVENT_CNT_DATA			0xC
> +#define DWC_PCIE_DURATION_4US			0xff
...
Pick upper-case hex or lower-case hex and use consistently.

> +#define DWC_PCIE_LANE_EVENT_MAX_PERIOD		(GENMASK_ULL(31, 0))
> +#define DWC_PCIE_TIME_BASED_EVENT_MAX_PERIOD	(GENMASK_ULL(63, 0))

Unnecessary outer "()".

> +struct dwc_pcie_pmu {
> +	struct pci_dev		*pdev;		/* Root Port device */
> +	u32			ras_des;	/* RAS DES capability offset */

u16 is enough to address all of config space.
