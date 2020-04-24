Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065181B7909
	for <lists+linux-pci@lfdr.de>; Fri, 24 Apr 2020 17:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbgDXPMX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Apr 2020 11:12:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:47160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727031AbgDXPMW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 24 Apr 2020 11:12:22 -0400
Received: from localhost (mobile-166-175-187-210.mycingular.net [166.175.187.210])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EE5420706;
        Fri, 24 Apr 2020 15:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587741142;
        bh=MbYJoEzGEEYggyHpPkfeAlaxFRhTCDvhL5ee+mbH470=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=i08Yn6erJadjQDSk7dqB8l/XgWmDFdlAfFqtq5wU7kUWod8m15qw3SnMyGLfcR0iC
         r2cah8DykcNVQKlGtLNfjOIZSnUBUGL6xPKTTZbgC5hdfgrK6HAdDiwSYE/aB1taAD
         9RayJaz7gU458gRp16uQtBIE28k0QLqgbqTVP1jo=
Date:   Fri, 24 Apr 2020 10:12:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     Saheed Bolarinwa <refactormyself@gmail.com>, bjorn@helgaas.com,
        skhan@linuxfoundation.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH RFC] pci: Make return value of pcie_capability_read*()
 consistent
Message-ID: <20200424151220.GA134293@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d80f8d9e-0676-5661-6031-39fe4460b66c@hisilicon.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Apr 24, 2020 at 05:11:44PM +0800, Yicong Yang wrote:
> On 2020/4/24 14:02, Saheed Bolarinwa wrote:
> > On 4/24/20 12:38 AM, Bjorn Helgaas wrote:
> >> On Thu, Apr 23, 2020 at 07:55:17PM +0800, Yicong Yang wrote:

> >>> BTW, pci_{read, write}_config_*() may also have the issues that
> >>> export the private err code outside. You may want to solve these in
> >>> a series along with this patch.
> >>
> >> If you see a specific issue, please point it out.
> 
> arch/x86/platform/intel/iosf_mbi.c, iosf_mbi_pci_read_mdr():
>         result = pci_read_config_dword(mbi_pdev, MBI_MDR_OFFSET, mdr);
>         if (result < 0)
>             goto fail_read;
>         return 0;
>     fail_read:
>         dev_err(&mbi_pdev->dev, "PCI config access failed with %d\n", result);
>         return result;

This is a problem in the caller, not in pci_read_config*().  This
caller is definitely broken, but fixing it is material for other
patches, not the current effort to align pcie_capability_read*() and
pci_read_config*().

> >> I looked at pci_read_config_word(), and it can return
> >> PCIBIOS_DEVICE_NOT_FOUND, PCIBIOS_BAD_REGISTER_NUMBER, or the return
> >> value from bus->ops->read().
> >>
> >> I looked at all the users of PCIBIOS_*.  There's really no interesting
> >> use of any of them except by pcibios_err_to_errno() and
> >> xen_pcibios_err_to_errno(), so I'm not sure it's even worth keeping
> >> them.
> 
> maybe we can mark them as deprecated. I can send a RFC one to do so.

Let's put this on a list for later.  I want to make sure this first
effort is successful before throwing more stuff into the mix.

Bjorn
