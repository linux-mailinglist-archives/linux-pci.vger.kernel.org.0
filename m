Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8519B78EF12
	for <lists+linux-pci@lfdr.de>; Thu, 31 Aug 2023 15:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbjHaN56 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Aug 2023 09:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240727AbjHaN55 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Aug 2023 09:57:57 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE1FB8;
        Thu, 31 Aug 2023 06:57:54 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-34c5fec2a95so2903155ab.3;
        Thu, 31 Aug 2023 06:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693490274; x=1694095074; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OrjBYAvFpUX6DSC/lthNg14YPHSorb1JxUZYg6+nTYE=;
        b=FKruF52x2Z1NFX1zak2uu09siv+0P+EdV3EKFiRjlg2WV61ad+YtAJtkORDmXNeQXF
         ISzI9IBu4P2ZWN8C+4A6ZIBEK3MV4Uvgn+roLAVNFy0OfKOPPFRscsXeMveQfuPI5xZW
         LGmaVCNuBQf6+zZNfh/y9v9pGKWLbonqSnh+CC/koLRVXjjJcjHKWUKXYGbydkH/ENmh
         QKFP7qaRycIMmEL7sWureEaVQtOqwybkY2ltT5wsjiyLL/fhJdmBpo/opBbYiAUR9Fzk
         RnXR5q9wo3EZLlqntMUVjm069cuSUzSve3cKIiW+iapqpzRilO0GZngfl9cZzWaw/5R5
         adVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693490274; x=1694095074;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrjBYAvFpUX6DSC/lthNg14YPHSorb1JxUZYg6+nTYE=;
        b=A96ku+z9nWW01zq7qkI2+0R7DWH+lzHzNQxpFqhOy0s3fARi2CVxf3vJb5R8CfoeeY
         6RIytmzxEvDqqOShh9KJgb3Qepvayws1raKFKF0IJ4adj8iuUyQU6Lnw6DRd9Ix/zND5
         ubTJYiNCtxYzM0NbNXm8ZOSRLzTc8v84hTxeyzzLU5ZbJtQIcT2N5wAZUz1eBmwMBjfo
         ecKdz2EzQVWItrbXCa6qEpzvcgJQ98NhiDPrMbFunZxU1iLJPFE6RyUGzX/B1HUIX/eM
         Lm5H7a5ZgxEcyP/PzRt1VdlUEtJ0TIipuuD67gm+35O1Pr2Aqodi4WntcWPDC6UEzQqP
         ZIHw==
X-Gm-Message-State: AOJu0Yy8pGCxRNObZcMWRgOdjFKAkl4l2tldmz8nn59AnOfGqWYYHvv8
        zQ0iBUS4u0zcurMfunOCV9c=
X-Google-Smtp-Source: AGHT+IGhSlJOTL5cRDk0waAv2iu6tqSMoCmyYgC44RNtmj6R5QN6Ym/33i4lmR2EUwyCq1pOg302Hw==
X-Received: by 2002:a92:c809:0:b0:345:fae5:666c with SMTP id v9-20020a92c809000000b00345fae5666cmr5462094iln.4.1693490274196;
        Thu, 31 Aug 2023 06:57:54 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id o20-20020a056638125400b0042b91ec7e31sm412353jas.3.2023.08.31.06.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 06:57:52 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Thu, 31 Aug 2023 06:57:50 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Lizhi Hou <lizhi.hou@amd.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh@kernel.org, max.zhen@amd.com,
        sonal.santan@amd.com, stefano.stabellini@xilinx.com
Subject: Re: [PATCH V13 2/5] PCI: Create device tree node for bridge
Message-ID: <2187619d-55bc-41bb-bbb4-6059399db997@roeck-us.net>
References: <1692120000-46900-1-git-send-email-lizhi.hou@amd.com>
 <1692120000-46900-3-git-send-email-lizhi.hou@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1692120000-46900-3-git-send-email-lizhi.hou@amd.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 15, 2023 at 10:19:57AM -0700, Lizhi Hou wrote:
> The PCI endpoint device such as Xilinx Alveo PCI card maps the register
> spaces from multiple hardware peripherals to its PCI BAR. Normally,
> the PCI core discovers devices and BARs using the PCI enumeration process.
> There is no infrastructure to discover the hardware peripherals that are
> present in a PCI device, and which can be accessed through the PCI BARs.
> 
> Apparently, the device tree framework requires a device tree node for the
> PCI device. Thus, it can generate the device tree nodes for hardware
> peripherals underneath. Because PCI is self discoverable bus, there might
> not be a device tree node created for PCI devices. Furthermore, if the PCI
> device is hot pluggable, when it is plugged in, the device tree nodes for
> its parent bridges are required. Add support to generate device tree node
> for PCI bridges.
> 
> Add an of_pci_make_dev_node() interface that can be used to create device
> tree node for PCI devices.
> 
> Add a PCI_DYNAMIC_OF_NODES config option. When the option is turned on,
> the kernel will generate device tree nodes for PCI bridges unconditionally.
> 
> Initially, add the basic properties for the dynamically generated device
> tree nodes which include #address-cells, #size-cells, device_type,
> compatible, ranges, reg.
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>

This patch results in the following build error.

Building sparc64:allmodconfig ... failed
--------------
Error log:
<stdin>:1519:2: warning: #warning syscall clone3 not implemented [-Wcpp]
sparc64-linux-ld: drivers/pci/of_property.o: in function `of_pci_prop_intr_map':
of_property.c:(.text+0xc4): undefined reference to `of_irq_parse_raw'

Guenter
