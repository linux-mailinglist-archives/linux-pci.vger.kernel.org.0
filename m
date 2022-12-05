Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB2264276E
	for <lists+linux-pci@lfdr.de>; Mon,  5 Dec 2022 12:25:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbiLELZX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 5 Dec 2022 06:25:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiLELZN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 5 Dec 2022 06:25:13 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D5C186C0
        for <linux-pci@vger.kernel.org>; Mon,  5 Dec 2022 03:25:12 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id p24so10508686plw.1
        for <linux-pci@vger.kernel.org>; Mon, 05 Dec 2022 03:25:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gzsdjxu1gCYjvJoIlo2hP0aqa93HSENNGWpI+E9CGjY=;
        b=tpEexnwFRGkb1KbxPqMlTsJTN39PCdViVwSkP+44hJ3ZBeWB0EN2OMM7+5CGpPJwtR
         /8g29P8Z0iMyn2lm4gpDXh71eHjlPjOqqLtTXXZqBXOHoVnxT/iDSEj7DCWKICi8lJ2K
         0z6HxAOeG0RZkuAD8nLcc6R8JXTa/uvNfusKhgJAi3PWZ6ei5wLgOa5fGULQd5jQ4fWh
         LxDbZ4t+mZ/Pn1Tcv3f8IMflRXy6Nwd3Tbg3WX6Ui+2aujxkCWmGEpNvmK6KYUxzTYqs
         IugI6EY5XKFMmy4QkKNEOSwWTT8MiLGRfiYrOUFLAt8J5Yf+1uj8RhZ9m5PBGx6uHHMw
         AYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gzsdjxu1gCYjvJoIlo2hP0aqa93HSENNGWpI+E9CGjY=;
        b=mGK5WZNUYa3td6Xl8PysRq8F/bRktSwC2/svhXxcdzNutmdgp5jbsDLoGXt3wtqqVQ
         b7H33bgbD2+bzOWopIxb7VWLjc6keHEIIxydnOgLtX8bjn5VrJKyFpVmOBCACZSpOlyX
         /6yRBpCg4cpLn3fGE4gskp8RKSzLAfbfaHL+B1R0C1leWB20gkK5t9bu0Lrnw3wsoQh3
         1YZcbKu3Q6MCICs+ElIibcunUGlEOFD4Gm+Fo+rKAOaS1yx4CcXnD1Oaa3d10I/9lu8g
         xD0dO050Z2llh6v/vgObh8GSUbWFQYmnkElHM+eowNAlPxgMa6gjaNPmZ+Se8v91n5Vl
         hywg==
X-Gm-Message-State: ANoB5pmv314oQWXk5MsYR6RFHoBQL0oGLBKMu5SusgwnYPAVpUj3opW2
        Y7meDZPuk2ArkMrEr/y6qTmm
X-Google-Smtp-Source: AA0mqf5ePvaf+hXy28SJC//Y9oswW/nXG7qCNktZ4juFM9qAKAeXrVbbhPSSXUvOrFbS1BFP6RJeNA==
X-Received: by 2002:a17:902:be17:b0:188:fbc5:b734 with SMTP id r23-20020a170902be1700b00188fbc5b734mr64659678pls.170.1670239511659;
        Mon, 05 Dec 2022 03:25:11 -0800 (PST)
Received: from thinkpad ([59.92.98.136])
        by smtp.gmail.com with ESMTPSA id bd12-20020a170902830c00b001894198d0ebsm10317639plb.24.2022.12.05.03.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 03:25:10 -0800 (PST)
Date:   Mon, 5 Dec 2022 16:55:00 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v7] PCI/ASPM: Update LTR threshold based upon reported
 max latencies
Message-ID: <20221205112500.GB4514@thinkpad>
References: <1663315719-21563-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1663315719-21563-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

I take my Ack back... Sorry that I did not look into this patch closer.

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

Apart from the bug in calculating the LTR_Threshold as reported by Matthias
and Bjorn, I'm wondering if we are covering up for the device firmware issue.

As per section 6.18, if the device reports snoop/no-snoop scale/value as 0, then
it implies that the device won't tolerate any additional delays from the host.

In that case, how can we allow the link to go into L1.2 since that would incur
high delay compared to L1.1?

Thanks,
Mani

> +	 */
> +	scale = min(scale, max_scale);
> +	value = min(value, max_val);
> +
>  	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
>  
>  	/* Some broken devices only support dword access to L1 SS */
> -- 
> 2.7.4
> 

-- 
மணிவண்ணன் சதாசிவம்
