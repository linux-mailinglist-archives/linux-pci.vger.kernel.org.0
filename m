Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595503B34A2
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 19:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbhFXRU7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 13:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232416AbhFXRUw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 13:20:52 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96467C0617AD
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 10:18:31 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id z3-20020a17090a3983b029016bc232e40bso3895342pjb.4
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 10:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nkeWCBI+uU/7cGiyR8KqX3jtouOj5+BeMGH/nCx1Gq8=;
        b=Ayx3KtOrfzrF668/PdjmLpf7tQlp6VlbptxTyKHq7GsvYQIJPQY5qKMrWpc9iYrXjR
         kUJX4rrZWID0zFM5jzuOxvaqFCw8/SZ/SXf6IwfZ9urvuDnhdrQFQCEb2gseUY8BXV7p
         KwbwUAVnc+MiyP4GgT8glTY6U/l2S8y2wDwOU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nkeWCBI+uU/7cGiyR8KqX3jtouOj5+BeMGH/nCx1Gq8=;
        b=uVXHFS8IJQZO54oXJfVnfCpwSk9Fyjdx6Srp9mgo+tMo+C79Hi4XOQy8ZUFJNzGYEX
         r8EHxwmy5hN2018VvNvRqlarfg43tW66XpQp3FwzMLDks4luVcjZFNt4m+3qC4O206Ze
         VqaGCQHBP6q2wP08RCOZgfnMf1Bml0vkKrhXyo5WaypCJeJxVu9BOsw4c4g8pSl/N33l
         9Ei5qouf11OPYkN4zao3IR4ud9g2aFbDJt1Rm3jHB6mVeJMLnsHiitSrRR5E1f6hlCRs
         giQrxUukvRIr3XRjFSdEG1iMuyX0N/rUaL4R+z87nXrzWcIgqm7sFiGT6N8qYHfUGMv2
         RTxg==
X-Gm-Message-State: AOAM532RG2mbc4NPGSqJNU5L87qzM80hEsdp6+BlL3Z9TiZw+cJwVe05
        omZsQtxTe7k+CA57hvAvFQbNww==
X-Google-Smtp-Source: ABdhPJyh24ZBk4IyfzZyEkgHlKXR3pzQ1j5uOTe/6sAHkvrmVGAJ4JM61YDjzhKl8PSKbPF0E6Cx2A==
X-Received: by 2002:a17:90a:8c4:: with SMTP id 4mr16092152pjn.82.1624555111053;
        Thu, 24 Jun 2021 10:18:31 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:201:fd74:62bc:19e3:a43b])
        by smtp.gmail.com with ESMTPSA id z9sm3365960pfa.2.2021.06.24.10.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 10:18:30 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     will@kernel.org, robin.murphy@arm.com, joro@8bytes.org,
        bjorn.andersson@linaro.org, ulf.hansson@linaro.org,
        adrian.hunter@intel.com, bhelgaas@google.com
Cc:     john.garry@huawei.com, robdclark@chromium.org,
        quic_c_gdjako@quicinc.com, saravanak@google.com,
        rajatja@google.com, saiprakash.ranjan@codeaurora.org,
        vbadigan@codeaurora.org, linux-mmc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        iommu@lists.linux-foundation.org, sonnyrao@chromium.org,
        joel@joelfernandes.org, Douglas Anderson <dianders@chromium.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] mmc: sdhci-msm: Request non-strict IOMMU mode
Date:   Thu, 24 Jun 2021 10:17:59 -0700
Message-Id: <20210624101557.v2.3.Icde6be7601a5939960caf802056c88cd5132eb4e@changeid>
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
In-Reply-To: <20210624171759.4125094-1-dianders@chromium.org>
References: <20210624171759.4125094-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The concept of IOMMUs being in strict vs. non-strict mode is a
pre-existing Linux concept. I've included a rough summary here to help
evaluate this patch.

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
e) Linux driver starts unmapping DMA memory but doesn't wait for the
   unmap to finish (the definition of non-strict). At this point,
   though, the Linux APIs say that the driver owns the memory and
   shouldn't expect any more scribbling from the DMA device.
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
f) Linux driver starts unmapping DMA memory but doesn't wait for the
   unmap to finish (the definition of non-strict)
g) Linux driver frees memory and returns it to the pool of memory
   available for other users to allocate.
h) Memory is allocated for another purpose since it was free memory.
i) Device takes advantage of the period of time before IOMMU flush to
   read memory that it shouldn't have had access to. What exactly the
   memory could contain depends on the randomness of who allocated
   next, though exploits have been built on flimisier holes.

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

Now that we've decided we want the SD/MMC controller in non-strict
mode, we need to figure out how to make it happen. We will take
advantage of the fact that on Qualcomm IOMMUs we know that SD/MMC
controllers are in a domain by themselves and hook in when initting
the domain context. In response to a previous version of this series
there had been discussion [4] of having this driven from a device tree
property and this solution doesn't preclude that but is a good jumping
off point.

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
[4] https://lore.kernel.org/r/20210621235248.2521620-1-dianders@chromium.org

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2:
- Now accomplish the goal by putting rules in the IOMMU driver.
- Reworded commit message to clarify things pointed out by Greg.

 drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
index 98b3a1c2a181..bd66376d21ce 100644
--- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
+++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
@@ -172,6 +172,24 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
 	{ }
 };
 
+static const struct of_device_id qcom_smmu_nonstrict_of_match[] __maybe_unused = {
+	{ .compatible = "qcom,sdhci-msm-v4" },
+	{ .compatible = "qcom,sdhci-msm-v5" },
+	{ }
+};
+
+static int qcom_smmu_init_context(struct arm_smmu_domain *smmu_domain,
+		struct io_pgtable_cfg *pgtbl_cfg, struct device *dev)
+{
+	const struct of_device_id *match =
+		of_match_device(qcom_smmu_nonstrict_of_match, dev);
+
+	if (match)
+		smmu_domain->domain.strictness = IOMMU_NOT_STRICT;
+
+	return 0;
+}
+
 static int qcom_smmu_cfg_probe(struct arm_smmu_device *smmu)
 {
 	unsigned int last_s2cr = ARM_SMMU_GR0_S2CR(smmu->num_mapping_groups - 1);
@@ -295,6 +313,7 @@ static int qcom_smmu500_reset(struct arm_smmu_device *smmu)
 }
 
 static const struct arm_smmu_impl qcom_smmu_impl = {
+	.init_context = qcom_smmu_init_context,
 	.cfg_probe = qcom_smmu_cfg_probe,
 	.def_domain_type = qcom_smmu_def_domain_type,
 	.reset = qcom_smmu500_reset,
-- 
2.32.0.93.g670b81a890-goog

