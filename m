Return-Path: <linux-pci+bounces-14265-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F65999F3E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 10:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D8B94285341
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 08:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89EFF209F4F;
	Fri, 11 Oct 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WQb1NEwk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E7EB209F25;
	Fri, 11 Oct 2024 08:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728636318; cv=none; b=IDMPbiNipImjDuwxIJO3nDrZ35L2FuA6tlSYTAo8zKtHd2rtfK0Df6NEi8px5qhqlmtjL+AX0FboP6zKba762BIcmmazY3k8COlVfI4+kf3Y/o4poBSkYGbbHNvPEtwR89zg7nbsjCfx9e1ZBUB7pGFOf2f3l7cBoOMWSsqyZtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728636318; c=relaxed/simple;
	bh=Rz1JW1rIi79ZSTNSWl9Mp46JKBe8iE1qkRrozsoCn5E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bTHstFcqQqNP1dCjbadg0krwpnuuM/XWqVT6EbyNycPJ4v850gdVZDBYOmDHr6ZhpFIBSpsS8HdL4FC+AOtWe3aRmVOAxIWD4ogSPQOiETsW7IOMyxl/rIT4Wl0QYuVWG/vpKFeSb1XFaDcXBahhoxbDzPW5pjwFVGnLl8tJ7fg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WQb1NEwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7455C4CEC3;
	Fri, 11 Oct 2024 08:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728636318;
	bh=Rz1JW1rIi79ZSTNSWl9Mp46JKBe8iE1qkRrozsoCn5E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WQb1NEwkBbQe7zMcMr9j+7YfBn4W54TsKCP8ZsTiksJjGJEXO3zKxu5nes6uPr3PH
	 DR2VRIi8Ls6V548ICpgrd9YULkhxvJdjBfH4rl7XwXJe0iIER3iG6mgOAFBjuM/PK4
	 GvsAA35qe7WCV6U4hOiOATtrDq/m1qJ1l9HvQz7pUVndvnMtSQaBWzdDLh+xFUWStv
	 5Sc5j4f82f0MFrlMQ6V7GzIFJEkqL8GLhWRuyTGdHPmmDYSaV1IHK+5cfOucI/xJze
	 P9BwK87Dmpm+Qkm3He5Se1aAQix4GBcjKu8Ng0nW/AebymNv58UstIk+Bs/BJk9Te7
	 YLcJfudPayt5Q==
Message-ID: <d9ae3745-6ec6-44e6-842d-4086f50864ae@kernel.org>
Date: Fri, 11 Oct 2024 17:45:14 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/12] PCI: rockchip-ep: Refactor endpoint link
 training enable
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kw@linux.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Rick Wertenbroek <rick.wertenbroek@gmail.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, Niklas Cassel <cassel@kernel.org>
References: <20241007041218.157516-1-dlemoal@kernel.org>
 <20241007041218.157516-9-dlemoal@kernel.org>
 <20241010082223.amfboyuegxwdo5gf@thinkpad>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20241010082223.amfboyuegxwdo5gf@thinkpad>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/10/24 17:22, Manivannan Sadhasivam wrote:
> On Mon, Oct 07, 2024 at 01:12:14PM +0900, Damien Le Moal wrote:
>> The function rockchip_pcie_init_port() enables link training for a
>> controller configured in EP mode. Enabling link training is again done
>> in rockchip_pcie_ep_probe() after that function executed
>> rockchip_pcie_init_port(). Enabling link training only needs to be done
>> once, and doing so at the probe stage before the controller is actually
>> started by the user serves no purpose.
>>
> 
> I hope that the dual enablement is done as a mistake and not on purpose...

Yes, I think that was a mistake, likely when the EP mode support was added.

>> Refactor this by removing the link training enablement from both
>> rockchip_pcie_init_port() and rockchip_pcie_ep_probe() and moving it to
>> the endpoint start operation defined with rockchip_pcie_ep_start().
>> Enabling the controller configuration using the PCIE_CLIENT_CONF_ENABLE
>> bit in the same PCIE_CLIENT_CONFIG register is also move to
>> rockchip_pcie_ep_start() and both the controller configuration and link
>> training enable bits are set with a single call to
>> rockchip_pcie_write().
>>
> 
> But you didn't remove the existing code in probe() that sets
> PCIE_CLIENT_CONF_ENABLE.

Indeed. Removed. It does not seem to hurt though.

-- 
Damien Le Moal
Western Digital Research

