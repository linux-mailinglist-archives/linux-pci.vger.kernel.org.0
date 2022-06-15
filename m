Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B63CB54D029
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jun 2022 19:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357710AbiFORjq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 13:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348990AbiFORjp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 13:39:45 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDEAB52E69
        for <linux-pci@vger.kernel.org>; Wed, 15 Jun 2022 10:39:43 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id c196so12080163pfb.1
        for <linux-pci@vger.kernel.org>; Wed, 15 Jun 2022 10:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=JIGNx3dxDBXAJBCjmLCOBkusT3zHmoO5EB6WelB8/B4=;
        b=oUnFHZqLgzAe8XdtP8xIy+iktAr8OgZ4tDzEeFSBmBvpgqj5WAhI+pSU3KD2EHL4MU
         Fx70SswIOfEmaDuHutuxmIs8RnsZ5Ask4k7KmE76D6HqBiQFmPX6vJ6Etu3JGb04jsvZ
         0S6FvLFPnTJbFXSqt+DjJZwAKP30H/aWT4wqfQlj2JfFf+6c+T5RC6BCqpgSpJ/DMVTM
         Ak4XK9T5z5jR7V7tC9BYqOyv3Yb3SLxTdK119Ac8ejXjJZ9WQULAo8ZLLMZ6q6Dp+7zJ
         iS2jrR3zlapsYE/y8XadnHxa6za+sH7sOnGte3ZwBME5awCGiRETJliB+l76OoUIILPq
         KaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=JIGNx3dxDBXAJBCjmLCOBkusT3zHmoO5EB6WelB8/B4=;
        b=J9sBkORWWZuUuxhvxqumabPkGOfe6tIWbKTIotvOKH7IPJfsS+YUB/0aVU3facFU82
         IhTMCGg94q9IUvdttyUua/bab6Be9Rrq2X2yK/9mXUnIqGUTYdW2JEjjkqBnHIVzEjNI
         LwSefG9eczXcb+Fcs9D7XBhEJBFVo1G8tPSwePcLo0vmzaN+o0yInBSpYxo2l98oUwGR
         BnNbj50oqFd3/WfzIirFN3GSHNkpwv4EFR6QPePTGox4DnadMiwSJHiOcSVvPGTn7f14
         t7KT2K/ae3W05V1e2LhhE61UIGYKr+aGbevct3beaq1hXdrbJr5a5oYVZpLrVJ8yeMAE
         Ldaw==
X-Gm-Message-State: AJIora9GugUBlDxxSrQZFYK6rWqVrvQZTlT9kJnAXXk3TEHjrWnBFsZq
        xBkj8InXxbxdbm1tReZxc4l5
X-Google-Smtp-Source: AGRyM1vxpaSwdX+YrOVTzPhfpPmR3ZUlbCHDtX94AFzFgX6H6IowGyl2HG3yxhPrt495b2UfJjSbzg==
X-Received: by 2002:a63:1152:0:b0:3fd:b58f:5be7 with SMTP id 18-20020a631152000000b003fdb58f5be7mr825255pgr.164.1655314783415;
        Wed, 15 Jun 2022 10:39:43 -0700 (PDT)
Received: from thinkpad ([192.77.111.2])
        by smtp.gmail.com with ESMTPSA id t188-20020a6281c5000000b0051ba7515e0dsm7247196pfd.54.2022.06.15.10.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 10:39:42 -0700 (PDT)
Date:   Wed, 15 Jun 2022 23:09:41 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, swboyd@chromium.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v5] PCI/ASPM: Update LTR threshold based upon reported
 max latencies
Message-ID: <20220615173941.GC3606@thinkpad>
References: <1654242861-15695-1-git-send-email-quic_krichai@quicinc.com>
 <1654837710-30561-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1654837710-30561-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jun 10, 2022 at 10:38:28AM +0530, Krishna chaitanya chundru wrote:
> From: Prasad Malisetty <quic_pmaliset@quicinc.com>
> 
> In ASPM driver, LTR threshold scale and value are updated based on
> tcommon_mode and t_poweron values. In kioxia NVMe L1.2 is failing due to
> LTR threshold scale and value are greater values than max snoop/non-snoop
> value.
> 
> Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
> reported snoop/no-snoop values is greather than or equal to
> LTR_L1.2_THRESHOLD value.
> 
> Signed-off-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> 
> I am taking this patch forward as prasad is no more working with our org.
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
> index a96b742..676c03e 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -461,14 +461,36 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  {
>  	struct pci_dev *child = link->downstream, *parent = link->pdev;
>  	u32 val1, val2, scale1, scale2;
> +	u32 max_val, max_scale, max_snp_scale, max_snp_val, max_nsnp_scale, max_nsnp_val;
>  	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
>  	u32 ctl1 = 0, ctl2 = 0;
>  	u32 pctl1, pctl2, cctl1, cctl2;
>  	u32 pl1_2_enables, cl1_2_enables;
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
> @@ -501,6 +523,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
>  	 */
>  	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
>  	encode_l12_threshold(l1_2_threshold, &scale, &value);
> +
> +	/*
> +	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
> +	 * snoop/no-snoop values are greather than or equal to LTR_L1.2_THRESHOLD value.
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
