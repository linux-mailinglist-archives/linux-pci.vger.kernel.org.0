Return-Path: <linux-pci+bounces-4282-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B346C86D58E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 22:05:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B90171C22A17
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 21:05:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FA9B6D51F;
	Thu, 29 Feb 2024 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TANW0ozA"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481C36D51A;
	Thu, 29 Feb 2024 20:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709239962; cv=none; b=N7eduPI8NTeoARbt9KeqzDIZ6lU2e+Uvc1t91DzkOZ+cG4iYm/TzFtCnnws/w9Sb+rOxaENwPS4rItGOtFmnJ5gl/KiIk2CXaBGlI4DtU7xMfVU6d9GJl46/eQeBKWp1jYXS6fJypWXC7X9/e8LemwYqCSgJC1J/Ln993A06q6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709239962; c=relaxed/simple;
	bh=CsLQ4dZCelScfRnYjaZt1AjDEqq01xy8aL6Jr73WL4o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h/8NB5beQpeDNKccJVJ6JWMAoiha+sAPI4yTr7mj4cr5m4gUlD6zfQbhZM5VivDPsqmN0O3ghjSKNLOzubZXXelz0McWECQmuje4YNuUEz1qj7cIjzBww7/w4eb6Xy7nn/JbIQ62Xb+pVYwfLwVpNVS0UCS8Z1JAFqplny1hinY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TANW0ozA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C486CC43399;
	Thu, 29 Feb 2024 20:52:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709239962;
	bh=CsLQ4dZCelScfRnYjaZt1AjDEqq01xy8aL6Jr73WL4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=TANW0ozA+czmFr2lgmCX3j/bexTlqKQ7kPo2STpBGcIJXvUdw/Z4tWGYRYJA4cW9/
	 aven+jrS355EfGVlG7vuEr6Rt0rCAfHx8eGxFip3hs2QloM2bbuUSyIgwJ/j5JHt5P
	 NByiAqo5BPIEXxi+AuXc58/VcnddQp6hahfKDNGjv08Wz7+gBivoNjscHXhAL1ZcCg
	 g/MrHhTfXHDBShRiGub2Vn6Nrz6uN2qyJuREBlLf8iDqGEXOyyKIYZ1LZZjN52hUwu
	 fXxBSI4StIzH9WGZ0Up+DPdjB4U5P7tu3mHkoVG60YJuhpja7DlCUIaN9pu9JP9aS0
	 t+ET8NnuH+EpA==
Date: Thu, 29 Feb 2024 14:52:40 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
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
Message-ID: <20240229205240.GA361626@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeCCPRVvYCNfMYnd@hovoldconsulting.com>

On Thu, Feb 29, 2024 at 02:10:21PM +0100, Johan Hovold wrote:
> On Thu, Feb 29, 2024 at 05:54:16PM +0530, Manivannan Sadhasivam wrote:
> > On Thu, Feb 29, 2024 at 11:25:48AM +0100, Johan Hovold wrote:
> 
> > > As I mentioned, the 'required-opps' binding update is needed to
> > > fix the missing OPP vote so blocking the binding patch would
> > > block merging the DT fix which could otherwise go into 6.8.
> 
> > I agree that the fix gets the priority. But some maintainers
> > perfer to merge fix patches _only_ if they are fixing the issue
> > introduced in the ongoing release.  But if Bjorn has no issues in
> > merging these for 6.8, then it is fine.

I do prefer to merge only regression and important fixes after the
merge window, so I want to be able to provide justification.

> It also depends on the severity of the issue and to some extent the
> complexity of the fix. These binding fixes are certainly low risk.
> :)

IIUC we're talking about:

  arm64: dts: qcom: sc8280xp: add missing PCIe minimum OPP
  dt-bindings: PCI: qcom: Allow 'required-opps'

These don't look like a regression fix (correct me if I'm wrong), and
I can't tell whether they fix a user-visible problem, since
sc8280xp.dtsi does already contain 'required-opps' for ufs_mem_hc,
usb_0, and usb_1, which are mentioned in the commit log as covering up
the issue.

If these patches wait until v6.9, what badness ensues?

Bjorn

