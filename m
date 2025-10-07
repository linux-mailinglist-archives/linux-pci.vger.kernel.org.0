Return-Path: <linux-pci+bounces-37693-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53BBBC2FCB
	for <lists+linux-pci@lfdr.de>; Wed, 08 Oct 2025 01:45:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6328A3B77BA
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 23:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 325371C84A2;
	Tue,  7 Oct 2025 23:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FmbyFnpC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB31B34BA5F;
	Tue,  7 Oct 2025 23:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759880752; cv=none; b=h5AQ6MmKdmL1TIEzDDrWBTplPS9nO0FBccopNUK+/s25n2dwMHdr9lLc3umkoBkRjUig/RnEeODPWpYcH/hAk3ccXRyMT8ui2HArIED30/ylewamDZv3u3K8FbEz+99BVrILJS3ELvVDUsoRcyRQDXdlPYvazfgHM5UzrcZRvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759880752; c=relaxed/simple;
	bh=IqRRuKIoEphO+gj4luQowZCNvLxltjulvENl9vZ2t+0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QmZjgAYDBRGtsSCd5OFBmez84doHX0AR5J75szvg3eNGpAdnaa7jHJLyLBxfBgSgk/KuYfqiZNlRlZtG5tKRE8bkjX+VgJrHgyq1wssH15KT0MscVb0/fV3QESdF/rETcltrDm1N26rJOXw2vvh/ZVtVDd82hUSJXDIZnAsszAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FmbyFnpC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B17C4CEF1;
	Tue,  7 Oct 2025 23:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759880751;
	bh=IqRRuKIoEphO+gj4luQowZCNvLxltjulvENl9vZ2t+0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=FmbyFnpCYKwydzg66aV+Sua/TbY8p/XI9373e4P1XP0oJUHVtNKWGLa5ONUCoJAZB
	 zjir8jaXGOsic7nKP30hhQuqcx9N4f7FWJjUf3itM1YQoG3W7pzhJPXdtR8b/uiT6W
	 zpY9ErUIk0Vat6419gP+qxO9Iojrh56ieTeZ9rjlu/7M/Nm+PNowx6yqY1gl8tx/HI
	 RwcLdPMvDj3kRaK1NSnHOsskVljDT38VvtGvMy1DJEPhezdIvLs3IjCUgGM8B1jreS
	 F9n5r7dpYSvWDTvsosaUpQit2FF5TsoTln1UzvXld0Yy6tjNa4ZwGL5NylcV4SiZLD
	 i/rQbHX7Rd8ng==
Date: Wed, 08 Oct 2025 01:45:48 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Frank Li <Frank.li@nxp.com>
CC: Manivannan Sadhasivam <mani@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, ntb@lists.linux.dev,
 imx@lists.linux.dev
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v4_1/3=5D_PCI=3A_endpoint=3A_Add_help?=
 =?US-ASCII?Q?er_function_pci=5Fepf=5Fget=5Fbar=5Frequired=5Fsize=28=29?=
User-Agent: Thunderbird for Android
In-Reply-To: <aOVbOb5UyhM7c7p1@lizhi-Precision-Tower-5810>
References: <20250930-vntb_msi_doorbell-v4-0-ea2c94c6ff2e@nxp.com> <20250930-vntb_msi_doorbell-v4-1-ea2c94c6ff2e@nxp.com> <aOOdaDdxCAkmGbkd@ryzen> <aOVbOb5UyhM7c7p1@lizhi-Precision-Tower-5810>
Message-ID: <247854C3-B81F-48E2-A68C-CCA5F4338600@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 7 October 2025 20:26:01 CEST, Frank Li <Frank=2Eli@nxp=2Ecom> wrote:
>On Mon, Oct 06, 2025 at 12:43:52PM +0200, Niklas Cassel wrote:
>> On Tue, Sep 30, 2025 at 04:39:37PM -0400, Frank Li wrote:
>> > Introduce pci_epf_get_bar_required_size() to retrieve the required BA=
R
>> > size and memory size=2E Prepare for adding support to set an MMIO add=
ress to
>> > a specific BAR=2E
>> >
>> > Use two variables 'aligned_bar_size' and 'aligned_mem_size' to avoid
>> > confuse=2E
>>
>> 'aligned_bar_size' has been renamed, so this sentence should be updated=
=2E
>>
>>
>> (snip)
>>
>> > @@ -308,7 +327,9 @@ void *pci_epf_alloc_space(struct pci_epf *epf, si=
ze_t size, enum pci_barno bar,
>> >  	}
>> >
>> >  	dev =3D epc->dev=2Eparent;
>> > -	space =3D dma_alloc_coherent(dev, aligned_size, &phys_addr, GFP_KER=
NEL);
>> > +
>> > +	space =3D dma_alloc_coherent(dev, aligned_mem_size,
>> > +				   &phys_addr, GFP_KERNEL);
>> >  	if (!space) {
>> >  		dev_err(dev, "failed to allocate mem space\n");
>> >  		return NULL;
>> > @@ -317,7 +338,7 @@ void *pci_epf_alloc_space(struct pci_epf *epf, si=
ze_t size, enum pci_barno bar,
>> >  	epf_bar[bar]=2Ephys_addr =3D phys_addr;
>> >  	epf_bar[bar]=2Eaddr =3D space;
>> >  	epf_bar[bar]=2Esize =3D size;
>> > -	epf_bar[bar]=2Ealigned_size =3D aligned_size;
>> > +	epf_bar[bar]=2Ealigned_size =3D aligned_mem_size;
>>
>> I like that this local variable is now named aligned_mem_size
>> to more clearly highlight that it is the aligned _memory_ size=2E
>>
>> Perhaps you could also rename the struct pci_epf_bar struct member
>> 'aligned_size' to 'aligned_mem_size' or perhaps even better,
>> 'backing_mem_size' or 'mem_size' ?
>
>How about alloc_mem_size ? which actually used for dma_free() function=2E


I prefer mem_size, but I am not the maintainer=2E
Hopefully Mani has an option to avoid bike shedding :)

Have an awesome day!


/Niklas


