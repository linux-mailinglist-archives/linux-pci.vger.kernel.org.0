Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9C6C1B507E
	for <lists+linux-pci@lfdr.de>; Thu, 23 Apr 2020 00:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgDVWsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Apr 2020 18:48:22 -0400
Received: from mga17.intel.com ([192.55.52.151]:33718 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725779AbgDVWsW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Apr 2020 18:48:22 -0400
IronPort-SDR: y4AolHYq8+DUQm3BB6l0lH59Ysjf862Gv8UUO2gavOQL1zsjzrd7yBfM3XN88O7s4I9X0bMp/g
 F+gbokUxdjZA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 15:48:22 -0700
IronPort-SDR: r1IRe2VEuk6z3Z+5U9T7+yFyaDUSRmDToYCZuPClUDlClUJxNkhYfikEQRPuLvaO0Fm633aFfk
 BBSE3g+q1+aA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,304,1583222400"; 
   d="scan'208";a="259230942"
Received: from crschrol-desk22.amr.corp.intel.com (HELO [10.254.73.197]) ([10.254.73.197])
  by orsmga006.jf.intel.com with ESMTP; 22 Apr 2020 15:48:20 -0700
Subject: Re: [PATCH v2 1/2] PCI/AER: Allow Native AER Host Bridges to use AER
To:     Jon Derrick <jonathan.derrick@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
        Russell Currey <ruscur@russell.cc>,
        Sam Bobroff <sbobroff@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Frederick Lawler <fred@fredlawl.com>,
        Rajat Jain <rajatja@google.com>,
        "Patel, Mayurkumar" <mayurkumar.patel@intel.com>,
        Olof Johansson <olof@lixom.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
References: <1587418630-13562-1-git-send-email-jonathan.derrick@intel.com>
 <1587418630-13562-2-git-send-email-jonathan.derrick@intel.com>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <9f8c2a62-e67d-2869-db11-4644b69815f4@linux.intel.com>
Date:   Wed, 22 Apr 2020 15:48:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <1587418630-13562-2-git-send-email-jonathan.derrick@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 4/20/20 2:37 PM, Jon Derrick wrote:
> Some platforms have a mix of ports whose capabilities can be negotiated
> by _OSC, and some ports which are not described by ACPI and instead
> managed by Native drivers. The existing Firmware-First HEST model can
> incorrectly tag these Native, Non-ACPI ports as Firmware-First managed
> ports by advertising the HEST Global Flag and matching the type and
> class of the port (aer_hest_parse).
Is there a real use case for mixed mode (one host bridge in FF mode and
another in native)?
> 
> If the port requests Native AER through the Host Bridge's capability
> settings, the AER driver should honor those settings and allow the port
> to bind. This patch changes the definition of Firmware-First to exclude
> ports whose Host Bridges request Native AER.
> 
> Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
> ---
>   drivers/pci/pcie/aer.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index f4274d3..30fbd1f 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -314,6 +314,9 @@ int pcie_aer_get_firmware_first(struct pci_dev *dev)
>   	if (pcie_ports_native)
>   		return 0;
>   
> +	if (pci_find_host_bridge(dev->bus)->native_aer)
> +		return 0;
> +
>   	if (!dev->__aer_firmware_first_valid)
>   		aer_set_firmware_first(dev);
>   	return dev->__aer_firmware_first;
> 
