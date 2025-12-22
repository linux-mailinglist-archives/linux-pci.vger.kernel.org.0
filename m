Return-Path: <linux-pci+bounces-43511-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51332CD52A6
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 09:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8A71830022D3
	for <lists+linux-pci@lfdr.de>; Mon, 22 Dec 2025 08:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768493090CC;
	Mon, 22 Dec 2025 08:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OlaqKPzv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B642405ED
	for <linux-pci@vger.kernel.org>; Mon, 22 Dec 2025 08:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393362; cv=none; b=iDPxYA8v4RjjVbarYjgsRiVOk5bVqkbGrMx1njb72tGf1LErUp4/exd9Ph1jXxzqRUEQHqnyj8ILBL1889W4R3wEDbOzhlg2G44XFnCU1kptkLoDFxgdMQnXJuAhngCdojqHomkeiik7JE/kQ8xHpikmqgj3p4AZXtgREQm2mTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393362; c=relaxed/simple;
	bh=lGYe4SrAQ5Z8Ufdx+swBTt8GT+eQWM3pprHLNUV2L/Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TCBDIzHk9c5k8WLnnUOUkTDcfb5ULwzelbv5EY/5ftsm1/0tuZ3gpCKZXdmOoRXhkEHWIdnR+fFtDXIreYEUQsA6mP4aCNZVPsE/TZCdyi+GePLZ3Ox1tbzoY9ob2G66qSH5EZi4gWAkAutpq1srYG/WPdqfpioGw05Q84vfttw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OlaqKPzv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45D52C4CEF1;
	Mon, 22 Dec 2025 08:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766393361;
	bh=lGYe4SrAQ5Z8Ufdx+swBTt8GT+eQWM3pprHLNUV2L/Q=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=OlaqKPzvixpFd7kDcohzwTGk8qpczpdyA32gxkUkzI1De0tvRKxSCVrkz5afWH747
	 SHuHyridHxjSYUnvEZvttvn91cCYfA/lep4JbjHxgiRzjuylHeeQMR7gG8jf4ZHd9B
	 fnSZjIUrYd4yBTUdA81bD2Rym9B6rmWd0SYeajSsao6g/MUUQpdHX17YVBPNqlib3H
	 grFVOSpbmQKYMK1kX+hZxhy5e0xSJNGfA8k9CsWObmug8bSBbNuP/yDGRcOC5K+E15
	 QN+MotGgEg7m/ZWkmxbMrUbcUMbbRqVnld+/ZwLpJ2yuYFZXeMyyTillTbMdTyTpCn
	 VamLdZO8eDTNw==
Date: Mon, 22 Dec 2025 09:49:20 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
CC: Jingoo Han <jingoohan1@gmail.com>, Manivannan Sadhasivam <mani@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>,
 Koichiro Den <den@valinux.co.jp>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: ep: Cache MSI outbound iATU mapping
User-Agent: Thunderbird for Android
In-Reply-To: <712064a7-abb4-4cad-b6a6-b5c3a8faadea@oss.qualcomm.com>
References: <20251210071358.2267494-2-cassel@kernel.org> <8e00bd1c-29ae-43fd-90e8-ea0943cb02b6@oss.qualcomm.com> <aUkC-_pko_cItpKP@ryzen> <712064a7-abb4-4cad-b6a6-b5c3a8faadea@oss.qualcomm.com>
Message-ID: <5254D564-D848-4112-8C91-A0621353CE0A@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22 December 2025 09:42:50 CET, Krishna Chaitanya Chundru <krishna=2Echun=
dru@oss=2Equalcomm=2Ecom> wrote:
>> I guess we will need to come up with something else for the MSI-X case=
=2E
>>=20
>>=20
>>> Use the MSIX doorbell method which will not use iATU at all,
>>> dw_pcie_ep_raise_msix_irq_doorbell()=2E
>> AFAICT, right now, the only driver ever calling this function is:
>> drivers/pci/controller/dwc/pci-layerscape-ep=2Ec
>>=20
>> Are you suggesting that we somehow change all the other DWC based EPC
>> drivers' =2Eraise_irq() callback to call dw_pcie_ep_raise_msix_irq_door=
bell()
>> instead of dw_pcie_ep_raise_msix_irq() for case PCI_IRQ_MSIX ?
>Yes=2E
>> That sounds like a big change that would need to be tested and verified
>> for each DWC based EPC driver=2E
>I agree, but this will be clean solution to avoid iATU for MSIX=2E

I agree that this sounds like a nice solution for those platforms that can=
 use it=2E

But, for platforms that might not be able to use this method (not sure if =
this is possible with all versions of the DWC core),
we probably still need to come up with some other solution to this problem=
=2E

It would also be nice with some solution that can be used until all driver=
s have been converted=2E


Kind regards,
Niklas

