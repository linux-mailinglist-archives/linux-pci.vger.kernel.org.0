Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1E02D17C4
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 18:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgLGRqJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 12:46:09 -0500
Received: from mga11.intel.com ([192.55.52.93]:39122 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725832AbgLGRqJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 12:46:09 -0500
IronPort-SDR: 6Sdb+hBa6PfEtWIws/R/7BGw3ERGeJPmHkP+Cepvqun5M/FZAtIWKkV4eC+dYeeTa5efwzQmH3
 CTBEwbkb2DEw==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="170233171"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="170233171"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 09:44:23 -0800
IronPort-SDR: TImwrDxpD+lTqqwCKWBLXUGiSMULU6r2XFc4UJRoAELo4kzpsbipwrEdm5fpW39JWMDlKoFXM6
 ceDTmnWZN5pQ==
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="317271565"
Received: from unknown (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.209.92.217])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 09:44:23 -0800
Subject: Re: pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
To:     Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@dell.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
References: <084ea8e2-baae-0e2d-c60d-73fb055bdc1d@molgen.mpg.de>
From:   "Kuppuswamy, Sathyanarayanan" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Message-ID: <672a0bc2-717a-2545-6a19-8ca7e209c523@linux.intel.com>
Date:   Mon, 7 Dec 2020 09:44:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <084ea8e2-baae-0e2d-c60d-73fb055bdc1d@molgen.mpg.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Hi,

On 12/7/20 5:08 AM, Paul Menzel wrote:
> [Bringing the issue up on the list in case the Linux Bugzilla is not monitored/used.]
> 
> 
> Dear Linux folks,
> 
> 
> On Intel Tiger Lake Dell laptop, Linux logs the error below [1].
> 
>      [    0.507307] pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid
>      [    0.508835] pci 0000:00:07.2: DPC: RP PIO log size 0 is invalid
> 
>      $ lspci -nn -s 00:07
>      00:07.0 PCI bridge [0604]: Intel Corporation Tiger Lake-LP Thunderbolt PCI Express Root Port #0 
> [8086:9a23] (rev 01)
>      00:07.2 PCI bridge [0604]: Intel Corporation Tiger Lake-LP Thunderbolt PCI Express Root Port #2 
> [8086:9a27] (rev 01)
> 
> Commit 2700561817 (PCI/DPC: Cache DPC capabilities in pci_init_capabilities()) [1] probably 
> introduced it in Linux 5.7.
> 
> What does this error actually mean?
> 
>      pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
>      if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
>          pci_err(pdev, "RP PIO log size %u is invalid\n",
>              pdev->dpc_rp_log_size);
>          pdev->dpc_rp_log_size = 0;
As per PCIe spec r5.0, sec 7.9.15.2, valid RP log size is 4 or greater. Please see
the text copied from spec

- - - -
RP PIO Log Size - This field indicates how many DWORDs are allocated for the RP
PIO log registers, comprised by the RP PIO Header Log, the RP PIO ImpSpec Log,
and RP PIO TLP Prefix Log. If the Root Port supports RP Extensions for DPC, the
value of this field must be 4 or greater; otherwise, the value of
this field must be 0. See Section 7.9.15.11 , Section 7.9.15.12 , and Section 7.9.15.13 .
- - - -

In this case, since "(!(cap & PCI_EXP_DPC_CAP_RP_EXT))" condition is false, RP
EXT is supported. If RP EXT is supported, valid log size should be at-least 4.


>      }
> 
> (I guess `cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE` is zero too?)
> 
> Is it a firmware issue or a hardware issue?
I think this could be hardware issue.
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=209943
>       "pci 0000:00:07.0: DPC: RP PIO log size 0 is invalid"
> [2]: 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=27005618178ef9e9bf9c42fd91101771c92e9308 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
