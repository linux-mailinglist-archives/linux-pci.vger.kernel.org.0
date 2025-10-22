Return-Path: <linux-pci+bounces-39026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D455ABFC34C
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:38:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9F3919C44C1
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 440423491C5;
	Wed, 22 Oct 2025 13:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="K6158Wcy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B600319870;
	Wed, 22 Oct 2025 13:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761140260; cv=none; b=N5houvVNnwTK/QoPt3ubRA1RGLb0mTHsuqNx0uddfBvYpVuljmxfsnWI5P90wj9uhYORLKin2k8CdmN6Oy2lZGejl6n0zd2n6ZSosKDH5xhjoMRdbe9GD/KatlQ9IX09y+MMvZnqBiUfY2oeXMVIoiV9WXHK16S4bGd0EmmLaQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761140260; c=relaxed/simple;
	bh=bM78zcZcxf2ooIixxkmQEBOcOTvghqfII/4EoujWcjU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E/J3DQLrendkwstRNreqSdTHk647w6ROgQKJ4L/b+WPw4nApK66O/qOiu6/Eg78Ue5I25b9K1GaK0bchX+YnVbICN5/pT42bbJQk91kxVRxeB2DicEScmKG+Ewz1+1QR89SRrYri/OLdKFxec2u9v2+tr3uGwkjckpwgLbqdVEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=K6158Wcy; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cs9Fp5VDJz9tRP;
	Wed, 22 Oct 2025 15:37:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1761140254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2gGJ2j4XuU1eR+kSbHyPUvCzb9zojsG4YTdQlWdLMjQ=;
	b=K6158WcyF+BOJQFTdw7hpnl4LPtjCCwgBiCCZO314UzujaTkx27mAfeDY5kNdNKdVk0isG
	8VPHMrNfvq0ZC1yqFQMz5ULuKEl3qIJpwgDU18sOlqnIo41/WcD7wlhEaCZMekDFokhQDI
	2GEVpL7TtH0CxWs6P7aORkWFNddL+3VOAY8DtBbB+E5av5VXHzz7+L68UlqTmIjOdyeZxu
	HOYZnBAKk8EfJplVInSYNX7G1tUYZHvISQx0Tc8+xC59LATJzNcO+DdghHs6ea1IQgU+mK
	M0nVhp8ia3Bajfz0E/a56fJum/z5GuDpqcUS0w9CVvUe6GM4uJKlzWnIsoWlOQ==
Message-ID: <29bc5e92-04c9-475a-ba3d-a5ea26f1c95a@mailbox.org>
Date: Wed, 22 Oct 2025 15:37:30 +0200
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
Content-Language: en-US
From: Stefan Roese <stefan.roese@mailbox.org>
In-Reply-To: <DM4PR12MB6158ACBA7BCEDB99A55ACA03CDF3A@DM4PR12MB6158.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 4eec622a3ee0e92cfaf
X-MBO-RS-META: bxfn33oh4qooy9od7kb88eg7bpucyym8

On 10/22/25 14:48, Musham, Sai Krishna wrote:
> [AMD Official Use Only - AMD Internal Distribution Only]

<snip>

>>> We even don’t need ravi patch, as we have tested this at our end it
>>> works fine by just updating interrupt-map Property. We need to now understand the
>> difference in design.
>>
>> Ok, please let us know with your findings. In the meantime, I'll keep Ravi's patch in
>> tree, as it seems to be required on his setup.
>>
> 
> We tested on Linux version 6.12.40 without applying either Stefan's or Ravi's patches.
> Instead, we applied only the following interrupt-map property change (entries 0,1,2,3) and verified that
> legacy interrupts are working correctly.
> 
> interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
> <0 0 0 2 &pcie_intc_0 1>,
> <0 0 0 3 &pcie_intc_0 2>,
> <0 0 0 4 &pcie_intc_0 3>;
> 
> 38:       1143          0  pl_dma:RC-Event  16 Level     80000000.axi-pcie
> 39:       1143          0  pl_dma:INTx   0 Level     nvme0q0, nvme0q1

Okay. Same here. I don't need Ravi's patch for the INTx bit enabling.

I understand that you want us to change the interrupt map in the auto-
generated device-tree from Vivado. Which is IMHO a bit "suboptimal".

I would prefer to have a solution which works out-of-the-box, w/o the
need to manually change DT properties. Is it planned to change / fix
this interrupt map in pl.dtsi generated with a newer version of Vivado?

Thanks,
Stefan


