Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A685B8127
	for <lists+linux-pci@lfdr.de>; Wed, 14 Sep 2022 07:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiINF7O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 14 Sep 2022 01:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbiINF7M (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 14 Sep 2022 01:59:12 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EF765E643
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 22:59:11 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id v4so13359041pgi.10
        for <linux-pci@vger.kernel.org>; Tue, 13 Sep 2022 22:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=eMk4zk5vK2iwFc2VFHW23TYqcWJOpXNjrfrjLjJHErA=;
        b=z4NDsKsVw4P66Krj3J90B516nWyfGRMibREHJ80gYp2Vo/IqAe/GkzK2e7SWgcYK5h
         /IoaR/1FXLyivfzpzh/oLgFlti6k9GhohCBiVDueqQE/QXo4q1Wr1W4LmxmtiMFd66e4
         JsT1wnm6gY8VWO1Upp1Gqtj808uGWRnaHQZ87ncDoQebY8byftyttQoKJN9vdTwuTXVo
         QE9/VTWsm/Wu75LVqruIDbaCWE+aXGj2esqfDfzZc7+QD9fSge0FYQPMEC4MxG1cw8Za
         b7+xFB32RXRlKLilBO9/JCDGwVfBNd+ZZZntjfnQHqsKYXEhQIuK3zIh7gSiNWePZpgq
         3wJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=eMk4zk5vK2iwFc2VFHW23TYqcWJOpXNjrfrjLjJHErA=;
        b=UCCuX4gT06qtcJ8z8u9P9FjbzovVL692XeiLQAtLKWriD2NUg5OAE/1gMhN4j9sfCF
         jPwLVbvwguN30p+S8VJq8qtgxhBKLQvsjgiDJs7Hm5zzEbV6Kwbim2fEIoTEnE1SQh5B
         l0O+5wCwlk/Tc0CyDiL+++NFgt8Gyf/eSteYt64tF2PceaSfqKhPpID8dHNqAYkr++J+
         cALs77/OBqX1YxCpAQBzUXX9aTLffwN6erU4H+pR7uE8xhvHcyUTDiIUWyt7OfrBQcxw
         0xaMKaSMdtNQymA1DaNxfE3fKI/wDCA+RCPCAp9fBFjJdWuvmK4H5n61Ougye5L+6/t5
         9TRw==
X-Gm-Message-State: ACgBeo1S78hZa787nWLn8QjM3eDT5n1eGvk/wOOzccC6c7Bf4KiwddIh
        wy6Uc8faaeHSVgbrXbCNqfZrqRFjVIKXWQg=
X-Google-Smtp-Source: AA6agR44+dAqnrvrvPDqeZZ5OA60zl5uM/1c1fW3PIK7UOKM99NllRgE3f89AzEZNePFxLVxWfBHQQ==
X-Received: by 2002:a63:6b02:0:b0:430:3876:95b4 with SMTP id g2-20020a636b02000000b00430387695b4mr31509123pgc.233.1663135150500;
        Tue, 13 Sep 2022 22:59:10 -0700 (PDT)
Received: from workstation ([117.202.184.122])
        by smtp.gmail.com with ESMTPSA id x5-20020aa79405000000b0053e4296e1d3sm9094176pfo.198.2022.09.13.22.59.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Sep 2022 22:59:09 -0700 (PDT)
Date:   Wed, 14 Sep 2022 11:29:02 +0530
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
Message-ID: <20220914055902.GA16459@workstation>
References: <20220909195000.GA310621@bhelgaas>
 <7310fc0c-5f87-87a6-4484-d60970ce3285@quicinc.com>
 <20220912173346.GB25849@workstation>
 <e9c5d29a-f1a7-46c8-a456-6c75c129876f@quicinc.com>
 <20220913163921.GE25849@workstation>
 <51be0ae5-8f48-fc6e-0246-810018326594@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51be0ae5-8f48-fc6e-0246-810018326594@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 14, 2022 at 07:15:35AM +0530, Krishna Chaitanya Chundru wrote:
> 
> On 9/13/2022 10:09 PM, Manivannan Sadhasivam wrote:
> > On Tue, Sep 13, 2022 at 07:54:22PM +0530, Krishna Chaitanya Chundru wrote:
> > > On 9/12/2022 11:03 PM, Manivannan Sadhasivam wrote:
> > > > On Mon, Sep 12, 2022 at 09:39:36PM +0530, Krishna Chaitanya Chundru wrote:
> > > > > On 9/10/2022 1:20 AM, Bjorn Helgaas wrote:
> > > > > > On Fri, Sep 09, 2022 at 02:14:41PM +0530, Krishna chaitanya chundru wrote:
> > > > > > > Some specific devices are taking time to settle the link in L1ss.
> > > > > > > So added a retry logic before returning from the suspend op.
> > > > > > "L1ss" is not a state.  If you mean "L1.1" or "L1.2", say that.  Also
> > > > > > in code comments below.
> > > > > Yes L1ss means L1.2 and L1.2 We will update it next patch
> > > > > > s/So added a/Add/
> > > > > > 
> > > > > > What are these specific devices?  Is this a qcom controller defect?
> > > > > > An endpoint defect that should be addressed via some kind of generic
> > > > > > quirk?
> > > > > This is depending up on the endpoint devices and it varies to device to
> > > > > device.
> > > > > 
> > > > Can we identify the source of the traffic? Is the NVMe driver not
> > > > flushing it's queues correctly?
> > > We found that it is not from nvme data, we are seeing some physical layer
> > > activity on the
> > > 
> > > protocol analyzer.
> > > 
> > Okay
> > 
> > > > > We are thinking this is not a defect if there is some traffic in the link
> > > > > the link will
> > > > > 
> > > > > not go to L1ss .
> > > > > 
> > > > Is this hack still required even after switching to syscore ops?
> > > > 
> > > > Thanks,
> > > > Mani
> > > Yes, mani it is still required. And just before this sycore ops there will
> > > be a pci transaction to
> > > 
> > > mask msix interrupts.
> > > 
> > Hmm. I'm getting slightly confused here. What really happens when you do
> > the resource teardown during suspend and the link has not entered L1SS?
> > 
> > Since PHY is powered by MX domain, I'm wondering why we should wait for
> > the link to be in L1SS?
> > 
> > Thanks,
> > Mani
> 
> Mani, we need to turn off the link only after link entered in to L1ss. If we
> do before that
> 
> some transactions will be disturbed and we see a link down.
> 
> Mx power rail will control digital logic of the PHY and tries to retain the
> link state only,
> 
> The analog logic is controlled by the CX rail only, so when the link is in
> L1ss only we turn off
> 
> clks and phy.
> 

Okay, thanks for the clarification. Please add this info as a comment just above
the change.

Thanks,
Mani

> > > > > > > Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> > > > > > > ---
> > > > > > >     drivers/pci/controller/dwc/pcie-qcom.c | 36 +++++++++++++++++++++++-----------
> > > > > > >     1 file changed, 25 insertions(+), 11 deletions(-)
> > > > > > > 
> > > > > > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > > > index 6e04d0d..15c2067 100644
> > > > > > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > > > > > @@ -1809,26 +1809,40 @@ static int qcom_pcie_probe(struct platform_device *pdev)
> > > > > > >     static int __maybe_unused qcom_pcie_pm_suspend(struct qcom_pcie *pcie)
> > > > > > >     {
> > > > > > >     	u32 val;
> > > > > > > +	ktime_t timeout, start;
> > > > > > >     	struct dw_pcie *pci = pcie->pci;
> > > > > > >     	struct device *dev = pci->dev;
> > > > > > >     	if (!pcie->cfg->supports_system_suspend)
> > > > > > >     		return 0;
> > > > > > > -	/* if the link is not active turn off clocks */
> > > > > > > -	if (!dw_pcie_link_up(pci)) {
> > > > > > > -		dev_info(dev, "Link is not active\n");
> > > > > > > -		goto suspend;
> > > > > > > -	}
> > > > > > > +	start = ktime_get();
> > > > > > > +	/* Wait max 200 ms */
> > > > > > > +	timeout = ktime_add_ms(start, 200);
> > > > > > > -	/* if the link is not in l1ss don't turn off clocks */
> > > > > > > -	val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> > > > > > > -	if (!(val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> > > > > > > -		dev_warn(dev, "Link is not in L1ss\n");
> > > > > > > -		return 0;
> > > > > > > +	while (1) {
> > > > > > > +
> > > > > > > +		if (!dw_pcie_link_up(pci)) {
> > > > > > > +			dev_warn(dev, "Link is not active\n");
> > > > > > > +			break;
> > > > > > > +		}
> > > > > > > +
> > > > > > > +		/* if the link is not in l1ss don't turn off clocks */
> > > > > > > +		val = readl(pcie->parf + PCIE20_PARF_PM_STTS);
> > > > > > > +		if ((val & PCIE20_PARF_PM_STTS_LINKST_IN_L1SUB)) {
> > > > > > > +			dev_dbg(dev, "Link enters L1ss after %d  ms\n",
> > > > > > > +					ktime_to_ms(ktime_get() - start));
> > > > > > > +			break;
> > > > > > > +		}
> > > > > > > +
> > > > > > > +		if (ktime_after(ktime_get(), timeout)) {
> > > > > > > +			dev_warn(dev, "Link is not in L1ss\n");
> > > > > > > +			return 0;
> > > > > > > +		}
> > > > > > > +
> > > > > > > +		udelay(1000);
> > > > > > >     	}
> > > > > > > -suspend:
> > > > > > >     	if (pcie->cfg->ops->suspend)
> > > > > > >     		pcie->cfg->ops->suspend(pcie);
> > > > > > > -- 
> > > > > > > 2.7.4
> > > > > > > 
