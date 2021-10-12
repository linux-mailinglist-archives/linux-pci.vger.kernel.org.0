Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 337F742AFD8
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 00:52:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235142AbhJLWyv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Oct 2021 18:54:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:37236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234607AbhJLWyu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Oct 2021 18:54:50 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4D21E604DA;
        Tue, 12 Oct 2021 22:52:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634079167;
        bh=6avHt35fxd5kfvbX66gcBjXd91rrPnS5ZdttP+UskTM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tUPaJIq+NbqOD928tKX1BaHll+Clbo11OlaJjS4L7fMEi3Wxh/KWrAvByhm27g5uI
         jHufW02Yvz1zwBCVPjT1Y/91WiqSaK4VXq419ncpNJKGlkB+Co8bjghoeZnZghTjy7
         oWO7Ymrq2Z/HgxNplbaJCMFxu52HBXferNerq53AFNa0ZEZ5dvUb+TQ9Nxw1ris26r
         dBXS0CwwWl/xjHh8KKj91DETVIts+SXYLIGcB7Phu2VN9UzhbUS/hTcfnIcHwL924U
         tQFqx3LtPP6pUc3CDOd8v4r4ZBx6coeyaGD1YkX3x7pFxgIydvCfKGhTu3zZdMiaA1
         yYZ8pclq0gZJQ==
Received: by pali.im (Postfix)
        id A11267B4; Wed, 13 Oct 2021 00:52:44 +0200 (CEST)
Date:   Wed, 13 Oct 2021 00:52:44 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        andrew.murray@arm.com
Subject: Re: [PATCH 02/22] PCI: Unify PCI error response checking
Message-ID: <20211012225244.y75fsd7777ubvljl@pali>
References: <cover.1633972263.git.naveennaidu479@gmail.com>
 <c632b07eb1b08cc7d4346455a55641436a379abd.1633972263.git.naveennaidu479@gmail.com>
 <YWS1QtNJh7vPCftH@robh.at.kernel.org>
 <20211012162054.rxx7aubwdvhl2eqj@theprophet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211012162054.rxx7aubwdvhl2eqj@theprophet>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tuesday 12 October 2021 21:51:08 Naveen Naidu wrote:
> On 11/10, Rob Herring wrote:
> > On Mon, Oct 11, 2021 at 11:08:32PM +0530, Naveen Naidu wrote:
> > >  		return PCIBIOS_DEVICE_NOT_FOUND;
> > 
> > Neither does this using custom error codes rather than standard Linux 
> > errno. I point this out as I that's were I'd start with the config 
> > accessors. Though there are lots of occurrences so we'd need a way to do 
> > this in manageable steps.
> > 
> 
> I am sorry, but I do not have any answer for this. I really do not know
> why we return custom error codes instead of standard Linux errno. Maybe
> someone else can pitch in on this.

More people are asking same question and Bjorn recently wrote answer:
https://lore.kernel.org/linux-pci/20211011205851.GA1690395@bhelgaas/

It looks like some relict from past when PCI was implemented only for x86.

Anyway, I was looking at PCI firmware spec (where are these PCBIOS_*
codes defined) and config read function can return only
PCIBIOS_SUCCESSFUL value.

So if kernel PCI API is following this PCBIOS API it means that
controller drivers are implementing it improperly if they returns also
non-success value for read method in some cases. And for me it looks
like very "stupid" API for read as it has basically same meaning as
function with void return value.

> > Can't we make PCI_OP_READ and PCI_USER_READ_CONFIG set the data value 
> > and delete the drivers all doing this? Then we have 2 copies (in source) 
> > rather than the many this series modifies. Though I'm not sure if there 
> > are other cases of calling pci_bus.ops.read() which expect to get ~0.
> > 
> 
> This seems like a really good idea :) But again, I am not entirely sure
> if doing so would give us any unexpected behaviour. I'll wait for some
> one to reply to this and if people agree to it, I would be glad to make
> the changes to PCI_OP_READ and PCI_USER_READ_CONFIG and send a new
> patch.

If you are going to discuss and change API of config read / write
functions, please CC me.

For example pci-aardvark controller reports not only "unknown error"
happened (via 0xffffffff) but can report exact PCIe error (CRS, UR, CA)
which can be mapped to some linux errnos. I can imagine that it can be
useful for some callers.
