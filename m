Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 854311FC9DF
	for <lists+linux-pci@lfdr.de>; Wed, 17 Jun 2020 11:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725860AbgFQJcK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Jun 2020 05:32:10 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2319 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725554AbgFQJcJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 17 Jun 2020 05:32:09 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 3A02CCEC14DEEF102460;
        Wed, 17 Jun 2020 10:32:08 +0100 (IST)
Received: from localhost (10.52.121.100) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Wed, 17 Jun
 2020 10:32:07 +0100
Date:   Wed, 17 Jun 2020 10:31:20 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 1/2] PCI/AER: Do not reset the device status if doing
 firmware first handling.
Message-ID: <20200617103120.00006dcd@Huawei.com>
In-Reply-To: <110fa7a9-1147-b755-2958-6f40c5d666a2@linux.intel.com>
References: <20200616174731.GA1969609@bjorn-Precision-5520>
        <110fa7a9-1147-b755-2958-6f40c5d666a2@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.100]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 16 Jun 2020 11:00:32 -0700
"Kuppuswamy, Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com> wrote:

> Hi Jonathan,
> 
> On 6/16/20 10:47 AM, Bjorn Helgaas wrote:
> > [+cc Sathy]
> > 
> > On Fri, May 22, 2020 at 01:31:33AM +0800, Jonathan Cameron wrote:  
> >> pci_aer_clear_device_status() currently resets the device status even when
> >> firmware first handling is going on.  In particular it resets it on the
> >> root port.
> >>
> >> This has been discussed previously
> >> https://lore.kernel.org/patchwork/patch/427375/.  
> pci_aer_clear_device_status() is only used by handle_error_source(). And
> I don't think handle_error_source() is called in FF mode. Can you
> give more details on this issue ?

It's called in pcie_do_recovery

https://elixir.bootlin.com/linux/latest/source/drivers/pci/pcie/err.c#L200

Which is called from both handle_error_source and aer_recover_work_func.

indirectly called from ghes_handle_aer / ghes_do_proc

This particular flow will only happen (I think) on hardware reduced ACPI systems.

Jonathan

> > 
> > I don't think this reference is really pertinent, is it?  That patch
> > to b2c8881da764 changes pci_cleanup_aer_uncorrect_error_status() so it
> > doesn't clear PCI_ERR_UNCOR_STATUS in "firmware-first" mode.
> > 
> > But your patch only affects PCI_EXP_DEVSTA, not PCI_ERR_UNCOR_STATUS.
> >   
> >> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> >> ---
> >>   drivers/pci/pcie/aer.c | 3 +++
> >>   1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> >> index f4274d301235..43e78b97ace6 100644
> >> --- a/drivers/pci/pcie/aer.c
> >> +++ b/drivers/pci/pcie/aer.c
> >> @@ -373,6 +373,9 @@ void pci_aer_clear_device_status(struct pci_dev *dev)
> >>   {
> >>   	u16 sta;
> >>   
> >> +	if (pcie_aer_get_firmware_first(dev))
> >> +		return;  
> > 
> > This needs to be adjusted because pcie_aer_get_firmware_first() no
> > longer exists after 708b20003624 ("PCI/AER: Remove HEST/FIRMWARE_FIRST
> > parsing for AER ownership").
> > 
> > This will use the _OSC AER ownership bit to gate clearing of the
> > status bits in the PCIe capability (not the AER capability).
> > 
> > I think that's the right thing to do, but it's certainly not obvious
> > from the _OSC description in the PCI Firmware Spec r3.2.  I think we
> > need a pointer to the ECN that clarifies this, i.e., sec 4.5.1 of:
> > 
> >    System Firmware Intermediary (SFI) _OSC and DPC Updates ECN, Feb 24,
> >    2020, affecting PCI Firmware Specification, Rev. 3.2
> >    https://members.pcisig.com/wg/PCI-SIG/document/14076
> >   
> >>   	pcie_capability_read_word(dev, PCI_EXP_DEVSTA, &sta);
> >>   	pcie_capability_write_word(dev, PCI_EXP_DEVSTA, sta);
> >>   }
> >> -- 
> >> 2.19.1
> >>  
> 


