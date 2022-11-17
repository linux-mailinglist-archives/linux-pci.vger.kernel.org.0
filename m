Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75ABF62E558
	for <lists+linux-pci@lfdr.de>; Thu, 17 Nov 2022 20:38:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234418AbiKQTiI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Nov 2022 14:38:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233225AbiKQTiF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Nov 2022 14:38:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E062E88F98;
        Thu, 17 Nov 2022 11:38:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 122B562232;
        Thu, 17 Nov 2022 19:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37811C433D6;
        Thu, 17 Nov 2022 19:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668713883;
        bh=KPMa5USpM4BwKCaoPZCynZJmzGkezREaUXU/RoRTwxo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vJ5LrcBtZeiTi5t36dDlv1vOJQlF4ER4uy0QzQZs5u2f9Jn9AB6mkzfmDx8DeUaUX
         NKPcLLJA3w2vcEtTUHodc8IOVBWUESOWttPvhxSWccDcPVRfJtQwT63fx3myKDgMDf
         DTxRD9VV4MFXEovj2mzQOCsGl6KfSs+qh8eMeZLCYQ/mS2A7v6ZmdmgMfDuAxc0prW
         emTPaX2r8yieMDdgMicEnQTF2UJRijh97mdU1SUa2Z/02Ofafnw9467vmWP2gzquxq
         OOBfgdPvvlrlhBRZrdf4h2CX/63w7GisK2vNx58BzNHTtz9VdR4Cf9ouqL01Wt8GS9
         sZclFUqDL0iIg==
Date:   Thu, 17 Nov 2022 13:38:01 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-pci@vger.kernel.org,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v2 2/2] PCI: Allow building CONFIG_OF drivers with
 COMPILE_TEST
Message-ID: <20221117193801.GA1204302@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVtSHdFhd-V=7EzSZz6K7+fW9rLxUCN_=yZTGfKoAhS6A@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 17, 2022 at 09:55:08AM +0100, Geert Uytterhoeven wrote:
> On Wed, Nov 16, 2022 at 9:51 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>

> >  config PCI_HISI
> > -       depends on OF && (ARM64 || COMPILE_TEST)
> >         bool "HiSilicon Hip05 and Hip06 SoCs PCIe controllers"
> > +       depends on ARM64 || COMPILE_TEST
> > +       depends on OF || COMPILE_TEST
> 
> Note that ARM64 selects OF, so this (and a few others) could be
> simplified by dropping the "depends on OF || COMPILE_TEST".
> But that might be the scope of a different patch?

Hmm, yes.  I don't really know what to do here, so I left it for now.
ARM64 does indeed select OF, but I'm not sure whether that's an actual
arch dependency or just a convenience because most ARM64 platforms
rely on it.  I know there are some that use ACPI, and I don't know
whether they *also* need OF.

Bjorn
