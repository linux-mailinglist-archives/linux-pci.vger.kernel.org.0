Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C6F32F69C
	for <lists+linux-pci@lfdr.de>; Sat,  6 Mar 2021 00:30:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229672AbhCEX3r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 5 Mar 2021 18:29:47 -0500
Received: from mail-ot1-f43.google.com ([209.85.210.43]:38465 "EHLO
        mail-ot1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbhCEX3Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 5 Mar 2021 18:29:25 -0500
Received: by mail-ot1-f43.google.com with SMTP id a17so3466337oto.5;
        Fri, 05 Mar 2021 15:29:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iKRgquV/vXUrEGo0YcM7TxZEX4fPND//V0LED3FIsgg=;
        b=OGVYYg2bGaBnehxAS54YDItfUMiMYifkaGHolBJ8Bk/i7wPIIM6tbmMdvO46Kt19rO
         GxjTK3T0aL79ecnDgb+OwMdyTTDMDfaraqfs7b8VCCXo483CWqy8AulKRgUvqdwy4VU+
         9vQwjbHQQsOETcoAIxkoMeAWxuBYjzzLfdwh/b0YQVS3Z8ixNnqkjLXx3kMK4nRkG+xJ
         sJw2effSsyWlYQO433HD/wPGAHB54ygnnHk5AGWw3mBKineVTFRbbqp45DO+4f7crlqg
         5p91MWgFEUwoJqpwrdVNRE5zwUW5P5Z0MvQ32dtVhtJL80C4y68lFjJ4YVIZtkV0EVoA
         Ch+g==
X-Gm-Message-State: AOAM533A/HqWNILwsYzSAWLMjnDLVqJZKJ8zG+krLAI2tM3NBh7k9F73
        E6TGVtgv1FaL2CQIEAxs6w==
X-Google-Smtp-Source: ABdhPJzHhvdjsYrT7iTPxHuGcSSSs7Klj5z9aHCOABPdeVGJyKvyq2/rbmyb1HZQqsM9BK5US7ZTBg==
X-Received: by 2002:a9d:67cb:: with SMTP id c11mr9942429otn.290.1614986964702;
        Fri, 05 Mar 2021 15:29:24 -0800 (PST)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id e131sm834716oia.41.2021.03.05.15.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Mar 2021 15:29:23 -0800 (PST)
Received: (nullmailer pid 839646 invoked by uid 1000);
        Fri, 05 Mar 2021 23:29:22 -0000
Date:   Fri, 5 Mar 2021 17:29:22 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/4] dt-bindings: PCI: ti, j721e: Add endpoint mode
 dt-bindings for TI's AM64 SoC
Message-ID: <20210305232922.GA839612@robh.at.kernel.org>
References: <20210222114030.26445-1-kishon@ti.com>
 <20210222114030.26445-4-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210222114030.26445-4-kishon@ti.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 Feb 2021 17:10:29 +0530, Kishon Vijay Abraham I wrote:
> Add endpoint mode dt-bindings for TI's AM64 SoC. This is the same IP
> used in J7200, however AM64 is a non-coherent architecture.
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  .../devicetree/bindings/pci/ti,j721e-pci-ep.yaml         | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
