Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C46FE7380C1
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jun 2023 13:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjFULGK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jun 2023 07:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbjFULFo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jun 2023 07:05:44 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5E33D1BEC;
        Wed, 21 Jun 2023 04:05:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D08BB1063;
        Wed, 21 Jun 2023 04:06:16 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 34AA43F663;
        Wed, 21 Jun 2023 04:05:31 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        mathieu.poirier@linaro.org, corbet@lwn.net,
        Yicong Yang <yangyicong@huawei.com>,
        jonathan.cameron@huawei.com
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-pci@vger.kernel.org, prime.zeng@huawei.com,
        yangyicong@hisilicon.com, hejunhao3@huawei.com,
        alexander.shishkin@linux.intel.com, linuxarm@huawei.com,
        helgaas@kernel.org
Subject: Re: [PATCH v6 0/5] Improve PTT filter interface and some fixes
Date:   Wed, 21 Jun 2023 12:05:16 +0100
Message-Id: <168734549634.567664.225208952925294170.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621092804.15120-1-yangyicong@huawei.com>
References: <20230621092804.15120-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 21 Jun 2023 17:27:59 +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> This series tends to improve the PTT's filter interface in 2 aspects (Patch 2&3):
> - Support dynamically filter updating to response to hotplug
>   Previous the supported filter list is settled down once the driver probed and
>   it maybe out-of-date if hotplug events happen later. User need to reload the
>   driver to update list. Patch 1/2 enable the driver to update the list by
>   registering a PCI bus notifier and the filter list will always be the latest.
> - Export the available filters through sysfs
>   Previous user needs to calculate the filters and filter value using device's
>   BDF number, which requires the user to know the hardware well. Patch 3/3 tends
>   to export the available filter information through sysfs attributes, the filter
>   value will be gotten by reading the file. This will be more user friendly.
> 
> [...]

Applied, thanks!

[1/5] hwtracing: hisi_ptt: Factor out filter allocation and release operation
      commit: a3ecaba7017f5d02d1ad60229cc14d5f0cda0c20
[2/5] hwtracing: hisi_ptt: Add support for dynamically updating the filter list
      commit: 556ef09392dbc2d0b9aad5fd880d5d11addfc40d
[3/5] hwtracing: hisi_ptt: Export available filters through sysfs
      commit: 6373c463ac894e41cab24469d1947ff91aaea486
[4/5] hwtracing: hisi_ptt: Advertise PERF_PMU_CAP_NO_EXCLUDE for PTT PMU
      commit: 45c90292ad0e275ef4b870838b3b5273b3ef8ade
[5/5] hwtracing: hisi_ptt: Fix potential sleep in atomic context
      commit: 6c50384ef8b94a527445e3694ae6549e1f15d859

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
