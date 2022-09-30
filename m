Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C02245F14DA
	for <lists+linux-pci@lfdr.de>; Fri, 30 Sep 2022 23:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbiI3V3T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 30 Sep 2022 17:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbiI3V3R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 30 Sep 2022 17:29:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0499D1CD12D;
        Fri, 30 Sep 2022 14:29:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DE04B6250C;
        Fri, 30 Sep 2022 21:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C5BCC433D7;
        Fri, 30 Sep 2022 21:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664573351;
        bh=NTTzbJJF9X0vGnGIOc251ZTkuAM+HSF5NjtXEgtJH7U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=jliIKOzU1kBvM2I7e1wo4JNOFsRwJLQp8ZslYaGwaCIC8OyOpyGwLmC42NIsKCt0Y
         i2b4cS3e85QCn/F9oImHNLczIqv2u2uBTXoDv/82ZJpQudDwTEY7IzsewqsfVDI/pG
         sRZKvSAiIdfSER+zCh4VHhbygQhlwRibiPx+5/kwbtwGzgpHmjj5buI9hvE9t8F0/v
         QjVFvHsxau7XrU+qBPmPaesikAgwGGZjf15FrpxMgmr3pMz9elNIvtub1Pj+SWXeYW
         H60CFFjfbZDZsRHcIE2wfuJeA75iN+WZl/sg6j9b0sJ09feVDAhWarPYgse9D4qPxU
         CVcMXfq4kXVFQ==
Date:   Fri, 30 Sep 2022 16:29:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, mka@chromium.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, manivannan.sadhasivam@linaro.org,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v7] PCI/ASPM: Update LTR threshold based upon reported
 max latencies
Message-ID: <20220930212909.GA1923173@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663315719-21563-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 16, 2022 at 01:38:37PM +0530, Krishna chaitanya chundru wrote:
> In ASPM driver, LTR threshold scale and value are updated based on
> tcommon_mode and t_poweron values. In Kioxia NVMe L1.2 is failing due to
> LTR threshold scale and value are greater values than max snoop/non-snoop
> value.
>
> Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
> reported snoop/no-snoop values is greater than or equal to
> LTR_L1.2_THRESHOLD value.

I find LTR configuration pretty much impenetrable, but this doesn't
seem right to me.  If I understand correctly, LTR messages are a way
for endpoints to report their latency requirements, i.e., sort of a
dynamic version of "Endpoint L1 Acceptable Latency".

As you said, a comparison between the most recent LTR value and
LTR_L1.2_THESHOLD determines whether the link goes to L1.1 or L1.2.

So I assume LTR_L1.2_THESHOLD must be the minimum time required to
transition the link from L0 to L1.2 and back to L0, which includes
T_POWER_OFF, T_L1.2, T_POWER_ON, and T_COMMONMODE (sec 5.5.3.3.1,
5.5.5).

If the device can tolerate at least that much time, i.e., if the
LTR value >= LTR_L1.2_THESHOLD, the link should go to L1.2.

I'm not a hardware person, but I don't see how LTR_L1.2_THESHOLD can
*depend* on the LTR max latency values.  The LTR max latencies depend
on the endpoint.  I think LTR_L1.2_THESHOLD depends on the circuit
design of both ends of the link.

More comments below, but they're only pertinent if we can figure out
that this is the correct approach.

Bjorn

> Signed-off-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> I am taking this patch forward as prasad is no more working with our org.
> changes since v6:
> 	- Rebasing with pci/next.

It's best if you base patches on my "main" branch (not "next"), which
is typically -rc1, unless they depend on something that's already been
merged.

In the patch below, rewrap so everything still fits in 80 columns like
the rest of the file.

Update citations to current spec version (r6.0).  It looks like the
section numbers are the same.

> changes since v5:
> 	- no changes, just reposting as standalone patch instead of reply to
> 	  previous patch.
> Changes since v4:
> 	- Replaced conditional statements with min and max.
> changes since v3:
> 	- Changed the logic to include this condition "snoop/nosnoop
> 	  latencies are not equal to zero and lower than LTR_L1.2_THRESHOLD"
> Changes since v2:
> 	- Replaced LTRME logic with max snoop/no-snoop latencies check.
> Changes since v1:
> 	- Added missing variable declaration in v1 patch
> ---
>  drivers/pci/pcie/aspm.c | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 928bf64..2bb8470 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -486,13 +486,35 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  {
>  	struct pci_dev *child = link->downstream, *parent = link->pdev;
>  	u32 val1, val2, scale1, scale2;
> +	u32 max_val, max_scale, max_snp_scale, max_snp_val, max_nsnp_scale, max_nsnp_val;
>  	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
>  	u32 ctl1 = 0, ctl2 = 0;
>  	u32 pctl1, pctl2, cctl1, cctl2;
> +	u16 ltr;
> +	u16 max_snoop_lat, max_nosnoop_lat;
>  
>  	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
>  		return;
>  
> +	ltr = pci_find_ext_capability(child, PCI_EXT_CAP_ID_LTR);
> +	if (!ltr)
> +		return;
> +
> +	pci_read_config_word(child, ltr + PCI_LTR_MAX_SNOOP_LAT, &max_snoop_lat);
> +	pci_read_config_word(child, ltr + PCI_LTR_MAX_NOSNOOP_LAT, &max_nosnoop_lat);
> +
> +	max_snp_scale = (max_snoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
> +	max_snp_val = max_snoop_lat & PCI_LTR_VALUE_MASK;
> +
> +	max_nsnp_scale = (max_nosnoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
> +	max_nsnp_val = max_nosnoop_lat & PCI_LTR_VALUE_MASK;
> +
> +	/* choose the greater max scale value between snoop and no snoop value*/

Add space before */

Capitalize comments to match style of file.

> +	max_scale = max(max_snp_scale, max_nsnp_scale);
> +
> +	/* choose the greater max value between snoop and no snoop scales */
> +	max_val = max(max_snp_val, max_nsnp_val);
> +
>  	/* Choose the greater of the two Port Common_Mode_Restore_Times */
>  	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
>  	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> @@ -525,6 +547,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  	 */
>  	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
>  	encode_l12_threshold(l1_2_threshold, &scale, &value);
> +
> +	/*
> +	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
> +	 * snoop/no-snoop values are greater than or equal to LTR_L1.2_THRESHOLD value.
> +	 */
> +	scale = min(scale, max_scale);
> +	value = min(value, max_val);

I don't think this computes the right thing.  If we have this:

  scale = 001b (x 32ns)
  value = 1024
  max_scale = 010b (x 1024ns)
  max_value = 1

Then the latencies are both 1024ns, so I would expect a min() of
1024ns.  But computing min() separately for the scale and value will
give "scale = 001b" (x 32ns) and "value = 1", for a latency of 32ns.

I think you would need to compare the values in ns, i.e.,
"l1_2_threshold".

I assume the max() computations above have a similar issue, but I
didn't work it out.

But I'm not convinced that this is the right approach to begin with.

>  	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
>  
>  	/* Some broken devices only support dword access to L1 SS */
> -- 
> 2.7.4
> 
