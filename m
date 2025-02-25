Return-Path: <linux-pci+bounces-22365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9678CA447F5
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 18:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1F38178FD7
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2025 17:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DAE5194A59;
	Tue, 25 Feb 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pQBFDBkH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6A614A60A;
	Tue, 25 Feb 2025 17:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740504090; cv=none; b=J5E+EGrfuESLRc5BonyOff4FeAX3Fl4Scwu3cqrPVp1knYoKokPKZhAIEBmJiRWJavCY0Z9XWxH76PNpxX3UJkl0b83BMJD9rH7PMu9Ow4yIDNyQAYZTtDFYMg7yiKKnExaxpaKFYRt1tVr6wh3NS4PoL3W15nCbVFw3AWjE7lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740504090; c=relaxed/simple;
	bh=c4aCbzvpC4OPRzag8tbbZyRbYav/HzlqEic//RGnM50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+jhu885KPOKqTZReA9+jnem5fVZsZRrfy9++ESNr6aVxaW30KCuDUVGBulS3hgDmUl8tKn0R7AS0C7fvJgeSz+9897tyM8M6RbREU7JplrXbGVNYKLN8M8C129zdPvVgMSUUqGjpSt3W3udJlvPI9wR9q8m2DaufMrV1XD97dE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pQBFDBkH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB00FC4CEDD;
	Tue, 25 Feb 2025 17:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740504090;
	bh=c4aCbzvpC4OPRzag8tbbZyRbYav/HzlqEic//RGnM50=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pQBFDBkHOiyBhy/mAW0E84hm10c6PAX9Ku0+prxgkb7+EhgTa7ECdsYNiW2V/6fEK
	 D9u6+TZVuOP1ZixIsqp+WL8eiZjV9Yor3oEKRVQ4QoYbzcRvjNjmMp73a7zT+/pbgL
	 FrVuScma9NPfpg6EAceg//o3k4E6fUhEEAvxhf04BI1Ye7w5KVyE6zIvlz+AZjgPH+
	 D/c8eey1FHRasm8hFL1JQONUaCqRyD15flt7yKpcE++TiTtOlQi0tCI9hDggU2CEzV
	 1aLYrh0hQ7TulRA1hy/jHCdrvyl6OxRg/BSVIOTGkx5mVPnM52UaACHi0bYyGUvEnc
	 xZI2V/glBgBBQ==
Date: Tue, 25 Feb 2025 11:21:28 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Lucas Stach <l.stach@pengutronix.de>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Shawn Guo <shawnguo@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Fabio Estevam <festevam@gmail.com>, linux@ew.tq-group.com,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Frank Li <Frank.li@nxp.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Richard Zhu <hongxing.zhu@nxp.com>,
	imx@lists.linux.dev
Subject: Re: [PATCH 1/3] dt-bindings: PCI: fsl,imx6q-pcie: Add optional DMA
 interrupt
Message-ID: <174050408775.2723311.3813891689598918931.robh@kernel.org>
References: <20250225102726.654070-1-alexander.stein@ew.tq-group.com>
 <20250225102726.654070-2-alexander.stein@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225102726.654070-2-alexander.stein@ew.tq-group.com>


On Tue, 25 Feb 2025 11:27:21 +0100, Alexander Stein wrote:
> i.MX8QM and i.MX8QXP/DXP have an additional interrupt for DMA.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
>  Documentation/devicetree/bindings/pci/fsl,imx6q-pcie.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


