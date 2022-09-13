Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C16845B7887
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 19:45:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233137AbiIMRoi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 13:44:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233125AbiIMRoN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 13:44:13 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA986CD2
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 09:39:29 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id x1-20020a17090ab00100b001fda21bbc90so16178229pjq.3
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 09:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=QsjjO29pV+lXnXx8W3jvjySTYx0DjCwzWNd1Q2TmSXA=;
        b=Uqnmjv2xQNeNKUq7BA4jcJlTZavzWJWhXukjJKyzC6pVFxMd0AzNd7CIJMP+lYYZMf
         rG+4JX2uYdFGphoSIMXiymcu0A66WUnE5bVc/thHgnWrLHp013vc7TxCNyd3fwHkJx0a
         fKZe9OKqlVWzr5GCkcFRXwIkjzUpm0+4WZalg3kT3SbCvFFt8bYTJQYJQcXO4u8Xp/KI
         V1fk91M+6twTeJvNjlHc/fk+vkhF6MNjMCoWviMZnCJAaAwPfuhRyPPPfglH74ezfl24
         xKo1NvFzl3xADNqgD0ofJ4ZBbTVkbWg6yS4Tb1wKpmso5K7ESaWBhRR2grqhAEJTdkxO
         hHyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=QsjjO29pV+lXnXx8W3jvjySTYx0DjCwzWNd1Q2TmSXA=;
        b=pWa5yZqwEkEbHCaIxC0nuOKFzJy/LuOL3E/OTigvQR3qfqkFqfNKsgKcFpSQQBF+TV
         2NHvLYJmPjJvzGKvulc9BLycr23j6IhgKrTFzhmmspBwwe1w0AuBHOWdOHOBUkT3M3Fu
         ihP9T3xEtGCBitvOsxJvxhluOfaB3UVxOOqMxRXixuA9ebKzumE7wgkL+iHMF5ebFBDM
         oR7ulwADVc5tWkQJUWYdE5SUZrtJqvBhgDX/pnFxKjYHrm7Nj9qHrm2DoP4Gu4lgngSK
         S5XhjSuC00s9y+BG3boiiiYRhfFX+YWpE0kdpHJJ3eJNUWI4+vezDBxu5RO4rGV46qDq
         KlDg==
X-Gm-Message-State: ACgBeo27jrflZ9noz16mWXgibdacb03UJDXxvgdY8R9v1vx4ZgMcc4D9
        OSDwYSefVACf3JZnPZ+WIC6d
X-Google-Smtp-Source: AA6agR5TkRvWKKpdCy2xfTloIRSf/Zw2zjtIJkVjQVewOdcYMyHw0J1LpGaeyV7kqixlIKowsTJScg==
X-Received: by 2002:a17:903:110e:b0:171:3afa:e68c with SMTP id n14-20020a170903110e00b001713afae68cmr32267098plh.12.1663087169076;
        Tue, 13 Sep 2022 09:39:29 -0700 (PDT)
Received: from workstation ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id e14-20020a17090a7c4e00b002008a85bac1sm7344495pjl.49.2022.09.13.09.39.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Sep 2022 09:39:28 -0700 (PDT)
Date:   Tue, 13 Sep 2022 22:09:21 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        mka@chromium.org, quic_vbadigan@quicinc.com,
        quic_hemantk@quicinc.com, quic_nitegupt@quicinc.com,
        quic_skananth@quicinc.com, quic_ramkri@quicinc.com,
        swboyd@chromium.org, dmitry.baryshkov@linaro.org,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 2/5] PCI: qcom: Add retry logic for link to be stable
 in L1ss
Message-ID: <20220913163921.GE25849@workstation>
References: <20220909195000.GA310621@bhelgaas>
 <7310fc0c-5f87-87a6-4484-d60970ce3285@quicinc.com>
 <20220912173346.GB25849@workstation>
 <e9c5d29a-f1a7-46c8-a456-6c75c129876f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9c5d29a-f1a7-46c8-a456-6c75c129876f@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 13, 2022 at 07:54:22PM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 9/12/2022 11:03 PM, Manivannan Sadhasivam wrote:
