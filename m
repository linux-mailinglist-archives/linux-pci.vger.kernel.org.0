Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA49A62766B
	for <lists+linux-pci@lfdr.de>; Mon, 14 Nov 2022 08:33:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235667AbiKNHd1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Nov 2022 02:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235468AbiKNHd0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Nov 2022 02:33:26 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864F2B2
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 23:33:23 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id b185so10219544pfb.9
        for <linux-pci@vger.kernel.org>; Sun, 13 Nov 2022 23:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ci7EEHbshcFehJfZ1vhA/3zbDhlLQ5SlERB0/duNlh8=;
        b=y3sTF4hmY4khAQzxD5W0lpR+G1orJovJ5WNYYWsHTSyjMcgBjhMkaiOKdjckMTBiSh
         vh2JE+gHWRkYtjJoGRqNcDFThmcgZ3HDTXz4t768hG1xHySziZr6AG6FeEXAHrWsdLcY
         SoFCnu7xK8reZ4yDWPnDrdBf/SDCBNPE+xlm3Qsz/JZglETSwzmQ5uRroMSLDpE3gk/e
         Qt9aUnUTI21HApCAfmG9Ea0xI5FsXzBMCinDKk0fGzcoHt1oqpAXXut11zfY0T/wZcol
         5gaB+iO7F/tNZyVlMi2ANbPrZljhp4bUCyrGnGb4yq2dlMZhj3TYphO8NvVFGWUy0HW7
         gB4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ci7EEHbshcFehJfZ1vhA/3zbDhlLQ5SlERB0/duNlh8=;
        b=1UNoZ7Z3vEPqZFoNGraM62NdpmGo+feHuDVolFU9G9XnL5kqNaQnTmSyOakmyEuNVL
         j16YRgex+Avcd92+s0ykUcQFS4n4tirI4oNdwQI6CLezbSNriBMMT9810Ym4czA6e/69
         wQc+/qisE8GZ4iRfUvWLt8z5gtIUyyEtdIVzqsWpXzkpjoMpD3WLTg4YX9T+mjlOee9N
         ngPRT0cSYOjaDYs/Atw+j8NRsHHIDhBuL4YfAOzUet0LfLWa48pOqYOd/gQx8rCAepyw
         6GGkw5t7BGfqrJr2+Ggfob+uGWt2WtCV3el1Ax8jFPAEbbIivb8T3aPHDI7/6FI/GtW7
         AGYQ==
X-Gm-Message-State: ANoB5plFc0VsxMng9Zz8olHKE43XZB1kBxVnl0Gr6DqCRHRiQ6VhrsOG
        176Pj7VV5OnvwGgnpRcypqJQ
X-Google-Smtp-Source: AA0mqf7pnXSPJUmcLy5E7oq1swZ5WkTvgCA6ttdHUuKrnr9k9Qhvivs0XObyuY2+UptCt2a0b/0dqg==
X-Received: by 2002:aa7:8813:0:b0:56b:f64b:b385 with SMTP id c19-20020aa78813000000b0056bf64bb385mr12648979pfo.68.1668411202990;
        Sun, 13 Nov 2022 23:33:22 -0800 (PST)
Received: from thinkpad ([117.248.0.54])
        by smtp.gmail.com with ESMTPSA id w7-20020a654107000000b0043ae1797e2bsm5215425pgp.63.2022.11.13.23.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 23:33:21 -0800 (PST)
Date:   Mon, 14 Nov 2022 13:03:16 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     lpieralisi@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com,
        kishon@kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v4 0/5] PCI: endpoint: Rework the EPC to EPF notification
Message-ID: <20221114073316.GI3869@thinkpad>
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

Lorenzo, can this series be merged for v6.2 since all the patches are reviewed
now?

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
