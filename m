Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2090E57D7C8
	for <lists+linux-pci@lfdr.de>; Fri, 22 Jul 2022 02:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbiGVA26 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 20:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiGVA24 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 20:28:56 -0400
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 723AA89E84;
        Thu, 21 Jul 2022 17:28:55 -0700 (PDT)
Received: by mail-il1-f171.google.com with SMTP id h14so1644800ilq.12;
        Thu, 21 Jul 2022 17:28:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uwv+gN0NlgKxjcm7U5gVS+wwglvRHuzmiAe4Kbo6KBU=;
        b=c44ePVI4Szi8Gpuu/yowXvI4Nkq9NrvYArI/7ubZbSTIwkK7hIaNvDoyp+/czdXr+X
         f6H2QEY4AZD5dtoxFuo6sdVxJYkqNtnVe0+ffp2jeJBll5SntOtbDPOQmGsq3COa9vd+
         fh4D0Y+LuLNPAbROssIGcKIUBYyn2Iz8TsuiaGR5/3G7qO0dbAmed5w7NqAHHStNDDOQ
         lFP5R0k33eC3w2Hq/TD1mW3TxvE00RSsFaTfxuxhPLx6/Z1p3JTr6RElmClKphzBJ2bl
         QPjtOHmX2t8V0biqu6e5QEakLfWaKGvW87pIHSTS4ZKYedbf0HqOEsCsp4nZuqpX70ET
         ZdnQ==
X-Gm-Message-State: AJIora+1SQiYjt69Hc34s0YhXTtn7RV4OfLl7S1AofWWCIuB36kEA4Sx
        0vekkbhagO7EE5ZJR7C5tQ==
X-Google-Smtp-Source: AGRyM1urL3PlZaVsQRdlXGlj6gmmEOJcuktf0By1HpYfXlLl2jfPpiCZ+d2KBxAHYFinihcmiU84NQ==
X-Received: by 2002:a05:6e02:1b01:b0:2dc:7472:a5d1 with SMTP id i1-20020a056e021b0100b002dc7472a5d1mr393678ilv.62.1658449734546;
        Thu, 21 Jul 2022 17:28:54 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id cv2-20020a056638498200b00332044db2aasm1416302jab.95.2022.07.21.17.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 17:28:54 -0700 (PDT)
Received: (nullmailer pid 2244922 invoked by uid 1000);
        Fri, 22 Jul 2022 00:28:52 -0000
Date:   Thu, 21 Jul 2022 18:28:52 -0600
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kw@linux.com,
        l.stach@pengutronix.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, kishon@ti.com, kernel@pengutronix.de,
        robh+dt@kernel.org, linux-pci@vger.kernel.org, linux-imx@nxp.com,
        bhelgaas@google.com, frank.li@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/10] dt-bindings: imx6q-pcie: Add iMX8MQ PCIe EP
 mode compatible string
Message-ID: <20220722002852.GA2244896-robh@kernel.org>
References: <1658223939-25478-1-git-send-email-hongxing.zhu@nxp.com>
 <1658223939-25478-3-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658223939-25478-3-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 19 Jul 2022 17:45:31 +0800, Richard Zhu wrote:
> Add i.MX8MQ PCIe endpoint mode compatible string.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
