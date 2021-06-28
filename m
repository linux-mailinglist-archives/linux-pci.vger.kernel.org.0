Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4F6D3B5CF2
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jun 2021 13:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhF1LLf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Jun 2021 07:11:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:37522 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232781AbhF1LLe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 28 Jun 2021 07:11:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A96CD61C71;
        Mon, 28 Jun 2021 11:09:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1624878549;
        bh=uImDlloM2fNLspP3AHGBmgdXtW6ZmXKHVCV5VoFsTvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GNwcP18fpQnUYTve6gyZxClZ6rIOrzNKbiZAKbuhRF03fneFzRy8O2f/xDCC472Qy
         E2JKbvZmL0nU/h77Z5B7JyiqefEWWtNV0e7U/m1pTn5ZMzAFOOhmA4w2uyE2p7s60n
         dj1m1DO11jyZrNkuB/fD8yvbC3DkW5EARSxqYZ4g=
Date:   Mon, 28 Jun 2021 13:09:06 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Krzysztof Wilczy??ski <kw@linux.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Kees Cook <keescook@chromium.org>,
        Pali Roh??r <pali@kernel.org>,
        Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/2] PCI/sysfs: Pass iomem_get_mapping() as a function
 pointer
Message-ID: <YNmt0gkonSbCXxus@kroah.com>
References: <20210625233118.2814915-1-kw@linux.com>
 <20210625233118.2814915-3-kw@linux.com>
 <YNmhVQzj4fdgVPf0@infradead.org>
 <20210628102453.GA139153@rocinante>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210628102453.GA139153@rocinante>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 28, 2021 at 12:24:53PM +0200, Krzysztof Wilczy??ski wrote:
> Hi Christoph,
> 
> > Doesn't this need to be merged into the previous patch to prevent
> > a compile failure after just the previous patch is applied?
> 
> Yes, it does.  I kept it separate for the sake of review, since we have
> sysfs and PCI involved.  I wasn't sure if Bjorn would prefer to have
> this done as separate patches or not, to be honest.
> 
> Bjorn said that he can squash this when applying, thus I left it as-is
> for now - which means that the entire series has to be applied for
> everything to build cleanly.
> 
> I will send v3 that merges first two patches.  Sorry for troubles!

This all needs to wait until after 5.14-rc1 is out anyway, so no rush.

greg k-h
