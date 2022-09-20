Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC3675BE8C7
	for <lists+linux-pci@lfdr.de>; Tue, 20 Sep 2022 16:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231603AbiITOYr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 10:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiITOYT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 10:24:19 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAACA60F7
        for <linux-pci@vger.kernel.org>; Tue, 20 Sep 2022 07:24:05 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id y136so2917942pfb.3
        for <linux-pci@vger.kernel.org>; Tue, 20 Sep 2022 07:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date;
        bh=tw5JepNVuSemI8iTe0VhXImI4+meN0vkWPMfuC7p/uA=;
        b=V1tJfP21tPSRjuZucdUla75lyyVUE4/LJ8/Eg2g2yTfgsFYdvxH3zhs4Z0L1ld2RzR
         YCBUGSsOrroJJUWxulke4YV5OWXffPug6HKl69swib4DxWiNwocYD/a6kEdjZScRlu0Q
         kklAlvxWQ5uttby+fLYdaeL/ohMOQnsh0dOnrda1IB2vdzfS4ipG1DcuK+MJFx5hipK2
         LmqBvN9dDREvPLMWXSCzPGNGsN8ULNaqKRThVqdWvlRHOyfNT2NbtEwSLPXeROk2gW7o
         xvYzVBchhm95jvo7WhFQRd+Hc+yXGu+6VE57Yrs4vuV/4t68Yv/jVEJ9QvAzx56Kxw7X
         322w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=tw5JepNVuSemI8iTe0VhXImI4+meN0vkWPMfuC7p/uA=;
        b=CcOMTOvpnu1hkS9JNKtxrkRswh2wW98sOJRB7kBMVaFmV4AbgB55w0djgFN7f1x3xW
         voH32NsWUdPK1f47LmcGSjnzcvC/SCIwPmDUx5Yy7vv6V68+ueZxhvyMnOnT0pob2Vr4
         bg8pPXe2LZNjEQ4DmWN1ldr2BkYRSgpNdgZEdobA4vvF33SjWCMWtUYkKekNTIdcNbNl
         l6p0KgyOPXW0uRZgUC7oeHML5ESXDE6jbL9OHKIew8BUWAQeT+AHfcNgyPCrYJEYjESR
         17EZAMUG3J6pdqi9Nm0iJThfwQR4wz7x0+fYm1Bwr3uL8kcA4WuAEkM4SNsK8BPENqpf
         VkjQ==
X-Gm-Message-State: ACrzQf1MZnSHWxBCFzu/cm1wv7aqgHW0Ru0CQ80cZb/r3Xh1m/5uhjBU
        9AesQiyIj6EwUIZ8sSaXHU6C
X-Google-Smtp-Source: AMsMyM7SaHcyLpR02pe1wD1J8Vkp9UMa8vcgfb3RlXCgdzNfWqiCxD+NtKfn2UDZANn5q5Uj+WDtdw==
X-Received: by 2002:aa7:9d9a:0:b0:53e:8bc5:afb7 with SMTP id f26-20020aa79d9a000000b0053e8bc5afb7mr23749586pfq.54.1663683845090;
        Tue, 20 Sep 2022 07:24:05 -0700 (PDT)
Received: from thinkpad ([220.158.159.29])
        by smtp.gmail.com with ESMTPSA id j6-20020a170903024600b0017732e4003bsm1504313plh.141.2022.09.20.07.24.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Sep 2022 07:24:03 -0700 (PDT)
Date:   Tue, 20 Sep 2022 19:53:55 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     lpieralisi@kernel.org, bhelgaas@google.com, kw@linux.com,
        robh@kernel.org, vidyas@nvidia.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/3] PCI: endpoint: Use link_up() callback in place of
 LINK_UP notifier
Message-ID: <20220920142355.GB1621196@thinkpad>
References: <20220910090508.61157-1-manivannan.sadhasivam@linaro.org>
 <20220910090508.61157-4-manivannan.sadhasivam@linaro.org>
 <04506b2a-dbcb-0bb5-496e-35ccfc9cc18b@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <04506b2a-dbcb-0bb5-496e-35ccfc9cc18b@ti.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Mon, Sep 19, 2022 at 02:28:33PM +0530, Kishon Vijay Abraham I wrote:
