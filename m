Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1295EB4D4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Sep 2022 00:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiIZWxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Sep 2022 18:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiIZWxU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 26 Sep 2022 18:53:20 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6C6CE08;
        Mon, 26 Sep 2022 15:53:20 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id w22-20020a056830061600b006546deda3f9so5400105oti.4;
        Mon, 26 Sep 2022 15:53:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=1KyI/YiZ9o+DkbCha5lJgOmG2QK4+2AqmbtElIJsO1U=;
        b=HB+3m3w6CJ/WWDHZozj5U6b34v5+ciTdfNFA1g7qhHrzhmk3XgTXAEJBK5NBd2Pln/
         X35XSzxxYU5oeI70u29Zw9ghh+FoUV6o1tAi0gFiWEC7G2fbfwbxBCQpKY2A3bZ9KjGV
         ppq53Ox2xqHjA4iFHANb/ajopvKVmF3chNI+CqB3TcQg6Kcw0GozqDeS+iidg/MdMeep
         qOcZudwt32FX0/hmHmv7I/R0FesCf5MXoWMnZEcDxdri5ictfR3LG1ldpnsIKe/PQ3IQ
         blu5b1zWGLJgUn/VxO+cVgyaNTqzIGbu58ec7GedUSDsWtCf12T7CY5TmvoUJrfAx3IS
         b7NA==
X-Gm-Message-State: ACrzQf0CSagAJxwmzSBiARo7RKcVuw7tj8br6o22P5f+0c8JGSvJ8dY9
        SUf0VCg1sfvr3rbthqVWdA==
X-Google-Smtp-Source: AMsMyM6CLc44+ZHmzIrhrhVNnqkAT+B9X8/pWLpgYP+Dn4DjDs6XccJaIrD9uXHXN4lbHDZWaDyjSA==
X-Received: by 2002:a05:6830:3901:b0:658:fff4:51b8 with SMTP id br1-20020a056830390100b00658fff451b8mr10765748otb.55.1664232799267;
        Mon, 26 Sep 2022 15:53:19 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id u27-20020a4a6c5b000000b004761ac650e1sm7162315oof.42.2022.09.26.15.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 15:53:18 -0700 (PDT)
Received: (nullmailer pid 3112634 invoked by uid 1000);
        Mon, 26 Sep 2022 22:53:17 -0000
Date:   Mon, 26 Sep 2022 17:53:17 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, robh+dt@kernel.org,
        linux-imx@nxp.com, kernel@pengutronix.de, kw@linux.com,
        devicetree@vger.kernel.org, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, frank.li@nxp.com,
        l.stach@pengutronix.de, shawnguo@kernel.org, kishon@ti.com
Subject: Re: [PATCH v3 03/14] dt-bindings: imx6q-pcie: Add iMX8MP PCIe EP
 mode compatible string
Message-ID: <20220926225317.GA3112562-robh@kernel.org>
References: <1663913220-9523-1-git-send-email-hongxing.zhu@nxp.com>
 <1663913220-9523-4-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663913220-9523-4-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 23 Sep 2022 14:06:49 +0800, Richard Zhu wrote:
> Add i.MX8MP PCIe endpoint mode compatible string.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
