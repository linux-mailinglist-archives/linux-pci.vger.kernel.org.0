Return-Path: <linux-pci+bounces-4326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9030886E2D6
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 14:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA03E1C214A8
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 13:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0AB69E1C;
	Fri,  1 Mar 2024 13:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O9tcttBq"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DAF6EB7C;
	Fri,  1 Mar 2024 13:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709301435; cv=none; b=VzKa1mxro6ORqXvcU9msuPmBq2C1IrRE3NpO3EsTxLfWvI2WrRll2pJD4c/mVnUTodIH0O6oBy1+Sp0XHmrS0rhvdSkTLqmu+g68GywLwDgQmwX51YHTUbfe3wbR8ZBNmtmp+W89X2969nLo8Q5RwIGUnkSwd2PLMWQujCptklg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709301435; c=relaxed/simple;
	bh=q6H+s7+gd2Vvp0gLoYzsJzAn9VGVJNmi9tsrXyKTsuU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urSPiTHHioSNTzQgMxmUw4s8mv46X3ULm3W3LH2GqfOjk3RJPYqYWpp/S/XT4CAMsjn/uz1XPwlhIW3CsTwqq8X6kZQssLHf+d2/jqwK9iATOPS2pYPJaZc/61TbK4whYrNELw4x24l7wjCVwM3rBCEdZGeTtD7/A4v3pC5HH5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O9tcttBq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5ADEC433C7;
	Fri,  1 Mar 2024 13:57:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709301434;
	bh=q6H+s7+gd2Vvp0gLoYzsJzAn9VGVJNmi9tsrXyKTsuU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O9tcttBqZrp/c+OnpaWXkOIUnpaVgqBWjmTwwkfJqTek+iVdzbKGBDtgdhbR13487
	 LnJBXr+InD5qozAtlvdt8l61YC0km25+cjg6gbI1S30Br9IilmkNJM3PGopc9XDvej
	 e3QjvX4ahfxKI7k0p3ywte51LhpIbGxCdUUMzI3lalEVy3Tz+GdGJXG7FaxVaQydg1
	 V8XzalgF71zkDc+i5q4ghvw9GHEikHiu0bkX1cCGXDZMEbhO7y8q7x2VMwgXRYKSLd
	 xhpek+lGfGT3jaCv0n0mpyEUXnvNqrjP3mabqPemM1HqzLWteTCAc74d2kRBqm2z+0
	 4e5vjkgBdLszg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rg3OA-000000001PI-2QRh;
	Fri, 01 Mar 2024 14:57:26 +0100
Date: Fri, 1 Mar 2024 14:57:26 +0100
From: Johan Hovold <johan@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Johan Hovold <johan+linaro@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/12] arm64: dts: qcom: sc8280xp: PCIe fixes and
 GICv3 ITS enable
Message-ID: <ZeHexh-TJ8qxLTCO@hovoldconsulting.com>
References: <20240228220843.GA309344@bhelgaas>
 <20240229100853.GA2999@thinkpad>
 <ZeBbrJhks46XByMD@hovoldconsulting.com>
 <20240229122416.GD2999@thinkpad>
 <ZeCCPRVvYCNfMYnd@hovoldconsulting.com>
 <20240229135407.GE2999@thinkpad>
 <ZeCktwcEFAfCEVkV@hovoldconsulting.com>
 <20240301122406.GA2401@thinkpad>
 <ZeHOF4p1LlNDiLcy@hovoldconsulting.com>
 <20240301131445.GA5414@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240301131445.GA5414@thinkpad>

On Fri, Mar 01, 2024 at 06:44:45PM +0530, Manivannan Sadhasivam wrote:

> For the series:
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks for reviewing.

Johan

