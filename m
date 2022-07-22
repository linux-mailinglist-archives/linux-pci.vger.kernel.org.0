Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A4F57D7C6
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 02:28:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233887AbiGVA2r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 20:28:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233878AbiGVA2q (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 20:28:46 -0400
Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B392A8C5B0;
        Thu, 21 Jul 2022 17:28:45 -0700 (PDT)
Received: by mail-io1-f51.google.com with SMTP id r70so2621991iod.10;
        Thu, 21 Jul 2022 17:28:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6DrkXoX5cXYOJhQa0g1AYrB3wtqFIVlejRy8w2AKUQE=;
        b=Jj9ZnoDKF9rOo4OBibadCTIlVZgumPRz+eWLg/Im2U31YXnY5JKZXd5gucO5PujuaW
         6tdc1RSK+Sqe22k2e6VJT/KdXVpi2ZBhEkhxnp5jddqgxxY0vo897GRc+Ux+puYuy4xT
         CouUJhJn45NfasQjafuLAaFAwq/EYQK1HHegkDlPgMoEx8y6wWxecpxcyswxpZPZgXZ4
         5666FrqLDSWt0WuvwYqimchKyz3qp6pedHBZA9Wx7vMxfbaT4zo7aAgh8bjKIAPdnBBR
         ApbBIOl881bo1HFbeFQq+cavntxfsvExFtaUFasuAUmvidRqWObaDksxugScgwT5uQPa
         jlBQ==
X-Gm-Message-State: AJIora9sWfuXMuH5QW28A4+cCedhn6PP6DM8qCX9aHN6zBhhjBo1pg1w
        +jTLLLD+ImdVksgt5KzQkQ==
X-Google-Smtp-Source: AGRyM1sax7Knc34JQSbu2WweBKxoJdyvHKHR70asPoL1I5e+1I7G9SQzQHXv5Glg2tSZ7m3IT5o38g==
X-Received: by 2002:a05:6638:1441:b0:33f:64ae:aabe with SMTP id l1-20020a056638144100b0033f64aeaabemr452208jad.89.1658449724998;
        Thu, 21 Jul 2022 17:28:44 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u14-20020a02b1ce000000b00339e42c3e2fsm1387059jah.80.2022.07.21.17.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 17:28:44 -0700 (PDT)
Received: (nullmailer pid 2244596 invoked by uid 1000);
        Fri, 22 Jul 2022 00:28:43 -0000
Date:   Thu, 21 Jul 2022 18:28:43 -0600
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     kishon@ti.com, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, kernel@pengutronix.de,
        lorenzo.pieralisi@arm.com, linux-imx@nxp.com, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, l.stach@pengutronix.de,
        kw@linux.com, frank.li@nxp.com, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, robh+dt@kernel.org
Subject: Re: [PATCH v1 01/10] dt-bindings: imx6q-pcie: Add iMX8MM PCIe EP
 mode compatible string
Message-ID: <20220722002843.GA2244544-robh@kernel.org>
References: <1658223939-25478-1-git-send-email-hongxing.zhu@nxp.com>
 <1658223939-25478-2-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658223939-25478-2-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 19 Jul 2022 17:45:30 +0800, Richard Zhu wrote:
> Add i.MX8MM PCIe endpoint mode compatible string.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
