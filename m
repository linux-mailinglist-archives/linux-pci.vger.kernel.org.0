Return-Path: <linux-pci+bounces-9321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A141A9185D6
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 17:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4155CB2B676
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 15:30:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5873718C331;
	Wed, 26 Jun 2024 15:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hgjI3B92"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2837418A95A;
	Wed, 26 Jun 2024 15:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719415774; cv=none; b=MNoJqAvDmCKMLL2p1WwOtFF6MlrqJBIW06+ifX7CwX7FUPgVhG+iG0eyfz5v8y0TZphrWa7QnXw4oNKzsKymp9R8S3gvcnooUOyJhlZ7n5fD6FodGlnQV15q0GYavz92XNdGaP27dGz4luRbQAGw1rsUEYfmFYypuk4OX8/lUug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719415774; c=relaxed/simple;
	bh=tn+0wc0SWf+K7ShAbsHDVu8PM/PzdESvEuUAgQX5AYE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=Vr1zW1JlWt+nvLBaiTIzdiicOPMjqpCGlUktFsm7d+3EbDa5a5cRcwmRanJ5695TjEW5lfKp0btH9SYUOZjRGwjU3EF76RKvekL4Pz3Qf8iymBF+18QPcq2gM9XssLeFiRljLWdsXeDT0lnICNVQyC+YaFhYwT/30fO0j3XSZOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hgjI3B92; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703C5C116B1;
	Wed, 26 Jun 2024 15:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719415773;
	bh=tn+0wc0SWf+K7ShAbsHDVu8PM/PzdESvEuUAgQX5AYE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=hgjI3B927W4sKIv97HF4xJVonGiMTt++c17owxPWvBYRP253LM63PZugPYSfouOl4
	 ya6CUFpx4gSUZR8CWHXU/DTcnwbBaF8/sQCiHgAg0qkM0r+v1gMRW9qHqi7AVnb93t
	 oRjGcGjT58tu8bXFy7PiDO9hc9K7itrZzrWTznatV+9WngMKSeLB7R5xll7RW4BA63
	 j3zgwNJiYxY3qDvbVn7Bl0JPPx2o6b6MPrPKHKIG6hYbtlSYwOl6K5K0HuG0lCWqQC
	 McQLUc8XmCPqouXXgxBhjJLyqEbz7dJEkguy/lkylXAJ2c1JY0s9TIkOhQV3HfQE3s
	 IpZNCBBBd+A9w==
Date: Wed, 26 Jun 2024 10:29:31 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Jingoo Han <jingoohan1@gmail.com>, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC 0/7] PCI: enable Power and configure the QPS615 PCIe
 switch
Message-ID: <20240626152931.GA1467524@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>

On Wed, Jun 26, 2024 at 06:07:48PM +0530, Krishna chaitanya chundru wrote:

> Krishna chaitanya chundru (7):
>       dt: bindings: add qcom,qps615.yaml
>       arm64: dts: qcom: qcs6490-rb3gen2: Add qps615 node
>       pci: Change the parent of the platform devices for child OF nodes
>       pci: Add new start_link() & stop_link function ops
>       pci: dwc: Add support for new pci function op
>       pci: qcom: Add support for start_link() & stop_link()
>       pci: pwrctl: Add power control driver for qps615

Take a look at the git history of the files you update and match the
style.  s/pci/PCI/, for instance.

