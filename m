Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A394198D2
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbhI0QZ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Sep 2021 12:25:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:41774 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235338AbhI0QZ1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Sep 2021 12:25:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6806161058;
        Mon, 27 Sep 2021 16:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632759829;
        bh=ahbLyZ8Wv5gvxyTSBNy6NXQAnOFTP57heCOScjz9m8I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=hTkybTtCve3N/NOAkASYAmrf0pxHRVSX9uIBlvrWeo3qQ01O30yCvXfCbfXXYHDiC
         avWfGXzY8Squww313qv1uvj6Z5P5Xf0nzBijyK3CFXA8fW8WGFb/3DLGrdNAVdyWWn
         yd2Zi9vLtaGfS1BaigLTKRWnaVyvvzrcQziDFFuqnViqfSEbBhSKXfaeeFgw1RFecX
         OTI5jZof+bBHXM4fguZsTLVE2MtPIufg5CPdCpIGh9lcaNBfC1BAtCS/4LkxtI4Syj
         Hc6tEeemjDsYUihr1ClsWwIdbdX0PF8/BnXSjAFhunmwoPVJO0FqENYiWUjnzY3/Xr
         1Ua02QS+pvb6A==
Date:   Mon, 27 Sep 2021 11:23:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: aardvark: Implement re-issuing config requests on
 CRS response
Message-ID: <20210927162348.GA650225@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210926111319.sgtfsjovkhfkh4qs@pali>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Sep 26, 2021 at 01:13:19PM +0200, Pali Rohár wrote:
> On Wednesday 22 September 2021 11:48:03 Bjorn Helgaas wrote:

> > The config read of Vendor ID after a reset should be done by the PCI
> > core, not a device driver.
> 
> Of course. But in case of unexpected reset (which PCI code does not
> detect), card driver at the same time could issue some config read/write
> request.

By "unexpected reset", you mean a reset performed autonomously by the
device, or a reset initiated by the driver without help from the PCI
core?  Either way, I think the PCI core is pretty much out of the
picture and the driver is on its own.

> > If we disable CRS SV, the only outcomes of
> > that read are:
> > 
> >   1) Valid Vendor ID data, or
> > 
> >   2) Failed transaction, typically reported as 0xffff data (and, I
> >      expect, an Unsupported Request or similar error logged)
> 
> Yes. And I think it should apply also for any other config register, not
> just vendor id.

Yes.

> In case error reporting or AER functionality is not supported then there
> would be no error logged. And PCI core / kernel does not have to know
> that such thing happened.

There *should* be at least the logging in Device Status for all PCIe
devices, though I'm not sure the PCI core handles that nicely.  I'm
looking at PCIe r5.0, sec 6.2.5: https://imgur.com/a/0yqygiM

Bjorn
