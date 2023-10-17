Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD747CC95F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Oct 2023 19:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234988AbjJQRBt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 13:01:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233940AbjJQRBq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 13:01:46 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76408113;
        Tue, 17 Oct 2023 10:01:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C42502F4;
        Tue, 17 Oct 2023 10:02:21 -0700 (PDT)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 978083F762;
        Tue, 17 Oct 2023 10:01:39 -0700 (PDT)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     linux-kernel@vger.kernel.org, mathieu.poirier@linaro.org,
        Yicong Yang <yangyicong@huawei.com>,
        jonathan.cameron@huawei.com
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, hejunhao3@huawei.com,
        yangyicong@hisilicon.com, helgaas@kernel.org, linuxarm@huawei.com,
        linux-pci@vger.kernel.org, alexander.shishkin@linux.intel.com,
        prime.zeng@hisilicon.com
Subject: Re: [PATCH v3 0/5] Several updates for PTT driver
Date:   Tue, 17 Oct 2023 18:01:32 +0100
Message-Id: <169756192530.746517.2466420521869567832.b4-ty@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231010084731.30450-1-yangyicong@huawei.com>
References: <20231010084731.30450-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 10 Oct 2023 16:47:26 +0800, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> This series contains several updates for PTT driver:
> - Disable interrupt when trace stops, reverse to what we do in trace start
> - Always handle the interrupt in hardirq context

I wrapped the commit description to 75 chars for this patch to suppress the
following checkpatch warning and queued it.

WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#10:
change of arm-ccn PMU commit 0811ef7e2f54 ("bus: arm-ccn: fix PMU interrupt flags").

total: 0 errors, 1 warnings, 12 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

      "[PATCH] hwtracing: hisi_ptt: Handle the interrupt in hardirq context" has style problems, please review.


> - Optimize the AUX buffer handling to make consumer have more time to process
>   the data
> - Since we're a uncore PMU so block any task attach operation
> - Add a dummy pmu::read() callback since the perf core may use
> 
> [...]

Applied, thanks!

[1/5] hwtracing: hisi_ptt: Disable interrupt after trace end
      https://git.kernel.org/coresight/c/4669551e797a
[2/5] hwtracing: hisi_ptt: Handle the interrupt in hardirq context
      https://git.kernel.org/coresight/c/e8b7d8718c51
[3/5] hwtracing: hisi_ptt: Optimize the trace data committing
      https://git.kernel.org/coresight/c/7a527d4d9273
[4/5] hwtracing: hisi_ptt: Don't try to attach a task
      https://git.kernel.org/coresight/c/7d52e2cfef91
[5/5] hwtracing: hisi_ptt: Add dummy callback pmu::read()
      https://git.kernel.org/coresight/c/4708eada8bd6

Best regards,
-- 
Suzuki K Poulose <suzuki.poulose@arm.com>
