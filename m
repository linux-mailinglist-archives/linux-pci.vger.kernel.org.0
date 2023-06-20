Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A098736B44
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 13:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjFTLnk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 07:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232720AbjFTLnb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 07:43:31 -0400
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E61E171B
        for <linux-pci@vger.kernel.org>; Tue, 20 Jun 2023 04:43:29 -0700 (PDT)
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6686708c986so2916100b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 20 Jun 2023 04:43:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687261409; x=1689853409;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0WMRdfzJXzzm7FmTkHRC1o3s/ED/9vlwKEGCEPQu8Zs=;
        b=bh35atQR1Rmi4+jZLkFb9SpSWYvz8ZfdwH/mVLPzNRxICs6t/i0XwGIXbzJ75SBQOt
         Cbf7frvab34XYnOIwbqHpV14F/pDjVSsPND2t7kjXPY0BDx+/p5TSmRKZLUy9bzXi0j4
         L7vE/YEdKucXvWcdc4F8f50BhglHMqZPrdDewVHWH02tD6T1vG822+UZ7YJEU0PvpNP7
         PIEDYOcqvjX+BeYRap+BLB/ckwpPYuJldimXpfoj6jo3DwXBp97Vw8YsyJ9IzodJvqhl
         Tisr8jGyNBuqOczkyo4cBUr0Us8l/GKOAD6lZFn8r9f4mpRk4qkUdHOZkXGmObCMkF8F
         W6Ag==
X-Gm-Message-State: AC+VfDyU/tppgSSdmiSaYJENxDh7jN9RqAuNqedEdUkhiZ/ZuN0oNkm4
        +1kNG9Wi5CXlgZgaeykU7OysXGV6M50piw==
X-Google-Smtp-Source: ACHHUZ5/IJwPkIxllDVj4sGsvgL8Ogl1vR3rNRt2+x5LYjXhua8O6tdE+MS2mWLquc8YwulYvqEAKw==
X-Received: by 2002:aa7:88c1:0:b0:668:83b6:bfe8 with SMTP id k1-20020aa788c1000000b0066883b6bfe8mr4970123pff.9.1687261408368;
        Tue, 20 Jun 2023 04:43:28 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id q24-20020a62e118000000b00666b7446219sm1199315pfh.45.2023.06.20.04.43.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 04:43:27 -0700 (PDT)
Date:   Tue, 20 Jun 2023 20:43:25 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Linux PCI <linux-pci@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?B?SsO2cmc=?= Roedel <jroedel@suse.de>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>
Subject: The VFIO/IOMMU/PCI MC at LPC 2023
Message-ID: <20230620114325.GA1387614@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello everyone!

Registration for this year's Linux Plumbers Conference[1] is now open[2],
and if you plan to attend the LPC this year, don't hesitate to register
while space is still available.

That said, on behalf of the PCI sub-system maintainers, I would like to
invite everyone to join our VFIO/IOMMU/PCI micro-conference (MC) this year.

You can find the complete MC proposal at:

  https://drive.google.com/file/d/1U3_WvPzVeP7DcTSs5FN7jZ2EtTTzUSor

We are hoping to bring together, both in person and online, everyone
interested in the VFIO, IOMMU, and PCI space to talk about the latest
developments and challenges in these areas.

If you are interested in participating in our MC and have topics to
propose, please use the official Call for Proposals (CfP) process[3]

Please get in touch with me directly if you need any assistance or have any
questions.  The deadline for proposal submissions is early August.

Join us!  We eagerly look forward to your presence and active participation
at the event.  See you there!

Thank you!

	Alex, Bjorn, Jörg, Lorenzo and Krzysztof

1. https://lpc.events
2. https://lpc.events/event/17/page/212-attend
3. https://lpc.events/event/17/abstracts
