Return-Path: <linux-pci+bounces-17546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E10A09E0807
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 17:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17379175BE7
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F170D70826;
	Mon,  2 Dec 2024 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ioCIHjXV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2F42AAD;
	Mon,  2 Dec 2024 15:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733154482; cv=none; b=apgIg1A2OoRHgAOA+Dw3M+CnGRac2D985RnOHxsObE+dPKSM309GfCnZOAdrojo68AxAZ3wRXbCiO10TNf6zAFMl7RyUKljdC+BI4Y3K7IffrpRNmyz1Acps4sqT07kG92dYTdXNYvdJV0hWX/Ccnx9AyK9K5vKFYdkREnPD/K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733154482; c=relaxed/simple;
	bh=tUIUYos7HfM9zp290BdrLXtD0sN1aHS92XAApgYZMBk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuP4DNTuvyHF8NBeOoMvksqjcNmVGI5K3huSG5Xn9AU+saXrWIv0aKIOeKk3jgp8/aWloLWpHBigzVXXAC3yfbKFFnejIWzV/JD0yObN1trFsBOgUacizM1Bqf83koNdyYkqjIuQnuoH/Ey4AttcS11DXKD52h5h6271XwJtxUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ioCIHjXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F31C6C4CEDD;
	Mon,  2 Dec 2024 15:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733154482;
	bh=tUIUYos7HfM9zp290BdrLXtD0sN1aHS92XAApgYZMBk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ioCIHjXVuT/MldTsu21M7/2/vGwSGBcdP9+5GJAHnU0Y4BT4VQr7yPOWGNAjTcScY
	 Vxb1JlB6qY1HPYy9ZkPJN1UUqMZz4hPlLoFZiFQKHUG30UbWIhK9nhzIg8OVF0MPTb
	 R5Ti1zMcRH/YL3LnS1DO05aGdN1+OWvWWIWH/TIwfOhr6Ll29jvpja36E+7O+2jONx
	 IoRimoYA0BpeNRFX+A2PtCKCnhUjI1wICHzKv0Al4isIXhPTij/dhljOm5++R+pfsO
	 jZb1N8ZXJibwa1PseqjjbPJsYGjtDMUEoxCmlx14hqTPvxt4fIsEf6lAU8BgrQ0ewY
	 w6quEcbYKeXCw==
Date: Mon, 2 Dec 2024 09:48:00 -0600
From: Rob Herring <robh@kernel.org>
To: Herve Codina <herve.codina@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Bjorn Helgaas <bhelgaas@google.com>, Lizhi Hou <lizhi.hou@amd.com>,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v4 5/6] of: Add #address-cells/#size-cells in the
 device-tree root empty node
Message-ID: <20241202154800.GA2617722-robh@kernel.org>
References: <20241202131522.142268-1-herve.codina@bootlin.com>
 <20241202131522.142268-6-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202131522.142268-6-herve.codina@bootlin.com>

On Mon, Dec 02, 2024 at 02:15:17PM +0100, Herve Codina wrote:
> On systems where ACPI is enabled or when a device-tree is not passed to
> the kernel by the bootloader, a device-tree root empty node is created.
> This device-tree root empty node does not have the #address-cells and
> the #size-cells properties
> 
> This leads to the use of the default address cells and size cells values
> which are defined in the code to 1 for the address cells value and 1 for
> the size cells value.
> 
> According to the devicetree specification and the OpenFirmware standard
> (IEEE 1275-1994) the default value for #address-cells should be 2.
> 
> Also, according to the devicetree specification, the #address-cells and
> the #size-cells are required properties in the root node.
> 
> The device tree compiler already uses 2 as default value for address
> cells and 1 for size cells. The powerpc PROM code also uses 2 as default
> value for address cells and 1 for size cells. Modern implementation
> should have the #address-cells and the #size-cells properties set and
> should not rely on default values.
> 
> On x86, this root empty node is used and the code default values are
> used.
> 
> In preparation of the support for device-tree overlay on PCI devices
> feature on x86 (i.e. the creation of the PCI root bus device-tree node),
> the default value for #address-cells needs to be updated. Indeed, on
> x86_64, addresses are on 64bits and the upper part of an address is
> needed for correct address translations. On x86_32 having the default
> value updated does not lead to issues while the upper part of a 64-bit
> value is zero.
> 
> Changing the default value for all architectures may break device-tree
> compatibility. Indeed, existing dts file without the #address-cells
> property set in the root node will not be compatible with this
> modification.
> 
> Instead of updating default values, add both required #address-cells
> and #size-cells properties in the device-tree empty node.
> 
> Use 2 for both properties value in order to fully support 64-bit
> addresses and sizes on systems using this empty root node.
> 
> Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> ---
>  drivers/of/empty_root.dts | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

This also fixes unittest hitting a warning added for 6.13. So 
I've applied this patch as a fix.

Rob

