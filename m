Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F78C21A4CC
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jul 2020 18:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgGIQ3I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jul 2020 12:29:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:33504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726408AbgGIQ3I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jul 2020 12:29:08 -0400
Received: from embeddedor (unknown [201.162.245.14])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C92CF207DD;
        Thu,  9 Jul 2020 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594312147;
        bh=XsNuitHhYM6kMfGhX8xkC5TqV/m57YXn+6jH4L6J7Wg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VSfq34mXjHIJ5J+MRKVlVMD/rNadsDoRRVEfmuarRfT/77teZlxjfpDZ5iDaiF1LG
         JOv8e19APo9W1WHPM9GsQLZyDSC8L7EzLnZ4s+A68fraxhB6NNrEbktv+eglRnp8Xl
         TblsrchtjiecSYFMp6gubyCEqWif+SGUWooRV6K0=
Date:   Thu, 9 Jul 2020 11:34:38 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] ACPI: Use fallthrough pseudo-keyword
Message-ID: <20200709163438.GD15020@embeddedor>
References: <20200707200937.GA5056@embeddedor>
 <CAJZ5v0jv-or+gTy2u4hS3Zv6T6XwEqXuifygy5ZoXe8mMEZzbw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jv-or+gTy2u4hS3Zv6T6XwEqXuifygy5ZoXe8mMEZzbw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jul 09, 2020 at 02:10:41PM +0200, Rafael J. Wysocki wrote:
> On Tue, Jul 7, 2020 at 10:04 PM Gustavo A. R. Silva
> <gustavoars@kernel.org> wrote:
> >
> > Replace the existing /* fall through */ comments and its variants with
> > the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
> > fall-through markings when it is the case.
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through
> >
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> 
> Applied as 5.9 material, thanks!
> 

Thanks, Rafael.

--
Gustavo

