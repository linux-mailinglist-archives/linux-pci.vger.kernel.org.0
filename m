Return-Path: <linux-pci+bounces-38562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C38BEC972
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 09:40:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87173583F32
	for <lists+linux-pci@lfdr.de>; Sat, 18 Oct 2025 07:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6B9277C9B;
	Sat, 18 Oct 2025 07:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="nFZApW6u"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9531339A4;
	Sat, 18 Oct 2025 07:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760773204; cv=none; b=sCFBO4Bk9EKDMDtDUU+AWQk0DSDdzRW9rFs+/2nJxKuaf4vw/e9Bwx5O9/aHv4hxtxrNynurl8eahEWMIjKPJM8MZ29KsI4GWcdgoWr+WOmwl8Nuc4Rp706YF/D3QHRyM2vjYfzHaaF8IVuiCpFo3NUroki2oa1sSgxG9KFRXhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760773204; c=relaxed/simple;
	bh=8Fz3phuxbtV02HdHTRSHw7+Hhf4cfXgZuaz2xcN8tt8=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=ojecHT7AdPA6SXxJFeRz7y2yltIUVRAlQuPlOytDdHztRxZmMz1ft8l30SNVcP80TUQP+zdsGiW6C7K8gNIflVB+v3Zpu6aU7/77Y5omavmBu1bOunf5ceBmwdkq+L0Qqi6+9mzbC2wFLlG67JiPFtKjhLUrjvtVSEjBJ2i0nQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=nFZApW6u; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760773174; x=1761377974; i=markus.elfring@web.de;
	bh=ITeyYImjcRv6uHjygXjrqGCaO48d/NPR0/Y/rveSIeQ=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=nFZApW6u/xbFjOfNgbumI7ETqwdfOVRRNfomaX352cczpAoavVVhas59dBkHrjvQ
	 ScdKOvIuOEG3FDRXaW3iTrI2DzHmtqx1MD2uK0tgg/9ndFSskqQN0ejMzM14h6og1
	 ho9YJ9SZ9H030m24GrNU+F7oGrJRPmX3YlB3xgdixDOgpYtr0UvHUdJrO3YsBV/cK
	 O3vHZlGKptS+OY3H8LJ3QM46lKUWjuqJwJHeSVi9t1XyZO029TjS3RGH/2gm14Npd
	 P/Bau0hvKJjCLmDW8tNm2wmwKe+hi1fh/LQvXgPDjQ5aFVR1vSLoe+xYDOIWGe7pd
	 VcWd5GWUEsrAYg01EA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.233]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MDvDi-1v2M1S2D48-003KES; Sat, 18
 Oct 2025 09:39:34 +0200
Message-ID: <071f563c-6d09-46ea-870b-a51e0522bfad@web.de>
Date: Sat, 18 Oct 2025 09:39:32 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Anand Moon <linux.amoon@gmail.com>, linux-pci@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <20251018061127.7352-1-linux.amoon@gmail.com>
Subject: Re: [PATCH] PCI: rockchip: Propagate dev_err_probe return value
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251018061127.7352-1-linux.amoon@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:mSFJRFZrf1ftMXlRfbnZEziBky4zoKY/CmZ9vZ1ELb8LPcTTZgz
 TyTWSzPXwDD+aIzudBpUPacahlmJE3Ggj51Jt+9nK1jGA3wZaz9YrzgJNv765Uc3pnFT6Qy
 ttaFVVKbxugIR35mzKn/fKY5zCo1TiVgVHoMRvxmdE1nZvf2OUQzm/CdSoejcIzasIoN6LT
 OGEFRcRpU54Su5k57VE1g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3bmeeKbiof8=;772G4JCpimTY2LYPwK0UUB1vofa
 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
 PCUfhQ77sKex7eo7uemJDBh8kK0R9Hw6anE=

> Ensure that the return value from dev_err_probe() is consistently assigned
> back to return in all error paths within rockchip_pcie_init_port()
> function. This ensures the original error code are propagation for
> debugging.

I find the change description improvable.


Would an other source code variant become more desirable?
https://elixir.bootlin.com/linux/v6.17.1/source/drivers/base/core.c#L5031-L5075

	err = dev_err_probe(dev,
			    reset_control_bulk_assert(ROCKCHIP_NUM_CORE_RSTS, rockchip->core_rsts),
			    "Couldn't assert Core resets\n");
	if (err)
		goto err_exit_phy;


Regards,
Markus

