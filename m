Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64BB4EFB7A
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 22:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347423AbiDAU3M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 16:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352718AbiDAU21 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 16:28:27 -0400
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569AD58395;
        Fri,  1 Apr 2022 13:26:36 -0700 (PDT)
Received: by mail-oi1-f173.google.com with SMTP id e189so3917775oia.8;
        Fri, 01 Apr 2022 13:26:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=T+0PW5LNkz/Ox7qIIpulz8qqFC9xWysNmc+x8WFttFI=;
        b=5lsKgLsuYt89sUkh4navtKdOnEt+IFXgqV50aak7qlru0y4CW+sBtVGH1XZ0gxsEcl
         sxtAzqPlJixT3dL/EYHhWHugeEzr7lDVSs1chJcSYi3+wEIMuaIYCnrIR7bsxsezhadH
         k8mm5HDPu6B7rrB5M+GusidyWZT+7Qxot3rP+QZd+jROfXVtSAkzYRZjkFRtH+ntHdBI
         XN4XfVWtfLAY/VEEsGyjgdpzLRe9EZtvkJzpEYdMTDdBq8d9IttSlVRFBkOsfVBN1TIN
         /aumwUd1OF+hin+Q8aGv7gACja0EX4vgrscGvfIcBvWNkNIIuCyJfhugw4N6BDd989bt
         p6cg==
X-Gm-Message-State: AOAM5301GaSTqgwtoPHEgHQuMfvSJ5ph3XaoloyTOxlTyDsXjPZ1ezD4
        Y9AzFS8S/ERTzPWJGRu4EQ==
X-Google-Smtp-Source: ABdhPJw+tFR9vw806n3+CZYVqImyHzmW91QrWT8iYynrciq4HEd6xNf3xACCW870T49+LpN9xAOA4Q==
X-Received: by 2002:a05:6808:238e:b0:2ec:e0ee:abe4 with SMTP id bp14-20020a056808238e00b002ece0eeabe4mr5792022oib.187.1648844796079;
        Fri, 01 Apr 2022 13:26:36 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y3-20020a056870e50300b000d9be6436f1sm1415409oag.29.2022.04.01.13.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:26:34 -0700 (PDT)
Received: (nullmailer pid 3526180 invoked by uid 1000);
        Fri, 01 Apr 2022 20:26:33 -0000
Date:   Fri, 1 Apr 2022 15:26:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        festevam@gmail.com, francesco.dolcini@toradex.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v8 8/8] PCI: imx6: Add compliance tests mode support
Message-ID: <Ykdf+dQE10fkK3K6@robh.at.kernel.org>
References: <1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com>
 <1645760667-10510-9-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645760667-10510-9-git-send-email-hongxing.zhu@nxp.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Feb 25, 2022 at 11:44:27AM +0800, Richard Zhu wrote:
> Refer to the Chapter 3.2 System Board Signal Quality of PCI Express
> Architecture PHY Test Specification Revision 2.0.
> 
> Signal quality tests (for example: jitter, differential eye opening and
> so on) can be executed with devices in the polling.compliance state.
> 
> To let the device support polling.compliance state, the clocks and powers
> shouldn't be turned off when the probe of device driver fails.
> 
> Based on CLB (Compliance Load Board) Test Fixture and so on test
> equipments, the PHY link would be down during the compliance tests.
> Refer to this scenario, add the i.MX PCIe compliance tests mode enable
> support, and keep the clocks and powers on, and finish the driver probe
> without error return.

How is this specific to i.MX? If there's a need for compliance test 
mode, then shouldn't it be common? However, while your usecase is 
compliance testing, there doesn't seem to be any need for the kernel to 
know what the usecase is.

In the same series you've argued both ways. You need the driver to probe 
successfully with no link and you need it to shutdown on no link.

> 
> Use the "pci_imx6.compliance=1" in kernel command line to enable the
> compliance tests mode.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 47 ++++++++++++++++++---------
>  1 file changed, 31 insertions(+), 16 deletions(-)
