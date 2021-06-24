Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 032E33B39A0
	for <lists+linux-pci@lfdr.de>; Fri, 25 Jun 2021 01:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229585AbhFXXIP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 19:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbhFXXIO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 19:08:14 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21A21C061756
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 16:05:55 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id w26so6127498qto.13
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 16:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OVGe70VQ7Bofs1GsJDbN4DH060Z/5/8km4zQo9PX9Z0=;
        b=MJhioia1IT1d05V8QLP3QAmMcl+n8b0r3nyXI6yDlQGvUP4e4uWfsLU9g1lixGxL3Z
         kErmOg59tZQv9l36Vky1BEm/+e9ro4cQkf8kOWUVvdZ7eB4ypM9aK3Ej15JburBfyZH6
         qOSnyreGroIMvqSgeVo0p2f02c4xlHSOHXvIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVGe70VQ7Bofs1GsJDbN4DH060Z/5/8km4zQo9PX9Z0=;
        b=BWQV3J1hxaZEjeTU6LexFBKATZNRSGi53WYN5aLS3p/leo3Z7oAdTbDwWgtFfaVvGB
         CnpTwVdBJAp2kR4MFlxx0Zz3ae+9qNNtThq1YN+Rpt0uN49197O1S08DqdmW8AtRbPl/
         /KwYAaREGoHFgOtUiei37zrP0B7QlBuvqf1zXcVtnqqLLX/vStLJBxjNLPlZKb/3Idox
         TQdNlzKO+FmPbGRRZLoVFtVQCCmGfen9Yw9dtKCKboTOVDWkrfGRSSCRxgzpjVLTsTvi
         e95gTXgZ+aPLNIP58PRD3bX8BPgfftfHQK4oaGS/SKGxxczuTrNZWLLLsvYegj+p9QXp
         6dhw==
X-Gm-Message-State: AOAM530xRUM8Sp/w2lTF4m85GCNGFQBaD+pOyOuFLEY0aKFPevelppDm
        1UD2KjgXSGudrMRrNPMDuJHbdU/lpTLVqw==
X-Google-Smtp-Source: ABdhPJzG1ihRx8iw9Np+IJGLwOM9gXMCUaTF0+Ez2FPtYDwaYCyMAEcJto+NVn14FFpcgvLuIt46Vg==
X-Received: by 2002:ac8:75c8:: with SMTP id z8mr6968981qtq.300.1624575953754;
        Thu, 24 Jun 2021 16:05:53 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id d20sm2798665qtw.92.2021.06.24.16.05.52
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Jun 2021 16:05:53 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id d76so1779490ybc.12
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 16:05:52 -0700 (PDT)
X-Received: by 2002:a25:8082:: with SMTP id n2mr8357075ybk.79.1624575952073;
 Thu, 24 Jun 2021 16:05:52 -0700 (PDT)
MIME-Version: 1.0
References: <20210624171759.4125094-1-dianders@chromium.org> <20210624101557.v2.3.Icde6be7601a5939960caf802056c88cd5132eb4e@changeid>
In-Reply-To: <20210624101557.v2.3.Icde6be7601a5939960caf802056c88cd5132eb4e@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Jun 2021 16:05:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Uf3U-kC5j_g7FB6U6_Qf2PVwKJfEsB-b+bVydW4eLymg@mail.gmail.com>
Message-ID: <CAD=FV=Uf3U-kC5j_g7FB6U6_Qf2PVwKJfEsB-b+bVydW4eLymg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] mmc: sdhci-msm: Request non-strict IOMMU mode
To:     Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     John Garry <john.garry@huawei.com>,
        Rob Clark <robdclark@chromium.org>, quic_c_gdjako@quicinc.com,
        Saravana Kannan <saravanak@google.com>,
        Rajat Jain <rajatja@google.com>,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Veerabhadrarao Badiganti <vbadigan@codeaurora.org>,
        Linux MMC List <linux-mmc@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        linux-pci@vger.kernel.org,
        "list@263.net:IOMMU DRIVERS <iommu@lists.linux-foundation.org>, Joerg
        Roedel <joro@8bytes.org>," <iommu@lists.linux-foundation.org>,
        Sonny Rao <sonnyrao@chromium.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jordan Crouse <jordan@cosmicpenguin.net>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On Thu, Jun 24, 2021 at 10:18 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> The concept of IOMMUs being in strict vs. non-strict mode is a
