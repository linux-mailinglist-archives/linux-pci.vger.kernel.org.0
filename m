Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2D6A1CB86B
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 21:38:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgEHTi6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 15:38:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbgEHTi6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 8 May 2020 15:38:58 -0400
Received: from embeddedor (unknown [189.207.59.248])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A4DC20725;
        Fri,  8 May 2020 19:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588966737;
        bh=TVF1tf6NxsU/ettA9htZ19+xz7qF2EXHonAMXoKKwVE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fEUa2hpQEVZ/5oNp1fr5qsCBw8GHgtMEJvhk+5/bCZYLMkOiF7tcXsTfELHccv7bK
         gaBqJ8v8aRf2VzYARtx9NSsWuSkEQtr52uc4DiUh/tLlhaQaM4jx9XCFmRcC867Uvh
         P8onb0BGagZbzRt//WbMxOJknZofArfkbeEQOkaw=
Date:   Fri, 8 May 2020 14:43:25 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] PCI: Replace zero-length array with flexible-array
Message-ID: <20200508194325.GD23375@embeddedor>
References: <20200507190544.GA15633@embeddedor>
 <20200507201544.GA23633@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200507201544.GA23633@bjorn-Precision-5520>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, May 07, 2020 at 03:15:44PM -0500, Bjorn Helgaas wrote:
> On Thu, May 07, 2020 at 02:05:44PM -0500, Gustavo A. R. Silva wrote:
> > The current codebase makes use of the zero-length array language
> > extension to the C90 standard, but the preferred mechanism to declare
> > variable-length types such as these ones is a flexible array member[1][2],
> > introduced in C99:
> > 
> > struct foo {
> >         int stuff;
> >         struct boo array[];
> > };
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied to pci/misc for v5.8, thanks!
> 
> I assume this takes care of everything in drivers/pci/, right?  I'd
> like to do them all at once, so if there are others, send another
> patch and I'll squash them.  I took a quick look but didn't see any.
> 

Yep. I can confirm that these are the last zero-length arrays in
drivers/pci/ :)

Thanks
--
Gustavo
