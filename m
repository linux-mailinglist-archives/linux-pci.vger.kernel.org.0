Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22EAC2808FD
	for <lists+linux-pci@lfdr.de>; Thu,  1 Oct 2020 23:02:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727308AbgJAVB5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 1 Oct 2020 17:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727017AbgJAVB5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 1 Oct 2020 17:01:57 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12459C0613E2
        for <linux-pci@vger.kernel.org>; Thu,  1 Oct 2020 14:01:57 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 197so5003620pge.8
        for <linux-pci@vger.kernel.org>; Thu, 01 Oct 2020 14:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=epzDBCKfU6kQnWudPInRhtz0qFDSHXIcIMxx0I+ud7c=;
        b=YxqwHFjClYHotLzMgM7yvdOythv5UnMld5Eh3Agaud9UmsdwyIQkZ6h20viFcXu3SU
         +k+vX2NOHWtWinAnpe4yOSuZvAYRoFQtBgHe/DTSTZvwGgcv9PmJDpSuRyfNFyMaTPeH
         EphDV6T/Jk1BJQ9OD3AknjSu9+esL6wBIHvlhktD44mWiBH7gqi6KfI8JCrGrqNiiQWe
         668VXScaPB6iKjN0OWbVMYVrgbnSoXBGZzA2ZRrQASO/Vlej+r1JkoEXNnw8Drd6b7U6
         lqihPDQvjM+Zs3dXf373deU/jwbHA01ZbmeTgFHdtOWspL8lIfOn2TqzwDlOF+kW4SA0
         EtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=epzDBCKfU6kQnWudPInRhtz0qFDSHXIcIMxx0I+ud7c=;
        b=CLo2WOpljUK3XcHXVvpr+L2LHvdNSuMzImtvwOA2tKcnO0JsjI4g84rczm+YZmJd7v
         KCUuoRYAFKgFEi+Y74uFvPL4CuudSqBbdXQzDUaDL6n3qkPDov68s5NqwTpWTrTEPSTz
         jyNwn4YWJ8r3zJaIMf6br6g0AR7TVbua9hMangHDB8Ppoh3PZ7VFTFT2g8sauTVTeF8v
         UaJFNQdKOENONVoO4kKZdp3GjMPwkKSpqgdx+D85aoCzIoVIi9OJ9OEAKP4nCWm8dM6z
         wimND7JHBr38ATanv4e1z4l8zFdG02BiRipP8Loauw16SH8Fai6jt09WQiCguMeTBHtR
         AXQg==
X-Gm-Message-State: AOAM5317ROb/I9mN9i3f0IDXHYSq/MA0Iwsa5fQvszIeAmRl8Kegm09v
        UrTH82Z4xzJPFuaeBoFf7UE4Wg==
X-Google-Smtp-Source: ABdhPJz9QzZicYdRD8yNLQvR1f1/SS33cp0IbLf12LitiIpDSXjAF0+k0B0JUENXdIU1ltmbTVtoVg==
X-Received: by 2002:a63:546:: with SMTP id 67mr7690402pgf.347.1601586116458;
        Thu, 01 Oct 2020 14:01:56 -0700 (PDT)
Received: from [192.168.1.102] (c-24-20-148-49.hsd1.or.comcast.net. [24.20.148.49])
        by smtp.gmail.com with ESMTPSA id i9sm7054942pfo.138.2020.10.01.14.01.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 01 Oct 2020 14:01:55 -0700 (PDT)
From:   "Sean V Kelley" <sean.v.kelley@intel.com>
To:     "Jonathan Cameron" <Jonathan.Cameron@Huawei.com>
Cc:     "Sean V Kelley" <seanvk.dev@oregontracks.org>, bhelgaas@google.com,
        rafael.j.wysocki@intel.com, ashok.raj@intel.com,
        tony.luck@intel.com, sathyanarayanan.kuppuswamy@intel.com,
        qiuxu.zhuo@intel.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 00/13] Add RCEC handling to PCI/AER
Date:   Thu, 01 Oct 2020 14:01:54 -0700
X-Mailer: MailMate (1.13.2r5673)
Message-ID: <0C7903B8-BC98-4DE8-8973-62A7EC32645B@intel.com>
In-Reply-To: <20201001101622.00003e48@Huawei.com>
References: <20200930215820.1113353-1-seanvk.dev@oregontracks.org>
 <20201001101622.00003e48@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 1 Oct 2020, at 3:16, Jonathan Cameron wrote:

> On Wed, 30 Sep 2020 14:58:07 -0700
> Sean V Kelley <seanvk.dev@oregontracks.org> wrote:
>
>> From: Sean V Kelley <sean.v.kelley@intel.com>
>>
>> Changes since v6 [1]:
>>
>> - Remove unused includes in rcec.c.
>> - Add local variable for dev->rcec_ea.
>> - If no valid capability version then just fill in nextbusn =3D 0xff.
>> - Leave a blank line after pci_rcec_init(dev).
>> - Reword commit w/ "Attempt to do a function level reset for an RCiEP =

>> on fatal error."
>> - Change An RCiEP found on bus in range -> An RCiEP found on a =

>> different bus in range
>> - Remove special check on capability version if you fill in nextbusn =

>> =3D 0xff.
>> - Remove blank lines in pcie_link_rcec header.
>> - Fix indentation aer.c.
>> (Jonathan Cameron)
>>
>> - Relocate enabling of PME for RCECs to later RCEC handling additions =

