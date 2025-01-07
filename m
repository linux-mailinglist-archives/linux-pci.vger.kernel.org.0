Return-Path: <linux-pci+bounces-19387-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5669DA03905
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 08:48:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63DDC1650B3
	for <lists+linux-pci@lfdr.de>; Tue,  7 Jan 2025 07:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58501DFDAF;
	Tue,  7 Jan 2025 07:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="StPlvgmg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m15574.qiye.163.com (mail-m15574.qiye.163.com [101.71.155.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046F71DDC1F;
	Tue,  7 Jan 2025 07:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736236098; cv=none; b=gpfOi1QfG5bfL86QI9bxiJbBBSjRRAdNZvQpc9CQOeGRYAsowye5h6T3KDjVoOYETVxY5mBYxRYSadAjUYBAXJCd+2MMFtn6KNfrxkgephqtdki36Nq4exfz/IYYaumSDh8cXm9OIaaJ3V1sIqWo892JVb1ltx5/HjWD/paV/UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736236098; c=relaxed/simple;
	bh=gGptPtNh89lKw8ky5xWKZn1GCqD63iRpNzT9mYL9C2o=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=UEXuJhMvnz27QrwnsUnbD2P3gtNAy80XDFyy5BhJ4FEY814qomW+6OA3s2OvcVngiUZMY+me4/73oNIsdedC1Szhfb3mZhGjxay4nVPgU6tnGzwtSMm/pxO3z7nwUA1OZ+8OERVevaU74ywyT4WUt/2ILgD78ScDKvep26qTZh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=StPlvgmg; arc=none smtp.client-ip=101.71.155.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.67] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 7f39843f;
	Tue, 7 Jan 2025 15:48:08 +0800 (GMT+08:00)
Message-ID: <82848f35-73d8-4254-a818-59495f96bcf2@rock-chips.com>
Date: Tue, 7 Jan 2025 15:48:08 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Kever Yang <kever.yang@rock-chips.com>
Subject: Re: [PATCH v3 2/7] dt-bindings: PCI: dw: rockchip: Add rk3576 support
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, heiko@sntech.de,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 linux-arm-kernel@lists.infradead.org, Simon Xue <xxm@rock-chips.com>,
 linux-rockchip@lists.infradead.org,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
References: <20241223110637.3697974-1-kever.yang@rock-chips.com>
 <20241223110637.3697974-3-kever.yang@rock-chips.com>
 <173495701750.480868.16123444058526675248.robh@kernel.org>
Content-Language: en-US
In-Reply-To: <173495701750.480868.16123444058526675248.robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQ08ZSVYaThhKGhoYT0NDTkJWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSUhCSE
	NVSktLVUpCS0tZBg++
X-HM-Tid: 0a943fbc3d6a03afkunm7f39843f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NDY6HAw4EzIXVhMwIjJISE02
	GCtPCgxVSlVKTEhNSUhNS0JLT09LVTMWGhIXVRAeDR4JVQIaFRw7CRQYEFYYExILCFUYFBZFWVdZ
	EgtZQVlOQ1VJSVVMVUpKT1lXWQgBWUFJS0pNNwY+
DKIM-Signature:a=rsa-sha256;
	b=StPlvgmgCk5NjJLGBsbH6e3x0WpRSjrU469Y9tqJ9Aq67rrJyxLlDernhB6kB+Sl0M+l6f4NjPGze89Qz1Vx/j6HzIh4b6iCY2k8Wm3hLVy4kb/z90+aLL4LYWcARNQue3FGR2L34kCCkBsaq4HBomb0fOpCWsyymIo/uDADHEU=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=7dY7cGRSnsKC1U8wn2NYn8pujnABECXqtMmusYeeylE=;
	h=date:mime-version:subject:message-id:from;

Hi Rob,

On 2024/12/23 20:30, Rob Herring (Arm) wrote:
> On Mon, 23 Dec 2024 19:06:32 +0800, Kever Yang wrote:
>> rk3576 is using dwc controller, with msi interrupt directly to gic instead
>> of to gic its, so
>> - no its suport is required and the 'msi-map' is not need anymore,
>> - a new 'msi' interrupt is needed.
>>
>> Signed-off-by: Kever Yang<kever.yang@rock-chips.com>
>> ---
>>
>> Changes in v3:
>> - Fix dtb check broken on rk3588
>> - Update commit message
>>
>> Changes in v2:
>> - remove required 'msi-map'
>> - add interrupt name 'msi'
>>
>>   .../devicetree/bindings/pci/rockchip-dw-pcie-common.yaml      | 4 +++-
>>   Documentation/devicetree/bindings/pci/rockchip-dw-pcie.yaml   | 4 +---
>>   2 files changed, 4 insertions(+), 4 deletions(-)
>>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/pci/rockchip-dw-pcie-common.yaml:85:9: [warning] wrong indentation: expected 10 but found 8 (indentation)

Sorry, I'm not so good at the yaml grammar, I will fix it in next version.

But when I run the make dt_binding_check, I can't find this warning in 
my side, maybe the tool has version required?


Thanks,
- Kever
> dtschema/dtc warnings/errors:
>
> doc reference errors (make refcheckdocs):
>
> Seehttps://patchwork.ozlabs.org/project/devicetree-bindings/patch/20241223110637.3697974-3-kever.yang@rock-chips.com
>
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
>
>

