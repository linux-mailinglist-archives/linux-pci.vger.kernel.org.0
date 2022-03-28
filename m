Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E8E44E96FF
	for <lists+linux-pci@lfdr.de>; Mon, 28 Mar 2022 14:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242686AbiC1MxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Mar 2022 08:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242650AbiC1Mwy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Mar 2022 08:52:54 -0400
Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51B523ED3E;
        Mon, 28 Mar 2022 05:51:14 -0700 (PDT)
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-de3ca1efbaso15056351fac.9;
        Mon, 28 Mar 2022 05:51:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=tvIH566M2naDeof99DqDztnAH/aJCYf9hZLfUroAlzE=;
        b=w41tTtAVuegvnrp0qRRXn9YnoJUB51KVGMXwWNnhZ7qynC2ZlKhiSJFr0x+/xzcbGK
         kb2ymzDVOo51SV4hG0Jw7q7dYtQqhVDZWhRvcP8lxlw+gYeL7maHCahyoB5dM8+MK2Lf
         yjFnPPxCTL+wqWWgstC68PtB5fhqxcCJfwcYkGudOF5MfjRAb/SCWg/EMOv8p71xis8d
         Cty69ku5gxZKKzSN/2MfNxustSMlGjsoP7rLrrpZOlakYH1iNoE8dooJy2ywmE21I7q8
         xpm5F8cOw79YCJ7zWmMD9wYHaiqIQmFIVnUBe7XuGUp2evwjgcfVxcJYSOPjCjKTt0+4
         ZTWw==
X-Gm-Message-State: AOAM533Xr7lE+7RjY0CSNNxdwxAFg6rht0MZNltxZ4ObkREGmf5HGy7T
        95ZQuzeJvvgILCHaZKFx+A==
X-Google-Smtp-Source: ABdhPJxHZ3DRiUohCXK1pGQxTd+pIpKejsX9Ww6u1GMMfHC1FdeHxhL7RxOkTMJMno7hIeqlfFYuOA==
X-Received: by 2002:a05:6871:b22:b0:dd:9eeb:4292 with SMTP id fq34-20020a0568710b2200b000dd9eeb4292mr14997931oab.223.1648471873557;
        Mon, 28 Mar 2022 05:51:13 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m187-20020aca58c4000000b002ef721352easm7183219oib.14.2022.03.28.05.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 05:51:12 -0700 (PDT)
Received: (nullmailer pid 2153572 invoked by uid 1000);
        Mon, 28 Mar 2022 12:51:05 -0000
From:   Rob Herring <robh@kernel.org>
To:     =?utf-8?b?7J207JmV7ISd?= <wangseok.lee@samsung.com>
Cc:     "kernel@axis.com" <kernel@axis.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        =?utf-8?b?7KCE66y46riw?= <moonki.jun@samsung.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-arm-kernel@axis.com" <linux-arm-kernel@axis.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        "lars.persson@axis.com" <lars.persson@axis.com>
In-Reply-To: <20220328084319epcms2p3670d7836bb111e0d9c648aeebfde8603@epcms2p3>
References: <CGME20220328084319epcms2p3670d7836bb111e0d9c648aeebfde8603@epcms2p3> <20220328084319epcms2p3670d7836bb111e0d9c648aeebfde8603@epcms2p3>
Subject: Re: [PATCH 2/5] dt-bindings: phy: Add ARTPEC-8 PCIe phy
Date:   Mon, 28 Mar 2022 07:51:05 -0500
Message-Id: <1648471865.787623.2153571.nullmailer@robh.at.kernel.org>
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,PP_MIME_FAKE_ASCII_TEXT,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 28 Mar 2022 17:43:19 +0900, 이왕석 wrote:
> Add description to support Axis, ARTPEC-8 SoC.
> ARTPEC-8 is the SoC platform of Axis Communications
> and PCIe phy is designed based on SAMSUNG PHY.
> 
> Signed-off-by: Wangseok Lee <wangseok.lee@samsung.com>
> ---
>  .../bindings/phy/axis,artpec8-pcie-phy.yaml        | 67 ++++++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/phy/axis,artpec8-pcie-phy.example.dt.yaml:0:0: /example-0/artec8/pcie-phy@16c80000: failed to match any schema with compatible: ['samsung,artpec8-pcie-phy']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1610068

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

