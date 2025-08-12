Return-Path: <linux-pci+bounces-33848-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D55B22188
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 10:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21EDD6E53CA
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 08:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6608C2EAD1C;
	Tue, 12 Aug 2025 08:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYv7Wg0f"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF542E62C7;
	Tue, 12 Aug 2025 08:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754987589; cv=none; b=kRGd9InF05h3GwhXbhQnO54UEQKDDQIuLTwI36slWLhmNxMmUvPkQIwuAgaNCwTYRY2lvLsbsHmmG72KiKAHYbBGu3T5AXTsrREj6eIgs75Doi8Zj+6LN95/JpNb1B9o6IMwy3vUA7m9cB3SIxr/DxkSHFY6t+13jY4++X8PX3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754987589; c=relaxed/simple;
	bh=YTp57RwAZl2gMOX6rbpz35pqyOCWuvVFAOg2wJZqtns=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bvVxD8YBysStLZmDLTSFkvuA8tZzYUiFHUpMAZwmbwuF4+gSuhqIi+jQ/V9O25GjOhlBxd7MZN6Bm2qRGmA2e+BOHkd9+948W2xU2Ox8fltsOxQlCB8sMX4Kcti5dXMemx0ELzb/x44BEY/ulbvHB2datwihfDJyRdVfbdTxgCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NYv7Wg0f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38F0BC4CEF0;
	Tue, 12 Aug 2025 08:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754987588;
	bh=YTp57RwAZl2gMOX6rbpz35pqyOCWuvVFAOg2wJZqtns=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NYv7Wg0fKqQewm3TnpIoJrDG90CPeYErfup9E1VdEqjHgARUh7h83Ode75ZLPOVqX
	 27S+Hj2KxWcHN/Pqg45vjUkOGSwPjc3brChZFtIDxABN+ZQHkVeKfCZMOlvaja2MLO
	 Hobusvef46rti8dM0gAEvoDcX/MZ5NwBh2MNlD7Gz7uw9AWTq88OkB1QHdkM9j8zaS
	 OjLDNKwZ/4WZq4pSiQ60Unq6kvDv6/b7Z2PjhLa8viixZ39vdPOIU6htovRG6kqYk9
	 cZussY+bQCQZedTzX54kmmR6VbFyQNR9Pc6Fk4ohzV+1u3kbrjyYQyAkMuJ5tABA/w
	 YUK4v+Y5Z4UNg==
Message-ID: <2b4fd0fb-ecab-4a10-bead-c78fa5e6d436@kernel.org>
Date: Tue, 12 Aug 2025 10:33:00 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 0/5] pci: qcom: Add QCS8300 PCIe support
To: Ziyue Zhang <ziyue.zhang@oss.qualcomm.com>, andersson@kernel.org,
 konradybcio@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, jingoohan1@gmail.com, mani@kernel.org,
 lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 johan+linaro@kernel.org, vkoul@kernel.org, kishon@kernel.org,
 neil.armstrong@linaro.org, abel.vesa@linaro.org, kw@linux.com
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-phy@lists.infradead.org, qiang.yu@oss.qualcomm.com,
 quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
 Ziyue Zhang <quic_ziyuzhan@quicinc.com>
References: <20250811071131.982983-1-ziyue.zhang@oss.qualcomm.com>
 <dc3dda22-34d3-4254-ba60-9037f3ccb368@oss.qualcomm.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <dc3dda22-34d3-4254-ba60-9037f3ccb368@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/08/2025 10:30, Ziyue Zhang wrote:
