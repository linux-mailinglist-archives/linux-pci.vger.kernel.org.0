Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDD2776F306
	for <lists+linux-pci@lfdr.de>; Thu,  3 Aug 2023 20:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231700AbjHCSvv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 14:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjHCSvu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 14:51:50 -0400
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82A3A4219;
        Thu,  3 Aug 2023 11:51:17 -0700 (PDT)
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-686d8c8fc65so950815b3a.0;
        Thu, 03 Aug 2023 11:51:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691088633; x=1691693433;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YArgeg3R+qPNvDbHRIeuLdMldAhO+zIKf3DxPW2KznU=;
        b=NswcG+EY3wNi3LM/th8U2irX3evODPVKZR91B3h8lF7gxW8Mg8XJe+Mez8vGkqiQn+
         bfPnEsdhfRHZVL+Z6Lt0VjXpHeqw2SX3tprG6VOsGDWH5i9e2DXp5/o0AjyCL/kLqoj/
         cP/q/lT+lcRt6WvwbEjZsvn6MOuD/Af+2P2RVE1WVyzlvW8GCMrGDIixbO68wiITEUwu
         4BAdcfS2CfloFIuPzjD8JTYpKW+wompjNdSmaO1U++9l9VgCfdCOEUZL26FVxuURRHq1
         IFIeUgm8X5x2EkdQzlWYirztX98p6YfLkEseKZ8eGciub8uThxAUGaT5GA6R6mwtXK+e
         dlmA==
X-Gm-Message-State: AOJu0YxKqjrGX5os+/58FwVbeHdmWhqnaNGA/PVgG0xPaV0PDPDjGotA
        CUKdMkvqn4qtEyqnvv8e2clHj1+bVNbPJfRE9CE=
X-Google-Smtp-Source: AGHT+IGWP+Ta3kBOZIn0rQ+nRm4a98cxEt/cEydrXsCKO/YlRyUFPGi373eG5NRLBbmefb/mW36skA==
X-Received: by 2002:aa7:88d3:0:b0:687:82a4:49f8 with SMTP id k19-20020aa788d3000000b0068782a449f8mr4133602pff.30.1691088633463;
        Thu, 03 Aug 2023 11:50:33 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id fk10-20020a056a003a8a00b0068718f6a035sm186346pfb.33.2023.08.03.11.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 11:50:32 -0700 (PDT)
Date:   Fri, 4 Aug 2023 03:50:31 +0900
From:   Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, lpieralisi@kernel.org,
        robh@kernel.org, bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, Sergey.Semin@baikalelectronics.ru,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V4] Revert "PCI: tegra194: Enable support for 256 Byte
 payload"
Message-ID: <20230803185031.GA3849329@rocinante>
References: <20230801204015.GA49719@bhelgaas>
 <55e8a27b-580f-8b33-f069-a05cc5322cbb@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55e8a27b-580f-8b33-f069-a05cc5322cbb@nvidia.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hello!

[...]
> > > After commit 4fb8e46c1bc4 ("PCI: tegra194: Enable support for 256 Byte
> > > payload"), we set MPS=256 for tegra194 Root Ports.
> > > 
> > > By default (CONFIG_PCIE_BUS_DEFAULT set and no "pci=pcie_bus_*"
> > > parameter), Linux configures the MPS of every device to match the
> > > upstream bridge, which is impossible if the Root Port has MPS=256
> > > and a device only supports MPS=128.
> > 
> > Thanks for pointing out that I broke this log by omitting the mention
> > of a switch.  Is the rewording below better?  If so, Krzysztof can
> > amend the commit.
> Yes. The below rewording looks good.

Updated commit at:

  https://git.kernel.org/pci/pci/c/ebfde1584d9f

Thank you everyone!

	Krzysztof
