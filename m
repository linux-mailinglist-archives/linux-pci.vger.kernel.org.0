Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 886C94E2376
	for <lists+linux-pci@lfdr.de>; Mon, 21 Mar 2022 10:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243225AbiCUJli (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Mar 2022 05:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233668AbiCUJlh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Mar 2022 05:41:37 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1653CA64;
        Mon, 21 Mar 2022 02:40:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BBBEB8117A;
        Mon, 21 Mar 2022 09:40:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6018C340E8;
        Mon, 21 Mar 2022 09:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647855607;
        bh=ZKi4YlvyyNSHWjyB+pv67CnQHv49C6aN3o7OPmSTGeE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MW9gFgsfoF6aqMf7oDl7jGsCEMYkWMuwhedkNWKmxgjhCCrSMEYM/K7yvA5i10v07
         twc5NbGErePDCz2VF1fKRBpHrQQr7CLctI4FJNRkcHbrz2yMWzspp4iC1d5mvt6nSb
         xHyiMUIXZaQ0g6nH/OrG0NTkwjf2NjPo7DqBzDfCqjRID7LVcdB8fQC+Ra/iG30/E5
         wvZKJH4iwOcScGvjP+7kHVFe6ivxoU23a8DyuUAhv4kP0bQaUtehF4QeAv7CoKcVNh
         /HPb6b1/DFTq7ClrdHCdYyx2UUeqsQLvV3kVw0RfCLlPLiW3V+sqb0mRzjZBg7fsvT
         o6r5Nrxj1covg==
Received: from sofa.misterjones.org ([185.219.108.64] helo=why.misterjones.org)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <maz@kernel.org>)
        id 1nWEWC-00FuXw-Lf; Mon, 21 Mar 2022 09:40:04 +0000
Date:   Mon, 21 Mar 2022 09:40:04 +0000
Message-ID: <87ils7y77v.wl-maz@kernel.org>
From:   Marc Zyngier <maz@kernel.org>
To:     dann frazier <dann.frazier@canonical.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Toan Le <toan@os.amperecomputing.com>,
        Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?B?U3TDqXBoYW5l?= Graber <stgraber@ubuntu.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Re: [PATCH] PCI: xgene: Revert "PCI: xgene: Use inbound resources for setup"
In-Reply-To: <YjN8pT5e6/8cRohQ@xps13.dannf>
References: <20220314144429.1947610-1-maz@kernel.org>
        <YjL8P0zkle2foxbk@lpieralisi>
        <YjN8pT5e6/8cRohQ@xps13.dannf>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/27.1
 (x86_64-pc-linux-gnu) MULE/6.0 (HANACHIRUSATO)
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: dann.frazier@canonical.com, lorenzo.pieralisi@arm.com, robh@kernel.org, linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@android.com, toan@os.amperecomputing.com, kw@linux.com, bhelgaas@google.com, stgraber@ubuntu.com, regressions@leemhuis.info
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 17 Mar 2022 18:23:33 +0000,
dann frazier <dann.frazier@canonical.com> wrote:
>=20
> On Thu, Mar 17, 2022 at 09:15:43AM +0000, Lorenzo Pieralisi wrote:
> > [removed CC stable]
> >=20
> > On Mon, Mar 14, 2022 at 02:44:29PM +0000, Marc Zyngier wrote:
> > > Commit 6dce5aa59e0b ("PCI: xgene: Use inbound resources for setup")
> > > killed PCIe on my XGene-1 box (a Mustang board). The machine itself
> > > is still alive, but half of its storage (over NVMe) is gone, and the
> > > NVMe driver just times out.
> > >=20
> > > Note that this machine boots with a device tree provided by the
> > > UEFI firmware (2016 vintage), which could well be non conformant
> > > with the spec, hence the breakage.
> > >=20
> > > With the patch reverted, the box boots 5.17-rc8 with flying colors.
> > >=20
> > > Signed-off-by: Marc Zyngier <maz@kernel.org>
> > > Cc: Rob Herring <robh@kernel.org>
> > > Cc: Toan Le <toan@os.amperecomputing.com>
> > > Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> > > Cc: Krzysztof Wilczy=C5=84ski <kw@linux.com>
> > > Cc: Bjorn Helgaas <bhelgaas@google.com>
> > > Cc: St=C3=A9phane Graber <stgraber@ubuntu.com>
> > > Cc: dann frazier <dann.frazier@canonical.com>
> > > Cc: Thorsten Leemhuis <regressions@leemhuis.info>
> > > Cc: stable@vger.kernel.org>
> > > ---
> > >  drivers/pci/controller/pci-xgene.c | 33 ++++++++++++++++++++--------=
--
> > >  1 file changed, 22 insertions(+), 11 deletions(-)
> >=20
> > Dann, Rob,
> >=20
> > does this fix the regression debated here:
> >=20
> > https://lore.kernel.org/all/Yf2wTLjmcRj+AbDv@xps13.dannf
> >=20
> > It is unclear in that thread what the conclusion reached was.
>=20
> Thanks for checking in Lorenzo! Reverting that patch is required but
> not sufficient to get our m400s working. In addition, we'd also need
> to revert commit c7a75d07827a ("PCI: xgene: Fix IB window setup").
>=20
> I believe if we revert both then it should return us to a state where
> Marc's Mustang, St=C3=A9phane's Merlins and our m400s all work again.

Right. I'll post a series reverting both patches, which hopefully
Lorenzo and Bjorn can merge shortly.

Thanks,

	M.

--=20
Without deviation from the norm, progress is not possible.
