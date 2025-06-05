Return-Path: <linux-pci+bounces-29052-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98CA0ACF55B
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 19:28:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67CD2163FA4
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 17:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A9E1DE4DC;
	Thu,  5 Jun 2025 17:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S2+xcgAD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7590913D521;
	Thu,  5 Jun 2025 17:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749144524; cv=none; b=gTYcHelCQ4XorOAQdlMoM0pZ3XLr0zDEgusMgjY1omc+zzRyHxx26A6CICq2O599JcrztUEYBuaTel1s/iZrkLpat/Sd11vpmImrPdy2+RlwVH3B7WtT1eTCb3HkqlAh/eiIf7vAB1A7/36W6MCa74dWIAAak4Jy6yFPoHifV/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749144524; c=relaxed/simple;
	bh=pPVln6uz8VEQ1LSlOwYmeTuxkB56Y7tsEA6ufuwufOo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FcVtyxusL3RX5IhNQ6oYoNP3xR3R7u4vlGFR/NCLInJqXcZXsnbDteen39QmzkodRoLU65ORlCb97bqUEIWxq1afJHvA1kmZ9wLqcGRzmiAfIfgkTjrKNY9qWQpG9xKyRbcWnU8oOZxFQlDzPcN7CYbH0y9mVmSydMNtU/5fP/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S2+xcgAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3BC6C4CEE7;
	Thu,  5 Jun 2025 17:28:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749144522;
	bh=pPVln6uz8VEQ1LSlOwYmeTuxkB56Y7tsEA6ufuwufOo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S2+xcgADCL+DajqMqwiGzac8V+G6v/M72VFV2/prRE0TV8k+VXNQrVzkfEuiIANQM
	 kFuBQlWtA84eshRcAmBCIuMao1tcyg6PEAaopfsRNIhCi6WuCWkuU2Q4COVC0zjMGM
	 kQePEw/lpYQN31MCjWHDWyaNt3mWcUp7ybT8kpJJhMBkHazcg2vDrP9+hHT0MNLf3y
	 QjQxDRHZfvTG2NwCuXkUq4loF0oqKYt3YDI1MrOMYqAuG0+XAmQEx4rsZ49TAJh/d+
	 03kkDTZHIQBn3yLgYtFUE2P25LVheKpt6J5scZiCAVL/fDgKFMllUIAPxTBK5jYtRd
	 A5c/8el8Ktz7Q==
Date: Thu, 5 Jun 2025 12:28:40 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Mayank Rana <mayank.rana@oss.qualcomm.com>
Cc: manivannan.sadhasivam@linaro.org, linux-arm-msm@vger.kernel.org,
	quic_nkela@quicinc.com, linux-pci@vger.kernel.org,
	quic_msarkar@quicinc.com, quic_shazhuss@quicinc.com,
	krzysztof.kozlowski+dt@linaro.org, lpieralisi@kernel.org,
	kw@linux.com, conor+dt@kernel.org, quic_ramkri@quicinc.com,
	bhelgaas@google.com, devicetree@vger.kernel.org,
	quic_nitegupt@quicinc.com, andersson@kernel.org
Subject: Re: [PATCH v4 3/4] dt-bindings: PCI: qcom,pcie-sa8255p: Document
 ECAM compliant PCIe root complex
Message-ID: <174914451774.2895726.5063599337799991617.robh@kernel.org>
References: <20250522001425.1506240-1-mayank.rana@oss.qualcomm.com>
 <20250522001425.1506240-4-mayank.rana@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250522001425.1506240-4-mayank.rana@oss.qualcomm.com>


On Wed, 21 May 2025 17:14:24 -0700, Mayank Rana wrote:
> Document the required configuration to enable the PCIe root complex on
> SA8255p, which is managed by firmware using power-domain based handling
> and configured as ECAM compliant.
> 
> Signed-off-by: Mayank Rana <mayank.rana@oss.qualcomm.com>
> ---
>  .../bindings/pci/qcom,pcie-sa8255p.yaml       | 122 ++++++++++++++++++
>  1 file changed, 122 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


