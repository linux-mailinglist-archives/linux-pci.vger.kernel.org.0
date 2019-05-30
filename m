Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ABC02EAE5
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 05:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726308AbfE3DBm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 May 2019 23:01:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:40608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725821AbfE3DBl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 May 2019 23:01:41 -0400
Received: from localhost (15.sub-174-234-174.myvzw.com [174.234.174.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 092AA24450;
        Thu, 30 May 2019 03:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559185301;
        bh=xlqT1K7enlVKZFkAxENutch544Oi7NgY9tj2XmaoiWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I5+SJ2uqpNOjnl2C+mRPUPxSGXxyfjQ7/UwswpuCqSZLJkQqw1TJuTJCSsYsAzN20
         1gE6UZMcN4fgGmQfnZ/R5cK1l2+vedMmQ1+8YnuSNwbtpkRFh75+Fv8RILpzeivwmF
         vVE+nFxRchNor7LwweEqGZRFd7QNrTgygN0AXoXY=
Date:   Wed, 29 May 2019 22:01:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Changbin Du <changbin.du@gmail.com>, linux-pci@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab+samsung@kernel.org
Subject: Re: [PATCH v6 00/12] Include linux PCI docs into Sphinx TOC tree
Message-ID: <20190530030139.GI28250@google.com>
References: <20190514144734.19760-1-changbin.du@gmail.com>
 <20190520061014.qtq6tc366pnnqcio@mail.google.com>
 <20190529163510.3dd4dc2d@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529163510.3dd4dc2d@lwn.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 29, 2019 at 04:35:10PM -0600, Jonathan Corbet wrote:
> On Mon, 20 May 2019 06:10:15 +0000
> Changbin Du <changbin.du@gmail.com> wrote:
> 
> > Bjorn and Jonathan,
> > Could we consider to merge this serias now? Thanks.
> 
> Somewhat belatedly, but I think we could.  Bjorn, do you have a preference
> for which tree this goes through?  I don't remember if we'd come to an
> agreement on that or not, sorry...

Actually, let me at least take a look at these.  I noticed that
renames caused some of the ACPI docs to end up with lines >80 columns,
and I'd prefer to avoid that.  So maybe I'll take these after all if
that's OK.

Bjorn
