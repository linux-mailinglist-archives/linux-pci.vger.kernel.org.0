Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA2A926E2BE
	for <lists+linux-pci@lfdr.de>; Thu, 17 Sep 2020 19:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgIQRor (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Sep 2020 13:44:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:42394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726646AbgIQRnY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 17 Sep 2020 13:43:24 -0400
Received: from localhost (52.sub-72-107-123.myvzw.com [72.107.123.52])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ACE7420872;
        Thu, 17 Sep 2020 17:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1600364580;
        bh=pAUgZwKrVGAksvmMLVWJtj2umdA0bC7ccTmXsfdGHUs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=MzEv0DxV0UqUO3nJx7aPe5tQZ2VGDy6vEd8Q11BCSrM8msDIjD7+T7Lzb4rtDiYEs
         5CgXbVIbW7UDrIVtMZaPcoUb9Sy4jr02qYCL7SICUGN3qDe3wPCGStA65a0SRtXW+n
         kBrifFmawHjvMAc4vU5iuDHsv9jU0W8EZQ/nIPgE=
Date:   Thu, 17 Sep 2020 12:42:58 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Alexander Duyck <alexander.duyck@gmail.com>
Cc:     Liu Shixin <liushixin2@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Alexander Duyck <alexander.h.duyck@intel.com>
Subject: Re: [PATCH -next] PCI/IOV: use module_pci_driver to simplify the code
Message-ID: <20200917174258.GA1715659@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKgT0Uf=TmW0SKWROPcwAOdoaXvLn3t6_ynUtPVoH64bnCRTww@mail.gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 17, 2020 at 10:19:13AM -0700, Alexander Duyck wrote:
> On Thu, Sep 17, 2020 at 9:56 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > [+cc Alexander]
> >
> > On Thu, Sep 17, 2020 at 03:10:42PM +0800, Liu Shixin wrote:
> > > Use the module_pci_driver() macro to make the code simpler
> > > by eliminating module_init and module_exit calls.
> > >
> > > Signed-off-by: Liu Shixin <liushixin2@huawei.com>
> >
> > Applied to pci/misc for v5.10, thanks!
> 
> The code below seems pretty straight forward.
> 
> Acked-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>

Thanks a lot for taking a look, Alexander, I added your ack.
