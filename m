Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 529AE228BB8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jul 2020 23:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726658AbgGUVxv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 17:53:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:39212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726500AbgGUVxv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 17:53:51 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A8EA206E3;
        Tue, 21 Jul 2020 21:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595368430;
        bh=ZDwqctdzZPCgYeb9FKUOONTbrY61SI9ly9wrmqDQ7CI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ran8XxFk0BGzWstiAVzSe+D1GcR2EYs97nyaoe7VOOGry6aLJWY6HnzMtXV1vvzbT
         yoiBjXx+EW7nvymIN6AXki2z1MBI41nfYTadrzoQyzZByR5btWCKWZC0MqIF2HCdXp
         ZVLpngDujuRnwcLg38nP8ndCS6+nbAXGduUd6xJo=
Date:   Tue, 21 Jul 2020 16:53:48 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     linux-pci@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sean Kelley <sean.v.kelley@linux.intel.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linuxarm@huawei.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI/ERR: Rename pci_aer_clear_device_status() to
 pcie_clear_device_status()
Message-ID: <20200721215348.GA1160927@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cee203b-3ba9-3e42-0caa-92d12b9086fe@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Jul 17, 2020 at 01:20:22PM -0700, Kuppuswamy, Sathyanarayanan wrote:
> Hi Bjorn,
> 
> On 7/17/20 12:56 PM, Bjorn Helgaas wrote:
> > From: Bjorn Helgaas <bhelgaas@google.com>
> > 
> > pci_aer_clear_device_status() clears the error bits in the PCIe Device
> > Status Register (PCI_EXP_DEVSTA).  Every PCIe device has this register,
> > regardless of whether it supports AER.
>
> Since its not related to AER, can we move it out of AER driver ? May be
> to pci.c ?

OK.  pci.c is really a grab bag of random stuff, but it *is* true that
this doesn't really seem to belong in aer.c.

So I don't mind moving it to pci.c (does just before
pcie_clear_root_pme_status() seem like a reasonable spot?)

But looking at this again makes me wonder whether putting the
pcie_aer_is_native() test inside pcie_clear_device_status() is the
right thing.  It seems like that test fits better with the AER code,
i.e., in the *callers* of pcie_clear_device_status().

It would mean repeating the test, since we call it twice, but it seems
like it might match up with the spec better.  And I have a slight
aversion to functions that can silently return without doing what it
looks like they're supposed to do.

I can fix this all up if that seems right.  Or let me know if you have
alternate ideas.

Bjorn
