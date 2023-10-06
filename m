Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B227BBF51
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 20:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233308AbjJFSzD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 14:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233398AbjJFSyo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 14:54:44 -0400
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 889AF19F;
        Fri,  6 Oct 2023 11:53:30 -0700 (PDT)
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-57bb6b1f764so1447358eaf.2;
        Fri, 06 Oct 2023 11:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618410; x=1697223210;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pu1OhqaEizQhNsXiPRvW0zuKQRn9KfZiSBfIH3NMeIw=;
        b=s/Zvfd2VJweS8M7BtG1n4DbO58nm9TI8mY1XKcgXIxc08r+SY5m80KHK6Q9dCIhjQJ
         ii4Z5BAXfFdkSO5B6ueWjT+cwUc6jScN5VXOkvcn0lRb7CHH5K4J2Ng9peIJ4IOG31f4
         4kzN/7GIqkzkNOKVPf8jwKb+u27pkKDSXRtlWEtP7ZAyDHS3KyflIHOJLjmOY45dyvQd
         m6ZiEYv6LFBmIPfpwgrhIjtBT0AmU/A+TawoG25W6VHB65gjGBzB3b5G6h+PVXqfvcaI
         0rmBtLcMvf+KAV/cKrOBTdgtsh/nGS1FLqzeVwIOWwgPq0WUPwZcr6815iOG8J+0iibL
         qcOA==
X-Gm-Message-State: AOJu0Yw2mJGnxwhtxm2svJcFnFHSESRT8NSnjZ4/b4ub5cuksy1nh32d
        rCw1pfFrCqKN/90nf6MC9A==
X-Google-Smtp-Source: AGHT+IF+T0d7oTVdlXt4Yx2WM43GDasmNgyD6b0RzCQ+yHy1Oq8qLsNcOxF/Qtri9h1PO8yl+6CffA==
X-Received: by 2002:a4a:3447:0:b0:571:1fad:ebdb with SMTP id n7-20020a4a3447000000b005711fadebdbmr9655109oof.3.1696618409730;
        Fri, 06 Oct 2023 11:53:29 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z6-20020a4aae06000000b0057b74352e3asm469358oom.25.2023.10.06.11.53.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:53:29 -0700 (PDT)
Received: (nullmailer pid 137174 invoked by uid 1000);
        Fri, 06 Oct 2023 18:53:28 -0000
Date:   Fri, 6 Oct 2023 13:53:28 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org,
        Ray Jui <ray.jui@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        devicetree@vger.kernel.org,
        Scott Branden <scott.branden@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Ray Jui <rjui@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] dt-bindings: PCI: brcm,iproc-pcie: Fix 'msi' child
 node schema
Message-ID: <169661840623.137085.10013985063047530748.robh@kernel.org>
References: <20230926155351.31117-1-robh@kernel.org>
 <20230926155613.33904-3-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926155613.33904-3-robh@kernel.org>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Tue, 26 Sep 2023 10:56:09 -0500, Rob Herring wrote:
> The 'msi' child node schema is missing constraints on additional properties.
> It turns out it is incomplete and properties for it are documented in the
> parent node by mistake. Move the reference to msi-controller.yaml and
> the custom properties to the 'msi' node. Adding 'unevaluatedProperties'
> ensures all the properties in the 'msi' node are documented.
> 
> With the schema corrected, a minimal interrupt controller node is needed
> to properly decode the interrupt properties since the example has
> multiple interrupt parents.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pci/brcm,iproc-pcie.yaml         | 24 ++++++++++++-------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 

Applied, thanks!

