Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287DD683A84
	for <lists+linux-pci@lfdr.de>; Wed,  1 Feb 2023 00:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbjAaXcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 Jan 2023 18:32:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbjAaXcJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 Jan 2023 18:32:09 -0500
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D244FAE6;
        Tue, 31 Jan 2023 15:32:06 -0800 (PST)
Received: by mail-oo1-f42.google.com with SMTP id i11-20020a4a6f4b000000b00517b271130eso353575oof.1;
        Tue, 31 Jan 2023 15:32:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BMfQK8rh+2Lwkllf5BijXRm+2Sma8TiNrVOqaDM18Xs=;
        b=gjRYW84rkxw2WCYZLt6cdSiIHvv+C3wzjkY1ahhK34KgL/k6I8Z4fIsUW4InrkkFX1
         ebtZYry2zz6BDrua+X26tXZFILdM9YVcm+K3sbI0NIbfY3Lju0Xl9HfDGZMAo6fyqMiF
         bCcs28b7WpuQqdckoMOZrKQgDhVH9imKGSICu24CaHqdsXWUR1CskWs1tyAE+mnSTCbz
         eM47ZJh/yWfs5P8vaE9jYgFCfVFKTCFMq9i+G9feelefCkY7ECV0Vr760UbKuxsuwL7m
         xefJxTKIkEHIUSCGlGh0mZWraoQFuiGkPv0iPtcLceXsM1ffmxVIGP3j1k5dPmGs/9Mg
         1zlw==
X-Gm-Message-State: AO0yUKWlNnSPZAkTGN7BP2ebrLTG+O1UN2LWZ/4Qr+OceCldScdnC5VX
        erwAVuuZhVrOmzMkRHvtfXG9xgO2kQ==
X-Google-Smtp-Source: AK7set8NBbL61H36Znk+hvHtDw1I6Jig0feHMJqClBPQZtonwTvzT2QLtmMlV3yxBtkDxiFE99xEwg==
X-Received: by 2002:a4a:98cc:0:b0:517:5a19:a10b with SMTP id b12-20020a4a98cc000000b005175a19a10bmr5232873ooj.5.1675207925304;
        Tue, 31 Jan 2023 15:32:05 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z15-20020a4ade4f000000b004fb9a65daf1sm6592068oot.43.2023.01.31.15.32.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 15:32:05 -0800 (PST)
Received: (nullmailer pid 2151360 invoked by uid 1000);
        Tue, 31 Jan 2023 23:32:04 -0000
Date:   Tue, 31 Jan 2023 17:32:04 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Abraham I <kishon@ti.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        devicetree@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: ti,j721e-pci-host: Simplify
 'device-id' schema
Message-ID: <167520792363.2151305.15514657925774289222.robh@kernel.org>
References: <20230125221432.3058405-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230125221432.3058405-1-robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Wed, 25 Jan 2023 16:14:32 -0600, Rob Herring wrote:
> 'device-id' is just a scalar value, so just 'enum' is sufficient.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/ti,j721e-pci-host.yaml | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)
> 

Applied, thanks!

