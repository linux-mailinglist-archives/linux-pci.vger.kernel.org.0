Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6362508950
	for <lists+linux-pci@lfdr.de>; Wed, 20 Apr 2022 15:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352871AbiDTN3y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Apr 2022 09:29:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235191AbiDTN3x (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Apr 2022 09:29:53 -0400
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27B2C42A00
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 06:27:07 -0700 (PDT)
Received: by mail-oi1-f182.google.com with SMTP id z8so2028406oix.3
        for <linux-pci@vger.kernel.org>; Wed, 20 Apr 2022 06:27:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=tkDJJIO0rUiY/JrWpsvjznlENbJoBpxJ9u4z5TwDZfo=;
        b=FZny8C0YJkFu7UlorPLXmWMXrknqhnqsTd9t6DBaaHnvZDnt6gxtHr/k3vASFIRRbY
         geCFkUlNEuibW+EoSls4fNyHErEv/APyHuQF9nVnPxroyWGlzfsK2lse0TFDjgE33wRl
         P82TzRhp5j1BIRGGImcGaRY9BdmW1mBAhCZrf3UPeGfbtyar3ZsncAGy15+vdRltRFsZ
         ZO4/ufQdan682WsTN9psqc3XVNgIJ3cj+TKXTiTqN13MwIh/syFXOsTNRZu1P/DwVNO8
         orXdpidnEsAM0GGW6LaHRIsJsfP2Z/CagKZMiiZTufE73oxZIucdWHuZipoIoRbEdx3e
         pfiA==
X-Gm-Message-State: AOAM531UUite5My349TeHjSVIxZMfE0IHdmFtsHIIrmNPpdJ4Jo8vBdB
        ya895UTtF8sMc7oJCSyqEQ==
X-Google-Smtp-Source: ABdhPJxBo2V629ksxHTbQB5jeijVMxjg1ExJ9Lc4yUMIPVeMdwXalrIQz+OOFeQLA1nYGGJZJIKt5g==
X-Received: by 2002:a05:6808:148f:b0:2fa:767d:3c86 with SMTP id e15-20020a056808148f00b002fa767d3c86mr1759420oiw.198.1650461226464;
        Wed, 20 Apr 2022 06:27:06 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ay9-20020a056808300900b0032272231c25sm4236528oib.40.2022.04.20.06.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:27:06 -0700 (PDT)
Received: (nullmailer pid 1164667 invoked by uid 1000);
        Wed, 20 Apr 2022 13:27:05 -0000
Date:   Wed, 20 Apr 2022 08:27:05 -0500
From:   Rob Herring <robh@kernel.org>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daire McNamara <daire.mcnamara@microchip.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel@pengutronix.de, Ian Cowan <ian@linux.cowan.aero>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] PCI: microchip: Add a missing semicolon
Message-ID: <YmAKKcBVGuBHwhUb@robh.at.kernel.org>
References: <20220420065832.14173-1-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220420065832.14173-1-u.kleine-koenig@pengutronix.de>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 20, 2022 at 08:58:32AM +0200, Uwe Kleine-König wrote:
> If the driver is configured as a module (after allowing this by changing
> PCIE_MICROCHIP_HOST from bool to tristate) the missing semicolon makes the
> compiler very unhappy. While there isn't a real problem as
> MODULE_DEVICE_TABLE always evaluates to nothing for a built-in driver,
> do it right for consistency with other drivers.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> I wonder if there is a technical reason to have PCIE_MICROCHIP_HOST (and
> some others) only bool. With this patch applied the driver compiles just
> fine with PCIE_MICROCHIP_HOST=m.

Historical copy-n-paste.

Rob