> pre-existing Linux concept. I've included a rough summary here to help
> evaluate this patch.
>
> IOMMUs can be run in "strict" mode or in "non-strict" mode. The
> quick-summary difference between the two is that in "strict" mode we
> wait until everything is flushed out when we unmap DMA memory. In
> "non-strict" we don't.
>
> Using the IOMMU in "strict" mode is more secure/safer but slower
> because we have to sit and wait for flushes while we're unmapping. To
> explain a bit why "non-strict" mode is unsafe, let's imagine two
> examples.
>
> An example of "non-strict" being insecure when reading from a device:
> a) Linux driver maps memory for DMA.
> b) Linux driver starts DMA on the device.
> c) Device write to RAM subject to bounds checking done by IOMMU.
> d) Device finishes writing to RAM and signals transfer is finished.
> e) Linux driver starts unmapping DMA memory but doesn't wait for the
>    unmap to finish (the definition of non-strict). At this point,
>    though, the Linux APIs say that the driver owns the memory and
>    shouldn't expect any more scribbling from the DMA device.
> f) Linux driver validates that the data in memory looks sane and that
>    accessing it won't cause the driver to, for instance, overflow a
>    buffer.
> g) Device takes advantage of knowledge of how the Linux driver works
>    and sneaks in a modification to the data after the validation but
>    before the IOMMU unmap flush finishes.
> h) Device has now caused the Linux driver to access memory it
>    shouldn't.
>
> An example of "non-strict" being insecure when writing to a device:
> a) Linux driver writes data intended for the device to RAM.
> b) Linux driver maps memory for DMA.
> c) Linux driver starts DMA on the device.
> d) Device reads from RAM subject to bounds checking done by IOMMU.
> e) Device finishes reading from RAM and signals transfer is finished.
> f) Linux driver starts unmapping DMA memory but doesn't wait for the
>    unmap to finish (the definition of non-strict)
> g) Linux driver frees memory and returns it to the pool of memory
>    available for other users to allocate.
> h) Memory is allocated for another purpose since it was free memory.
> i) Device takes advantage of the period of time before IOMMU flush to
>    read memory that it shouldn't have had access to. What exactly the
>    memory could contain depends on the randomness of who allocated
>    next, though exploits have been built on flimisier holes.
>
> As you can see from the above examples, using the iommu in
> "non-strict" mode might not sound _too_ scary (the window of badness
> is small and the exposed memory is small) but there is certainly
> risk. Let's evaluate the risk by breaking it down into two problems
> that IOMMUs are supposed to be protecting us against:
>
> Case 1: IOMMUs prevent malicious code running on the peripheral (maybe
> a malicious peripheral or maybe someone exploited a benign peripheral)
> from turning into an exploit of the Linux kernel. This is particularly
> important if the peripheral has loadable / updatable firmware or if
> the peripheral has some type of general purpose processor and is
> processing untrusted inputs. It's also important if the device is
> something that can be easily plugged into the host and the device has
> direct DMA access itself, like a PCIe device.
>
> Case 2: IOMMUs limit the severity of a class of software bugs in the
> kernel. If we misconfigure a peripheral by accident then instead of
> the peripheral clobbering random memory due to a bug we might get an
> IOMMU error.
>
> Now that we understand the issue and the risks, let's evaluate whether
> we really need "strict" mode for the Qualcomm SDHCI controllers. I
> will make the argument that we don't _need_ strict mode for them. Why?
> * The SDHCI controller on Qualcomm SoCs doesn't appear to have
>   loadable / updatable firmware and, assuming it's got some firmware
>   baked into it, I see no evidence that the firmware could be
>   compromised.
> * Even though, for external SD cards in particular, the controller is
>   dealing with "untrusted" inputs, it's dealing with them in a very
>   controlled way.  It seems unlikely that a rogue SD card would be
>   able to present something to the SDHCI controller that would cause
>   it to DMA to/from an address other than one the kernel told it
>   about.
> * Although it would be nice to catch more software bugs, once the
>   Linux driver has been debugged and stressed the value is not very
>   high. If the IOMMU caught something like this the system would be in
>   a pretty bad shape anyway (we don't really recover from IOMMU
>   errors) and the only benefit would be a better spotlight on what
>   went wrong.
>
> Now we have a good understanding of the benefits of "strict" mode for
> our SDHCI controllers, let's look at some performance numbers. I used
> "dd" to measure read speeds from eMMC on a sc7180-trogdor-lazor
> board. Basic test command (while booted from USB):
>   echo 3 > /proc/sys/vm/drop_caches
>   dd if=/dev/mmcblk1 of=/dev/null bs=4M count=512
>
> I attempted to run my tests for enough iterations that results
> stabilized and weren't too noisy. Tests were run with patches picked
> to the chromeos-5.4 tree (sanity checked against v5.13-rc7). I also
> attempted to compare to other attempts to address IOMMU problems
> and/or attempts to bump the cpufreq up to solve this problem:
> - eMMC datasheet spec: 300 MB/s "Typical Sequential Performance"
>   NOTE: we're driving the bus at 192 MHz instead of 200 Mhz so we might
>   not be able to achieve the full 300 MB/s.
> - Baseline: 210.9 MB/s
> - Baseline + peg cpufreq to max: 284.3 MB/s
> - This patch: 279.6 MB/s
> - This patch + peg cpufreq to max: 288.1 MB/s
> - Joel's IO Wait fix [1]: 258.4 MB/s
> - Joel's IO Wait fix [1] + peg cpufreq to max: 287.8 MB/s
> - TLBIVA patches [2] + [3]: 214.7 MB/s
> - TLBIVA patches [2] + [3] + peg cpufreq to max: 285.7 MB/s
> - This patch plus Joel's [1]: 280.2 MB/s
> - This patch plus Joel's [1] + peg...: 279.0 MB/s
>   NOTE: I suspect something in the system was thermal throttling since
>   there's a heat wave right now.
>
> I also spent a little bit of time trying to see if I could get the
> IOMMU flush for MMC out of the critical path but was unable to figure
> out how to do this and get good performance.
>
> Overall I'd say that the performance results above show:
> * It's really not straightforward to point at "one thing" that is
>   making our eMMC performance bad.
> * It's certainly possible to get pretty good eMMC performance even
>   without this patch.
> * This patch makes it much easier to get good eMMC performance.
> * No other solutions that I found resulted in quite as good eMMC
>   performance as having this patch.
>
> Given all the above (security safety concerns are minimal and it's a
> nice performance win), I'm proposing that running SDHCI on Qualcomm
> SoCs in non-strict mode is the right thing to do until such point in
> time as someone can come up with a better solution to get good SD/eMMC
> performance without it.
>
> Now that we've decided we want the SD/MMC controller in non-strict
> mode, we need to figure out how to make it happen. We will take
> advantage of the fact that on Qualcomm IOMMUs we know that SD/MMC
> controllers are in a domain by themselves and hook in when initting
> the domain context. In response to a previous version of this series
> there had been discussion [4] of having this driven from a device tree
> property and this solution doesn't preclude that but is a good jumping
> off point.
>
> NOTES:
> * It's likely that arguments similar to the above can be made for
>   other SDHCI controllers. However, given that this is something that
>   can have an impact on security it feels like we want each SDHCI
>   controller to opt-in. I believe it is conceivable, for instance,
>   that some SDHCI controllers might have loadable or updatable
>   firmware.
> * It's also likely other peripherals will want this to get the quick
>   performance win. That also should be fine, though anyone landing a
>   similar patch should be very careful that it is low risk for all
>   users of a given peripheral.
> * Conceivably if even this patch is considered too "high risk", we
>   could limit this to just non-removable cards (like eMMC) by just
>   checking the device tree. This is one nice advantage of using the
>   pre_probe() to set this.
>
> [1] https://lore.kernel.org/r/20210618040639.3113489-1-joel@joelfernandes.org
> [2] https://lore.kernel.org/r/1623850736-389584-1-git-send-email-quic_c_gdjako@quicinc.com/
> [3] https://lore.kernel.org/r/cover.1623981933.git.saiprakash.ranjan@codeaurora.org/
> [4] https://lore.kernel.org/r/20210621235248.2521620-1-dianders@chromium.org
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Now accomplish the goal by putting rules in the IOMMU driver.
> - Reworded commit message to clarify things pointed out by Greg.
>
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)

