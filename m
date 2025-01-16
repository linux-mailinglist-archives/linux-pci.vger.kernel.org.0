Return-Path: <linux-pci+bounces-19999-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B91A14094
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 18:18:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C91C3AA83B
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jan 2025 17:18:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B2D01917F1;
	Thu, 16 Jan 2025 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CI84PlUe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9D514EC4E;
	Thu, 16 Jan 2025 17:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737047932; cv=none; b=MVBbvoFjk911LvshHapROThkMGj9bJ5EctFMqUxs/asryDrGvaH3u0CHmSPSzHAIL/Qy8ePzcWo5h9qEvqCPZMG5mae2tQahnxdRsnrJflgTogBXCfXWhVYCiUCd5MldiHMQXygOLyBxrkv3bUsez3B4F6PU0bksfEtxDKmC/rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737047932; c=relaxed/simple;
	bh=TVCXj+YjsIO3sWzLycpEciLhX8CUcnj5sMP5OiVH360=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=DBAu8VcAYuRZB7RbD0MeBO4GbhE6m1E7Wl/dUe14Lj11QKgFZ+CL7ZyegC5VlKMRbYLgw6pRYenb5+aNYD9Bcm1933BLBNY2peMzAb+o/4L+CQ85pqRCn7Jb1sTA7deZLUe13QT48F4tkhFYBQNePv1Gx4kWf1T/76TEbUKe6e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CI84PlUe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D909C4CED6;
	Thu, 16 Jan 2025 17:18:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737047931;
	bh=TVCXj+YjsIO3sWzLycpEciLhX8CUcnj5sMP5OiVH360=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=CI84PlUeMBLhgkD9T89DhBTDkC9lNzj5pCO5F00ecsDpJFgTQWf2QI7jQ7fNXHEp2
	 XcN/d/nXExaC7xowOEw1eXcmHE5w1C0ZtLiNkzhrcyoWl/zIolIoIKHZYhctKdpukg
	 McfrgHGIBPCbkXWKghpuDOrxEggrIRzqPF2AyITibVHQa5WLVRczPBRP9591H49A2W
	 TDj408ZMicUuxJzawV/M/8xI6XVjzqTmXQITVQfs8GwOM5vcmNoixYbk1qQip9LnN7
	 o7uY7UXUliIn8+rMlM8rUOLAFFkaM/bUWbZybnvi9LqrXzzV2jB29XZsYJOIP1fXsQ
	 udl+29m5xyasw==
Date: Thu, 16 Jan 2025 11:18:49 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
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
Subject: Re: [PATCH v2 1/4] arm64: dts: qcom: sc7280: Increase config size to
 256MB for ECAM feature
Message-ID: <20250116171849.GA590910@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241224-enable_ecam-v2-1-43daef68a901@oss.qualcomm.com>

On Tue, Dec 24, 2024 at 07:40:15PM +0530, Krishna Chaitanya Chundru wrote:
> From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> 
> Increase the configuration size to 256MB as required by the ECAM feature.
> And also move config space, DBI, ELBI, iATU to upper PCIe region and use
> lower PCIe region entierly for BAR region.

s/entierly/entirely/

