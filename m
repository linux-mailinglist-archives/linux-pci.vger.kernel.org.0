Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69A4A34C2BC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 07:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbhC2FDn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 01:03:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:55166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhC2FD2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Mar 2021 01:03:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 83E7F6193C;
        Mon, 29 Mar 2021 05:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1616994208;
        bh=kQHa25Re0VmMnnSYwE0WwlnZwlFjdDOzl4IYFbWowLQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VOK9FatGGORZpQKEKjeOEN8ZSdOvAa1J8Go49aroLSC4yh50fHNbdsU6KQs5pbPn9
         FOcEkPAGkZi/LoEkmSDrcnM+rRlWfZJC8uZ665/fmQBDEv8jMxEVug7tKJMokvrV3D
         2lDVJUtC+ZAsCcVLxn5v/AArEswJymEZu73LENcw=
Date:   Mon, 29 Mar 2021 07:03:25 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Subject: Re: [PATCH v7 1/5] misc: Add Synopsys DesignWare xData IP driver
Message-ID: <YGFfnX1bDrJ/eAO9@kroah.com>
References: <cover.1616814273.git.gustavo.pimentel@synopsys.com>
 <726feba26faebc2620b36d57859aa526bef1c0b9.1616814273.git.gustavo.pimentel@synopsys.com>
 <YGB7SfmrJkLLoL3B@kroah.com>
 <DM5PR12MB18356331B588B123FC0E1F56DA7F9@DM5PR12MB1835.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM5PR12MB18356331B588B123FC0E1F56DA7F9@DM5PR12MB1835.namprd12.prod.outlook.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, Mar 28, 2021 at 09:06:47PM +0000, Gustavo Pimentel wrote:
> > > +static const struct pci_device_id dw_xdata_pcie_id_table[] = {
> > > +	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
> > 
> > Why do you need a pointer to snps_edda_data here?
> 
> The structure snps_edda_data indicates the location of this IP block (BAR 
> and offset) for this particular endpoint.
> It's very likely in the future to be more variants that for HW design 
> reasons might require this IP block to be on a different location.

Then make the change when that happens sometime in the future.  Don't
add unneeded complexity today, that just makes the code harder to review
by us now, and for you to maintain today.

thanks,

greg k-h
