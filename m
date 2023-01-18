Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9A06728CB
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jan 2023 20:56:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjART4c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 14:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjART4b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 14:56:31 -0500
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF6559549;
        Wed, 18 Jan 2023 11:56:30 -0800 (PST)
Received: by mail-oi1-f177.google.com with SMTP id d188so18399885oia.3;
        Wed, 18 Jan 2023 11:56:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=akZulwLnMRZAXk7khxYZKnUiCXgcGRehJrIuYvwvNb0=;
        b=xSUOYlDCZPOPhoTSZG57XG3xt0KI6uL/8sfHwVd83BrMWZLYD+fWSbSMF89A5o0Kd4
         4opnTOuF9jlDB54eMFmEQtgG6PuTT3bpWDtVqlE+ach6Vd4pgxUD2SCTvKhtvFE/iJeq
         rY9zWUIMNWEn+SpTdzmRTErCg9+RE/OgRqzx5T2/VESdviR4qSTjO1+9SrpWpyHWnY/6
         clwb03FuPDb9wOzChfhjmEnV11rHf+TXWybzP3OHH5NeYw2pqZGe9gewCL2Fx15MALZF
         9ozGh8mf5BHdcreh048Ka6YG9t2e1OUvumUlwFsyfNvNq4SgmghaSBCI+15ibhaOo2o7
         QL+w==
X-Gm-Message-State: AFqh2kphms+iv6RQ6clB9hJMK6WOcNWEsptIu90fGJAMK5baEzpe4nNv
        Ft9OJm/oYPjE/pD6QqL/kg==
X-Google-Smtp-Source: AMrXdXs9lF5ksgkjo+IhPIHJNNYeSJLIwYvkoIWS/Qllw83zdH43zruP0gkDfhp+tqRcnjdJWEHDfw==
X-Received: by 2002:a54:469a:0:b0:363:b22c:4c7 with SMTP id k26-20020a54469a000000b00363b22c04c7mr3447152oic.7.1674071789726;
        Wed, 18 Jan 2023 11:56:29 -0800 (PST)
Received: from robh_at_kernel.org ([4.31.143.193])
        by smtp.gmail.com with ESMTPSA id r42-20020a056808212a00b00364e8f85c08sm6095948oiw.21.2023.01.18.11.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jan 2023 11:56:29 -0800 (PST)
Received: (nullmailer pid 706834 invoked by uid 1000);
        Wed, 18 Jan 2023 19:56:28 -0000
Date:   Wed, 18 Jan 2023 13:56:28 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        linux-pci@vger.kernel.org,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "linux-rockchip@lists.infradead.org , Heiko Stuebner" 
        <heiko@sntech.de>
Subject: Re: [PATCH] dt-bindings: PCI: Convert Rockchip RK3399 PCIe to DT
 schema
Message-ID: <167407178127.706640.6877082216577984494.robh@kernel.org>
References: <20221219191209.1975834-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221219191209.1975834-1-robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Mon, 19 Dec 2022 13:12:08 -0600, Rob Herring wrote:
> Convert the Rockchip RK3399 PCIe Host/Endpoint controller to DT schema
> format. Like most dual mode PCI controllers, we need to split the schema
> into common, host and endpoint schemas.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> Shawn (or anyone from Rockchip), Note and please ack the license change.
> ---
>  .../pci/rockchip,rk3399-pcie-common.yaml      |  69 +++++++++
>  .../bindings/pci/rockchip,rk3399-pcie-ep.yaml |  68 +++++++++
>  .../bindings/pci/rockchip,rk3399-pcie.yaml    | 132 +++++++++++++++++
>  .../bindings/pci/rockchip-pcie-ep.txt         |  62 --------
>  .../bindings/pci/rockchip-pcie-host.txt       | 135 ------------------
>  MAINTAINERS                                   |   2 +-
>  6 files changed, 270 insertions(+), 198 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-common.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie-ep.yaml
>  create mode 100644 Documentation/devicetree/bindings/pci/rockchip,rk3399-pcie.yaml
>  delete mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-ep.txt
>  delete mode 100644 Documentation/devicetree/bindings/pci/rockchip-pcie-host.txt
> 

Applied, thanks!
