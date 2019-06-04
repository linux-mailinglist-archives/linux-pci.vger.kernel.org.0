Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 242A935131
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 22:41:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFDUle (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 16:41:34 -0400
Received: from gate.crashing.org ([63.228.1.57]:33068 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726033AbfFDUle (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jun 2019 16:41:34 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x54KfGAB012090;
        Tue, 4 Jun 2019 15:41:17 -0500
Message-ID: <e520a4269224ac54798314798a80c080832e68b1.camel@kernel.crashing.org>
Subject: Re: [RFC] ARM64 PCI resource survey issue(s)
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Date:   Wed, 05 Jun 2019 06:41:16 +1000
In-Reply-To: <20190604124959.GF189360@google.com>
References: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
         <20190604014945.GE189360@google.com>
         <960c94eb151ba1d066090774621cf6ca6566d135.camel@kernel.crashing.org>
         <20190604124959.GF189360@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2019-06-04 at 07:49 -0500, Bjorn Helgaas wrote:
> > Yes... I am not personally aware of such a case but I was led to
> > believe based on prior conversations that such setups do exist,
> > especially in the non-ACPI ARM64 world. Which is why I would suggest
> > initially changing the default only on ACPI, at least until we have a
> > bit better visibility.
> 
> If a resource assignment that is valid in terms of all the PCI rules
> (BARs are valid, BARs are inside upstream bridge windows, etc) doesn't
> work, we would need more information in order to fix anything.  We'd
> need to know exactly *what* doesn't work and *why* so we can avoid it.
> The current blanket statement of "reassign everything and hope it
> works better" is useless.

I agree and I assume the problem stems from BIOSes creating either
invalid or incomplete assignments but as I said, I don't know for sure
as our platforms dont have that problem.

Cheers,
Ben.


