Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C5557EB7B7
	for <lists+linux-pci@lfdr.de>; Tue, 14 Nov 2023 21:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233869AbjKNUWh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Nov 2023 15:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjKNUWh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Nov 2023 15:22:37 -0500
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE56F5;
        Tue, 14 Nov 2023 12:22:30 -0800 (PST)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b512dd7d5bso4083080b6e.1;
        Tue, 14 Nov 2023 12:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699993350; x=1700598150;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN1QbTvxURo/h7mHZUP6E5kNPIsXRML0G9gU6ayYKzw=;
        b=IX+9OGYD7Vu9yVBN+NhdBo6kO6+n607TfiV8gdX06uQf0bKBt15GHNX1+J9HL/ITxz
         8+qDl/lb3Kvbu3l9erGPHUTXiKv2/jHqa5ldL0+zf9rC/Knip8r9aF/kO8vfS7ce1DqW
         wl2dCHQqJD9/VarQZxntFvWgKH9VP6j/7aXV/KLzwhDVD2FIRyZaQYsnKNrLAlDH76qW
         qMyUceBxPohBP0u7pZB+4oy5wDO+0sl6NlsZBwr+uebgFJStUO4XW39aOAalG6D/TNbv
         LfcI26HCObjyM6/9bp6ixhgXnSoyfUPvEC9Oy2qgvue8OrcgiV9N1EBV+6dp3YNns+BW
         SLSg==
X-Gm-Message-State: AOJu0YxdwkstZML7e8SITiS/RCYzUqF1Skyro2CfmQglK2EmgFkF814o
        xlxtF2rO2JT1dFElBj8ugA==
X-Google-Smtp-Source: AGHT+IEROoId8ghIa/bUPwkp/GfJOwSwEJpVH6CEk4esrLAW0KKOStfLZDL1S3Jl3FT0nRRTMbYjkA==
X-Received: by 2002:a05:6808:31a:b0:3a7:a3b1:ac30 with SMTP id i26-20020a056808031a00b003a7a3b1ac30mr11034373oie.44.1699993349749;
        Tue, 14 Nov 2023 12:22:29 -0800 (PST)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b7-20020aca1b07000000b003af732a2054sm1236360oib.57.2023.11.14.12.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 12:22:29 -0800 (PST)
Received: (nullmailer pid 455067 invoked by uid 1000);
        Tue, 14 Nov 2023 20:22:27 -0000
Date:   Tue, 14 Nov 2023 14:22:27 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Cyril Brulebois <kibi@debian.org>,
        Jim Quinlan <jim2101024@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-kernel@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-rpi-kernel@lists.infradead.org,
        Phil Elwell <phil@raspberrypi.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v8 1/2] dt-bindings: PCI: brcmstb: Add property
 "brcm,clkreq-mode"
Message-ID: <169999334704.455013.2784769290164979974.robh@kernel.org>
References: <20231113185607.1756-1-james.quinlan@broadcom.com>
 <20231113185607.1756-2-james.quinlan@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113185607.1756-2-james.quinlan@broadcom.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Mon, 13 Nov 2023 13:56:05 -0500, Jim Quinlan wrote:
> The Broadcom STB/CM PCIe HW -- a core that is also used by RPi SOCs --
> requires the driver to deliberately place the RC HW one of three CLKREQ#
> modes.  The "brcm,clkreq-mode" property allows the user to override the
> default setting.  If this property is omitted, the default mode shall be
> "default".
> 
> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  .../devicetree/bindings/pci/brcm,stb-pcie.yaml | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

