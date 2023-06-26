Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C034773EB37
	for <lists+linux-pci@lfdr.de>; Mon, 26 Jun 2023 21:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbjFZTfn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jun 2023 15:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFZTfn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Jun 2023 15:35:43 -0400
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB9210DA;
        Mon, 26 Jun 2023 12:35:40 -0700 (PDT)
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7836164a08aso45903339f.1;
        Mon, 26 Jun 2023 12:35:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687808140; x=1690400140;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGfCwcbVLNoCSLzgxFgaQHuuup0hQXpRqIa+hpJXPdc=;
        b=dXZBj1J5m8Y5Q3lPq4/jUo8q8lCgLGD7Is/63mplyAzlwMH8L8Fw646D1t9kKaeYW/
         91DxcIrQMMrktDGPOse4fcgHXEHLwmxW3VEd5ZpuGS27L0a3cUlqtlFw7Ya97hrUdnlV
         X0HyxO2rCh6LV/gvsWhy8p2sL+ZULFCOS17M4iEouwMD8U55Wx7VbgbSXY2GjAWMKCwr
         mkrQZX9tfb4c2kVhx+1uDL9bpElYp1G2ChX5aCXEnLexBkEwLe+hEJM011cMu7kOJL43
         /JLSeCu7DUnZco+RY12x5QXEyoYJo6UbHSO1KOWSFH3vZh4IIn1p8CLdw0VXhOJp+y8p
         N+FA==
X-Gm-Message-State: AC+VfDzlpmuOqsiLeOViVbEosLCnAVCo18/uGaXn26b/AZh1AhqHkz0+
        f5RJJIDKnsapfY8crm+4ug==
X-Google-Smtp-Source: ACHHUZ5n+5iHOWhRthQiOeSfPq/OI+/OPCixQPcsYGvRwG60osxotB0cF5A7pDV6dz3Nptrxo1Q4lQ==
X-Received: by 2002:a5d:96c1:0:b0:76f:1664:672 with SMTP id r1-20020a5d96c1000000b0076f16640672mr28860112iol.13.1687808140076;
        Mon, 26 Jun 2023 12:35:40 -0700 (PDT)
Received: from robh_at_kernel.org ([199.114.228.113])
        by smtp.gmail.com with ESMTPSA id l14-20020a02a88e000000b00423076f5442sm409363jam.2.2023.06.26.12.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jun 2023 12:35:39 -0700 (PDT)
Received: (nullmailer pid 3613294 invoked by uid 1000);
        Mon, 26 Jun 2023 19:32:38 -0000
Date:   Mon, 26 Jun 2023 13:32:38 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Xue <xxm@rock-chips.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        kernel@collabora.com
Subject: Re: [PATCH v1 0/4] RK3588 PCIe2 support
Message-ID: <20230626193238.GA3553158-robh@kernel.org>
References: <20230616170022.76107-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616170022.76107-1-sebastian.reichel@collabora.com>
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

On Fri, Jun 16, 2023 at 07:00:18PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> This adds PCIe2 support for RK3588. The series has been tested with the
> onboard RTL8125 network card on Rockchip RK3588 EVB1 (&pcie2x1l1) and
> Radxa Rock 5B (&pcie2x1l2). The final patch in this series depends on
> the combo PHY support added by the SATA series [0].
> 
> [0] https://lore.kernel.org/all/20230612171337.74576-1-sebastian.reichel@collabora.com/
> 
> Thanks,
> 
> -- Sebastian
> 
> Sebastian Reichel (4):
>   dt-bindings: PCI: dwc: rockchip: Fix interrupt-names issue
>   dt-bindings: PCI: dwc: rockchip: Add missing
>     legacy-interrupt-controller
>   dt-bindings: PCI: dwc: rockchip: Update for RK3588
>   arm64: dts: rockchip: rk3588: add PCIe2 support

I applied patches 1-3.

Rob
