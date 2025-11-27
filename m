Return-Path: <linux-pci+bounces-42189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD3BC8D274
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 08:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 3777C34CCA5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Nov 2025 07:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA8431C58A;
	Thu, 27 Nov 2025 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n2qhreBZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10B731618C;
	Thu, 27 Nov 2025 07:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229427; cv=none; b=B/VGd1A3RA8V3f5flzgyHQwhzler7Fn/y7QYwThWVzGmZpA0rJwd/TPWLJHEULibEhIwW5aZXOQ2li5sMGd/t00Gy+BES3eEDPAcoWs7dQD3gsZVFV0c2aTVAEqawsaHv0+feV7y8UBb5/lUpKT2q+PlsDSmE4dqR44iaqO5so4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229427; c=relaxed/simple;
	bh=stfZYo+TOb5/udfo8Ni52S3dEgdKEJoaTftGPEkaTEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kUqtJI3/HW+3Juzospy+Ex35KEOA2QUsbfHbxagm5hrukV0dGmdpdqSf8g2a4dPD6lhuuj9GJl/OXOKhqBPZEfGrAc0BfKPGUF3kC9lE9c0ObP5aRbefdauPHP5VOlB6jxDEvK1VdzaX9sLoYJzuHs4UHZXeMfxjiSmm56qKW2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n2qhreBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C097C4CEF8;
	Thu, 27 Nov 2025 07:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764229427;
	bh=stfZYo+TOb5/udfo8Ni52S3dEgdKEJoaTftGPEkaTEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n2qhreBZ6hx5qKaCQD/Ummy08gyYqCO2jKo6y4KlAWs6fsaomo28Rkfmj8hLIA7Ro
	 ua3cW71SxmOAIGMzNb+r/J73tDPM0Jb3kHqqC+Ek6jHOhtj94HTgQ7ZHjJJeBuY3fK
	 8L2DRE+BkndgKHhIDgVfwtVNbHlSya8cCZwdkV4iKC1Ii75+ISf+nxYHzWhAc4ld31
	 EQQRHl+kbzAhd89CDlVtnrDnMFc28chxSunAM/vnmu9Xu3QUsrTI+ksnEP7mOWaNwB
	 U7on4MYwJ/qEX92ONC+CrvivQHzi3tOqNaQs0SzMFnlE1cKMCF+4WgEhB/0tdw7Qtq
	 suC8JCokvLrfA==
Date: Thu, 27 Nov 2025 08:43:41 +0100
From: Niklas Cassel <cassel@kernel.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH 0/6] PCI: dwc: Revert Link Up IRQ support
Message-ID: <aSgBLQ7rDOiEFhMB@ryzen>
References: <20251111105100.869997-8-cassel@kernel.org>
 <mt7miqkipr4dvxemftq6octxqzauueln252ncrcwy6i2t7wfhi@jtwokeilhwsi>
 <aSRli_Mb6qoQ9TZO@ryzen>
 <7667E818D7D31A4E+cf7c83d4-b99c-469d-8d46-588fc95b843f@radxa.com>
 <F11F0D13437B012D+0c15c5ca-f64f-49f1-9ff5-26b88d59ff59@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F11F0D13437B012D+0c15c5ca-f64f-49f1-9ff5-26b88d59ff59@radxa.com>

Hello FUKAUMI Naoki,

On Thu, Nov 27, 2025 at 04:34:53PM +0900, FUKAUMI Naoki wrote:
> Hi all,
> 
> I'm very sorry, but my ROCK 5C appears to be unreliable. (It worked fine
> with vanilla v6.13, so I thought it was fine.)
> 
> I replaced it with another 5C (Lite), and now every method (Niklas's patch,
> Shawn's patch, and applying patch 1 and 2) seems to work.

Could you please give us some more information.

Does the Rock 5C Lite have a PCIe switch?

Does Rock 5C Lite work fine with the current code in mainline?
(i.e. with bus enumeration when Link Up IRQ is triggered).


Kind regards,
Niklas

