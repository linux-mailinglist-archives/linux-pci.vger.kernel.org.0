Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31026545797
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 00:43:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345056AbiFIWnu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jun 2022 18:43:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242329AbiFIWnt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jun 2022 18:43:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E9C1742A5;
        Thu,  9 Jun 2022 15:43:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3B2561F97;
        Thu,  9 Jun 2022 22:43:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1212EC34115;
        Thu,  9 Jun 2022 22:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654814627;
        bh=B2cPDRdznb5RUKWTOcdRF0MpJnZCQPuRS1yF4z2JHhg=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=df7uVm3wzmTDWNU00ljP0U1SLXpkda1igGQVXkjGR/VUxXtke5gaucVSJxjY+w9/Z
         s+5WJrZ81Ftn0oQ2/E0TKNPs0kYjF4MoWjbxU2QTtNszgh/Ing/I3FjX1TXE9ERT2T
         MEciaw/Jyvsf/qbDUbijTyNIrAbaOHocMrNRnv4EbJkYaoHgpsCu39cDEtg/MsGtvx
         Q0rnxrztptTjIu0q+ihh7qgcqB7T5YGwqDd1MU9tq3829+MbSX0pMcMEO0JpYB+6s7
         j4KLVFQ3ERUALPSWj0Uy+AL9FF35hUAeJe9ZMyizR9AX7j4cmQnAC2vn9Yi+AVErMl
         eJbG6LZafv3CA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <mhng-5c57560e-a00b-4fd8-95ee-5e2fc0dcd34c@palmer-ri-x1c9>
References: <mhng-5c57560e-a00b-4fd8-95ee-5e2fc0dcd34c@palmer-ri-x1c9>
Subject: Re: [PATCH v4 1/1] MAINTAINERS: add polarfire rng, pci and clock drivers
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Daire.McNamara@microchip.com,
        Lewis.Hanly@microchip.com, Cyril.Jean@microchip.com
To:     Arnd Bergmann <arnd@arndb.de>, Conor.Dooley@microchip.com,
        Greg KH <gregkh@linuxfoundation.org>,
        Palmer Dabbelt <palmer@rivosinc.com>, kw@linux.com,
        linux-clk@vger.kernel.org, linux-pci@vger.kernel.org,
        lorenzo.pieralisi@arm.com, mturquette@baylibre.com, robh@kernel.org
Date:   Thu, 09 Jun 2022 15:43:45 -0700
User-Agent: alot/0.10
Message-Id: <20220609224347.1212EC34115@smtp.kernel.org>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Palmer Dabbelt (2022-06-01 18:55:40)
> On Mon, 23 May 2022 13:00:01 PDT (-0700), Conor.Dooley@microchip.com wrot=
e:
> > On 23/05/2022 20:52, Palmer Dabbelt wrote:
> >> EXTERNAL EMAIL: Do not click links or open attachments unless you know=
 the content is safe
> >>=20
> >> On Mon, 23 May 2022 04:42:53 PDT (-0700), Conor.Dooley@microchip.com w=
rote:
> >>> On 05/05/2022 11:55, Conor Dooley wrote:
> >>>> Hardware random, PCI and clock drivers for the PolarFire SoC have be=
en
> >>>> upstreamed but are not covered by the MAINTAINERS entry, so add them.
> >>>> Daire is the author of the clock & PCI drivers, so add him as a
> >>>> maintainer in place of Lewis.
> >>>>
> >>>> Signed-off-by: Conor Dooley <conor.dooley@microchip.com>
> >>>
> >>> Hey Palmer,
> >>> I know youre busy etc but just a reminder :)
> >>=20
> >> Sorry, I didn't realize this was aimed at the RISC-V tree.=EF=BF=BD=EF=
=BF=BD I'm fine
> >> taking it, but it seems like these should have gone in along with the
> >> drivers.
> >=20
> > Yeah, sorry. In hindsight it should've but that ship has sailed. I sent
> > the rng bundled this way b/c I didn't want to end up a conflict.
> > Obv. there's not a rush so I can always split it back out if needs be.
>=20
> I'm adding a bunch of subsystem maintainers just to check again.  I=20
> don't have any problem with it, just not really a RISC-V thing and don't =

> wan to make a mess.  I've stashed it over at palmer/pcsoc-maintainers=20
> for now.
>=20

Acked-by: Stephen Boyd <sboyd@kernel.org>
