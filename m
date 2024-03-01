Return-Path: <linux-pci+bounces-4344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F0186E936
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 20:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0546A287614
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 19:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF4039AF4;
	Fri,  1 Mar 2024 19:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNPV1sby"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256E8848E;
	Fri,  1 Mar 2024 19:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709320174; cv=none; b=apMJC5OsD68+icEX0VuBZibGQL8hzwOnKHgDVdQ/TiVfZG0X9TeddgRzgszXsNj3WB72em3J32WgWrx9nXIHh/1vIMZe6BWvd3BYJYYCVX1r9URGUWdA8he3aoHJVvksIGxVjV1/Lm2gfhD8pf9MQf91/Qev5JIYxF3x8u/IPvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709320174; c=relaxed/simple;
	bh=baHSsvEGjsVt+7v/liOi4Y7CvASDhD35gdGFuKH30K0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Lrufhd67QF2S4JKk3pnui4FqxOQ6SuC4sH+iwpmm0UBsGNMDdWNYPBHzKIVCci1TG81dfe5nv8vbHBEsRpQk4WQwImzHQByYJTxemFey6gnBp5hoLsKJ5NLAr0R5jhELNeGrzr03VTs1r1bk3TTrmzh4bngE3q4RvX24XsayOXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNPV1sby; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4757FC433C7;
	Fri,  1 Mar 2024 19:09:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709320173;
	bh=baHSsvEGjsVt+7v/liOi4Y7CvASDhD35gdGFuKH30K0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=VNPV1sbyzb+ixQL1A9VSdpxDFMaC+8Xv3GJsfotzFBOC/p5jdgyYIkHNomT2PmQqT
	 6IgpMsQTIoSKD/PBZdBwmYn4TlP/Q4ivCd/llN8QGG40huQDMEZ6Mi7RotZdh1Lbom
	 Ix1ANFbLTQ43PG7M8aC9prTFKg5XR0/zNyxU8gkKw194cpektuFP4t5oYiefKRGqaH
	 M9tNsRpE5zrbjIt1pu94bq5Fm3mSnu5HP8soVK4mTz608m81/NXC7o9I0z9qS5sk5U
	 eyLCycUwMMwk8WRLjiXx1oRbZWgnnTmchPJXq9dLkXoUgsUACq4HmZh3H5jHyDC2JC
	 lZlFSM6rIZn/w==
Date: Fri, 1 Mar 2024 13:09:31 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: lpieralisi@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
	devicetree@vger.kernel.org, festevam@gmail.com,
	hongxing.zhu@nxp.com, imx@lists.linux.dev, kernel@pengutronix.de,
	krzysztof.kozlowski+dt@linaro.org, krzysztof.kozlowski@linaro.org,
	kw@linux.com, l.stach@pengutronix.de,
	linux-arm-kernel@lists.infradead.org, linux-imx@nxp.com,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	manivannan.sadhasivam@linaro.org, robh@kernel.org,
	s.hauer@pengutronix.de, shawnguo@kernel.org,
	Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH v10 03/14] PCI: imx6: Simplify reset handling by using by
 using *_FLAG_HAS_*_RESET
Message-ID: <20240301190931.GA403500@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205173335.1120469-4-Frank.Li@nxp.com>

[+cc Nathan]

On Mon, Feb 05, 2024 at 12:33:24PM -0500, Frank Li wrote:
> Refactors the reset handling logic in the imx6 PCI driver by adding
> IMX6_PCIE_FLAG_HAS_*_RESET bitmask define for drvdata::flags.
> 
> The drvdata::flags and a bitmask ensures a cleaner and more scalable
> switch-case structure for handling reset.
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Frank Li <Frank.Li@nxp.com>

Lorenzo, would you mind squashing in Nathan's fix from
https://lore.kernel.org/r/20240301-pci-imx6-fix-clang-implicit-fallthrough-v1-1-db78c7cbb384@kernel.org?

Also, the subject line has a repeated "by using by using".

Bjorn

