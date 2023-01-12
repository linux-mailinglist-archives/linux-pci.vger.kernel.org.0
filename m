Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 424B0667A21
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jan 2023 16:59:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbjALP7k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Jan 2023 10:59:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjALP7L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Jan 2023 10:59:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB6DFE70;
        Thu, 12 Jan 2023 07:50:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68593B81EB8;
        Thu, 12 Jan 2023 15:50:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10935C433EF;
        Thu, 12 Jan 2023 15:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673538644;
        bh=56hHJDsmg+aMaj3QZPHGVjwdZvjGg+53Y+wWNaKhYAw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d4giMpFzAv8KQ4w0ui8ugaeRwaolxyDPbRIHurora702Io29haIJ9ZySWNUBH5ltK
         wxEHrB2x1YUZQtlOvLNeL5K7BDpDPjIXMMRMMtTHxKcD14FXROAOCUNx0LjlJhU9gC
         jAazybdLcqwV9L4LoNlPNCRhdXWOqO5YKtFGrRTkk/qrVfj2FXgr3CGRZ2bqQJ2pO8
         bfxRQL0vi14RmaBNmI06t6Ptrsc9gKadgFQwC3GUlotBaRvITT8+69xaBM6s+P64fO
         LMX6cKvlI3TvuMG+V8yDR/lceuhTXYxQqVEIhxo6Ixowmb9/99dAZDbbcDhnW91Y/s
         99IUpoA/3O8rg==
Date:   Thu, 12 Jan 2023 16:50:37 +0100
From:   Lorenzo Pieralisi <lpieralisi@kernel.org>
To:     Frank Li <frank.li@nxp.com>
Cc:     "M.H. Lian" <minghuan.lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linuxppc-dev@lists.ozlabs.org>,
        "open list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-pci@vger.kernel.org>,
        "moderated list:PCI DRIVER FOR FREESCALE LAYERSCAPE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [PATCH 1/1] PCI: layerscape: Add EP mode support for ls1028a
Message-ID: <Y8AsTaMwC/L/M+ve@lpieralisi>
References: <20221216161537.1003595-1-Frank.Li@nxp.com>
 <HE1PR0401MB2331BA1F1CDF8F8B8A4D26E488FE9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HE1PR0401MB2331BA1F1CDF8F8B8A4D26E488FE9@HE1PR0401MB2331.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 09, 2023 at 03:41:31PM +0000, Frank Li wrote:
> > 
> > From: Xiaowei Bao <xiaowei.bao@nxp.com>
> > 
> > Add PCIe EP mode support for ls1028a.
> > 
> > Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
> > Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
> > ---
> > 
> > All other patches were already accepte by maintainer in
> > https://lore.kernel.org/lkml/20211112223457.10599-1-leoyang.li@nxp.com/
> > 
> > But missed this one.
> > 
> > Re-post.
> > 
> 
> Ping.

You must sign it off since you obviously are in the patch delivery chain:

https://docs.kernel.org/process/submitting-patches.html

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
