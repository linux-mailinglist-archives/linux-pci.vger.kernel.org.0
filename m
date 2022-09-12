Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F365B5F64
	for <lists+linux-pci@lfdr.de>; Mon, 12 Sep 2022 19:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiILRd5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Sep 2022 13:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiILRd4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Sep 2022 13:33:56 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C4501EC5E
        for <linux-pci@vger.kernel.org>; Mon, 12 Sep 2022 10:33:55 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y136so9322518pfb.3
        for <linux-pci@vger.kernel.org>; Mon, 12 Sep 2022 10:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=/r5Bs3v4WsCz3gJEKQuWc8+fDNXKW1W7QGEa91zvunM=;
        b=tYrJzil8gfs2G+8yrRtY8nqSTlkPcoLrajF80b138SwChrSk/Y3KQT/kzxOF4No9Lp
         6WI3O73Z/ZAffISmvfp/na0h0iV0Zg3019mbv472YaZIdJqoNK3cYeil9yhO7EmZpFou
         0uJjrjcklWMF5nohc79f44fPs8qztgUPdncoKDltxRzzQqr/S+sGitPtDZcto4LfgT6S
         HaMA8Ek0KtDa4MOuW/t5K6eNTLy9UJHkYRa2oD4gwEgqR4C3qpOXMF+AU89qSpzKpVXE
         SgV4zcXQWNXqMR1HRkIR0lHkw7mwy1/KztPkQ+DQBpJlDcC4VEKhDXGmAYYF1++sYvNw
         vv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=/r5Bs3v4WsCz3gJEKQuWc8+fDNXKW1W7QGEa91zvunM=;
        b=hZ8OZH1f76QgVRG2oBJ3oTlzcokVszTlGHAQ5GUkHXVk6c9q0yNbCx3cGSLx2VNhzG
         EVJoIkz/43tIIAFpO12ZOYRimeYGlccG4Sa7djsrwMUnucAYv9fFqWeobB7KD7ogH/Wy
         E3ZEs+5xGCrSLpMrTg5tE9YbQ6ofRbGRp/VXNAWzy0+iG4BaSp2V5HJYMvU4f3iTvcdT
         Nk27JF0W3YxH4MawpOwS2yZSzqRBodyJb0K2+KQs4VDOvS1UqZh9+rxYnL2jGARWcwSN
         aFuPu84S8+4LFQuzkgCxCTAjdBrxo8H75yqP2P5yhn4C/G6yBKt9+aYDCMbhOxmVmalp
         YLxw==
X-Gm-Message-State: ACgBeo0a4pst4xMXXzObZQ/kp9VCSNDymfDvMyZuhsG95J7LSOTnHPte
        VMYw6M+TsmaTj1MSHjg4dKv1
X-Google-Smtp-Source: AA6agR6WpHbs3Uwsjhfe+mNha7sTw8Pvv+jWYsejJb22yqAQn7QaL3TpOk5fdS/hPKEcPFreZGz1oQ==
X-Received: by 2002:a62:3241:0:b0:545:e66:9d05 with SMTP id y62-20020a623241000000b005450e669d05mr2632451pfy.53.1663004034664;
        Mon, 12 Sep 2022 10:33:54 -0700 (PDT)
Received: from workstation ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id b8-20020a170902650800b00176d0b44be2sm6311633plk.47.2022.09.12.10.33.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Sep 2022 10:33:53 -0700 (PDT)
Date:   Mon, 12 Sep 2022 23:03:46 +0530
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
Message-ID: <20220912173346.GB25849@workstation>
References: <20220909195000.GA310621@bhelgaas>
 <7310fc0c-5f87-87a6-4484-d60970ce3285@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7310fc0c-5f87-87a6-4484-d60970ce3285@quicinc.com>
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

On Mon, Sep 12, 2022 at 09:39:36PM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 9/10/2022 1:20 AM, Bjorn Helgaas wrote:
> > On Fri, Sep 09, 2022 at 02:14:41PM +0530, Krishna chaitanya chundru wrote:
> > > Some specific devices are taking time to settle the link in L1ss.
> > > So added a retry logic before returning from the suspend op.
> > "L1ss" is not a state.  If you mean "L1.1" or "L1.2", say that.  Also
> > in code comments below.
> Yes L1ss means L1.2 and L1.2 We will update it next patch
> > s/So added a/Add/
> > 
> > What are these specific devices?  Is this a qcom controller defect?
> > An endpoint defect that should be addressed via some kind of generic
> > quirk?
> 
> This is depending up on the endpoint devices and it varies to device to
> device.
> 

Can we identify the source of the traffic? Is the NVMe driver not
flushing it's queues correctly?

> We are thinking this is not a defect if there is some traffic in the link
> the link will
> 
> not go to L1ss .
> 

Is this hack still required even after switching to syscore ops?

Thanks,
Mani

> > 
> > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > ---
> > >   drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++-----------
> > >   1 file changed, 25 insertions(+), 11 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 6e04d0d..15c2067 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -1809,26 +1809,40 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > >   static int __maybe_unused qcom_pcie_pm_suspend(struct qcom_pcie *pcie)
> > >   {
> > >   	u32 val;
> > > +	ktime_t timeout, start;
> > >   	struct dw_pcie *pci = pcie->pci;
> > >   	struct device *dev = pci->dev;
> > >   	if (!pcie->cfg->supports_system_suspend)
> > >   		return 0;
> > > -	/* if the link is not active turn off clocks */
> > > -	if (!dw_pcie_link_up(pci)) {
> > > -		dev_info(dev, "Link is not active\n");
> > > -		goto suspend;
> > > -	}
> > > +	start = ktime_get();
> > > +	/* Wait max 200 ms */
> > > +	timeout = ktime_add_ms(start, 200);
> > > -	/* if the link is not in l1ss don't turn off clocks */
> > > -	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> > > -	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> > > -		dev_warn(dev, "Link is not in L1ss\n");
> > > -		return 0;
> > > +	while (1) {
> > > +
> > > +		if (!dw_pcie_link_up(pci)) {
> > > +			dev_warn(dev, "Link is not active\n");
> > > +			break;
> > > +		}
> > > +
> > > +		/* if the link is not in l1ss don't turn off clocks */
> > > +		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> > > +		if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> > > +			dev_dbg(dev, "Link enters L1ss after %d  ms\n",
> > > +					ktime_to_ms(ktime_get() - start));
> > > +			break;
> > > +		}
> > > +
> > > +		if (ktime_after(ktime_get(), timeout)) {
> > > +			dev_warn(dev, "Link is not in L1ss\n");
> > > +			return 0;
> > > +		}
> > > +
> > > +		udelay(1000);
> > >   	}
> > > -suspend:
> > >   	if (pcie->cfg->ops->suspend)
> > >   		pcie->cfg->ops->suspend(pcie);
> > > -- 
> > > 2.7.4
> > > 
