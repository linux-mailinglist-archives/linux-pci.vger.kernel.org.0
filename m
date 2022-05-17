Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1465295F2
	for <lists+linux-pci@lfdr.de>; Tue, 17 May 2022 02:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236677AbiEQASW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 May 2022 20:18:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiEQASV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 May 2022 20:18:21 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3710245AF1;
        Mon, 16 May 2022 17:18:20 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id l16so20620175oil.6;
        Mon, 16 May 2022 17:18:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=GPUFIY49jVOLB0PCg0hcdHV6Ri73fGCHmtlekomUChM=;
        b=NPgz3MMf5+bjZKCVRca3NdXWMHnBh0wl2BcJ8SLFcju9YjwIYxWui8JmnZwA2yN5Cp
         ndokBO5iCsia1PGQZKD1b54rAnpazY5qdxXJhlzKqe/PpFlYrnWAmmfh6PMGEmUYZ2AF
         MQcWQXSW3zc0rkQWx+5MHwHVC5v895JVIMonQRlfqgyWjqgQHCHEJRbteIA2lPGrwmPF
         o6F74o1JnqXHBzgZwIa1vHo+28ncDboqKutaCbdWGtRAvXpu8tM8Y/d28Jl1hpGXUnG8
         MQRz55v3Srisndb+qJ5tatnfVG2m7x01RnBBzPmintP1TaK3QgpjSVYuy8+aPDle+QXi
         i92A==
X-Gm-Message-State: AOAM532Mymjhl7ybURi7AwS3x9H8aDjOx+LE+AtHjSsN83Hk5GEpYT27
        hbLTaUNtc6U4nE7sgqIY5A==
X-Google-Smtp-Source: ABdhPJyoOUMiRrvr83FjYScfsZOHKuD0JIOvH2MR2SrWlETM1o5zPl+aB9buWtlZMSv2NfO8ZGVhHA==
X-Received: by 2002:a05:6808:218c:b0:328:c5e6:b2a with SMTP id be12-20020a056808218c00b00328c5e60b2amr10874658oib.173.1652746699562;
        Mon, 16 May 2022 17:18:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z18-20020a544592000000b00325cda1ffb2sm4334484oib.49.2022.05.16.17.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:18:18 -0700 (PDT)
Received: (nullmailer pid 3632950 invoked by uid 1000);
        Tue, 17 May 2022 00:18:17 -0000
Date:   Mon, 16 May 2022 19:18:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/6] dt-bindings: irqchip: armada-370-xp: Update
 information about MPIC SoC Error
Message-ID: <20220517001817.GA3629501-robh@kernel.org>
References: <20220506134029.21470-1-pali@kernel.org>
 <20220506134029.21470-2-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220506134029.21470-2-pali@kernel.org>
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

On Fri, May 06, 2022 at 03:40:24PM +0200, Pali Rohár wrote:
> Signed-off-by: Pali Rohár <pali@kernel.org>

Why do we need/want this change?

> ---
>  .../interrupt-controller/marvell,armada-370-xp-mpic.txt  | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/marvell,armada-370-xp-mpic.txt b/Documentation/devicetree/bindings/interrupt-controller/marvell,armada-370-xp-mpic.txt
> index 5fc03134a999..8cddbc16ddbd 100644
> --- a/Documentation/devicetree/bindings/interrupt-controller/marvell,armada-370-xp-mpic.txt
> +++ b/Documentation/devicetree/bindings/interrupt-controller/marvell,armada-370-xp-mpic.txt
> @@ -24,6 +24,11 @@ Optional properties:
>    connected as a slave to the Cortex-A9 GIC. The provided interrupt
>    indicate to which GIC interrupt the MPIC output is connected.
>  
> +Optional subnodes:
> +
> +- interrupt-controller@20 with interrupt-controller property for
> +  MPIC SoC Error IRQ controller
> +
>  Example:
>  
>          mpic: interrupt-controller@d0020000 {
> @@ -35,4 +40,8 @@ Example:
>                msi-controller;
>                reg = <0xd0020a00 0x1d0>,
>                      <0xd0021070 0x58>;
> +              soc_err: interrupt-controller@20 {

unit address without 'reg' is an error.

> +                    interrupt-controller;
> +                    #interrupt-cells = <1>;
> +              };
>          };
> -- 
> 2.20.1
> 
> 
