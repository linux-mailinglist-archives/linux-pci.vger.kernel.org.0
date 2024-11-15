Return-Path: <linux-pci+bounces-16844-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9D39CDB02
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36F5A282F5D
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0258918990C;
	Fri, 15 Nov 2024 09:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nu7qyjMI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28FE1898EA
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 09:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661292; cv=none; b=AUl2D88QawqWsxTwlgOzVZAuo8qW1i0LNOi+XVJ7S5c8u4XHUxmqAb26Eqc03XosuOlu4B8mXi7m4BpdYzYvcjsU4352wtG6QrM6iSMJe9hwX3ehKzq96DnL7xzYY5t4j5d1S4VqH4+CNCG9I2kSxfnuvjhVC230Vz2mW7BJo9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661292; c=relaxed/simple;
	bh=OfcSEayo6+nXOypkC14YWE7Vx2F4Cx8nd1AgMtz3DbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=niseaphFk2YQh7OBvMp0G9lXM4zgsxGGZlG7gJw7wwYTbpKwjuWftp3hjwdyfhHF/ewmJYSTudn1UopVPn8oFilWnlFyx3StxzYgpxt63aPjsKdK4dKP8YerHqWwEMNGeMgDczDBnz+CUv8CgLhiVnnxUjdAUubA6qwFS3jLfXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nu7qyjMI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3791C4CED4;
	Fri, 15 Nov 2024 09:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731661292;
	bh=OfcSEayo6+nXOypkC14YWE7Vx2F4Cx8nd1AgMtz3DbA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nu7qyjMI6INfbVZhDoXWHKX4qpkw82ZQzHTG+7zoUE5LOh47wn2xafu97YP76kzVe
	 Lkhdgih7WYux7jQm51LTT9eR8TNgJYYSGkabQ+1Bb7OS/7yyhbLOaxZUKdQRBEYgRH
	 Cv9UQsEHzsOJ2zLZEsO3XLomzpXp40niYZ2cxgglB12NJbwKD9WoIIqkUeWhRSqV0a
	 hbV38QCly6hQqYZwl739TJz1OE/+qhfRDYGK0BstfQJIi6Jehm4YBIl50+h33DKNvZ
	 NiV1O08axK22xo8i5wJarFTZ958ubtd1wT4l6Uwks1sYEoz2yP44czsKDGshdqTLns
	 QlMsP8iKU83xg==
Date: Fri, 15 Nov 2024 10:01:27 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Jesper Nilsson <jesper.nilsson@axis.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-arm-kernel@axis.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 0/3] PCI endpoint additional pci_epc_set_bar() checks
Message-ID: <ZzcN56G2MACeJHvo@ryzen>
References: <20241115084749.1915915-5-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115084749.1915915-5-cassel@kernel.org>

On Fri, Nov 15, 2024 at 09:47:49AM +0100, Niklas Cassel wrote:
> Hello all,
> 
> This series adds some extra checks to ensure that it is not possible to
> program the iATU with an address which we did not intend to use.
> 
> If these checks were in place when testing some of the earlier revisions
> of Frank's doorbell patches (which did not handle fixed BARs properly),
> we would gotten an error, rather than silently using an address which we
> did not intend to use.
> 
> Having these checks in place will hopefully avoid similar debugging in the
> future.

Changes since v1:
-Improved commit message in patch 3/3.
-Picked up tags.


Kind regards,
Niklas

