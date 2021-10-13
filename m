Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8313742C219
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 16:06:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235623AbhJMOIa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 10:08:30 -0400
Received: from rosenzweig.io ([138.197.143.207]:46952 "EHLO rosenzweig.io"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230347AbhJMOIa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 10:08:30 -0400
Date:   Wed, 13 Oct 2021 10:06:20 -0400
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Colin King <colin.king@canonical.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: apple: Remove redundant initialization of
 pointer port_pdev
Message-ID: <YWbn3MoXwXZ/r4Hn@sunset>
References: <20211012133235.260534-1-colin.king@canonical.com>
 <20211013134114.GC11036@lpieralisi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013134114.GC11036@lpieralisi>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi Lorenzo,

> > The pointer port_pdev is being initialized with a value that is never
> > read, it is being updated later on. The assignment is redundant and
> > can be removed.
> > 
> > Addresses-Coverity: ("Unused value")
> > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > ---
> >  drivers/pci/controller/pcie-apple.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Squashed into the commit it is fixing.

It seems the commit already landed in linux-next? [1]

[1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=00723f494020aceb92f789af634fecba1477fc01

Alyssa
