Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B5E3822BA
	for <lists+linux-pci@lfdr.de>; Mon, 17 May 2021 04:27:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbhEQC20 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 16 May 2021 22:28:26 -0400
Received: from mail-oi1-f171.google.com ([209.85.167.171]:39498 "EHLO
        mail-oi1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbhEQC2Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 16 May 2021 22:28:25 -0400
Received: by mail-oi1-f171.google.com with SMTP id u144so5179400oie.6;
        Sun, 16 May 2021 19:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=/er4zuQ6xSk4AaBj/SRaF6wzt3GkbqgHN4aInie/C9E=;
        b=FlajzLquCiLCntu4KKDgSB4t2/pcfRoswna8rxeEW2Wnwgb9eZnCt0ZEJsyBVpbHse
         5QRdgxBekB4DlJRYzdGJFnSKiTjluF/m5vnB2pxWcsC2XUB7U2hOykKjrjWA0vKlfhba
         jjOGfNr8SmtoUAWSjdHFTYf9XtNc96G6Nv9xxI98BPD8PlL+FXpzhc+/UAMxletx5ZK1
         znoHQpOBgcMOs7qjzRNMFSzcX4WySITbtU2vHcApWTBFJQ1pXEYAG4tobqCb+FkYC/tl
         XNBVuQLbXe7mpzNfDQoPGR6BRTaTZ8Q+ud6U8Uj+hM0fp2+6g5P5BxFY3jU9xJBc/+95
         e9aQ==
X-Gm-Message-State: AOAM533Xg/HLfouO9VPRaEUtWotocF5Px+tQPHsqSdbJhiOho/pl/DCO
        6tiplos85IAEI8V5AZdLEg==
X-Google-Smtp-Source: ABdhPJy/WI+eQ7PJfec0G3DnBFz4Sy2zaFeQyoeIuGLhRHAHHIR9uOxlxhf1sV4ePoZJBKe4ZJMlWA==
X-Received: by 2002:a54:4f0d:: with SMTP id e13mr41925650oiy.156.1621218428456;
        Sun, 16 May 2021 19:27:08 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id y11sm2520759oiv.19.2021.05.16.19.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 May 2021 19:27:07 -0700 (PDT)
Received: (nullmailer pid 1315836 invoked by uid 1000);
        Mon, 17 May 2021 02:27:03 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     arnd@arndb.de, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Hector Martin <marcan@marcan.st>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>
In-Reply-To: <20210516211851.74921-2-mark.kettenis@xs4all.nl>
References: <20210516211851.74921-1-mark.kettenis@xs4all.nl> <20210516211851.74921-2-mark.kettenis@xs4all.nl>
Subject: Re: [PATCH 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
Date:   Sun, 16 May 2021 21:27:03 -0500
Message-Id: <1621218423.820656.1315835.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 16 May 2021 23:18:46 +0200, Mark Kettenis wrote:
> From: Mark Kettenis <kettenis@openbsd.org>
> 
> The Apple PCIe host controller is a PCIe host controller with
> multiple root ports present in Apple ARM SoC platforms, including
> various iPhone and iPad devices and the "Apple Silicon" Macs.
> 
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  .../devicetree/bindings/pci/apple,pcie.yaml   | 150 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 151 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/apple,pcie.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pci/apple,pcie.example.dts:20:18: fatal error: dt-bindings/pinctrl/apple.h: No such file or directory
   20 |         #include <dt-bindings/pinctrl/apple.h>
      |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
compilation terminated.
make[1]: *** [scripts/Makefile.lib:380: Documentation/devicetree/bindings/pci/apple,pcie.example.dt.yaml] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [Makefile:1416: dt_binding_check] Error 2

See https://patchwork.ozlabs.org/patch/1479170

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

