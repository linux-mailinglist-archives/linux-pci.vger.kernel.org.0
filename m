Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84DAC4197F9
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 17:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235087AbhI0PdJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 11:33:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:38946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234158AbhI0PdI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 11:33:08 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 282FA60E94;
        Mon, 27 Sep 2021 15:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632756690;
        bh=BSIQbhcTAO8ZPgbB9YoTkX4id04un2WWtaUv2/wWqfg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=EyH4WRLrHmQ3FMOjdcXuaJQ5cGQUSUth95nwzt9aZ7C5tThMZQJypMc1I8l8OpDo/
         kKTUj4kaiPwcxsF32qHpvBCkT12SZujArnHLfiIo2ihLFFCoyzUFSUz3GffjRuzytk
         j+GMZsU3FvIU2RnErdUk4FiY+jux7YSQuiSXp4JP+KrcJgISiEzFfTfQa1lbKpyvof
         StMbBxOMGulaAOPggrSlfFeK4KZpsYnJj1h58T5cfxnR0ZK/a71NX0FKvbLc0IgM1t
         fuaI6MelcpS95lsaPbKes+jx3wxPRqcxtnn8i+9Ky2fXwpV+5QhXbVKP5wJk3Vvx9W
         XbqUDIX+iePXQ==
Date:   Mon, 27 Sep 2021 10:31:28 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Sergio M. Iglesias" <sergio@lony.xyz>
Cc:     bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        kw@linux.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: About the "__refdata" tag in pci-keystone.c
Message-ID: <20210927153128.GA646260@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210927103321.v4kod7xfiv5sreet@lony.xyz>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Sep 27, 2021 at 12:33:21PM +0200, Sergio M. Iglesias wrote:
> Hello!
> 
> I have checked the "__refdata" tag that appears in the file
> "drivers/pci/controller/dwc/pci-keystone.c" and it is needed. The tag has
> been there since the creation of the file on commit 6e0832fa432e and
> nothing has changed since that would make it redundant.
> 
> The reason it is needed is because the struct references "ks_pcie_probe",
> which is a function tagged as "__init", so the compiler will most likely
> complain about the "__refdata" being removed.
> 
> Should I send a patch to add a comment explaining why it is a necessary
> tag as recommended in "include/linux/init.h"?
> > [...] so optimally document why the __ref is needed and why it's OK).

Thanks a lot for looking into this.

I'm not yet convinced that either the __init or the __refdata is
necessary.  If there is a reason, it would not be "to silence a
compiler complaint"; it would be something like "the keystone platform
is different from all the other platforms because the other platforms
support X but keystone does not."

Also, there are a couple other .probe() functions that are marked
__init:

  $ git grep "static int .*_pci.*_probe" drivers/pci | grep __init
  drivers/pci/controller/dwc/pci-keystone.c:static int __init ks_pcie_probe(struct platform_device *pdev)
  drivers/pci/controller/dwc/pci-layerscape-ep.c:static int __init ls_pcie_ep_probe(struct platform_device *pdev)
  drivers/pci/controller/mobiveil/pcie-layerscape-gen4.c:static int __init ls_pcie_g4_probe(struct platform_device *pdev)
  drivers/pci/controller/pci-ixp4xx.c:static int __init ixp4xx_pci_probe(struct platform_device *pdev)

and their platform_driver structs are not marked __refdata:

  $ git grep "static struct platform_driver" drivers/pci | grep __refdata
  drivers/pci/controller/dwc/pci-keystone.c:static struct platform_driver ks_pcie_driver __refdata = {

I think this should all be more consistent: either all these __init
and __refdata annotations should be removed, or they should be used by
many more drivers.

Bjorn
