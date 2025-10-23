Return-Path: <linux-pci+bounces-39084-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1036BFF72A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 09:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 842084EC118
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 07:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37A826E146;
	Thu, 23 Oct 2025 07:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="vu+Mc10b"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B5E1D6194;
	Thu, 23 Oct 2025 07:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761203006; cv=none; b=oewH53McTim7J7DLuf+UtPVIo6IZMT5fD8lRZmAoarkc3ND/soqKc2FJwj2Werw2eUNyOWFC/cyjLRTFj4hvr+8N6Pscw6mfWyTky6r8dXjioSwQiyerj7rsIk+zIxTL3icnMQu6nzmqSujh9oJmlRAXwKylBH6e665XLyp1e2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761203006; c=relaxed/simple;
	bh=0ckqV0K2dAXM3Dkb2JcKRgkmbGuv8T4/uaLf0swVWsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qbiSnah3XxjiRye3n+vmr9fla0hnfwSizhgJZo7BrzhdDxZUTXUwfGlkxCDwZmfPxtRv01p9gJRF5VH4MPHHbItmY/WWx1MFOPQsI7heNy2pE40EJCs9ZxlwFovhFUnmw60HrbWV5VH25y+7kAlijcW6PwMQi0SmpZAlbAC1l3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=vu+Mc10b; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4cscSJ4tYYz9t4g;
	Thu, 23 Oct 2025 09:03:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761202992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G6Ffq+ccXhdu6bXkIVnRfbSR16dvXJBwWlJvJBmc4C0=;
	b=vu+Mc10bLXPpvhAqYk5bXxYTs1HTKafr6RVNerUH3+/USKTUzMsf+pd1rvIWl9QchACxgY
	4zKKcupQrMnuvqwZI7y99Fci6+G7L5Tj1nJyEppAlzPlroaJnvnX4Fj7gRi3kCKFSoT2/H
	uH01xiEk6xYbMxtHS50MrrVbQE8dW9nYZXhITofdse1xstTFfhADwldr64mub4LkhxyAdH
	NniMIgcoPySC5PBH8r5adx8mqwK/9y+KDFVITyXqemq3caRUPBtPjmxjghvBY80hL12zjQ
	6b6hWvtEjQtV/SnMlX3TSEQI9iFnql5jaDzi2unQD7+L0B8XGM3HypbE9GQJjQ==
Message-ID: <9c7e43c3-24e9-4b08-a6ce-2035b50226f4@mailbox.org>
Date: Thu, 23 Oct 2025 09:03:07 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
To: "Musham, Sai Krishna" <sai.krishna.musham@amd.com>,
 "mani@kernel.org" <mani@kernel.org>,
 "Havalige, Thippeswamy" <thippeswamy.havalige@amd.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Bandi, Ravi Kumar"
 <ravib@amazon.com>, "lpieralisi@kernel.org" <lpieralisi@kernel.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "kwilczynski@kernel.org" <kwilczynski@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>, "Simek, Michal" <michal.simek@amd.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 Sean Anderson <sean.anderson@linux.dev>,
 "Yeleswarapu, Nagaradhesh" <nagaradhesh.yeleswarapu@amd.com>
References: <20251021212801.GA1224310@bhelgaas>
 <ab1f7c51-bc41-4774-a0dc-850e53c412eb@mailbox.org>
 <3it5l556vmfpuu6kz5yvulwosi4ecmcgfbzcizrc5wi7ifddkh@mpzfxf2v6v3f>
 <72267a6c-13c7-40bd-babb-f73a28625ca4@mailbox.org>
 <SN7PR12MB7201CF621AF0A38AA905799D8BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
 <brekq5jmgnotwpshcksxefpg2adm4vlsbuncazdg32sdpxqjwj@annnvyzshrys>
 <SN7PR12MB7201C6B5B64F8847DD6D816D8BF3A@SN7PR12MB7201.namprd12.prod.outlook.com>
 <zuj6puxpqgjmaa3y3wwyixlru7e7locplnjev37i5fnh6zummw@72t5prkfsrpk>
 <DM4PR12MB6158ACBA7BCEDB99A55ACA03CDF3A@DM4PR12MB6158.namprd12.prod.outlook.com>
 <29bc5e92-04c9-475a-ba3d-a5ea26f1c95a@mailbox.org>
 <DM4PR12MB615855ADA4F81818418FD6EBCDF0A@DM4PR12MB6158.namprd12.prod.outlook.com>
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <DM4PR12MB615855ADA4F81818418FD6EBCDF0A@DM4PR12MB6158.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 358144a9827ee41a4ee
X-MBO-RS-META: g69ksoo1z1asa47yurzwt9fgrzr3uqh6

