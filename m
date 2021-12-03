Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B302546808C
	for <lists+linux-pci@lfdr.de>; Sat,  4 Dec 2021 00:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383468AbhLCXhs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Dec 2021 18:37:48 -0500
Received: from mail-oi1-f172.google.com ([209.85.167.172]:34488 "EHLO
        mail-oi1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383441AbhLCXhp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 Dec 2021 18:37:45 -0500
Received: by mail-oi1-f172.google.com with SMTP id t19so8862005oij.1;
        Fri, 03 Dec 2021 15:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=5xVzvDh1joQ0PvtSRXDyTia4qRtzHANFPSquK7O4Heg=;
        b=6rJV6ImOG4Mak3mc+XfBCUxGpemC363s1jS1OKwVPxmXu0qkA462WvBaYIug5blUbf
         uvoSJNaExjD+2ZH4wTS74oRQAiasSUq8NMMGeKUT3BUY3VhK2w1fhXUtKHD3Z+qT/463
         ataBvqGzASaQGAAO6YJ8usqyTvXIXEXVdcQmgGY9844qDpfbaCL4ly3Gm/09gUMCSEWG
         36CUEMZbnntywD88WnhkrTSCEbxby1TQshUEQR3slwoYeTm8/vLWtL/SCxHOpvAY5tSm
         p3hmwk5jCinTNb8lrLK/sJ2UI/hpzGRLTHfUHtR0jrLF2E4wLeXNEz/MUvSdtFvl8rJu
         swWQ==
X-Gm-Message-State: AOAM5334DcNnCuZxzN2rAXuvrwl4kh7myUZ2+VRFDWgSdQTNc7HkKRAY
        E01OzLxU4QpfJJIC3HWAIA==
X-Google-Smtp-Source: ABdhPJy4EYzcmvaszVCZtdLXGyr9r/GuQ7QGHrA0QRrleCyp6BSEkJZmgzgvRtOFnfBaOn8BQ+NNVQ==
X-Received: by 2002:a05:6808:ec9:: with SMTP id q9mr12176101oiv.160.1638574460276;
        Fri, 03 Dec 2021 15:34:20 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id h26sm847262oor.17.2021.12.03.15.34.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 15:34:19 -0800 (PST)
Received: (nullmailer pid 1043001 invoked by uid 1000);
        Fri, 03 Dec 2021 23:34:15 -0000
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com, Ray Jui <rjui@broadcom.com>,
        devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
In-Reply-To: <20211202233248.1190797-6-f.fainelli@gmail.com>
References: <20211202233248.1190797-1-f.fainelli@gmail.com> <20211202233248.1190797-6-f.fainelli@gmail.com>
Subject: Re: [PATCH 5/5] dt-bindings: pci: Convert iProc PCIe to YAML
Date:   Fri, 03 Dec 2021 17:34:15 -0600
Message-Id: <1638574455.209193.1043000.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 02 Dec 2021 15:32:48 -0800, Florian Fainelli wrote:
> Conver the iProc PCIe controller Device Tree binding to YAML now that
> all DTS in arch/arm and arch/arm64 have been fixed to be compliant.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/pci/brcm,iproc-pcie.txt          | 133 --------------
>  .../bindings/pci/brcm,iproc-pcie.yaml         | 172 ++++++++++++++++++
>  2 files changed, 172 insertions(+), 133 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
Documentation/devicetree/bindings/pci/brcm,iproc-pcie.example.dt.yaml:0:0: /example-0/bus/pcie@18012000/msi: failed to match any schema with compatible: ['brcm,iproc-msi']

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1563044

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

