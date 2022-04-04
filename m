Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D85B24F1768
	for <lists+linux-pci@lfdr.de>; Mon,  4 Apr 2022 16:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378016AbiDDOpo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Apr 2022 10:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379155AbiDDOoZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 Apr 2022 10:44:25 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620663FD81;
        Mon,  4 Apr 2022 07:39:35 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id k10so10326948oia.0;
        Mon, 04 Apr 2022 07:39:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=0vlRFIroYhAxAtt8b1uV208IEJmMxWXEuymzJQC0hzs=;
        b=vOvkCwwENwRzsAqMwcDLhswRPtOybFEb5TQnwVkNSz+XUfgbwIXvfBgkaOW1RHFy/Z
         SL7uXML9vqr+52iJEWsFH3IFexCQ/pfBAjMgPYSt/xxBOIO5YmQlHv8gblokzbkfnhFZ
         0NpT47hOPkIV6MventGN0YdY3V/uqd07Vu+76BqyzNPhsJjz4DBU7mBY7IADdo1ok2zS
         Q6r8NOQdUKWksQ+ZzEvrFg4vKAI8XETGztVjBSXqjUva6fBo9iOsDOQ0ejQnlVf/lBd/
         Vk82f/GAMfRpFLlhADz0YX5AXjpa5UdCrhfbc9OwQpsAMiY+WtQJvQiRHb/q6BcWfgLj
         n3AQ==
X-Gm-Message-State: AOAM531z5YZYxKRtrrJvUJfUaOfrdYHjLEZ4Uqgqj7/8r6NRw7TVGvzd
        Pdtkkwk8ZvMVh+baUYbghw==
X-Google-Smtp-Source: ABdhPJw3vbnKQcMaVYmulaeEK3Kx4XuELdAzMXUc+g7jTSfRuo70GHTY7tIsrfoDltxuhFYzholOKQ==
X-Received: by 2002:a05:6808:1a29:b0:2da:4dd3:a024 with SMTP id bk41-20020a0568081a2900b002da4dd3a024mr67329oib.35.1649083174445;
        Mon, 04 Apr 2022 07:39:34 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id m13-20020a056820050d00b003297b35bc63sm205368ooj.40.2022.04.04.07.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 07:39:33 -0700 (PDT)
Received: (nullmailer pid 1281753 invoked by uid 1000);
        Mon, 04 Apr 2022 14:39:33 -0000
Date:   Mon, 4 Apr 2022 09:39:33 -0500
From:   Rob Herring <robh@kernel.org>
To:     Hongxing Zhu <hongxing.zhu@nxp.com>
Cc:     "l.stach@pengutronix.de" <l.stach@pengutronix.de>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "broonie@kernel.org" <broonie@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "francesco.dolcini@toradex.com" <francesco.dolcini@toradex.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v8 6/8] PCI: dwc: Add dw_pcie_host_ops.host_exit()
 callback
Message-ID: <YksDJfterGl9uPjs@robh.at.kernel.org>
References: <1645760667-10510-1-git-send-email-hongxing.zhu@nxp.com>
 <1645760667-10510-7-git-send-email-hongxing.zhu@nxp.com>
 <Ykdj+oJ+0k8UZCwK@robh.at.kernel.org>
 <AS8PR04MB8676A8E85BBDA507481E12C78CE39@AS8PR04MB8676.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AS8PR04MB8676A8E85BBDA507481E12C78CE39@AS8PR04MB8676.eurprd04.prod.outlook.com>
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

On Sat, Apr 02, 2022 at 03:03:00AM +0000, Hongxing Zhu wrote:
> > -----Original Message-----
> > From: Rob Herring <robh@kernel.org>
> > Sent: 2022年4月2日 4:44
> > To: Hongxing Zhu <hongxing.zhu@nxp.com>
> > Cc: l.stach@pengutronix.de; bhelgaas@google.com; broonie@kernel.org;
> > lorenzo.pieralisi@arm.com; jingoohan1@gmail.com; festevam@gmail.com;
> > francesco.dolcini@toradex.com; linux-pci@vger.kernel.org;
> > linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org;
> > kernel@pengutronix.de; dl-linux-imx <linux-imx@nxp.com>
> > Subject: Re: [PATCH v8 6/8] PCI: dwc: Add dw_pcie_host_ops.host_exit()
> > callback
> > 
> > On Fri, Feb 25, 2022 at 11:44:25AM +0800, Richard Zhu wrote:
> > > When the link never comes up after ->host_init(), some drivers,
> > > especially those that don't support hotplug, want to turn off clocks
> > > and power supplies.
> > 
> > Isn't supporting hotplug or not a board level decision? And hotplug doesn't
> > have to mean physical plug/unplug. For example, you could have a soldered
> > down PCIe device which needs regulators, resets, clocks, etc.
> > for that device to be initialized before the link comes up. If that device is
> > handled by a module loaded some time later, then the link may be down when
> > you probe.
> > 
> > I think the way this all needs to work is with runtime PM. If that's all in place,
> > then either you shutdown clocks/power on timeout or via sysfs suspend. If
> > there's a child device, then that should prevent suspending.
> Hi Rob:
> Thanks a lot for your review comments.
> Understand what you mean.
> i.MX PCIe doesn't support hot-plug from chip design view.

The scenario I described is not hotplug.


> The ops.host_exit() callback is invoked only when the iMX PCIe driver hooked
>  callback ops->start_link return an error.
> For the platforms, that support the hot-plug feature, they can just return one
> zero from their own ops->start_link.

You cannot have a per board start_link().

> In the current situation, i.MX PCIe does just return one zero when probe failed.
> See the discussion and commit issued by Fabio below.
> https://patchwork.kernel.org/project/linux-pci/patch/1641368602-20401-6-git-send-email-hongxing.zhu@nxp.com/
> https://patchwork.ozlabs.org/project/linux-pci/patch/20220106103645.2790803-1-festevam@gmail.com/

That's a stable fix and different discussion.

> > > Add a new ->host_exit() callback in dw_pcie_host_ops so these drivers
> > > can clean up if ->host_init() fails.
> > 
> > I'm not really a fan of adding more ops nor the ops which aren't too specific
> > about what they do. 'init' and 'exit' can be anything. I'd rather see more
> > specific ops with the DWC core driver in charge of sequence of operations and
> > the state.
> Understand. 

You don't seem to...

> i.MX PCIe can't handle the error exit properly in this case by itself. So I
>  add one more ops.host_exit() in this series.
> 
> Best Regards
> Richard Zhu
> > 
> > Rob
