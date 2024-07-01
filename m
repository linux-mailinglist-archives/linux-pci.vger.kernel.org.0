Return-Path: <linux-pci+bounces-9523-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2C091E6EC
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 19:52:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79749281F35
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 17:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8D6A16EBE8;
	Mon,  1 Jul 2024 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FKH7srHI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A8816EB77;
	Mon,  1 Jul 2024 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719856312; cv=none; b=tEh61Jd8uz7gJHwiisNsz7qDP0j4iOESSCitrJLl+5MvN1KnU820See/5/DwomTDHglpdSLxQORiXBm0RIIedyLem1x0YKwkhBRS2374eI4CHOUwDjkWK/FPT1Vr///Cms/tI/BXe2lGe5CKtxLL/gyns+R8cJ33EJWYQkHkE+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719856312; c=relaxed/simple;
	bh=+xTcvxBakZ4cHh0hXoK9EpJRwYxm/3zwJmLM/+ERZyc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OyMmLoArLaqI4Qe/aIjy84iP1GwjHn2x8tv+Y125/bO2h6Rke0GMGuGwumXOfwf3+kw3Nfdg3KZ1XLP/lbOM8bh8O4WSaSHEQiy85ow8I4kBlJ2c1/F/JuSAmzi5pEbAXTLsJVjbmMkMqcEtTLx+NZFKpTR/6IK+ft72ZuifElI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FKH7srHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31FBC116B1;
	Mon,  1 Jul 2024 17:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719856312;
	bh=+xTcvxBakZ4cHh0hXoK9EpJRwYxm/3zwJmLM/+ERZyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FKH7srHI4Yo1MYbh1wm2OLGqHckHihJmvcF+yJfLIOPxZJYM8uje+hAqVUn7J4sOV
	 dSC8EXnJ8xX+YM3CP5NSk6RCwdhGJl/sMgn0UgObqwTS+1THutn3ShGabc7hkLhYWc
	 Q2xjVfTYt5im03tQiPRQJ3aemWnw42gEAVUTrvuAz9u0sk9JULKbB0eCBhE5eP5jsm
	 H9qVfq8MxIuS5TUMn9QSgmJoqtJqQAO4iz9TT+Jf8uPgsVNR9eVAZXTfkBDiZ2THt5
	 TYaBcvh7baMNe/p6saTZKW+xHXTQL6bZMVaNK+aXhf6AGgtL4H9V//m7mIEZMu+c7e
	 x4YXpuwLXpYJg==
Date: Mon, 1 Jul 2024 12:51:49 -0500
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
Message-ID: <20240701175149.GA10638@bhelgaas>
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
>       dt: bindings: add qcom,qps615.yaml
>       arm64: dts: qcom: qcs6490-rb3gen2: Add qps615 node
>       pci: Change the parent of the platform devices for child OF nodes
>       pci: Add new start_link() & stop_link function ops
>       pci: dwc: Add support for new pci function op
>       pci: qcom: Add support for start_link() & stop_link()
>       pci: pwrctl: Add power control driver for qps615

Run "git log --oneline" on these files and match the style.
"PCI: Change ...", "PCI: qcom:", "PCI/pwrctl", etc.

The colon vs slash convention isn't obvious, but this is how we've
applied it in the past:

For PCI core features like MSI, PM, ASPM, AER, DOE, etc:

  PCI/<feature>: <Text>

For PCI drivers outside the PCI core, like dwc, qcom, imx6, etc:

  PCI: <driver name>: <Text>

