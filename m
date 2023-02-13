Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DE0695413
	for <lists+linux-pci@lfdr.de>; Mon, 13 Feb 2023 23:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjBMWvN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Feb 2023 17:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjBMWvM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Feb 2023 17:51:12 -0500
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E57F20D13;
        Mon, 13 Feb 2023 14:51:11 -0800 (PST)
Received: by mail-pj1-f51.google.com with SMTP id a8-20020a17090a6d8800b002336b48f653so12405555pjk.3;
        Mon, 13 Feb 2023 14:51:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eaCOkjRgOPVSqSFnQnaCyCMQTSH93zOmQIZaCaVkP4g=;
        b=GcTaHt6CbITzdjIsTDP58SFAceZEQeug1PnRbBuqFrAzaLw46SsIDXqByRxS0UnLc8
         Ypu9Dyf+8K2dOENxe+u1tJyvkfp/IyQYBQzX3WAmzyz/1nL7PVplezZxb266ubyQaPKY
         LhtHoowjPUcFpV1FP4xrQ5eLxmJIFuPWYyqUu4pOVY8zz6peyboVE/5R5O8MlVscjhXv
         YoG5GYKFQo5wIxOLe/gdpNfdzYjhl4LDCy/a4qJQybf7JlApTgCykyAaO/MPiruqRlpk
         fZnRVJkSotIGKHZC11FgmLt+nrC0xmKP3ObGL4ZhtNFI3SXfsSl7wMvGikW/akBVHEj9
         mmeA==
X-Gm-Message-State: AO0yUKUZZ47REY9qCZKebDk4DI8Vw1WIp515wStF91dn421O7q9wq3lq
        aYYGDNqE18v1PPxXSMubJBSpVZyb5pc=
X-Google-Smtp-Source: AK7set+s8kytI1QMBcYaNIA9/2K9gPfKG9pUdDrraXiaSFtiwmbe5YGDO0kTOaQvQaZMm/8LQ3SbMg==
X-Received: by 2002:a17:902:f251:b0:19a:7e03:c4fd with SMTP id j17-20020a170902f25100b0019a7e03c4fdmr487210plc.0.1676328670882;
        Mon, 13 Feb 2023 14:51:10 -0800 (PST)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d23-20020a170902aa9700b00198f36a8941sm6800920plr.221.2023.02.13.14.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 14:51:10 -0800 (PST)
Date:   Tue, 14 Feb 2023 07:51:07 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     kishon@kernel.org, lpieralisi@kernel.org, bhelgaas@google.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh@kernel.org, vidyas@nvidia.com, vigneshr@ti.com
Subject: Re: [PATCH v5 0/5] PCI: endpoint: Rework the EPC to EPF notification
Message-ID: <Y+q+2zBWoyXd041n@rocinante>
References: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230124071158.5503-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

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
[...]

Applied to pci/endpoint, thank you!

[01/05] PCI: dra7xx: Use threaded IRQ handler for "dra7xx-pcie-main" IRQ
        https://git.kernel.org/pci/pci/c/da87d35a6e51

[02/05] PCI: tegra194: Move dw_pcie_ep_linkup() to threaded IRQ handler
        https://git.kernel.org/pci/pci/c/c2cc5cdda46c

[03/05] PCI: endpoint: Use a separate lock for protecting epc->pci_epf list
        https://git.kernel.org/pci/pci/c/d6dd5bafaabf

[04/05] PCI: endpoint: Use callback mechanism for passing events from EPC to EPF
        https://git.kernel.org/pci/pci/c/838125b07e77

[05/05] PCI: endpoint: Use link_up() callback in place of LINK_UP notifier
        https://git.kernel.org/pci/pci/c/f5edd8715e2e

	Krzysztof
