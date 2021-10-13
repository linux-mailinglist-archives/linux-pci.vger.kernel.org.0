Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5884F42C29E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 16:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbhJMORG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 10:17:06 -0400
Received: from foss.arm.com ([217.140.110.172]:39952 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236390AbhJMORG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 10:17:06 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B9E7ED6E;
        Wed, 13 Oct 2021 07:15:02 -0700 (PDT)
Received: from lpieralisi (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 83BDA3F694;
        Wed, 13 Oct 2021 07:15:01 -0700 (PDT)
Date:   Wed, 13 Oct 2021 15:14:59 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Alyssa Rosenzweig <alyssa@rosenzweig.io>
Cc:     Colin King <colin.king@canonical.com>,
        Marc Zyngier <maz@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] PCI: apple: Remove redundant initialization of
 pointer port_pdev
Message-ID: <20211013141459.GD11036@lpieralisi>
References: <20211012133235.260534-1-colin.king@canonical.com>
 <20211013134114.GC11036@lpieralisi>
 <YWbn3MoXwXZ/r4Hn@sunset>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YWbn3MoXwXZ/r4Hn@sunset>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 13, 2021 at 10:06:20AM -0400, Alyssa Rosenzweig wrote:
> Hi Lorenzo,
> 
> > > The pointer port_pdev is being initialized with a value that is never
> > > read, it is being updated later on. The assignment is redundant and
> > > can be removed.
> > > 
> > > Addresses-Coverity: ("Unused value")
> > > Signed-off-by: Colin Ian King <colin.king@canonical.com>
> > > ---
> > >  drivers/pci/controller/pcie-apple.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > Squashed into the commit it is fixing.
> 
> It seems the commit already landed in linux-next? [1]
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=00723f494020aceb92f789af634fecba1477fc01

I know thanks. The updated one will land in next shortly.

Lorenzo
