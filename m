Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B8B4AFFA3
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 22:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234415AbiBIV5F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 16:57:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:55308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234318AbiBIV5E (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 16:57:04 -0500
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13525E00E274;
        Wed,  9 Feb 2022 13:57:06 -0800 (PST)
Received: by mail-oo1-f52.google.com with SMTP id o128-20020a4a4486000000b003181707ed40so4057261ooa.11;
        Wed, 09 Feb 2022 13:57:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dtrYQmSGaEERL4OvVpMDUjn1HaXRBwdthhUoDs8eLLE=;
        b=FvYkeTBFJ9CQpKKJXc0Wjt4ijAe+d2cWyr8AkHNmK7ZgUYtvVoRLVMh1kiKSSg+DNG
         hraFNS2D3LYdbAsZRyR9i1l2TLYFb5BF1pZPE7rosaP88n6gAlP+7t9rWOwBfUvDhx2N
         ocs+pylOlzGc9rg0smvSn2wLtmNKPRdxTmtX97zxpNxkrxp2c76Wq/ioBhwiO5s02xnE
         crOBuFtqJ9BVrfAbfk7eHDatDQxgmXrH3vfiEQDvGbaV/speP8FXTko/G/m/0CZ5Lkgm
         6wyfUhHcmvFmi5BeLxfuGrj1d9K53YQVIQUKXTw8nwXfA75Ct5QYyUxRvwlU92u4flPh
         YGeg==
X-Gm-Message-State: AOAM530XwlgzXwZxdvndft3Uo4VdkKJOrmZFAEBU66ZlLc3qShCa6Qf4
        UGDvpoQjham/4xLwKtWUkA==
X-Google-Smtp-Source: ABdhPJzFsLHKY/pkz5V1EDRdU6Nw48e/R3+K5mgE9eHbzt8VBwPY3G/K+3ifdh9pBAtLf1d0SpYHMA==
X-Received: by 2002:a05:6870:b78c:: with SMTP id ed12mr1460893oab.250.1644443825305;
        Wed, 09 Feb 2022 13:57:05 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bp5sm627821oib.25.2022.02.09.13.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 13:57:04 -0800 (PST)
Received: (nullmailer pid 997564 invoked by uid 1000);
        Wed, 09 Feb 2022 21:57:03 -0000
Date:   Wed, 9 Feb 2022 15:57:03 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rajat Jain <rajatxjain@gmail.com>,
        Dmitry Torokhov <dtor@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Pavel Machek <pavel@denx.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v2 2/2] dt-bindings: Document "UntrustedDevice" property
 for PCI devices
Message-ID: <YgQ4r34842L6puV+@robh.at.kernel.org>
References: <20220202020103.2149130-1-rajatja@google.com>
 <20220202020103.2149130-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220202020103.2149130-2-rajatja@google.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 01, 2022 at 06:01:03PM -0800, Rajat Jain wrote:
> Add the new "UntrustedDevice" property for PCI devices. This property
> is optional and can be applied to any PCI device.
> 
> Signed-off-by: Rajat Jain <rajatja@google.com>
> ---
> v2: Initial version (added documentation based on comments)
> v1: Does not exist.
> 
>  Documentation/devicetree/bindings/pci/pci.txt | 35 +++++++++++++++++++
>  1 file changed, 35 insertions(+)

New properties have to be in a schema which resides here:

https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus.yaml

> 
> diff --git a/Documentation/devicetree/bindings/pci/pci.txt b/Documentation/devicetree/bindings/pci/pci.txt
> index 6a8f2874a24d..bc1ba10f51e1 100644
> --- a/Documentation/devicetree/bindings/pci/pci.txt
> +++ b/Documentation/devicetree/bindings/pci/pci.txt
> @@ -82,3 +82,38 @@ pcie@10000000 {
>  		external-facing;
>  	};
>  };
> +
> +PCI Device Properties
> +---------------------
> +Following optional properties may be present for any PCI device:
> +
> +- UntrustedDevice:
> +   When present, this property is an indicator that this PCI device (and
> +   any downstream devices) are to be treated as untrusted by the kernel.
> +   The kernel can, for example, use this information to isolate such
> +   devices using a strict DMA protection via the IOMMU.
> +
> +   Example device tree node:
> +	pcie@0008 {
> +		/* PCI device 00:01.0 is an untrusted device */
> +		reg = <0x00000800 0 0 0 0>;
> +		UntrustedDevice = <1>;
> +	};
> +
> +   Example ACPI node:

Humm, your caret case smelled like ACPI to begin with. As far as ACPI 
bindings in Documentation/devicetree/bindings/ are concerned, NAK.
