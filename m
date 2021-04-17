Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 400FA363078
	for <lists+linux-pci@lfdr.de>; Sat, 17 Apr 2021 15:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236129AbhDQN5J (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Apr 2021 09:57:09 -0400
Received: from mga01.intel.com ([192.55.52.88]:60140 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236058AbhDQN5J (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Apr 2021 09:57:09 -0400
IronPort-SDR: Sf+tmaw5V7DoCpgOMcizwHoNE5wX8dGGY4jB1iDV8lq8oeL4FhMZlivjo/vXiaMSZiFKMPpQWi
 xQwzZ9CTYruQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9957"; a="215722368"
X-IronPort-AV: E=Sophos;i="5.82,229,1613462400"; 
   d="scan'208";a="215722368"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2021 06:56:42 -0700
IronPort-SDR: rfkFROCfAr3fKHP9T+JiF0ymqW11+G9xkVZnj656scJEKzwTA3YPKDnlUNGFmaJQc98VE/wGfM
 9iYrN9q4Enhg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,229,1613462400"; 
   d="scan'208";a="419459743"
Received: from um.fi.intel.com (HELO um) ([10.237.72.62])
  by fmsmga008.fm.intel.com with ESMTP; 17 Apr 2021 06:56:36 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Yicong Yang <yangyicong@hisilicon.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-pci@vger.kernel.org
Cc:     helgaas@kernel.org, gregkh@linuxfoundation.org,
        lorenzo.pieralisi@arm.com, will@kernel.org, mark.rutland@arm.com,
        mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, song.bao.hua@hisilicon.com,
        john.garry@huawei.com, prime.zeng@huawei.com, liuqi115@huawei.com,
        zhangshaokun@hisilicon.com, yangyicong@hisilicon.com,
        linuxarm@huawei.com, alexander.shishkin@linux.intel.com
Subject: Re: [PATCH RESEND 0/4] Add support for HiSilicon PCIe Tune and
 Trace device
In-Reply-To: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
References: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
Date:   Sat, 17 Apr 2021 16:56:35 +0300
Message-ID: <8735vpf20c.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Yicong Yang <yangyicong@hisilicon.com> writes:

> The reason for not using perf is because there is no current support
> for uncore tracing in the perf facilities.

Not unless you count

$ perf list|grep -ic uncore
77

> We have our own format
> of data and don't need perf doing the parsing.

Perf has AUX buffers, which are used for all kinds of own formats.

> A similar approach for implementing this function is ETM, which use
> sysfs for configuring and a character device for dumping data.

And also perf. One reason ETM has a sysfs interface is because the
driver predates perf's AUX buffers. Can't say if it's the only
reason. I'm assuming you're talking about Coresight ETM.

> Greg has some comments on our implementation and doesn't advocate
> to build driver on debugfs [1]. So I resend this series to
> collect more feedbacks on the implementation of this driver.
>
> Hi perf and ETM related experts, is it suggested to adapt this driver
> to perf? Or is the debugfs approach acceptable? Otherwise use

Aside from the above, I don't think the use of debugfs for kernel ABIs
is ever encouraged.

Regards,
--
Ale
