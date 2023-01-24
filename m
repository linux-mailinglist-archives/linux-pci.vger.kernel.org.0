Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99B1D6791BE
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jan 2023 08:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233471AbjAXHQR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Jan 2023 02:16:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233479AbjAXHQN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Jan 2023 02:16:13 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32B73C36
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 23:16:11 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id 5so8578067plo.3
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 23:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SiurnOYAkeKt29fHrAzebFb+oWYWVydRMZlV3KhJgps=;
        b=FIEUh4JxydUOaCsXsiTa4mg/Yx4/E35uzA6fUk4BLH+osNOAqiLKTI+Bh7khgxLGpz
         LiyB/RxEwe1voPsIZsn2Jm54v/4OK/Q3980vm1SHgI3Rv0LL2A7zKDpvLGg+te33hZAm
         L6JkFomSbbmFmYeE+wgXyadq7dx8GgWj0hDYmBJORKpSQNgVWm1IHKfiaccGdYvMEp02
         wFqM4axXMSoll1urC1zBGQufqGIqTdrRtHp475dwAOapcVSjosLIRS10c8fYLWXodpvD
         X5IGvHGiyu75LneBXq2ASRWA3bhQPwtvwguDw/tyulIl1ti+6rwGsxcbg5VxVhdClxxJ
         dNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SiurnOYAkeKt29fHrAzebFb+oWYWVydRMZlV3KhJgps=;
        b=VSO2HAxKsCk4hC0h325TuYB9fTg76romxslxHiOv6Vs/1bXHaQrLuWHvr2FjL4a3r0
         2qZWttVnKa6FflZR0/VxkoEaktf1qrSDpCRd4FPHkURaOmsihO99xV+ITb7HcQNTuCuq
         Lad3h+ZhRJ+s+pTrBnmcAdA9pRwnmqolvoxuTZFv0K4DMW4CjYBuH7+qvXmyCK8siXke
         wBiCQFs0YYAsbz5rO65jd6f3LWjrJGnHO9ghUEAf57tIWh/2/J6Fyt4pbMwFk1dtPdKm
         phm5Ai3pI6hi7b/JtEhUWPHvYRUN7hh47a6wyadfiKiJ0UlOz5lTpR4Wos2E7o6ImcfN
         euYw==
X-Gm-Message-State: AFqh2kplRDbtKt2SdCxQfPyYNuXGDrtziglHcSuUhuPncV0NeS/ij111
        ryIkrOlU3xyqFRrUzKO6AuLT
X-Google-Smtp-Source: AMrXdXu4mi6dvGvEO/n/C5xxXN1FLj9XQ2O0zlWnVWpPCjshvxCfAR8WoMfy5X7ZEJve9bf9pc0YkQ==
X-Received: by 2002:a05:6a20:be03:b0:b8:5813:e700 with SMTP id ge3-20020a056a20be0300b000b85813e700mr37929542pzb.3.1674544571225;
        Mon, 23 Jan 2023 23:16:11 -0800 (PST)
Received: from thinkpad ([117.193.209.165])
        by smtp.gmail.com with ESMTPSA id ja5-20020a170902efc500b001930b189b32sm883146plb.189.2023.01.23.23.16.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 23:16:10 -0800 (PST)
Date:   Tue, 24 Jan 2023 12:46:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com, robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com
Subject: Re: [PATCH v5 0/5] PCI: endpoint: Rework the EPC to EPF notification
Message-ID: <20230124071602.GB4947@thinkpad>
References: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 24, 2023 at 12:41:53PM +0530, Manivannan Sadhasivam wrote:
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

Lorenzo, all patches in this series got review tags. Can you please merge now?

Thanks,
Mani

> Thanks,
> Mani
> 
> [1] https://lore.kernel.org/all/20220802072426.GA2494@thinkpad/T/#mfa3a5b3a9694798a562c36b228f595b6a571477d
> [2] https://lore.kernel.org/all/20220228055240.24774-1-manivannan.sadhasivam@linaro.org
> 
> Changes in v5:
> 
> * Collected review tag from Vidya
> * Fixed the issue reported by Kbot regarding missing declaration
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
