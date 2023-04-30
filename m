Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 042AB6F2B65
	for <lists+linux-pci@lfdr.de>; Mon,  1 May 2023 00:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229663AbjD3Wiy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 30 Apr 2023 18:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjD3Wix (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 30 Apr 2023 18:38:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667A61AB;
        Sun, 30 Apr 2023 15:38:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 017C760F80;
        Sun, 30 Apr 2023 22:38:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10201C433D2;
        Sun, 30 Apr 2023 22:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682894331;
        bh=EQ09llp2SHctNPCqeExFa+2KP7sZE7fwfCOS3LtZp44=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=WGRoSKYsiJaCJUR6IRoOXRKraFROluOZz0atONXONdDS/ziS+Fd96tb+Vl8eXqGV8
         /pjaY+mpQUv30Hz58l6epXHVYiup34Xy2rJKUnDuVLN5vViMF9PAMGCgCrkI3W6Mgz
         hLR4RFOHJTHGLuG4ybLspKSNxAOkDpwZJ8qcq5FuDQ4ztACjQQBdAlPqDDE6C3r2vW
         BcGPHsN6Kc6MqtqfuxfEPKWT5tK2XU1ZKqvPHKyLEarIxDtstRcZ1gStxXXkBNtj7v
         GDL/Jz3nRutLx0EqFCS8+6kKpiXLDxsFKE4uiZIf2Jpco2XNQq5UHN/Ryhjg1qxtFx
         w1/MxGpfyHKIA==
Date:   Sun, 30 Apr 2023 17:38:49 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jim Quinlan <james.quinlan@broadcom.com>
Cc:     Jim Quinlan <jim2101024@gmail.com>, linux-pci@vger.kernel.org,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cyril Brulebois <kibi@debian.org>,
        Phil Elwell <phil@raspberrypi.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <f.fainelli@gmail.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        "moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] PCI: brcmstb: Set PCIe transaction completion
 timeout
Message-ID: <20230430223849.GA528725@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+-6iNwb6Cn-78BJ5URhwvDuYHg5b4X5h+WdMw-CB3nRs=pSYw@mail.gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Apr 30, 2023 at 05:24:26PM -0400, Jim Quinlan wrote:
> On Sun, Apr 30, 2023 at 3:13 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > On Fri, Apr 28, 2023 at 06:34:57PM -0400, Jim Quinlan wrote:
> > > Since the STB PCIe HW will cause a CPU abort on a PCIe transaction
> > > completion timeout abort, we might as well extend the default timeout
> > > limit.  Further, different devices and systems may requires a larger or
> > > smaller amount commensurate with their L1SS exit time, so the property
> > > "brcm,completion-timeout-us" may be used to set a custom timeout value.
> >
> > s/requires/require/
> >
> > AFAIK, other platforms do not tweak Configuration Timeout values based
> > on L1SS exit time.  Why is brcm different?
> 
> Keep in mind that our Brcm PCIe HW signals a CPU abort on a PCIe
> completion timeout.  Other PCIe HW just returns 0xffffffff.

Most does, but I'm pretty sure there are other controllers used on
arm64 that signal CPU aborts, e.g., imx6q_pcie_abort_handler() seems
similar.

> I've been maintaining this driver for over eight years or so and we've
> done fine with the HW default completion timeout value.
> Only recently has a major customer requested that this timeout value
> be changed, and their reason was so they could
> avoid a CPU abort when using L1SS.
> 
> Now we could set this value to a big number for all cases and not
> require "brcm,completion-timeout-us".  I cannot see any
> downsides, other than another customer coming along asking us to
> double the default or lessen it.
> 
> But I'm certainly willing to do that -- would that  be acceptable?

That would be fine with me.

Bjorn
