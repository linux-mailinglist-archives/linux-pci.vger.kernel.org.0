Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A38551C9C57
	for <lists+linux-pci@lfdr.de>; Thu,  7 May 2020 22:27:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728045AbgEGU14 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 May 2020 16:27:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39314 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726320AbgEGU1z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 7 May 2020 16:27:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id m13so5679306otf.6;
        Thu, 07 May 2020 13:27:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ln2E/jvReZq9WnHJIz5sFnJWJFU3r566YgUAK7BxH3c=;
        b=Na8lwbiXBV5ptJcpEw0IKA2SmvcAzLIR5MPACTvdjy1/ZqOLIXRBJhgDCNA+emLC63
         euqRLQ4gHFbq9Uc4pyCob67GX5pRh+C/lV99tGrahHb5u/QLQ0hp+cGOd+KE2tOT+wvD
         OIRqwWdBvCuXHHW5uiLIVR7SOwrET/4w6Sob0LmGMEzTiE8DaCwkT9vGCZZuQTxTMvc5
         gyNtW8sYmECxH+ChfhRr5rNBfCnF89Z3IOVllejoYT55Nwt8e9IqtTaeK2Km9/lstoOH
         DR2KiC2Ur2xvh18Rc54rvDJKoXxT2v1gfIf48ogx2bx4uLmho5rQhb7H/bnMVG0FSpzJ
         SHHw==
X-Gm-Message-State: AGi0Pubrhm9nvqAzQmImyIDn3EkUB8vwnLqPJJNF15Urylwjl6ECk5n6
        EGYnOkrVNSjl027zgf9kNw==
X-Google-Smtp-Source: APiQypKx/+0vAYYfToTPh9BTuoAyIx1XP/EVGGtjl4K9DLnqWKUm7OqAxftP3FPyEX4UUrd0KuCqog==
X-Received: by 2002:a9d:4113:: with SMTP id o19mr11603329ote.354.1588883274822;
        Thu, 07 May 2020 13:27:54 -0700 (PDT)
Received: from rob-hp-laptop (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id z13sm1621472oth.10.2020.05.07.13.27.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 13:27:54 -0700 (PDT)
Received: (nullmailer pid 21941 invoked by uid 1000);
        Thu, 07 May 2020 20:27:53 -0000
Date:   Thu, 7 May 2020 15:27:53 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Tom Joseph <tjoseph@cadence.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] PCI: cadence: Fix to read 32-bit Vendor ID/Device
 ID property from DT
Message-ID: <20200507202753.GA21833@bogus>
References: <20200417114322.31111-1-kishon@ti.com>
 <20200417114322.31111-5-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200417114322.31111-5-kishon@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 17 Apr 2020 17:13:22 +0530, Kishon Vijay Abraham I wrote:
> The PCI Bus Binding specification (IEEE Std 1275-1994 Revision 2.1 [1])
> defines both Vendor ID and Device ID to be 32-bits. Fix
> pcie-cadence-host.c driver to read 32-bit Vendor ID and Device ID
> properties from device tree.
> 
> [1] -> https://www.devicetree.org/open-firmware/bindings/pci/pci2_1.pdf
> 
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> ---
>  drivers/pci/controller/cadence/pcie-cadence-host.c | 4 ++--
>  drivers/pci/controller/cadence/pcie-cadence.h      | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 

Acked-by: Rob Herring <robh@kernel.org>
