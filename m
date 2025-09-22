Return-Path: <linux-pci+bounces-36712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 88515B9326D
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 21:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 96272190721F
	for <lists+linux-pci@lfdr.de>; Mon, 22 Sep 2025 19:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE5430DEBE;
	Mon, 22 Sep 2025 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qUmQ/xhS"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4A82E2847;
	Mon, 22 Sep 2025 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758570963; cv=none; b=HOHYFrb/3+8zfOf0IVcIlkf1yVtYa9o5OR389+R0wl+40cgaBuJp2C7GklsT11pAmO+8DsEJbNobvcqOsRGVQ3MOu7lZ5y40JcYD7HL+XtR/TQ6Y7maKAvcFaisBFTjQnJCOxRPSUvMdc90K7ZSb9SVmv95HCeVSC830ZPQljd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758570963; c=relaxed/simple;
	bh=wrKLzg8JVJv0MU+Akem4rxVGFTstG95SrVxzXNpDs8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m75Hq3PVXYDFwat3XzP+9gH2Ibc7sMKnxiMuzcvZSN4bOWVhmlqXoKD3/o4tC2aGi1pVRukln3wi3b+W8Ox8DJtLomd2DmamWXwcFQRZ2c3KcTJIDWgb+SJtEs/SgfNmkTCyYmREfN8Q3+r8GyrM5UOEVkbjNln1ffA1lcnbUp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qUmQ/xhS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2391C4CEF0;
	Mon, 22 Sep 2025 19:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758570962;
	bh=wrKLzg8JVJv0MU+Akem4rxVGFTstG95SrVxzXNpDs8o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qUmQ/xhSPD8FnkreADlNy1kDy8UtVNVWXtjiuFHeJ5VhVx01MoYBlYAexm0cbS1of
	 3sBttZwQYhLajKKgD500EeXcQCl0+aLPCynaD0uE6uqwXbit44EgE05suE+MFyua88
	 o/biKRRfSrXBlD360yMr5BOOCy3KArOpzFLYoicyl7WrTlyzZPh3/Uz5PR3UaMBClg
	 AghjOLkOBdVtsQstlsclirzJKpRTN7egdpvRrzpkj7siRf1s6KlzRsIpFGnMIxlWSk
	 LsfbnT4M4pdk34c5AtfgVPzCbvZiwAFf7nxOtvbzIcbgoiYBNGrvnFda50NKD+TWN6
	 F8OHhIeKiMY6g==
Date: Mon, 22 Sep 2025 14:56:01 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
Cc: lpieralisi@kernel.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, kwilczynski@kernel.org,
	bhelgaas@google.com, conor+dt@kernel.org, andersson@kernel.org,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	mani@kernel.org, krzk+dt@kernel.org
Subject: Re: [PATCH] dt-bindings: PCI: qcom,pcie-x1e80100: Set clocks
 minItems for the fifth Glymur PCIe Controller
Message-ID: <175857096123.1104979.8944000757958543283.robh@kernel.org>
References: <20250919142325.1090059-1-pankaj.patil@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250919142325.1090059-1-pankaj.patil@oss.qualcomm.com>


On Fri, 19 Sep 2025 19:53:25 +0530, Pankaj Patil wrote:
> From: Qiang Yu <qiang.yu@oss.qualcomm.com>
> 
> On the Qualcomm Glymur platform, the fifth PCIe host is compatible with
> the DWC controller present on the X1E80100 platform, but does not have
> cnoc_sf_axi clock. Hence, set minItems of clocks and clock-names to six.
> 
> Signed-off-by: Qiang Yu <qiang.yu@oss.qualcomm.com>
> Signed-off-by: Pankaj Patil <pankaj.patil@oss.qualcomm.com>
> ---
>  Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Acked-by: Rob Herring (Arm) <robh@kernel.org>


