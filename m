Return-Path: <linux-pci+bounces-44344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2885AD080BE
	for <lists+linux-pci@lfdr.de>; Fri, 09 Jan 2026 10:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5897300EDFA
	for <lists+linux-pci@lfdr.de>; Fri,  9 Jan 2026 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17F0932ED36;
	Fri,  9 Jan 2026 09:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UEnrO90e"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18A619D8AC;
	Fri,  9 Jan 2026 09:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767949337; cv=none; b=QHsicN31C2f1C4mhzNkpLPiP/2bFDGjo1XJ5LiDkL7rVU4dMp3C8tKayW/f0jSMygSRy5YFZ0kXxLWOZrI5ZA+qW5duvXvFzx17OFNgB8LxsIvKvEzLG8jXdqZc5KISgYAMje8v8Ieby015dIaMPPjf89czSnBvYYHoifsIdOM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767949337; c=relaxed/simple;
	bh=Xg6PsXa8GhzoKCwVHsdcHep1mSyOFfXyx28YBPInsTU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NF3e8P/wr4uyX1O7aTeOQR5Y+LkGAT4V7FoafkRsosHDKk4qr454eD9uD556zAt5nv69sqoA0htr47buZNbk0hItbg3S+cnxPOf+TjHkZCvk1jv34BaVPa5duX5Z+dzaf1bsROhvdxIHp+0FyG4QwrJzn68reNzlzy8L85UR8f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UEnrO90e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D77EC4CEF1;
	Fri,  9 Jan 2026 09:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767949336;
	bh=Xg6PsXa8GhzoKCwVHsdcHep1mSyOFfXyx28YBPInsTU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UEnrO90e6vUGRJvbEotFLhyBspaOhiJhRju3ljNpPEDk8S8sKAI6JDkWzk3xfZmwe
	 Nz80IvLF6uvjmM1CAo/hAOqm+YH5lDG7FtaZWnoRTBmBj+8Cq6Ben81yaTTp7juxNB
	 0MB27QBsKdE6fC9o7ooRkGa5GaZ62H1BOVSxJVA2wgdEbjl3R4lLOMT0EK0GdfKJh/
	 vjGb6Q/EFnIsLTbNTkomTlvxkdiQK+SmcCx+4labfuhkKjdmsw0Ndppvn2Peo9Yb4D
	 0UuLNVzDfyGlkEjzU3TtR95OYS+NjPTQQKU2v9iFpGssxH4JAxx0Fc7InC1vMcAGFd
	 G8eWfgvMaTqiQ==
Message-ID: <375ea14c-b089-4ae4-9827-5c19139f69c4@kernel.org>
Date: Fri, 9 Jan 2026 10:02:10 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/5] power: sequencing: Add the Power Sequencing driver
 for the PCIe M.2 connectors
To: Manivannan Sadhasivam <mani@kernel.org>,
 Bartosz Golaszewski <brgl@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com,
 Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, Stephan Gerhold <stephan.gerhold@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 linux-pm@vger.kernel.org, linux-ide@vger.kernel.org
References: <20260107-pci-m2-v5-0-8173d8a72641@oss.qualcomm.com>
 <20260107-pci-m2-v5-5-8173d8a72641@oss.qualcomm.com>
 <CAMRc=Md9TQiSX-gFa5q--JgaGyQ2ky4mOwjSpdxHhvHAj-X5Qw@mail.gmail.com>
 <xd5uvfqcx3vcbcqerji556ejstmgvtci4chfzxclkzhizqmqxa@xusf2skt6xhh>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <xd5uvfqcx3vcbcqerji556ejstmgvtci4chfzxclkzhizqmqxa@xusf2skt6xhh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 1/9/26 07:02, Manivannan Sadhasivam wrote:
> On Thu, Jan 08, 2026 at 01:15:12PM +0100, Bartosz Golaszewski wrote:
>> On Wed, Jan 7, 2026 at 3:11 PM Manivannan Sadhasivam via B4 Relay
>> <devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org> wrote:
>>>
>>> From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>>
>>> This driver is used to control the PCIe M.2 connectors of different
>>> Mechanical Keys attached to the host machines and supporting different
>>> interfaces like PCIe/SATA, USB/UART etc...
>>>
>>> Currently, this driver supports only the Mechanical Key M connectors with
>>> PCIe interface. The driver also only supports driving the mandatory 3.3v
>>> and optional 1.8v power supplies. The optional signals of the Key M
>>> connectors are not currently supported.
>>>
>>> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
>>
>> This looks good to me, though there are some nits I may fix when applying.
>>
>> I'll pick it up for v7.0 once the bindings are reviewed.
>>
> 
> Ok. I'm expecting patch 1 to go through ATA tree, patch 2 through DT, and
> patches 3,4 through PCI tree.

Patch 1 seems to be completely unrelated to the power changes, so please send it
to the ata list separately. It is otherwise very complicated and confusing for
everyone to have patches from one series being applied through multiple trees.


-- 
Damien Le Moal
Western Digital Research

