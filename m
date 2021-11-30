Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09434463AEA
	for <lists+linux-pci@lfdr.de>; Tue, 30 Nov 2021 17:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbhK3QHD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 30 Nov 2021 11:07:03 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:56252 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbhK3QHC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 Nov 2021 11:07:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1A03ECE1410;
        Tue, 30 Nov 2021 16:03:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2398C53FC7;
        Tue, 30 Nov 2021 16:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638288220;
        bh=tK9LCxQALG+XYMfehzdMiewK02vT2wEJJjF+v9T3HCs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=IOr3RAEWSfHqvq/PrjBge2DDC3vR5Su23evbXIaXf4kRwUxGFSj5LoZ0otmQkmM+G
         7qX/ewmErJNnHmPj1mdSoBppPzX1QV5k1kxB/7+gnOADYajFu/wUxhuQUq6sFMVQci
         upiltg9llpLNe1HwF2oTunW+cWWiGnmW3yUwmu8BS8MU5j2TjrwWdGccmMEQGgzRKo
         QRO/CFAuae8boOHr2rwI1k0jvX0Znfe4XWdaWzpaSXCoJra6FApxUudtboKtc3ETTF
         IUJOWSBH3puHQbjz2nkiKFPpshtOCIAVIamBU5kE7LaSfY8OlKV+cAynjHZbxD+kCm
         gCovLG3cMvCbg==
Date:   Tue, 30 Nov 2021 10:03:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        svarbanov@mm-sol.com, bjorn.andersson@linaro.org, robh@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Sven Peter <sven@svenpeter.dev>
Subject: Re: [PATCH] PCI: qcom: Fix warning generated due to the incorrect
 data type
Message-ID: <20211130160338.GA2739234@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211130062137.GD205712@thinkpad>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Marc, Alyssa, Sven for RID-to-SID mapping insight.  The patch at
https://lore.kernel.org/all/20211130062137.GD205712@thinkpad/ merely
fixes a warning.  My meta-question is about the qcom BDF-to-SID
mapping.]

On Tue, Nov 30, 2021 at 11:51:37AM +0530, Manivannan Sadhasivam wrote:
> On Mon, Nov 29, 2021 at 09:36:14PM -0600, Bjorn Helgaas wrote:
> > ...
> > I'm also curious why pcie-qcom.c is the only driver that does this.
> > "iommu-map" is not specific to qcom, but no other drivers do similar
> > things with it.
> 
> Yes, on the recent qcom platforms starting from sm8250 we need to program
> the BDF to SID mapping in the controller and that's the reason we are
> extracting the "iommu-map" property in DT.

This sounds like something that may not really be specific to sm8250.

It looks vaguely similar to apple_pcie_add_device().  Compare the qcom
code at [1] with the Apple code at [2].

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/controller/dwc/pcie-qcom.c?id=v5.16-rc1#n1308
[2] https://git.kernel.org/linus/468c8d52c332

> > > sparse warnings: (new ones prefixed by >>)
> > > >> drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse: sparse: incorrect type in initializer (different base types) @@     expected unsigned short [usertype] bdf_be @@     got restricted __be16 [usertype] @@
> > >    drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse:     expected unsigned short [usertype] bdf_be
> > >    drivers/pci/controller/dwc/pcie-qcom.c:1305:30: sparse:     got restricted __be16 [usertype]
> > > 
> > > Reported-by: kernel test robot <lkp@intel.com>
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > > index 8a7a300163e5..6c3b034e9946 100644
> > > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > > @@ -1312,7 +1312,7 @@ static int qcom_pcie_config_sid_sm8250(struct qcom_pcie *pcie)
> > >  
> > >  	/* Look for an available entry to hold the mapping */
> > >  	for (i = 0; i < nr_map; i++) {
> > > -		u16 bdf_be = cpu_to_be16(map[i].bdf);
> > > +		__be16 bdf_be = cpu_to_be16(map[i].bdf);
> > >  		u32 val;
> > >  		u8 hash;
> > >  
> > > -- 
> > > 2.25.1
> > > 
