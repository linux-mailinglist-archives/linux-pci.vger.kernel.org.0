Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FADD11984D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Dec 2019 22:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbfLJVik (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 10 Dec 2019 16:38:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44740 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfLJVij (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 10 Dec 2019 16:38:39 -0500
Received: from localhost (mobile-166-170-223-177.mycingular.net [166.170.223.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A58120828;
        Tue, 10 Dec 2019 21:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1576013918;
        bh=iBgwcqaqBpCkZ0DHrwouNEs/rxFI/NvMwVvKFZ8tIIc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qGyB7Mw5mj7++nkPwUbmN8unW9QVEE66AAaxgJktpQrNbVTUB6wnS7s4XomiIIxEx
         GqIzQ4h/13H6Q+Ls7V4JkFS+3BUN/td8y28qqRuo8hIadBzDakFdOU+wtj0OMshJ2L
         rxTni2l5iz4DvoFrBEijFeVCwIOYN1c/b5+d9Y6U=
Date:   Tue, 10 Dec 2019 15:38:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH v12 0/4] PCI: Patch series to improve Thunderbolt
 enumeration
Message-ID: <20191210213836.GA149297@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PSXP216MB043892C04178AB333F7AF08C80580@PSXP216MB0438.KORP216.PROD.OUTLOOK.COM>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Dec 09, 2019 at 12:59:29PM +0000, Nicholas Johnson wrote:
> Hi all,
> 
> Since last time:
> 	Reverse Christmas tree for a couple of variables
> 
> 	Changed while to whilst (sounds more formal, and so that 
> 	grepping for "while" only brings up code)
> 
> 	Made sure they still apply to latest Linux v5.5-rc1
> 
> Kind regards,
> Nicholas
> 
> Nicholas Johnson (4):
>   PCI: Consider alignment of hot-added bridges when distributing
>     available resources
>   PCI: In extend_bridge_window() change available to new_size
>   PCI: Change extend_bridge_window() to set resource size directly
>   PCI: Allow extend_bridge_window() to shrink resource if necessary
> 
>  drivers/pci/setup-bus.c | 182 +++++++++++++++++++---------------------
>  1 file changed, 88 insertions(+), 94 deletions(-)

Applied to pci/resource for v5.6, thanks!
