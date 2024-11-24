Return-Path: <linux-pci+bounces-17265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3359D7559
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 16:36:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3A522875CE
	for <lists+linux-pci@lfdr.de>; Sun, 24 Nov 2024 15:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98A1918A6DF;
	Sun, 24 Nov 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NS0edT7p"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7F218FC9F;
	Sun, 24 Nov 2024 15:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732461976; cv=none; b=GkkwE0U0QTv56JolIB3Oje0CCPlp1Ck0l47K+v0wwsE4tYlsCvPr2s4qjJCyq4LJAJgXF5Sug6TypSr0oxpRAcC5HnJuS7ibLxrd4rUMREd///8HQkdLW3ECpqhI/ZePabFCtteML2Y/sZK2nNQwb/k4gmqfMPSkUTZUf9ZZreQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732461976; c=relaxed/simple;
	bh=x15zhF9GW0i/jB5F4aM+ww3ByyaY8y3kDOuMbCCVrlA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=qv01Z3eOm1A4kSFphAUm9Wzop6t2HrxWH8uC9HF1zmzS2/4+Ae1MbE7LvQo5Mbup+A8LVVr/lIR3g2EpzCR85g1FOmhVkPdkMHdyJUwCIhROrCBz2cujU5p2sUaofizgJQrV6MSJTZgxa3m7+hGW7TvAKoAUoOgdvjNasBh+kyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NS0edT7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B2C9C4CECC;
	Sun, 24 Nov 2024 15:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1732461976;
	bh=x15zhF9GW0i/jB5F4aM+ww3ByyaY8y3kDOuMbCCVrlA=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=NS0edT7pdihHuaSLhTj0mB3QGaWr+bZiDWNrGAI9JoKJFBPTYkvoZqlknaRZETY8R
	 legxidwxNwveE3K0UGcOWRLTF7eIS7G2aHw44AZUMjrhUpJOukQCNTvoMN+f/BEgt3
	 3qNe6uvT9Po34PoCC4vLcG6+kI8U8lHp37c4Ke5ia4KSeiSkq6F06SBU0gUjS8wDDk
	 DB/z8YHlm91qTEUS7+s/gRUGeWP2A+PnZ6dJJPa9gcZAccCi9iZaBxZ3frK7Ri4Xab
	 4tjWSVMPvLK4Wmh5dzghFgdXKpfHB24wF5i18vfoqs4WuptKKMjiwevNK/bQquFe/p
	 XUR0iJBIPGzQQ==
Date: Sun, 24 Nov 2024 16:26:14 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Frank Li <Frank.Li@nxp.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, imx@lists.linux.dev,
 dlemoal@kernel.org, maz@kernel.org, tglx@linutronix.de, jdmason@kudzu.us
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v8_2/6=5D_PCI=3A_endpoint=3A_Add_RC-to-EP?=
 =?US-ASCII?Q?_doorbell_support_using_platform_MSI_controller?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20241124131701.yrb4bkhwigcux6b4@thinkpad>
References: <20241116-ep-msi-v8-0-6f1f68ffd1bb@nxp.com> <20241116-ep-msi-v8-2-6f1f68ffd1bb@nxp.com> <20241124071100.ts34jbnosiipnx2x@thinkpad> <113B93C0-8384-431A-BE4D-AA98B67C342A@kernel.org> <20241124131701.yrb4bkhwigcux6b4@thinkpad>
Message-ID: <066A8516-07D3-43F0-A135-9F4360FE9698@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 24 November 2024 14:17:01 CET, Manivannan Sadhasivam <manivannan=2Esadh=
asivam@linaro=2Eorg> wrote:
>On Sun, Nov 24, 2024 at 10:56:38AM +0100, Niklas Cassel wrote:
>>=20
>> I'm okay to change the error print as you suggested, but in that case I=
 really think that we should add a comment above the check, something sugge=
stive like:
>>=20
>> /*
>>  * The pcie_ep DT node has to specify
>>  * 'msi-parent' for EP doorbell support to work=2E
>>  * Right now only GIC ITS is supported=2E
>>  * If you have GIC ITS and reached this print,
>>  * perhaps you are missing 'msi-parent' in DT?
>>  */
>
>Looks good to me (except that the comment needs to fit 80 columns) :)

Sorry about that, I wrote the reply from my phone :D


Kind regards,
Niklas

