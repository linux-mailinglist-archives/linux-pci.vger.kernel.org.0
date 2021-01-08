Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAD392EEAA8
	for <lists+linux-pci@lfdr.de>; Fri,  8 Jan 2021 02:06:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbhAHBC3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 20:02:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:35756 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729465AbhAHBC2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 20:02:28 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 333DC2076E;
        Fri,  8 Jan 2021 01:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610067708;
        bh=NKUggXfpZoH7IqHHRR5QWltRsKDmLmNJObXFp2AwbFo=;
        h=Date:From:To:Subject:In-Reply-To:From;
        b=VuCwcsfw4hNEoFWpQvShhDEdJOP2jxhdhRXxpy+okQ8igZXRURzvPk7SOFL7A7//E
         DoBxvwAdQCRQJnaLkozQTHr9H0OiP5VD0DN69mPRGFCyJn0TqTaeKVZ4dBdvhIQTXF
         m8rF8geu//PDwVYhistGUA8bmxYpyX2piyyIHgG8AAbzgRmelSlCKPrQCpm2qqsbmv
         rBO0UwdUcsZ2e3rXwhc1cO4VzXFv0OK1D2aEFMck7aYJDlJigQxVPbn+MdzFJ4un6F
         9+kOKQkSJ8yfsUJhrD3TmkwUQWbuUQvwqgVTS0z0iRnh1xTGPcQs0ShxkqSdyHFgLv
         uVA7SQjfnstEg==
Date:   Thu, 7 Jan 2021 19:01:47 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     nirmoy.das@amd.com, bhelgaas@google.com,
        ckoenig.leichtzumerken@gmail.com, linux-pci@vger.kernel.org,
        christian.koenig@amd.com, devspam@moreofthesa.me.uk,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 2/4] PCI: Add pci_rebar_bytes_to_size()
Message-ID: <20210108010147.GA1406822@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58F0BFBCD0%devspam@moreofthesa.me.uk>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 07, 2021 at 11:31:36PM +0000, Darren Salt wrote:
> I demand that Bjorn Helgaas may or may not have written...

?

> >> +static inline int pci_rebar_bytes_to_size(u64 bytes)
> >> +{
> >> +	bytes = roundup_pow_of_two(bytes);
> >> +	return max(ilog2(bytes), 20) - 20;
> 
> > This isn't returning a "size", is it?  It looks like it's returning the
> > log2 of the number of MB the BAR will be, i.e., the encoding used by the
> > Resizable BAR Control register "BAR Size" field.  Needs a brief comment to
> > that effect and/or a different function name.
> 
> Given that, it seems to me that pci_rebar_size_to_bytes should be similarly
> commented and/or renamed.

Makes sense.  Something like this is sufficient:

  return 1ULL << (size + 20);  /* Convert PCI_REBAR_CTRL "BAR Size" */
