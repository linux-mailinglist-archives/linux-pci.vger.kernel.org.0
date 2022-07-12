Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E652572644
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jul 2022 21:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235209AbiGLTqe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jul 2022 15:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiGLTqI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2022 15:46:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69036B5D28;
        Tue, 12 Jul 2022 12:36:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F020561986;
        Tue, 12 Jul 2022 19:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23766C3411C;
        Tue, 12 Jul 2022 19:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657654570;
        bh=wN/LWHBi+cVNlWfntej/+mBGt2AqOQhceyycixiKPVg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=m3NIv7flPd/wQsyuEJHQx/hOQhcX6DjQvI+qaV31j6ZMw1Rg1hq6xYOgvb42dbhMs
         APTyYetDI6XegSyOqOqqcmnDy5qRvmJ+s/4w66FmhS9kyXf3fT1q7XJ8flDjnZAgLK
         lc8cYj7ui3/ULo4UzAacj+oQnfNwrcDIECw3PRr6obOizCzEVRnB4X5Wv0ggzeMlx/
         T/+rajhlGHTQYJotCWjNaC00utb6xTYuvKqNrYbJb631YxrElMtp4V0JNez8LBFkNy
         TiCeFPZ5A0yLugPrJ0W/wevLE6GeegXz314O1t+iEbD81t/dGiaOtH70KxcoxcSD4u
         VoUbqx+AL3k4w==
Date:   Tue, 12 Jul 2022 14:36:08 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ASPM: Unexport pcie_aspm_support_enabled()
Message-ID: <20220712193608.GA788935@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gYhSkFWF49+orQsiqO0Kbmc_A+1L+QiZWcO6Q8sGWFKQ@mail.gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 12, 2022 at 08:10:03PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 12, 2022 at 1:14 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > pcie_aspm_support_enabled() is used only by the acpi/pci_root.c driver,
> > which cannot be built as a module, so it does not need to be exported.
> > Unexport it.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Thanks, applied with your Reviewed-by to pci/aspm for v5.20.

> > ---
> >  drivers/pci/pcie/aspm.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> > index 7f76a5875feb..a8aec190986c 100644
> > --- a/drivers/pci/pcie/aspm.c
> > +++ b/drivers/pci/pcie/aspm.c
> > @@ -1347,4 +1347,3 @@ bool pcie_aspm_support_enabled(void)
> >  {
> >         return aspm_support_enabled;
> >  }
> > -EXPORT_SYMBOL(pcie_aspm_support_enabled);
> > --
> > 2.25.1
> >