> Hi Mani,
> 
> On 10/09/22 14:35, Manivannan Sadhasivam wrote:
> > As a part of the transition towards callback mechanism for signalling the
> > events from EPC to EPF, let's use the link_up() callback in the place of
> > the LINK_UP notifier. This also removes the notifier support completely
> > from the PCI endpoint framework.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/endpoint/functions/pci-epf-test.c | 33 ++++++-------------
> >  drivers/pci/endpoint/pci-epc-core.c           | 12 +++++--
> >  include/linux/pci-epc.h                       |  8 -----
> >  include/linux/pci-epf.h                       |  8 ++---
> >  4 files changed, 22 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> > index 868de17e1ad2..f75045f2dee3 100644
> > --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > @@ -826,30 +826,21 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
> >  	return 0;
> >  }
> >  
> > -static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> > -	.core_init = pci_epf_test_core_init,
> > -};
> > -
> > -static int pci_epf_test_notifier(struct notifier_block *nb, unsigned long val,
> > -				 void *data)
> > +int pci_epf_test_link_up(struct pci_epf *epf)
> >  {
> > -	struct pci_epf *epf = container_of(nb, struct pci_epf, nb);
> >  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> >  
> > -	switch (val) {
> > -	case LINK_UP:
> > -		queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
> > -				   msecs_to_jiffies(1));
> > -		break;
> > -
> > -	default:
> > -		dev_err(&epf->dev, "Invalid EPF test notifier event\n");
> > -		return NOTIFY_BAD;
> > -	}
> > +	queue_delayed_work(kpcitest_workqueue, &epf_test->cmd_handler,
> > +			   msecs_to_jiffies(1));
> >  
> > -	return NOTIFY_OK;
> > +	return 0;
> >  }
> >  
> > +static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> > +	.core_init = pci_epf_test_core_init,
> > +	.link_up = pci_epf_test_link_up,
> > +};
> > +
> >  static int pci_epf_test_alloc_space(struct pci_epf *epf)
> >  {
> >  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> > @@ -976,12 +967,8 @@ static int pci_epf_test_bind(struct pci_epf *epf)
> >  	if (ret)
> >  		epf_test->dma_supported = false;
> >  
> > -	if (linkup_notifier || core_init_notifier) {
> > -		epf->nb.notifier_call = pci_epf_test_notifier;
> > -		pci_epc_register_notifier(epc, &epf->nb);
> > -	} else {
> > +	if (!linkup_notifier && !core_init_notifier)
> >  		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
> > -	}
> >  
> >  	return 0;
> >  }
> > diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> > index ba54f17ae06f..5dac1496cf16 100644
> > --- a/drivers/pci/endpoint/pci-epc-core.c
> > +++ b/drivers/pci/endpoint/pci-epc-core.c
> > @@ -690,10 +690,19 @@ EXPORT_SYMBOL_GPL(pci_epc_remove_epf);
> >   */
> >  void pci_epc_linkup(struct pci_epc *epc)
> >  {
> > +	struct pci_epf *epf;
> > +
> >  	if (!epc || IS_ERR(epc))
> >  		return;
> >  
> > -	atomic_notifier_call_chain(&epc->notifier, LINK_UP, NULL);
> > +	mutex_lock(&epc->list_lock);
> 
> This will break pci-dra7xx which invokes pci_epc_linkup() in interrupt
> context.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pci-dra7xx.c#n332
> 

Ah, sorry missed this one.

> dra7xx_pcie_irq_handler()
> 	|
> 	|
> 	dw_pcie_ep_linkup()

This doesn't look right to me. IRQ handlers are supposed to execute quickly and
not block for long time. Here the EPF drivers are free to consume more time if
they want and that will block the IRQ handler.

Since the IRQ handler is just reporting the IRQs and calling link_up handler,
it looks like it should be made as a threaded IRQ as like other DWC drivers.

Thoughts?

Thanks,
Mani

> 		|
> 		|
> 		pci_epc_linkup()
> 			|
> 			|
> 			mutex_lock()
> 
> Thanks,
> Kishon

-- 
மணிவண்ணன் சதாசிவம்
