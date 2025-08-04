Return-Path: <linux-pci+bounces-33400-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D394B1AAE7
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 00:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35AF34E1E63
	for <lists+linux-pci@lfdr.de>; Mon,  4 Aug 2025 22:27:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8EE128B7F3;
	Mon,  4 Aug 2025 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JLm16R0K"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89387238C07;
	Mon,  4 Aug 2025 22:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754346455; cv=none; b=sdX83gAjJnGnc2qBc+3AMocYN1Alopc+J9LPsrCOLSowecjD7DusiIkZXRtZLT53GfdAhgjDk00mH3iMI+KtdY2lEG7Uw9utQW3aXWlh9/SjwRJTn4LyxvS5PC2RoeQA8+Fkty2lyHP/8/yKUJBpttPSP8K0Vdye10Ej4ORphD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754346455; c=relaxed/simple;
	bh=QjAfphgpwaCkmwcy6gqPcaikXjKuuOfYkPwyuERtBCI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=eVOy0fqhHNbUuHY7g9jOKHldz+z7nVKJQOkA1aUW5UMjqd3FiNu2g3qCqTc51haCnQ4GCcuP5jvaF66d3Y6FHptgzcZsomhR4AdxG4ywvoGZKKlQ5Ivm2dvGIsxn8CDi6VmWxP5Zw0uUngUbBp0wKLl8WWnSZFFj1Np4IiXiB78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JLm16R0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D74DFC4CEE7;
	Mon,  4 Aug 2025 22:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754346455;
	bh=QjAfphgpwaCkmwcy6gqPcaikXjKuuOfYkPwyuERtBCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=JLm16R0KZGRe1ENxyFO7nwK9rOqmpTbBedVvlbOErUciZ+/rHZB6tZ7mNCIOAVgZU
	 RN73clt6Xlyrenotr27jIbsmQNoev6BywyEMGlJ0c+YvCx4LAqKGBK/8g22PF+kBIq
	 Vxse6VOjR1/Plyggk2J6jALS95Yn4SgCc9Fe7ggsrUL8ZIGjB7XOu8BeW/5Mpn4lOg
	 QZXtIX6FrRkxiq2kpnM4c2H6kd+w4zBLUPtytKfJCqiVbqi4POlq8XkPBDuAPhImBG
	 m2+koZxx3OZhGKZvb35mvlzWSFLqMGNwsdvUXaQs/+1CSvW7YDQnIcObTinKIZUVa+
	 YphLPWB4NcMUA==
Date: Mon, 4 Aug 2025 17:27:33 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	aik@amd.com, lukas@wunner.de, Samuel Ortiz <sameo@rivosinc.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Steven Price <steven.price@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>
Subject: Re: [RFC PATCH v1 35/38] coco: guest: arm64: Add Realm device start
 and stop support
Message-ID: <20250804222733.GA3644884@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250728135216.48084-36-aneesh.kumar@kernel.org>

On Mon, Jul 28, 2025 at 07:22:12PM +0530, Aneesh Kumar K.V (Arm) wrote:
> Writing 1 to 'tsm/acceept' will initiate the TDISP RUN sequence.

s/acceept/accept/

