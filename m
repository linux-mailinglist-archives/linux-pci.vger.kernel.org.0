Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF32B3AF9EC
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jun 2021 01:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232367AbhFUXzo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Jun 2021 19:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232413AbhFUXzh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Jun 2021 19:55:37 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F07C0613A2
        for <linux-pci@vger.kernel.org>; Mon, 21 Jun 2021 16:53:21 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id x22so7901983pll.11
        for <linux-pci@vger.kernel.org>; Mon, 21 Jun 2021 16:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEKHWQJp4n8yoFiHOuNtGCbJTSsuHccWZBKCtuc7Qts=;
        b=JfVj6R5c5gvmti+4j0JlnamjjPtwJC40uf1GOUKZBNoGRYiwsk9gN9EB47jU4GyrdB
         xt9uNo3jbU8+ZN08CVaYhgzUoi4ZKNEmEvp0W/f1M3/vIs9Q8AtbTKYGjpLEMeJJH90a
         3Q3C/PI3x6byOZQohM26KarCNSpYlv4k3HqMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEKHWQJp4n8yoFiHOuNtGCbJTSsuHccWZBKCtuc7Qts=;
        b=NFhud4N95vP/2OK0ucqdCinU1DRGPy6WEeZCRoo3pv+nmGBKJxj2QkssKu8ot6rJoF
         m24YQWSyQ0T7zmPqv3GNzTUERPAMZ1urmJihDVqlehczNufEnL0jwnGSQFj29/51tYOy
         gD1RLUYm1PzMfv5NXk1IVoV02YXchTWYIT7/apYLgZFVtfgakOx1DAM1QPrtM7kUmVuU
         8VDF/xtQkyh0FXHFY8Czq4wyh6O2mVRxjQQkOceq+Wuax2TMcDAlmnjgyoSfErYIXuwu
         B1yKDUBcJAgVGY0kezyZSLoV7QjeB0bHmtLCn3ce8a4Y1WY1alpCCz4u90jaeVu1n3Sq
         kNLg==
X-Gm-Message-State: AOAM530R9gNaGnZDZ9NkIDDQf2sP/0zzoRhG/rQnYulD+gG3mfPpREJT
        1m4erd0DBWTArvDxSNrxdjw3BQ==
X-Google-Smtp-Source: ABdhPJy2hHxfJrn4WVFmNTak00b5y5qz5F7V+JU2zimAB1kk2WW5Pzu2fcXDvLwNYMoHeCfmM4GdVw==
X-Received: by 2002:a17:90a:73ca:: with SMTP id n10mr809631pjk.16.1624319601314;
        Mon, 21 Jun 2021 16:53:21 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:bdc1:a4b1:b06e:91d1])
        by smtp.gmail.com with ESMTPSA id s27sm4339663pfg.169.2021.06.21.16.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 16:53:20 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     gregkh@linuxfoundation.org, rafael@kernel.org,
        rafael.j.wysocki@intel.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, bjorn.andersson@linaro.org,
        ulf.hansson@linaro.org, adrian.hunter@intel.com,
        bhelgaas@google.com
Cc:     robdclark@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-pci@vger.kernel.org, quic_c_gdjako@quicinc.com,
        iommu@lists.linux-foundation.org, sonnyrao@chromium.org,
        saiprakash.ranjan@codeaurora.org, linux-mmc@vger.kernel.org,
        vbadigan@codeaurora.org, rajatja@google.com, saravanak@google.com,
        joel@joelfernandes.org, Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 6/6] mmc: sdhci-msm: Request non-strict IOMMU mode
Date:   Mon, 21 Jun 2021 16:52:48 -0700
Message-Id: <20210621165230.6.Icde6be7601a5939960caf802056c88cd5132eb4e@changeid>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
In-Reply-To: <20210621235248.2521620-1-dianders@chromium.org>
References: <20210621235248.2521620-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

