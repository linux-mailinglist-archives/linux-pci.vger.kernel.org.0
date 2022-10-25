Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D634E60CB0D
	for <lists+linux-pci@lfdr.de>; Tue, 25 Oct 2022 13:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229497AbiJYLjn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Oct 2022 07:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230285AbiJYLjl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Oct 2022 07:39:41 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BFB2ADE
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 04:39:40 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so15997831pji.1
        for <linux-pci@vger.kernel.org>; Tue, 25 Oct 2022 04:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U2x8uoYfyy7DJtdVvgEN/JiSxJ0vUzGgcYGLfQrBvzs=;
        b=pfPPTsmKQVVVn9N3ZVjJ40Yno8+kzJou3om0Z0b3MSmONH8x6L1WkTEbQMK1xRL4Kr
         ndjql1TA98GugofEKiO7ByNvyIDs3tXIpgcB7AMEYFT+IpusmigkDC4jSlVJW+qb3k2g
         26sTaoX0y68oa73OYrBiJ3WNCZRGz1+eBK3Kxrl01gHbno4/gV1i1v1TrVOHlbu9UjV8
         crXhM8U3TAKkSaMAii/j8yWkFL4S5EK2md58xENhOjR9J+HneJuBheXjbyZ61Ye12ENS
         RPEDZhH2tznnKFFRjvWr2ukFDZYihlphCCmj8f4hntM8IU6hGrcKJ6loYnpw1iu9Sr7z
         TZag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2x8uoYfyy7DJtdVvgEN/JiSxJ0vUzGgcYGLfQrBvzs=;
        b=D8AbeaFOehC2GLtpZz6lNckQuziGCQlspUD6d2cl/LN+p1EzjBD1Z33sBzkG7xTFRW
         Mg9uj0EFiP3mK/lharrvwlFCFvHuBH+QNQ00xHj6PnHiv2OyadzUHC2v6r/QV3/L5CDZ
         t3FUEXziyNii+0lwEzcZ2eJ3U4M8YBebptTHTp//4Eu0pHLOoL9uEgHq6g7rVRfka6zZ
         KPQv3IUgjtfUP4irNWbem5rws1RnBzsV/RzjxqcDH+VxdjDq3uKAFjeA7MxCllMdDx/1
         WMK9/YeGXpQ3nKO1j/JfUk1s0pD7Wq9yYnXKmkxkDcZxVMXXbSkiueRYakAOtCYo94/B
         /x0w==
X-Gm-Message-State: ACrzQf2xoI5CG5nawrSKljpx3hCb+hhhvLfIT2X20dIydHBMXD7Oo0Mz
        l8x9s15AwlhgsJYoAkh7EbrIRLZHP3p6VooBDg==
X-Google-Smtp-Source: AMsMyM4zfNSy9w9j7XfrxLxUvzKSDx8IZZD17JEKq4H3Gk26jsy7h0VRMIaA1h0f2Nn2u2MLHd3Isg==
X-Received: by 2002:a17:902:c40b:b0:17f:9636:9014 with SMTP id k11-20020a170902c40b00b0017f96369014mr37584551plk.150.1666697979493;
        Tue, 25 Oct 2022 04:39:39 -0700 (PDT)
Received: from thinkpad ([117.193.208.236])
        by smtp.gmail.com with ESMTPSA id d16-20020a17090abf9000b0020ad26fa65dsm1239737pjs.56.2022.10.25.04.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 04:39:38 -0700 (PDT)
Date:   Tue, 25 Oct 2022 17:09:33 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com
Subject: Re: [PATCH v3 4/5] PCI: endpoint: Use callback mechanism for passing
 events from EPC to EPF
Message-ID: <20221025113933.GC221610@thinkpad>
References: <20221006134927.41437-1-manivannan.sadhasivam@linaro.org>
 <20221006134927.41437-5-manivannan.sadhasivam@linaro.org>
 <b6001af6-4c41-a678-b3cb-4c1d874425bf@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6001af6-4c41-a678-b3cb-4c1d874425bf@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HI Kishon,

