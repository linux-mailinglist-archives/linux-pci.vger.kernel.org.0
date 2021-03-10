Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8E533332B
	for <lists+linux-pci@lfdr.de>; Wed, 10 Mar 2021 03:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhCJCeM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Mar 2021 21:34:12 -0500
Received: from mail-io1-f52.google.com ([209.85.166.52]:32799 "EHLO
        mail-io1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231228AbhCJCeG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Mar 2021 21:34:06 -0500
Received: by mail-io1-f52.google.com with SMTP id n132so16315789iod.0;
        Tue, 09 Mar 2021 18:34:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jVJuHwNtFnhiIpdvi4iXC7hbsxDw7lapoWRXaBtbaCY=;
        b=WBo9aLGdQo6Wv9ir34Vyd3IeO76B8ZBAx2IR85L65/LPciYZmUaBx4g3dyXCD3kDnN
         RsKmfMP703Nv5Zl+UXcr3LeJYJVdDLalk44cI/+DGUBFwVs1TDPkgJ2YFkfMKrVR/OB9
         95uprE2OxNiopkPSSe5D9DpnGabzUEF4Um+G5es7hKWMwscRD5eZDe2Ri0IUlAN4zYGl
         reHALZs+XgBbxnwE5E/s+AKqlxtNIHO9N//tqYvtFBT3l/eIfs5u21b/1Vc/YOV/3JOs
         +S/UcB4VyFY2DJ29/4FUuy+ccqU2wBs+81BNG19HeW3AEzPF/63e6PfuoyIfitiu29DP
         kSJw==
X-Gm-Message-State: AOAM530DF1K/hRb52bVykFd6bHeyEQHYm2cPrYWIhFG83Idkrt+DSVZF
        7qWIlPtGfVezWqtCZcWH7Q==
X-Google-Smtp-Source: ABdhPJzn5+OnaQcbq9py83N+I+20k5N0ExASimPvcyzCWj4ldTkE5CXKuj+Y0I7vEhmibFklnXgpEQ==
X-Received: by 2002:a6b:e20a:: with SMTP id z10mr908695ioc.99.1615343646327;
        Tue, 09 Mar 2021 18:34:06 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id t7sm8632404ilj.62.2021.03.09.18.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 18:34:05 -0800 (PST)
Received: (nullmailer pid 1622948 invoked by uid 1000);
        Wed, 10 Mar 2021 02:34:03 -0000
Date:   Tue, 9 Mar 2021 19:34:03 -0700
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, Lokesh Vutla <lokeshvutla@ti.com>,
        Nadeem Athani <nadeem@cadence.com>
Subject: Re: [PATCH v4 1/4] dt-bindings: PCI: ti, j721e: Add binding to
 represent refclk to the connector
Message-ID: <20210310023403.GA1622887@robh.at.kernel.org>
References: <20210308063550.6227-1-kishon@ti.com>
 <20210308063550.6227-2-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210308063550.6227-2-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 08 Mar 2021 12:05:47 +0530, Kishon Vijay Abraham I wrote:
> Add binding to represent refclk to the PCIe connector.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml       | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