IOMMUs can be run in "strict" mode or in "non-strict" mode. The
quick-summary difference between the two is that in "strict" mode we
wait until everything is flushed out when we unmap DMA memory. In
"non-strict" we don't.

Using the IOMMU in "strict" mode is more secure/safer but slower
because we have to sit and wait for flushes while we're unmapping. To
explain a bit why "non-strict" mode is unsafe, let's imagine two
examples.

An example of "non-strict" being insecure when reading from a device:
a) Linux driver maps memory for DMA.
b) Linux driver starts DMA on the device.
c) Device write to RAM subject to bounds checking done by IOMMU.
d) Device finishes writing to RAM and signals transfer is finished.
e) Linux driver starts unmapping DMA memory but doesn't flush.
f) Linux driver validates that the data in memory looks sane and that
   accessing it won't cause the driver to, for instance, overflow a
   buffer.
g) Device takes advantage of knowledge of how the Linux driver works
   and sneaks in a modification to the data after the validation but
   before the IOMMU unmap flush finishes.
h) Device has now caused the Linux driver to access memory it
   shouldn't.

An example of "non-strict" being insecure when writing to a device:
a) Linux driver writes data intended for the device to RAM.
b) Linux driver maps memory for DMA.
c) Linux driver starts DMA on the device.
d) Device reads from RAM subject to bounds checking done by IOMMU.
e) Device finishes reading from RAM and signals transfer is finished.
f) Linux driver starts unmapping DMA memory but doesn't flush.
g) Linux driver frees memory and returns it to the pool.
h) Memory is allocated for another purpose.
i) Device takes advantage of the period of time before IOMMU flush to
   read memory that it shouldn't have had access to.

As you can see from the above examples, using the iommu in
"non-strict" mode might not sound _too_ scary (the window of badness
is small and the exposed memory is small) but there is certainly
risk. Let's evaluate the risk by breaking it down into two problems
that IOMMUs are supposed to be protecting us against:

Case 1: IOMMUs prevent malicious code running on the peripheral (maybe
a malicious peripheral or maybe someone exploited a benign peripheral)
from turning into an exploit of the Linux kernel. This is particularly
important if the peripheral has loadable / updatable firmware or if
the peripheral has some type of general purpose processor and is
processing untrusted inputs. It's also important if the device is
something that can be easily plugged into the host and the device has
direct DMA access itself, like a PCIe device.

Case 2: IOMMUs limit the severity of a class of software bugs in the
kernel. If we misconfigure a peripheral by accident then instead of
the peripheral clobbering random memory due to a bug we might get an
IOMMU error.

Now that we understand the issue and the risks, let's evaluate whether
we really need "strict" mode for the Qualcomm SDHCI controllers. I
will make the argument that we don't _need_ strict mode for them. Why?
* The SDHCI controller on Qualcomm SoCs doesn't appear to have
  loadable / updatable firmware and, assuming it's got some firmware
  baked into it, I see no evidence that the firmware could be
  compromised.
* Even though, for external SD cards in particular, the controller is
  dealing with "untrusted" inputs, it's dealing with them in a very
  controlled way.  It seems unlikely that a rogue SD card would be
  able to present something to the SDHCI controller that would cause
  it to DMA to/from an address other than one the kernel told it
  about.
* Although it would be nice to catch more software bugs, once the
  Linux driver has been debugged and stressed the value is not very
  high. If the IOMMU caught something like this the system would be in
  a pretty bad shape anyway (we don't really recover from IOMMU
  errors) and the only benefit would be a better spotlight on what
  went wrong.

Now we have a good understanding of the benefits of "strict" mode for
our SDHCI controllers, let's look at some performance numbers. I used
"dd" to measure read speeds from eMMC on a sc7180-trogdor-lazor
board. Basic test command (while booted from USB):
  echo 3 > /proc/sys/vm/drop_caches
  dd if=/dev/mmcblk1 of=/dev/null bs=4M count=512

