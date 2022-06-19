Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0192550C50
	for <lists+linux-pci@lfdr.de>; Sun, 19 Jun 2022 19:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232786AbiFSRUU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Jun 2022 13:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiFSRUT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 19 Jun 2022 13:20:19 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B2F63D6;
        Sun, 19 Jun 2022 10:20:18 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id l81so11157157oif.9;
        Sun, 19 Jun 2022 10:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=cvcofqYVEQjCaj+AkeCKgXWxJh7cQwGp0V6JPFxdw0U=;
        b=66Fz+hARvPXMT0IOaeECggjPZf/Af5tP3K4r72OwzL6rvWm0wl/jjIZor0YGrTTMLp
         or8Yh9VOlb29FM/iIrErRFSoS0e46buzojXU7zqjy0i5TdsEJJc/dzTzdZESCLxkBpFb
         ONtjRwdE8aMIHN5OqopWEHYWYsplak4YIMoFeXuilWQQNrVI8CCNnpanDCTqmcYJGOOx
         d3xP/Jf1COY/AGrLXcaFa+fy7yOyUic5EDqRw3pLad/bnUia0a633kOH2MVWKAg+BwzT
         vSzcOFX3xQBwmSZWuYt1bgEXti37hAAYgUJXzv9fRnttejdbBoHeBs1tSz2xHJrlGec8
         0mkQ==
X-Gm-Message-State: AJIora+d6EpsYmbPXiEWX/hooBcMExlK1AViHZhl8+LDMXd46S5wAzMn
        YnC3TYu46ksrOYK8VRXplkLgCLWTpQ==
X-Google-Smtp-Source: AGRyM1t4tv/5kd90UFjFUm8xqek2f0yIoId8FFpWPvSKMDeM5k+UARzGxxo+/61ii0CM8eNGdjOrJA==
X-Received: by 2002:a05:6808:14c5:b0:32e:f7b9:99a2 with SMTP id f5-20020a05680814c500b0032ef7b999a2mr9751321oiw.174.1655659217362;
        Sun, 19 Jun 2022 10:20:17 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.255])
        by smtp.gmail.com with ESMTPSA id d1-20020a056870540100b000f342119f41sm5899475oan.42.2022.06.19.10.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 10:20:16 -0700 (PDT)
Received: (nullmailer pid 1922480 invoked by uid 1000);
        Sun, 19 Jun 2022 17:20:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
Cc:     devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-kernel@vger.kernel.org,
        michals@xilinx.com, linux-pci@vger.kernel.org
In-Reply-To: <20220618024459.7554-2-bharat.kumar.gogada@xilinx.com>
References: <20220618024459.7554-1-bharat.kumar.gogada@xilinx.com> <20220618024459.7554-2-bharat.kumar.gogada@xilinx.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: PCI: xilinx-cpm: Add Versal CPM5 Root Port
Date:   Sun, 19 Jun 2022 11:20:15 -0600
Message-Id: <1655659215.212817.1922479.nullmailer@robh.at.kernel.org>
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

On Sat, 18 Jun 2022 08:14:58 +0530, Bharat Kumar Gogada wrote:
> Xilinx Versal Premium series has CPM5 block which supports Root Port
> functionality at Gen5 speed.
> 
> Add support for YAML schemas documentation for Versal CPM5 Root Port driver.
> 
> Signed-off-by: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
> ---
>  .../bindings/pci/xilinx-versal-cpm.yaml       | 38 ++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/xilinx-versal-cpm.yaml:17:7: [warning] wrong indentation: expected 4 but found 6 (indentation)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

