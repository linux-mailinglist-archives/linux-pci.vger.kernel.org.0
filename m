Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3657052B0EC
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 05:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbiERDwi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 May 2022 23:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiERDw3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 May 2022 23:52:29 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29E2081986
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 20:52:26 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 31so1014058pgp.8
        for <linux-pci@vger.kernel.org>; Tue, 17 May 2022 20:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=G71rbip7/LLYSXlMxn5Fb4jLrk7Bgah6j7mSed9BosI=;
        b=sS7XbaBcd1qpF0aCh0W2Jwgv70gwT4Ug0J3sCEDc1Q9lDkS++RyzbRyStmZ5YOO0BX
         XjJWDmUc1oenXcbEW1kpShGyImvl9t80wsK6WmFP7pxQM703lalbo7lhC5+/6KX6QpAP
         4yaz6x5yJEyrqqIXwfQwo2lMu+XDzA3Cf1ZZ+RcfmAa4R14tslDJg1kj8SiKysAd1LSD
         XTtOQ1BalipuNZ5Mknq4zLt/Ye+g5JUi+EMYjR8yJtbHSa0vCBIJ2jiDij9GhP2b1fOX
         FvJiGQF644dAnQOBJ2XOYOms9j4vrlnnm/R8lh5nFLdDOEW1Zei1VlX/8uxH7R1oQcgT
         GjLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=G71rbip7/LLYSXlMxn5Fb4jLrk7Bgah6j7mSed9BosI=;
        b=y28vS0x/TgiicyXoDzxrBstdigM24KFcN8U+7L2jyuBaY4NQ8H26+Ia2X+75o63l2s
         2a9daySQq4XoSMTFrLm8Jk+QZg1a0bLsoAeoWfg8EEeDDlFbLsQARYMVMDiKmUEzAcCt
         Rtt7BObDNdpaRgQBiuJPIA1/DL73vejHhCN00pUuquG5BTr5YgC8TkOleYZOCYDssv5v
         hH5+XDDSckmLde8mWD/05rPcaqYgfUDtklqjMK05wqOqzDwlm2Au9Q1kfopNzZN+wGTB
         qLNxDxhAR2NYs3lBJPXTliTV47tNe4/nRrlh3sM9ma7grYjqXesnM4Tam0hw5YPjtQkX
         vKpA==
X-Gm-Message-State: AOAM531cPCEo+USF0Fo8jrLxQsO0hyrMZEc2UXExbuH/vtsNiuPVyLfe
        PNf9W+SIwVoJO9589UcJRsG0
X-Google-Smtp-Source: ABdhPJyn0zWz/SCS7bu223+7utEv5bkwaN8Pb4hOqt4M5DSib9uBdw4PMShPcABUrkoa8U5FuQRDLg==
X-Received: by 2002:a05:6a00:170a:b0:50d:3e40:9e0 with SMTP id h10-20020a056a00170a00b0050d3e4009e0mr25613004pfc.48.1652845945391;
        Tue, 17 May 2022 20:52:25 -0700 (PDT)
Received: from thinkpad ([117.207.31.8])
        by smtp.gmail.com with ESMTPSA id b12-20020a170903228c00b0015e8d4eb29csm377690plh.230.2022.05.17.20.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 May 2022 20:52:24 -0700 (PDT)
Date:   Wed, 18 May 2022 09:22:11 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jens Axboe <axboe@fb.com>,
        Veerabhadrarao Badiganti <quic_vbadigan@quicinc.com>,
        quic_krichai@quicinc.com, Nitin Rawat <quic_nitirawa@quicinc.com>,
        Vidya Sagar <vidyas@nvidia.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        Prasad Malisetty <quic_pmaliset@quicinc.com>,
        Andy Gross <agross@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rajat Jain <rajatja@google.com>,
        "Saheed O. Bolarinwa" <refactormyself@gmail.com>,
        Rama Krishna <quic_ramkri@quicinc.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kalle Valo <kvalo@kernel.org>
Subject: Re: [PATCH 2/3] PCI: dwc: qcom: Set suspend_poweroff flag for SC7280
Message-ID: <20220518035211.GA4791@thinkpad>
References: <20220517151134.GB4528@thinkpad>
 <20220517171857.GA1083896@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220517171857.GA1083896@bhelgaas>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 17, 2022 at 12:18:57PM -0500, Bjorn Helgaas wrote:
