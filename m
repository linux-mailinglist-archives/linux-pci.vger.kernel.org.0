Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B17CAA5824
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 15:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731387AbfIBNjf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 09:39:35 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40860 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731280AbfIBNjR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 09:39:17 -0400
Received: by mail-wm1-f68.google.com with SMTP id t9so14651346wmi.5;
        Mon, 02 Sep 2019 06:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:date:from:subject:references
         :in-reply-to:cc:cc:to;
        bh=mdMEyHANWr3uFXlguLTgUNjt9G7yervbWu2Ux/GAB0I=;
        b=onPidkbw27Hed+VSSexQp04PD9a75u/z6+9x03Of/I5z2M6BV8nGOnRAy3Qtf6YBv9
         Tpnw3xz2jrelpXitQGccpp+QzlFAFtGiUkuMBfYUtwx/2LhzLoR/VF/uFOJtFCtf641L
         vxmq6m+oEQULMEGh/zvi1waoaBypTGEWBXreQRQTU5hoU82VeZPOC/Ll2taQ1Te6isYf
         5Wfj05I/t+GnykDN01ROqVbYTMlEsjzelPY1TUFUi39iPRqB4z2uGlxQW96Mn/o3hPl1
         GgjZRIFZRhMFdpuHGCYFIdU/NaJfRU/ivE8t0o5/CvHtRjUcxAEzeLk67AlCHIJ8ZVJP
         A2qw==
X-Gm-Message-State: APjAAAXClDoub0xi1hJH5pJmiztGMrM46CAs1WyZPsxf/NlsanGi+max
        dSEt76TY+9j7IbQRQw7dBQ==
X-Google-Smtp-Source: APXvYqwMzwv1OFbk9jMbIrvjNPmwN4pGid61E7yY74F5cVWue5sDTckRsA9VxA03xcI175B+qRSeCw==
X-Received: by 2002:a7b:c84e:: with SMTP id c14mr36008947wml.46.1567431554729;
        Mon, 02 Sep 2019 06:39:14 -0700 (PDT)
Received: from localhost ([212.187.182.166])
        by smtp.gmail.com with ESMTPSA id i73sm5116549wmg.33.2019.09.02.06.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2019 06:39:14 -0700 (PDT)
Message-ID: <5d6d1b82.1c69fb81.de44.60b9@mx.google.com>
Date:   Mon, 02 Sep 2019 14:39:13 +0100
From:   Rob Herring <robh@kernel.org>
Subject: Re: [PATCH] PCI: Remove unused includes and superfluous struct declaration
References: <20190901112506.8469-1-kw@linux.com>
In-Reply-To: <20190901112506.8469-1-kw@linux.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Joerg Roedel <joro@8bytes.org>, Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
To:     Krzysztof Wilczynski <kw@linux.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun,  1 Sep 2019 13:25:06 +0200, Krzysztof Wilczynski wrote:
> Remove <linux/pci.h> and <linux/msi.h> from being included
> directly as part of the include/linux/of_pci.h, and remove
> superfluous declaration of struct of_phandle_args.
> 
> Move users of include <linux/of_pci.h> to include <linux/pci.h>
> and <linux/msi.h> directly rather than rely on both being
> included transitively through <linux/of_pci.h>.
> 
> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
>  drivers/iommu/of_iommu.c                          | 2 ++
>  drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
>  drivers/pci/controller/pci-aardvark.c             | 1 +
>  drivers/pci/pci.c                                 | 1 +
>  drivers/pci/probe.c                               | 1 +
>  include/linux/of_pci.h                            | 4 +---
>  6 files changed, 7 insertions(+), 3 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

