Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2A1EEE534
	for <lists+linux-pci@lfdr.de>; Mon,  4 Nov 2019 17:53:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729006AbfKDQxC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 Nov 2019 11:53:02 -0500
Received: from foss.arm.com ([217.140.110.172]:47228 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728705AbfKDQxC (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 4 Nov 2019 11:53:02 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B687468D;
        Mon,  4 Nov 2019 08:53:01 -0800 (PST)
Received: from e121166-lin.cambridge.arm.com (unknown [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 45F443F71A;
        Mon,  4 Nov 2019 08:53:00 -0800 (PST)
Date:   Mon, 4 Nov 2019 16:52:55 +0000
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     Sinan Kaya <okaya@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, bhelgaas@google.com,
        Thierry Reding <treding@nvidia.com>, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, linux-pci@vger.kernel.org,
        kthota@nvidia.com, mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Message-ID: <20191104165255.GA26409@e121166-lin.cambridge.arm.com>
References: <20191005182129.32538-1-vidyas@nvidia.com>
 <20191014082023.GA232162@ulmo>
 <ce411d27-5b92-8dae-fccd-73c63aa30f1c@kernel.org>
 <20191015093053.GA5778@ulmo>
 <4953b718-8818-575e-2ec1-8197e6b32593@kernel.org>
 <85267afb-c08e-5625-d3ee-bd32af9ecb12@nvidia.com>
 <afa16546-e63d-6eba-8be0-8e52339cd100@nvidia.com>
 <aed391af-f54c-c25e-43b9-ed9db01bd3cf@nvidia.com>
 <4424cd45-e441-0d8d-548e-5c025f48bb03@kernel.org>
 <065d1b8a-29e1-9282-27ba-5512f9f4f1d4@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <065d1b8a-29e1-9282-27ba-5512f9f4f1d4@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 04, 2019 at 05:13:50PM +0530, Vidya Sagar wrote:
> On 10/26/2019 7:29 PM, Sinan Kaya wrote:
> > On 10/25/2019 7:58 AM, Vidya Sagar wrote:
> > > On 10/21/2019 11:13 AM, Vidya Sagar wrote:
> > > 
> > > Hi Sinan / Rafael,
> > > Apologies for the ping again.
> > > Do you guys have any further comments on this?
> > > 
> > > -Vidya Sagar
> > 
> > I think you'll need some attention from Bjorn here to see the complete
> > picture.
> > 
> > As I said, changing pci_device_is_present() is not right. This needs to
> > be done at one level higher.
> 
> Hi Bjorn,
> Could you please help me understand why this change can't be done in
> pci_device_is_present() API?

I assume that's because pci_device_is_present() is currently called
in contexts that aren't allowed to sleep, therefore you would trigger
a regression.

Lorenzo
