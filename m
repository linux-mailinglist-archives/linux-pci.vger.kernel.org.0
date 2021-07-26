Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD683D6935
	for <lists+linux-pci@lfdr.de>; Tue, 27 Jul 2021 00:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233006AbhGZVYq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Jul 2021 17:24:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51978 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232876AbhGZVYq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Jul 2021 17:24:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0D3CB60F59;
        Mon, 26 Jul 2021 22:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627337114;
        bh=b5THSFkdyJL8D+0I+2LhwNffVY4VRO/Mrvt7jCTnVps=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=dBby/dSAOVXYr9SJxc5kEgycRLgxQrV8UXvI2ggfBXPehDGF8x23UZGlpVhb7tds7
         7E8of2d3WwlTlhhihyFfkJCJNsVOagR6dYqwUNrKjgyRwNRS4iGA+5nKd0eoV5CRyg
         C1fs0PjGanG/lWWW+fDu8c/91WnStM824vyClIxG1tuFX26rzrZHH5mlRW7MU0Hgf5
         AMQ0JyOj7L1wP0YlaWvrP8l/YTxmrj7+pUKMQSrQ2yNXftfvMpZOWqxGLAA+eC0zk9
         Q6BxfGb/WHfJQhzl2xdP2w/CLrQzCxWKtf2XvRfCVzlaG4LtFGCMC14tnp2iNRMfAo
         E0nZVnmuLfpfw==
Date:   Mon, 26 Jul 2021 17:05:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org,
        sathyanarayanan.kuppuswamy@linux.intel.com, kbusch@kernel.org,
        sean.v.kelley@intel.com, qiuxu.zhuo@intel.com,
        prime.zeng@huawei.com, linuxarm@openeuler.org
Subject: Re: [PATCH v2] PCI/DPC: Check host->native_dpc before enable dpc
 service
Message-ID: <20210726220512.GA648162@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ab7923c-c9d4-d864-86f0-743077e15d98@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Feb 24, 2021 at 05:47:58PM +0800, Yicong Yang wrote:
> On 2021/2/3 20:53, Yicong Yang wrote:
> > Per Downstream Port Containment Related Enhancements ECN[1]
> > Table 4-6, Interpretation of _OSC Control Field Returned Value,
> > for bit 7 of _OSC control return value:
> > 
> >   "Firmware sets this bit to 1 to grant the OS control over PCI Express
> >   Downstream Port Containment configuration."
> >   "If control of this feature was requested and denied,
> >   or was not requested, the firmware returns this bit set to 0."
> > 
> > We store bit 7 of _OSC control return value in host->native_dpc,
> > check it before enable the dpc service as the firmware may not
> > grant the control.
> > 
> > [1] Downstream Port Containment Related Enhancements ECN,
> >     Jan 28, 2019, affecting PCI Firmware Specification, Rev. 3.2
> >     https://members.pcisig.com/wg/PCI-SIG/document/12888
> > 
> > Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> > ---
> > Change since v1:
> > - use correct reference for _OSC control return value
> > 
> >  drivers/pci/pcie/portdrv_core.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
> > index e1fed664..7445d03 100644
> > --- a/drivers/pci/pcie/portdrv_core.c
> > +++ b/drivers/pci/pcie/portdrv_core.c
> > @@ -253,7 +253,8 @@ static int get_port_device_capability(struct pci_dev *dev)
> >  	 */
> >  	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
> >  	    pci_aer_available() &&
> > -	    (pcie_ports_dpc_native || (services & PCIE_PORT_SERVICE_AER)))
> > +	    (pcie_ports_dpc_native ||
> > +	    ((services & PCIE_PORT_SERVICE_AER) && host->native_dpc)))
> >  		services |= PCIE_PORT_SERVICE_DPC;
> >  
> 
> the check here maybe problematic. the bit 7 of _OSC return value is reserved
> previously and the change here may break the backward compatibility.
> currently we make dpc enabled along with aer, which can ensure the native
> dpc won't be enabled if the edr is enabled.

Since you think this is problematic, I'll drop it for now.  If you
decide it's the right thing to do, please post it again.

> i feel a bit confused as the bit 7 is not used.
> does it provide a way to enable native dpc regardless of aer ownership?
> just as pcie_ports=dpc-native does when i checked the discussion in [1].
> 
> [1] https://lore.kernel.org/linux-pci/20191023192205.97024-1-olof@lixom.net/
> 
> Thanks,
> Yicong
> 
> >  	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
> > 
> 
