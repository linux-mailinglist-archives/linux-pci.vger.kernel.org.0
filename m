Return-Path: <linux-pci+bounces-25718-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E7CA86EAC
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 20:13:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65FA81890F31
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 18:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70302208997;
	Sat, 12 Apr 2025 18:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXJVWwK2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408FB205ABB;
	Sat, 12 Apr 2025 18:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744481575; cv=none; b=C5J36Jge8Uo/vnHHiHTpVUFQDNq3Nub9T3AmC+jbh/oDa7RY0miyW2tvkAWk1S3mWxFjBiXZcFjYAwOh1RHQVttMV83oG9Vf75hNm1k0MfVXj9e3mmTU7blbJ/A+AORiJsF0Mm5oOOpyohSEZEQ4zPuoSk4938etxkOu2/+jMPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744481575; c=relaxed/simple;
	bh=8ZMhNL0HAVO4YdJ4TTaWJP3WsvNWh9xZuA8vyiaBt/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H1dOInOG0XGKm0Y5g4UI6ux/QIOEXANx1O/CcFbCt4XzJA857dKpx0PPsWzcgAr8lr/8IJMHEtLMbZZV0vHWfuzHV1zJw99Y3eUZ7ahWlkVaO7OwCdg6oNDflnqeMXUR1TKIlkqKFpdCJYQLJ7YpW7ayD21HhwGzzXu9T2FdufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXJVWwK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A893C4CEE3;
	Sat, 12 Apr 2025 18:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744481574;
	bh=8ZMhNL0HAVO4YdJ4TTaWJP3WsvNWh9xZuA8vyiaBt/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HXJVWwK2RzTe88EvjbeSezuB+fQtgh42HOPafUyPikXICzsH1dSCVqmlvX2yfuc81
	 mX7uq+KPolqnPUbj95jp20XdJknp0h+ihWzVzHHPuzhi2NIfN17peHnWfp7XZ6AT3N
	 S1TvMyw/UeNc+4lsm7U2fLQ54+EZmRyeLmfnQxvmFwzjDVZhQF4eI7DrY4V5Jyn0IJ
	 WRLvr4Eu3Zr4FJ3B6gfAFMHaB6GcvQN+3jiDUs0+6Ml1dTv1SXIn8Hw6d2qPtLZsaJ
	 rDzJ718ukyGZKzQlLwH5DFw00LSLJj75nfgPa+5rIM/2hbWhGw/ZgPM1Er8CqADnds
	 sk6LZ8LQ9ZRdw==
Date: Sat, 12 Apr 2025 13:12:53 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: cros-qcom-dts-watchers@chromium.org, quic_vbadigan@quicnic.com,
	devicetree@vger.kernel.org, Konrad Dybcio <konradybcio@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	jorge.ramirez@oss.qualcomm.com, Dmitry Baryshkov <lumag@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	chaitanya chundru <quic_krichai@quicinc.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, amitk@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	linux-arm-msm@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v5 1/9] dt-bindings: PCI: Add binding for Toshiba TC9563
 PCIe switch
Message-ID: <174448157279.1425104.5352261835417060521.robh@kernel.org>
References: <20250412-qps615_v4_1-v5-0-5b6a06132fec@oss.qualcomm.com>
 <20250412-qps615_v4_1-v5-1-5b6a06132fec@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250412-qps615_v4_1-v5-1-5b6a06132fec@oss.qualcomm.com>


On Sat, 12 Apr 2025 07:19:50 +0530, Krishna Chaitanya Chundru wrote:
> Add a device tree binding for the Toshiba TC9563 PCIe switch, which
> provides an Ethernet MAC integrated to the 3rd downstream port and
> two downstream PCIe ports.
> 
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
> ---
>  .../devicetree/bindings/pci/toshiba,tc9563.yaml    | 178 +++++++++++++++++++++
>  1 file changed, 178 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


