Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40202465993
	for <lists+linux-pci@lfdr.de>; Wed,  1 Dec 2021 23:55:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353722AbhLAW6d (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 17:58:33 -0500
Received: from mail-oi1-f181.google.com ([209.85.167.181]:41533 "EHLO
        mail-oi1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343872AbhLAW6c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Dec 2021 17:58:32 -0500
Received: by mail-oi1-f181.google.com with SMTP id u74so51774986oie.8;
        Wed, 01 Dec 2021 14:55:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ib/q2WdtptujHEB1lSaLIrDhy6pKI5PXBCEmpVwVMTc=;
        b=wmMFlxH2H5vX194tEXwow9kvI7nSn5ZFuYw1v+WuU242gr7NeAbcxFsPNCikpJY9t/
         0yRRZc0Twv14l7j8DgcvZfUexGQSJ25N1bRzYzU928k0upL8B7Rg0EeJPJt4WIWZKaNi
         J9gp9+kRLUU/klu4mSize5r9YMI4T25FsznYy/xG31SB8k/E/geQT7LziJ70uqEXwakw
         fwSuDIz6HeGWV6nRFmTfejQWFWVeu9P5bBqlFYHFYGXyY8/4pkVeu1va6i7uitITm3xa
         DWe5flxPcbp92QXV1LAyuv+vMrQDImQDsFpXteeYYW5LnYsZ1Zs4rFoHffDgmDnqPLT3
         uGPQ==
X-Gm-Message-State: AOAM533aId674PSxgTGmX3V5wSNTZGZghen3LfPB32yQx25LpetQSGJ+
        LYatUWyY1gXOXcWu7qsaRg==
X-Google-Smtp-Source: ABdhPJycbEcaMETSqXei9OfAshaCZRuZAW9lmaRdJVOfv6dvTwQ/VYgm04Ezv1ZyHkpShGuTXfHpeA==
X-Received: by 2002:a05:6808:14e:: with SMTP id h14mr1291601oie.28.1638399311073;
        Wed, 01 Dec 2021 14:55:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q9sm444496oti.32.2021.12.01.14.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 14:55:10 -0800 (PST)
Received: (nullmailer pid 3020368 invoked by uid 1000);
        Wed, 01 Dec 2021 22:55:09 -0000
Date:   Wed, 1 Dec 2021 16:55:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/5] dt-bindings: PCI: ti,am65: Fix
 "ti,syscon-pcie-id"/"ti,syscon-pcie-mode" to take argument
Message-ID: <Yaf9TbHHdT7RMSSd@robh.at.kernel.org>
References: <20211126083119.16570-1-kishon@ti.com>
 <20211126083119.16570-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211126083119.16570-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 26 Nov 2021 14:01:15 +0530, Kishon Vijay Abraham I wrote:
> Fix binding documentation of "ti,syscon-pcie-id" and "ti,syscon-pcie-mode"
> to take phandle with argument. The argument is the register offset within
> "syscon" used to configure PCIe controller. Similar change for j721e is
> discussed in [1]
> 
> [1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/ti,am65-pci-ep.yaml  |  8 ++++++--
>  .../bindings/pci/ti,am65-pci-host.yaml           | 16 ++++++++++++----
>  2 files changed, 18 insertions(+), 6 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
