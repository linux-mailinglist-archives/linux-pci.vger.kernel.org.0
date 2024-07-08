Return-Path: <linux-pci+bounces-9959-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDF792A817
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 19:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83D21F2139E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 17:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8863D1494C8;
	Mon,  8 Jul 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jKvjLsTm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57697148FF2;
	Mon,  8 Jul 2024 17:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720458655; cv=none; b=Q05WeGIFJ13r10LkTg6+WWdJOJ7fRPQ8uhTxefrUAYzc9tDYkfTK0KOsgZc4YIkSEGxX4m6qdxHds+RBVYfI/yDfsbZfj7359O06Njl471XUzwtRR4sdk9+hePItpwr9c1Gr08oJWg/xsmPAQt0j15voufNpvqnLEr2r6m7q7sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720458655; c=relaxed/simple;
	bh=WKIwnezwdqKkfmKHL941rSU5Nnnh9+YX9sLJNtc4aME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PR3da1u39m93Q/x4VOv7D9R4zsnb1rxvMxUcw6ercYZgKkAOxOq6yqB3NhOadMgqnwVfxKfGbo9fvN9w/YoSCfyQ6GCkfjpypuEbnoGDnKIcdWpb2nIHiIV8DcvGld0ZI9j5u8oectSJl8z127VW7D/DTE7ATzwMA7j2ko3Ea3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jKvjLsTm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC30DC4AF0A;
	Mon,  8 Jul 2024 17:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720458655;
	bh=WKIwnezwdqKkfmKHL941rSU5Nnnh9+YX9sLJNtc4aME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jKvjLsTm0UlhwoN86vZR+LgSFSgiU4fGPkFglFI0OXqPCvb4bH7Vz/uh9Phc31e/0
	 4jtsbL9rBY36+qV0ycsMYpyfcy4HvgmmlRlBqn4piJRti53Rh931C07B5UiUzUQGvz
	 3yht5I4ccZo+llv26k2J4WKUyb3+NUt88WUkKT8w8To8bbfRjzPMqk8mpb6h3aIKo0
	 ussCDYkTm4Po0GQvz5iBHMN/zY6RLYgP9tKmZc+7jXJ4eh2zgkf69OeoElqdh/0eNY
	 g2rKhEiaBy/UMs3kl7DKKmYcqrFq+/AU9fXezv/db3u56d+o0vrGJaCPMTht9jECpK
	 sGESCL+96YC5Q==
Date: Mon, 8 Jul 2024 11:10:52 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Conor Dooley <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
	Will Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, imx@lists.linux.dev,
	Krzysztof Kozlowski <krzk+dt@kernel.org>
Subject: Re: [PATCH v2 1/1] dt-bindings: PCI: host-generic-pci: Drop minItems
 and maxItems of ranges
Message-ID: <172045865135.3461600.11204852988221577437.robh@kernel.org>
References: <20240704164019.611454-1-Frank.Li@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704164019.611454-1-Frank.Li@nxp.com>


On Thu, 04 Jul 2024 12:40:19 -0400, Frank Li wrote:
> The ranges description states that "at least one non-prefetchable memory
> and one or both of prefetchable memory and IO space may also be provided."
> 
> However, it should not limit the maximum number of ranges to 3.
> 
> Freescale LS1028 and iMX95 use more than 3 ranges because the space splits
> some discontinuous prefetchable and non-prefetchable segments.
> 
> Drop minItems and maxItems. The number of entries will be limited to 32
> in pci-bus-common.yaml in dtschema, which should be sufficient.
> 
> Fix the below CHECK_DTBS warning.
> arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: pcie@1f0000000: ranges: [[2181038080, 1, 4160749568, 1, 4160749568, 0, 1441792], [3254779904, 1, 4162191360, 1, 4162191360, 0, 458752], [2181038080, 1, 4162650112, 1, 4162650112, 0, 131072], [3254779904, 1, 4162781184, 1, 4162781184, 0, 131072], [2181038080, 1, 4162912256, 1, 4162912256, 0, 131072], [3254779904, 1, 4163043328, 1, 4163043328, 0, 131072], [2181038080, 1, 4227858432, 1, 4227858432, 0, 4194304]] is too long
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
> Change from v1 to v2
> - Rework commit message
> - drop minItems and maxItems according to Rob's comments.
> ---
>  Documentation/devicetree/bindings/pci/host-generic-pci.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


