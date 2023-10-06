Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A15A7BBF36
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 20:54:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233405AbjJFSys (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 14:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233362AbjJFSyn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 14:54:43 -0400
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD0E13A;
        Fri,  6 Oct 2023 11:53:18 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6c4b9e09528so1576682a34.3;
        Fri, 06 Oct 2023 11:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618397; x=1697223197;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NgHDaFVKjk5Tz3smYemKLQ/U+tfp6fpmolPcd3VkR3Y=;
        b=tl+gKyNwX2DUfe7Wg1XE3pFPx4TQQjGTg6OA1XaZMJ+FJIX4EnclppeFsKSYaI8M9j
         8jgGWrX9fF2Lsy8jAA8qNnBSWUBnkXH0t4qIr7oXAJLgzfQnZ/Bvh6PHdZYNKRucAPEJ
         TjHbG49JIPQrzYmONlDNQ4QjUxwaZEYL7N2ElVbr//AmrGEJDIY41vEo1bmBLu++63a6
         zv+fVPjnpK+AaDs1VXRDtHxKpHr9q3tt4wtObkO90wNLI2U9BZbhZ01E9tTk5cpGZYJs
         NqIZXRYqowf483HqNW1ig4QDMhdcXoWRiqdpW6C2CxJW+ozzDLUhHdFKWs9e8bFz+r5T
         9dPQ==
X-Gm-Message-State: AOJu0YwbHqexhvofBuvzctplCNLXKZvn2zJcGdBm3Qgh/5biN984rOYY
        YEN5Psa+IfhSYCGDmrNTAA==
X-Google-Smtp-Source: AGHT+IHvOnliybToFTSuyoigWnqOnxAGdE+QcUPu8P2u4dnDC8XWyk8frh9ogE4DuaLJ2P3FFyGKZg==
X-Received: by 2002:a9d:75da:0:b0:6c4:deba:254f with SMTP id c26-20020a9d75da000000b006c4deba254fmr9618468otl.22.1696618397071;
        Fri, 06 Oct 2023 11:53:17 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v17-20020a05683011d100b006b881a6518esm654490otq.10.2023.10.06.11.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:53:16 -0700 (PDT)
Received: (nullmailer pid 136626 invoked by uid 1000);
        Fri, 06 Oct 2023 18:53:15 -0000
Date:   Fri, 6 Oct 2023 13:53:15 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Ray Jui <rjui@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        devicetree@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Scott Branden <sbranden@broadcom.com>,
        Ray Jui <ray.jui@broadcom.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 1/3] dt-bindings: PCI: brcm,iproc-pcie: Fix example
 indentation
Message-ID: <169661838083.136126.6539111218233008277.robh@kernel.org>
References: <20230926155351.31117-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926155351.31117-1-robh@kernel.org>
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


On Tue, 26 Sep 2023 10:53:40 -0500, Rob Herring wrote:
> The example's indentation is off. While fixing this, the 'bus' node
> is unnecessary and can be dropped. It is also preferred to split up
> unrelated examples to their own entries.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/pci/brcm,iproc-pcie.yaml         | 124 +++++++++---------
>  1 file changed, 60 insertions(+), 64 deletions(-)
> 

Applied, thanks!

