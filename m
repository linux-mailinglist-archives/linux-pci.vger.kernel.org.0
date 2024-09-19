Return-Path: <linux-pci+bounces-13296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C18B897CBA9
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 17:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63ABF1F242E1
	for <lists+linux-pci@lfdr.de>; Thu, 19 Sep 2024 15:37:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF8219F499;
	Thu, 19 Sep 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sqQs/Szp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BF9190477;
	Thu, 19 Sep 2024 15:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726760262; cv=none; b=ZmD6IJ2n2HoD4/fM1+6RZOEufx/gXiwSSYBfnFKV1DKjS02G2xxOA/UZW/N7UAdlD+jbzHVYoggn6fSZ774Pw1xKVwSfagLOX3mvVRGfw4K+lg+jVpNxO1VFuUiR3stlFyqbrsNi1IS91X/beiJEA0YNh+yEBuMFuLsuVYW7zzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726760262; c=relaxed/simple;
	bh=S6MIWYK6Un51svGZ37c7JU+yySKaaclPw/YJv6ZmRvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sxu+OLqzvAlF3FitAG89A6IMiYIBtmXYHtxW9B07pmmiBtRaPCmExcHDsS0Iaf5BmKi/Ex1NJhV5fDoXS6iKJWSDudB+5WawsS0gFE6l5uGkf50UbNh1lIh7O/7GvwxoM6EO8v9Ie/XH/XODL6KGpVZEXukFDQi4n7GFkw4m+A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sqQs/Szp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6401C4CEC4;
	Thu, 19 Sep 2024 15:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726760262;
	bh=S6MIWYK6Un51svGZ37c7JU+yySKaaclPw/YJv6ZmRvc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=sqQs/SzpmNnddohCXdihZ4r5oYBTBNJ6bP9ZJYIUmw9zHuxB+rYCXPkeW2vqYL1Is
	 XkCa84DwrMY+qAkTUZAhgtS41A5oynMVOhrsh3pG7sOTYyPnYcE1jkY7N8683yNuZR
	 +iYiMKNTDTg9CtVwb4AmBFdKSx8AIXC0y6Hucdjky6SZxTJQ1urIDMMnOPdt6+Dn80
	 rO85T8mvqRCG9TWJ3ESSmX/iW2oTO0DSPpAK/UPxEnebx3QyghNpae1qCH5YmfE3xV
	 nGYMN4Jv+8hzxYlvwreVnj1Q96N+Q9sVfCntq0R9ZqenFPSFkKuWzJqAAPEV4w8U9F
	 SnKW13xPqrnjQ==
Message-ID: <2acbaedc-e577-4685-875c-ba599d845b19@kernel.org>
Date: Thu, 19 Sep 2024 17:37:33 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] dt-bindings: phy: qcom,sc8280xp-qmp-pcie-phy:
 Document the X1E80100 QMP PCIe PHY Gen4 x8
To: Qiang Yu <quic_qianyu@quicinc.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
 robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
 sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
 quic_devipriy@quicinc.com, dmitry.baryshkov@linaro.org, kw@linux.com,
 lpieralisi@kernel.org, neil.armstrong@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org
References: <20240913083724.1217691-1-quic_qianyu@quicinc.com>
 <20240913083724.1217691-2-quic_qianyu@quicinc.com>
 <lrcridndulcurod7tc5z76tmfhcf5uqumkw7cijsqicmad2rim@blyor66wt4e4>
 <b36819ed-0e4a-4820-8c38-ac9d2c6f0f28@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konradybcio@kernel.org>
In-Reply-To: <b36819ed-0e4a-4820-8c38-ac9d2c6f0f28@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.09.2024 4:03 PM, Qiang Yu wrote:
> 
> On 9/16/2024 11:15 PM, Krzysztof Kozlowski wrote:
>> On Fri, Sep 13, 2024 at 01:37:20AM -0700, Qiang Yu wrote:
>>> PCIe 3rd instance of X1E80100 support Gen 4x8 which needs different 8 lane
>>> capable QMP PCIe PHY. Document Gen 4x8 PHY as separate module.
>> And this is really different hardware? Not just different number of lanes? We discussed it, but I don't see the explanation in commit msg.
> Yes, PCIe3 use a different phy that supports 8 lanes and provides
> additional register set, txz and rxz. It is not a bifurcation mode which
> actually combines two same phys like PCIe6a. It's also not just different
> number of lanes. Will explain this in commit msg.

Krzysztof, this PHY is new and has a different hardware revision (v6.30 as
opposed to v6.20? of the other ones)

Konrad

