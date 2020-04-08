Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6A341A2B63
	for <lists+linux-pci@lfdr.de>; Wed,  8 Apr 2020 23:47:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgDHVrt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Apr 2020 17:47:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:50394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgDHVrt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 8 Apr 2020 17:47:49 -0400
Received: from localhost (mobile-166-175-188-68.mycingular.net [166.175.188.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0CF02074F;
        Wed,  8 Apr 2020 21:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586382469;
        bh=NnShytSGeCEQechGUCI/Zae9u/PmtXA1+7fWrnwX/3Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=qV2EplEsNKg8oY/wLKvp1Uh5lgHp4qsVg2s3dXExzmSP+BMM9MARAN+69VTFHzK3B
         1PJyLNNCZw8WQatnFja4VYE065T9iroyg93ZPv2LiyWCXzmGs7Vrn713iLgRgTDDsH
         UsIEg+u1mxNamiBGaFxdfjN13mpOQLmUnFV7+MZo=
Date:   Wed, 8 Apr 2020 16:47:47 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     mj@ucw.cz, linux-pci@vger.kernel.org
Subject: Re: [RFC Patch 1/1] lspci: Add basic decode support for Compute
 eXpress Link
Message-ID: <20200408214747.GA129363@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1766804A-54D2-4977-975A-9E9F29EFC155@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 08, 2020 at 02:12:45PM -0700, Sean V Kelley wrote:
> On 8 Apr 2020, at 9:56, Bjorn Helgaas wrote:
> > On Tue, Apr 07, 2020 at 05:09:59PM -0700, Sean V Kelley wrote:

> > > +#define PCI_EVNDR_CXL_ID	0
> > 
> > Unused in this patch.  Is this the DVSEC Vendor ID as described in
> > PCIe r5.0, sec 7.9.6.2?  Is 0 really the ID assigned for CXL?
> 
> It is as described in the PCIe Spec.  The DVSEC ID is set to 0x0 here to
> advertise that this is a Flex Bus feature capability structure. It’s
> assigned in table 58 “PCI Express DVSEC Register Settings for Flex Bus
> Device” of the CXL 1.1 spec.

It sounds like it's the "DVSEC ID" (not the "DVSEC Vendor ID") that is
zero.  That would make sense to me because the "DVSEC ID" is
completely under vendor control.

I would expect the "DVSEC Vendor ID" to be assigned by the PCI-SIG,
and I would be surprised if they assigned zero to CXL.

So I assume you'll eventually #define both IDs here and I won't be
confused any more :)

Thanks for proactively working on this support in lspci!

Bjorn
