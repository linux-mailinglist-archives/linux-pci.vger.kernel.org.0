Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED96516F0A
	for <lists+linux-pci@lfdr.de>; Mon,  2 May 2022 13:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384781AbiEBLtp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 May 2022 07:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355474AbiEBLtm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 May 2022 07:49:42 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 35A92167D4;
        Mon,  2 May 2022 04:46:13 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id A665B92009C; Mon,  2 May 2022 13:46:11 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id A19A992009B;
        Mon,  2 May 2022 12:46:11 +0100 (BST)
Date:   Mon, 2 May 2022 12:46:11 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Ben Dooks <ben.dooks@codethink.co.uk>
cc:     Alexandre Ghiti <alex@ghiti.fr>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        Bjorn Helgaas <bhelgaas@google.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Greentime Hu <greentime.hu@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        Neill Whillans <neill.whillans@codethink.co.uk>
Subject: Re: [V3] PCI: fu740: Drop to 2.5GT/s to fix initial device probing
 on some boards
In-Reply-To: <3acd20b2-5882-7cc0-8a7b-7b406b768c1c@codethink.co.uk>
Message-ID: <alpine.DEB.2.21.2205020049130.9383@angie.orcam.me.uk>
References: <20220318152430.526320-1-ben.dooks@codethink.co.uk> <2442936e-a53e-59bf-488f-95eac26d1252@ghiti.fr> <85e864fd-762e-0780-f829-bfbb178ab24e@ghiti.fr> <bded4b1e-3404-6bcd-3289-dc8d5b4d713a@codethink.co.uk> <alpine.DEB.2.21.2204140048460.9383@angie.orcam.me.uk>
 <3acd20b2-5882-7cc0-8a7b-7b406b768c1c@codethink.co.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Ben,

> >   Any idea what might be causing it?  I can't see it being explicitly set
> > or cleared anywhere, be it in U-Boot or Linux, so it must be done by the
> > device itself depending on something.  And the lack of this capability
> > seems to me like non-compliance for a multiple-lane, multiple-speed
> > device.
> 
> I'll see if we can reproduce this

 Have you been able to look into it?

  Maciej