> 
> On 8/11/2025 3:11 PM, Ziyue Zhang wrote:
>> This series depend on the sa8775p gcc_aux_clock and link_down reset change
>> https://lore.kernel.org/all/20250725102231.3608298-2-ziyue.zhang@oss.qualcomm.com/
>>
>> This series adds document, phy, configs support for PCIe in QCS8300.
>> It also adds 'link_down' reset for sa8775p.
>>
>> Have follwing changes:
>> 	- Add dedicated schema for the PCIe controllers found on QCS8300.
>> 	- Add compatible for qcs8300 platform.
>> 	- Add configurations in devicetree for PCIe0, including registers, clocks, interrupts and phy setting sequence.
>> 	- Add configurations in devicetree for PCIe1, including registers, clocks, interrupts and phy setting sequence.
>>
>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
>> Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
>> ---
>> Changes in v10:
>> - Update PHY max_items (Johan)
>> - Link to v9: https://lore.kernel.org/all/20250725104037.4054070-1-ziyue.zhang@oss.qualcomm.com/
>>
>> Changes in v9:
>> - Fix DTB error (Vinod)
>> - Link to v8: https://lore.kernel.org/all/20250714081529.3847385-1-ziyue.zhang@oss.qualcomm.com/
>>
>> Changes in v8:
>> - rebase sc8280xp-qmp-pcie-phy change to solve conflicts.
>> - Add Fixes tag to phy change (Johan)
>> - Link to v7: https://lore.kernel.org/all/20250625092539.762075-1-quic_ziyuzhan@quicinc.com/
>>
>> Changes in v7:
>> - rebase qcs8300-ride.dtsi change to solve conflicts.
>> - Link to v6: https://lore.kernel.org/all/20250529035635.4162149-1-quic_ziyuzhan@quicinc.com/
>>
>> Changes in v6:
>> - move the qcs8300 and sa8775p phy compatibility entry into the list of PHYs that require six clocks
>> - Update QCS8300 and sa8775p phy dt, remove aux clock.
>> - Fixed compile error found by kernel test robot
>> - Link to v5: https://lore.kernel.org/all/20250507031019.4080541-1-quic_ziyuzhan@quicinc.com/
>>
>> Changes in v5:
>> - Add QCOM PCIe controller version in commit msg (Mani)
>> - Modify platform dts change subject (Dmitry)
>> - Fixed compile error found by kernel test robot
>> - Link to v4: https://lore.kernel.org/linux-phy/20241220055239.2744024-1-quic_ziyuzhan@quicinc.com/
>>
>> Changes in v4:
>> - Add received tag
>> - Fixed compile error found by kernel test robot
>> - Link to v3: https://lore.kernel.org/lkml/202412211301.bQO6vXpo-lkp@intel.com/T/#mdd63e5be39acbf879218aef91c87b12d4540e0f7
>>
>> Changes in v3:
>> - Add received tag(Rob & Dmitry)
>> - Update pcie_phy in gcc node to soc dtsi(Dmitry & Konrad)
>> - remove pcieprot0 node(Konrad & Mani)
>> - Fix format comments(Konrad)
>> - Update base-commit to tag: next-20241213(Bjorn)
>> - Corrected of_device_id.data from 1.9.0 to 1.34.0.
>> - Link to v2: https://lore.kernel.org/all/20241128081056.1361739-1-quic_ziyuzhan@quicinc.com/
>>
>> Changes in v2:
>> - Fix some format comments and match the style in x1e80100(Konrad)
>> - Add global interrupt for PCIe0 and PCIe1(Konrad)
>> - split the soc dtsi and the platform dts into two changes(Konrad)
>> - Link to v1: https://lore.kernel.org/all/20241114095409.2682558-1-quic_ziyuzhan@quicinc.com/
>>
>> Ziyue Zhang (5):
>>    dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy: Update pcie phy bindings
>>      for qcs8300
>>    arm64: dts: qcom: qcs8300: enable pcie0
>>    arm64: dts: qcom: qcs8300-ride: enable pcie0 interface
>>    arm64: dts: qcom: qcs8300: enable pcie1
>>    arm64: dts: qcom: qcs8300-ride: enable pcie1 interface
>>
>>   .../phy/qcom,sc8280xp-qmp-pcie-phy.yaml       |  17 +-
>>   arch/arm64/boot/dts/qcom/qcs8300-ride.dts     |  80 +++++
>>   arch/arm64/boot/dts/qcom/qcs8300.dtsi         | 296 +++++++++++++++++-
>>   3 files changed, 376 insertions(+), 17 deletions(-)
>>
>>
>> base-commit: e2622a23e8405644c7188af39d4c1bd2b405bb27
> Hi Maintainers,
> 
> It seems the patches get reviewed tag for a long time, can you give this
> 
> series further comment or help me to merge them ?
> Thanks very much.

Can you NOT ping after one day? It is not really acceptable.

Best regards,
Krzysztof

