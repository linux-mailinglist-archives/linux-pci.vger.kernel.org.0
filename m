Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B01C652C85
	for <lists+linux-pci@lfdr.de>; Wed, 21 Dec 2022 06:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234040AbiLUFuM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Dec 2022 00:50:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbiLUFuJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Dec 2022 00:50:09 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FD1209A0
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 21:50:04 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id u15-20020a17090a3fcf00b002191825cf02so1055540pjm.2
        for <linux-pci@vger.kernel.org>; Tue, 20 Dec 2022 21:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Oi6MKv+8Yh0su2x+3wnzQEef+BMWodNZ1GKcRIWPe/g=;
        b=ywYPMZzOYVTkkuj8UqS4nrfDsNVVRom/2Rs4csKQ63J9SLUSm15X5OOj3wB9Pe0yQW
         1+TV6ZFG/WbBCfQwhb2nULWcCS52t8GUUTIkmZt0POTrKFGTdzDNOniPf+H83Pw+bWTv
         Jomr6rgBzNk26uAcm580W/wBJkQHtPDJeIvdb5WSOCgA/5C1rqIH10gSf7/3bEvIoZeP
         +jXPpigMMLmWdV7F1a34LckDpo8XFeQCcmJwNFOiRHJjkSkAuykH87eMIm9raqp9ApHq
         5AMZ//JB43ZL2EkFah5AvizsT3Q06iA+4oBwJg/sYGSXFExwVkF8G8XOcTWe17T7C5QW
         SJWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oi6MKv+8Yh0su2x+3wnzQEef+BMWodNZ1GKcRIWPe/g=;
        b=fiqH0x6NcKQMGrNXPre6DeC2rwKUULKshcQRm8PP4sb7beMf66FEMe279zH/jJVtUr
         SoNft8iA46wDktDLnm1UM4BjhOzP3R+ZyyJhFld0OGkyBUDIKmGMEONqpmoEaD2h3N9s
         0a+DugtMzikQJZ92S4bnwVp03xlwkjfSv6Q4tyPTxr4knUG83yPzEL5XzwBeEXFRQJNU
         q80Rmxu+P3FmOIoZrcFes6Ssgg0ldYI+oSuaS3pSVEATAt1GOiirZranTPBFT7dnzf5g
         Vd6eabC2eCalMEaV3HtSNmnNQ7qKbH5RPGWjORyQm2Gb98IYniRe9jBNcgLzF02i5tXp
         6UQQ==
X-Gm-Message-State: AFqh2kpWP9R+DBbgJPM1FEGYYaidN+KuH1iw45xfD8kTUIuQRFSllz8J
        zN2YdPwxn3uH2S/gFa6K+EFk
X-Google-Smtp-Source: AMrXdXswAWzhwsfC0ABbkBo6/mdDNCCDtY0/kM+SdcIo0JoA6d6eLhqGPB5H96r6UW+07m1nLDcrcw==
X-Received: by 2002:a17:902:ea91:b0:191:327d:c18b with SMTP id x17-20020a170902ea9100b00191327dc18bmr716744plb.67.1671601804212;
        Tue, 20 Dec 2022 21:50:04 -0800 (PST)
Received: from thinkpad ([117.217.177.7])
        by smtp.gmail.com with ESMTPSA id j4-20020a170902c3c400b00172cb8b97a8sm10382094plj.5.2022.12.20.21.49.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Dec 2022 21:50:02 -0800 (PST)
Date:   Wed, 21 Dec 2022 11:19:53 +0530
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
Message-ID: <20221221054953.GA2922@thinkpad>
References: <1663315719-21563-1-git-send-email-quic_krichai@quicinc.com>
 <20221205112500.GB4514@thinkpad>
 <Y441/Icd2wSgVnNU@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y441/Icd2wSgVnNU@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 05, 2022 at 06:18:36PM +0000, Matthias Kaehlcke wrote:
