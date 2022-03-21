Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41674E2FFD
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 19:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352170AbiCUSam (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 14:30:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352165AbiCUSah (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 14:30:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B9E2B1A9;
        Mon, 21 Mar 2022 11:29:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0969B61507;
        Mon, 21 Mar 2022 18:29:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A83C340F3;
        Mon, 21 Mar 2022 18:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647887351;
        bh=EHIoXmYCuzDlVCK0jURCIo59lgDODdUVpaJaU5SSLpg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qeL4wsD1g++Dcko05MgG1VrqlOEY/wR4/46wp1OsXiJ04a/Nqn0yRIkr8QfmxOOw3
         0X/+BZjvQAhfw48Rqj4qi4etTu5qO4nhwHf+720KAC8veUmFgrM91J2t+1a64BZsQO
         QdTzEzsP6lp/UkKWvdMpAwyvluEkeiLg0bzjvUggNZ1qa6uQHcr1zGBkrwLtTvGzAS
         UOskj0J/graWCS9Q3E0mSCcPnIWt5/bhT/wqlIPgNoCpseMCrKoTsDIQzA9z1jyvlz
         94xoCBxXPZKCs00ill82TBAkNGZW1t/t7rWb6qWdtyfK2YvImCAY8CbqUvcS5p5ros
         zLe4oGstqSyiQ==
Received: by pali.im (Postfix)
        id 35DCAA5B; Mon, 21 Mar 2022 19:29:08 +0100 (CET)
Date:   Mon, 21 Mar 2022 19:29:08 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Marek =?utf-8?B?QmVow7pu?= <kabel@kernel.org>,
        Russell King <rmk+kernel@armlinux.org.uk>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/4] PCI: mvebu: Slot support
Message-ID: <20220321182908.3q4s2ramvhfdpgab@pali>
References: <20220302145733.12606-1-pali@kernel.org>
 <20220308113831.pmq4apsxjwzfbesk@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220308113831.pmq4apsxjwzfbesk@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PING?

On Tuesday 08 March 2022 12:38:31 Pali Rohár wrote:
> Hello Bjorn! Could you look if v2 changes are now fine?
> 
> On Wednesday 02 March 2022 15:57:29 Pali Rohár wrote:
> > This patch series add slot support to pci-mvebu.c driver.
> > 
> > It is based on branch pci/mvebu of git repository:
> > https://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/pci.git
> > 
> > Changes in v2:
> > * Dropped patch with PCI_EXP_SLTCAP_*_SHIFT macros as it is not needed anymore
> > * Dropped patch "ARM: dts: turris-omnia: Set PCIe slot-power-limit-milliwatt properties" which was applied
> > * Added support for PCIe 6.0 slot power limit encodings
> > * Round down slot power limit value
> > * Fix handling of slot power limit with scale x1.0 (0x00 value)
> > * Use FIELD_PREP instead of _SHIFT macros
> > * Changed commit message to Bjorn's suggestion
> > * Changed comments in the code to match PCIe spec
> > * Preserve user settings of PCI_EXP_SLTCTL_ASPL_DISABLE bit
> > 
> > Pali Rohár (4):
> >   PCI: Add PCI_EXP_SLTCTL_ASPL_DISABLE macro
> >   dt-bindings: Add 'slot-power-limit-milliwatt' PCIe port property
> >   PCI: Add function for parsing 'slot-power-limit-milliwatt' DT property
> >   PCI: mvebu: Add support for sending Set_Slot_Power_Limit message
> > 
> >  Documentation/devicetree/bindings/pci/pci.txt |  6 ++
> >  drivers/pci/controller/pci-mvebu.c            | 96 ++++++++++++++++++-
> >  drivers/pci/of.c                              | 64 +++++++++++++
> >  drivers/pci/pci.h                             | 15 +++
> >  include/uapi/linux/pci_regs.h                 |  1 +
> >  5 files changed, 177 insertions(+), 5 deletions(-)
> > 
> > -- 
> > 2.20.1
> > 
