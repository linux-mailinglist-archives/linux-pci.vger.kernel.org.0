Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6FA53BC0F
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 18:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236722AbiFBQDc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Jun 2022 12:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiFBQDa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Jun 2022 12:03:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6225212CBE;
        Thu,  2 Jun 2022 09:03:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 618E3614BA;
        Thu,  2 Jun 2022 16:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C3BC385A5;
        Thu,  2 Jun 2022 16:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654185807;
        bh=Vc3eAUMjMU8tORu4+YbRV1KqF0w9KECltFREEa/MG7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=SOUJ9Sa4h8L9vwt8poGEI/YG0hUBQYbHQH2BFCt3a9mlgtpGlou3/7BPBbi09EDqT
         vIYjtoyqtH7ByGmYUCrMNvVooTmBpfHIM83teW0F91R8GDRf2CvJa89VO2WOPSSd+f
         bHsvEzkx1/v4Dlwbm+rSVHnE+FNZw8bnGE4lw8E5mY2p/Ep9d4nULcyLlP2JAVuvBi
         9u8gFJNfA2pToiDTkw4/Z/WMRTvkcgiarq5+k53xMnBj1s1WqUsoJAIQlfw8b/yD4E
         y2ASSS90imr5/ca0qsIq0nS5Rm8GZMojxvpj9o9SnSptqpfHyz+k/++HZryuEii+tL
         qr1PhPsy4tRPw==
Date:   Thu, 2 Jun 2022 11:03:25 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     Conor.Dooley@microchip.com, Greg KH <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>, mturquette@baylibre.com,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        linux-pci@vger.kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Daire.McNamara@microchip.com,
        Lewis.Hanly@microchip.com, Cyril.Jean@microchip.com
Subject: Re: [PATCH v4 1/1] MAINTAINERS: add polarfire rng, pci and clock
 drivers
Message-ID: <20220602160325.GA20054@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <mhng-5c57560e-a00b-4fd8-95ee-5e2fc0dcd34c@palmer-ri-x1c9>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 01, 2022 at 06:55:40PM -0700, Palmer Dabbelt wrote:
> On Mon, 23 May 2022 13:00:01 PDT (-0700), Conor.Dooley@microchip.com wrote:
> > On 23/05/2022 20:52, Palmer Dabbelt wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >> 
> >> On Mon, 23 May 2022 04:42:53 PDT (-0700), Conor.Dooley@microchip.com wrote:
> >>> On 05/05/2022 11:55, Conor Dooley wrote:
> >>>> Hardware random, PCI and clock drivers for the PolarFire SoC have been
> >>>> upstreamed but are not covered by the MAINTAINERS entry, so add them.
> >>>> Daire is the author of the clock & PCI drivers, so add him as a
> >>>> maintainer in place of Lewis.
> >>>>
> >>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >>>
> >>> Hey Palmer,
> >>> I know youre busy etc but just a reminder :)
> >> 
> >> Sorry, I didn't realize this was aimed at the RISC-V tree.  I'm fine
> >> taking it, but it seems like these should have gone in along with the
> >> drivers.
> > 
> > Yeah, sorry. In hindsight it should've but that ship has sailed. I sent
> > the rng bundled this way b/c I didn't want to end up a conflict.
> > Obv. there's not a rush so I can always split it back out if needs be.
> 
> I'm adding a bunch of subsystem maintainers just to check again.  I 
> don't have any problem with it, just not really a RISC-V thing and don't 
> wan to make a mess.  I've stashed it over at palmer/pcsoc-maintainers 
> for now.

Fine with me, if you want it:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> >> Arnd: maybe this is really an SOC tree sort of thing?  No big deal
> >> either way on my end, just let me know.
> >> 
> >>> Thanks,
> >>> Conor.
> >>>
> >>>> ---
> >>>>   MAINTAINERS | 5 ++++-
> >>>>   1 file changed, 4 insertions(+), 1 deletion(-)
> >>>>
> >>>> diff --git a/MAINTAINERS b/MAINTAINERS
> >>>> index fd768d43e048..d7602658b0a5 100644
> >>>> --- a/MAINTAINERS
> >>>> +++ b/MAINTAINERS
> >>>> @@ -16939,12 +16939,15 @@ N: riscv
> >>>>   K: riscv
> >>>>
> >>>>   RISC-V/MICROCHIP POLARFIRE SOC SUPPORT
> >>>> -M:  Lewis Hanly <lewis.hanly@microchip.com>
> >>>>   M: Conor Dooley <conor.dooley@microchip.com>
> >>>> +M:  Daire McNamara <daire.mcnamara@microchip.com>
> >>>>   L: linux-riscv@lists.infradead.org
> >>>>   S: Supported
> >>>>   F: arch/riscv/boot/dts/microchip/
> >>>> +F:  drivers/char/hw_random/mpfs-rng.c
> >>>> +F:  drivers/clk/microchip/clk-mpfs.c
> >>>>   F: drivers/mailbox/mailbox-mpfs.c
> >>>> +F:  drivers/pci/controller/pcie-microchip-host.c
> >>>>   F: drivers/soc/microchip/
> >>>>   F: include/soc/microchip/mpfs.h
> >>>>
> >>>
> > 
