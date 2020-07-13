Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C113921E1D3
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 23:02:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgGMVCm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 17:02:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgGMVCm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 17:02:42 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E9FE92083B;
        Mon, 13 Jul 2020 21:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594674162;
        bh=8x0Tpf6iI5PqmLcY/XaeypajZdv42jkioD+NSonLSLg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aGPRHRGgLCy1uyNADvnJHEfPevONoGJiicslm5eeFK3uB2Fp4O/Uvb4GHReKkXti6
         RAId2vUFIK76/O91AoTFZ+to7uffY1O7BRcX6l3iIKiJeT1VCSSS07+oUUYXEMpuyV
         zqYqUlMD5t4Hl8LKiUtaujxOLA5mlBY/+IwoOuBQ=
Date:   Mon, 13 Jul 2020 16:02:40 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v1 2/2] x86/PCI: Describe @reg for type1_access_ok()
Message-ID: <20200713210240.GA273404@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713200338.GF3703480@smile.fi.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jul 13, 2020 at 11:03:38PM +0300, Andy Shevchenko wrote:
> On Mon, Jul 13, 2020 at 02:59:07PM -0500, Bjorn Helgaas wrote:
> > On Mon, Jul 13, 2020 at 10:44:37PM +0300, Andy Shevchenko wrote:
> > > Describe missed parameter in documentation of type1_access_ok().
> > > Otherwise we get the following warning:
> > 
> > Would you mind including the "make" invocation that runs this
> > checking?  I assume it's something like "make C=2
> > arch/x86/pci/intel_mid_pci.o"?
> 
> No, it is not sparse, it's a kernel doc validation.
> I guess `make W=1` does it, but I can repeat my command line publicly again :-)
> 	make W=1 C=1 CF=-D__CHECK_ENDIAN__ -j64

Thanks.  "make W=1 arch/x86/pci/" is enough.  I would just put this in
the commit log, e.g.,

  Otherwise "make W=1 arch/x86/pci/" produces the following warning:

    CHECK   arch/x86/pci/intel_mid_pci.c
    CC      arch/x86/pci/intel_mid_pci.o
    arch/x86/pci/intel_mid_pci.c:152: warning: Function parameter or member 'reg' not described in 'type1_access_ok'
