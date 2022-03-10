Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86C94D52EB
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 21:11:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbiCJUL7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 15:11:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233319AbiCJUL6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 15:11:58 -0500
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3747E9BBAA;
        Thu, 10 Mar 2022 12:10:57 -0800 (PST)
Received: by mail-ot1-f41.google.com with SMTP id t8-20020a0568301e2800b005b235a56f2dso4818551otr.9;
        Thu, 10 Mar 2022 12:10:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=6UR/WFOFq3EqUbPef1y1xYnsL6gNNVdISGkg2vViX9w=;
        b=jSOjD66O9efOSNd39a/Mwrnin8brCNeIHaiB3s6dDJ+C78WDD+zhH5jol0lg7ficLK
         4a+v7sGAlIq5RpzIuLUDQXBFd85PETFKapRsTGz7wzIEFQGaQXYv9GR0TIWo4fxIBVOk
         FoVnxmgVB0A2OyGN+NDT1TwGTfUQ2GouHTICHtA63o1aOBSFDLovfTgrqkMPfn0Dywae
         i65PQ9KjmjMu83j3y7kHBzUvikq8Yf+LZsa/AN/G81wuDtvpYMc9qF9RxEa1cCTLqarX
         25BS5CH8vVPkvkgLSWr8p8PPjjYnyfzOc39YkHAkm96mgrXQgTxwZXnykWzrCmIDp7Qx
         pVrw==
X-Gm-Message-State: AOAM532SiSZJ/7TtU+suHAp6/GopoEZW1Hrn6UzRE7Wnrew1vtKCUWw0
        lASZLvBYOUEP47f4o1GL4w==
X-Google-Smtp-Source: ABdhPJxL7g6Qf3ansWpLK6G9FxO6gNGunWkYCEA8ijqWIMaeMWYNdpuYZ1hvk+PT1yUf71ucL/d07Q==
X-Received: by 2002:a05:6830:31ad:b0:599:7af5:d470 with SMTP id q13-20020a05683031ad00b005997af5d470mr3373087ots.50.1646943056529;
        Thu, 10 Mar 2022 12:10:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id a14-20020a544e0e000000b002d97bda3874sm2705452oiy.57.2022.03.10.12.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 12:10:55 -0800 (PST)
Received: (nullmailer pid 1982443 invoked by uid 1000);
        Thu, 10 Mar 2022 20:10:54 -0000
Date:   Thu, 10 Mar 2022 14:10:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-phy@lists.infradead.org, alexander.stein@ew.tq-group.com,
        shawnguo@kernel.org, l.stach@pengutronix.de, linux-imx@nxp.com,
        p.zabel@pengutronix.de, vkoul@kernel.org,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        linux-arm-kernel@lists.infradead.org, kernel@pengutronix.de,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v2 4/7] dt-bindings: imx6q-pcie: Add iMX8MP PCIe
 compatible string
Message-ID: <YipbTpT1B6dHSpt2@robh.at.kernel.org>
References: <1646644054-24421-1-git-send-email-hongxing.zhu@nxp.com>
 <1646644054-24421-5-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646644054-24421-5-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 07 Mar 2022 17:07:31 +0800, Richard Zhu wrote:
> Add i.MX8MP PCIe compatible string.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
