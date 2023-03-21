Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 761CE6C3B9C
	for <lists+linux-pci@lfdr.de>; Tue, 21 Mar 2023 21:20:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjCUUUd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Mar 2023 16:20:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjCUUUc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Mar 2023 16:20:32 -0400
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02600EC75;
        Tue, 21 Mar 2023 13:19:24 -0700 (PDT)
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-1755e639b65so17485484fac.3;
        Tue, 21 Mar 2023 13:19:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679429939;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Vv0/QpHW4WBzNxG4OfYkP6UO/kQv3JtxHcAwY9D2EE=;
        b=s9K5NNSAkfwHftZW0PRxBZ3mTFtwl21ENBYiO2EFWawklUArX2vDItPlRWzz48QkEB
         9Mt8iY1W87Mo0em1Q27w/8AMe1hDB+Hms5vIbqOe88VLretzZbrlajTmauOWrwXrEr5L
         xCLBNEKESJoZMWXjXb5+Yj8ClthHj++k16Ef7RDEwnPzWPs4U3uIuSiQly5DIamMI/6B
         qMh/whGVSVKTWI+NCWMHK2ARRAqiFm148aoHapkKzw/u7Xm5wUibgLEZDTbdpbpftbxQ
         Pndkl4DU+MEJAU/e3IL4TVqYHKlyZfJUIzHTZDmJZ+mBMqUkVs3MJW2dyP+X11ZWqHL/
         0ZDA==
X-Gm-Message-State: AO0yUKVrfVMNn7Xy1oTnjI2Y1sMxJHHuFaYX4cF+KwiItDyvhqwcA899
        Yrabuf5tEENsI791DFv8S1LBkUuwlQ==
X-Google-Smtp-Source: AK7set+a0lSr7Z1I8SaxHEPIsHU/HqHm0Uo+B9z0TCPujXIJCJsbz2HeZI33vbZ60IgW5Uf1RCg8Zg==
X-Received: by 2002:a05:6870:a7a5:b0:17e:77bb:2c14 with SMTP id x37-20020a056870a7a500b0017e77bb2c14mr187645oao.1.1679429939289;
        Tue, 21 Mar 2023 13:18:59 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id vi15-20020a0568710d8f00b001724742cfcesm4507293oab.38.2023.03.21.13.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 13:18:58 -0700 (PDT)
Received: (nullmailer pid 1477651 invoked by uid 1000);
        Tue, 21 Mar 2023 20:18:58 -0000
Date:   Tue, 21 Mar 2023 15:18:58 -0500
From:   Rob Herring <robh@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH] dt-bindings: PCI: Fix unit address of example root port
Message-ID: <167942993719.1477341.14094858300653754193.robh@kernel.org>
References: <20230317112019.9090-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230317112019.9090-1-johan+linaro@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On Fri, 17 Mar 2023 12:20:19 +0100, Johan Hovold wrote:
> Fix the unit address of the example root port which is identical to the
> device number (i.e. 1).
> 
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  Documentation/devicetree/bindings/pci/pci.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Acked-by: Rob Herring <robh@kernel.org>

