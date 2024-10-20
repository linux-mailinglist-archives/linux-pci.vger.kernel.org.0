Return-Path: <linux-pci+bounces-14913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1846E9A51D5
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 03:07:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7349B22878
	for <lists+linux-pci@lfdr.de>; Sun, 20 Oct 2024 01:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06661392;
	Sun, 20 Oct 2024 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CP5lx5ND"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705051373;
	Sun, 20 Oct 2024 01:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729386418; cv=none; b=Jwp4hw28CYI1A61amTXefaxpOxPjQakc1yXObVAy40ZCeswAVEpXdPPuO7Z9XgiN3H6Cm7KInoicZEcxivs4C57HS+Ea95218tQmKFfSkg8JVn3EBe0sNOcMLm8iSAy4WGZQYE4PfVZd+X0Lq6Vap3TTWOWJ1IO8n45w2wGAWyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729386418; c=relaxed/simple;
	bh=QykmPv/BE6IkDfW5xnvum0kBf+OEw3Cv6VurB2ePnZU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T2rnRblaAe0qiOXoCC28f12VlRP48s9CVYm5V40HW1Je0iTXl0cMr6vz4Ux84lPRKTiNyxbEainp0EN1ySiJDT84Ddl2rfx0CUXfzBgboT3ESGbI92RXJlBd0/3Ij9naMXCEuTHrt15esDK+Mb6KXrCFLoLvPQRPgN09Q9DQIVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CP5lx5ND; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C04FC4CEC5;
	Sun, 20 Oct 2024 01:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729386418;
	bh=QykmPv/BE6IkDfW5xnvum0kBf+OEw3Cv6VurB2ePnZU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CP5lx5NDeHvNn1dsSX9/F0Nl0iOQemMFzRDokTKuQD90OB5AC8Gyb8/cu/az29bX+
	 yRp4Pr6Ydv4aSBtadDIXn4bG/M0kv7v4nBMG51XglANyLJ730E4nlwl4vFfcT6SJd/
	 GmF4TqhWcvUEV0UJo8/N2rWTNw/rVXnguKGdsZc7HWhTkEEqzOnnqTnwCaUpWh3R6V
	 4VxZB5rJjgsbZX5WqtlVQtmLrVQv1dzEpkp2NFLQO7TDiRxpKUcVNcEZVyEg92ms2N
	 uH+ZamMstcWnbIvYTND0oisZ7C2XH39drySY0QEmrQf2b0c+8WfgCLzaKmcoahMM+y
	 kctDBFacgFexg==
Message-ID: <6aa0a404-9bc8-4b0c-b6f9-a455a3033670@kernel.org>
Date: Sun, 20 Oct 2024 10:06:54 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/12] Fix and improve the Rockchip endpoint driver
To: Anand Moon <linux.amoon@gmail.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Niklas Cassel <cassel@kernel.org>
References: <20241011121408.89890-1-dlemoal@kernel.org>
 <CANAwSgQ+YmSTqJs3-53nmpmCRKuqfRysT37uHQNGibw5FZhRvg@mail.gmail.com>
 <f13618a6-0922-4fc8-af01-10be1ef95f0d@kernel.org>
 <CANAwSgRDbCCridYMciq=xSDPV0qGhs-OhCJ_uniXFbp-yM5CcQ@mail.gmail.com>
 <0f2cf12b-3f27-403c-802e-bb8b539766b0@kernel.org>
 <CANAwSgRXfZ9hgdJpSrwucHQfMToZwSC8N-b4MYLZjsryid=Fpw@mail.gmail.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CANAwSgRXfZ9hgdJpSrwucHQfMToZwSC8N-b4MYLZjsryid=Fpw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/19/24 15:24, Anand Moon wrote:
> I have a question can new test external low power GPU with external cables
> which supports PCI host (RC mode) with external power supply for GPU card.

I do not understand this sentence.

> Which mode is suitable for the PCIe endpoint controller or PCIe host controller?

If you do not know/understand what PCI endpoint is, you probably do not need it
at all. If you are using your board to simply connect and use regular PCI
devices, you do not need the PCI endpoint framework/drivers.

-- 
Damien Le Moal
Western Digital Research

