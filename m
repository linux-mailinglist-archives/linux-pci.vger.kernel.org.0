Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B11752E9FD2
	for <lists+linux-pci@lfdr.de>; Mon,  4 Jan 2021 23:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726098AbhADWGM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Jan 2021 17:06:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:43870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726074AbhADWGM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Jan 2021 17:06:12 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90FF122512;
        Mon,  4 Jan 2021 22:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609797931;
        bh=o2e3lHYsBlwQsIkH4kAmMT3Ep04Jl03o9r2XRNIe9xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lJTdw/ryNIIFz07P3NfsLU4tHDlRMBe6HGqyWJoUxuIl6RjzKcIn2/SJWqE3oDsiR
         c53arsS4eDIFwQVLVRQSpxGKejQxTUujhr7ZV6gtlRGRo/q3S/F96J10uGD9LaoBO2
         zJtjdQ8kcJUTVrA5g5DIcaTpFO+s2yD6dYRsONVLuJB5Jfaj/BH936hT8M/hA//9Ko
         3XJSAyX3ZZ8Vc82lI68tnNEAbbXr3v3bSmp/WGmJk9yypbImVaRqFUTDi84umHU5w7
         ZMLHy3huNrh+Pifn8YOfxIGm/0cZlzd/9eXCyB2X6dNFr9b8j3MzZIutoe1IZ6F8+Z
         gNw55Q4US8c0Q==
Date:   Mon, 4 Jan 2021 14:05:29 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     "Kelley, Sean V" <sean.v.kelley@intel.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] PCI/AER: Actually get the root port
Message-ID: <20210104220529.GF1024941@dhcp-10-100-145-180.wdc.com>
References: <20201217171431.502030-1-kbusch@kernel.org>
 <20201217171431.502030-2-kbusch@kernel.org>
 <F5E3C1CC-4420-4EA2-9770-8AEBDE0CEACA@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <F5E3C1CC-4420-4EA2-9770-8AEBDE0CEACA@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 04, 2021 at 06:42:58PM +0000, Kelley, Sean V wrote:
> > On Dec 17, 2020, at 9:14 AM, Keith Busch <kbusch@kernel.org> wrote:
> > 		rc = pci_bus_error_reset(dev);
> > -		pci_info(dev, "Root Port link has been reset (%d)\n", rc);
> > +		pci_info(dev, "%s Port link has been reset (%d)\n", rc,
> 
> Perhaps … "%s%s Port

I am not sure I understand. What should the second string in this format
say?

I have to resend this patch anyway because I messed up the parmeter
order and build bot caught me. I'll split it out from this patch since
it is really a separate issue.
 
 
> > +			pci_is_root_bus(dev->bus) ? "Root" : "Downstream");
