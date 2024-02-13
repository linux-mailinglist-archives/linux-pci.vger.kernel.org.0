Return-Path: <linux-pci+bounces-3398-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FD7853414
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 16:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8452228E32F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Feb 2024 15:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F4B5EE80;
	Tue, 13 Feb 2024 15:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h6dM+pCT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E968D5EE60;
	Tue, 13 Feb 2024 15:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836464; cv=none; b=d+zE5ewbX2ZGT/A3ukNp2VmOGgcN8ntqGQEmnHLOyUwy2D7vxMxim/490R8hLJGyCUN/VfklIptXwyKD8TEffUokwngdh8PXVpFPyimSrmUA+DCTc3N/HSDWPtGjyGbQDMXoWFIHSVPL8fkFB+cME9XxQFw/zH+CKzPYYAhOX5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836464; c=relaxed/simple;
	bh=uHJ8QMuS8ivI4WXQ9n9PNE82twukstL8Xzx1tgomXCE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lbbAHWYJ0RGFTJojn52M/vezUcfITUPa7Dv1G4SApTDHoP3yD31OnyZVpe8ntPXtqpR4UJ5POrN5QpEQ/kFipvnjFkgEyoCXfn1vkbXdu5VwmQ5q+k7NQzwhkKDhr+YxuFcojOZGI/ToxdzeelJ9l2dqcw89EDekavYZlr1EgIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h6dM+pCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43FD8C433F1;
	Tue, 13 Feb 2024 15:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707836463;
	bh=uHJ8QMuS8ivI4WXQ9n9PNE82twukstL8Xzx1tgomXCE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6dM+pCT9QqTKsIRTYvJPtYFp/lx2ZogzuCbx2tKGnYUK6IAX8MaD1O6TV2xiLSKe
	 w8eqqBU1OiQ7GeQdhQKtz5D2yRrYTBhIPa7MMd0mwCiYRCQnjFtB0/rGZEgSvVC4gj
	 zPYrQkb1Vm696S7hTnFWb+uKN1uVXjRJ4G1fp9hXm/u+xErzTdv/tAtgtZUZ1KTb1j
	 Zhp+INdOkmFHESjQl92xg3pm+AQb5fCWoPEFmR2+YrMZ/XQZdDiWbiUutZUN2BQau+
	 c4hsOdWf8U9rSKyV6ePBkGgpVopu0pd0A5KIqcjgq7yzypCCfHkVrz+To+MK4u9Gkt
	 4NqcUq1O6TI7Q==
Date: Tue, 13 Feb 2024 09:01:01 -0600
From: Rob Herring <robh@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] dt-bindings: PCI: qcom: move to dedicated schema
 (part two)
Message-ID: <20240213150101.GA1186205-robh@kernel.org>
References: <20240205-dt-bindings-pci-qcom-split-continued-v1-0-c333cab5eeea@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205-dt-bindings-pci-qcom-split-continued-v1-0-c333cab5eeea@linaro.org>

On Mon, Feb 05, 2024 at 04:58:00PM +0100, Krzysztof Kozlowski wrote:
> Hi,
> 
> Please take this patchset and its dependency via PCI tree.
> 
> Dependency
> ==========
> This depends on:
> https://lore.kernel.org/all/20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org/
> 
> DTS fixes for interrupts will be send separately.
> 
> Description
> ===========
> The qcom,pcie.yaml containing all devices results in huge allOf: section
> with a lot of if:then: clauses making review and changes quite
> difficult.
> 
> Split individual devices into their own files, so we get rid of
> multiple if:then: clauses.

The downside to this is the resource names don't live next to each 
other. Then it is just a free-for-all on making up names with little 
attempt at alignment.

OTOH, I give up and your mess to maintain...

Acked-by: Rob Herring <robh@kernel.org>

Rob