> > On Mon, Sep 12, 2022 at 09:39:36PM +0530, Krishna Chaitanya Chundru wrote:
> > > On 9/10/2022 1:20 AM, Bjorn Helgaas wrote:
> > > > On Fri, Sep 09, 2022 at 02:14:41PM +0530, Krishna chaitanya chundru wrote:
> > > > > Some specific devices are taking time to settle the link in L1ss.
> > > > > So added a retry logic before returning from the suspend op.
> > > > "L1ss" is not a state.  If you mean "L1.1" or "L1.2", say that.  Also
> > > > in code comments below.
> > > Yes L1ss means L1.2 and L1.2 We will update it next patch
> > > > s/So added a/Add/
> > > > 
> > > > What are these specific devices?  Is this a qcom controller defect?
> > > > An endpoint defect that should be addressed via some kind of generic
> > > > quirk?
> > > This is depending up on the endpoint devices and it varies to device to
> > > device.
> > > 
> > Can we identify the source of the traffic? Is the NVMe driver not
> > flushing it's queues correctly?
> 
> We found that it is not from nvme data, we are seeing some physical layer
> activity on the
> 
> protocol analyzer.
> 

Okay

> > 
> > > We are thinking this is not a defect if there is some traffic in the link
> > > the link will
> > > 
> > > not go to L1ss .
> > > 
> > Is this hack still required even after switching to syscore ops?
> > 
> > Thanks,
> > Mani
> 
> Yes, mani it is still required. And just before this sycore ops there will
> be a pci transaction to
> 
> mask msix interrupts.
> 

Hmm. I'm getting slightly confused here. What really happens when you do
the resource teardown during suspend and the link has not entered L1SS?

Since PHY is powered by MX domain, I'm wondering why we should wait for
the link to be in L1SS?

Thanks,
Mani

> > > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > ---
> > > > >    drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++-----------
> > > > >    1 file changed, 25 insertions(+), 11 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > index 6e04d0d..15c2067 100644
> > > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > @@ -1809,26 +1809,40 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > > > >    static int __maybe_unused qcom_pcie_pm_suspend(struct qcom_pcie *pcie)
> > > > >    {
> > > > >    	u32 val;
> > > > > +	ktime_t timeout, start;
> > > > >    	struct dw_pcie *pci = pcie->pci;
> > > > >    	struct device *dev = pci->dev;
> > > > >    	if (!pcie->cfg->supports_system_suspend)
> > > > >    		return 0;
> > > > > -	/* if the link is not active turn off clocks */
> > > > > -	if (!dw_pcie_link_up(pci)) {
> > > > > -		dev_info(dev, "Link is not active\n");
> > > > > -		goto suspend;
> > > > > -	}
> > > > > +	start = ktime_get();
> > > > > +	/* Wait max 200 ms */
> > > > > +	timeout = ktime_add_ms(start, 200);
> > > > > -	/* if the link is not in l1ss don't turn off clocks */
> > > > > -	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> > > > > -	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> > > > > -		dev_warn(dev, "Link is not in L1ss\n");
> > > > > -		return 0;
> > > > > +	while (1) {
> > > > > +
> > > > > +		if (!dw_pcie_link_up(pci)) {
> > > > > +			dev_warn(dev, "Link is not active\n");
> > > > > +			break;
> > > > > +		}
> > > > > +
> > > > > +		/* if the link is not in l1ss don't turn off clocks */
> > > > > +		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> > > > > +		if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> > > > > +			dev_dbg(dev, "Link enters L1ss after %d  ms\n",
> > > > > +					ktime_to_ms(ktime_get() - start));
> > > > > +			break;
> > > > > +		}
> > > > > +
> > > > > +		if (ktime_after(ktime_get(), timeout)) {
> > > > > +			dev_warn(dev, "Link is not in L1ss\n");
> > > > > +			return 0;
> > > > > +		}
> > > > > +
> > > > > +		udelay(1000);
> > > > >    	}
> > > > > -suspend:
> > > > >    	if (pcie->cfg->ops->suspend)
> > > > >    		pcie->cfg->ops->suspend(pcie);
> > > > > -- 
> > > > > 2.7.4
> > > > > 
