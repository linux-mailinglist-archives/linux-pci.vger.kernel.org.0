Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0C5F73FA75
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jun 2023 12:48:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjF0KsT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Jun 2023 06:48:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjF0KsS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Jun 2023 06:48:18 -0400
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB34F10D8;
        Tue, 27 Jun 2023 03:48:17 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-66c729f5618so2867715b3a.1;
        Tue, 27 Jun 2023 03:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687862897; x=1690454897;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8kR5N8k1cATdBJ+KhZdRci8FZk5P5nCz0LfFdh3fX4=;
        b=NWDaF18hqry3cIREP7vfFyG9g6N0hWt0Eiae0MFkQ+IjDTLgpS4w6ViKPrKKS7w4Ra
         2kE3s31dAIUSJn7py54r/bPGUH4uLQ6bs4hStGMDVIi0SsPcFmxrJZ3SBeijQuF03Lhx
         04IaY4LAgzxq63Z3TFwRsypIjlksV0zN8loBAimA3xTosGHQ0hDRJYGhVElY9xVNlJ22
         Fl/r0fgi9g3aZRJzD/tGKG4nkM8DpH7qx3UOeqBRVJ9WSlYM06jzOROTNUfrtQmA1o63
         ok4s+Q7q498Pa637JdL5XsDFdmAmvkYJRUM38RP2Fu1LoSiworitELQdCYhoXbd/4IXD
         K28w==
X-Gm-Message-State: AC+VfDwCRZAPHpfhLh3Xg9rteit7DhgDdQFX+u0VKLm+eyLPWz+8//Cj
        TdkC2vDVk5RmaZFnmgo6vas=
X-Google-Smtp-Source: ACHHUZ5tgtCulcm7hoVplGcarYJQ0IMFJCwGAz7GA7wJbXixNt/NX0oiVwmcSOn6w0VAWhJilFBySw==
X-Received: by 2002:a05:6a00:c86:b0:676:76ea:e992 with SMTP id a6-20020a056a000c8600b0067676eae992mr6523213pfv.5.1687862897025;
        Tue, 27 Jun 2023 03:48:17 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d25-20020aa78159000000b0064378c52398sm5184966pfn.25.2023.06.27.03.48.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 03:48:15 -0700 (PDT)
Date:   Tue, 27 Jun 2023 19:48:14 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        Sergey.Semin@baikalelectronics.ru, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V3] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
Message-ID: <20230627104814.GA3676313@rocinante>
References: <20230619014218.1970846-1-vidyas@nvidia.com>
 <20230619102604.3735001-1-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230619102604.3735001-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello,

> This reverts commit 4fb8e46c1bc4 ("PCI: tegra194: Enable
> support for 256 Byte payload").
> 
> Consider a PCIe hierarchy with a PCIe switch and a device connected
> downstream of the switch that has support for MPS which is the minimum in
> the hierarchy, and root port programmed with an MPS in its DevCtl register
> that is greater than the minimum. In this scenario, the default bus
> configuration of the kernel i.e. "PCIE_BUS_DEFAULT" doesn't configure the
> MPS settings in the hierarchy correctly resulting in the device with
> support for minimum MPS in the hierarchy receiving the TLPs of size more
> than that. Although this can be addressed by appending "pci=pcie_bus_safe"
> to the kernel command line, it doesn't seem to be a good idea to always
> have this commandline argument even for the basic functionality to work.
> 
> Reverting commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256
> Byte payload") avoids this requirement and ensures that the basic
> functionality of the devices irrespective of the hierarchy and the MPS of
> the devices in the hierarchy.
> 
> To reap the benefits of having support for higher MPS, optionally, one can
> always append the kernel command line with "pci=pcie_bus_perf".

Applied to controller/tegra194, thank you!

[1/1] Revert "PCI: tegra194: Enable support for 256 Byte payload"
      https://git.kernel.org/pci/pci/c/606295f16360

	Krzysztof
