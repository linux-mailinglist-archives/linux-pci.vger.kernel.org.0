Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15A277D65D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Aug 2023 00:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233717AbjHOWqg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Aug 2023 18:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbjHOWqQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Aug 2023 18:46:16 -0400
Received: from ciao.gmane.io (ciao.gmane.io [116.202.254.214])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EB4E74
        for <linux-pci@vger.kernel.org>; Tue, 15 Aug 2023 15:46:14 -0700 (PDT)
Received: from list by ciao.gmane.io with local (Exim 4.92)
        (envelope-from <glp-linux-pci@m.gmane-mx.org>)
        id 1qW2nl-0001KA-3U
        for linux-pci@vger.kernel.org; Wed, 16 Aug 2023 00:46:13 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-pci@vger.kernel.org
From:   deloptes <emanoil.kotsev@deloptes.org>
Subject: Re: SSD SATA 3.3 and Broadcom / LSI SAS1068E PCI-Express Fusion-MPT SAS
Followup-To: gmane.linux.kernel.pci
Date:   Wed, 16 Aug 2023 00:46:03 +0200
Lines:  45
Message-ID: <ubgv7c$43t$1@ciao.gmane.io>
References: <ubedo7$151n$1@ciao.gmane.io> <20230815174942.GA211975@bhelgaas>
Reply-To: emanoil.kotsev@deloptes.org
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8Bit
User-Agent: KNode/0.10.9
X-Face: &bB+dG6r\D$gd^NFeYm<f{n8m&2W,Lr'h>#MNOHtI/(z<->Su~)mL1rYXAE7W:U2d;tQAEP  ?3('tC@:iV_x)~3Kq.-X\\j1HU;i6/u\An"y=\gO%d`v#QdRgaw9JySH|xOp&6giT2q+z3j<t`[9@b  _&-<C%rE*@-)n9uI5?P_u9`8x.@SeM*h,'bBR~v^^XiU[Y&\/L6(jEpen8eNtlhu!p)GYOW6Iny
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Bjorn Helgaas wrote:

Thank you Bjorn for answering and explaining

> ASPM is a PCIe feature that applies to the PCIe Links between 00:02.0
> and 01:00.0 (the first 1068E) and 00:15.0 and 08:00.0 (the second
> 1068E).
> 
> PWDIS is a feature on the SATA cables between the SAS1068E adapters
> and the SSDs.
> 
> PWDIS/P3 should not be related to ASPM.  I assume you're referring to
> the "disabling ASPM on pre-1.1 PCIe device" message.  That should
> happen with both the old r3.0 HDDs and the new r3.3 SSDs.
> 

Yes, this is what I meant. So it can be ignored as well as the ASPM.
I will check the cables, when I can get hands on the machine - just out of
curiosity.

> I wish I had some good ideas for you, but I don't know anything about
> the SATA side.  I googled for "1068 ssd sata 1.5 gb/s" and found a few
> hints about system firmware, LSI firmware, etc, but nothing concrete.
> 

Yeah, if it were so easy, I wouldn't be bothering you.

> I think some controllers have a BIOS setup user interface; have you
> poked around in there?

I have not seen the bios of the machine for many years. I was looking
forward to plug it to a console, so that I can reboot remotely, but for
some reason it was not possible. It was may be 5y ago. I will definitely
double check this, allthough there will be nothing regarding SATA3.3 there
as these were build many years before SATA3.3 saw daylight.

As mentioned in the other posting I will attach those SSDs directly to the
mobo. There are 6 SATA ports there. I think this is the best approach.
But you know curiosity is a force you can not resist, so I still want to
know why?! :)

Thank you anyway
BR
-- 
FCD6 3719 0FFB F1BF 38EA 4727 5348 5F1F DCFE BCB0

