Return-Path: <linux-pci+bounces-45176-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B0E8D3A9A5
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 13:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F2157300349C
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 12:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC868361DBF;
	Mon, 19 Jan 2026 12:57:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C32EBDD9;
	Mon, 19 Jan 2026 12:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827460; cv=none; b=m8oaTUKmU+TvvG+HAaJThPbNGazEbrngb7qyK7QPvSEWDDtVylNZAZtkQCDK65WkS8emasS+KZUW0PrLKCS0xJuMPFi0JX3ZPNS/nAv3byJCmPAxldXnJkbW4rwCO0ZqHFIeHK/TLwd19xydVyR+RoyDwGdJjJvv2HYGETZR0Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827460; c=relaxed/simple;
	bh=r2ff9uDL8xt8n0rYya4z5qBtNjY8LP95g1UfN4rnFqE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=CUR2irmwLtgESc8MZ0Z06OInxEtJvb7sZGHvY2aFaGMQ/cuhTCvq+aVHBSbZHEcXawY4XHQOWEd8kYYkKi198+B6U3Ke6sL4vlJ3gm9ua9X7PgXKQeihLnPuksDmSSXLY2PXD8mu38m6xdRQPh+kCLjkpjdOGOaNaSuWQoxYFjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from [192.168.0.66] ([88.171.60.104]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N6KQZ-1vtGwY2aMb-00w7w0; Mon, 19 Jan 2026 13:51:43 +0100
Message-ID: <87fb14ce-d708-414c-8b38-4195b7dd65a3@green-communications.fr>
Date: Mon, 19 Jan 2026 13:51:42 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, "Rob Herring (Arm)" <robh@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 regressions@lists.linux.dev
References: <a1d926f0-4cb5-4877-a4df-617902648d80@green-communications.fr>
 <eb94b379-6e0b-4beb-aaa7-413a4e7f04b9@green-communications.fr>
 <3780eb61-68e2-42ce-939e-7458cd3a63cb@green-communications.fr>
 <20260116171048.GP961588@nvidia.com>
Content-Language: en-US
From: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Autocrypt: addr=Nicolas.Cavallari@green-communications.fr; keydata=
 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
Subject: Re: [REGRESSION] Re: imx8 PCI regression since "iommu: Get DT/ACPI
 parsing into the proper probe path"
In-Reply-To: <20260116171048.GP961588@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gOhvnN7z0uHCNgwQGGM9CIBM1Oz3un92068MxFN97zndh8SR9CX
 IVySgViSQp9kfyE4gyZLmhHtfTvcByvw5XKHFUU91+b4AaSmk8UfKA1YXEhAOx9EWF3AQFy
 d5/tQ+t9+F+UfAsQvH8KFSikCHokx9DPzqqhBvMFc8CZ7siK2OF5xiKdJ4am7OSzA7vimug
 TxBH6gHAI8vEi50TcHDMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xJo3KYuFO+8=;HRChcvNLxy8FiHXqL67U2fRPtSS
 9Ci+gjnzuA2JFi72dfbNTf6aL8vBnG0qXcdm8h9eeV6PNPZ9zErymei3fM4YGVooh8TI3EfUk
 eY5qhJ7obVTDbX3q6GV4knbF/4LHGa5VAyWESActqIXWp3kFNGsHRb0cftEYPwQL3CvSxfJyr
 hc1yMpoyMc+7RKwdFOLIAUQygSI19ubtLL0S5919zOs0IYFVRHRRAWfkRBranznfkHOlpn9XN
 XQHtgJVhsshxAUs6d7G1KC0XmZftSOAsf5c/Oa9R3rpASOl0QLnNBQ/SZ4kQ5PS4hJy7jzwsk
 7nCr+oojPLojuHkkOrT1T0Y67k18uCUugR5/kOoTMcCGZ+V43oPVzwRNl844j1qrrel4s/QCq
 RiRisnxztImwdd3q94T0Am5OvybaFGl0hN64wtE4KAEONkXvZi12ITQbo4r5FOstmkuH/nWpz
 9IKnGl7fu4Tn0uhqAYjetRkFqn86cCq8ERxFj6adK7+/zjIXsPv3pmko7hDrgLEJcq8+VV2NG
 2qgtLUPbjOeUbv0Q0AF1Yip8WQntGqA8laRB8OgGCFyxu4NNG2t6SPUuCZRBH5oOpJVuioHk+
 fJagO28M/4RrROQRlTAvotSjIaHfWrcKkZ7igXRjFqyqlvPAVspoUchqXAl/56baj8dnZ5yP+
 fKRUU7BLJsOBKuPsnvfZT3UgVyAI3Kx8CsmINrjtaWqo0zLy2J8p+Fu+bzcr38G0D4d3AUyWT
 mDT3rXqKxH/MZNu7XFEu4i88BWcnS+eVcXZvqfsdGNNp53BXKhPattDz+u7BipybQFSvXnXeD
 Gwt0aIMW0aT0z/a0Wbe7YPIx3EDz1r32KCSY82755mol3UA4hVnrsjE63NbF/Xr+O3i7ZOjs5
 8LAqSR/J6yRTUptTRj3lMt7ZsKEc8I0S8jQ/t4HNyumwB+tXQHbjK4tw1SyoLOn58YJtashgk
 EO/PinpsaeTlRu9UkZxX1RNeNjDdp5Wzi6rCyh4HpWX5ikjZK5wFqt/l/AuZJiXW0gBEZLKf0
 WPjxeskGAkGrR6tRkFy0ojtHP3JvkqvozpWG1gXTG1g0ZSMg9XCogDgTRz96AAwgt1XeDEUdO
 1GHzXGmg+S4WijICZYyQB9PMRtdMli3S2O08SHscUmalaP7fQJOicCk78ObMhevAr8qEm9ZMT
 BkhZtOfqg/Qu14gIvc8XhP0VDgi4XOu3excuI3MpFZqtO2Au33XHB5JVm/BEZ8SxbLPRTjfCt
 ZP/DwCkFMDWxMGSYS2F64RoLA0GPzCqxA54jbVb4ngLvIiE8n7Zww0MXi7hFTxAJbyCHuKwOG
 LOPLKeENFKX5ZdYnnlLkDY/K4s0bsWPPN5tk6roLH75LGUAScmE+fDszJ9e1w2rLXTgXy3ygx
 QqW3UOtJ8WwxVA+58hzg4avapdccZbWcpCN3T3+XwGVVGp8mHkczXVSrN85EXZjwvnEDwqcF+
 Yy8aj7+Bd+bKjZjGkC9H4AaZ1i665nTf0JWT1Q5xrBk59L8Rf2tg0hp1x+AQQvlU9YOqN5+hR
 FTLjW86g6E0l2pb9dHbUWC3bTyD+UPzLFBQ+fDHpM3hvF91l0QRw0j9kl6lmHqE6/uHrLMptk
 MkvQdIYbuR1HWxQGBSVHxTaKfefCXGBGCAVHItAxtA9qk7XztZ67X4bejNejdyC4N2WyAjHf9
 g6QJxLGjzq/U6VKrDBPD49z2fhYurEHY1U0dOegbfkPQYqhIjc4GIRVLRzhJ7EBlhF8HH3Ve1
 GrqWFXwC3xJe8d2/bcRkzCk6RiEaYReutqma4tQatfN1AI4Mfk30f+8w=

Le 16/01/2026 à 18:10, Jason Gunthorpe a écrit :
> On Fri, Jan 16, 2026 at 05:52:36PM +0100, Nicolas Cavallari wrote:
>> I debugged it further, it seems to be mostly a PCI issue since the system
>> does not actually have an IOMMU.
>>
>> When examining changes in the PCI configuration (lspci -vvvv), the main
>> difference is that, with the patch, Access Control Services are enabled on
>> the PCI switch.
>>
>>          Capabilities: [220 v1] Access Control Services
>>                  ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
>> UpstreamFwd+ EgressCtrl+ DirectTrans+
>> -               ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir-
>> UpstreamFwd- EgressCtrl- DirectTrans-
>> +               ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
>> UpstreamFwd+ EgressCtrl- DirectTrans-
>>
>> If I manually patch the config space in sysfs and re-disable ACS on the port
>> connected to the LAN7430, I cannot reproduce the problem.  In fact,
>> disabling only ReqRedir is enough to work around the issue.
> 
> My guess would be your system has some kind of address alias going on?
> 
> Assuming you are not facing an errata, ACS generally changes the
> routing of TLPs so if you have a DMA address that could go to two
> different places then messing with ACS will give you different
> behaviors.
> 
> In specific when you turn all those ACS settings you cannot do P2P
> traffic anymore. If your system expects this for some reason then you
> must use the kernel command line option to disable acs.
> 
> If you are just doing normal netdev stuff then it is doubtful that you
> are doing P2P at all, so I might guess a bug in the microchip ethernet
> driver doing a wild DMA? Stricter ACS settings cause it to AER and the
> device cannot recover?

Yes, i'm just running network throughput tests (iperf3) on eth1 while wlan0 is 
idling, and those are the only two peripheral on the PCI bus. I don't think 
there are anything unusual going on (P2P or vendor commands).

Bit it turns out there is an errata for the Pericom PI7C9X2G404 switch that 
matches my problem, and there is already a workaround in the kernel, but it does 
not match my PCI ids:

   DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2404,
                            pci_fixup_pericom_acs_store_forward);
   DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2404,
                            pci_fixup_pericom_acs_store_forward);
   DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2304,
                            pci_fixup_pericom_acs_store_forward);
   DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2304,
                            pci_fixup_pericom_acs_store_forward);
   DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2303,
                            pci_fixup_pericom_acs_store_forward);
   DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2303,
                            pci_fixup_pericom_acs_store_forward);

While my device is 12d8:b404 and lspci still identifies it as PI7C9X2G404:

01:00.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G404 EV/SV PCIe2 
4-Port/4-Lane Packet Switch [12d8:b404] (rev 01) (prog-if 00 [Normal decode])

Adding this ID to the quirks.c list fixes the issue. I'll send a patch.

