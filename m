Return-Path: <linux-pci+bounces-5535-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EA082895345
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 14:38:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E4981F25CBD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 12:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C50C07764E;
	Tue,  2 Apr 2024 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F5MXzVIh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CEA83CD3;
	Tue,  2 Apr 2024 12:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061429; cv=none; b=MZejC3lwr2b2aIiC2UA7xojO/EQ01lQ89IRed7JBTsfGFCkzhfRTb2AjqOHEty0Vt7xenYAhPor56cRaPbG/HiYh++wZI9QbqZDviMu7o0P//1nYQqG+sx14OW1fExIRbm8ljnLp0JqW4q8vcbO51R7HjZR9wWjdTu5Oj7yui4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061429; c=relaxed/simple;
	bh=Pk2HgzXAGCfJO2L7X/paOS4JEgzpUMyFsy/4qgAscqY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MMF9p4VCTd7qF35gkLQhvv4H92MczGninoberdz8NUoPJlTkkIWTw+IhUY01w7mtF5/eMcCREPWKysS+5Q96GMvbdMhx8CySNmWWLaURVAxPtqYL65RVkOYyMhfM71fHrYrfXCamjdZq0Dxu3Kp3TT/z21j0qguWl7uJPJmHm4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F5MXzVIh; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcbf82cdf05so4265253276.2;
        Tue, 02 Apr 2024 05:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712061427; x=1712666227; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+hVDtgf/tX6CB1x3wViNXfCr99QZLJMtRkH2+/L34AU=;
        b=F5MXzVIhApZ7QC+EvBmq4NfJ/Bf91v5ElS8FkW19jKStRlMQyFzgA9DY9WnoozkuPK
         Woc/HuqKehMDlKW1GVHvoYTjRj78g4ia/tiKQWvLMo5zk11Qn4JafZmnWL5xw/6aYL3j
         YaI1fs8mH/5zJIdJPbLMgEmEmJWDK7+6lWGZSwSgOFXnVu0xJJI2XPIMkmMpf/KCY2Gf
         gltpZ/tkvxbiiuNSW9p8Se7OOYBHpL57rse5134HXfDTRmr9RUYXgTifvSnktrhYVJhX
         XGf9gHx6kjCv4L97CeRgN07L/MHJsNMKtCJQYcE1Ds7HKv1j0FxLrsefh4l79dVg+Dhf
         n/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712061427; x=1712666227;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+hVDtgf/tX6CB1x3wViNXfCr99QZLJMtRkH2+/L34AU=;
        b=Ge0ItIi8Vg8J9AhVSsiWnguGzANF/oKlbq1ESbobPUNaUPVdTbfAAPEOGnsfJvtWwC
         81yKDe79jGPpCXROriNGOWa/gpy7ryYc3nEeDtduMZbnDcKUWYdQp0fYavlxGwTnyLBr
         4xgfhxaiIRE4NFm/RNtl+L/tYnxuo6X6ZevdbtKub+9CE6WZwnonD7uGE5FOlaptHab5
         qYvr40MFn3CI0gnYxzPVnjveih/6Km3QPLIkhfWH3HaEhiOj11+asg+H4JNRL0R+IaRK
         YIj6mHZBnWFvq9uXOio+9m/pOLi0SivRq20RO7p9HbKCBvB1WettXy8N8BrH/+4Rm4ZN
         tMtw==
X-Forwarded-Encrypted: i=1; AJvYcCUWoFoOrTESPKP+huOqkzuYZQmjbkPrNZ5uEY6IacRFky6U5xCgVNnd6FzHOB0ikrOKkANeaxtX60nncTDYSlo6Ln+tzIEDQeljze9H25gHr8QG9cwLAiDufk1EtSKiLeUhXjRKpg==
X-Gm-Message-State: AOJu0YzbjvaZ+gPRgrNIsT3qJ0n0IrrVLhFAEoQmvgnCdBijuJrgaCLx
	Qcrcm6TVvTQNly+e1D3YB9416VIgTR2rufjJVLfDR/BW1siMIJKXGP+s2qEUQaT6+XmIa4evI9h
	V+e7tAqhaJpPoxgpbbrWCzFbKD3c=
X-Google-Smtp-Source: AGHT+IEsX2IyHA+ZUdqmgdyBhyN/n3wzZWG/aPw2nClgFtPv8DabvDpNMD5pRH43XmPMEAGZEKh8bpUFWc8XHCF9O54=
X-Received: by 2002:a25:19c3:0:b0:dc6:b8f5:50ae with SMTP id
 186-20020a2519c3000000b00dc6b8f550aemr10180179ybz.32.1712061426800; Tue, 02
 Apr 2024 05:37:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240330041928.1555578-1-dlemoal@kernel.org>
In-Reply-To: <20240330041928.1555578-1-dlemoal@kernel.org>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Tue, 2 Apr 2024 14:36:28 +0200
Message-ID: <CAAEEuhr6szh76u+OhxYnsa6-55_zhOyfGYL3YwjHvYKoGuXNmg@mail.gmail.com>
Subject: Re: [PATCH v2 00/18] Improve PCI memory mapping API
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	Wilfred Mallawa <wilfred.mallawa@wdc.com>, Niklas Cassel <cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 5:19=E2=80=AFAM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> This series introduces the new functions pci_epc_map_align(),
> pci_epc_mem_map() and pci_epc_mem_unmap() to improve handling of the
> PCI address mapping alignment constraints of endpoint controllers in a
> controller independent manner.
>
> The issue fixed is that the fixed alignment defined by the "align" field
> of struct pci_epc_features assumes that the alignment of the endpoint
> memory used to map a RC PCI address range is independent of the PCI
> address being mapped. But that is not the case for the rk3399 SoC
> controller: in endpoint mode, this controller uses the lower bits of the
> local endpoint memory address as the lower bits for the PCI addresses
> for data transfers. That is, when mapping local memory, one must take
> into account the number of bits of the RC PCI address that change from
> the start address of the mapping.
>
> To fix this, the new endpoint controller method .map_align is introduced
> and called from pci_epc_map_align(). This method is optional and for
> controllers that do not define it, the mapping information returned
> is based of the fixed alignment constraint as defined by the align
> feature.
>
> The functions pci_epc_mem_map() is a helper function which obtains
> mapping information, allocates endpoint controller memory according to
> the mapping size obtained and maps the memory. pci_epc_mem_map() unmaps
> and frees the endpoint memory.

