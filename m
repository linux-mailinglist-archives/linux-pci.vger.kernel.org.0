Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F63C5B9F48
	for <lists+linux-pci@lfdr.de>; Thu, 15 Sep 2022 18:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbiIOQAB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Sep 2022 12:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbiIOP7i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Sep 2022 11:59:38 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294CB2BF5
        for <linux-pci@vger.kernel.org>; Thu, 15 Sep 2022 08:59:32 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h194so13448022iof.4
        for <linux-pci@vger.kernel.org>; Thu, 15 Sep 2022 08:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=A9MuMr8sNFs+YY+FKNgKXQBhOWjKSVReOcYSP90Jf1A=;
        b=Ik+US2xysLuHqA26EeZQtVLuRyrG1XfW58naE8RwKWA47z9umdBePuYBCKpZKOXQx4
         rgcv2+ht9lY6mpF2IWDS8J5lHSbWLocG+63ouJKqeofiMEI+qGCL1wuXO8JcVNIqkayM
         ONhxT72VMXODD1Zp7KHVGccZVVihwEO+OyYus=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=A9MuMr8sNFs+YY+FKNgKXQBhOWjKSVReOcYSP90Jf1A=;
        b=y0cbZThx3Ccd5yVgb7amrAluAIy3mExlfTGR99psYWEK04d0jbD+PIT5a4Cg1B4LIp
         Grdh7Hsvf+MjE5tIGdz9+wRnb5wg8mMH7jCSXaP/x7cW+ak8fiYee2uBMxdIdWvAJ/4Z
         LRMSqhZmRpLVTLuPhw/qb8TG1FvPs2ggM0WrDCtLGIjhnHJJ7S5QlwDrGC4/IzuCvmTY
         fekdiAD+l2vxq07c8Mrf0gVq9klUgtv/eJzkK5/Ryu01lROh+GthtZGGWlXHhzTpTVHx
         sbmwiThkcKGtDF6fSEoIX/iZB5xqtBAHQ9fCEBu68yJYerzPzLlnpHBS8MridNgPNTH/
         gUVg==
X-Gm-Message-State: ACrzQf3AkeHFLdJlphpVdR29FCrJ6rVO8Gqk7SixnPexnJHY8W38G3ta
        JM8WStLNrydacqCYArRwLlbUpg==
X-Google-Smtp-Source: AMsMyM7gHn31ptChXvos9nZsLVhPP/4vq9KZDZObUsqXgzrJBDSZbL+iBuAH+HL42QzLb2tXWtp2SA==
X-Received: by 2002:a05:6602:14c5:b0:689:5640:5b0f with SMTP id b5-20020a05660214c500b0068956405b0fmr170588iow.70.1663257571541;
        Thu, 15 Sep 2022 08:59:31 -0700 (PDT)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id cx14-20020a056638490e00b0034a036a9a1fsm1322866jab.48.2022.09.15.08.59.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 08:59:30 -0700 (PDT)
Date:   Thu, 15 Sep 2022 15:59:30 +0000
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
        Rajat Jain <rajatja@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [RESEND PATCH v6] PCI/ASPM: Update LTR threshold based upon
 reported max latencies
Message-ID: <YyNL4lwmh0mz5CcV@google.com>
References: <1663216335-9311-1-git-send-email-quic_krichai@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1663216335-9311-1-git-send-email-quic_krichai@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Krishna,

Your patch doesn't apply on pci/next due to changes to aspm_calc_l1ss_info()
from commit 1d46154eed48 ("PCI/ASPM: Refactor L1 PM Substates Control
Register programming"). Please send a rebased version.

Thanks

Matthias

On Thu, Sep 15, 2022 at 10:02:06AM +0530, Krishna chaitanya chundru wrote:
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
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> 
> I am taking this patch forward as prasad is no more working with our org.
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
