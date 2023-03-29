Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45B96CDB60
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 16:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbjC2OCX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 10:02:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230373AbjC2OCW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 10:02:22 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3C654C1F
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2023 07:01:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso18638177pjb.3
        for <linux-pci@vger.kernel.org>; Wed, 29 Mar 2023 07:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680098519;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+t+rqepYDiPCeucRwMGif55QGbm9o8+zPctzSfAB80U=;
        b=i86veqBnDoigJJiVx28C2dy2G9XN+6v4XIy8vWr19qwezqy4lmNfvb+M35MDPFXpe8
         VsEXhCWWC5nFZKYf/n4mL+fXaPtb9lEc7RtQ6k4gra8g48qjyn+2ha7fa9FDXhCDN6hi
         x3YdNPXWQRHms6ouL0kgVgslYOVsdr6fKKdnCsZG7NmiPhXAhFRXWRAhAcRJaOXaB5zv
         QvuP7Av6kK8z6yYIEV70DY07BrglUWW+Ep11oOTS5+dvAYOqS4KXfc/pICdhDDN4g3L+
         Kah4r38GUt6ptCnbFgMf3lDtM9s6pH5yR0HmPWxVkcDDPxjiU2eHpdyOYgo4yrN6OfxR
         nr5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680098519;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+t+rqepYDiPCeucRwMGif55QGbm9o8+zPctzSfAB80U=;
        b=IWlN3tZxZRYrlQvzWSOg7N6/t+NrIYfSuEe8CfrGsymRCARz1tStZWnjd7TsaNdT3q
         ZsWq9zkZgiitiXmRd4UcxSd4ZjlexbgBGASM/BeRg5dYxfbsKeAJIkv1PRKl4jbMZ3KS
         XAVgjDLAPgDpmUNXoczHsyp0X0bhVBT3lerqhvurYemBpe0Qy4qY/+Afyap8Sn6PITXO
         kvfmqxfQqkTawFqr7aBfOsY7XsjNfGlNI7qG4KtiHJZPd486/Umq+jNdwo8OctLqNsRg
         sA4CvEmpOiRD/7hcq2oQ587gvSf/WlF3qcfj5Mj09/1smMIqu/JMCbk00P7bmWaxlqiF
         QSTQ==
X-Gm-Message-State: AO0yUKUHvBIsnYZ59i45OJ+ij9DpxKR5DoV6R7P8Q+gDckaB396PsG1Q
        t+XOsd6YU3hX/1/VPCuXCDnh
X-Google-Smtp-Source: AK7set9wQikTSV1pgs3dy6STodYlwf25gv+l3pyiPdbF2QYVGcKDUJ3vgqvGI1rALG4VDgx9tbdNeA==
X-Received: by 2002:a05:6a20:b29f:b0:cc:a8d7:ad7e with SMTP id ei31-20020a056a20b29f00b000cca8d7ad7emr15656875pzb.60.1680098518618;
        Wed, 29 Mar 2023 07:01:58 -0700 (PDT)
Received: from thinkpad ([117.216.120.213])
        by smtp.gmail.com with ESMTPSA id 16-20020aa79250000000b005e4d8c6168csm23034693pfp.210.2023.03.29.07.01.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 07:01:58 -0700 (PDT)
Date:   Wed, 29 Mar 2023 19:31:50 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Johan Hovold <johan@kernel.org>
Cc:     lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_krichai@quicinc.com, johan+linaro@kernel.org, steev@kali.org,
        mka@chromium.org, Dhruva Gole <d-gole@ti.com>
Subject: Re: [PATCH v3 1/1] PCI: qcom: Add support for system suspend and
 resume
Message-ID: <20230329140150.GE5575@thinkpad>
References: <20230327133824.29136-1-manivannan.sadhasivam@linaro.org>
 <20230327133824.29136-2-manivannan.sadhasivam@linaro.org>
 <ZCQLWzqKPrusMro+@hovoldconsulting.com>
 <20230329125232.GB5575@thinkpad>
 <ZCQ69xyQ4mwTow1W@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCQ69xyQ4mwTow1W@hovoldconsulting.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 29, 2023 at 03:19:51PM +0200, Johan Hovold wrote:
> On Wed, Mar 29, 2023 at 06:22:32PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Mar 29, 2023 at 11:56:43AM +0200, Johan Hovold wrote:
> > > On Mon, Mar 27, 2023 at 07:08:24PM +0530, Manivannan Sadhasivam wrote:
>  
> > > > +static int qcom_pcie_suspend_noirq(struct device *dev)
> > > > +{
> > > > +	struct qcom_pcie *pcie = dev_get_drvdata(dev);
> > > > +	int ret;
> > > > +
> > > > +	/*
> > > > +	 * Set minimum bandwidth required to keep data path functional during
> > > > +	 * suspend.
> > > > +	 */
> > > > +	ret = icc_set_bw(pcie->icc_mem, 0, MBps_to_icc(250));
> > > 
> > > This isn't really the minimum bandwidth you're setting here.
> > > 
> > > I think you said off list that you didn't see real impact reducing the
> > > bandwidth, but have you tried requesting the real minimum which would be
> > > kBps_to_icc(1)?
> > > 
> > > Doing so works fine here with both the CRD and X13s and may result in
> > > some further power savings.
> > > 
> > 
> > No, we shouldn't be setting random value as the bandwidth. Reason is, these
> > values are computed by the bus team based on the requirement of the interconnect
> > paths (clock, voltage etc...) with actual PCIe Gen speeds. I don't know about
> > the potential implication even if it happens to work.
> 
> Why would you need PCIe gen1 speed during suspend?
> 

That's what the suggestion I got from Qcom PCIe team. But I didn't compare the
value you added during icc support patch with downstream. More below...

> These numbers are already somewhat random as, for example, the vendor
> driver is requesting 500 kBps (800 peak) during runtime, while we are
> now requesting five times that during suspend (the vendor driver gets a
> away with 0).
> 

Hmm, then I should've asked you this question when you added icc support.
I thought you inherited those values from downstream but apparently not.
Even in downstream they are using different bw votes for different platforms.
I will touch base with PCIe and ICC teams to find out the actual value that
needs to be used.

Regarding 0 icc vote, downstream puts all the devices in D3Cold (poweroff)
state during suspend. So for them 0 icc vote will work but not for us as we need
to keep the device and link intact.

- Mani

> Sure, this indicates that the interconnect driver is broken and we
> should indeed be using values that at least makes some sense (and
> eventually fix the interconnect driver).
> 
> Just not sure that you need to request that much bandwidth during
> suspend (e.g. for just a couple of register accesses).
> 
> Johan

-- 
மணிவண்ணன் சதாசிவம்
