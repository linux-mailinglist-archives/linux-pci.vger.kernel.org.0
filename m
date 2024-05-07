Return-Path: <linux-pci+bounces-7177-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA0F8BE7C8
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 17:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 510871F285D8
	for <lists+linux-pci@lfdr.de>; Tue,  7 May 2024 15:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CD5165FA4;
	Tue,  7 May 2024 15:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJWhACGT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED131649BF;
	Tue,  7 May 2024 15:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715096993; cv=none; b=LGugD8Tj50aW30uYXPfigW5lz1lof3mHSKJxp9s6Ufc7BkUXQ4SKXtWmAeDYLGyR7GD/h4/ZoNK+DCmx34khQ1TFK4UtmOdEZGOFD78u+Ai3LjjbB116nRqXu224r3533TF4xhORQrYdhSK4eELljZ8L7VPx3d3HQ7cskZxkmGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715096993; c=relaxed/simple;
	bh=73IkLegRnrX7zQ8f5gztcN1MdWKuO8IZnFZ5nj4zXSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LqsVpzmuPmYwDdxVYt8JcHWRk5jg42bN5zwhuSj6+ZB+wLugnm5TrW6SKxJNKiXHgfarFrmuxWojLod4BUmIBNUEWDr/mgbt7ORLVpynIBS0/oexjI7QRphgLiCK0n1odSe/tbo5qMObFO2IRvDglagWhiGsP4Psd4in3W12OkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJWhACGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D71FC4AF18;
	Tue,  7 May 2024 15:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715096992;
	bh=73IkLegRnrX7zQ8f5gztcN1MdWKuO8IZnFZ5nj4zXSk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CJWhACGT+KQcnWUR2wiLfGSGU7mWAaNI4VzE0cKztOi2ILoMc1Cmjea1jy3yAEvG0
	 a8FGErPv1G+SSdpfyYFSYbvQGNfBIP3BYBeqZLAHwrjN9iuclKVpAfllQkqiGurGP7
	 nwpI54K41Q6WzRmLS26IlhEnzlW8bTrT56ee5jVo+2Xg5s64HA0Abc0aVuWcDkKQaB
	 pVkyq08T/QNsbKWtH+rAI4JPIXpf7pS1/egBuVKjVdFoQV3JFbVlaEIP4IevgpG0K0
	 uIR2ej0CxhZdjGtcTqgHnR3zHnORUtNEr0QqSQ8oIND0aZMwI7L+TS1zmv8Z7JU4sW
	 X04jX+slQT2aQ==
Date: Tue, 7 May 2024 10:49:50 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org, Simon Xue <xxm@rock-chips.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Jingoo Han <jingoohan1@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 06/14] dt-bindings: rockchip: Add DesignWare based
 PCIe Endpoint controller
Message-ID: <171509698733.530839.7604642260352271551.robh@kernel.org>
References: <20240430-rockchip-pcie-ep-v1-v2-0-a0f5ee2a77b6@kernel.org>
 <20240430-rockchip-pcie-ep-v1-v2-6-a0f5ee2a77b6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430-rockchip-pcie-ep-v1-v2-6-a0f5ee2a77b6@kernel.org>


On Tue, 30 Apr 2024 14:01:03 +0200, Niklas Cassel wrote:
> Document DT bindings for PCIe Endpoint controller found in Rockchip SoCs.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  .../bindings/pci/rockchip-dw-pcie-common.yaml      | 14 ++++
>  .../bindings/pci/rockchip-dw-pcie-ep.yaml          | 95 ++++++++++++++++++++++
>  2 files changed, 109 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