> [+cc Prasad, Andy, Rob, Krzysztof, Rajat, Saheed, Rama, Stephen,
> Dmitry, Kalle for connection to https://lore.kernel.org/lkml/CAE-0n53ho2DX2rqQMvvKAuDCfsWW62TceTaNPzv5Mn_NQ-U6dA@mail.gmail.com/T/]
> 
> Subject line convention for this file is "PCI: qcom:" (not "PCI: dwc:
> qcom:").
> 
> Find this from "git log --oneline drivers/pci/controller/dwc/pcie-qcom.c".
> 
> On Tue, May 17, 2022 at 08:41:34PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, May 16, 2022 at 03:19:50PM -0500, Bjorn Helgaas wrote:
> > > On Fri, May 13, 2022 at 04:30:26PM +0530, Manivannan Sadhasivam wrote:
> > > > For aggressive power saving on SC7280 SoCs, the power for the
> > > > PCI devices will be taken off during system suspend. Hence,
> > > > notify the same to the PCI device drivers using
> > > > "suspend_poweroff" flag so that the drivers can prepare the PCI
> > > > devices to handle the poweroff and recover them during resume.
> > > 
> > > No doubt "power ... will be taken off during system suspend" is
> > > true, but this isn't very informative.  Is this a property of
> > > SC7280?  A choice made by the SC7280 driver?  Why is this not
> > > applicable to other systems?
> > 
> > The SC7280's RPMh firmware is cutting off the PCIe power domain
> > during system suspend. And as I explained in previous patch, the RC
> > driver itself may put the devices in D3cold conditionally on this
> > platform. The reason is to save power as this chipset is being used
> > in Chromebooks.
> 
> It looks like this should be squashed into the patch you mentioned:
> https://lore.kernel.org/lkml/CAE-0n53ho2DX2rqQMvvKAuDCfsWW62TceTaNPzv5Mn_NQ-U6dA@mail.gmail.com/T/
> 
> If Prasad's patch is applied without this, devices will be powered
> off, but nvme will not be prepared for it.  Apparently something would
> be broken in that case?
> 

Yes, but Prasad's patch is not yet reviewed so likely not get merged until
further respins.

> Also, I think this patch should be reordered so the nvme driver is
> prepared for suspend_poweroff before the qcom driver starts setting
> it.  Otherwise there's a window where qcom sets suspend_poweroff and
> powers off devices, but nvme doesn't know about it, and I assume
> something will be broken in that case?
> 

As per my understanding, patches in a series should not have build dependency
but they may depend on each other for functionality.

But I don't have any issue in reordering the patches. Will do.

> Please mention RPMh in the commit log, along with the specific
> connection with system suspend, i.e., what OS action enables RPMh to
> cut power.
> 

Okay, will do.

Thanks,
Mani

> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pcie-qcom.c | 6 ++++++
> > > >  1 file changed, 6 insertions(+)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > index 6ab90891801d..4b0ad2827f8f 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > @@ -199,6 +199,7 @@ struct qcom_pcie_cfg {
> > > >  	unsigned int has_ddrss_sf_tbu_clk:1;
> > > >  	unsigned int has_aggre0_clk:1;
> > > >  	unsigned int has_aggre1_clk:1;
> > > > +	unsigned int suspend_poweroff:1;
> > > >  };
> > > >  
> > > >  struct qcom_pcie {
> > > > @@ -1220,6 +1221,10 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
> > > >  	if (pcie->cfg->pipe_clk_need_muxing)
> > > >  		clk_set_parent(res->pipe_clk_src, res->ref_clk_src);
> > > >  
> > > > +	/* Indicate PCI device drivers that the power will be taken off during system suspend */
> > > > +	if (pcie->cfg->suspend_poweroff)
> > > > +		pci->pp.bridge->suspend_poweroff = true;
> > > > +
> > > >  	ret = clk_bulk_prepare_enable(res->num_clks, res->clks);
> > > >  	if (ret < 0)
> > > >  		goto err_disable_regulators;
> > > > @@ -1548,6 +1553,7 @@ static const struct qcom_pcie_cfg sc7280_cfg = {
> > > >  	.ops = &ops_1_9_0,
> > > >  	.has_tbu_clk = true,
> > > >  	.pipe_clk_need_muxing = true,
> > > > +	.suspend_poweroff = true,
> > > >  };
> > > >  
> > > >  static const struct dw_pcie_ops dw_pcie_ops = {
> > > > -- 
> > > > 2.25.1
> > > > 
> > 
> > -- 
> > மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
