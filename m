Return-Path: <linux-pci+bounces-28728-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04606AC94A9
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 19:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCD8D4E8401
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 17:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5221A2367B5;
	Fri, 30 May 2025 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WA07GutG"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6347260A
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 17:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748625895; cv=none; b=eOH8qmLomLMBPRScsmTX58j9pWxw7SFqPXzmo7EVVTcLXBbFI1jYkI5/xnMWJhNJlYCyd2mauXFUZ3Dx4493g9iwAzNuIt+ARZbjRZIQqw8wp2K1bNpnwfITDhxrxGo1ZSbgvRJ5F8SJDMiwsXfdNXeEJbORJYZ1qRb+cIrhYiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748625895; c=relaxed/simple;
	bh=Fi8xBM8N/1UJOJHg+QvBM0v5UxznL2mUiHKiHfA5xiU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Y7ivsTh0SeCjM98Fc9J4KaUnjrEb9bIfn6WNCjg+I7ehpId5f8xRudtTueGTNE6LaM5WN+YutaUuvhNWDm2MQFERwkCu14x/9LEnQVfAFyarxilvl34vgFuaWrb07BHYtAIkatgv/CoBG5zu4Fzkur1m6XlSZ/7xJDMDzWwoh18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WA07GutG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF92C4CEEB;
	Fri, 30 May 2025 17:24:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748625895;
	bh=Fi8xBM8N/1UJOJHg+QvBM0v5UxznL2mUiHKiHfA5xiU=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=WA07GutGWsgZNiDexF2R2ziRpCuD5VGsGMBidzJJNXYwr3fAn4/40SRxfqbxHNV41
	 zcUTDtgSPsC86Knw91KtxVKLGXAHVo2TPns+MEEwP491DS9HGMyFFbf3HwA+N4h0Z1
	 TdnbHnNfGrUbrQyg1fz6pfn+w30ZTooUa4LKxAyn8/vlGzaTrcjXkJbrdVKbn9V2vo
	 vdLLkw75u6tBwb2+q3y17llDCBF+laGq91eSEzZPCN3nP0lLdlIMcY5x4vlYTtQ4WH
	 Ze5Hb5tgH8x5oUUPF76E3SfWU58s+TCOXyrwjNB4/mDlGKhRUzawgiMAKqQGaTJo9v
	 WLdVLGubVBVsw==
Date: Fri, 30 May 2025 19:24:53 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Wilfred Mallawa <wilfred.mallawa@wdc.com>,
 Damien Le Moal <dlemoal@kernel.org>, Hans Zhang <18255117159@163.com>,
 Laszlo Fiat <laszlo.fiat@proton.me>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2_1/4=5D_PCI=3A_dw-rockchip=3A_Do_not_e?=
 =?US-ASCII?Q?numerate_bus_before_endpoint_devices_are_ready?=
User-Agent: Thunderbird for Android
In-Reply-To: <20250530171937.GA198252@bhelgaas>
References: <20250530171937.GA198252@bhelgaas>
Message-ID: <76F22449-6A2D-4F64-BF23-DF733E6B9165@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 30 May 2025 19:19:37 CEST, Bjorn Helgaas <helgaas@kernel=2Eorg> wrote:
>
>I think all drivers should wait PCIE_T_RRS_READY_MS (100ms) after exit
>from Conventional Reset (if port only supports <=3D 5=2E0 GT/s) or after
>link training completes (if port supports > 5=2E0 GT/s)=2E
>
>> So I don't think this is a device specific issue but rather
>> controller specific=2E  And this makes the Qcom patch that I dropped a
>> valid one (ofc with change in description)=2E
>
>URL?

PATCH 4/4 of this series=2E


Kind regards,
Niklas


