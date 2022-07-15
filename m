Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28BBE575D72
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 10:29:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232301AbiGOI3K (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 04:29:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiGOI3A (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 04:29:00 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21E537195
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 01:28:58 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id o15so5060547pjh.1
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 01:28:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=0WR/mFAWfJJysvnTsFiFts05A6ZUT1nV5g4wTH/0EpM=;
        b=ENSA6Prmo7gAqp/Yu1lqDRjkcBr9zTp8FHgrine5fObrInJkZPsaeSS/D7KeI4w+AT
         Vuc6TT0FBpi45DzZI6RkDBNeChXvu6+joKbss9ybN+0NFhttCzr1HA04ddQjCLpiY98p
         T/D1rpGm4pRLO8/hYRiRD76PPaqbzcmNjuWZZXZqzzedZYEBXpaEK2diZPWB8R199/xl
         ul6pDJe9nFMgJ6NBXckrtFBaeyKI5/wBSqWEZ4x8EJxmSCcv4YYVbUIffexyXxTUdRBO
         ySjgkXLbBsvlsXwiAep3utD3dzl/ONPjjfrEcOGle2am2vv4giQP5Xj6M+x/2pC20Gnb
         f0QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=0WR/mFAWfJJysvnTsFiFts05A6ZUT1nV5g4wTH/0EpM=;
        b=g00kXdwl0wTnNnJyzywA2Wr48U8uwysZGomnac8D4V8W/awmPFJkMVkBztRNfOouHQ
         LOcrwebSyuixp01ess0mW4b7SqH0F0OrEJkIuNV3i+4ECuwk2Nigh9LsRakiY2E0lVml
         hAzptPVUdJjq7e58jkFky0Gsl4I6caPLEhssCyJJxHY0sEqz3r6fo5YoekNxmOwclh8V
         8vgZoz7veOV/t4QGm0xjgryTh6ktTsCbSDZH9d4Mq1mXtuSGRuTZiuodvJLABV7G5T+z
         AJySm/azuB9ZTIHVxx+kquR691uXj7WIXLzY2e4g6Mf7wmwRGEut8WlyRs+hDGkPwfZk
         w2Ng==
X-Gm-Message-State: AJIora+zrP8L7oyTf41DZpVO4HDaJ+VqXsQLnXWNRZkxkPoyzSuWtnTH
        1R0JuRq2Ee5Yk+Wmp3kgXn48
X-Google-Smtp-Source: AGRyM1sjOB7YbJxuz5YY5jecM+1Fk2v9O75Q+ZA+MGlkid5m0umKveG6PXck6AQ5+7u0MWnOX8ywyA==
X-Received: by 2002:a17:902:7406:b0:16b:dbe3:ee0c with SMTP id g6-20020a170902740600b0016bdbe3ee0cmr12194054pll.123.1657873738207;
        Fri, 15 Jul 2022 01:28:58 -0700 (PDT)
Received: from workstation ([117.248.1.85])
        by smtp.gmail.com with ESMTPSA id h27-20020aa79f5b000000b00528c16966casm3214721pfr.174.2022.07.15.01.28.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 15 Jul 2022 01:28:57 -0700 (PDT)
Date:   Fri, 15 Jul 2022 13:58:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, swboyd@chromium.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Rajat Jain <rajatja@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        helgaas@kernel.org
Subject: Re: [PATCH v5] PCI/ASPM: Update LTR threshold based upon reported
 max latencies
Message-ID: <20220715082852.GC12197@workstation>
References: <1654242861-15695-1-git-send-email-quic_krichai@quicinc.com>
 <1654837710-30561-1-git-send-email-quic_krichai@quicinc.com>
 <20f88022-e9b1-53b3-8832-85edc713ef6a@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20f88022-e9b1-53b3-8832-85edc713ef6a@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 15, 2022 at 06:53:18PM +0530, Krishna Chaitanya Chundru wrote:
> A Gentle remainder please review it.
> 
> On 6/10/2022 10:38 AM, Krishna chaitanya chundru wrote:
> > From: Prasad Malisetty <quic_pmaliset@quicinc.com>
> > 
> > In ASPM driver, LTR threshold scale and value are updated based on
> > tcommon_mode and t_poweron values. In kioxia NVMe L1.2 is failing due to
> > LTR threshold scale and value are greater values than max snoop/non-snoop
> > value.
> > 
> > Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
> > reported snoop/no-snoop values is greather than or equal to
> > LTR_L1.2_THRESHOLD value.
> > 
> > Signed-off-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
> > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

As Stephen noted in previous verison, you should sent the newer versions
separately and not as a reply to previous ones. So please sent v6 with
my tag as well.

Thanks,
Mani

> > ---
> > 
> > I am taking this patch forward as prasad is no more working with our org.
> > Changes since v4:
> > 	- Replaced conditional statements with min and max.
> > changes since v3:
> > 	- Changed the logic to include this condition "snoop/nosnoop
> > 	  latencies are not equal to zero and lower than LTR_L1.2_THRESHOLD"
> > Changes since v2:
> > 	- Replaced LTRME logic with max snoop/no-snoop latencies check.
> > Changes since v1:
> > 	- Added missing variable declaration in v1 patch
> > ---
> >   drivers/pci/pcie/aspm.c | 30 ++++++++++++++++++++++++++++++
> >   1 file changed, 30 insertions(+)
> > 
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index a96b742..676c03e 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -461,14 +461,36 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> >   {
> >   	struct pci_dev *child = link->downstream, *parent = link->pdev;
> >   	u32 val1, val2, scale1, scale2;
> > +	u32 max_val, max_scale, max_snp_scale, max_snp_val, max_nsnp_scale, max_nsnp_val;
> >   	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
> >   	u32 ctl1 = 0, ctl2 = 0;
> >   	u32 pctl1, pctl2, cctl1, cctl2;
> >   	u32 pl1_2_enables, cl1_2_enables;
> > +	u16 ltr;
> > +	u16 max_snoop_lat, max_nosnoop_lat;
> >   	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
> >   		return;
> > +	ltr = pci_find_ext_capability(child, PCI_EXT_CAP_ID_LTR);
> > +	if (!ltr)
> > +		return;
> > +
> > +	pci_read_config_word(child, ltr + PCI_LTR_MAX_SNOOP_LAT, &max_snoop_lat);
> > +	pci_read_config_word(child, ltr + PCI_LTR_MAX_NOSNOOP_LAT, &max_nosnoop_lat);
> > +
> > +	max_snp_scale = (max_snoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
> > +	max_snp_val = max_snoop_lat & PCI_LTR_VALUE_MASK;
> > +
> > +	max_nsnp_scale = (max_nosnoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
> > +	max_nsnp_val = max_nosnoop_lat & PCI_LTR_VALUE_MASK;
> > +
> > +	/* choose the greater max scale value between snoop and no snoop value*/
> > +	max_scale = max(max_snp_scale, max_nsnp_scale);
> > +
> > +	/* choose the greater max value between snoop and no snoop scales */
> > +	max_val = max(max_snp_val, max_nsnp_val);
> > +
> >   	/* Choose the greater of the two Port Common_Mode_Restore_Times */
> >   	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> >   	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> > @@ -501,6 +523,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> >   	 */
> >   	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
> >   	encode_l12_threshold(l1_2_threshold, &scale, &value);
> > +
> > +	/*
> > +	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
> > +	 * snoop/no-snoop values are greather than or equal to LTR_L1.2_THRESHOLD value.
> > +	 */
> > +	scale = min(scale, max_scale);
> > +	value = min(value, max_val);
> > +
> >   	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
> >   	/* Some broken devices only support dword access to L1 SS */
