Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 750EB2F3A6A
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 20:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436737AbhALT2n (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 14:28:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:48548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2436746AbhALT2m (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 12 Jan 2021 14:28:42 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 078F52070B;
        Tue, 12 Jan 2021 19:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610479681;
        bh=K1q2Hl3swGZq/3iwAwrbto/xilRsdC0A82hF8kohU5Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nkA96c7L9fk6jbcJxxGCUPjPLf2l67dpHSxKjqwd56Jb9wYrw2BifHAMzHbfM2CDm
         dNQWVFn2cMuGGPhxyVhMGPyZcUUUAfgH9LhjpkEymaYbaeCD6OwM2BsPEAX0vhVkyt
         SHd2IG2cxijs8ssBN1svbZXv7e3GK07LPxkFSgkVufqpS7rT2WebgTE1MkTtftLANt
         S8dMyv5IKUR5oTXJWgxwRG7N7eg+EpxqOj6NUQtMh8ktJs7Jgklxix3zVcB2Ho+Cxz
         VKE+ME3udn60Za4rfstyJfNGCIOC5+Venuphe4DY+UN/lDQdxiQo22SMBFNNOnrhJL
         iBNwBbBfIX0HA==
Date:   Tue, 12 Jan 2021 11:27:58 -0800
From:   Keith Busch <kbusch@kernel.org>
To:     Hinko Kocevar <hinko.kocevar@ess.eu>
Cc:     "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>
Subject: Re: [PATCHv2 0/5] aer handling fixups
Message-ID: <20210112192758.GB1472929@dhcp-10-100-145-180.wdc.com>
References: <4242a9a9-c881-0af4-1cab-396931fee420@ess.eu>
 <20210105183302.GA1278205@dhcp-10-100-145-180.wdc.com>
 <B31F8CA9-D62B-4488-B4C1-EB31E9117203@intel.com>
 <20210107214236.GA1284006@dhcp-10-100-145-180.wdc.com>
 <70f2288d-2d1e-df82-d107-e977e1f50dca@ess.eu>
 <c3117c51-144f-ae59-ad68-bdc5532d12cb@ess.eu>
 <20210111163708.GA1458209@dhcp-10-100-145-180.wdc.com>
 <6783d09d-1431-15fd-961e-3820b14e001e@ess.eu>
 <20210111220951.GA1472929@dhcp-10-100-145-180.wdc.com>
 <ed8256dd-d70d-b8dc-fdc0-a78b9aa3bbd9@ess.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed8256dd-d70d-b8dc-fdc0-a78b9aa3bbd9@ess.eu>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jan 12, 2021 at 06:20:55PM +0100, Hinko Kocevar wrote:
> On 1/11/21 11:09 PM, Keith Busch wrote:
>
> Here is the log after applying the patch.
> 
> What sticks out are the numerous "VC buffer not found in pci_save_vc_state"
> messages, AFAICT from vc.c pci_save_vc_state(), which I have not spotted
> before:
> 
> [dev@bd-cpu18 ~]$ dmesg | grep vc_
> [  336.960749] pcieport 0000:00:01.1: VC buffer not found in pci_save_vc_state
> [  338.125683] pcieport 0000:01:00.0: VC buffer not found in pci_save_vc_state
> [  338.342504] pcieport 0000:02:01.0: VC buffer not found in pci_save_vc_state
> [  338.569035] pcieport 0000:03:00.0: VC buffer not found in pci_save_vc_state
> [  338.775696] pcieport 0000:04:01.0: VC buffer not found in pci_save_vc_state
> [  338.982599] pcieport 0000:04:03.0: VC buffer not found in pci_save_vc_state
> [  339.189608] pcieport 0000:04:08.0: VC buffer not found in pci_save_vc_state
> [  339.406232] pcieport 0000:04:0a.0: VC buffer not found in pci_save_vc_state
> [  339.986434] pcieport 0000:04:12.0: VC buffer not found in pci_save_vc_state

Ah, that's happening because I added the cap caching after the cap
buffer allocation. The patch below on top of the previous should fix
those warnings.
 
> I do not see the lockup anymore, and the recovery seems to have successfully
> been performed.

Okay, that kind of indicates the frequent capability lookups are taking
a while. We cache other capability offsets for similar reasons in the
past, but I don't recall them ever taking so long that it triggers the
CPU lockup watchdog.

---
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 56992a42bac6..a12efa87c7e0 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2385,6 +2385,7 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_ea_init(dev);		/* Enhanced Allocation */
 	pci_msi_init(dev);		/* Disable MSI */
 	pci_msix_init(dev);		/* Disable MSI-X */
+	pci_vc_init(dev);		/* Virtual Channel */
 
 	/* Buffers for saving PCIe and PCI-X capabilities */
 	pci_allocate_cap_save_buffers(dev);
@@ -2401,7 +2402,6 @@ static void pci_init_capabilities(struct pci_dev *dev)
 	pci_aer_init(dev);		/* Advanced Error Reporting */
 	pci_dpc_init(dev);		/* Downstream Port Containment */
 	pci_rcec_init(dev);		/* Root Complex Event Collector */
-	pci_vc_init(dev);		/* Virtual Channel */
 
 	pcie_report_downtraining(dev);
 
--
