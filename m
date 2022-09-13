Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C348D5B7CAF
	for <lists+linux-pci@lfdr.de>; Tue, 13 Sep 2022 23:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiIMVY2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Sep 2022 17:24:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiIMVY0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Sep 2022 17:24:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879A36B169;
        Tue, 13 Sep 2022 14:24:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E070615C6;
        Tue, 13 Sep 2022 21:24:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A3D5C433D6;
        Tue, 13 Sep 2022 21:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663104264;
        bh=YmC8EMwSctk7x2dKGjz75evV77+1YkS7yGjJnCMZl9I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fod98ampF4E963Ap0LjtJx0J69/n70HdCGZSFWcXEToV2EMIKX7NkB2ncf74wMUks
         xa+IitXRJSKucqqrS11QwE5S/X0a6I6moIsuNnWQD3m6kMlBqkDuY8Pz2C6L7IncsZ
         PfgKvZe7OgX5ZS6Kt7U1DcXUdwkJsnbOOmBXg9kBxV1R21ey0ysxSq441tGwsimfo0
         vAQKNrT7VKTu3tksYDfmT1DiZ4/vHKA2dsqSBXbqXwNfjQ/AvqEn1NPxCYFSvx/BHF
         VY/tiVDIsQ69af3m5eHEbhfjToCFr0se4Bwa0yL0llQF42E5eQ9DApLzNfB/OojHzK
         S2iZ62WdGSO6A==
Received: by pali.im (Postfix)
        id 64BD5BE3; Tue, 13 Sep 2022 23:24:21 +0200 (CEST)
Date:   Tue, 13 Sep 2022 23:24:21 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Sergio Paracuellos <sergio.paracuellos@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 1/3] PCI: Add standard PCI Config Address macros
Message-ID: <20220913212421.yblwhgbd7zpdg5eo@pali>
References: <20220911112024.14304-2-pali@kernel.org>
 <20220913211143.GA624473@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220913211143.GA624473@bhelgaas>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 13 September 2022 16:11:43 Bjorn Helgaas wrote:
> On Sun, Sep 11, 2022 at 01:20:22PM +0200, Pali Rohár wrote:
> > Lot of PCI and PCIe controllers are using standard Config Address for PCI
> > Configuration Mechanism #1 (as defined inPCI Local Bus Specification) or
> > its extended version.
> > 
> > So introduce new macros PCI_CONF1_ADDRESS() and PCI_CONF1_EXT_ADDRESS() in
> > new include file linux/pci-conf1.h which can be suitable for PCI and PCIe
> > controllers which uses this type of access to PCI config space.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  include/linux/pci-conf1.h | 51 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >  create mode 100644 include/linux/pci-conf1.h
> 
> This seems like a nice addition, but it would be nice if we could
> encapsulate it in drivers/pci.
> 
> I know it's parallel to the existing include/linux/pci-ecam.h.  I wish
> we could encapsulate *that* in drivers/pci, too.  For pci-ecam.h, I
> think the only things that prevent that are drivers/acpi/pci_mcfg.c,
> loongarch, and a few arm64 things.

As these macros describe original Intel x86 API, it can be used also in
arch/x86 PCI code.

> pci_mcfg.c arguably would make more sense in drivers/pci; it uses
> acpi_table_parse(), but no other ACPI services.
> 
> The arm64 code that uses pci-ecam.h is really generic code that would
> not be in arch/arm64 except for the fact that x86 has really ugly
> legacy x86-specific mmconfig code.

IIRC that legacy x86-specific code is used also on modern AMD processors
which have broken ECAM. AMD supports that extended version of CF8/CFC
with access to PCIe extended config space registers.

> I guess that's a long-winded way of saying that I think maybe we could
> put this in drivers/pci/pci.h even though the parallel ECAM stuff is
> in include/linux/pci-ecam.h.
> 
> Bjorn

Well, if you like this change, let me know where to put those new
macros, into which file and in which subdirectory, and I can prepare a
new patch version.

But doing all those arm64, x86, ACPI cleanup is a huge cross-tree work
which I'm really not going to do...