> On Mon, Dec 05, 2022 at 04:55:00PM +0530, Manivannan Sadhasivam wrote:
> > On Fri, Sep 16, 2022 at 01:38:37PM +0530, Krishna chaitanya chundru wrote:
> > > In ASPM driver, LTR threshold scale and value are updated based on
> > > tcommon_mode and t_poweron values. In Kioxia NVMe L1.2 is failing due to
> > > LTR threshold scale and value are greater values than max snoop/non-snoop
> > > value.
> > > 
> > > Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when
> > > reported snoop/no-snoop values is greater than or equal to
> > > LTR_L1.2_THRESHOLD value.
> > > 
> > > Signed-off-by: Prasad Malisetty  <quic_pmaliset@quicinc.com>
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > 
> > I take my Ack back... Sorry that I did not look into this patch closer.
> > 
> > > ---
> > > 
> > > I am taking this patch forward as prasad is no more working with our org.
> > > changes since v6:
> > > 	- Rebasing with pci/next.
> > > changes since v5:
> > > 	- no changes, just reposting as standalone patch instead of reply to
> > > 	  previous patch.
> > > Changes since v4:
> > > 	- Replaced conditional statements with min and max.
> > > changes since v3:
> > > 	- Changed the logic to include this condition "snoop/nosnoop
> > > 	  latencies are not equal to zero and lower than LTR_L1.2_THRESHOLD"
> > > Changes since v2:
> > > 	- Replaced LTRME logic with max snoop/no-snoop latencies check.
> > > Changes since v1:
> > > 	- Added missing variable declaration in v1 patch
> > > ---
> > >  drivers/pci/pcie/aspm.c | 30 ++++++++++++++++++++++++++++++
> > >  1 file changed, 30 insertions(+)
> > > 
> > > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > > index 928bf64..2bb8470 100644
> > > --- a/drivers/pci/pcie/aspm.c
> > > +++ b/drivers/pci/pcie/aspm.c
> > > @@ -486,13 +486,35 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> > >  {
> > >  	struct pci_dev *child = link->downstream, *parent = link->pdev;
> > >  	u32 val1, val2, scale1, scale2;
> > > +	u32 max_val, max_scale, max_snp_scale, max_snp_val, max_nsnp_scale, max_nsnp_val;
> > >  	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
> > >  	u32 ctl1 = 0, ctl2 = 0;
> > >  	u32 pctl1, pctl2, cctl1, cctl2;
> > > +	u16 ltr;
> > > +	u16 max_snoop_lat, max_nosnoop_lat;
> > >  
> > >  	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
> > >  		return;
> > >  
> > > +	ltr = pci_find_ext_capability(child, PCI_EXT_CAP_ID_LTR);
> > > +	if (!ltr)
> > > +		return;
> > > +
> > > +	pci_read_config_word(child, ltr + PCI_LTR_MAX_SNOOP_LAT, &max_snoop_lat);
> > > +	pci_read_config_word(child, ltr + PCI_LTR_MAX_NOSNOOP_LAT, &max_nosnoop_lat);
> > > +
> > > +	max_snp_scale = (max_snoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
> > > +	max_snp_val = max_snoop_lat & PCI_LTR_VALUE_MASK;
> > > +
> > > +	max_nsnp_scale = (max_nosnoop_lat & PCI_LTR_SCALE_MASK) >> PCI_LTR_SCALE_SHIFT;
> > > +	max_nsnp_val = max_nosnoop_lat & PCI_LTR_VALUE_MASK;
> > > +
> > > +	/* choose the greater max scale value between snoop and no snoop value*/
> > > +	max_scale = max(max_snp_scale, max_nsnp_scale);
> > > +
> > > +	/* choose the greater max value between snoop and no snoop scales */
> > > +	max_val = max(max_snp_val, max_nsnp_val);
> > > +
> > >  	/* Choose the greater of the two Port Common_Mode_Restore_Times */
> > >  	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> > >  	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
> > > @@ -525,6 +547,14 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
> > >  	 */
> > >  	l1_2_threshold = 2 + 4 + t_common_mode + t_power_on;
> > >  	encode_l12_threshold(l1_2_threshold, &scale, &value);
> > > +
> > > +	/*
> > > +	 * Based on PCIe r4.1, sec 5.5.1, L1.2 substate must be entered when reported
> > > +	 * snoop/no-snoop values are greater than or equal to LTR_L1.2_THRESHOLD value.
> > 
> > Apart from the bug in calculating the LTR_Threshold as reported by Matthias
> > and Bjorn, I'm wondering if we are covering up for the device firmware issue.
> 
> Yes, I think the patch is doing exactly that.
> 
> > As per section 6.18, if the device reports snoop/no-snoop scale/value as 0, then
> > it implies that the device won't tolerate any additional delays from the host.
> >
> > In that case, how can we allow the link to go into L1.2 since that would incur
> > high delay compared to L1.1?
> 
> I had the same doubt, a value of 0 doesn't make sense, if it literally means
> 'max delay of 0ns'. I did some debugging around this issue. One thing I found
> is that there are NVMe models that don't have issues with entering L1.2 with
> max (no-)snoop latencies of 0. From that I infer that a value of 0 does not
> literally mean a max delay of 0ns.
> 

This is interesting.

> The PCIe spec doesn't say specifically what a value of 0 in those registers
> means, but chapter "6.18 Latency Tolerance Reporting (LTR) Mechanism" of the
> PCIe 4.0 base spec says something about the latency requirements in LTR
> messages:
> 
>   Setting the value and scale fields to all 0’s indicates that the device will
>   be impacted by any delay and that the best possible service is requested.
> 
> With that and the fact that several NVMe's don't have issues with all 0 values
> I deduce that all 0's means 'best possible service' and not 'max latency of
> 0ns'. It seems the Kioxia firmware has a bug which interprets all 0 values as
> a max latency of 0ns.
> 
> Another finding is that the Kioxia NVMe can enter L1.2 if the max latencies
> are set to values >= the LTR threshold. Unfortunately that isn't a viable
> fix for existing devices in the field, devices under development could possibly
> adjust the latencies in the BIOS (coreboot code [1] suggests that this is done
> at least in some cases).
> 

I fully agree that it is a firmware issue. And yes, we should refrain to fixes
in the bootloader if possible. 

Another option would be to add a quirk for specific devices in the ASPM code.
But in that case, I'm not sure what would be the optimal snoop/no-snoop value
that could be used. There is another issue where if we have some other device
on the same bus that explicitly requires 0ns latency.

Thanks,
Mani

> m.
> 
> [1] https://github.com/coreboot/coreboot/blob/master/src/device/pciexp_device.c#L313
> 
> 
> 
> 
> > > +	 */
> > > +	scale = min(scale, max_scale);
> > > +	value = min(value, max_val);
> > > +
> > >  	ctl1 |= t_common_mode << 8 | scale << 29 | value << 16;
> > >  
> > >  	/* Some broken devices only support dword access to L1 SS */
> > > -- 
> > > 2.7.4
> > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
