Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3E86495391
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 18:54:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232400AbiATRy0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 12:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbiATRyZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 12:54:25 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F281AC061574
        for <linux-pci@vger.kernel.org>; Thu, 20 Jan 2022 09:54:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4478BCE213B
        for <linux-pci@vger.kernel.org>; Thu, 20 Jan 2022 17:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E76FCC340E0;
        Thu, 20 Jan 2022 17:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642701261;
        bh=hf05+WnLlVx/ittw/XUQFQXaAdJ0s8m7SrMEaTE38fM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=bK1xADaZJOLh0DoDwQ6R7FyquHV5MeCBl4a63iHf7vMbIosLUG5h22qmXCCq0BdmM
         KfVho+k5vpm3jSaGb5jpuIgcRfhTF7KPrs/BxIKmfv0e+7U1UbZsaqz0rGECWpoE3c
         yP7zHhLT/nV9cdOfpY0HeYrIUXSz9+kMNNWd7HJ/1z4HjCLSe4vgMe5rle88AbaNBy
         620+tKf1W1Rt3sHAuUiJ7GLBK6FOLy2J5dRCtCGQNRaqQVtLTAiKsYyMSN3ReQWJbX
         hy0NvDUTjUuwdnFMP+3hM5mPckPo+XzFV5WtzH7Q7qi5gEuVM0Kh7jawn3mWvsmV2H
         QyGGqlgBzrHbQ==
Date:   Thu, 20 Jan 2022 11:54:19 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Stefan Roese <sr@denx.de>
Cc:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
Subject: Re: [PATCH v3 2/2] PCI/AER: Enable AER on all PCIe devices
 supporting it
Message-ID: <20220120175419.GA1053838@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3dcb1639-3234-8c3c-28b4-3be0f66dc29e@denx.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jan 20, 2022 at 05:59:22PM +0100, Stefan Roese wrote:
> On 1/20/22 16:46, Bjorn Helgaas wrote:
> > On Thu, Jan 20, 2022 at 08:31:31AM +0100, Stefan Roese wrote:
> > > On 1/19/22 11:37, Pali Rohár wrote:
> > 
> > > > And when you opened this issue with hotplugging, another thing for
> > > > followup changes in future is calling pcie_set_ecrc_checking() function
> > > > to align ECRC state of newly hotplugged device with "pci=ecrc=..."
> > > > cmdline option. As currently it is done only at that function
> > > > set_device_error_reporting().
> > > 
> > > Agreed, this is another area to look into. Not sure if it's okay to
> > > address this, once this patch-set has been accepted (if it will be).
> > 
> > ECRC might be something that could be peeled off first to reduce the
> > complexity of AER itself.
> > 
> > The ECRC capability and enable bits are in the AER Capability, so I
> > think it should be moved to pci_aer_init() so it happens for every
> > device as we enumerate it.
> 
> Just that there is no misunderstanding: You are thinking about something
> like this:
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9fa1f97e5b27..5585fefc4d0e 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -387,6 +387,9 @@ void pci_aer_init(struct pci_dev *dev)
>         pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, sizeof(u32) *
> n);
> 
>         pci_aer_clear_status(dev);
> +
> +       /* Enable ECRC checking if enabled and configured */
> +       pcie_set_ecrc_checking(dev);
>  }
> 
>  void pci_aer_exit(struct pci_dev *dev)
> @@ -1223,9 +1226,6 @@ static int set_device_error_reporting(struct pci_dev
> *dev, void *data)
>                         pci_disable_pcie_error_reporting(dev);
>         }
> 
> -       if (enable)
> -               pcie_set_ecrc_checking(dev);
> -
>         return 0;
>  }
> 
> Perhaps as patch 1/3 in this patch series? Or as some completely
> separate patch?

Yes.  Probably as 1/3, since subsequent patches may depend on this
one, or at least may not apply cleanly without this one.

Bjorn
