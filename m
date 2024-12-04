Return-Path: <linux-pci+bounces-17702-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E6419E4694
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 22:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F36DC282FBE
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2024 21:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE1B1917D8;
	Wed,  4 Dec 2024 21:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YX2Y0r/b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123B818FC9F;
	Wed,  4 Dec 2024 21:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733347563; cv=none; b=ozbn2k8CKbR2rp/Xj5HrC00jp9awSfwNOLmcneO93+zD0otjLrGU69ufoK3PySIgyRr1/fPpaWz3JlPNGB2XUdfY+kctSv5laRepDF5OsFxOF32g4f75fj41LE4Q3Euk/B/axNsRrDmrX6sB9gQ6heT6c5//5pjqZKJdiYDBaQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733347563; c=relaxed/simple;
	bh=DscPDxPjQQtywiUUDcE+YVrQwSFEki0Lzq8DayalJvM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k3yyH//O0q4Os6hs+Re+SzSPk0o1AIuR/mfN9jPbkOKWF3zpZqt1xp5uC/mZnEEviyNRdOD9H0JtLCAjI3Olg0Ni+uEE43r4DwldiX3sJz+BFKlIQZJFCtv0xG2SFf7z1dNIO89XoQEqEl510m8RIMtxqijCKnVb+8SlKzzJFRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YX2Y0r/b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43516C4CECD;
	Wed,  4 Dec 2024 21:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733347562;
	bh=DscPDxPjQQtywiUUDcE+YVrQwSFEki0Lzq8DayalJvM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=YX2Y0r/bEPLEC5E/UHU3/2F05Vrzawad2TeiHHQtcQs/hozwXiulCqOwhBTQ+ZT1g
	 yj4hkVZSMa0bR8Ug5Mlfc4BxGPjSFwwsXzZxsgb96yfVgLZUk9NW+Pa1YB0XbCwBQP
	 e9xL1Q80+4eQkq9n18Pr/J+8gKGWUtjaoPVZqIqhc7xOlSmmd0zYGYIQ65N2VBCM3+
	 9dYa9tw2PiY99ZhZLaE7WUItxfo632TGIMzBz+RxvZN9R6lsfxTK6PxjCCx25pP7xi
	 68uKzOzdmg+cqNb7qUsq4InQjeoCvPrkOuq/mvtPXKi2euqmwxeecBT1w4UinJK+00
	 OgPYF2rJIruEg==
Date: Wed, 4 Dec 2024 15:25:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: andersson@kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Jingoo Han <jingoohan1@gmail.com>,
	Bartosz Golaszewski <brgl@bgdev.pl>, quic_vbadigan@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/6] dt-bindings: PCI: Add binding for qps615
Message-ID: <20241204212559.GA3007963@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112-qps615_pwr-v3-1-29a1e98aa2b0@quicinc.com>

On Tue, Nov 12, 2024 at 08:31:33PM +0530, Krishna chaitanya chundru wrote:
> Add binding describing the Qualcomm PCIe switch, QPS615,
> which provides Ethernet MAC integrated to the 3rd downstream port
> and two downstream PCIe ports.

> +$defs:
> +  qps615-node:
> +    type: object
> +
> +    properties:
> +      qcom,l0s-entry-delay-ns:
> +        description: Aspm l0s entry delay.
> +
> +      qcom,l1-entry-delay-ns:
> +        description: Aspm l1 entry delay.

To match spec usage:
s/Aspm/ASPM/
s/l0s/L0s/
s/l1/L1/

Other than the fact that qps615 needs the driver to configure these,
there's nothing qcom-specific here, so I suggest the names should omit
"qcom" and include "aspm".

> +    pcie {
> +        #address-cells = <3>;
> +        #size-cells = <2>;
> +
> +        pcie@0 {
> +            device_type = "pci";
> +            reg = <0x0 0x0 0x0 0x0 0x0>;
> +
> +            #address-cells = <3>;
> +            #size-cells = <2>;
> +            ranges;
> +            bus-range = <0x01 0xff>;
> +
> +            pcie@0,0 {
> +                compatible = "pci1179,0623";
> +                reg = <0x10000 0x0 0x0 0x0 0x0>;
> +                device_type = "pci";
> +                #address-cells = <3>;
> +                #size-cells = <2>;
> +                ranges;
> +                bus-range = <0x02 0xff>;

This binding describes a switch.  I don't think bus-range should
appear here at all because it is not a feature of the hardware (unless
the switch ports are broken and their Secondary/Subordinate Bus
Numbers are hard-wired).

The Primary/Secondary/Subordinate Bus Numbers of all switch ports
should be writable and the PCI core knows how to manage them.

Bjorn

