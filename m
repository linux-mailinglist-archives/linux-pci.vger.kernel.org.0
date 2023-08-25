Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A453C788E20
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 19:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjHYR5p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 13:57:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235889AbjHYR5d (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 13:57:33 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A904128;
        Fri, 25 Aug 2023 10:57:32 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-26f6b2c8e80so790260a91.1;
        Fri, 25 Aug 2023 10:57:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692986251; x=1693591051;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Br6kJJfxbLrAeYAoyaF8n8ch2SmPfAfalV3GMRZvTyE=;
        b=bXj4wH7leWNe9LicpoIIYkOBYbBvvtG8TMegYE7ildru+s3V+IZjGyFMxDmnz1MnXY
         CKm+PlSloLhMVaVA3VEU7L4Hl4SwtJ3a6Q/AJqmlzzA5+Npz94gA+io85r6JubcMuGe2
         WF8yyXKNYKme7AfAUW2MDkqOtamGRpr+EosPjogpl9SJQ0n1Pmik8IutfT6sKBp1MK77
         fxVT2JxVlH6knnEpNdLyu1a5g6/6oF5GHbi0QaTmLw0oVotxQ3YaU9XTF4F4TvGiUn9m
         GdSMC9s5yYOcqv0MWuHvvAUKU/7AHi/bwLFyuUmYIjio9FMNEjMfU0EItq0pBBjZdlMZ
         UBwQ==
X-Gm-Message-State: AOJu0YxH07guVOexn/DG4RjMMwLmgSzgiSDdfdqC+K28fl4SEMXiCLxJ
        L7BfdLEXTOFzvVj+193tdY30iplYCXs=
X-Google-Smtp-Source: AGHT+IGlvEx6Sbm28XFJGL/dVcxNkNLmDnxcOZS7bw2GFhwadT8yB9Sl8WuTzs59URW8TP9H70V15A==
X-Received: by 2002:a17:90b:4381:b0:263:4815:cb9a with SMTP id in1-20020a17090b438100b002634815cb9amr18209467pjb.41.1692986251528;
        Fri, 25 Aug 2023 10:57:31 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id f6-20020a17090ab94600b0025bdc3454c6sm3811608pjw.8.2023.08.25.10.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 10:57:30 -0700 (PDT)
Date:   Sat, 26 Aug 2023 02:57:29 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/7] Improvements to Qcom PCIe EP and EPF MHI drivers
Message-ID: <20230825175729.GB131548@rocinante>
References: <20230606115814.53319-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606115814.53319-1-manivannan.sadhasivam@linaro.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> This series adds eDMA (embedded DMA) support to the Qcom PCIe EP and EPF 
> MHI drivers for offloading the transfers between PCIe bus and the EP
> memory. eDMA support makes use of the recently merged eDMA DMAEngine driver
> and its integration with DWC PCIe EP core [1].
> 
> This series also adds Qcom SM8450 SoC support to EPF MHI driver that has
> the eDMA support built-in.

Applied to controller/qcom-edma, thank you!

[1/7] PCI: qcom-ep: Pass alignment restriction to the EPF core
      https://git.kernel.org/pci/pci/c/8cd2b8ce48e5
[2/7] PCI: epf-mhi: Make use of the alignment restriction from EPF core
      https://git.kernel.org/pci/pci/c/e0ea11b2b094
[3/7] PCI: qcom-ep: Add eDMA support
      https://git.kernel.org/pci/pci/c/2337fff7c400
[4/7] PCI: epf-mhi: Add eDMA support
      https://git.kernel.org/pci/pci/c/827d42dbbe3b
[5/7] PCI: epf-mhi: Add support for SM8450
      https://git.kernel.org/pci/pci/c/a35318fa2d73
[6/7] PCI: epf-mhi: Use iATU for small transfers
      https://git.kernel.org/pci/pci/c/b65bdcaa7ac4
[7/7] PCI: endpoint: Add kernel-doc for pci_epc_mem_init() API
      https://git.kernel.org/pci/pci/c/bcf054a26edc

        Krzysztof
