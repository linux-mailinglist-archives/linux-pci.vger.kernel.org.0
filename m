Return-Path: <linux-pci+bounces-20310-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32666A1AFF8
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 06:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C1D188F766
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jan 2025 05:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741381D63DF;
	Fri, 24 Jan 2025 05:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X+lGmCTZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3926617FE;
	Fri, 24 Jan 2025 05:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737697230; cv=none; b=JhvnK9IKAflkLshMN4DTcIPIL1RxtjUsWkq55CCZXmdn4bHPCUmU3dUrMXxVxi5CKZec4EG3LdkC0xxpzfQhNz3X+tjRSSeGAVp1i7ZC6mddXdfF7MwBjue37V6q4Xt81RAr6PMVrdkoHmD7MjNLZOxvNdSGgFn33Kcw+wLjIlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737697230; c=relaxed/simple;
	bh=Hpjcxr9NukUy6rJZPiuMedtcj36WhubCJwMNNtamwt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPh4rFzn4q2dKaPpovBYTkqiEsGPEP/zz0/8tJdlRSakmQhU/FcXGeF69D0XnGA/KpnohYugsbet4vz1C2b7RzogXBeBwwz4dbS8t8SyAVmuxzPqPEQfv51op7A6jygx6RKJg9sYcm8DYTYij3pyxelrSRyXY9QRLU5kJ7vhIWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X+lGmCTZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E6DC4CED2;
	Fri, 24 Jan 2025 05:40:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737697229;
	bh=Hpjcxr9NukUy6rJZPiuMedtcj36WhubCJwMNNtamwt8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X+lGmCTZs8sGOW6HzIVGVvQvgKqFhipe+Iqw0GVTHG5saHPycCaqBeIV77FsTu3LL
	 a7gW9l9AV9hH1DGiBnSnQQhAqzMLncOru47QDXavHK7FceU4AzDMi0hOEtajnY+qrG
	 Np9KmuBn4z8LUzc/xPOeo49jxPFb1lhWDimda2SulGY7yxMMt2XpDg0UljMAwDPuW4
	 zYCn9t/Aeb6cCO+SgBiUe4EP01YMfpd0ktQ736SLgwoyIX5FNNkPtpP8SNXpJ1kdxU
	 2FVC/HFMtZznXQAS9qPdYWYYvlIOVlh5i5SSX7FC1wuFPjqif7D522uwliFtjFygF4
	 U28T635ZU1Rfw==
Date: Fri, 24 Jan 2025 11:10:17 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jingoo Han <jingoohan1@gmail.com>, linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, quic_vbadigan@quicinc.com,
	quic_vpernami@quicinc.com, quic_mrana@quicinc.com,
	mmareddy@quicinc.com,
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: Re: [PATCH v3 1/4] arm64: dts: qcom: sc7280: Increase config size to
 256MB for ECAM feature
Message-ID: <20250124054017.rmrxqa5kyocuf2fi@thinkpad>
References: <20250121-enable_ecam-v3-0-cd84d3b2a7ba@oss.qualcomm.com>
 <20250121-enable_ecam-v3-1-cd84d3b2a7ba@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250121-enable_ecam-v3-1-cd84d3b2a7ba@oss.qualcomm.com>

On Tue, Jan 21, 2025 at 02:32:19PM +0530, Krishna Chaitanya Chundru wrote:
> PCIe ECAM(Enhanced Configuration Access Mechanism) feature requires
> maximum of 256MB configuration space.
> 
> To enable this feature increase configuration space size to 256MB. If
> the config space is increased, the BAR space needs to be truncated as
> it resides in the same location. To avoid the bar space truncation move
> config space, DBI, ELBI, iATU to upper PCIe region and use lower PCIe
> region entirely for BAR region.
> 

You also need to mention that this change depends on the commit: '10ba0854c5e6
("PCI: qcom: Disable mirroring of DBI and iATU register space in BAR region")'

> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்

