Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3CB84949B6
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 09:42:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiATImJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 03:42:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiATImH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 03:42:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E4C2C061574;
        Thu, 20 Jan 2022 00:42:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 28EAFB81CED;
        Thu, 20 Jan 2022 08:42:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A273C340E0;
        Thu, 20 Jan 2022 08:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1642668125;
        bh=SG6QumIZWuCm1rnscr1xgmVrF1po46c66KhmPwbceOw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rdM9KYSiWOHNTFIiRS7C9wuu6iu7pZSi9/BVWnv00dNlaTKwA9r8X8IztJT2malVu
         ZPSj18e2K9yRxpiOJCX0wSZ7b8FMBfmaDdDxZoum1IVwuZvk4yqvHkWWrVqN0HFayZ
         ZTHDYppZUpfxCAgjGx+QWkOH1gN/tDzf9oCsTaSI=
Date:   Thu, 20 Jan 2022 09:42:02 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Li Chen <lchen@ambarella.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [EXT] Re: [PATCH] misc: pci_endpoint_test: simplify endpoint
 test read and write operations
Message-ID: <YekgWmTSzCi2gTMs@kroah.com>
References: <SA1PR19MB5572EAD4025173FA9F3B3937A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
 <YekYAAHPEBeJflZN@kroah.com>
 <SA1PR19MB5572A56F07CC46A064330408A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
 <Yekahmtc0bsaUMhi@kroah.com>
 <SA1PR19MB5572D993FFC2EECDA89E5A66A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SA1PR19MB5572D993FFC2EECDA89E5A66A05A9@SA1PR19MB5572.namprd19.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 20, 2022 at 08:25:51AM +0000, Li Chen wrote:
> > -----Original Message-----
> > From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> > Sent: Thursday, January 20, 2022 4:17 PM
> > To: Li Chen
> > Cc: Kishon Vijay Abraham I; Lorenzo Pieralisi; Krzysztof Wilczyński; Arnd
> > Bergmann; Bjorn Helgaas; linux-pci@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: Re: [EXT] Re: [PATCH] misc: pci_endpoint_test: simplify endpoint test
> > read and write operations
> > 
> > On Thu, Jan 20, 2022 at 08:09:20AM +0000, Li Chen wrote:
> > > > -----Original Message-----
> > > > From: Greg Kroah-Hartman [mailto:gregkh@linuxfoundation.org]
> > > > Sent: Thursday, January 20, 2022 4:06 PM
> > > > To: Li Chen
> > > > Cc: Kishon Vijay Abraham I; Lorenzo Pieralisi; Krzysztof Wilczyński; Arnd
> > > > Bergmann; Bjorn Helgaas; linux-pci@vger.kernel.org; linux-
> > > > kernel@vger.kernel.org
> > > > Subject: [EXT] Re: [PATCH] misc: pci_endpoint_test: simplify endpoint test
> > read
> > > > and write operations
> > > >
> > > > On Thu, Jan 20, 2022 at 08:03:17AM +0000, Li Chen wrote:
> > > > >
> > > >
> > **************************************************************
> > > > ********
> > > > > This email and attachments contain Ambarella Proprietary and/or
> > Confidential
> > > > Information and is intended solely for the use of the individual(s) to whom it
> > is
> > > > addressed. Any unauthorized review, use, disclosure, distribute, copy, or
> > print is
> > > > prohibited. If you are not an intended recipient, please contact the sender by
> > > > reply email and destroy all copies of the original message. Thank you.
> > > >
> > > > Now deleted.
> > >
> > > Hi, Greg
> > >
> > > I'm sorry that I have no way to remove this message by myself.
> > 
> > Sorry, but patches/emails with that notice on it are not allowed to be
> > accepted for obvious reasons.  Please work with your company to fix
> > this.
> 
> Ok, thanks! So, should I resend this patch after fixing this self-attached message with my company?

As the original is not acceptable, yes, please do.
