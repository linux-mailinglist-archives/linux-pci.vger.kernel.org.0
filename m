Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BD9C61D7F9
	for <lists+linux-pci@lfdr.de>; Sat,  5 Nov 2022 07:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiKEGxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 5 Nov 2022 02:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiKEGxu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 5 Nov 2022 02:53:50 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83269140D6
        for <linux-pci@vger.kernel.org>; Fri,  4 Nov 2022 23:53:48 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q71so6145137pgq.8
        for <linux-pci@vger.kernel.org>; Fri, 04 Nov 2022 23:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=spqUCiWZo+MTX7gTrHIIYbpr2WVSxFKmPwib1nju6j0=;
        b=vCsvXpteUbvdxcyhUwgBbkS7JDK6vIpRhapWfumJik5YymwhByNlMCGeqSpgXhYw/k
         wDAhJUnTJ/l/8ChQJqwHBBFbVYrAFz+455zA+u0J0vFq3+Fv0oPXyO2Yo8yYsJZJPc4F
         ybr/mELOAE7KFyRqYOJ9RUdN5nX2MCQQqK/eClhpf3tbtSaW9MUZKtIovYnK6dJkwwRD
         wJNgSKT39a10xwVasH257lJNRPFoRPFhxQiLpHNT1CrXpT4xCGyjuVpmenkcuZPB2hUT
         Zlfx6JET0RzcNOVxswtJ07cWDEZ47vLdJIcx1+NTdICsw3z23Olq4g1QGEE8ybOFUGGr
         Uvdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=spqUCiWZo+MTX7gTrHIIYbpr2WVSxFKmPwib1nju6j0=;
        b=6pXEuiakCXqopcB+WSU2cEcOHByoqsKmpU3rVBOhwI3Fv4cnXx9Fz25Fk0zjmbNtkE
         r9gNt59rD75f8B0uZbtawhj3kWaejTpCOZ5W31UN88H68JSLUjTZob5hoYVMxNb1WILA
         pVkskxt87x+3RPUu6RD+77Ps9bNZBK5BhYeRJ1XIZ1hIU00IStFARfwftwjVnUxv9mB+
         rc3lV5Hky+SlfIcsWq/fyWbKQo0sk5+Dy+LgXnTN7oxMMLiJPgcXBkhfHAhViCQCu+Hi
         5JkfP3IPAGrrpbREsTD1OEfZTcve3GdoAdhP/BE4+1NoKxhyLZgqo8acK72FLHvkCH1y
         +FWA==
X-Gm-Message-State: ACrzQf3OoRjzkNjhonDtoP77g5+Wqpdfi4KAsMC3XMWQIX3tKjREuuu7
        yXOEXxpIYVW8KGreIw9aGPf4sDiwHETj
X-Google-Smtp-Source: AMsMyM5N2FhE/o8kj7rOhMh6xZCjBZiv0KSswsPslcJfG88j0WMERTeAbn/Rt39M6TXAOBiCJvxgqA==
X-Received: by 2002:a05:6a00:24cb:b0:56c:7815:bc7d with SMTP id d11-20020a056a0024cb00b0056c7815bc7dmr39946304pfv.44.1667631227974;
        Fri, 04 Nov 2022 23:53:47 -0700 (PDT)
Received: from thinkpad ([117.217.186.6])
        by smtp.gmail.com with ESMTPSA id v126-20020a626184000000b00565cf8c52c8sm666527pfb.174.2022.11.04.23.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 23:53:45 -0700 (PDT)
Date:   Sat, 5 Nov 2022 12:23:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        kvijayab@amd.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com
Subject: Re: [PATCH v4 0/5] PCI: endpoint: Rework the EPC to EPF notification
Message-ID: <20221105065337.GA109545@thinkpad>
References: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221025145101.116393-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Kishon,

On Tue, Oct 25, 2022 at 08:20:56PM +0530, Manivannan Sadhasivam wrote:
> Hello,
> 
> During the review of the patch that fixes DBI access in PCI EP, Rob
> suggested [1] using a fixed interface for passing the events from EPC to
> EPF instead of the in-kernel notifiers.
> 
> This series introduces a simple callback based mechanism for passing the
> events from EPC to EPF. This interface is chosen for satisfying the below
> requirements:
> 
> 1. The notification has to reach the EPF drivers without any additional
> latency.
> 2. The context of the caller (EPC) needs to be preserved while passing the
> notifications.
> 
> With the existing notifier mechanism, the 1st case can be satisfied since
> notifiers aren't adding any huge overhead. But the 2nd case is clearly not
> satisfied, because the current atomic notifiers forces the EPF
> notification context to be atomic even though the caller (EPC) may not be
> in atomic context. In the notification function, the EPF drivers are
> required to call several EPC APIs that might sleep and this triggers a
> sleeping in atomic bug during runtime.
> 
> The above issue could be fixed by using a blocking notifier instead of
> atomic, but that proposal was not accepted either [2].
> 
> So instead of working around the issues within the notifiers, let's get rid
> of it and use the callback mechanism.
> 
> NOTE: DRA7xx and TEGRA194 drivers are only compile tested. Testing this series
> on the real platforms is greatly appreciated.
> 

Any feedback on this series?

Thanks,
Mani

> Thanks,
> Mani
> 
> [1] https://lore.kernel.org/all/20220802072426.GA2494@thinkpad/T/#mfa3a5b3a9694798a562c36b228f595b6a571477d
> [2] https://lore.kernel.org/all/20220228055240.24774-1-manivannan.sadhasivam@linaro.org
> 
> Changes in v4:
> 
> * Added check for the presence of event_ops before involing the callbacks (Kishon)
> * Added return with IRQ_WAKE_THREAD when link_up event is found in the hard irq
>   handler of tegra194 driver (Vidya)
> * Collected review tags
> 
> Changes in v3:
> 
> * As Kishon spotted, fixed the DRA7xx driver and also the TEGRA194 driver to
>   call the LINK_UP callback in threaded IRQ handler.
> 
> Changes in v2:
> 
> * Introduced a new "list_lock" for protecting the epc->pci_epf list and
>   used it in the callback mechanism.
> 
> Manivannan Sadhasivam (5):
>   PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
>   PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
>   PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
>   PCI: endpoint: Use callback mechanism for passing events from EPC to
>     EPF
>   PCI: endpoint: Use link_up() callback in place of LINK_UP notifier
> 
>  drivers/pci/controller/dwc/pci-dra7xx.c       |  2 +-
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  9 ++++-
>  drivers/pci/endpoint/functions/pci-epf-test.c | 38 ++++++-------------
>  drivers/pci/endpoint/pci-epc-core.c           | 32 ++++++++++++----
>  include/linux/pci-epc.h                       | 10 +----
>  include/linux/pci-epf.h                       | 19 ++++++----
>  6 files changed, 59 insertions(+), 51 deletions(-)
> 
> -- 
> 2.25.1
> 

-- 
மணிவண்ணன் சதாசிவம்