This way of mapping is not only useful for the RK3399 but would also
help for the addition of other future PCI endpoint controller drivers.

For example, on several FPGA PCI endpoint IPs the window mapping is
also done by passing N bits from the mapped address and M bits from
the window mapping address (where N+M=3Dbus width, e.g., 32 or 64).
Using AND/OR masks/operations to combine the bits for the hardware
address from the mapped address and map base uses less resources than
using add/subtract to get the hardware address from an unaligned map
base and offset. So I guess that more than a few IPs, being hard or
soft IPs, use this kind of mapping (to reduce size, logic, improve max
operating frequency, improve efficiency etc.)

Two major examples come to mind :
1) The AMD/Xilinx PCIe endpoint IP. The mapping is documentented in
"AXI Bridge for PCI Express Gen3 Subsystem Product Guide (PG194)" [1]
section BAR and Address Translation (Figure AXI to PCIe Address
Translation).
2) The Intel/Altera PCIe endpoint IP. The mapping is documented in
"Multi Channel DMA Intel=C2=AE FPGA IP for PCI Express* User Guide" [2]
section 3.6. Root Port Address Translation Table Enablement.

Both those IPs don't have mainline support yet as PCIe endpoint
controllers but also use a similar kind of mapping as suggested here
for the RK3399. So these changes would also make the addition of these
controller drivers easier.

The new mapping scheme also makes it much clearer in the PCI endpoint
framework. Because without it some mapping operation would fail
because of alignment requirements in the controller, this requires
extra code and checks in the drivers that implement the endpoint
functions. With the current state of the PCI endpoint controller
framework there is no good way to express that the controller does an
AND/OR mask combination to create the hardware address and therefore
requires the map to be aligned to the window size, rather than doing a
window base addition with an offset (subtraction) in the mapping. This
could benefit from further clarification in the endpoint framework.

Best regards,
Rick

[1] https://docs.amd.com/r/en-US/pg194-axi-bridge-pcie-gen3/Address-Transla=
tion
[2] https://www.intel.com/content/www/us/en/docs/programmable/683821/23-4/

>
> This series is organized as follows:
>  - Patch 1 tidy up the epc core code
>  - Patch 2 and 3 introduce the new map_align endpoint controller method
>    and related epc functions.
>  - Patch 4 to 6 modify the test endpoint driver to use these new
>    functions and improve the code of this driver.
>  - Finally, Patch 7 to 18 fix the rk3399 endpoint driver, defining a
>    .map_align method for it and improving its overall code readability
>    and features.
>
> Changes from v1:
>  - Changed pci_epc_check_func() to pci_epc_function_is_valid() in patch
>    1.
>  - Removed patch "PCI: endpoint: Improve pci_epc_mem_alloc_addr()"
>    (former patch 2 of v1)
>  - Various typos cleanups all over. Also fixed some blank space
>    indentation.
>  - Added review tags
>
> Damien Le Moal (17):
>   PCI: endpoint: Introduce pci_epc_function_is_valid()
>   PCI: endpoint: Introduce pci_epc_map_align()
>   PCI: endpoint: Introduce pci_epc_mem_map()/unmap()
>   PCI: endpoint: test: Use pci_epc_mem_map/unmap()
>   PCI: endpoint: test: Synchronously cancel command handler work
>   PCI: endpoint: test: Implement link_down event operation
>   PCI: rockchip-ep: Fix address translation unit programming
>   PCI: rockchip-ep: Use a macro to define EP controller .align feature
>   PCI: rockchip-ep: Improve rockchip_pcie_ep_unmap_addr()
>   PCI: rockchip-ep: Improve rockchip_pcie_ep_map_addr()
>   PCI: rockchip-ep: Implement the map_align endpoint controller operation
>   PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() memory allocations
>   PCI: rockchip-ep: Refactor rockchip_pcie_ep_probe() MSI-X hiding
>   PCI: rockchip-ep: Refactor endpoint link training enable
>   PCI: rockship-ep: Introduce rockchip_pcie_ep_stop()
>   PCI: rockchip-ep: Improve link training
>   PCI: rockchip-ep: Handle PERST# signal in endpoint mode
>
> Wilfred Mallawa (1):
>   dt-bindings: pci: rockchip,rk3399-pcie-ep: Add ep-gpios property
>
>  .../bindings/pci/rockchip,rk3399-pcie-ep.yaml |   3 +
>  drivers/pci/controller/pcie-rockchip-ep.c     | 393 ++++++++++++++----
>  drivers/pci/controller/pcie-rockchip.c        |  17 +-
>  drivers/pci/controller/pcie-rockchip.h        |  22 +
>  drivers/pci/endpoint/functions/pci-epf-test.c | 390 +++++++++--------
>  drivers/pci/endpoint/pci-epc-core.c           | 213 +++++++---
>  include/linux/pci-epc.h                       |  39 ++
>  7 files changed, 768 insertions(+), 309 deletions(-)
>
> --
> 2.44.0
>

