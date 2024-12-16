Return-Path: <linux-pci+bounces-18478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F599F29C8
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 07:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9981648F2
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 06:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6F81BC064;
	Mon, 16 Dec 2024 06:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgmchC39"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AC94C7C;
	Mon, 16 Dec 2024 06:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734328821; cv=none; b=qTZotj4lwaoFuY+QLygd2oI8+PX5r7IV9DQ3oix5UH1cU8RpwqTATbsgYdpGqYsnAp/JUP7DaoGvRKO8QtcPG1yNCSuMnZEih7RHKoK7wPwm5TRLu8Z5e0ZoxqD23xsANngqHUJjXwpip35MfIXBmgnBnji5w4Cs8e35rWcb6eI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734328821; c=relaxed/simple;
	bh=bN6Mk/xRm/WwBSgPyNIv9xzDr9WBPJDR6DaiXA2uEqg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=GVbqx8SDiHwRfC/myFXxrf+vnZaOsh92tBuQDVDrvo0wvjKfuNuRzAcsFqNOIbyKDvssVeFfzgLsXL2+Z7rsszDmcoMsKmY/mMmeknRYueLKl6w34K38QxHHAHKQMln4XPa74R8vpyCUlYONsxBaVhOxQvHGG5TWSdYoM7+833I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgmchC39; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D62C7C4CED0;
	Mon, 16 Dec 2024 06:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734328819;
	bh=bN6Mk/xRm/WwBSgPyNIv9xzDr9WBPJDR6DaiXA2uEqg=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bgmchC39k4BQs9D/GWI4ttCgXXrg+Vt0ouNMJzFZU7KuFCcO2AeQPpuHOwloTkHKN
	 Zn1I4mljPuVcDvuPzslufPNU/6tzid0Dr4SFZv1i0LwthZc6xMnMxB5flJOlXAvMUv
	 bTWCfKkSckr++rX9fHAjMPx57a4xAkl1KIdst6+ky9hdxPXwN3o7xn6s4yi+/xNlTP
	 UvuGREJhQsgBXre3Mwc/n/tKx6cErVuTtfQvMr1ryUW/JCmHd1xFtTTeLXE4pY1iMb
	 AQ7GuPXWVZR4pNJhxf6YHBpI/u4uFZQobbnT/SezVg0kZvQNx11wcXtWJJ+qQLl7BX
	 koP4pM7PMM89Q==
Date: Mon, 16 Dec 2024 07:00:16 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Damien Le Moal <dlemoal@kernel.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>
Subject: Re: [PATCH v5 00/14] Fix and improve the Rockchip endpoint driver
User-Agent: K-9 Mail for Android
In-Reply-To: <20241216054953.kj43om6fbjksbjcy@thinkpad>
References: <20241017015849.190271-1-dlemoal@kernel.org> <20241216054953.kj43om6fbjksbjcy@thinkpad>
Message-ID: <45CC5230-1DFD-4F7E-A0E6-F4FAC5586038@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 16 December 2024 06:49:53 CET, Manivannan Sadhasivam <manivannan=2Esadh=
asivam@linaro=2Eorg> wrote:
>On Thu, Oct 17, 2024 at 10:58:35AM +0900, Damien Le Moal wrote:
>> This patch series fix the PCI address mapping handling of the Rockchip
>> PCI endpoint driver, refactor some of its code, improves link training
>> and adds handling of the PERST# signal=2E
>>=20
>> This series is organized as follows:
>>  - Patch 1 fixes the rockchip ATU programming
>>  - Patch 2, 3 and 4 introduce small code improvments
>>  - Patch 5 implements the =2Ealign_addr() operation to make the RK3399
>>    endpoint controller driver fully functional with the new
>>    pci_epc_mem_map() function
>>  - Patch 6 uses the new align_addr operation function to fix the ATU
>>    programming for MSI IRQ data mapping
>>  - Patch 7, 8, 9 and 10 refactor the driver code to make it more
>>    readable
>>  - Patch 11 introduces the =2Estop() endpoint controller operation to
>>    correctly disable the endpopint controller after use
>>  - Patch 12 improves link training
>>  - Patch 13 implements handling of the #PERST signal
>>  - Patch 14 adds a DT overlay file to enable EP mode and define the
>>    PERST# GPIO (reset-gpios) property=2E
>>=20
>
>Damien, please wait for my review before spinning the next revision=2E So=
rry for
>the delay=2E

Mani,

This series has already been merged, and is in Torvalds tree=2E

Except for patch 14/14 which is a device tree overlay, so it should go via=
 the rockchip tree=2E


Kind regards,
Niklas

