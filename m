Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05EF74BACDC
	for <lists+linux-pci@lfdr.de>; Thu, 17 Feb 2022 23:44:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244907AbiBQWn4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Feb 2022 17:43:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240152AbiBQWn4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Feb 2022 17:43:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C2C3169233
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 14:43:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA3EF6184B
        for <linux-pci@vger.kernel.org>; Thu, 17 Feb 2022 22:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D83BCC340E8;
        Thu, 17 Feb 2022 22:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645137820;
        bh=YCYCDzKG3hvl1kBvMT2cCfJG9PV0xAJpkKUqshvSFeU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=UWiEHEsZicO+UQ1IkYGowtH23RNHJXrPpspwOF/agfsGrctVJz4G36r8oPcIwm3Su
         eKjFcBQ0iMYOMDNHpm3EsLMvq3R07nx5RtxSuz9r5MySQrhRd/t6mecSMnL0B43Hs4
         Xg+sfw4DZIcOtPdh7ejz5MovPpXE8//44USwKq5P2aYfcZezD6F8gMzz/fPz0nkrUr
         xTwSWOQu+8yH2UKyO/4ERJTQ8ZIBPaW3Sz+jn1T2WF4re3kGfXGLvuSi99XHYaQte+
         9+ygpm6nPmuV8wOa0+4zGK+rOFJy8tgNOj+2lYIXDvS4StIKhrfz9f0pspLl4SoE6H
         MKpFRCVEwtOAA==
Date:   Thu, 17 Feb 2022 16:43:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Zhi Li <lznuaa@gmail.com>
Cc:     Frank Li <Frank.Li@nxp.com>, linux-pci@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com, kw@linux.com,
        jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        hongxing.zhu@nxp.com, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <allenbh@gmail.com>, linux-ntb@googlegroups.com
Subject: Re: [RFC PATCH 2/4] NTB: epf: Added more flexible memory map method
Message-ID: <20220217224338.GA311331@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHrpEqSWZaLan18+s_h2fLeKxqOv3yM2Zo7hr_P03bBBKvMYVA@mail.gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Feb 17, 2022 at 04:24:56PM -0600, Zhi Li wrote:
> On Thu, Feb 17, 2022 at 3:59 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Jon, Dave, Allen, linux-ntb, since you need at least an ack from
> > the NTB folks; beginning of thread:
> > https://lore.kernel.org/r/20220215053844.7119-1-Frank.Li@nxp.com]
> >
> > In subject, s/Added/Add/.
> >
> > But I don't think it's quite right yet, because this doesn't actually add
> > any functions.
> 
> How about "Allow more flexibility in the memory bar map method"?

s/bar/BAR/

Are you saying that the BAR numbers were fixed before, and you're
adding the ability to change the BAR numbers?  It would be useful to
know what sort of flexibility you're adding.

> > On Mon, Feb 14, 2022 at 11:38:42PM -0600, Frank Li wrote:
> > > Supported below memory map method
> > >
> > > bar 0: config and spad data
> > > bar 2: door bell
> > > bar 4: memory map windows
> >
> > s/bar/BAR/
> > s/spad/?/ (I don't know what this is)
> 
> SCRATCHPAD REGION
> https://www.kernel.org/doc/html/latest/driver-api/ntb.html

Just spelling out "scrachpad" is probably enough.

And s/door bell/doorbell/ to match your usage elsewhere.

> > Please make the commit log say what this patch does.
> 
> Does it help if attach ASCII diagram in patch 3/4 or cover letter one

The diagram is nice, but doesn't need to be replicated everywhere.  A
description of what the patch does would be better.

Bjorn
