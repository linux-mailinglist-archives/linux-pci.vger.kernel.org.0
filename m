Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D52B47487F
	for <lists+linux-pci@lfdr.de>; Tue, 14 Dec 2021 17:49:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhLNQt1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 Dec 2021 11:49:27 -0500
Received: from mail-oo1-f51.google.com ([209.85.161.51]:42823 "EHLO
        mail-oo1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbhLNQt1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 14 Dec 2021 11:49:27 -0500
Received: by mail-oo1-f51.google.com with SMTP id x1-20020a4aea01000000b002c296d82604so5078717ood.9;
        Tue, 14 Dec 2021 08:49:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qokM6jUX14ucUuDn7IqgVTrViuB8oq3uUjQQEtGlv1s=;
        b=70eB6TK0NbJq1lItIrDUZ8wNAU5UKzmlc8hJNIUPTjwkHydrZBt40XhYKvHi9max02
         3SnAeeePoIgnSXFYh7UQZQqeQFqqCive6lkGdoxE+HmWXklQ7LxPjIul10Bzi5kh3QRv
         Ngj5bqY8lcHe9TK2qVwEw5uaF7szRdU8n3NcGCkHLKlHEKbZwfPcHkVl5/higHRWEn3e
         DGAGmmPF80IZ/CGzNuCqa5KGYumnBKp9HwAod/rcZCEyhMNUc7sr0lyFkqd4z9scQchJ
         Y/1cBAl5ndkJpG0yDyC66dWKYsLbOdOGCXaNPWAdqtsq8ozBj63PdAAnV4LXuvgjQ7FB
         AEIw==
X-Gm-Message-State: AOAM532Gp7FlhDZ4rGb5alCmyiAM2PWVbwIOB/JqpuTOqd99AT43qvwA
        nEah4L4tErEqMeTpO5DaGKeViMs8ow==
X-Google-Smtp-Source: ABdhPJwE7QIPRKfJ6kuLUIrl5bqjH/TJnwVHyJhI+MpEKiLsAnLraikB1eLWvmaPSUTCEQCNdmcvaw==
X-Received: by 2002:a4a:9292:: with SMTP id i18mr4168858ooh.90.1639500566377;
        Tue, 14 Dec 2021 08:49:26 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q2sm62231otg.64.2021.12.14.08.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 08:49:25 -0800 (PST)
Received: (nullmailer pid 3534654 invoked by uid 1000);
        Tue, 14 Dec 2021 16:49:24 -0000
Date:   Tue, 14 Dec 2021 10:49:24 -0600
From:   Rob Herring <robh@kernel.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <rjui@broadcom.com>, linux-pci@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        bcm-kernel-feedback-list@broadcom.com
Subject: Re: [PATCH v6 6/6] dt-bindings: pci: Convert iProc PCIe to YAML
Message-ID: <YbjLFLe2RxqtntCD@robh.at.kernel.org>
References: <20211214035820.2984289-1-f.fainelli@gmail.com>
 <20211214035820.2984289-7-f.fainelli@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214035820.2984289-7-f.fainelli@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 13 Dec 2021 19:58:20 -0800, Florian Fainelli wrote:
> Conver the iProc PCIe controller Device Tree binding to YAML now that
> all DTS in arch/arm and arch/arm64 have been fixed to be compliant.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  .../bindings/pci/brcm,iproc-pcie.txt          | 133 -------------
>  .../bindings/pci/brcm,iproc-pcie.yaml         | 184 ++++++++++++++++++
>  2 files changed, 184 insertions(+), 133 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.txt
>  create mode 100644 Documentation/devicetree/bindings/pci/brcm,iproc-pcie.yaml
> 

Applied, thanks!
