Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B91397453
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jun 2021 15:32:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234226AbhFANec (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Jun 2021 09:34:32 -0400
Received: from mail-ot1-f53.google.com ([209.85.210.53]:44780 "EHLO
        mail-ot1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbhFANeN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Jun 2021 09:34:13 -0400
Received: by mail-ot1-f53.google.com with SMTP id r26-20020a056830121ab02902a5ff1c9b81so14105469otp.11;
        Tue, 01 Jun 2021 06:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=9tCAXE4nddFK2BiC21CgcfG97csZj4okHM3YUAOIflw=;
        b=TWmE6CMHWWKFuADqKkhylkWCm9UpIGOZjXhZyJE5ZxmR8xzn0SKU7KQgxup7okfn2b
         8beQjKyrGp2ukij+gSP0nKsGbjbgV8PULnrCJbAbAOZwV2psFS/iNyDgS2lOfkE+O4/i
         8MGB2QSKGm39kDQd5mXtI3axIHviL3aWASYMYkJe7AFNNQW8a25rGBREBdso+DG39qi8
         EKrBrrqYpePtKSP5OLztP4DU725o2u0S1kzi0nT8wcY5XiN7PNjGZeYx9CrKUDXaTNkl
         1wjDt9+l7WQRwpUD9wJ9feDJEN0YzPt1nzgMhYIXWzG0S6OZJooVxlwPhZSObMvOacJC
         pplg==
X-Gm-Message-State: AOAM532uSg2RdZykj0UWFxl4ZzmkW6iFJhb/y288jUyXvX+W4C3IB64o
        aIhhcGKAUwAjO7xuo4911g==
X-Google-Smtp-Source: ABdhPJyjdjQCQJXmoGhdiwEVbUBLVuDThJ17J7LSt6xuCmDjOO9EOIYe5Sjw4mCZXxRRwNqcn8BBxw==
X-Received: by 2002:a9d:71da:: with SMTP id z26mr22095367otj.41.1622554350725;
        Tue, 01 Jun 2021 06:32:30 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id l128sm3436502oif.16.2021.06.01.06.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 06:32:28 -0700 (PDT)
Received: (nullmailer pid 242361 invoked by uid 1000);
        Tue, 01 Jun 2021 13:32:10 -0000
From:   Rob Herring <robh@kernel.org>
To:     Mark Kettenis <mark.kettenis@xs4all.nl>
Cc:     linux-pci@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Hector Martin <marcan@marcan.st>, robin.murphy@arm.com,
        devicetree@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        maz@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
In-Reply-To: <20210530224404.95917-2-mark.kettenis@xs4all.nl>
References: <20210530224404.95917-1-mark.kettenis@xs4all.nl> <20210530224404.95917-2-mark.kettenis@xs4all.nl>
Subject: Re: [PATCH v2 1/2] dt-bindings: pci: Add DT bindings for apple,pcie
Date:   Tue, 01 Jun 2021 08:32:10 -0500
Message-Id: <1622554330.029938.242360.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 31 May 2021 00:44:00 +0200, Mark Kettenis wrote:
> From: Mark Kettenis <kettenis@openbsd.org>
> 
> The Apple PCIe host controller is a PCIe host controller with
> multiple root ports present in Apple ARM SoC platforms, including
> various iPhone and iPad devices and the "Apple Silicon" Macs.
> 
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  .../devicetree/bindings/pci/apple,pcie.yaml   | 167 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 168 insertions(+)
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

See https://patchwork.ozlabs.org/patch/1485507

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

