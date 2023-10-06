Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6BA7BBF39
	for <lists+linux-pci@lfdr.de>; Fri,  6 Oct 2023 20:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233379AbjJFSyt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Oct 2023 14:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233322AbjJFSyo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Oct 2023 14:54:44 -0400
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6E3192;
        Fri,  6 Oct 2023 11:53:22 -0700 (PDT)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-57bbb38d5d4so1339050eaf.2;
        Fri, 06 Oct 2023 11:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696618401; x=1697223201;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ONWYXZO8bRA2dtbBYHDHCwN702DxO6KSZQecU63vDlo=;
        b=GWmvmgyD3qJkkaPwe5BH2gazul1rPbVxZ9vIbvRl7hmHUg/4Q1RuIay4h6ed1Hj8nH
         S6jDqOHiEcGjDFH5zXQK49Xg02o8Hylz3TYiUh2t2BqOEFWDL79xd+FmKg75lJuKR7is
         tgP82bwK4IFzN2KQhtHlhxHt5mGB0objt7/mVcsFzBGj0mV/kVu65BNejR6UJQoC6EWh
         92+cDTCYGg/0vfl9trcw5MVuFjRNG7EKGHZV5HxRRZFhKEe1FDAWGTFE87VRkaqz/24t
         F99fvt5icPVRKg8o5mH96iJmO1bpOuXFYgvPtzy4OeItNqCgJzZQdahg0/1mj87lAwRU
         /MLg==
X-Gm-Message-State: AOJu0Yy3H+LU6HcMjwBIVyU18+LtDNQFkaQIpIh8wtxdimTkEiV0ntn5
        xorp/xRVSoIkW3RkqZJy5g==
X-Google-Smtp-Source: AGHT+IGm7i4Gm4811lafkcRg2mRNgArk1KRGl1/P7rQgRS2vE3vNsksU09zwwQNf8Ilhn56KR07Ntw==
X-Received: by 2002:a4a:6c4f:0:b0:57b:7ac4:7a94 with SMTP id u15-20020a4a6c4f000000b0057b7ac47a94mr9895708oof.2.1696618401638;
        Fri, 06 Oct 2023 11:53:21 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v127-20020a4a5a85000000b0057b8baf00bbsm486983ooa.22.2023.10.06.11.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 11:53:21 -0700 (PDT)
Received: (nullmailer pid 136832 invoked by uid 1000);
        Fri, 06 Oct 2023 18:53:19 -0000
Date:   Fri, 6 Oct 2023 13:53:19 -0500
From:   Rob Herring <robh@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Scott Branden <sbranden@broadcom.com>,
        linux-arm-kernel@lists.infradead.org, Ray Jui <rjui@broadcom.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>
Subject: Re: [PATCH 2/3] dt-bindings: PCI: brcm,iproc-pcie: Drop common
 pci-bus properties
Message-ID: <169661839855.136745.10599768047643852824.robh@kernel.org>
References: <20230926155351.31117-1-robh@kernel.org>
 <20230926155351.31117-2-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926155351.31117-2-robh@kernel.org>
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


On Tue, 26 Sep 2023 10:53:41 -0500, Rob Herring wrote:
> Drop the unnecessary listing of properties already defined in
> pci-bus.yaml. Unless there are additional constraints, it is not
> necessary.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  .../devicetree/bindings/pci/brcm,iproc-pcie.yaml  | 15 ---------------
>  1 file changed, 15 deletions(-)
> 

Applied, thanks!

