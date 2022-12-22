Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1828F654207
	for <lists+linux-pci@lfdr.de>; Thu, 22 Dec 2022 14:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiLVNjq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Dec 2022 08:39:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235011AbiLVNjl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Dec 2022 08:39:41 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAD9C13CDA
        for <linux-pci@vger.kernel.org>; Thu, 22 Dec 2022 05:39:38 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id t2so2058353ply.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Dec 2022 05:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=XkH6OCe/x7JQpec0bculCGFtQ6ZNz0wh9corwULkI6E=;
        b=FHVUziAoXjTfQ8658Fz9bwN0Axo0vLmOhfG4Ls9YhXfuE0H267tuhjHuesk9fD2K4W
         YPQXKDwl5aopv6vRGezEP4B9N9zw4a3u7G6Bz4yO3DD67p7mZTqlSa4PnAR5MEiyW9bJ
         dsGwTXvS3xKr2R1D9Ycerfrn21+Eul85nUP/XU6zE3v7jtoOAPPeTp8r3gvIqljBqNbY
         n58FCmLREKEpE5OW6kCAMEiBrj6vzqI71CBF2zAopovLxV9Qqn1C4KpVlGvv7LDupbaO
         hD5Xc176rzoQVE5I+chEqQDievaykAMcXpuLKEEZ/Ctqq7yXoTO1TgE17UMhm3MANEOP
         fL7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XkH6OCe/x7JQpec0bculCGFtQ6ZNz0wh9corwULkI6E=;
        b=r6IHStmZK0lgCS23La9mU1dN3b2np2c2DIjTQHV+FIQoyVuT7+3rl+ks1vFyaHA5BG
         QSVaRQjeA+WXnsy15o7DIuqdMd3rZgp+fiCWHcqJHNW3RMz5dTv1sUk3MPgqZ8oMGaZF
         v8/t8RwovXmHylKZtCRdwFWYOIi35r9nW6bzXB3dtzGskT3FF16hON1v3XemqNrutIw5
         maZJlGgwyqhKsAy8DWIdqrvSNgi3oh6DUmq6mqx2r3FQw/YbEm2SBlrlIooIkRzP5J9Y
         Igq9TUUiw/x9tfS7o2ITZRvzLTwTWHkfbY7E2MosEhfbwmvaWXSMcEfwAWsVeBMpmSkm
         bySg==
X-Gm-Message-State: AFqh2kpQCl2zm13YoGVxnrOeVCFAQaqX65CKfOPbQYtsPXOkzpnLjOM6
        GGmwhnZE6qHBA5yrxTzyRoBR
X-Google-Smtp-Source: AMrXdXv2M1IfxFj/4CiOC19ST6aljTgL/aYpmm8XATNS5YYQkHSGGLRZiUWulnL1zLa8NWat1LI+4g==
X-Received: by 2002:a05:6a21:3393:b0:ab:fb31:be13 with SMTP id yy19-20020a056a21339300b000abfb31be13mr31582570pzb.37.1671716378114;
        Thu, 22 Dec 2022 05:39:38 -0800 (PST)
Received: from thinkpad ([117.217.177.99])
        by smtp.gmail.com with ESMTPSA id 37-20020a631765000000b0046b2ebb0a52sm756040pgx.17.2022.12.22.05.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Dec 2022 05:39:36 -0800 (PST)
Date:   Thu, 22 Dec 2022 19:09:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Krishna chaitanya chundru <quic_krichai@quicinc.com>,
        helgaas@kernel.org, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_vbadigan@quicinc.com, quic_hemantk@quicinc.com,
        quic_nitegupt@quicinc.com, quic_skananth@quicinc.com,
        quic_ramkri@quicinc.com, swboyd@chromium.org,
        dmitry.baryshkov@linaro.org,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v7] PCI/ASPM: Update LTR threshold based upon reported
 max latencies
