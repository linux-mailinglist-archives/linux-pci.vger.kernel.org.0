Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C3634E69FE
	for <lists+linux-pci@lfdr.de>; Thu, 24 Mar 2022 21:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345866AbiCXUw1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Mar 2022 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353691AbiCXUwE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Mar 2022 16:52:04 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F103C36683;
        Thu, 24 Mar 2022 13:50:30 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id o64so6144229oib.7;
        Thu, 24 Mar 2022 13:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=N7X1Jph+spbx81bExVVBZgrp6RsoYRF8yIwNInaVhtw=;
        b=h2D/S/AKEQZEsiCsckqyEIwjZ9yYQwu30T8Iv8XvPaiNN6+vJ+ZEch/p2075ITJ+Eh
         EBbqSpIjPp+55CZrF7bmVwN6V850HeHtd5NUpcdbrxMtQhanJHzmbQaq2tz4b7Lxzzvk
         Cb2rvHPTDE/SDWaLnVMGnBIOMFInbHpWOO3r224nCIlRrr1rLe8TrqnqbPyh/ljOM+Ff
         v09K8nvDoSKwVhBgaoVEqPY5HtYfoskBGc/vNiQky7566PXr2W3tOsEqNcmCRbgcfBrL
         a74SeKRDG8+V9MEaho++SorbA4a8hpT0Y2oqpPJ81iBIMkNm0n+hDmX5SmNB8q3AJQ5R
         K6rA==
X-Gm-Message-State: AOAM531Pq20uGzFGMxhVgbDafrfduqZCfjoQxMH5gU0h/gAEqhrOdnfD
        tRrdZw0Rh5fuA/r2bevTOw==
X-Google-Smtp-Source: ABdhPJzkOrf3EbmXElP4l2eDGcS4BjQd5k4rYdMQJoqQaojX1X6UYuXfwsQHxSrooAqhCwpcNKSz8g==
X-Received: by 2002:aca:1c0f:0:b0:2ed:22b4:9205 with SMTP id c15-20020aca1c0f000000b002ed22b49205mr3498488oic.118.1648155030333;
        Thu, 24 Mar 2022 13:50:30 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m21-20020a056820035500b0032121ce8beesm1707401ooe.28.2022.03.24.13.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 13:50:29 -0700 (PDT)
Received: (nullmailer pid 2551160 invoked by uid 1000);
        Thu, 24 Mar 2022 20:50:28 -0000
Date:   Thu, 24 Mar 2022 15:50:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/4] PCI: mvebu: Add support for sending
 Set_Slot_Power_Limit message
Message-ID: <YjzZlPyaCtcQvIph@robh.at.kernel.org>
References: <20220302145733.12606-1-pali@kernel.org>
 <20220302145733.12606-5-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220302145733.12606-5-pali@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Mar 02, 2022 at 03:57:33PM +0100, Pali Rohár wrote:
> If DT supplies the 'slot-power-limit-milliwatt' property, program
> the value in the Slot Power Limit in the Slot Capabilities register
> and program the Root Port to send a Set_Slot_Power_Limit Message
> when the Link transitions to DL_Up.
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> ---
> Changes in v2:
> * Fix handling of slot power limit with scale x1.0 (0x00 value)
> * Use FIELD_PREP instead of _SHIFT macros
> * Changed commit message to Bjorn's suggestion
> * Changed comments in the code to match PCIe spec
> * Preserve user settings of PCI_EXP_SLTCTL_ASPL_DISABLE bit
> ---
>  drivers/pci/controller/pci-mvebu.c | 96 ++++++++++++++++++++++++++++--
>  1 file changed, 91 insertions(+), 5 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
