Return-Path: <linux-pci+bounces-22049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36A7DA4035F
	for <lists+linux-pci@lfdr.de>; Sat, 22 Feb 2025 00:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BCDA168A5E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Feb 2025 23:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFEB72054E5;
	Fri, 21 Feb 2025 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PtYlutvN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EFAA1F9F70;
	Fri, 21 Feb 2025 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740179667; cv=none; b=uZGirqevJRuDOZlUchE0KPMjkYS6+5NW8JDaeJWYQ/GUCL6JO5Yo1Ktt9avhx/JDv5dMGlnD2FNhWazHW03j6e3d+GaqT3byP/VkiiLxsS3O1s63MjtVmov45+6ZCtpkQnSJHgzmkG8r4tfCVw5mnmy060J7ojrWbjuCpYxaFHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740179667; c=relaxed/simple;
	bh=ZxrEIfABUThlyL83NqEocjM+61rjSOj8pPycrC979mA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Im9iYDTAW6xj9OuoqmURgWg7ZiQ2GmQprhMPru8svEZsDkK0LiVwBMuVEuIxjYDxCgpkb2a5R981UA3CohTrzBFPLD40+CdZGu2jO1Qp2mCgnbmWbX/qp4pbiW68LZv01EOhKcG0Efk2Fedfg9e3UgSS4kqotQVEHsmkSn9ZPPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PtYlutvN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE8BC4CED6;
	Fri, 21 Feb 2025 23:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740179667;
	bh=ZxrEIfABUThlyL83NqEocjM+61rjSOj8pPycrC979mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PtYlutvNQyz6oh+FTLV0+g6YgzBGvtEDnAeLuVtvfEQVJ8x7CikJM6sLo4J79vbt3
	 aPTnNK6arjQGvH7jYmvV3VMqnPD3d2d1kKGWhfMZJi/ps1tpMF9aXO/U5xtbntm/K4
	 iVF9YmZQtFKCO+oKaSHAEBmfvl1/6CgFU3iYXndbEPgbKPlr/CdU7nwTdLU/Oz6/gA
	 OiWKgoiuUCKw2q4hz3Gx+1yWoTSVssDk6zwFf3G+TOLqWDTU55dopjf7+iWMLMn2ti
	 xCA1X0HrmLjV7ZIYqnQf0T5tZLlF3uqmogRBv5RU12I2FhaiLzyB9cXEnRqQ3vtOve
	 3AP8pg1r1gK8g==
Date: Fri, 21 Feb 2025 17:14:24 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: =?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.ne@posteo.net>
Cc: devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
	=?iso-8859-1?Q?J=2E_Neusch=E4fer?= <j.neuschaefer@gmx.net>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH v3] dt-bindings: pci: Convert fsl,mpc83xx-pcie to YAML
Message-ID: <174017966427.307648.3944377161217971562.robh@kernel.org>
References: <20250220-ppcyaml-pci-v3-1-ca94a4f62a85@posteo.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250220-ppcyaml-pci-v3-1-ca94a4f62a85@posteo.net>


On Thu, 20 Feb 2025 13:29:58 +0100, J. Neuschäfer wrote:
> Formalise the binding for the PCI controllers in the Freescale MPC8xxx
> chip family. Information about PCI-X-specific properties was taken from
> fsl,pci.txt. The examples were taken from mpc8315erdb.dts and
> xpedite5200_xmon.dts.
> 
> Signed-off-by: J. Neuschäfer <j.ne@posteo.net>
> ---
> V3:
> - split out as a single patch
> - remove obsolete reference to fsl,pci.txt
> - remove unnecessary newline near the end of fsl,mpc8xxx-pci.yaml
> 
> V2:
> - part of series [PATCH v2 00/12] YAML conversion of several Freescale/PowerPC DT bindings
>   Link: https://lore.kernel.org/lkml/20250207-ppcyaml-v2-6-8137b0c42526@posteo.net/
> - merge fsl,pci.txt into fsl,mpc8xxx-pci.yaml
> - regroup compatible strings, list single-item values in one enum
> - trim subject line (remove "binding")
> - fix property order to comply with dts coding style
> ---
>  .../devicetree/bindings/pci/fsl,mpc8xxx-pci.yaml   | 113 +++++++++++++++++++++
>  Documentation/devicetree/bindings/pci/fsl,pci.txt  |  27 -----
>  2 files changed, 113 insertions(+), 27 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


