Return-Path: <linux-pci+bounces-22888-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEEAA4EC7E
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 19:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3C028E243C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Mar 2025 17:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3B1296D55;
	Tue,  4 Mar 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bKYyMLJ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB74264620;
	Tue,  4 Mar 2025 17:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741109794; cv=none; b=GcmlYQEAItndsMayrK5agxe4sfHMEsjWPgr1sBjiXNF/TRnsuXyhab00DpuzF95iGvS0UBadVXr5Fzmil4MXru+gt/eE2AC4ICVrlS2S8j5LawznAuQYq14fPh1jNtDN4ZLrCuGSgHstVreKcY/ioNeDPqwE/uD07+gcn3XyGvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741109794; c=relaxed/simple;
	bh=4xp4+anK14JQk+kT/F+uLJnv73+F1a80g9z7dafx3bU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=M5he7FFJQnVA69of/h0GI9BP5U3eatkMFyy4iQnlHRJUmfxyaFPfr7lqbbwVIsle8VJwkDtGk0wCqOgGoUomPsPu0prb23aeXCSVOPdu85na3el4zAs+CMsAV3yW9cu4+5ewj38bVDU9z6Gcrxoe/qBzOswWgD1AO0H5AWsvSCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bKYyMLJ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C95C4CEE7;
	Tue,  4 Mar 2025 17:36:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741109794;
	bh=4xp4+anK14JQk+kT/F+uLJnv73+F1a80g9z7dafx3bU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=bKYyMLJ+yOp+0aO9VyEpW+tSgo9qctpb7iguPytHoQU0sfJKJ+XoZAJZmaQkjyTfT
	 hehyQtmSyO4BUnQZBl+mhm/sv2wrBZoIEYviegMRdxEJ7ET4WyniNFxMd4W+Rb3kTi
	 V4pUatRzJzPAIaZ1OapVH/ueOT+AATjfwo/PhvKnT8xKN0v9sIquCXlF2f+VQfkpd2
	 nROLiqP3ksHB+/N4ZvMOdbFJQC9N5s0sN2YamzMzDksrwVwOR5iuJQf1tKMdAM0Nig
	 cnCboG+5xb+FcRmw2NSvQAEIEaIRnEld5eCqvecQ5KY0OWd1es3JFcFiU37U+HAXLH
	 2Bi6Nt2CvY5AQ==
Date: Tue, 4 Mar 2025 11:36:32 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Inochi Amaoto <inochiama@gmail.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen Wang <unicorn_wang@outlook.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Johan Hovold <johan+linaro@kernel.org>,
	Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>,
	Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, sophgo@lists.linux.dev,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 2/2] PCI: sophgo-dwc: Add Sophgo SG2044 PCIe driver
Message-ID: <20250304173632.GA243820@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304071239.352486-3-inochiama@gmail.com>

On Tue, Mar 04, 2025 at 03:12:38PM +0800, Inochi Amaoto wrote:
> Add support for DesignWare-based PCIe controller in SG2044 SoC.

> +static void sophgo_intx_irq_eoi(struct irq_data *d)
> +{
> +}

The empty .irq_eoi() is unusual.  Why do you need it?

I see that the existence of chip->irq_eoi() makes a difference in
chained_irq_enter() and chained_irq_exit(), but I'm surprised that
this is the only driver in drivers/pci/controller/ that implements an
empty .irq_eoi().

A comment here about what is special would be helpful.

> +static struct irq_chip sophgo_intx_irq_chip = {
> +	.name			= "INTx",
> +	.irq_mask		= sophgo_intx_irq_mask,
> +	.irq_unmask		= sophgo_intx_irq_unmask,
> +	.irq_eoi		= sophgo_intx_irq_eoi,
> +};

