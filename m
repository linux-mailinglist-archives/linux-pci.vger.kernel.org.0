Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61606537082
	for <lists+linux-pci@lfdr.de>; Sun, 29 May 2022 12:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiE2KI1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 29 May 2022 06:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbiE2KI1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 29 May 2022 06:08:27 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92799AE5B
        for <linux-pci@vger.kernel.org>; Sun, 29 May 2022 03:08:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1E2B5CE0B91
        for <linux-pci@vger.kernel.org>; Sun, 29 May 2022 10:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BF0C385A9;
        Sun, 29 May 2022 10:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653818900;
        bh=x5z5l4FMaBFY4jQAVBK9M2bjstOR54TlMBvs3UDLlx0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dijSRjG5fU6tYBJJLM1RspFvibrrjMo/20pKCp5FARkkjx7jFccIR9P6yEzbKHt9K
         MLpj55RszQL6v+V0bbve+i2rdMQTgymXEjCrAQD4Q5eWbHA3/IJXjc84Ot/Rz3x1ot
         4h7H/7H4a7sS9xMJ1O5CiaPbgPgosZIJAOvuLmdMB350Tise+wwcWfQ7Ylr1f2J1Au
         Z0UBzX7Tq+kn9+dHXj3fhSF8LWKiHGqBPYLruYOmsGfCnPIsC/7ki9+sSeH1qnH1wF
         Pgd4MPE4XpaSmqXpO13NCSAwsRBNt5BPYHLPIs/BEkgtd+3m1xNcpSd4222RCFuc4b
         sH3PeTmdsBANQ==
Date:   Sun, 29 May 2022 12:08:13 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org,
        Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: aardvark: Add support for AER registers on
 emulated bridge
Message-ID: <20220529120813.7dcb5aaf@thinkpad>
In-Reply-To: <20220526203801.GI54904-robh@kernel.org>
References: <20220524132827.8837-1-kabel@kernel.org>
        <20220524132827.8837-2-kabel@kernel.org>
        <20220526203801.GI54904-robh@kernel.org>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 26 May 2022 15:38:01 -0500
Rob Herring <robh@kernel.org> wrote:

> On Tue, May 24, 2022 at 03:28:26PM +0200, Marek Beh=C3=BAn wrote:
> > From: Pali Roh=C3=A1r <pali@kernel.org>
> >=20
> > Aardvark controller supports Advanced Error Reporting configuration
> > registers.
> >=20
> > Export these registers on the emulated root bridge via the new .read_ext
> > and .write_ext methods.
> >=20
> > Note that in the Advanced Error Reporting Capability header the offset
> > to the next Extended Capability header is set, but it is not documented
> > in Armada 3700 Functional Specification. Since this change adds support
> > only for Advanced Error Reporting, explicitly clear PCI_EXT_CAP_NEXT
> > bits in AER capability header.
> >=20
> > Now the pcieport driver correctly detects AER support and allows PCIe
> > AER driver to start receiving ERR interrupts. Kernel log now says:
> >=20
> >     [    4.358401] pcieport 0000:00:00.0: AER: enabled with IRQ 52
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
> > Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> =20
>=20
> Did you mean Reviewed-by? Signed-off-by is only correct if Lorenzo=20
> applied or rewrote these. If he applied them, then Bjorn will pick them=20
> up.

Hmm. Well, Lorenzo applied the subset I am sending (patches 3 and 5) to
his tree, with SOB, meaning to send it to Bjorn [1].

Then we discovered that patch 4 is also required for the _SHIFT
macros, which was discussed previously that we want to avoid those, and
use FIELD_PREP() / FIELD_GET() instead [2].

So I updated the second patch to use FIELD_PREP() / FIELD_GET() instead
of the _SHIFT macros. I guess this version isn't SOB by Lorenzo, but
the first version was... I should probably change it to Reviewed-by for
both patches anyway, right?

Marek

[1]
https://lore.kernel.org/linux-arm-kernel/165288925279.7950.9068708285341295=
4.b4-ty@arm.com/

[2]
https://lore.kernel.org/linux-arm-kernel/20220518202729.GA4606@bhelgaas/
