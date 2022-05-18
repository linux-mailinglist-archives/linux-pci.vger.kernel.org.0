Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C8952C3F3
	for <lists+linux-pci@lfdr.de>; Wed, 18 May 2022 22:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242276AbiERUGM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 May 2022 16:06:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242364AbiERUGG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 May 2022 16:06:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CCAF60B83
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 13:06:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1682619B6
        for <linux-pci@vger.kernel.org>; Wed, 18 May 2022 20:06:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 545D3C385A5;
        Wed, 18 May 2022 20:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652904362;
        bh=AB9p2DoJPg63wdRnOoH5Nqdhvpaw6DcreJOF1wFipAI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=J2+S+1VKPnh2POWYdUs8iriLXUMc/Uf8BRrvrlic8o2JkMroEWVjHh6Vs9y+/kjio
         DzIRp+AEw2THyVCJnROXJghvA/PHkWpfzyQrwWuMGI7/tFUAhS826LlZk//zOcfHhN
         ZlLLYqeRtIrJssbXh225u2kcB2tR19a+Fh1/DVJjvFN3+1n/Kn2HeZ5NvCPJm5OXZO
         Y0lEa0vn2yZUNch4b/DVKYy4hJNj3TVimM/iT7VsRqvmOhHh5sSHMrZxwhbVCv8PaX
         GkPvDT2F1DBo8YIQM9m1u6jK/ui5bmrHHY0W0PC92O4z4gO6bixIWlU83vduFNPWLR
         46Ot2PUlvD6zQ==
Date:   Wed, 18 May 2022 22:05:56 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 04/18] PCI: Add PCI_EXP_SLTCAP_*_SHIFT macros
Message-ID: <20220518220556.753c0367@thinkpad>
In-Reply-To: <20220518192600.usgzcaca565kt66h@pali>
References: <20220220193346.23789-5-kabel@kernel.org>
        <20220518192322.GA1155024@bhelgaas>
        <20220518192600.usgzcaca565kt66h@pali>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 18 May 2022 21:26:00 +0200
Pali Roh=C3=A1r <pali@kernel.org> wrote:

> On Wednesday 18 May 2022 14:23:22 Bjorn Helgaas wrote:
> > On Sun, Feb 20, 2022 at 08:33:32PM +0100, Marek Beh=C3=BAn wrote: =20
> > > From: Pali Roh=C3=A1r <pali@kernel.org>
> > >=20
> > > These macros allows to easily compose and extract Slot Power Limit and
> > > Physical Slot Number values from Slot Capability Register.
> > >=20
> > > Signed-off-by: Pali Roh=C3=A1r <pali@kernel.org>
> > > Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org> =20
> >=20
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> >=20
> > We talked about using FIELD_PREP() / FIELD_GET(), which I think would
> > remove the need for the *_SHIFT macros.  But we can always do that
> > later. =20
>=20
> I have already done this for pci-mvebu.c driver and patch was merged:
> https://lore.kernel.org/linux-pci/20220412094946.27069-5-pali@kernel.org/
>=20
> IIRC we have decided to not use those *_SHIFT macros as it would flood
> public uapi file and from this file we cannot remove macros due to
> userspace backward compatibility.

So should I change patch 5 of the aardvark batch 5 to also use
FIELD_GET(), so that this patch is not needed?

Marek
