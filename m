Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DAD34A858C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Feb 2022 14:50:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiBCNub (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Feb 2022 08:50:31 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:38570 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240877AbiBCNub (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Feb 2022 08:50:31 -0500
Received: by mail-oi1-f174.google.com with SMTP id u13so4164315oie.5;
        Thu, 03 Feb 2022 05:50:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject:date
         :message-id;
        bh=xOMR2ZZkrEs2A9siePkmd/O1P6JtjHeXZOx/YTCMPaw=;
        b=5a9f6DUBb3tNxB72MjCU2r4qM4ebnwhWDrw12fYAqIcsUgMxaZIp3FL6r09WPFkN5P
         uYmQZPLtlmq8S97m6IqMRwlkczhLZEWYzpErSDBMVHm9EB2rErYYqDG4OLI4Jt/XWNOw
         WgiepgpWIcEzDJPN9FNtX+V5sWIt2ARDLwrpb5D62izXFl8TYbvu04l9e84GjnFwng00
         0ALwr2cZfnTvXsloNILCxXsFTkGe/MXNEcPXd7FIq2tTQOtdGEosPyFTs1qoxOYd2hlN
         YMyvmTA2WU29F3YqAr2P6NO9sQVNmTzzk8jdB66mETRg3C+vHE7EffVrvfDu1LtyQn6H
         8i6w==
X-Gm-Message-State: AOAM533Cu0BgWBwfI1MJ+tFEv1LwM/AkLEQsK84sVGPS8cze3QI94gjG
        DkSMtf+AAwueM3hE03IoPA==
X-Google-Smtp-Source: ABdhPJwrAaj+h4ToZSivyMAtRx9hbnjMKYgFG1qOzYFEDJgMxgc7UZ4Vb86wLsVAjfdv+ODcS60jyw==
X-Received: by 2002:a05:6808:190f:: with SMTP id bf15mr7563854oib.40.1643896230398;
        Thu, 03 Feb 2022 05:50:30 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id k10sm18671534oou.26.2022.02.03.05.50.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Feb 2022 05:50:29 -0800 (PST)
Received: (nullmailer pid 252334 invoked by uid 1000);
        Thu, 03 Feb 2022 13:50:26 -0000
From:   Rob Herring <robh@kernel.org>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
In-Reply-To: <1643855786-23186-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1643855786-23186-1-git-send-email-hayashi.kunihiko@socionext.com> <1643855786-23186-2-git-send-email-hayashi.kunihiko@socionext.com>
Subject: Re: [PATCH 1/3] dt-bindings: PCI: uniphier-ep: Add bindings for NX1 SoC
Date:   Thu, 03 Feb 2022 07:50:26 -0600
Message-Id: <1643896226.748637.252333.nullmailer@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 03 Feb 2022 11:36:24 +0900, Kunihiko Hayashi wrote:
> Update PCI endpoint binding document for UniPhier NX1 SoC. Add a compatible
> string, clock and reset lines for the SoC to the document.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/pci/socionext,uniphier-pcie-ep.yaml   | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
> 

My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:
./Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml:24:9: [warning] too many spaces after hyphen (hyphens)
./Documentation/devicetree/bindings/pci/socionext,uniphier-pcie-ep.yaml:25:9: [warning] too many spaces after hyphen (hyphens)

dtschema/dtc warnings/errors:

doc reference errors (make refcheckdocs):

See https://patchwork.ozlabs.org/patch/1587871

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.