On Tue, Oct 11, 2022 at 06:27:37PM +0530, Kishon Vijay Abraham I wrote:
> Hi Mani,
> 
> On 06/10/22 7:19 pm, Manivannan Sadhasivam wrote:
> > Instead of using the notifiers for passing the events from EPC to EPF,
> > let's introduce a callback based mechanism where the EPF drivers can
> > populate relevant callbacks for EPC events they want to subscribe.
> > 
> > The use of notifiers in kernel is not recommended if there is a real link
> > between the sender and receiver, like in this case. Also, the existing
> > atomic notifier forces the notification functions to be in atomic context
> > while the caller may be in non-atomic context. For instance, the two
> > in-kernel users of the notifiers, pcie-qcom and pcie-tegra194, both are
> > calling the notifier functions in non-atomic context (from threaded IRQ
> > handlers). This creates a sleeping in atomic context issue with the
> > existing EPF_TEST driver that calls the EPC APIs that may sleep.
> > 
> > For all these reasons, let's get rid of the notifier chains and use the
> > simple callback mechanism for signalling the events from EPC to EPF
> > drivers. This preserves the context of the caller and avoids the latency
> > of going through a separate interface for triggering the notifications.
> > 
> > As a first step of the transition, the core_init() callback is introduced
> > in this commit, that'll replace the existing CORE_INIT notifier used for
> > signalling the init complete event from EPC.
> > 
> > During the occurrence of the event, EPC will go over the list of EPF
> > drivers attached to it and will call the core_init() callback if available.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >   drivers/pci/endpoint/functions/pci-epf-test.c | 13 ++++++-------
> >   drivers/pci/endpoint/pci-epc-core.c           | 11 ++++++++++-
> >   include/linux/pci-epf.h                       | 11 ++++++++++-
> >   3 files changed, 26 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index a6f906a96669..868de17e1ad2 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -826,20 +826,17 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
> >   	return 0;
> >   }
> > +static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> > +	.core_init = pci_epf_test_core_init,
> > +};
> > +
> >   static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
> >   				 void *data)
> >   {
> >   	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
> >   	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > -	int ret;
> >   	switch (val) {
> > -	case CORE_INIT:
> > -		ret = pci_epf_test_core_init(epf);
> > -		if (ret)
> > -			return NOTIFY_BAD;
> > -		break;
> > -
> >   	case LINK_UP:
> >   		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
> >   				   msecs_to_jiffies(1));
> > @@ -1010,6 +1007,8 @@ static int pci_epf_test_probe(struct pci_epf *epf, const struct pci_epf_device_i
> >   	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
> > +	epf->event_ops = &pci_epf_test_event_ops;
> 
> Doesn't this ignore epc_features input from the controller driver?

Sorry I don't get it! epc_features from the controller is acuquired during
pci_epf_test_bind(). EPF probe doesn't have any visibility of the controller
driver.

> > +
> >   	epf_set_drvdata(epf, epf_test);
> >   	return 0;
> >   }
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index 6cce430d431b..ba54f17ae06f 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -707,10 +707,19 @@ EXPORT_SYMBOL_GPL(pci_epc_linkup);
> >    */
> >   void pci_epc_init_notify(struct pci_epc *epc)
> >   {
> > +	struct pci_epf *epf;
> > +
> >   	if (!epc || IS_ERR(epc))
> >   		return;
> > -	atomic_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
> > +	mutex_lock(&epc->list_lock);
> > +	list_for_each_entry(epf, &epc->pci_epf, list) {
> > +		mutex_lock(&epf->lock);
> > +		if (epf->event_ops->core_init)
> 
> This would result in abort if the endpoint function driver is not bound to
> endpoint device and the notify is called.
> 

I don't think so. We are iterating the "epc->pci_epf" list, which will only be
populated if a EPF driver gets bind to an endpoint device.

> This would also require all function drivers to have event_ops populated.
> IOW this could break pci-epf-ntb.c.
> 

This I missed. I will add a check for the "epf->event_ops" existence first.

Thanks,
Mani

> Thanks,
> Kishon

-- 
மணிவண்ணன் சதாசிவம்