Ugh, I really miffed up ${SUBJECT}. I thought I had fixed it to the
proper iommu prefix but clearly I didn't. :(


> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index 98b3a1c2a181..bd66376d21ce 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -172,6 +172,24 @@ static const struct of_device_id qcom_smmu_client_of_match[] __maybe_unused = {
>         { }
>  };
>
> +static const struct of_device_id qcom_smmu_nonstrict_of_match[] __maybe_unused = {
> +       { .compatible = "qcom,sdhci-msm-v4" },
> +       { .compatible = "qcom,sdhci-msm-v5" },
> +       { }
> +};

I will note that I've done more testing and I've also found that I get
a really nice USB performance win with a similar change there. I have
run as many variety of tests there, but atop the patches that are
already in the chromeos-5.4 tree (which includes Joel's io wait patch)
I saw an "dd" from a USB 3.0 SD card reader (with a fast card) go from
~74 MB/s to ~86 MB/s by adding "snps,dwc3".

I believe that the USB controller is a more complicated beast than the
SDHCI controller so perhaps it's harder to have quite as much
confidence in it, but it still does technically fulfil the
requirements above.

I'd also say that since it appears that both Intel and AMD IOMMU
drivers appear to default to non-strict for anything that's not an
external PCI device that we could probably default to non-secure for
dwc3 as well. I'll include a 4th patch in the next version of this
series assuming that the series as a whole isn't NAKed.

-Doug