I attempted to run my tests for enough iterations that results
stabilized and weren't too noisy. Tests were run with patches picked
to the chromeos-5.4 tree (sanity checked against v5.13-rc7). I also
attempted to compare to other attempts to address IOMMU problems
and/or attempts to bump the cpufreq up to solve this problem:
- eMMC datasheet spec: 300 MB/s "Typical Sequential Performance"
  NOTE: we're driving the bus at 192 MHz instead of 200 Mhz so we might
  not be able to achieve the full 300 MB/s.
- Baseline: 210.9 MB/s
- Baseline + peg cpufreq to max: 284.3 MB/s
- This patch: 279.6 MB/s
- This patch + peg cpufreq to max: 288.1 MB/s
- Joel's IO Wait fix [1]: 258.4 MB/s
- Joel's IO Wait fix [1] + peg cpufreq to max: 287.8 MB/s
- TLBIVA patches [2] + [3]: 214.7 MB/s
- TLBIVA patches [2] + [3] + peg cpufreq to max: 285.7 MB/s
- This patch plus Joel's [1]: 280.2 MB/s
- This patch plus Joel's [1] + peg...: 279.0 MB/s
  NOTE: I suspect something in the system was thermal throttling since
  there's a heat wave right now.

I also spent a little bit of time trying to see if I could get the
IOMMU flush for MMC out of the critical path but was unable to figure
out how to do this and get good performance.

Overall I'd say that the performance results above show:
* It's really not straightforward to point at "one thing" that is
  making our eMMC performance bad.
* It's certainly possible to get pretty good eMMC performance even
  without this patch.
* This patch makes it much easier to get good eMMC performance.
* No other solutions that I found resulted in quite as good eMMC
  performance as having this patch.

Given all the above (security safety concerns are minimal and it's a
nice performance win), I'm proposing that running SDHCI on Qualcomm
SoCs in non-strict mode is the right thing to do until such point in
time as someone can come up with a better solution to get good SD/eMMC
performance without it.

NOTES:
* It's likely that arguments similar to the above can be made for
  other SDHCI controllers. However, given that this is something that
  can have an impact on security it feels like we want each SDHCI
  controller to opt-in. I believe it is conceivable, for instance,
  that some SDHCI controllers might have loadable or updatable
  firmware.
* It's also likely other peripherals will want this to get the quick
  performance win. That also should be fine, though anyone landing a
  similar patch should be very careful that it is low risk for all
  users of a given peripheral.
* Conceivably if even this patch is considered too "high risk", we
  could limit this to just non-removable cards (like eMMC) by just
  checking the device tree. This is one nice advantage of using the
  pre_probe() to set this.

[1] https://lore.kernel.org/r/20210618040639.3113489-1-joel@joelfernandes.org
[2] https://lore.kernel.org/r/1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com/
[3] https://lore.kernel.org/r/cover.1623981933.git.saiprakash.ranjan@codeaurora.org/

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/mmc/host/sdhci-msm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mmc/host/sdhci-msm.c b/drivers/mmc/host/sdhci-msm.c
index e44b7a66b73c..33ef5e6941d7 100644
--- a/drivers/mmc/host/sdhci-msm.c
+++ b/drivers/mmc/host/sdhci-msm.c
@@ -2465,6 +2465,13 @@ static inline void sdhci_msm_get_of_property(struct platform_device *pdev,
 }
 
 
+static int sdhci_msm_pre_probe(struct device *dev)
+{
+	dev->request_non_strict_iommu = true;
+
+	return 0;
+}
+
 static int sdhci_msm_probe(struct platform_device *pdev)
 {
 	struct sdhci_host *host;
@@ -2811,6 +2818,7 @@ static struct platform_driver sdhci_msm_driver = {
 		   .of_match_table = sdhci_msm_dt_match,
 		   .pm = &sdhci_msm_pm_ops,
 		   .probe_type = PROBE_PREFER_ASYNCHRONOUS,
+		   .pre_probe = sdhci_msm_pre_probe,
 	},
 };
 
-- 
2.32.0.288.g62a8d224e6-goog

