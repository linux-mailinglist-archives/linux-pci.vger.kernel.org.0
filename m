Return-Path: <linux-pci+bounces-40913-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BCF1C4E430
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 14:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F30863AF010
	for <lists+linux-pci@lfdr.de>; Tue, 11 Nov 2025 13:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D47135A153;
	Tue, 11 Nov 2025 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tmm+B3BU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149E82DC767;
	Tue, 11 Nov 2025 13:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762869282; cv=none; b=OGDYpIw88jBYRoQAKAQ52Hx+Hz0sCJn7cGxkcKdorij1JSnx0dLfd1fQM3Eg/+A2BOd/9GsPXGZJhdvNMxDeKZ/vDRhrOCp4zyJaC6li5EJ5PVchSpsLiLgfJN5Xp6X91n8HXcDf6fnVQanLXiavkDvx9i5ma8OCDEkiyRJbJhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762869282; c=relaxed/simple;
	bh=kzBRt/6FXdJVMh+oQhkIqqIqXaAbK7z0aQCzdHQi5GU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCLs35xTNJAi82QT4qG53LlGEgiGvy6dq3zdwvTnWIcFdD1apzbC2LJemn4FXY5xbrqu36YDjDwPVH+7lmwvA748fWbzTZt6HHMxDzfZ5F06SBR1NObp2y74ZoZnuFTm6POlFsp4VdoeZrq6gKqYkMNeYl8jsu+vOsm0gXozeLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tmm+B3BU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC69C19423;
	Tue, 11 Nov 2025 13:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762869281;
	bh=kzBRt/6FXdJVMh+oQhkIqqIqXaAbK7z0aQCzdHQi5GU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tmm+B3BUMnjzouAnN9Z4hoRm4TpQUWHR5ctUTAQfE57xC/sDG/l8LH7AGNP5qz5K+
	 04QPlH4q+wZ2jLWt/9bvEj6mOAO2z8eD103oXj1/8RRg0DTZJgI0Mf/Oa2Z09JC57O
	 Jr3K7KBy/KPdUWItt6wUM5v4lczgoEoVoPK+hBDrAcjQD0Jf0Te0EUEBkbO3vqGxTQ
	 nHJehNy4uXXt8lL9q9557JJLEbUp1UWzjitcmUPfGxcUbwHiPKd8hAyqYisnHJpgr8
	 y5rKFsQfoKvI527uMabT89gPfReN4axDCYUs78jl9Fdybq1WJpJNdVP2Co4ixEKNE9
	 eErpJi2MB6mHw==
Date: Tue, 11 Nov 2025 19:24:27 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
	linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: Add PCIe M.2 Mechanical
 Key M connector
Message-ID: <gprypdqjusuhd2xoaho7hpm33flwq4puv2tcfawadqwqgxlbkl@6f23ng4hjbxp>
References: <20251108-pci-m2-v2-0-e8bc4d7bf42d@oss.qualcomm.com>
 <20251108-pci-m2-v2-1-e8bc4d7bf42d@oss.qualcomm.com>
 <b6bj7tqpp55lx24qcf6czqydmjfm2xaztcada4iczptaiozc55@c5xkbdxwe5jp>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b6bj7tqpp55lx24qcf6czqydmjfm2xaztcada4iczptaiozc55@c5xkbdxwe5jp>

On Sun, Nov 09, 2025 at 07:34:09PM +0100, Sebastian Reichel wrote:
> Hi,
> 
> On Sat, Nov 08, 2025 at 08:53:19AM +0530, Manivannan Sadhasivam wrote:
> > Add the devicetree binding for PCIe M.2 Mechanical Key M connector defined
> > in the PCI Express M.2 Specification, r4.0, sec 5.3. This connector
> > provides interfaces like PCIe and SATA to attach the Solid State Drives
> > (SSDs) to the host machine along with additional interfaces like USB, and
> > SMB for debugging and supplementary features. At any point of time, the
> > connector can only support either PCIe or SATA as the primary host
> > interface.
> > 
> > The connector provides a primary power supply of 3.3v, along with an
> > optional 1.8v VIO supply for the Adapter I/O buffer circuitry operating at
> > 1.8v sideband signaling.
> > 
> > The connector also supplies optional signals in the form of GPIOs for fine
> > grained power management.
> > 
> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > ---
> >  .../bindings/connector/pcie-m2-m-connector.yaml    | 122 +++++++++++++++++++++
> >  1 file changed, 122 insertions(+)
> 
> I would expect something similar to usb-connector.yaml, i.e. m2-connector.yaml,
> which then defines
> 
> compatible:
>   enum:
>     - m2-a-connector
>     - m2-b-connector
>     - m2-e-connector
>     - m2-m-connector

The interfaces of each Key greatly varies as per the spec. So I was planning to
use a separate schema for each one of them to avoid clutter.

> 
> (also not sure if we need the PCIe prefix, it just seems to make the
> name longer)
> 

The M.2 card is always connected to the PCIe connector even if the interface
could use something else other than PCIe. So having the 'pcie' prefix seems
logical to me.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

