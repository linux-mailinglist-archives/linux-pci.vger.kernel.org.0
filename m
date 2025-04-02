Return-Path: <linux-pci+bounces-25198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB758A79866
	for <lists+linux-pci@lfdr.de>; Thu,  3 Apr 2025 00:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EBB6166C27
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 22:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EE71EB199;
	Wed,  2 Apr 2025 22:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBnRFRtr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BD31EB183
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 22:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743633869; cv=none; b=B1O2Cy73EAL9OVMdnXUPMtpYyoDIa+vqOuXnnqZh67MztsIsBE3FJq/77trY1qun4GRMNWMCpAWCzO5szvuALSYjs0vPKi1vlWAQJwT0+a5mVhju7wGDQ+cVh/2CTi04rhWPeOC0pEkcPzmZkq2N3OAZjDICwLf/chiCzgqHOoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743633869; c=relaxed/simple;
	bh=5jerJKwtBXPxFrsLVufViEy+TQ/1cqMd7muHN5rXFVI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GUuFFTB2LKKyzPSi0EUJkNY1wR8qCwJiN1esChor0qflNunGPDz9az5yB7dUZOICE/UFIIZgfsAp4TBtnYXHpoQWAcIn93izJwUJ96IJ3HFRzTSIFyKr4OCve4HHct5BXUCq1TqKHoIzGMIfndfz/3DlUo8M4WV2OEsdbWcBwjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBnRFRtr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CCC8C4CEDD;
	Wed,  2 Apr 2025 22:44:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743633868;
	bh=5jerJKwtBXPxFrsLVufViEy+TQ/1cqMd7muHN5rXFVI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=jBnRFRtrkkIQrejetDAt8TuVqicQPjFaRr00XJYTtWru6nis+BKRCvDvQ1/qSUQqg
	 irOLjRDx5558yNNr3UIgdqmOVOzx7rWlDhDG4AzsOxLi9rvZA7/ymYNKjw1xtTrqX7
	 fXHjcgtRoRUdBFkvekaInul+IzqNCtkIzLOV278R29mwjOtuXvntHatDWQVc7juUtS
	 k4IdF+tmXpJJHFjObFc8simrKbkxv8PBcmwG913HM2oPLk011bwz4d6XP3QaM5PJ4G
	 Lh+nVD96XG/Edfqdg3zlFMgjTCZ2wnUGqzMWBPFRhaqgXeRJ07zfUjWBnjkM22y7Iz
	 yEkf2So3GB0og==
Date: Thu, 03 Apr 2025 00:44:28 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
CC: bhelgaas@google.com, kw@linux.com, manivannan.sadhasivam@linaro.org,
 linux-pci@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_misc=3A_pci=5Fendpoint=5Ftest=3A_Defer_IR?=
 =?US-ASCII?Q?Q_allocation_until_ioctl=28PCITEST=5FSET=5FIRQTYPE=29?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Z+2XjBd1wQezRlNv@lizhi-Precision-Tower-5810>
References: <20250402085659.4033434-2-cassel@kernel.org> <Z+2XjBd1wQezRlNv@lizhi-Precision-Tower-5810>
Message-ID: <1AB85045-9BBE-47B8-9643-487D82E28877@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 2 April 2025 22:01:16 CEST, Frank Li <Frank=2Eli@nxp=2Ecom> wrote:
>On Wed, Apr 02, 2025 at 10:57:00AM +0200, Niklas Cassel wrote:
>> Commit a402006d48a9 ("misc: pci_endpoint_test: Remove global 'irq_type'
>> and 'no_msi'") changed so that the default IRQ vector requested by
>> pci_endpoint_test_probe() was no longer the module param 'irq_type',
>> but instead test->irq_type=2E test->irq_type is by default
>> IRQ_TYPE_UNDEFINED (until someone calls ioctl(PCITEST_SET_IRQTYPE))=2E
>>
>> However, the commit also changed so that after initializing test->irq_t=
ype
>> to IRQ_TYPE_UNDEFINED, it also overrides it with driver_data->irq_type,=
 if
>> the PCI device and vendor ID provides driver_data=2E
>>
>> This causes a regression for PCI device and vendor IDs that do not prov=
ide
>> driver_data, and the driver now fails to probe on such platforms=2E
>>
>> Considering that the pci endpoint selftests and the old pcitest always
>> call ioctl(PCITEST_SET_IRQTYPE)
>
>Maybe my pcitest is too old=2E "pcitest -r" have not call ioctl(PCITEST_S=
ET_IRQTYPE)=2E
>I need run "pcitest -i 1" firstly=2E It'd better remove pcitest informati=
on
>because pcitest already was removed from git tree=2E and now pcitest alwa=
ys
>show NOT OKAY=2E

If you are on an old version, the return value from the ioctls have been i=
nverted by Mani:

https://github=2Ecom/torvalds/linux/commit/f26d37ee9bda938e968d0e11ba1f8f1=
588b2a135

But you should use the pci endpoint selftest, or the pcitest=2Esh shell sc=
ript=2E

Both the pci endpoint selftest and the pcitest=2Esh shell script always do=
 ioctl(PCITEST_SET_IRQTYPE) before doing a read/write/copy test=2E

Like you said, pcitest and the matching pcitest=2Esh shell script have bee=
n removed, so I suggest using the selftest=2E


>
>> before performing any test that requires
>> IRQs, simply remove the allocation of IRQs in pci_endpoint_test_probe()=
,
>> and defer it until ioctl(PCITEST_SET_IRQTYPE) has been called=2E
>>
>> A positive side effect of this is that even if the endpoint controller =
has
>> issues with IRQs, the user can do still do all the tests/ioctls() that =
do
>> not require working IRQs, e=2Eg=2E PCITEST_BAR and PCITEST_BARS=2E
>>
>> This also means that we can remove the now unused irq_type from
>> driver_data=2E The irq_type will always be the one configured by the us=
er
>> using ioctl(PCITEST_SET_IRQTYPE)=2E (A user that does not know, or care
>> which irq_type that is used, can use PCITEST_IRQ_TYPE_AUTO=2E This has
>> superseded the need for a default irq_type in driver_data=2E)
>
>But you remove "irq_type" at driver_data, does it means PCITEST_IRQ_TYPE_=
AUTO
>will not be supported?

It is supported by the selftest=2E
It is not supported by pcitest since it has been removed from the tree=2E

driver_data was just specifying the default IRQ type, but that IRQ type wa=
s always overriden using ioctl(PCITEST_SET_IRQTYPE) before a read/write/cop=
y/test by the pcitest=2Esh shell script and the selftest, so the IRQ type i=
n driver_data was quite pointless=2E


Kind regards,
Niklas

