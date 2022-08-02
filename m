Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C4C587DE6
	for <lists+linux-pci@lfdr.de>; Tue,  2 Aug 2022 16:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiHBOHt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 2 Aug 2022 10:07:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbiHBOHs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 2 Aug 2022 10:07:48 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D68D2873C
        for <linux-pci@vger.kernel.org>; Tue,  2 Aug 2022 07:07:46 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id d7so9393043pgc.13
        for <linux-pci@vger.kernel.org>; Tue, 02 Aug 2022 07:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=acF7ZCk4WIBI8dJLq1aR0dvVY72jyDExunnoKB1PStM=;
        b=aJwNI/3IF4eENAEWFgkLc8UNtc/P8cvQC7OjD1ZvwwucjkHlyLuNy5Ee89vRztKD7e
         TdGJM89fx6P3VvpdFW9r4eP0zqu+VC9w1K2D19eBOiGIwPAHoPpZpL2aijIJBWW3eHru
         d9SUcYDQ6R9xK04aItM0+Kbvzfdxpw93khv2AVN1eA39CtmgurdO5OHa9ruaoHzovV7+
         XtqbtTD2fyWDY22GIIABlK6nZnWz588UYzx7GK2o0iyxU2/BtE7Eo/fY7phXXXoCi6De
         vk3rqgQnl6DOO3mXXd7U8m9mf+ZFYbtt6PU9l5XTmDCZX3h8pgkhTcKgJnFZnUYTmOJj
         KFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=acF7ZCk4WIBI8dJLq1aR0dvVY72jyDExunnoKB1PStM=;
        b=HrXxP4CF2CxsmYc3ay3ZC6vjtvgBIY1ZQOl9YpFgoEvrxubxIF/CVHSbv7KLGTBytT
         4dj43wulvCZ6bhllC5ts+GFVpgH4jNw4uSbrgLN9ZgQBeFFO7NMfgLK1xN5L7Dodesgs
         9RuIvSMwWCotM4prNtVJ2wuOVpgb33o9GPU0eJDebgnAVlTPxfrr0LiKUhMRj2YszHN2
         y/OR+TRnSXI+2QcpqJUuosdrH+iBNdx6q04HVXPBDNMtsADG+bY8VGPLQekXMu+Svkfu
         cuLVpATVPVe0uu/bvwZcmNTaOodP6k1uiE78O3gI6eoU+RQIkN/vJjb/HCo40KtImy21
         xjiA==
X-Gm-Message-State: AJIora8fkDqLyWeGhxXS2LiPgW2x3RMjYL9J09zlC6hDCzNhSaqOAisc
        p5ZhUvjp/80XvT6ZnwfviSnv
X-Google-Smtp-Source: AGRyM1tWFqySTRtL5/9s1GCTp0QCFnFQwXrJMCts0H48FyP9BMibCdmk9RKIUM8zQeOYgQUcBCPt3w==
X-Received: by 2002:a63:4857:0:b0:41a:d6ca:9975 with SMTP id x23-20020a634857000000b0041ad6ca9975mr17196245pgk.102.1659449266014;
        Tue, 02 Aug 2022 07:07:46 -0700 (PDT)
Received: from thinkpad ([117.193.215.193])
        by smtp.gmail.com with ESMTPSA id b13-20020a65578d000000b00419fc2c27d8sm9306640pgr.43.2022.08.02.07.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 07:07:45 -0700 (PDT)
Date:   Tue, 2 Aug 2022 19:37:38 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Vidya Sagar <vidyas@nvidia.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Krishna Thota <kthota@nvidia.com>,
        Manikanta Maddireddy <mmaddireddy@nvidia.com>,
        sagar.tv@gmail.com, Xiaowei Bao <xiaowei.bao@nxp.com>,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Message-ID: <20220802140738.GA115652@thinkpad>
References: <051a3baf-b4dd-7764-2e61-03584cefb4d3@nvidia.com>
 <20220729224404.GA478920@bhelgaas>
 <20220730145025.GA4005@thinkpad>
 <CAL_Jsq+tnLMcKGxzTJODQjCUTXU1yoMS2yF3WxEEfMmfgRt5uQ@mail.gmail.com>
 <20220802072426.GA2494@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220802072426.GA2494@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 02, 2022 at 12:54:37PM +0530, Manivannan Sadhasivam wrote:
> On Mon, Aug 01, 2022 at 02:27:14PM -0600, Rob Herring wrote:
> > On Sat, Jul 30, 2022 at 8:50 AM Manivannan Sadhasivam
> > <manivannan.sadhasivam@linaro.org> wrote:
> > >
> > > On Fri, Jul 29, 2022 at 05:44:04PM -0500, Bjorn Helgaas wrote:
> > > > [+cc Xiaowei (author of 6bfc9c3a2c70), Hou (author of 8bcca2658558)]
> > > >
> > > > On Thu, Jul 28, 2022 at 05:56:28PM +0530, Vidya Sagar wrote:
> > > > > On 7/28/2022 3:44 AM, Bjorn Helgaas wrote:
> > > > > > On Wed, Jun 22, 2022 at 09:31:33AM +0530, Vidya Sagar wrote:
> > > > > > > Platforms that cannot support their core initialization without the
> > > > > > > reference clock from the host, implement the feature 'core_init_notifier'
> > > > > > > to indicate the DesignWare sub-system about when their core is getting
> > > > > > > initialized. Any accesses to the core (Ex:- DBI) would result in system
> > > > > > > hang in such systems (Ex:- tegra194). This patch moves any access to the
> > > > > > > core to dw_pcie_ep_init_complete() API which is effectively called only
> > > > > > > after the core initialization.
> > 
> > > >   6) What's going on with the CORE_INIT and LINK_UP notifiers?
> > > >      dw_pcie_ep_init_notify() is only called by qcom and tegra.
> > > >      dw_pcie_ep_linkup() is only called by dra7xx, qcom, and tegra.
> > > >      As far as I can tell, nobody at all registers to handle those
> > > >      events except a test.  I think it's pointless to have that code
> > > >      if nobody uses it.
> > > >
> > >
> > > I have submitted an actual driver that makes use of these notifiers:
> > > https://lore.kernel.org/lkml/20220502060611.58987-9-manivannan.sadhasivam@linaro.org/
> > 
> > Notifiers aren't the best interface in the kernel. I think they are
> > best used if there's no real linkage between the sender and receiver.
> > For an EPC and EPF that's a fixed interface, so define a proper
> > interface.
> > 
> 
> Fair point! The use of notifiers also suffer from an issue where the notifier
> chain in EPC is atomic but the EPF calls some of the functions like
> pci_epc_write_header() could potentially sleep.
> 
> I'll try to come up with an interface.
> 

I thought about using a new set of callbacks that define the EPC events and
have the EPF drivers populate them during probe time. Like below,

```
diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
index e03c57129ed5..45247802d6f7 100644
--- a/include/linux/pci-epf.h
+++ b/include/linux/pci-epf.h
@@ -74,6 +74,20 @@ struct pci_epf_ops {
                                        struct config_group *group);
 };
 
+/**
+ * struct pci_epf_events - Callbacks for capturing the EPC events
+ * @init_complete: Callback for the EPC initialization complete event
+ * @link_up: Callback for the EPC link up event
+ */
+struct pci_epc_events {
+       void (*init_complete)(struct pci_epf *epf);
+       void (*link_up)(struct pci_epf *epf);
+};
+
 /**
  * struct pci_epf_driver - represents the PCI EPF driver
  * @probe: ops to perform when a new EPF device has been bound to the EPF driver
@@ -172,6 +186,7 @@ struct pci_epf {
        unsigned int            is_vf;
        unsigned long           vfunction_num_map;
        struct list_head        pci_vepf;
+       struct pci_epc_events   *events;
 };
 
 /**
```

When each of the event is received by the EPC driver, it will use the EPC API
to call the relevant event callback for _each_ EPF. Like below:

```
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 6ad9b38b63a9..4b0b30b91403 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -724,10 +724,15 @@ EXPORT_SYMBOL_GPL(pci_epc_linkdown);
  */
 void pci_epc_init_notify(struct pci_epc *epc)
 {
+       struct pci_epf *epf;
+
        if (!epc || IS_ERR(epc))
                return;
 
-       blocking_notifier_call_chain(&epc->notifier, CORE_INIT, NULL);
+       list_for_each_entry(epf, &epc->pci_epf, list) {
+               if (epf->events->init_complete)
+                       epf->events->init_complete(epf);
+       }
 }
 EXPORT_SYMBOL_GPL(pci_epc_init_notify);
```

Does this look good to you? I can spin up an RFC series, but wanted to check the
interface design beforehand.

Thanks,
Mani

> Thanks,
> Mani
> 
> > Rob
> 
> -- 
> மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
