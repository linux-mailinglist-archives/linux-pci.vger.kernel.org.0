Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0868F5BF36D
	for <lists+linux-pci@lfdr.de>; Wed, 21 Sep 2022 04:22:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbiIUCWJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Sep 2022 22:22:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIUCWH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Sep 2022 22:22:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B30F61D7D;
        Tue, 20 Sep 2022 19:22:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C9FB61223;
        Wed, 21 Sep 2022 02:22:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64F4C433D6;
        Wed, 21 Sep 2022 02:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663726926;
        bh=Nbnnvo9kvKva9lxHPmP+cCH4H3hG1lmax1LODPQ/hSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ryvK1SrKa5Bc2XfeKZvibPeVVSJrDJDJosH42xpMgsejNKdgvne2+x2yhNGuVl/b6
         YwtThcKND48TCgyf7xsS0N0BEeJby/ZwZqzKaQUGLpzEQCFii5XTCBsd/gldVCjZoq
         i2DUiVOMvaqDrfcUPI36b1CfbiTcmMwhU1sbX+0hAEFhJBXWAWDI0R6VXkZFKtafKb
         pPhonDtwNbxNHFB0W3O/1mkXUAGB375EQ9DDmof2+/amk7l0am4OdVj3D9QxngqEmB
         96JkUeJLrXadaAbMyZuwhyUZDz0Plg8WSY1cPGRIuntkqfHGvKhcBgOxja9X2UwjYn
         8oN7NnxHr9A/w==
Date:   Tue, 20 Sep 2022 21:22:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "geert+renesas@glider.be" <geert+renesas@glider.be>,
        "magnus.damm@gmail.com" <magnus.damm@gmail.com>,
        "marek.vasut+renesas@gmail.com" <marek.vasut+renesas@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>
Subject: Re: [PATCH v5 03/12] PCI: Add PCI_EXP_LNKCAP_MLW macros
Message-ID: <20220921022204.GA1154967@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYBPR01MB5341A75BFA6AFFCF59FA4502D84F9@TYBPR01MB5341.jpnprd01.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 21, 2022 at 12:05:26AM +0000, Yoshihiro Shimoda wrote:
> Hi Bjorn,
> 
> Thank you for your review!
> 
> > From: Bjorn Helgaas, Sent: Wednesday, September 21, 2022 5:08 AM
> > 
> > On Mon, Sep 05, 2022 at 04:12:48PM +0900, Yoshihiro Shimoda wrote:
> > > Add macros defining Maximum Link Width bits in Link Capabilities
> > > Register.
> > >
> > > Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
> > > ---
> > >  include/uapi/linux/pci_regs.h | 7 +++++++
> > >  1 file changed, 7 insertions(+)
> > >
> > > diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
> > > index 57b8e2ffb1dd..c9f4c452e210 100644
> > > --- a/include/uapi/linux/pci_regs.h
> > > +++ b/include/uapi/linux/pci_regs.h
> > > @@ -538,6 +538,13 @@
> > >  #define  PCI_EXP_LNKCAP_SLS_16_0GB 0x00000004 /* LNKCAP2 SLS Vector bit 3 */
> > >  #define  PCI_EXP_LNKCAP_SLS_32_0GB 0x00000005 /* LNKCAP2 SLS Vector bit 4 */
> > >  #define  PCI_EXP_LNKCAP_SLS_64_0GB 0x00000006 /* LNKCAP2 SLS Vector bit 5 */
> > > +#define  PCI_EXP_LNKCAP_MLW_X1	0x00000010 /* Maximum Link Width x1 */
> > > +#define  PCI_EXP_LNKCAP_MLW_X2	0x00000020 /* Maximum Link Width x2 */
> > > +#define  PCI_EXP_LNKCAP_MLW_X4	0x00000040 /* Maximum Link Width x4 */
> > > +#define  PCI_EXP_LNKCAP_MLW_X8	0x00000080 /* Maximum Link Width x8 */
> > > +#define  PCI_EXP_LNKCAP_MLW_X12	0x000000c0 /* Maximum Link Width x12 */
> > > +#define  PCI_EXP_LNKCAP_MLW_X16	0x00000100 /* Maximum Link Width x16 */
> > > +#define  PCI_EXP_LNKCAP_MLW_X32	0x00000200 /* Maximum Link Width x32 */
> > 
> > In PCIe r6.0, x32 is mentioned a few times, but not actually defined
> > for Link Capabilities.  Has it been defined in an ECN or something?
> 
> I should have looked PCIe r6.0, but I looked PCIe r4.0 v1.0 and it mentioned x32.
> So, I wrote the x32 macro.

Sure enough.  It's there in r4.0 and r5.0, but dropped from r6.0.
Wish there were a git tree where we could see whether this was a
mistake or there was some reason for it.  Maybe nobody had actually
built x32 hardware and they wanted to reserve the flexibility for
something else.

> I'll drop PCI_EXP_LNKCAP_MLW_X32 on v6 patch.

When you do, add my:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

