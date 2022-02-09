Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9434AFFDF
	for <lists+linux-pci@lfdr.de>; Wed,  9 Feb 2022 23:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234939AbiBIWEz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Feb 2022 17:04:55 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234925AbiBIWEy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Feb 2022 17:04:54 -0500
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FF5C0F8692;
        Wed,  9 Feb 2022 14:04:57 -0800 (PST)
Received: by mail-oo1-f47.google.com with SMTP id 189-20020a4a03c6000000b003179d7b30d8so4137618ooi.2;
        Wed, 09 Feb 2022 14:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4ijkWrfXNXFNXkGq3HCuR6HmSAMRuSuaY6N4jo/cPdE=;
        b=AnKuw7uCHK0Ow3FpBlq5TpknhVTxqF05pEyuA7JJf0Z8LK2g8Hk67pK6bCo6P5fmmC
         6LJ9iDsXVFhSNCG4XLADzVYBndt5NyOpl1FaSyAfOZZZcu5BLRdEGO6MX2xamow+3jDC
         qiE/kSnwKJhbPUxDEGbyzLrSZEA9QM1Qp7RBi6FmX15P/Np26JKRp06vCsRzwPx2+hkE
         JhgFoGaLfHXX7H3CzQ4SuV0hB3W7DSfEHMQ1KRACEaEc+krmAJvMkTKHiqUQSbcRZZkY
         pkJl2+aOxvcUf6PWuChz6xfpXceKl0WBv3X3TPfUmg8qH6HRuy5VIbhwPxMQF0gKKgVs
         +M4A==
X-Gm-Message-State: AOAM531qRnwYGJWfou9kmDlz3XasR8Xt+vLChfcKty+Mw3ebnxScU6pX
        Zrb88IM6TSd6F2wLa8CxTA==
X-Google-Smtp-Source: ABdhPJxlK00nn+sbI6Va0CAH0tQywbc38W4zTViSOPW0K8Q3N7UtwQNIT0f3TQAYuhNeBBQHxwefDg==
X-Received: by 2002:a05:6870:7b84:: with SMTP id jf4mr1460248oab.230.1644444297003;
        Wed, 09 Feb 2022 14:04:57 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id bb32sm7385734oib.11.2022.02.09.14.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 14:04:56 -0800 (PST)
Received: (nullmailer pid 1012267 invoked by uid 1000);
        Wed, 09 Feb 2022 22:04:55 -0000
Date:   Wed, 9 Feb 2022 16:04:55 -0600
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI: Introduce UniPhier NX1 PCI endpoint
 controller support
Message-ID: <YgQ6h3qYxWUiLWZ0@robh.at.kernel.org>
References: <1643948739-14889-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643948739-14889-1-git-send-email-hayashi.kunihiko@socionext.com>
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

On Fri, Feb 04, 2022 at 01:25:36PM +0900, Kunihiko Hayashi wrote:
> This series includes the patches to add basic support for the PCI endpoint
> controller implemented in NX1 SoC.
> 
> Existing functions for Pro5 treat as "legacy" because the some registers
> and initialization of NX1 is different from Pro5.
> 
> Changes since v1:
> - Fix dt-bindings warnings
> 
> Kunihiko Hayashi (3):
>   dt-bindings: PCI: uniphier-ep: Add bindings for NX1 SoC
>   PCI: uniphier-ep: Add support for non-legacy SoC
>   PCI: uniphier-ep: Add compatible string and SoC-dependent data for NX1
>     SoC
> 
>  .../bindings/pci/socionext,uniphier-pcie-ep.yaml   |  22 ++--
>  drivers/pci/controller/dwc/pcie-uniphier-ep.c      | 139 ++++++++++++++++++---
>  2 files changed, 136 insertions(+), 25 deletions(-)

For the series:

Reviewed-by: Rob Herring <robh@kernel.org>
