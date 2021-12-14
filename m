Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE42547446D
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 15:04:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbhLNOEt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 09:04:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33376 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234660AbhLNOEt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 09:04:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D70D4B819C8;
        Tue, 14 Dec 2021 14:04:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95D3FC34608;
        Tue, 14 Dec 2021 14:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639490686;
        bh=zrEpCYD1NVNo4oExLeQcs/vbny3ugkBOe+tK9tgu+kM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A5WmV7rlsV8zeA68Ts/VGFnfrQuKbNd6hZ9nWpu059FQmZfZuRqS/TXDBCfGw+iVH
         zhbN8QV8kbYxOmvsdzFz8kIz3nbQMznDZ4J/jdP6Bykq3/2KwGZFYPcDy1uTmaQL0E
         hyzV5HCXM2k5oRlO9VqvAHOU3vfZYoh73g5e1n0JZC2lK4r3rgFOYqc3b1VJVV4k80
         9WN+dEwTFU0Mu951UbtBdk5yHikBH8XB/MrYoLbau4z4FivXoBTiYR0j+kToc48+Nc
         HH0kfpFsEQ1NlssOfjKNaH9K6kCk4B9jZbBgAlMVaFn7jjFUAXAxALf4tf8+UgCLlO
         gBGX5gvDfuTZg==
From:   Will Deacon <will@kernel.org>
To:     bhelgaas@google.com, Qi Liu <liuqi115@huawei.com>,
        mark.rutland@arm.com
Cc:     catalin.marinas@arm.com, kernel-team@android.com,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, zhangshaokun@hisilicon.com,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH v13 0/2] drivers/perf: hisi: Add support for PCIe PMU
Date:   Tue, 14 Dec 2021 14:04:34 +0000
Message-Id: <163948502719.3585031.9796899117574080262.b4-ty@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211202080633.2919-1-liuqi115@huawei.com>
References: <20211202080633.2919-1-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 2 Dec 2021 16:06:31 +0800, Qi Liu wrote:
> This patchset adds support for HiSilicon PCIe Performance Monitoring
> Unit(PMU). It is a PCIe Root Complex integrated End Point(RCiEP) device
> added on Hip09. Each PCIe Core has a PMU RCiEP to monitor multi root
> ports and all Endpoints downstream these root ports.
> 
> HiSilicon PCIe PMU is supported to collect performance data of PCIe bus,
> such as: bandwidth, latency etc.
> 
> [...]

Applied to arm64 (for-next/perf-hisi), thanks!

[1/2] docs: perf: Add description for HiSilicon PCIe PMU driver
      https://git.kernel.org/arm64/c/c8602008e247
[2/2] drivers/perf: hisi: Add driver for HiSilicon PCIe PMU
      https://git.kernel.org/arm64/c/8404b0fbc7fb

Cheers,
-- 
Will

https://fixes.arm64.dev
https://next.arm64.dev
https://will.arm64.dev
