Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A85123CF30
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 21:16:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728623AbgHETQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 15:16:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:46982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729146AbgHESAn (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Aug 2020 14:00:43 -0400
Received: from localhost (mobile-166-175-186-42.mycingular.net [166.175.186.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4887221D95;
        Wed,  5 Aug 2020 18:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596650442;
        bh=eaSKaq7jKQvkKuz0XPzzBEPB27hIZ62m3oOhE/XHOEI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=fIyZusMrHX4zid5kO97lCYRpmzbz1CFPgZ9MndWP+x4s16Z6WMb5OmI3VOhm0Q8TO
         Wkhz34Aku78zk0ShcWh3ItyMnuwav25ZRDf6NuWgK2yepETFsI/xvmLu0KyFSu4ccq
         CB0U3aHnwX4TwCpQf2ODafc3WfH4H6pY2ChO11Es=
Date:   Wed, 5 Aug 2020 13:00:35 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@intel.com>
Cc:     bhelgaas@google.com, Jonathan.Cameron@huawei.com,
        rjw@rjwysocki.net, ashok.raj@intel.com, tony.luck@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: Re: [PATCH V2 0/9] Add RCEC handling to PCI/AER
Message-ID: <20200805180035.GA522190@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804194052.193272-1-sean.v.kelley@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Aug 04, 2020 at 12:40:43PM -0700, Sean V Kelley wrote:
> From: Sean V Kelley <sean.v.kelley@linux.intel.com>
> 
> On the use of FLR on RCiEPs for the fatal case, still interested in more
> feedback from the earlier discussion here [1]:
> 
> [1] https://lore.kernel.org/linux-pci/C21C050B-48B1-4429-B019-C81F3AB8E843@intel.com/
> 
> There is also the question of the absence of an FLR for non-fatal error.
> If the device driver tells us that it needs "PCI_ERS_RESULT_NEED_RESET" by
> the callback report_normal_detected() then we should try FLR on the device
> as well.
> 
> On the use of variables with RP centric names such as the attributes
> dev_attr_aer_rootport_total_err_..., one concern is the ripple effect on code
> churn due to renaming. Open to suggestions, but trying to co-habitate so to
> speak RCECs with RPs in the same drivers has trade-offs.
> 
> Changes since v1 [2]:
> 
> - Make PME capability of RCEC discoverable in get_port_device_capability().
> - Replace the check on bnr with <= lastbusn in pcie_walk_rcec().
> - Fix comment header for pcie_walk_rcec().
> - Fix comment header for pci_walk_dev_affected().
> - Fix spurious newline.
> - Add sanity checks on dev->rcec.
> - Use pci_dbg() in place of pci_info() for discovered RCiEPs.
> - Remove AER RCEC AP FOUND message (accidently left in previously).
> - Remove the check for RC_END from set_device_error_reporting() since
> only Ports and RCECs are being passed.
> (Jonathan Cameron)
> - Fix the return type for flr_on_rciep().
> (reported by lkp on DEC Alpha arch.)
> 
> [1] https://lore.kernel.org/linux-pci/20200724172223.145608-1-sean.v.kelley@intel.com/
> 
> Root Complex Event Collectors (RCEC) provide support for terminating error
> and PME messages from Root Complex Integrated Endpoints (RCiEPs).  An RCEC
> resides on a Bus in the Root Complex. Multiple RCECs can in fact reside on
> a single bus. An RCEC will explicitly declare supported RCiEPs through the
> Root Complex Endpoint Association Extended Capability.
> 
> (See PCIe 5.0-1, sections 1.3.2.3 (RCiEP), and 7.9.10 (RCEC Ext. Cap.))
> 
> The kernel lacks handling for these RCECs and the error messages received
> from their respective associated RCiEPs. More recently, a new CPU
> interconnect, Compute eXpress Link (CXL) depends on RCEC capabilities for
> purposes of error messaging from CXL 1.1 supported RCiEP devices.
> 
> DocLink: https://www.computeexpresslink.org/
> 
> This use case is not limited to CXL. Existing hardware today includes
> support for RCECs, such as the Denverton microserver product
> family. Future hardware will be forthcoming.
> 
> (See Intel Document, Order number: 33061-003US)
> 
> So services such as AER or PME could be associated with an RCEC driver.
> In the case of CXL, if an RCiEP (i.e., CXL 1.1 device) is associated with a
> platform's RCEC it shall signal PME and AER error conditions through that
> RCEC.
> 
> Towards the above use cases, add the missing RCEC class and extend the
> PCIe Root Port and service drivers to allow association of RCiEPs to their
> respective parent RCEC and facilitate handling of terminating error and PME
> messages.
> 
> 
> AER Test Results:
> 1) Inject a correctable error to the RCiEP 0000:e9:00.0
>     Run ./aer_inject <a parameter file as below>:
>     AER
>     PCI_ID 0000:e9:00.0
>     COR_STATUS BAD_TLP
>     HEADER_LOG 0 1 2 3
> 
>     Log:
> [   76.155963] pcieport 0000:e8:00.4: aer_inject: Injecting errors 00000040/00000000 into device 0000:e9:00.0
> [   76.166966] pcieport 0000:e8:00.4: AER: Corrected error received: 0000:e9:00.0
> [   76.175253] pci 0000:e9:00.0: PCIe Bus Error: severity=Corrected, type=Data Link Layer, (Receiver ID)
> [   76.185633] pci 0000:e9:00.0:   device [8086:4940] error status/mask=00000040/00002000
> [   76.194604] pci 0000:e9:00.0:    [ 6] BadTLP

If you remove the timestamps, there will be less distraction here.  As
I'm sure you know, the 0/n cover letter text doesn't really go
anywhere except the email archives.  If this is potentially useful in
the future, it should be in the actual patch commit logs.

> 2) Inject a non-fatal error to the RCiEP 0000:e8:01.0
>     Run ./aer_inject <a parameter file as below>:
>     AER
>     PCI_ID 0000:e8:01.0
>     UNCOR_STATUS COMP_ABORT
>     HEADER_LOG 0 1 2 3

I think maybe this could be written in a way that could be cut and
pasted?

>     Log:
> [  117.791854] pcieport 0000:e8:00.4: aer_inject: Injecting errors 00000000/00008000 into device 0000:e8:01.0
> [  117.804244] pcieport 0000:e8:00.4: AER: Uncorrected (Non-Fatal) error received: 0000:e8:01.0
> [  117.814652] igen6_edac 0000:e8:01.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Completer ID)
> [  117.828511] igen6_edac 0000:e8:01.0:   device [8086:0b25] error status/mask=00008000/00100000
> [  117.839189] igen6_edac 0000:e8:01.0:    [15] CmpltAbrt
> [  117.847365] igen6_edac 0000:e8:01.0: AER:   TLP Header: 00000000 00000001 00000002 00000003
> [  117.857775] igen6_edac 0000:e8:01.0: AER: device recovery successful
> 
> 3) Inject a fatal error to the RCiEP 0000:ed:01.0
>     Run ./aer_inject <a parameter file as below>:
>     AER
>     PCI_ID 0000:ed:01.0
>     UNCOR_STATUS MALF_TLP
>     HEADER_LOG 0 1 2 3
> 
>     Log:
> [  131.511623] pcieport 0000:ed:00.4: aer_inject: Injecting errors 00000000/00040000 into device 0000:ed:01.0
> [  131.523259] pcieport 0000:ed:00.4: AER: Uncorrected (Fatal) error received: 0000:ed:01.0
> [  131.533842] igen6_edac 0000:ed:01.0: AER: PCIe Bus Error: severity=Uncorrected (Fatal), type=Inaccessible, (Unregistered Agent ID)
> [  131.655618] igen6_edac 0000:ed:01.0: AER: device recovery successful
> 
> Jonathan Cameron (1):
>   PCI/AER: Extend AER error handling to RCECs
> 
> Qiuxu Zhuo (6):
>   pci_ids: Add class code and extended capability for RCEC
>   PCI: Extend Root Port Driver to support RCEC
>   PCI/portdrv: Add pcie_walk_rcec() to walk RCiEPs associated with RCEC
>   PCI/AER: Apply function level reset to RCiEP on fatal error
>   PCI: Add 'rcec' field to pci_dev for associated RCiEPs
>   PCI/AER: Add RCEC AER error injection support
> 
> Sean V Kelley (2):
>   PCI/AER: Add RCEC AER handling
>   PCI/PME: Add RCEC PME handling
> 

>  drivers/pci/pcie/aer.c          | 36 +++++++++----
>  drivers/pci/pcie/aer_inject.c   |  5 +-
>  drivers/pci/pcie/err.c          | 90 +++++++++++++++++++++++++++------
>  drivers/pci/pcie/pme.c          | 15 ++++--
>  drivers/pci/pcie/portdrv.h      |  2 +
>  drivers/pci/pcie/portdrv_core.c | 90 +++++++++++++++++++++++++++++++--
>  drivers/pci/pcie/portdrv_pci.c  | 20 +++++++-
>  include/linux/pci.h             |  3 ++
>  include/linux/pci_ids.h         |  1 +
>  include/uapi/linux/pci_regs.h   |  7 +++
>  10 files changed, 233 insertions(+), 36 deletions(-)

I always apply patches to topic branches based at my "master" branch
(typically -rc1, so currently v5.8-rc1, but will soon be v5.9-rc1).

If your series doesn't apply there (as this one doesn't), it saves me
time if you tell me where it does apply.  I figured out that this
applies cleanly on top of my pci/error branch, which does make sense.

I'd actually *rather* have patches based on "master", even if I have
to resolve conflicts, because that gives me the flexibility to squash
in fixes and re-merge the topic branches.

Bjorn
