Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8143E6E811C
	for <lists+linux-pci@lfdr.de>; Wed, 19 Apr 2023 20:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjDSSR0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Apr 2023 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjDSSR0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 19 Apr 2023 14:17:26 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB2546BD;
        Wed, 19 Apr 2023 11:17:25 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-24781e23c27so36254a91.0;
        Wed, 19 Apr 2023 11:17:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681928245; x=1684520245;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PeBdK+aOX5WklXzp1wDCp3VluwO0S4t7q6gfKuWPg94=;
        b=TAKCN/n47iXERHfLzbJcs8NNmia6bZ/p1ZbAVo/4UW1iGvzWQjlGFHaH+ukiqI+vN2
         BrVcKK3dLprYjx+crfWHAiXDaRtAWPrTIih8l5wn+MZOfAdcfWms30zXErZTOC3Eczt8
         65v/j/oS8Np4E5wVW47qM5LlnrA0kEdGNg03zUf4KLlh2twDjkEQVD14a4wNtz62kwfh
         ginJeF2aFn0lWAItEWxogvUFrtJ8DUDkkcMXUNoGCojzP4pidMoEXIksSZTRjey+dp9F
         /ORDRHEPOBRirskQmUecQ0FJjYn5TdC10iUd5Qny9vRB1kHlwoEmOq7GWDoYmeZ9mXrg
         9OlQ==
X-Gm-Message-State: AAQBX9ftMixXDUo5LVPtji3Bvz1CoCz1HezcDQca9irrICUfc4TdWbp/
        hCpwsfsbd5PLAftsoejLMdE=
X-Google-Smtp-Source: AKy350ZY847hKaLR9XgVdkaH33Rw1uv2+wMeSMUe1kmJeki6pghFcGewUpJDIYZzogtWqpQAM2QFsw==
X-Received: by 2002:a17:90a:9c0a:b0:247:529f:92d7 with SMTP id h10-20020a17090a9c0a00b00247529f92d7mr3440902pjp.8.1681928244780;
        Wed, 19 Apr 2023 11:17:24 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id r11-20020a65498b000000b004e28be19d1csm10761414pgs.32.2023.04.19.11.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 11:17:24 -0700 (PDT)
Date:   Wed, 19 Apr 2023 18:17:22 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Subject: Re: [PATCH 2/7] PCI: hv: Add 'Microsoft' to Kconfig prompt
Message-ID: <ZEAwMkmDBXKRkvIU@liuwe-devbox-debian-v2>
References: <20230418174336.145585-1-helgaas@kernel.org>
 <20230418174336.145585-3-helgaas@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230418174336.145585-3-helgaas@kernel.org>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Apr 18, 2023 at 12:43:31PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Add the "Microsoft" vendor name to the CONFIG_PCI_HYPERV_INTERFACE Kconfig
> prompt so it matches other PCIe drivers and other Hyper-V prompts.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: K. Y. Srinivasan <kys@microsoft.com>
> Cc: Haiyang Zhang <haiyangz@microsoft.com>
> Cc: Wei Liu <wei.liu@kernel.org>
> Cc: Dexuan Cui <decui@microsoft.com>

Acked-by: Wei Liu <wei.liu@kernel.org>

> ---
>  drivers/pci/controller/Kconfig | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 42654035654a..8b1f9a3f83ea 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -285,11 +285,12 @@ config PCIE_BRCMSTB
>  	  Broadcom STB based SoCs, like the Raspberry Pi 4.
>  
>  config PCI_HYPERV_INTERFACE
> -	tristate "Hyper-V PCI Interface"
> +	tristate "Microsoft Hyper-V PCI Interface"
>  	depends on ((X86 && X86_64) || ARM64) && HYPERV && PCI_MSI
>  	help
> -	  The Hyper-V PCI Interface is a helper driver allows other drivers to
> -	  have a common interface with the Hyper-V PCI frontend driver.
> +	  The Hyper-V PCI Interface is a helper driver that allows other
> +	  drivers to have a common interface with the Hyper-V PCI frontend
> +	  driver.
>  
>  config PCI_LOONGSON
>  	bool "LOONGSON PCI Controller"
> -- 
> 2.25.1
> 
