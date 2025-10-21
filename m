Return-Path: <linux-pci+bounces-38855-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BED2BF4FF8
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 09:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACC68403FD1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 07:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C498427AC5C;
	Tue, 21 Oct 2025 07:37:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB16A27FB34
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032235; cv=none; b=BJPDbjlUAOMAykj6K5yq6bvDyEWmpzYaZBzqxi3tRIGXa+BxY9j+ID334TvrcUmXzNxHR4fNLulJz9m3sdniYKlCM1Lo3Tb1JZEd77Whbsm278RYXy1pmHgAWNANw7Na4Fp1/4xLi1zAJLNh7sg6tzyvUsxBGcy02W+LgF0j8gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032235; c=relaxed/simple;
	bh=7SSh1YM/csH2ZXkYLwsJS3nVtXPyjmFqraaSLDNmPN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sbLw9w38fZvdeu1e0TTNMLz+ZH/Fl73ubPXAC0RicRCT6W7n0TTIAjhoKPw+b8+gNGc/FILrmU8UXUUyMi1+Zh3MxoqcHgyFmuiGRR+IyQgzHlSHFJHZXNugVk36stMbebGNZepRq9El+e8bg6lHKpm87M59iTcr/qio8ofgz78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id 8BD422008033;
	Tue, 21 Oct 2025 09:37:10 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 703444A12; Tue, 21 Oct 2025 09:37:10 +0200 (CEST)
Date: Tue, 21 Oct 2025 09:37:10 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Mario Limonciello (AMD) (kernel.org)" <superm1@kernel.org>,
	=?iso-8859-1?Q?Adri=E0_Vilanova_Mart=EDnez?= <me@avm99963.com>,
	Bjorn Helgaas <bhelgaas@google.com>, regressions@lists.linux.dev,
	linux-pci@vger.kernel.org
Subject: Re: [REGRESSION] Intel Wireless adapter is not detected until
 suspending to RAM and resuming
Message-ID: <aPc4JpVyhCY1Oqd-@wunner.de>
References: <149b04c5-23d3-4fd8-9724-5b955b645fbb@kernel.org>
 <20251020232510.GA1167305@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251020232510.GA1167305@bhelgaas>

On Mon, Oct 20, 2025 at 06:25:10PM -0500, Bjorn Helgaas wrote:
>   [    0.113379] pci 0000:00:1c.0: [8086:9d10] type 01 class 0x060400 PCIe Root Port
>   [    0.113403] pci 0000:00:1c.0: PCI bridge to [bus 01]
>   [    0.113409] pci 0000:00:1c.0:   bridge window [mem 0x91000000-0x910fffff]
>   [    0.115692] pci 0000:01:00.0: [8086:095a] type 00 class 0x028000 PCIe Endpoint
>   [    0.115830] pci 0000:01:00.0: BAR 0 [mem 0x91000000-0x91001fff 64bit]
>   [    0.196539] pcieport 0000:00:1c.0: pciehp: Slot #0 AttnBtn- PwrCtrl- MRL- AttnInd- PwrInd- HotPlug+ Surprise+ Interlock- NoCompl+ IbPresDis- LLActRep+
>   [    0.196802] pcieport 0000:00:1c.0: pciehp: Slot(0): Card not present
>   [    0.196925] pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
>   [    0.196927] pcieport 0000:00:1c.0: pciehp: Slot(0): Link Up
>   [    1.400127] pcieport 0000:00:1c.0: pciehp: Slot(0): No device found

Does this flap of the Presence Detect State bit also happen with
4d4c10f763d7?  AFAICS, no dmesg output has been provided yet for
the working case.  It would also be good to have debug output enabled,
i.e. set CONFIG_DYNAMIC_DEBUG=y and add this to the command line:

  pciehp.pciehp_debug=1 dyndbg="file drivers/pci/* +p"

Does it help if in drivers/pci/hotplug/pciehp_hpc.c:pci_bus_check_dev(),
the "delay" is initialized to a higher value, say, 5000 instead of 1000?

Thanks,

Lukas

