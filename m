Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30B094952C7
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 17:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377209AbiATQ7g (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 11:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377186AbiATQ7b (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jan 2022 11:59:31 -0500
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org [IPv6:2001:67c:2050:1::465:204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33705C061574
        for <linux-pci@vger.kernel.org>; Thu, 20 Jan 2022 08:59:31 -0800 (PST)
Received: from smtp202.mailbox.org (unknown [91.198.250.118])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4JfpdX0Ddfz9skr;
        Thu, 20 Jan 2022 17:59:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Message-ID: <3dcb1639-3234-8c3c-28b4-3be0f66dc29e@denx.de>
Date:   Thu, 20 Jan 2022 17:59:22 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v3 2/2] PCI/AER: Enable AER on all PCIe devices supporting
 it
Content-Language: en-US
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali@kernel.org>,
        linux-pci@vger.kernel.org,
        Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Yao Hongbo <yaohongbo@linux.alibaba.com>,
        Naveen Naidu <naveennaidu479@gmail.com>
References: <20220120154615.GA1044459@bhelgaas>
From:   Stefan Roese <sr@denx.de>
In-Reply-To: <20220120154615.GA1044459@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1/20/22 16:46, Bjorn Helgaas wrote:
> On Thu, Jan 20, 2022 at 08:31:31AM +0100, Stefan Roese wrote:
>> On 1/19/22 11:37, Pali Rohár wrote:
> 
>>> And when you opened this issue with hotplugging, another thing for
>>> followup changes in future is calling pcie_set_ecrc_checking() function
>>> to align ECRC state of newly hotplugged device with "pci=ecrc=..."
>>> cmdline option. As currently it is done only at that function
>>> set_device_error_reporting().
>>
>> Agreed, this is another area to look into. Not sure if it's okay to
>> address this, once this patch-set has been accepted (if it will be).
> 
> ECRC might be something that could be peeled off first to reduce the
> complexity of AER itself.
> 
> The ECRC capability and enable bits are in the AER Capability, so I
> think it should be moved to pci_aer_init() so it happens for every
> device as we enumerate it.

Just that there is no misunderstanding: You are thinking about something
like this:

diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 9fa1f97e5b27..5585fefc4d0e 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -387,6 +387,9 @@ void pci_aer_init(struct pci_dev *dev)
         pci_add_ext_cap_save_buffer(dev, PCI_EXT_CAP_ID_ERR, 
sizeof(u32) * n);

         pci_aer_clear_status(dev);
+
+       /* Enable ECRC checking if enabled and configured */
+       pcie_set_ecrc_checking(dev);
  }

  void pci_aer_exit(struct pci_dev *dev)
@@ -1223,9 +1226,6 @@ static int set_device_error_reporting(struct 
pci_dev *dev, void *data)
                         pci_disable_pcie_error_reporting(dev);
         }

-       if (enable)
-               pcie_set_ecrc_checking(dev);
-
         return 0;
  }

Perhaps as patch 1/3 in this patch series? Or as some completely
separate patch?

Thanks,
Stefan

> As far as I can tell, there is no requirement that every device in the
> path support ECRC, so it can be enabled independently for each device.
> I think devices that don't support ECRC checking must handle TLPs with
> ECRC without error.
> 
> Per Table 6-5, ECRC check failures result in a device logging the
> prefix/header of the TLP and sending ERR_NONFATAL or ERR_COR.  I think
> this is useful regardless of whether AER interrupts are enabled
> because error information is logged where the ECRC failure was
> detected.
> 
> Bjorn
> 

Viele Grüße,
Stefan Roese

-- 
DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-51 Fax: (+49)-8142-66989-80 Email: sr@denx.de