>> to PME.
>> - Rename rcec_ext to rcec_ea.
>> - Remove rcec_cap as its use can be handled with rcec_ea.
>> - Add a forward declaration for struct rcec_ea.
>> - Rename pci_bridge_walk() to pci_walk_bridge() to match consistency =

>> with other usage.
>> - Separate changes to "reset_subordinate_devices" because it doesn't =

>> change the interface.
>> - Separate the use of "type", rename of "dev" to "bridge", the =

>> inversion of the condition and
>> use of pci_upstream_bridge() instead of dev->bus->self.
>> - Separate the conditional check (TYPE_ROOT_PORT and TYPE_DOWNSTREAM) =

>> for AER resets.
>> - Consider embedding RCiEP's parent RCEC in the rcec_ea struct. =

>> However, the
>> issue here is that we don't normally allocate the rcec_ea struct for =

>> RCiEPs and
>> the linkage of rcec_ea->rcec is not necessarily more clear.
>> - Provide more comment on the non-native case for clarity.
>> (Bjorn Helgaas)
>>
>> [1] =

>> https://lore.kernel.org/linux-pci/20200922213859.108826-1-seanvk.dev@o=
regontracks.org/
>>
>> Root Complex Event Collectors (RCEC) provide support for terminating =

>> error
>> and PME messages from Root Complex Integrated Endpoints (RCiEPs).  An =

>> RCEC
>> resides on a Bus in the Root Complex. Multiple RCECs can in fact =

>> reside on
>> a single bus. An RCEC will explicitly declare supported RCiEPs =

>> through the
>> Root Complex Endpoint Association Extended Capability.
>>
>> (See PCIe 5.0-1, sections 1.3.2.3 (RCiEP), and 7.9.10 (RCEC Ext. =

>> Cap.))
>>
>> The kernel lacks handling for these RCECs and the error messages =

>> received
>> from their respective associated RCiEPs. More recently, a new CPU
>> interconnect, Compute eXpress Link (CXL) depends on RCEC capabilities =

>> for
>> purposes of error messaging from CXL 1.1 supported RCiEP devices.
>>
>> DocLink: https://www.computeexpresslink.org/
>>
>> This use case is not limited to CXL. Existing hardware today includes
>> support for RCECs, such as the Denverton microserver product
>> family. Future hardware will be forthcoming.
>>
>> (See Intel Document, Order number: 33061-003US)
>>
>> So services such as AER or PME could be associated with an RCEC =

>> driver.
>> In the case of CXL, if an RCiEP (i.e., CXL 1.1 device) is associated =

>> with a
>> platform's RCEC it shall signal PME and AER error conditions through =

>> that
>> RCEC.
>>
>> Towards the above use cases, add the missing RCEC class and extend =

>> the
>> PCIe Root Port and service drivers to allow association of RCiEPs to =

>> their
>> respective parent RCEC and facilitate handling of terminating error =

>> and PME
>> messages.
>
> I took a look at the combined result of the series as well as =

> individual
> patches I've acked.  All looks good to me.
>
> Also ran a quick batch of tests with the non-native / no visible RCEC =

> case
> and that's working as expected.  Feels a bit odd too give a tested-by =

> for
> the case that touches only a tiny corner of the code, but if you want =

> to include
> it...
>
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com> =

> #non-native/no RCEC

Much appreciated Jonathan.

Thanks,

Sean


>
> Thanks,
>
> Jonathan
>
>>
>>
>> Jonathan Cameron (1):
>>   PCI/AER: Extend AER error handling to RCECs
>>
>> Qiuxu Zhuo (5):
>>   PCI/RCEC: Add RCEC class code and extended capability
>>   PCI/RCEC: Bind RCEC devices to the Root Port driver
>>   PCI/AER: Apply function level reset to RCiEP on fatal error
>>   PCI/RCEC: Add RCiEP's linked RCEC to AER/ERR
>>   PCI/AER: Add RCEC AER error injection support
>>
>> Sean V Kelley (7):
>>   PCI/RCEC: Cache RCEC capabilities in pci_init_capabilities()
>>   PCI/ERR: Rename reset_link() to reset_subordinate_device()
>>   PCI/ERR: Use "bridge" for clarity in pcie_do_recovery()
>>   PCI/ERR: Limit AER resets in pcie_do_recovery()
>>   PCI/RCEC: Add pcie_link_rcec() to associate RCiEPs
>>   PCI/AER: Add pcie_walk_rcec() to RCEC AER handling
>>   PCI/PME: Add pcie_walk_rcec() to RCEC PME handling
>>
>>  drivers/pci/pci.h               |  25 ++++-
>>  drivers/pci/pcie/Makefile       |   2 +-
>>  drivers/pci/pcie/aer.c          |  36 ++++--
>>  drivers/pci/pcie/aer_inject.c   |   5 +-
>>  drivers/pci/pcie/err.c          | 109 +++++++++++++++----
>>  drivers/pci/pcie/pme.c          |  15 ++-
>>  drivers/pci/pcie/portdrv_core.c |   8 +-
>>  drivers/pci/pcie/portdrv_pci.c  |   8 +-
>>  drivers/pci/pcie/rcec.c         | 187 =

>> ++++++++++++++++++++++++++++++++
>>  drivers/pci/probe.c             |   2 +
>>  include/linux/pci.h             |   5 +
>>  include/linux/pci_ids.h         |   1 +
>>  include/uapi/linux/pci_regs.h   |   7 ++
>>  13 files changed, 367 insertions(+), 43 deletions(-)
>>  create mode 100644 drivers/pci/pcie/rcec.c
>>
>> --
>> 2.28.0
>>
