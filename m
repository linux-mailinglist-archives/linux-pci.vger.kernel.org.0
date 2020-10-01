Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FCA8280342
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 17:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732517AbgJAPxM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 11:53:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:58148 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732331AbgJAPxM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 1 Oct 2020 11:53:12 -0400
Received: from localhost (170.sub-72-107-125.myvzw.com [72.107.125.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2CEF120872;
        Thu,  1 Oct 2020 15:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601567592;
        bh=3y8JWfLL5dODqPi5bHq6fgfvuFy9ctHX4jdjrNwdoSM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=u9lKXwnUgdRk7flb8sSGV4h8hpJkTGqBDR8Ke54ap9Co71JHTTM8WEC3uxX14dZsh
         PgzH8rOE4RYARidBG81FkydMhDeZwtl0QHOlj6zYqgTwPQG+MCL6rw2TaYxymrdoKY
         Go7G1yCJsiSs1eTOk4CxIoKvtowwg6vrP3mJNBgA=
Date:   Thu, 1 Oct 2020 10:53:10 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Pratyush Anand <pratyush.anand@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        PCI <linux-pci@vger.kernel.org>
Subject: Re: of_match[] warnings
Message-ID: <20201001155310.GA2691450@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqKhP+o_Y6t8HRRp20F3isAtqdNLPzhg7VxDyY7j-UYOSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 01, 2020 at 07:48:23AM -0500, Rob Herring wrote:
> On Wed, Sep 30, 2020 at 5:37 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > These warnings are sort of annoying.  I guess most of the other
> > drivers avoid this by depending on OF as well as COMPILE_TEST.
> 
> Using the of_match_ptr() macro should prevent this.

Both drivers *do* use of_match_ptr(), but the of_device_id table is
unused when of_match_ptr() throws away the pointer.

I guess we could add __maybe_unused to squelch the warning.  Ugly, but
I do think COMPILE_TEST has some value.

> >   $ grep -E "CONFIG_(OF|PCIE_(SPEAR13XX|ARMADA_8K))" .config
> >   CONFIG_PCIE_SPEAR13XX=y
> >   CONFIG_PCIE_ARMADA_8K=y
> >   # CONFIG_OF is not set
> >
> >   $ make W=1 drivers/pci/
> >   ...
> >     CC      drivers/pci/controller/dwc/pcie-spear13xx.o
> >   drivers/pci/controller/dwc/pcie-spear13xx.c:270:34: warning: ‘spear13xx_pcie_of_match’ defined but not used [-Wunused-const-variable=]
> >     270 | static const struct of_device_id spear13xx_pcie_of_match[] = {
> >         |                                  ^~~~~~~~~~~~~~~~~~~~~~~
> >   ...
> >     CC      drivers/pci/controller/dwc/pcie-armada8k.o
> >   drivers/pci/controller/dwc/pcie-armada8k.c:344:34: warning: ‘armada8k_pcie_of_match’ defined but not used [-Wunused-const-variable=]
> >     344 | static const struct of_device_id armada8k_pcie_of_match[] = {
> >         |                                  ^~~~~~~~~~~~~~~~~~~~~~
> >
