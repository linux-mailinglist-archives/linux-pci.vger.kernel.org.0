Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B07A252C45E
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 22:33:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242612AbiERU1h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 16:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242614AbiERU1f (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 16:27:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11422131F2C
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 13:27:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 697B2619DA
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 20:27:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D8CC385A9;
        Wed, 18 May 2022 20:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652905651;
        bh=/lAaSrQLepD71mhjbFwFsLTT2sap9WMVoGPLCN9zYms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qdNV/vKK5xJ5i5iKaUWWVE6rqMxBD46F7zk3cJ1n+Wm45LdGa+42qg7Pv6FoM43yB
         m4qCoI3x+yIEu7PhSWhXr4fdT/bx1SpQI3QJtSBrlQW2y77iSiFWfJw+eTElMB69mt
         Rt2AlrxLOp6yMBhmSmGeFr1AXpcJdL9dUtuj3MRbsRiP3W3Q42EGgpm6AwfaOcQG1z
         leKQRUSdQibPtDZfPdvBgV+4pquEmTQMZ0PzH+02vv1nr26BAzK+xaMEv/HvtKW386
         4tOmjW4zMQw0F2y4OByBHl4/883xSqecvWJ20vZU1MmpxzLLbUlSydughJV5YOgpur
         MpoyDZbBJKPEw==
Date:   Wed, 18 May 2022 15:27:29 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 04/18] PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
Message-ID: <20220518202729.GA4606@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220518220556.753c0367@thinkpad>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 18, 2022 at 10:05:56PM +0200, Marek Behún wrote:
> On Wed, 18 May 2022 21:26:00 +0200
> Pali Rohár <pali@kernel.org> wrote:
> 
> > On Wednesday 18 May 2022 14:23:22 Bjorn Helgaas wrote:
> > > On Sun, Feb 20, 2022 at 08:33:32PM +0100, Marek Behún wrote:  
> > > > From: Pali Rohár <pali@kernel.org>
> > > > 
> > > > These macros allows to easily compose and extract Slot Power Limit and
> > > > Physical Slot Number values from Slot Capability Register.
> > > > 
> > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > > Signed-off-by: Marek Behún <kabel@kernel.org>  
> > > 
> > > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > > 
> > > We talked about using FIELD_PREP() / FIELD_GET(), which I think would
> > > remove the need for the *_SHIFT macros.  But we can always do that
> > > later.  
> > 
> > I have already done this for pci-mvebu.c driver and patch was merged:
> > https://lore.kernel.org/linux-pci/20220412094946.27069-5-pali@kernel.org/
> > 
> > IIRC we have decided to not use those *_SHIFT macros as it would flood
> > public uapi file and from this file we cannot remove macros due to
> > userspace backward compatibility.
> 
> So should I change patch 5 of the aardvark batch 5 to also use
> FIELD_GET(), so that this patch is not needed?

That would be awesome if you could.  I forgot about the backward
compatibility issue with include/uapi/linux/pci_regs.h

Bjorn
