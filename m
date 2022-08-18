Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4677F5990E4
	for <lists+linux-pci@lfdr.de>; Fri, 19 Aug 2022 01:04:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbiHRXDB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Aug 2022 19:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243287AbiHRXDA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Aug 2022 19:03:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CD10CAC80;
        Thu, 18 Aug 2022 16:03:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DA1C6B824D5;
        Thu, 18 Aug 2022 23:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D94C433C1;
        Thu, 18 Aug 2022 23:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660863777;
        bh=AbGgHbOwjkTVykX8eGWFbdjfmv1+Nmg9/TBmKGaYiwI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IlTgc0hS2koGEgkX5XMYOR4PcpRpMSTQn9s/t+hMKYt7j6dW9+Wa+D3V2DWhVtDP/
         ig5rE9KmrjZwwh5BsAZkRuCVfX5QrsF7oFSP/5crTzHF6ipceH2IowlxoVJ0p9RpuN
         EbuYEsmku2hXPCkNRWaH9yds10PRbteYzvaMl88th/7R1mNQfLj5e2bFuPd+rGYyjE
         zCKDwZAQDkKjw/i5BbKme2s47hkue/oSQKcBAkvxKh/OtAhAEnAn7ZdENy78NZeYv1
         os822RorHekAvF+APFBe9MuQFLT3HZNIB6/EhcNUA57eiirWIsIzwJzpl88M/4+bOY
         vcDhxvO0xwEmg==
Date:   Thu, 18 Aug 2022 18:02:55 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: pci-bridge-emul: Set position of PCI capabilities
 to real HW value
Message-ID: <20220818230255.GA2403243@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220818223636.zohqfos6i22pbs7h@pali>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 19, 2022 at 12:36:36AM +0200, Pali Rohár wrote:
> On Thursday 18 August 2022 17:31:36 Bjorn Helgaas wrote:
> > On Thu, Aug 18, 2022 at 03:50:54PM +0200, Pali Rohár wrote:
> > > On Sunday 03 July 2022 12:46:27 Pali Rohár wrote:
> > > > mvebu and aardvark HW have PCIe capabilities on different offset in PCI
> > > > config space. Extend pci-bridge-emul.c code to allow setting custom driver
> > > > custom value where PCIe capabilities starts.
> > > > 
> > > > With this change PCIe capabilities of both drivers are reported at the same
> > > > location as where they are reported by U-Boot - in their real HW offset.
> > 
> > Just curious since I haven't read the patch, and Lorenzo will take
> > care of this anyway, but does this fix a bug, i.e., does something
> > work when it didn't work before?  Or does everything *work* without
> > this patch, but lspci reports capabilities at different offsets than
> > U-Boot?
> 
> The last sentence is correct. Everything works with and also without
> this patch. Just without this patch lspci reports capabilities at
> different offsets than what HW reports and what U-Boot reports (U-Boot
> already reports offsets same as in HW).
> 
> So lets say, that with this patch, it is easier to compare pci config
> space dump from u-boot and linux. And this simplify debugging.

I agree, that's a really annoying difference.  Seems like a good thing
to fix (again, not having looked at the patch, I have no opinion on
the implementation :)).

Bjorn
