Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8097121562D
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jul 2020 13:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728697AbgGFLRO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jul 2020 07:17:14 -0400
Received: from foss.arm.com ([217.140.110.172]:58752 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728578AbgGFLRN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 6 Jul 2020 07:17:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 30A40C0A;
        Mon,  6 Jul 2020 04:17:12 -0700 (PDT)
Received: from e121166-lin.cambridge.arm.com (e121166-lin.cambridge.arm.com [10.1.196.255])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 31A3F3F68F;
        Mon,  6 Jul 2020 04:17:11 -0700 (PDT)
Date:   Mon, 6 Jul 2020 12:17:08 +0100
From:   Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To:     Sriram Dash <sriram.dash@samsung.com>
Cc:     'Kishon Vijay Abraham I' <kishon@ti.com>,
        'Shradha Todi' <shradha.t@samsung.com>, bhelgaas@google.com,
        pankaj.dubey@samsung.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: endpoint: Fix NULL pointer dereference for
 ->get_features()
Message-ID: <20200706111708.GF26377@e121166-lin.cambridge.arm.com>
References: <CGME20200311103443epcas5p2e97b8f3a8e52dc6f02eb551e0c97f132@epcas5p2.samsung.com>
 <20200311102852.5207-1-shradha.t@samsung.com>
 <000d01d5fdf3$55d43af0$017cb0d0$@samsung.com>
 <a7a6a295-160a-94d6-09f9-63f783c8b28a@ti.com>
 <000001d608fb$7ab39010$701ab030$@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000001d608fb$7ab39010$701ab030$@samsung.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 02, 2020 at 08:01:59PM +0530, Sriram Dash wrote:

[...]

> > So the patch itself is correct though the commit log has to be fixed. You should
> > also check if all the endpoint controller drivers existing currently provides
> > epc_features.
> 
> At the moment, there is no issue for existing controller drivers as I
> can see almost all drivers are providing epc_features. But, this is
> not a mandatory feature and some controller drivers may not have
> epc_features implemented, may be in the near future.  But because we
> are dealing with the configfs, the application need not bother about
> the driver details underneath.
> 
> IMO, the code should be fixed regardless and should not cause panic in
> any case.

What's this patch status please ?

Thanks,
Lorenzo

> > Thanks
> > Kishon
> > >
> > >
> > >>  drivers/pci/endpoint/functions/pci-epf-test.c | 15 +++++++++------
> > >>  1 file changed, 9 insertions(+), 6 deletions(-)
> > >>
> > >> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c
> > >> b/drivers/pci/endpoint/functions/pci-epf-test.c
> > >> index c9121b1b9fa9..af4537a487bf 100644
> > >> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> > >> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> > >> @@ -510,14 +510,17 @@ static int pci_epf_test_bind(struct pci_epf *epf)
> > >>  		return -EINVAL;
> > >>
> > >>  	epc_features = pci_epc_get_features(epc, epf->func_no);
> > >> -	if (epc_features) {
> > >> -		linkup_notifier = epc_features->linkup_notifier;
> > >> -		msix_capable = epc_features->msix_capable;
> > >> -		msi_capable = epc_features->msi_capable;
> > >> -		test_reg_bar = pci_epc_get_first_free_bar(epc_features);
> > >> -		pci_epf_configure_bar(epf, epc_features);
> > >> +	if (!epc_features) {
> > >> +		dev_err(dev, "epc_features not implemented\n");
> > >> +		return -ENOTSUPP;
> > >>  	}
> > >>
> > >> +	linkup_notifier = epc_features->linkup_notifier;
> > >> +	msix_capable = epc_features->msix_capable;
> > >> +	msi_capable = epc_features->msi_capable;
> > >> +	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
> > >> +	pci_epf_configure_bar(epf, epc_features);
> > >> +
> > >>  	epf_test->test_reg_bar = test_reg_bar;
> > >>  	epf_test->epc_features = epc_features;
> > >>
> > >> --
> > >> 2.17.1
> > >
> > >
> 
