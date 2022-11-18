Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2531062FECF
	for <lists+linux-pci@lfdr.de>; Fri, 18 Nov 2022 21:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbiKRU1f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 15:27:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbiKRU1e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 15:27:34 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FACA13C
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 12:27:34 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id p184so4665381iof.11
        for <linux-pci@vger.kernel.org>; Fri, 18 Nov 2022 12:27:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j6b228sSBdmEe622PJPDcidu4wKiIoq5NrJur1C1NIQ=;
        b=Rp2BQyogGJZQ7ZJZU5zktR/shwNgmYdk+YIhpqwuoI1mEaAsPi6k4IGEGidbqcsErp
         0amawcgipK1ioOyWiU/787JHnl9fgdRHjZv9gQE+OL3KOGlcI8HWVTbO9eAtWkRm+PYU
         EDs8AG73P2oeMBc/EOKlKeCXmggbkHjUzGX14=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j6b228sSBdmEe622PJPDcidu4wKiIoq5NrJur1C1NIQ=;
        b=N1eoHU8WFrI/1SwS5I7aSgaIUOe866G67yGAuvoHhaF5SvW8J9734fXJRg89vIfruN
         F14202HPNy92ii2DsaqDeWMhct6c1dBC0FQBmLjJwRAGtExJvBBP2DRr2bWUOelPZqiU
         fs2DiIILhzrNHGVhfwpvX+3cbu0EebBVFersI4nK8ChmvGRzvLaLpXKvWw3EPYu/mheD
         6eaZPsRRd8V5/F6diKJBQ7EJMTb22LeJGc/JG5H3LVv1iSmgG4HHYow5CabHgAgjwV9l
         lxu++S8MV9gN6mf2jaBDiulD0+MrZo794qLpXkmUt2YjgEX6JcBt1FXnnA3ZfJDUFXAt
         lqIA==
X-Gm-Message-State: ANoB5pnM3A5+gagc58Ehz03mWVrkmtcKLqIbYzN/jkXAZyQIM0nAlL/l
        eW4jCNJqKaxzWexptp9IPF+B2g==
X-Google-Smtp-Source: AA0mqf7OCpSwusxcSllfX3v77am0db2DyFyUduQIBkL2WKNHjBjLxPzprfSPv7kIZaIu2CsVhWh+LA==
X-Received: by 2002:a5e:df46:0:b0:6bb:e329:fcd7 with SMTP id g6-20020a5edf46000000b006bbe329fcd7mr4127553ioq.206.1668803253589;
        Fri, 18 Nov 2022 12:27:33 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id o8-20020a056e0214c800b002f9f44625fbsm1512925ilk.52.2022.11.18.12.27.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Nov 2022 12:27:33 -0800 (PST)
Date:   Fri, 18 Nov 2022 20:27:32 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Message-ID: <Y3fqtMKzRMAI7ivW@google.com>
References: <1663315719-21563-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1663315719-21563-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
> 
> Signed-off-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> I am taking this patch forward as prasad is no more working with our org.
> changes since v6:
> 	- Rebasing with pci/next.
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
> +	max_scale = max(max_snp_scale, max_nsnp_scale);
> +
> +	/* choose the greater max value between snoop and no snoop scales */
> +	max_val = max(max_snp_val, max_nsnp_val);

I suppose the goal is to dermine the max of snoop/no-snoop latency. Taking the
max of scale and value separately won't yield the correct result when the scale
is different for snoop vs no-snoop. Instead you need to convert scale + value
to ns and determine the max of that (as done for 't_power_on').

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

This is wrong for the same reason as above, as Bjorn also pointed out in an earlier
comment.

Even with the values calculated correctly I'm not sure it this is the right
thing to do, but I know little about LTR. In any case this patch reduces
power consumption of the Kioxia NVMe significantly, essentially by
programming an LTR_L1.2_THRESHOLD of 0ns instead of 86ns.

I just came across Bjorn's recent 'PCI/ASPM: Fix L1SS issues' series [1] that
corrects the LTR_L1.2_THRESHOLD calculation and landed upstream, unfortunately
it doesn't magically fix the issues with the Kioxia NVMe :(

[1] https://lore.kernel.org/lkml/ca836507-50ca-13bc-ef88-7f69b1333c99@linux.intel.com/T/#m3f223b7e582052159de7538bcaf2bea6d2071472
