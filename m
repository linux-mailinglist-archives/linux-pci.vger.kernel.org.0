Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F66E4D52A5
	for <lists+linux-pci@lfdr.de>; Thu, 10 Mar 2022 20:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiCJTz6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Mar 2022 14:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiCJTz5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Mar 2022 14:55:57 -0500
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6EA3DF4A0;
        Thu, 10 Mar 2022 11:54:56 -0800 (PST)
Received: by mail-oo1-f50.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso8125438ooi.1;
        Thu, 10 Mar 2022 11:54:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gOIMKNeVX044LSwaRshmsbZTbEhX/iEa0SUNdB2Ikeg=;
        b=TiKVIWcrT+K+wFBPR3/s5NsSVCv9cU1y/cxVO3kp7LochtJcR7yeuRVs9i3zSP93Vp
         9yOLmI/O05VWh5fn1lfgJZzd1ExhdDCgUOnecWiO8G0NH1Um90DLo3aG6Kq/eedOBWVF
         Yu+n3D8XP1RQkGhnvYFQ30wIVq4KJKGbZE61AC+r9okS4lkx5sOhB9LMqTge90PBMtta
         6syEebpU+Q/t/uU7EW69QW4UQ3ENVwkj01Er1bCweiI6J7A65ARajMvpY4o3Rn+JOQpZ
         tfWPA8dElVJeeyD3bhr50GTiJeKul6dZN7UCw/XxLd2E/uqLGPdoZHzUxyWAVOENuOYi
         XhGA==
X-Gm-Message-State: AOAM53002I53RXcJbh6mKkhV9fLpH+a0FYAXc0as8zaA/qFqcJxGO45a
        SPj84gVUJyKIluC30bPUMg==
X-Google-Smtp-Source: ABdhPJxENrF50U1QNywvt6Jd4JKG6Rw9w0Qwymtn2Cwm8MCVPwveLq5HCnvYEg3+6d4+cYtICrXd3w==
X-Received: by 2002:a05:6870:4346:b0:da:b3f:2b23 with SMTP id x6-20020a056870434600b000da0b3f2b23mr9983638oah.194.1646942096218;
        Thu, 10 Mar 2022 11:54:56 -0800 (PST)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id w1-20020a056808090100b002da82caced5sm410433oih.3.2022.03.10.11.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 11:54:55 -0800 (PST)
Received: (nullmailer pid 1956012 invoked by uid 1000);
        Thu, 10 Mar 2022 19:54:54 -0000
Date:   Thu, 10 Mar 2022 13:54:54 -0600
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, kernel@pengutronix.de,
        l.stach@pengutronix.de, linux-kernel@vger.kernel.org,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, linux-imx@nxp.com,
        shawnguo@kernel.org
Subject: Re: [PATCH] dt-bindings: imx6q-pcie: Add iMX8MM PCIe compatible
 string
Message-ID: <YipXjouu5LSJyrES@robh.at.kernel.org>
References: <1646293805-18248-1-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646293805-18248-1-git-send-email-hongxing.zhu@nxp.com>
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

On Thu, 03 Mar 2022 15:50:05 +0800, Richard Zhu wrote:
> Add the i.MX8MM PCIe compatible string.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Applied, thanks!
