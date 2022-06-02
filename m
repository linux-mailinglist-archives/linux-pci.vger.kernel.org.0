Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24CCF53B522
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 10:29:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232347AbiFBI3w (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 04:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiFBI3u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 04:29:50 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFC9FD9A
        for <linux-pci@vger.kernel.org>; Thu,  2 Jun 2022 01:29:46 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id n13-20020a17090a394d00b001e30a60f82dso8697849pjf.5
        for <linux-pci@vger.kernel.org>; Thu, 02 Jun 2022 01:29:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qLE93fLBk76sb5feEZB3lwg0tckq9OyeKY/n0bkrWVI=;
        b=RSkYj3WOKXwloda5tvOmqVsHsBOy9LS2cWoCJcwRQ2nd7TdqQ9ETsKz1SJG7p1Yru5
         DtaOiVJALg+o8f3pNWpaR8ACvsAxa/ZZR7W8TjAcCJBoW7F2cKTIOG54iVZ9JKcyD7nv
         9tblptL5satSidG+rDqAf1tAX4MI1F2r/Y1TsteEA09tUSnlsRVDwP/rQUx8RIceuPh6
         CeB6WOj0QhOwvslDnLb3t0DophjrnY1vP6yA4ViEMTiogfVR3a8bIAqLF+r/c1miwTFt
         uBDyKYE+eAHH1EOoCYVkVmlBnqJ2b6cwHgkzUhw4R3HHQAJ14wrUK2kMEhtSOCtS5QFd
         cD8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qLE93fLBk76sb5feEZB3lwg0tckq9OyeKY/n0bkrWVI=;
        b=zeLq4Yb5FN9TOvY1sEcN3iOTICLAEuZnLefJDqVYCrGKBbjlK78jkRfkcXzjTozHKN
         znhxX1vdsx1JZpu7bUfG+XaMTM9FpN1dDzNldB+PT5fgYlXLRWJ/r+z3FXNEDE91vaCA
         iLJdYzHbygdDj/hkcDroDrUHU96tQDmKCV68W5FyVg19NtcWmVkA8TmfSnJEcnGMkLe7
         Ujh8becffMhNLQKuSRJLXIKJOmYzyHD4gwo7QYzjFkP/MIci27M2tgm7mCy6xqEzaZUX
         J620zPRQEVKmdF2bRJTNNMZ0kvEZqIUBoEsR2S4mVvtk3bK9zpraKXeZtOsfyPLgY8RL
         l5Iw==
X-Gm-Message-State: AOAM533fA4qdXRlvGjR5XWlP/MgzAjWsguptJYw0z3OykfOJho97kb3E
        sTQB+1aw1YLuqPPE+epyaydm
X-Google-Smtp-Source: ABdhPJxinrA0W1VA+IL/O0ywNYDKGyJEBSUzZD2g4x110fuITrP1RNqA5h3zIXv0Od4GRXrdCjw4bw==
X-Received: by 2002:a17:902:d2c2:b0:164:1047:5438 with SMTP id n2-20020a170902d2c200b0016410475438mr3755076plc.18.1654158586216;
        Thu, 02 Jun 2022 01:29:46 -0700 (PDT)
Received: from thinkpad ([220.158.159.212])
        by smtp.gmail.com with ESMTPSA id a20-20020a621a14000000b0050dc762816asm2868478pfa.68.2022.06.02.01.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 01:29:45 -0700 (PDT)
Date:   Thu, 2 Jun 2022 13:59:38 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_ramkri@quicinc.com,
        swboyd@chromium.org, Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>, vidyas@nvidia.com,
        kenny@panix.com
Subject: Re: [PATCH v3] PCI/ASPM: Update LTR threshold based upon reported
 max latencies
Message-ID: <20220602082938.GA4936@thinkpad>
References: <1646679549-12494-1-git-send-email-quic_pmaliset@quicinc.com>
 <1654086232-17055-1-git-send-email-quic_krichai@quicinc.com>
 <91b75542-8e4c-5b91-bbfd-38ffc456c12e@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <91b75542-8e4c-5b91-bbfd-38ffc456c12e@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 01, 2022 at 05:57:53PM +0530, Krishna Chaitanya Chundru wrote:
> [+cc kenny, vidya]
> 
> On 6/1/2022 5:53 PM, Krishna chaitanya chundru wrote:
> > In ASPM driver, LTR threshold scale and value is updating based on

s/is/are

s/updating/updated

> > tcommon_mode and t_poweron values. In kioxia NVMe L1.2 is failing due to
> > LTR threshold scale and value is greater values than max snoop/non-snoop

s/is/are

> > value.
> > 
> > Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
> > reported snoop/no-snoop values is greather than or equal to
> > LTR_L1.2_THRESHOLD value.
> > 
> > Suggested-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

If you are inheriting the patch from Prasad, then you should still give the
authorship to him (unless the patch has changed significantly). You can add
your S-o-b tag to convey that you are carrying the patch from him.

> > ---
> > 
> > I am takking this patch forward as prasad is no more working with our org.
> > 
> > Changes since v2:
> > 	- Replaced LTRME logic with max snoop/no-snoop latencies check.
> > Changes since v1:
> > 	- Added missing variable declaration in v1 patch
> > ---
> >   drivers/pci/pcie/aspm.c | 22 +++++++++++++++++++++-
> >   1 file changed, 21 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index a96b742..4a15e50 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -465,10 +465,19 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> >   	u32 ctl1 = 0, ctl2 = 0;
> >   	u32 pctl1, pctl2, cctl1, cctl2;
> >   	u32 pl1_2_enables, cl1_2_enables;
> > +	int ltr;

This could be u16 too.

> > +	u16 max_snoop_lat = 0, max_nosnoop_lat = 0;

No need to initialize these variables.

> >   	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
> >   		return;
> > +	ltr = pci_find_ext_capability(child, PCI_EXT_CAP_ID_LTR);
> > +	if (!ltr)
> > +		return;

Is this capability implemented always?

> > +
> > +	pci_read_config_word(child, ltr + PCI_LTR_MAX_SNOOP_LAT, &max_snoop_lat);
> > +	pci_read_config_word(child, ltr + PCI_LTR_MAX_NOSNOOP_LAT, &max_nosnoop_lat);
> > +
> >   	/* Choose the greater of the two Port Common_Mode_Restore_Times */
> >   	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> >   	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> > @@ -501,7 +510,18 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> >   	 */
> >   	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
> >   	encode_l12_threshold(l1_2_threshold, &scale, &value);
> > -	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
> > +
> > +	/*
> > +	 * If the max snoop and no snoop latencies are '0', then avoid updating scale
> > +	 * and value.
> > +	 *

This looks fine but...

> > +	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
> > +	 * snoop/no-snoop values is greather than or equal to LTR_L1.2_THRESHOLD value.

s/is/are

What about this? What if the snoop/nosnoop latencies are not equal to zero and
lower than LTR_L1.2_THRESHOLD?

Thanks,
Mani

> > +	 */
> > +	if ((max_snoop_lat == 0) && (max_nosnoop_lat == 0))
> > +		ctl1 |= t_common_mode << 8;
> > +	else
> > +		ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
> >   	/* Some broken devices only support dword access to L1 SS */
> >   	pci_read_config_dword(parent, parent->l1ss + PCI_L1SS_CTL1, &pctl1);

-- 
மணிவண்ணன் சதாசிவம்
