Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3554EFBC1
	for <lists+linux-pci@lfdr.de>; Fri,  1 Apr 2022 22:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352489AbiDAUpd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 Apr 2022 16:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242759AbiDAUpb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 Apr 2022 16:45:31 -0400
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E972F4B432;
        Fri,  1 Apr 2022 13:43:40 -0700 (PDT)
Received: by mail-ot1-f53.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso2958174otj.0;
        Fri, 01 Apr 2022 13:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IXypJrR2NUuIxo4W8oiGCQjr/KdHyxNFHpZwbM7jZXk=;
        b=Zjo8gUZc0IAU5mSc75vFRDbJeQYPvKchLBBP+zY1hed2sm8WREnP4AoFuXRdlQ/Usb
         ZZSSpl2Nc7PTzFINtaj9TurHVWs9KpewaoBKi7eHnHNKBWHqsgtGTlfYI/WTAR19DTwl
         50aoZagtF4tAftwdZsyHO7LwOLjtGSeEd4EVE6yZfmBvYRF9lMvylclsZ0NOMQZsogaS
         F865bYcguls5ZZ/FwuXwrYDmIAqcFbdJFgXZDgqXAFJiE5Q/FvU1mfyDUvgijTnR6iAi
         V1awpGYfUQ3vgqLCM9MpnoCCrjb6qehYU25aLehnxt75a0dAtLnOrkkzL5IRE59UkBTy
         VnXg==
X-Gm-Message-State: AOAM530v0JR4g5TbuJZwGefzZErpckRNTeICmAXkmHSyhPVc30DcI27D
        d6GRxfWrGMjqHxu0iyIAcg==
X-Google-Smtp-Source: ABdhPJycKUVcZj1wJNSIsYLAeYaiinytlsTT2U4l9QHuGn5CjYdV7zq45O31BCuiAdn+VyhWUWagKA==
X-Received: by 2002:a05:6830:821:b0:5b2:352a:3ea4 with SMTP id t1-20020a056830082100b005b2352a3ea4mr8070783ots.36.1648845820198;
        Fri, 01 Apr 2022 13:43:40 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id y3-20020a056870e50300b000d9be6436f1sm1433965oag.29.2022.04.01.13.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 13:43:39 -0700 (PDT)
Received: (nullmailer pid 3550236 invoked by uid 1000);
        Fri, 01 Apr 2022 20:43:38 -0000
Date:   Fri, 1 Apr 2022 15:43:38 -0500
From:   Rob Herring <robh@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>
Cc:     l.stach@pengutronix.de, bhelgaas@google.com, broonie@kernel.org,
        lorenzo.pieralisi@arm.com, jingoohan1@gmail.com,
        festevam@gmail.com, francesco.dolcini@toradex.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: Re: [PATCH v8 6/8] PCI: dwc: Add dw_pcie_host_ops.host_exit()
 callback
Message-ID: <Ykdj+oJ+0k8UZCwK@robh.at.kernel.org>
References: <1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com>
 <1645760667-10510-7-git-send-email-hongxing.zhu@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1645760667-10510-7-git-send-email-hongxing.zhu@nxp.com>
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

On Fri, Feb 25, 2022 at 11:44:25AM +0800, Richard Zhu wrote:
> When the link never comes up after ->host_init(), some drivers,
> especially those that don't support hotplug, want to turn off clocks
> and power supplies.

Isn't supporting hotplug or not a board level decision? And hotplug 
doesn't have to mean physical plug/unplug. For example, you could have a 
soldered down PCIe device which needs regulators, resets, clocks, etc. 
for that device to be initialized before the link comes up. If that 
device is handled by a module loaded some time later, then the link may 
be down when you probe.

I think the way this all needs to work is with runtime PM. If that's all 
in place, then either you shutdown clocks/power on timeout or via sysfs 
suspend. If there's a child device, then that should prevent suspending.

> Add a new ->host_exit() callback in dw_pcie_host_ops so these
> drivers can clean up if ->host_init() fails.

I'm not really a fan of adding more ops nor the ops which aren't too 
specific about what they do. 'init' and 'exit' can be anything. I'd 
rather see more specific ops with the DWC core driver in charge of 
sequence of operations and the state. 

Rob