Message-ID: <20221222133926.GA50976@thinkpad>
References: <1663315719-21563-1-git-send-email-quic_krichai@quicinc.com>
 <20221205112500.GB4514@thinkpad>
 <Y441/Icd2wSgVnNU@google.com>
 <20221221054953.GA2922@thinkpad>
 <Y6MfXltck34gSwU9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y6MfXltck34gSwU9@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 21, 2022 at 02:59:42PM +0000, Matthias Kaehlcke wrote:
> On Wed, Dec 21, 2022 at 11:19:53AM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Dec 05, 2022 at 06:18:36PM +0000, Matthias Kaehlcke wrote:
> > > On Mon, Dec 05, 2022 at 04:55:00PM +0530, Manivannan Sadhasivam wrote:
> > > > On Fri, Sep 16, 2022 at 01:38:37PM +0530, Krishna chaitanya chundru wrote:
> > > > > In ASPM driver, LTR threshold scale and value are updated based on
> > > > > tcommon_mode and t_poweron values. In Kioxia NVMe L1.2 is failing due to
> > > > > LTR threshold scale and value are greater values than max snoop/non-snoop
> > > > > value.
> > > > > 
> > > > > Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
> > > > > reported snoop/no-snoop values is greater than or equal to
> > > > > LTR_L1.2_THRESHOLD value.
> > > > > 
> > > > > Signed-off-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
> > > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > 
> > > > I take my Ack back... Sorry that I did not look into this patch closer.
> > > > 
> > > > > ---
> > > > > 
> > > > > I am taking this patch forward as prasad is no more working with our org.
> > > > > changes since v6:
> > > > > 	- Rebasing with pci/next.
> > > > > changes since v5:
> > > > > 	- no changes, just reposting as standalone patch instead of reply to
> > > > > 	  previous patch.
> > > > > Changes since v4:
> > > > > 	- Replaced conditional statements with min and max.
> > > > > changes since v3:
> > > > > 	- Changed the logic to include this condition "snoop/nosnoop
> > > > > 	  latencies are not equal to zero and lower than LTR_L1.2_THRESHOLD"
> > > > > Changes since v2:
> > > > > 	- Replaced LTRME logic with max snoop/no-snoop latencies check.
> > > > > Changes since v1:
> > > > > 	- Added missing variable declaration in v1 patch
> > > > > ---
> > > > >  drivers/pci/pcie/aspm.c | 30 ++++++++++++++++++++++++++++++
> > > > >  1 file changed, 30 insertions(+)
> > > > > 
> > > > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > > > index 928bf64..2bb8470 100644
> > > > > --- a/drivers/pci/pcie/aspm.c
> > > > > +++ b/drivers/pci/pcie/aspm.c
> > > > > @@ -486,13 +486,35 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> > > > >  {
> > > > >  	struct pci_dev *child = link->downstream, *parent = link->pdev;
> > > > >  	u32 val1, val2, scale1, scale2;
> > > > > +	u32 max_val, max_scale, max_snp_scale, max_snp_val, max_nsnp_scale, max_nsnp_val;
> > > > >  	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
> > > > >  	u32 ctl1 = 0, ctl2 = 0;
> > > > >  	u32 pctl1, pctl2, cctl1, cctl2;
> > > > > +	u16 ltr;
> > > > > +	u16 max_snoop_lat, max_nosnoop_lat;
> > > > >  
> > > > >  	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
> > > > >  		return;
> > > > >  
> > > > > +	ltr = pci_find_ext_capability(child, PCI_EXT_CAP_ID_LTR);
> > > > > +	if (!ltr)
> > > > > +		return;
> > > > > +
> > > > > +	pci_read_config_word(child, ltr + PCI_LTR_MAX_SNOOP_LAT, &max_snoop_lat);
> > > > > +	pci_read_config_word(child, ltr + PCI_LTR_MAX_NOSNOOP_LAT, &max_nosnoop_lat);
> > > > > +
> > > > > +	max_snp_scale = (max_snoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
> > > > > +	max_snp_val = max_snoop_lat & PCI_LTR_VALUE_MASK;
> > > > > +
> > > > > +	max_nsnp_scale = (max_nosnoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
> > > > > +	max_nsnp_val = max_nosnoop_lat & PCI_LTR_VALUE_MASK;
> > > > > +
> > > > > +	/* choose the greater max scale value between snoop and no snoop value*/
> > > > > +	max_scale = max(max_snp_scale, max_nsnp_scale);
> > > > > +
> > > > > +	/* choose the greater max value between snoop and no snoop scales */
> > > > > +	max_val = max(max_snp_val, max_nsnp_val);
> > > > > +
> > > > >  	/* Choose the greater of the two Port Common_Mode_Restore_Times */
> > > > >  	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> > > > >  	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> > > > > @@ -525,6 +547,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> > > > >  	 */
> > > > >  	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
> > > > >  	encode_l12_threshold(l1_2_threshold, &scale, &value);
> > > > > +
> > > > > +	/*
> > > > > +	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
> > > > > +	 * snoop/no-snoop values are greater than or equal to LTR_L1.2_THRESHOLD value.
> > > > 
> > > > Apart from the bug in calculating the LTR_Threshold as reported by Matthias
> > > > and Bjorn, I'm wondering if we are covering up for the device firmware issue.
> > > 
> > > Yes, I think the patch is doing exactly that.
> > > 
> > > > As per section 6.18, if the device reports snoop/no-snoop scale/value as 0, then
> > > > it implies that the device won't tolerate any additional delays from the host.
> > > >
> > > > In that case, how can we allow the link to go into L1.2 since that would incur
> > > > high delay compared to L1.1?
> > > 
> > > I had the same doubt, a value of 0 doesn't make sense, if it literally means
> > > 'max delay of 0ns'. I did some debugging around this issue. One thing I found
> > > is that there are NVMe models that don't have issues with entering L1.2 with
> > > max (no-)snoop latencies of 0. From that I infer that a value of 0 does not
> > > literally mean a max delay of 0ns.
> > > 
> > 
> > This is interesting.
> > 
> > > The PCIe spec doesn't say specifically what a value of 0 in those registers
> > > means, but chapter "6.18 Latency Tolerance Reporting (LTR) Mechanism" of the
> > > PCIe 4.0 base spec says something about the latency requirements in LTR
> > > messages:
> > > 
> > >   Setting the value and scale fields to all 0’s indicates that the device will
> > >   be impacted by any delay and that the best possible service is requested.
> > > 
> > > With that and the fact that several NVMe's don't have issues with all 0 values
> > > I deduce that all 0's means 'best possible service' and not 'max latency of
> > > 0ns'. It seems the Kioxia firmware has a bug which interprets all 0 values as
> > > a max latency of 0ns.
> > > 
> > > Another finding is that the Kioxia NVMe can enter L1.2 if the max latencies
> > > are set to values >= the LTR threshold. Unfortunately that isn't a viable
> > > fix for existing devices in the field, devices under development could possibly
> > > adjust the latencies in the BIOS (coreboot code [1] suggests that this is done
> > > at least in some cases).
> > > 
> > 
> > I fully agree that it is a firmware issue. And yes, we should refrain to fixes
> > in the bootloader if possible.
> > 
> > Another option would be to add a quirk for specific devices in the ASPM code.
> > But in that case, I'm not sure what would be the optimal snoop/no-snoop value
> > that could be used.
> 
> I had/have the same doubt.
> 
> > There is another issue where if we have some other device on the same bus
> > that explicitly requires 0ns latency.
> 
> Would that be reasonable requirement, i.e. can 0ns latency ever be achieved?

Well, not in an ideal world. But the device vendors do not fail to surprise us ;)

Thanks,
Mani

-- 
மணிவண்ணன் சதாசிவம்
