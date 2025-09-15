Return-Path: <linux-pci+bounces-36151-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7B0B57BED
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 14:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5C3220694A
	for <lists+linux-pci@lfdr.de>; Mon, 15 Sep 2025 12:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4265430C379;
	Mon, 15 Sep 2025 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ACQk6zaL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBFF306B23;
	Mon, 15 Sep 2025 12:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757940834; cv=none; b=r0i2bDLRQT//bx3TcbfINQ+FTe02zLUlKo/ThZ1Gs3JLMDTZdQuCGsrhExNEIqakvQrnE+776o+jMDB67hacNlVIM9UJ/oxz8MzcNLkniyuob9KWhshOB10dDYLqiGpq48CC3YcvmYlvwllz5/AdxZB7V7eKDdPF4pSj5tTQZfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757940834; c=relaxed/simple;
	bh=aqETlmDmWR4pUzAUT/120cFRSo7KiyoK/PKhhV+Y9Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qFhrG5OjgY9JtQrPKLURQOhnNWeVnaygVeUgrydpYr6PCEgs54eFvNK+CTIHArEsqoEO25tIUSWuluYM5F5iR53YalxGzCevbd8dZizYpRx3wcRBTBHLpm9V39uWlQlK6ujfGyIVhCqycrtIk83Qga4y5tnR11HosImZ3yKWDzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACQk6zaL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C4FBC4CEF1;
	Mon, 15 Sep 2025 12:53:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757940833;
	bh=aqETlmDmWR4pUzAUT/120cFRSo7KiyoK/PKhhV+Y9Mg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ACQk6zaLUFRXioPyBElZtBPJndRyWfl6aKL1M4oVNK+MYg4LyUE7mowXvAAaeP0EA
	 j1m2afNNLWxbBBaCsIhvLcmAshdwPv2/++kuFob1Q2vZYR5K7CNH7XUzJlfWwB4zyN
	 Tiust8tnGeOk1heANFk2bRTS2wPnKoB3F6y6gwIctvKGw7Sq0g7mSbF5VGpcw9UAZ3
	 62zED32ZgxsYt8vgvfghpgqIGY25bXt9Py2MwuysQ4FgrRKD8UqN623yC8MuKs6Lrl
	 ijXRCG/5VMRues4tH9Bktr2m21e61eiIH+QVzT7Np/LFvKi2uUgzZYpRnMZYywv4x6
	 ZrUPgJ8kKkoNg==
Date: Mon, 15 Sep 2025 18:23:45 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@oss.qualcomm.com, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Saravana Kannan <saravanak@google.com>, 
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>, 
	Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH v3 3/4] PCI: qcom: Parse PERST# from all PCIe bridge nodes
Message-ID: <blgpkdfx333h6vu25peatl3bbxffe5vuovgmae4osuoahuiryp@owrxkcv63kxb>
References: <20250912-pci-pwrctrl-perst-v3-3-3c0ac62b032c@oss.qualcomm.com>
 <20250912232811.GA1653368@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250912232811.GA1653368@bhelgaas>

On Fri, Sep 12, 2025 at 06:28:11PM GMT, Bjorn Helgaas wrote:
> On Fri, Sep 12, 2025 at 02:05:03PM +0530, Manivannan Sadhasivam via B4 Relay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
> > 
> > Devicetree schema allows the PERST# GPIO to be present in all PCIe bridge
> > nodes, not just in Root Port node. But the current logic parses PERST# only
> > from the Root Port nodes. Though it is not causing any issue on the current
> > platforms, the upcoming platforms will have PERST# in PCIe switch
> > downstream ports also. So this requires parsing all the PCIe bridge nodes
> > for the PERST# GPIO.
> > 
> > Hence, rework the parsing logic to extend to all PCIe bridge nodes starting
> > from the Root Port node. If the 'reset-gpios' property is found for a PCI
> > bridge node, the GPIO descriptor will be stored in qcom_pcie_perst::desc
> > and added to the qcom_pcie_port::perst list.
> 
> The switch part doesn't seem qcom specific.  Aren't we going to end up
> with lots of drivers reimplementing something like the
> qcom_pcie_port.perst list?

If this kind of switch is attached to other platforms, then yes. Right now, Qcom
host is the only known DT based host platform that has seen this requirement.

If other drivers also start showing this pattern, I may try to create a common
code somewhere to avoid code duplication. But now, common code is not warranted.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