On 10/23/25 08:35, Musham, Sai Krishna wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]
> 
>> -----Original Message-----
>> From: Stefan Roese <stefan.roese@mailbox.org>
>> Sent: Wednesday, October 22, 2025 7:08 PM
>> To: Musham, Sai Krishna <sai.krishna.musham@amd.com>; mani@kernel.org;
>> Havalige, Thippeswamy <thippeswamy.havalige@amd.com>
>> Cc: Bjorn Helgaas <helgaas@kernel.org>; Bandi, Ravi Kumar
>> <ravib@amazon.com>; lpieralisi@kernel.org; bhelgaas@google.com; linux-
>> pci@vger.kernel.org; kwilczynski@kernel.org; robh@kernel.org; Simek, Michal
>> <michal.simek@amd.com>; linux-arm-kernel@lists.infradead.org; linux-
>> kernel@vger.kernel.org; stable@vger.kernel.org; Sean Anderson
>> <sean.anderson@linux.dev>; Yeleswarapu, Nagaradhesh
>> <nagaradhesh.yeleswarapu@amd.com>
>> Subject: Re: [PATCH v2] PCI: xilinx-xdma: Enable INTx interrupts
>>
>> Caution: This message originated from an External Source. Use proper caution
>> when opening attachments, clicking links, or responding.
>>
>>
>> On 10/22/25 14:48, Musham, Sai Krishna wrote:
>>> [AMD Official Use Only - AMD Internal Distribution Only]
>>
>> <snip>
>>
>>>>> We even don’t need ravi patch, as we have tested this at our end it
>>>>> works fine by just updating interrupt-map Property. We need to now
>>>>> understand the
>>>> difference in design.
>>>>
>>>> Ok, please let us know with your findings. In the meantime, I'll keep
>>>> Ravi's patch in tree, as it seems to be required on his setup.
>>>>
>>>
>>> We tested on Linux version 6.12.40 without applying either Stefan's or Ravi's
>> patches.
>>> Instead, we applied only the following interrupt-map property change
>>> (entries 0,1,2,3) and verified that legacy interrupts are working correctly.
>>>
>>> interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
>>> <0 0 0 2 &pcie_intc_0 1>,
>>> <0 0 0 3 &pcie_intc_0 2>,
>>> <0 0 0 4 &pcie_intc_0 3>;
>>>
>>> 38:       1143          0  pl_dma:RC-Event  16 Level     80000000.axi-pcie
>>> 39:       1143          0  pl_dma:INTx   0 Level     nvme0q0, nvme0q1
>>
>> Okay. Same here. I don't need Ravi's patch for the INTx bit enabling.
>>
>> I understand that you want us to change the interrupt map in the auto- generated
>> device-tree from Vivado. Which is IMHO a bit "suboptimal".
>>
>> I would prefer to have a solution which works out-of-the-box, w/o the need to
>> manually change DT properties. Is it planned to change / fix this interrupt map in
>> pl.dtsi generated with a newer version of Vivado?
>>
> 
> Yes Stefan, this will be fixed in the newer versions and the auto-generated
> device tree will include the correct interrupt-map property entries.

Understood. And thanks the update on this.

@Bjorn & Mani, this patch can be dropped then.

Thanks,
Stefan


