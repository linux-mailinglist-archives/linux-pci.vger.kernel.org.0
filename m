Return-Path: <linux-pci+bounces-14621-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA3B9A03CD
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 10:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 835E71F216D2
	for <lists+linux-pci@lfdr.de>; Wed, 16 Oct 2024 08:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F8C1D2780;
	Wed, 16 Oct 2024 08:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PdZeJ1jt"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B1C1D014E;
	Wed, 16 Oct 2024 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729066091; cv=none; b=lhMaj0kUAgpr4nNPXPR5s3O5B+xggH6bmTKs2JpkRGuLt2lkQnzIFbxun2Ro9hpT+ltsWjELLF2PamkLB/n7h0SDn8WLNqen97NLYacB/u/7FK5DdwePeW/2GWzC02NG7Hh5sdBDIWX85Y/fHtSSrcQoucsSAf2QRMiBgk6Jxbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729066091; c=relaxed/simple;
	bh=FrbqntNk8ygK1+SOiz5igmldSyPodiaS/1oL3ol2S1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VD/f441jA10T8zgi3JvTd41Gtdt+kDxstxNbS888jb4OGsalW1OuAxB0ew5T8OHDtVgTIOTaXqPSKpFjv9L3O2pYdPmKf4Xkf4lpwh4Hrg4yZU5LF9mBkuiERa6xZlWMEN3H4uE/FJah0rczdRBcMR25dByI4D1wFQo2zRbNs48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PdZeJ1jt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31986C4CEC5;
	Wed, 16 Oct 2024 08:08:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729066090;
	bh=FrbqntNk8ygK1+SOiz5igmldSyPodiaS/1oL3ol2S1A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=PdZeJ1jtW5PIZ2Op7/a8aQi5gFTJqlfC86FEyIboGjBYZKN6e7cn239KIEFlNXr+/
	 jc8tcG/Ahsph+GygoLXX6Do8RyZ3FgHnB754ogj3u4WDFy7KKW7uApPLEC2kUulSza
	 djb0vtgCvqe80a7VkSE5ifD6AC5a7OpAdzX9x1n2ekYls/LRcQUEkfFbbeDJnP/hGB
	 z/hwNU9p9UEffa2CN8ynpqbokOjVsCkYcoqwIpkQVxdoNy2watb0EW+W6a9v5FfsKi
	 BcaxJZJQkSfZxfhbD6W1seTsQr1D4E82xrmzFe77WxeR18HHQsVXbGMhIdRY7j9u/2
	 wg8c31R5csdxw==
Message-ID: <0f2cf12b-3f27-403c-802e-bb8b539766b0@kernel.org>
Date: Wed, 16 Oct 2024 17:08:06 +0900
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
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <CANAwSgRDbCCridYMciq=xSDPV0qGhs-OhCJ_uniXFbp-yM5CcQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/16/24 4:22 PM, Anand Moon wrote:
> Hi Damien,
> 
> On Wed, 16 Oct 2024 at 11:45, Damien Le Moal <dlemoal@kernel.org> wrote:
>>
>> On 10/16/24 2:32 PM, Anand Moon wrote:
>>> Hi Damien,
>>>
>>> On Fri, 11 Oct 2024 at 17:55, Damien Le Moal <dlemoal@kernel.org> wrote:
>>>>
>>>> This patch series fix the PCI address mapping handling of the Rockchip
>>>> endpoint driver, refactor some of its code, improves link training and
>>>> adds handling of the #PERST signal.
>>>>
>>>> This series is organized as follows:
>>>>  - Patch 1 fixes the rockchip ATU programming
>>>>  - Patch 2, 3 and 4 introduce small code improvments
>>>>  - Patch 5 implements the .get_mem_map() operation to make the RK3399
>>>>    endpoint controller driver fully functional with the new
>>>>    pci_epc_mem_map() function
>>>>  - Patch 6, 7, 8 and 9 refactor the driver code to make it more readable
>>>>  - Patch 10 introduces the .stop() endpoint controller operation to
>>>>    correctly disable the endpopint controller after use
>>>>  - Patch 11 improves link training
>>>>  - Patch 12 implements handling of the #PERST signal
>>>>
>>>> This patch series depends on the PCI endpoint core patches from the
>>>> V5 series "Improve PCI memory mapping API". The patches were tested
>>>> using a Pine Rockpro64 board used as an endpoint with the test endpoint
>>>> function driver and a prototype nvme endpoint function driver.
>>>
>>> Can we test this feature on Radxa Rock PI 4b hardware with an external
>>> nvme card?
>>
>> This patch series is to fix the PCI controller operation in endpoint (EP) mode.
>> If you only want to use an NVMe device connected to the board M.2 M-Key slot,
>> these patches are not needed. If that board PCI controller does not work as a
>> PCI host (RC mode), then these patches will not help.
>>
> 
> Thanks for your inputs, I don't think my board supports this feature.

The Rock 4B board uses a RK3399 SoC. So the PCIe port should work as long as
you have the right device tree for the board. The mainline kernel currently has
this DT:

rk3399-rock-pi-4b.dts

Which uses

rk3399-rock-pi-4.dtsi

which has:

&pcie0 {
        ep-gpios = <&gpio4 RK_PD3 GPIO_ACTIVE_HIGH>;
        num-lanes = <4>;
        pinctrl-0 = <&pcie_clkreqnb_cpm>;
        pinctrl-names = "default";
        vpcie0v9-supply = <&vcc_0v9>;
        vpcie1v8-supply = <&vcc_1v8>;
        vpcie3v3-supply = <&vcc3v3_pcie>;
        status = "okay";
};

So it looks to me like the PCIe port is supported just fine. FOr the PCIe port
node definition look at rk3399.dtsi and rk3399-base.dtsi.

-- 
Damien Le Moal
Western Digital Research

