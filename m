Return-Path: <linux-pci+bounces-42654-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C291CA52FB
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 20:54:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 692B2308ED0F
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 19:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E851A3446DB;
	Thu,  4 Dec 2025 19:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CRDyqcy+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25102D5C74;
	Thu,  4 Dec 2025 19:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764878040; cv=none; b=oEKDBtzl1ihY89n4wTAXtY7mHsB4dqGkwn/BRsAxp/4HpIb6qBwjaqPt8JjRIvT7dzuZpZufBx/4YaBiV2hdtifWFRzx/v4iT9xkvffBCctvhEKeRO8vTL32V9B6RW9OXbGms5KvbpY7GqQUaz9Rwf/B/vtbLEVGxhO0BPeE+us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764878040; c=relaxed/simple;
	bh=IlWhPGE3xUkVs9noGqN8k3YfY0Ubf/0Tz/7YbiNoNOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVJiXX0/uT8tUNJ/NiCiZdOiuumOj8CkFuASH/qkmuGk2hZVLAULl5P/jCJxt8kWz0uEjwZiSIQlKl1qaEhvPKqjvEcUrLTTVLmAsqeWoTdETHaCXO/b10U98UqKBcm8E2NoFoVkbRAl6swdipDJ90qZ2zYUi3OV6MjFJ5uTwKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CRDyqcy+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC75C4CEFB;
	Thu,  4 Dec 2025 19:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764878038;
	bh=IlWhPGE3xUkVs9noGqN8k3YfY0Ubf/0Tz/7YbiNoNOw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CRDyqcy+7t1NqBpjwfvt6EVa8fBQkxIXQGm3UhSM6pF/wQO2GB/GsLsPVU/5x5GEi
	 ISuzg0kUbHZykMWfUetqINwESVLOMc5Fmkby09hgB/u7SERCzYnp0wawyGV2PlT7/n
	 5l87bi2MeH9BDcFb4RYVZv5QJbaJ1y96IceT5JXqsVQb4D3G9VqtQmvZmKYyR8TlJc
	 Kvw7JWiTUYPVYuFB9UIihbWz7Pzyesd0xuz9ohN9oj0Fd4ZSSgOfGwZqBkdh2dU7D4
	 SjUBhWCsYAnJLC6nKdnqRUem9TAlPRZT3hfEV3yMJUy6kE89pMlaWtQcaBAKjIyVu9
	 WVBxr11PatfhA==
Date: Thu, 4 Dec 2025 13:53:55 -0600
From: Rob Herring <robh@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Joel Stanley <joel@jms.id.au>,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	linux-aspeed@lists.ozlabs.org, linux-pci@vger.kernel.org,
	linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Andrew Jeffery <andrew@aj.id.au>, openbmc@lists.ozlabs.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v6 0/7] Add ASPEED PCIe Root Complex support
Message-ID: <20251204195355.GA1975043-robh@kernel.org>
References: <20251201-upstream_pcie_rc-v6-0-8c8800c56b16@aspeedtech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251201-upstream_pcie_rc-v6-0-8c8800c56b16@aspeedtech.com>

On Mon, Dec 01, 2025 at 02:29:10PM +0800, Jacky Chou wrote:
> This patch series adds support for the ASPEED PCIe Root Complex,
> including device tree bindings, pinctrl support, and the PCIe host controller
> driver. The patches introduce the necessary device tree nodes, pinmux groups,
> and driver implementation to enable PCIe functionality on ASPEED platforms.
> Currently, the ASPEED PCIe Root Complex only supports a single port.
> 
> Summary of changes:
> - Add device tree binding documents for ASPEED PCIe PHY, PCIe Config, and PCIe RC
> - Update MAINTAINERS for new bindings and driver
> - Add PCIe RC node and PERST control pin to aspeed-g6 device tree
> - Implement ASPEED PCIe PHY driver
> - Implement ASPEED PCIe Root Complex host controller driver
> 
> This series has been tested on AST2600/AST2700 platforms and enables PCIe device
> enumeration and operation.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>
> ---
> Changes in v6:
> - Refer to pci-cpi-bridge.yaml to update aspeed,ast2600-pcie.yaml and
>   the pcie node of aspeed-g6.dtsi.

Where is this? You don't describe the root port and its properties at 
all now.

> - 'dt-bindings: pinctrl: aspeed,ast2600-pinctrl: Add PCIe RC PERST#
>   group' have applied, remove it from this version.
> - Adjust the defnitions in pci.h. 
> - Link to v5: https://lore.kernel.org/r/20251117-upstream_pcie_rc-v5-0-b4a198576acf@aspeedtech.com

