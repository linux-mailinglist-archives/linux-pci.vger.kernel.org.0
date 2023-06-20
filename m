Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B64E73724F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jun 2023 19:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbjFTRIl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jun 2023 13:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbjFTRIj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Jun 2023 13:08:39 -0400
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A83021728;
        Tue, 20 Jun 2023 10:08:37 -0700 (PDT)
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-76c64da0e46so221680839f.0;
        Tue, 20 Jun 2023 10:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687280917; x=1689872917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJcsNw9M8GOd71NQMFbyfiNslmnbg2Ev97OtD/n6IA8=;
        b=MkRSKavmE92H2cx52IyNqmPVr/Lcs++eBvFmJLr4ApQtRSIRwml792Og/iEVxhOWnC
         baPTiGxnVzZPOFeWmEOwPhewsfyNlXlOkvaWxtye6WwOTbYwm/hHuoCowBWWZbQDQhvF
         Dt5MHLNo/8mC4KBoTiU1sy7bv1j0QBDgRgDVcRtXuHULupyjPAidQvgIOOCStLTfP/b2
         h8owKkEwC7Tc4JxqON9Ol8aMCakz6QDtD7vWQ37HPgsukIwVbBwXJhJFE0tiEIZZSgdR
         esimBNSXloaHjiXk6/7lA5rRAdWzTWzH+5HhB2GOFpbTBDwWONGHNCT+zUB7XXX/1gdM
         37TQ==
X-Gm-Message-State: AC+VfDzCAEuJtnv/l50+IGyhemOm00CcSaWL77f4jJafn7hbUvIV3bp4
        PrFpxN7FnMLl1LJpEOOElfW3Pj2jxQ==
X-Google-Smtp-Source: ACHHUZ4LW3ZZ/cBYhYhRQFPFEU1u8KrW05QGpnRnMNVV6p1GfqQBCDIZtWRbIiboQdX+bfk3YUT6Jw==
X-Received: by 2002:a5e:db05:0:b0:778:82d1:39a3 with SMTP id q5-20020a5edb05000000b0077882d139a3mr12005610iop.13.1687280916907;
        Tue, 20 Jun 2023 10:08:36 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id w17-20020a02cf91000000b00422e02bff00sm764914jar.84.2023.06.20.10.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jun 2023 10:08:36 -0700 (PDT)
Received: (nullmailer pid 3833675 invoked by uid 1000);
        Tue, 20 Jun 2023 17:08:34 -0000
Date:   Tue, 20 Jun 2023 11:08:34 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     kernel@collabora.com, linux-rockchip@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Simon Xue <xxm@rock-chips.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v1 1/4] dt-bindings: PCI: dwc: rockchip: Fix
 interrupt-names issue
Message-ID: <168728091385.3833618.8845528184695868032.robh@kernel.org>
References: <20230616170022.76107-1-sebastian.reichel@collabora.com>
 <20230616170022.76107-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616170022.76107-2-sebastian.reichel@collabora.com>
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


On Fri, 16 Jun 2023 19:00:19 +0200, Sebastian Reichel wrote:
> The RK356x (and RK3588) have 5 ganged interrupts. For example the
> "legacy" interrupt combines "inta/intb/intc/intd" with a register
> providing the details.
> 
> Currently the binding is not specifying these interrupts resulting
> in a bunch of errors for all rk356x boards using PCIe.
> 
> Fix this by specifying the interrupts and add them to the example
> to prevent regressions.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  .../bindings/pci/rockchip-dw-pcie.yaml         | 18 ++++++++++++++++++
>  .../devicetree/bindings/pci/snps,dw-pcie.yaml  | 15 ++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

