Return-Path: <linux-pci+bounces-38366-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848E0BE4603
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 058D154318E
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 15:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38C9F34F482;
	Thu, 16 Oct 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBgKyP62"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00DD81C84B2;
	Thu, 16 Oct 2025 15:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760630144; cv=none; b=JRqEytoyswIaPflc3cbN0ZUkPflR2FNzbbCcN2KPnkt5w4SQxwIWuvwoTSsyw7xdpVc7OvK3VvLxAnMkUEc7vZB8zLPC5TuQ7ekA1mCC+sm7hU9DJ998UXqS+94xWYY1MazOuSTezYAJOxOsZ4ZD0JUigVXcpi6jrRkQSoTDvEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760630144; c=relaxed/simple;
	bh=HkFyKu+xLbSALL1o9HOxCzlRCTdBKmDeTKiXn+ccPxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Gw1xITub59mc1HDKxSL8JjImYExW3KMQyHUWYp3B3F9VrTWoMrJF+KEi8xuZ34JSsfxpau8G/0s1+QBLpT74UNQaGndDcnvnLx5rwrMeo307UMwBzmgueFaneGuqeG2VbQce5OVvsf8smKjEyGEYq2OmjtQnX6qEYRWuajkj998=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBgKyP62; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 461DDC4CEF1;
	Thu, 16 Oct 2025 15:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760630143;
	bh=HkFyKu+xLbSALL1o9HOxCzlRCTdBKmDeTKiXn+ccPxQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=EBgKyP628FMYhUyZybjaX9vcdmX7blg4QFheGJfsniNp1IlEFnJRZ1NANTGEfHG11
	 Vla5Fihywf+rTjx7GyV+c15i/GmE2kW0dPlVZ8NlromccQXbuBXHDOh9SXsZp7I0Qc
	 Ot8btIDd6cBdJtLbmkt+0BylDxEHhr32DgoSlwUENp/XYPP05PBuc+bQ5WZTZnBIP+
	 oznZX4WEhqodaGgJXcChseSGuXYJN6prVnUW9b5Bv4rE0Q777ZtyJmVPCIY1bwZp7l
	 SpUd5+kdLnll7X41HrlTE6bNNc55Ahf9M+UKpcsU1kc+HIC5c4GqG2micwthZV5Mq3
	 ubCGH1YpF7nKw==
Date: Thu, 16 Oct 2025 10:55:42 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Sjoerd Simons <sjoerd@collabora.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Chunfeng Yun <chunfeng.yun@mediatek.com>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Lee Jones <lee@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	kernel@collabora.com, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, netdev@vger.kernel.org,
	Daniel Golle <daniel@makrotopia.org>,
	Bryan Hinton <bryan@bryanhinton.com>
Subject: Re: [PATCH 05/15] dt-bindings: pci: mediatek-pcie-gen3: Add MT7981
 PCIe compatible
Message-ID: <20251016155542.GA985895@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016-openwrt-one-network-v1-5-de259719b6f2@collabora.com>

On Thu, Oct 16, 2025 at 12:08:41PM +0200, Sjoerd Simons wrote:
> Add compatible string for MediaTek MT7981 PCIe Gen3 controller.
> The MT7981 PCIe controller is compatible with the MT8192 PCIe
> controller.

In subject,
s/pci: mediatek-pcie-gen3:/PCI: mediatek-gen3:/

Note that previous commits to this file use subject lines like this:

  0106b6c114cf ("dt-bindings: PCI: mediatek-gen3: Add support for MT6991/MT8196")
  a1360a6a72b9 ("dt-bindings: PCI: mediatek-gen3: Add mediatek,pbus-csr phandle array property")

git log --oneline Documentation/devicetree/bindings/pci/mediatek-pcie-gen3.yaml

