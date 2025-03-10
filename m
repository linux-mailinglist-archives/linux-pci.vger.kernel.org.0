Return-Path: <linux-pci+bounces-23297-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29A24A58FBF
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 10:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B82887A25FE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 09:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EF5224B08;
	Mon, 10 Mar 2025 09:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aBNnQJ5h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24D991C5D6A;
	Mon, 10 Mar 2025 09:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741599156; cv=none; b=UcGjvQPxNRTgMepNKXdqqIiEF3VMXdHMbrICnKqiKQCh72JfryLDm56q9oRfyE8ivs6D02QAzOOaAFMIBRnxYLctyegP6nMCJe+5UXKL4Myxk2Qw7ZNs7G4HFnIWYDG3K97i4hc3sb+zHgTHWCf+govzwJ3/EFjUG5oL51wX+4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741599156; c=relaxed/simple;
	bh=1DXbIDSv40GCjpvf8zEG7cq6F5YuAvlfpqHWbXxLuxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4lrCiiGl3cqPaAjtHoXULMT6kJDegj029abuB+5sk5A21/jRtG9CQrpJMhaWoC37AqQUWA4caokR2Pl406zDiPQ0W2jbLUPxZKDNMPJWUa+lRT1WZdlk4MkWzhh19vh9GBzAG5huaS4v+DX+GimtKansxTeHEeinSWdLEswwPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aBNnQJ5h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E21EC4CEE5;
	Mon, 10 Mar 2025 09:32:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741599155;
	bh=1DXbIDSv40GCjpvf8zEG7cq6F5YuAvlfpqHWbXxLuxw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aBNnQJ5hr4c4rVW9/H3OV21cK07YhkXgvsDTArI8P3pkwag/ZPPVFYVU66IL8yYgs
	 9IwjftriKoVv2KjQP/sSLj16mrNn9lwe052KosjvGx5+m8iI/ZrbKZuCFRXUBSPDRQ
	 aEUdyewsp7E7xx/XvDl5/O84HoTgWRoMueNgCgcT806QYUxb2zv2VpeA+k7oOwPHcJ
	 kbslKQUK4qroqSDNM0YUpo84ejD0iNemZfrS8aAZx1g6w7w2a2DH66XSGyNXjmM2jg
	 L6K4l5shuM/wZiIEpnB7LF3eGC40YSXFw6j/p0YeGwKoOM6aXzVB9z+rvM/VEYAnOx
	 fwxHHuIymse7w==
Date: Mon, 10 Mar 2025 10:32:30 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Bjorn Helgaas <bhelgaas@google.com>, Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	quic_vbadigan@quicinc.com, quic_mrana@quicinc.com, quic_vpernami@quicinc.com, 
	mmareddy@quicinc.com
Subject: Re: [PATCH v5 3/7] arch: arm64: qcom: sc7280: Remove optional elbi
 register
Message-ID: <20250310-pristine-idealistic-husky-1e57b2@krzk-bin>
References: <20250309-ecam_v4-v5-0-8eff4b59790d@oss.qualcomm.com>
 <20250309-ecam_v4-v5-3-8eff4b59790d@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250309-ecam_v4-v5-3-8eff4b59790d@oss.qualcomm.com>

On Sun, Mar 09, 2025 at 11:15:25AM +0530, Krishna Chaitanya Chundru wrote:
> ELBI registers are optional registers which are not used by this
> platform. So removing the elbi registers from PCIe node.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/sc7280.dtsi | 3 +--


Please use standard email subjects, so with the PATCH keyword in the
title. 'git format-patch -vX' helps here to create proper versioned patches.
Another useful tool is b4. Skipping the PATCH keyword makes filtering of
emails more difficult thus making the review process less convenient.

That's a v5 and still wrong... Can you pass the patchset through
internal review first?

Best regards,
Krzysztof


