Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5244259830E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Aug 2022 14:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244533AbiHRMWv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 08:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240115AbiHRMWu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 08:22:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37564B2770
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 05:22:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C296761544
        for <linux-pci@vger.kernel.org>; Thu, 18 Aug 2022 12:22:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BC69C433D6;
        Thu, 18 Aug 2022 12:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660825368;
        bh=ypGy+78z9aSf176hU+tuxIxoLIa6YEaBBm70dka6Ncs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BNRiO//6a8chENw36zV6KCwIaSqWGe3dFUJRNJpE/jIlZ4mWSdcfTJCPGR7hPjDfI
         /4XoHJl3rTQsz0Gm1MxrDu+cmM+EuUVELuRlAH7eH7gM5DdjyzRdtLb2nMBIji+Bo3
         YgaRPvSNmpYmJszFmcdq+c631NcA1efPeNGGqb/nGHDXIbPAeBQnXQSMYP6j3qC6Je
         Sc2ZKQafacTV7Ueo88XXbUXSVgCiy0zIZfKzh02Uk2T72K5WoaX2xbibnCduoBp7K4
         MJc8zjrW4NySVdKwjATxqmTUIMBE/6mNsKCvw3bMLptqEDu4wEfycBe5p3dHx1W4Xv
         bIYWfnIaE+Z9A==
Date:   Thu, 18 Aug 2022 14:22:43 +0200
From:   Marek =?UTF-8?B?QmVow7pu?= <kabel@kernel.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     Pali =?UTF-8?B?Um9ow6Fy?= <pali@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof Wilczy??ski <kw@linux.com>,
        Marc Zyngier <maz@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Gregory CLEMENT <gregory.clement@bootlin.com>
Subject: Re: [PATCH 06/18] PCI: pciehp: Enable DLLSC interrupt only if
 supported
Message-ID: <20220818142243.4c046c59@dellmb>
In-Reply-To: <20220514091400.GA20725@wunner.de>
References: <20220220193346.23789-1-kabel@kernel.org>
        <20220220193346.23789-7-kabel@kernel.org>
        <20220509034216.GA26780@wunner.de>
        <20220513165729.wuaatfr2drsjwoos@pali>
        <20220514091400.GA20725@wunner.de>
X-Mailer: Claws Mail 3.19.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, 14 May 2022 11:14:00 +0200
Lukas Wunner <lukas@wunner.de> wrote:

> On Fri, May 13, 2022 at 06:57:29PM +0200, Pali Roh=C3=A1r wrote:
> > To answer your questions: Config space of Aardvark Root Port does not
> > conform to PCIe base spec. It does not implement DLLLARC, nor DLLSCE and
> > lot of other bits. Plus it has Type 0 header (not Type 1). And due to
> > these reasons, pci-aardvark.c driver implements "emulation" of the
> > Root Port and implements some of the functionality via custom aardvark
> > registers. So Root Port would be presented to kernel and also to
> > userspace as PCI Bridge device with Type 1 header and with PCIe
> > registers required by linux kernel.
> >=20
> > During my testing of kernel hotplug code last year, I figured out that
> > kernel was waiting for event which never happened. And so it was needed
> > to "fix" kernel to not try to enable DLLSCE because it did nothing. =20
>=20
> Could you please reproduce this and add the following on the command line:
>=20
>   log_buf_len=3D10M pciehp.pciehp_debug=3D1 dyndbg=3D"file pciehp* +p"
>   ignore_loglevel
>=20
> Then open a bug at bugzilla.kernel.org, attach full dmesg output
> as well as full "lspci -vv" output and send the bugzilla link to me.
>=20
> (Obviously, revert patches 6 and 7 when trying to reproduce it.)
>=20
> So a PDC event should be sufficient to bring the slot up or down,
> a DLLSC event should not be necessary.  Enabling DLLSC should not
> make a difference on a controller which doesn't support it.
> I just double-checked the code and I do not see where we'd wait
> for a DLLSC event which never comes.
>=20
> Don't worry, if we come to the conclusion that your proposed fix
> is the only solution, I'm fine with it, but at this point I'd
> like to get a better understanding what is really going on.
> Perhaps there is some other issue in pciehp that this patch
> just papers over.  Once you provide the dmesg debug output
> I'll be able to analyze that.

Dear Lukas,

we have tried to reproduce the bug where kernel was waiting for an
event which never happend, the bug that Pali remembered from his
work on the pciehp code.

We have concluded that it doesn't concert the DLLSC patch (06/18), only
the Command Completed Interrupt patch (07/18), and even there it seems
that the patch is not needed to trigger the bug: it seems that when
Pali was studying the bug, he did two things:
1. he made enabling Command Completed Interrupt conditional on NCCS bit
   not  set
2. he made the aardvark driver report NCCS bit via emulated bridge.

It turns out that only the second thing is needed, since the pciehp
code checks NCCS bit in pcie_wait_cmd() and does not wait for the
interrupt if NCCS is set.

Anyway we still think that both patches make sense, at least so that an
interrupt isn't reported as enabled and not supported at once when
dumping the configuration space.

So I will resend these patches with updated commit messages.

Marek
