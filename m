Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D54DFD3A5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2019 05:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfKOE2l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Nov 2019 23:28:41 -0500
Received: from bilbo.ozlabs.org ([203.11.71.1]:48521 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726549AbfKOE2l (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 14 Nov 2019 23:28:41 -0500
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 47Dlj16q4Nz9sP3;
        Fri, 15 Nov 2019 15:28:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1573792118;
        bh=MWdn41PZG6SZc8Chav2+ActZ+b4sq7GWSSOQtit0J64=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=TdNXZRi4NOqbMSvdLS7nMZC7omM3sukXKqe3Ndimj4J7mqhooznCbAJDWI/f457cK
         B/9XXs1KVmRXMTn13YKRrSS5GQ5OWQgSfrGavUaIGFHRJ9v6vlDYQYqm7VeincO2fR
         cac6MmkmgY3zkN+5b7L51ZVPSp15dv7w/Doo4J7iPFms9YD6Fs/tWtu4dwR3FRREd9
         tuBESXKObtkZdR/1hslqabODpfAXj4CSzCAis6luQNSBfn9ZF3teekZIKAVKSVSEsn
         J/mxX0DDdiVtiTcekr104D9ZvB7QAbuXNcNc4y8DlFrg9iohSA0mvfgh6mXfSmLqpp
         KnVod41p2D1WA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Tyrel Datwyler <tyreld@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org
Cc:     linux-pci@vger.kernel.org,
        Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Subject: Re: [PATCH] powerpc/powernv: Disable native PCIe port management
In-Reply-To: <5a12d199-fa1f-5a60-05d8-df9edffbc227@linux.ibm.com>
References: <20191113094035.22394-1-oohall@gmail.com> <5a12d199-fa1f-5a60-05d8-df9edffbc227@linux.ibm.com>
Date:   Fri, 15 Nov 2019 15:28:35 +1100
Message-ID: <87a78xepak.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Tyrel Datwyler <tyreld@linux.ibm.com> writes:
> Nothing but pedantic spelling and grammar nits of the commit log follow.

Thanks, they were annoying me :)

cheers

> On 11/13/19 1:40 AM, Oliver O'Halloran wrote:
>> On PowerNV the PCIe topology is (currently) managed the powernv platform
>
> s/the powernv/by the powernv
>
>> code in cooperation with firmware. The PCIe-native service drivers bypass
>> both and this can cause problems.
>> 
>> Historically this hasn't been a big deal since the only port service
>> driver that saw much use was the AER driver. The AER driver relies
>> a kernel service to report when errors occur rather than acting autonmously
>
> s/a kernel/on a kernel
> autonomously
>
>> so it's fairly easy to ignore. On PowerNV (and pseries) AER events are
>> handled through EEH, which ignores the AER service, so it's never been
>> an issue.
>> 
>> Unfortunately, the hotplug port service driver (pciehp) does act
>> autonomously and conflicts with the platform specific hotplug
>> driver (pnv_php). The main issue is that pciehp claims the interrupt
>> associated with the PCIe capability which in turn prevents pnv_php from
>> claiming it.
>> 
>> This results in hotplug events being handled by pciehp which does not
>> notify firmware when the PCIe topology changes, and does not setup/teardown
>> the arch specific PCI device structures (pci_dn) when the topology changes.
>> The end result is that hot-added devices cannot be enabled and hot-removed
>> devices may not be fully torn-down on removal.
>> 
>> We can fix these problems by setting the "pcie_ports_disabled" flag during
>> platform initialisation. The flag indicates the platform owns the PCIe
>> ports which stops the portbus driver being registered.
>
> s/being/from being
>
>> 
>> Cc: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
>> Fixes: 66725152fb9f ("PCI/hotplug: PowerPC PowerNV PCI hotplug driver")
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>> ---
>> Sergey, just FYI. I'll try sort out the rest of the hotplug
>> trainwreck in 5.6.
>> 
>> The Fixes: here is for the patch that added pnv_php in 4.8. It's been
>> a problem since then, but wasn't noticed until people started testing
>> it after the EEH fixes in commit 799abe283e51 ("powerpc/eeh: Clean up
>> EEH PEs after recovery finishes") went in earlier in the 5.4 cycle.
>> ---
>>  arch/powerpc/platforms/powernv/pci.c | 17 +++++++++++++++++
>>  1 file changed, 17 insertions(+)
>> 
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index 2825d00..ae62583 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -941,6 +941,23 @@ void __init pnv_pci_init(void)
>> 
>>  	pci_add_flags(PCI_CAN_SKIP_ISA_ALIGN);
>> 
>> +#ifdef CONFIG_PCIEPORTBUS
>> +	/*
>> +	 * On PowerNV PCIe devices are (currently) managed in cooperation
>> +	 * with firmware. This isn't *strictly* required, but there's enough
>> +	 * assumptions baked into both firmware and the platform code that
>> +	 * it's unwise to allow the portbus services to be used.
>> +	 *
>> +	 * We need to fix this eventually, but for now set this flag to disable
>> +	 * the portbus driver. The AER service isn't required since that AER
>> +	 * events are handled via EEH. The pciehp hotplug driver can't work
>> +	 * without kernel changes (and portbus binding breaks pnv_php). The
>> +	 * other services also require some thinking about how we're going
>> +	 * to integrate them.
>> +	 */
>> +	pcie_ports_disabled = true;
>> +#endif
>> +
>>  	/* If we don't have OPAL, eg. in sim, just skip PCI probe */
>>  	if (!firmware_has_feature(FW_FEATURE_OPAL))
>>  		return;
>> 
