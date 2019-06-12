Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C95E42773
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 15:27:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731517AbfFLN1c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 09:27:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:53416 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728977AbfFLN1c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jun 2019 09:27:32 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9B30D20866;
        Wed, 12 Jun 2019 13:27:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560346051;
        bh=fCiEkHOn4IM9qMiFXhbfh3OOyEoB+GLRdm6K+ZhmpQQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ucR0cDZmFIAHAdxv2kahFhIRw1/m7K1Irbr3F1WGoYg1wU8GwY+GO3X8PGXOr9MfO
         27guwNNyMJRbXvYoPvcn2+SOMPfBEAIolvLJ1NJBgjuCA2nqD3gs+VATaw4iJSpvae
         0+8MmKtLZitZu83Igh7zA0p4Wi1UecnRG/psFaa0=
Date:   Wed, 12 Jun 2019 08:27:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Subject: Re: [PATCH/RESEND] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
Message-ID: <20190612132730.GB13533@google.com>
References: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
 <20190604014945.GE189360@google.com>
 <960c94eb151ba1d066090774621cf6ca6566d135.camel@kernel.crashing.org>
 <20190604124959.GF189360@google.com>
 <e520a4269224ac54798314798a80c080832e68b1.camel@kernel.crashing.org>
 <d53fc77e1e754ddbd9af555ed5b344c5fa523154.camel@kernel.crashing.org>
 <20190611233908.GA13533@google.com>
 <97fd2516fdde7f9f01688af426c103806f68dd2c.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97fd2516fdde7f9f01688af426c103806f68dd2c.camel@kernel.crashing.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 12, 2019 at 10:06:06AM +1000, Benjamin Herrenschmidt wrote:
> On Tue, 2019-06-11 at 18:39 -0500, Bjorn Helgaas wrote:

> > This is fine, but can we make a tiny step toward doing this in generic
> > code instead of adding more arch-specific stuff?
> > 
> > E.g., evaluate the _DSM in the generic acpi_pci_root_add(), set a
> > "preserve_config" bit in the struct acpi_pci_root, and test the bit
> > here?
> 
> I'd rather have the flag in the host bridge no ?

Oh, of course, that would make more sense.

> Talking of which, look at the ongoing discussion I have with Lorenzo
> when it comes to pci_bus_claim_resources vs. what x86 does, I'd love
> for you to chime in. I'd like to try to consolidate things further
> accross architectures but there might be reasons I don't see as to why
> things are different in that area, so ...

I don't know any reasons why things are different per arch.  In most
cases I suspect FUD.

Speaking of which, *this* patch looks like FUD because it essentially
says "Linux shouldn't change the PCI configuration on this system" but
it offers no explanation of *why* the config needs to be preserved.  I
would really like some note like "run-time firmware depends on the
addresses of device X".

Bjorn
