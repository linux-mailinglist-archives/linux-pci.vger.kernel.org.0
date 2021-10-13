Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EEF742C90C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Oct 2021 20:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233182AbhJMSus (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 13 Oct 2021 14:50:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:40820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238777AbhJMSup (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 13 Oct 2021 14:50:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3E79F61130;
        Wed, 13 Oct 2021 18:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634150921;
        bh=ivRTxznM3B+fLvy1toNw8cZLjifCIQrQ1rDrS3ccI+E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=V453JicKZcGYgPq4fByKU5Dgtrq5jUXh+7vhrVI8shrdvlfkJKoNKblJKvKgrd08a
         gubNLdEfDffLiChOeFrQT64/4hUjpg4Pq5RvNbSdxI9DA3nf7TbY93m86TsDUQ0rQa
         rFfT4zoG0+g5iVkh2FgXV4QaJw2mchBDfAsVGEIDsuuDeky+mMo/KrpU0BIu1utqFj
         DLqRehcWdR1HaKSZBdHH6sdY2g1wyHn6WuCKbhw8dFBq5JVThnPDmzjTDXSqyW1c00
         eMXdgTMGayyRkD33tZy9iYHEzqQNMtNSO65uAasyPcjy1VVv/oOkOYwSoqMdWs/rij
         yBMNddXiJlFwg==
Date:   Wed, 13 Oct 2021 13:48:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        PCI <linux-pci@vger.kernel.org>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH 02/22] PCI: Unify PCI error response checking
Message-ID: <20211013184839.GA1909162@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211013171653.zx4sxdzhvy2ujytd@theprophet>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 13, 2021 at 10:46:53PM +0530, Naveen Naidu wrote:

> 2. "Rework any callers expecting a positive return value"
>    
>    This means, find out the places where we have something like 
>      
>      err = pci_read_config_dword();
>         if (err > 0)
> 
>    Then change it to:
> 
>      err = pci_read_config_dword(pdev, PCI_REG_NPKDSC, &npkdsc);
>         if (err != PCIBIOS_SUCCESSFUL)

I'm sure this is obvious, but I would try hard not to add any new uses
of PCIBIOS_SUCCESSFUL.

>    Is there any easy way to search for these patterns, or should I look
>    for each instance of pci_read_config_* and other such variants and
>    see if such an case exists?

coccigrep might be able to find things like this, but I'ver never
really become friends with it.
