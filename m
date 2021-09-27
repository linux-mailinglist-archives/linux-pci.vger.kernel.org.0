Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33A744199BD
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 18:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbhI0Q4f (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 12:56:35 -0400
Received: from mail-ot1-f42.google.com ([209.85.210.42]:43875 "EHLO
        mail-ot1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235439AbhI0Q4e (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Sep 2021 12:56:34 -0400
Received: by mail-ot1-f42.google.com with SMTP id x33-20020a9d37a4000000b0054733a85462so25273901otb.10;
        Mon, 27 Sep 2021 09:54:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=k+03s9ColU3insx3nl7OabKJ2TECvU9cwXvP5gaCp+c=;
        b=DYu+JOQd0CzZtEG4FWVOcuHA07cak8/9ycCC+2oz3n1BctOKoyr+v9OIET1ta4UGGy
         8fEzYdvMlBYj6gnzmx0mdbirCCwj9TVrnmWjifBlTRzN/d1KxR3Nyjil9U7A8JIRIca+
         ZivEf3qBbT3CrjMb0BHV0wauUdwEgL4HEqe3I2hL6ceeckV8ySchZ9u+pQ0utLywnyTk
         oUdiU/810/7hO5z4orP9jKZKiTLuc5q99NY7o3MXroCvm8bWj0tDx3qpCEYE/KI5Vyrl
         Rkji0AJf09UGLFlcBAf/33wiH7cKcPqu3+q3mbcXiwLHfm37laTTXHSPdp8BqxAF7neC
         FhNQ==
X-Gm-Message-State: AOAM530XmsTu539dPAokZTJXfIYcpfjJjZOVDi5nUIwHsOOTAavVoEb2
        2Olp5cUQ1ihVuDQ6zPhvJQ==
X-Google-Smtp-Source: ABdhPJwyDYj6BSP2zD/66bQe1DTfa0qH76DYxW7XvZ4ZjwIQfIDQ1VlH/IN+CXT6oH3l0/QZlYE80g==
X-Received: by 2002:a05:6830:2486:: with SMTP id u6mr902465ots.93.1632761696429;
        Mon, 27 Sep 2021 09:54:56 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id q20sm949145ooc.29.2021.09.27.09.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 09:54:55 -0700 (PDT)
Received: (nullmailer pid 3457954 invoked by uid 1000);
        Mon, 27 Sep 2021 16:54:54 -0000
Date:   Mon, 27 Sep 2021 11:54:54 -0500
From:   Rob Herring <robh@kernel.org>
To:     Mark Kettenis <kettenis@openbsd.org>
Cc:     sven@svenpeter.dev, Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Hector Martin <marcan@marcan.st>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-rpi-kernel@lists.infradead.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Fainelli <f.fainelli@gmail.com>, alyssa@rosenzweig.io,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        maz@kernel.org, robin.murphy@arm.com, linux-pci@vger.kernel.org,
        Jim Quinlan <jim2101024@gmail.com>,
        Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v5 1/4] dt-bindings: interrupt-controller: Convert MSI
 controller to json-schema
Message-ID: <YVH3XhxjL/hVJxkN@robh.at.kernel.org>
References: <20210921183420.436-1-kettenis@openbsd.org>
 <20210921183420.436-2-kettenis@openbsd.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210921183420.436-2-kettenis@openbsd.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 21 Sep 2021 20:34:12 +0200, Mark Kettenis wrote:
> Split the MSI controller bindings from the MSI binding document
> into DT schema format using json-schema.
> 
> Acked-by: Marc Zyngier <maz@kernel.org>
> Signed-off-by: Mark Kettenis <kettenis@openbsd.org>
> ---
>  .../interrupt-controller/msi-controller.yaml  | 38 +++++++++++++++++++
>  .../bindings/pci/brcm,stb-pcie.yaml           |  1 +
>  .../bindings/pci/microchip,pcie-host.yaml     |  1 +
>  3 files changed, 40 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/msi-controller.yaml
> 

Applied, thanks!
