Return-Path: <linux-pci+bounces-29022-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CD4ACEDD1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 12:38:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 718C9188B537
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 10:38:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CBBE217F24;
	Thu,  5 Jun 2025 10:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="guBQAQiw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 490BB217664
	for <linux-pci@vger.kernel.org>; Thu,  5 Jun 2025 10:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749119853; cv=none; b=rdOR+sRPn0v7z5RWvvfsRj6vc7IMgPI1qWoUrjuk0lUINOTK3eZsfRGdV0aIhnZvdQ/MKGZ3GcodLiP61Ldbe5REJyfAsoevlyI4GLICa+3XTI8OZtUeLcVbsb7nwyL2EiHH/XLX2iVhvbf85iMt1qgub+yimJ7qwCXdmD1osXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749119853; c=relaxed/simple;
	bh=5W99aD1HPPU70uFrXi4wd3DyADurA3SSuHBr+b7XjMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c/L73Nv/W48ShBArT4y7o/e0VfkNwYC1Si0GclPygsKGz9suGxQDq8N+ahOi5isei7eGLqWJWBuLpsxqodl6G5JS5FhK/WrmwOQWZ5hlAqGygKhRk/cFncnpqcBZxUGmZV0jdAn0Rdl9IQXyUuw45dJFhgv8gBurlLox1Nx5caA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=guBQAQiw; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ad8826c05f2so154965966b.3
        for <linux-pci@vger.kernel.org>; Thu, 05 Jun 2025 03:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1749119848; x=1749724648; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eXn3QIeAiS3fNUutBHTej2gUQDr8syUYYLvUu5jnOQ0=;
        b=guBQAQiwmdYT4eEHKn+dQvdO04rkq7BfuOwAFr4J+G8COQ31SjnXVO9JKX8AoimP7S
         fxDIJaEsFTO7XdTxhOORhW+XcjI1L+4/V2V/TaC6GuxTnHy+kN7Pd11choC/Jho9hfwt
         TX8xsauoJMRmSZXxXXP+iNWQlmJVLT+NDaEV0tH+GjKDSPussK93sWUCSQWiNbeIFO+2
         EXAi+X7CpnzRAjXvN4OldzCOclARYDEt1xWGGXTfl7FUVmE6eD47oh8DrYr1cm02XyqC
         z9hQ0mW9QOx2LEpYoneOLKegacvJsaZ+6gWuFTbjiYwzoPCGcwe/Uh0AfI7H/QDj0ZOP
         Je4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749119848; x=1749724648;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eXn3QIeAiS3fNUutBHTej2gUQDr8syUYYLvUu5jnOQ0=;
        b=PAO+ZA9TaYWMLwC70IbGQiyAuMwFJ6gVUGTVAJl+uBKCuAIGAPz3MTJIepXiuCl8ky
         20oHfARTGSvgC3+FGtR0gMCu9MjdZ5BxQQV41gECVDUGJmGmKEmbJaVXF2g1V4rdRb6y
         xBOURZxDeAzKPHvfI7gFfpO1SMrjiultm1KBwOR1f3i1L26sgb4wKexo1/hZ7CwkX1zE
         c/vXl7cWEHpIC5zO8vbGc8NzWd1ZSw9uhkwRjTmekg5ibtLYXVFXaKPHkupGiotzvZnQ
         yzmqR9YnPlG7jhtU9W8o0JniN2vLNg2NmP6dqb2SxLUMvXtB5nOLhUCIeocmGCwiOzGP
         hTZg==
X-Forwarded-Encrypted: i=1; AJvYcCUXZYnqFBOvGwCh0RNGnOXotVTNdxPmhDaWJavMWMzNDRpu29WKXpUhLp/r3XB5wjbvtsRTEb4x13M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTKZjWGmUCG4iR/VZdyApdzVjMUZ7I2bNeOUmwZwk8w+0JVdBq
	Iwyc5ZGM1E3ExedShW0dIQG6JG7tPxG7O/n2sW7zCsfHe/W68P9nRQNc3yQtqiHOyLc=
X-Gm-Gg: ASbGncuux0LIcq88c3tPy4IzUfGn74VzlFlAaPSY/un40mTHzEdbYkztjUQHo5OGN7s
	pvu0ccGeJ+RzCLndEleIyTHIpyYJdNst+4U7jJnlWk29yd2OUSNLbCCnPr2tsuP+IIKsIN51nlw
	svomYjJj4k5jncebyE5yY9yINFIvFzg/dF/0H15GTHoXTJt4aWrP4LifEo/f+9YbV3/JSZCeWCk
	JgGtl2oQ5Th/f6mdcf9jqW+XhPC4m5KtQD+1Sbxy0dO0lb9p9X7kb7kcdVKeo8mqyfsOoj6+g6+
	DWy7RJs93llMdb51E3S9lsbjNj5SkQ1IG+8+KTXoite44Sj9TZtj8MpIoIGA
X-Google-Smtp-Source: AGHT+IG4imuIKem/lacSZ6kswTIN1P3NtX5m21Xzl748xyEppt8Z7hqNmdhVquPXd1dCij8MnG6lzA==
X-Received: by 2002:a17:907:980f:b0:ad4:f517:ca3 with SMTP id a640c23a62f3a-addf8d27228mr582111566b.20.1749119848014;
        Thu, 05 Jun 2025 03:37:28 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d82e760sm1253095066b.52.2025.06.05.03.37.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Jun 2025 03:37:27 -0700 (PDT)
Message-ID: <7b8ae87e-f733-45f9-bf45-302d755ebbf6@tuxon.dev>
Date: Thu, 5 Jun 2025 13:37:25 +0300
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/8] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, geert+renesas@glider.be, magnus.damm@gmail.com,
 mturquette@baylibre.com, sboyd@kernel.org, p.zabel@pengutronix.de,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
 john.madieu.xa@bp.renesas.com,
 Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
References: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>
 <20250530111917.1495023-5-claudiu.beznea.uj@bp.renesas.com>
 <a58abc2a-6583-d4be-aea2-b2178b2acf60@linux.intel.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <a58abc2a-6583-d4be-aea2-b2178b2acf60@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Ilpo,

On 02.06.2025 19:18, Ilpo Järvinen wrote:
> On Fri, 30 May 2025, Claudiu wrote:
> 
>> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>>
>> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
>> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
>> only as a root complex, with a single-lane (x1) configuration. The
>> controller includes Type 1 configuration registers, as well as IP
>> specific registers (called AXI registers) required for various adjustments.
>>
>> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> ---
>>
>> Changes in v2:
>> - dropped the references to other RZ SoCs from patch description
>> - dropped the dot at the end of single line comments that are not a
>>   sentence
>> - as a result of v2 rework removed unused macros and definitions
>>   (e.g. RZG3S_PCI_REQISS_TR_TP1_RD, RZG3S_PCI_REQISS_TR_TP1_WR,
>>   enum rzg3s_pcie_cfg_access_type)
>> - dropped driver specific defines that are for generic PCI
>>   register offsets and used the generic ones
>> - updated the value of RZG3S_PCI_MSI_INT_NR as on RZ/G3S there
>>   are no more than 32 MSIs (v1 value was due to mistake in the
>>   HW manual)
>> - added timeout macros to be used by read_poll_timeout() specific
>>   functions
>> - re-worked the reset handling part by using reset subsystem specific
>>   functions only; with this the struct rzg3s_pcie_soc_data was
>>   added; reference to PHY initialization function was added to this
>>   structure as well
>> - dropped devres_group_id as the issue it tried to address will
>>   now be fixed in platform bus code (v2 posted [2])
>> - use 80 columns alignment
>> - updated function name in the idea of using names similar to
>>   what is used in other drivers
>> - added rzg3s_pcie_root_ops and rzg3s_pcie_child_ops and populate
>>   bridge->ops, bridge->child_ops with it; from probe:
>> +	bridge->ops = &rzg3s_pcie_root_ops;
>> +	bridge->child_ops = &rzg3s_pcie_child_ops;
>> - print a warning for 32 bit accesses (based on the value of
>>   bus->unsafe_warn as done in the common code)
>> - dropped dev_dbg() in read/write functions
>> - added HW manual revision identifier in comments that points to the
>>   statements from manual
>> - reworked the rzg3s_pcie_intx_setup() as the legacy interrupt DT
>>   node is not used anymore
>> - in rzg3s_pcie_config_init() do not hardcode anymore the
>>   primary bus, secondary bus, subordinate bus but get this information
>>   from device tree and update HW registers accordingly
>> - dropped rzg3s_pcie_remove() and added rzg3s_pcie_host_remove_action()
>>   to be used as a devm action or reset function
>> - s/rzg3s_pcie_suspend/rzg3s_pcie_suspend_noirq,
>>   s/rzg3s_pcie_resume/rzg3s_pcie_resume_noirq
>> - dropped DEFINE_NOIRQ_DEV_PM_OPS()
>> - updated driver name (rzg3s-pcie-host) to reflect it is for RZ/G3S 
>>
>> [2] https://lore.kernel.org/all/20250526122054.65532-2-claudiu.beznea.uj@bp.renesas.com
>>
>>  MAINTAINERS                              |    8 +
>>  drivers/pci/controller/Kconfig           |    7 +
>>  drivers/pci/controller/Makefile          |    1 +
>>  drivers/pci/controller/pcie-rzg3s-host.c | 1686 ++++++++++++++++++++++
>>  4 files changed, 1702 insertions(+)
>>  create mode 100644 drivers/pci/controller/pcie-rzg3s-host.c
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 0d59a5910e63..3076065955f0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -19286,6 +19286,14 @@ S:	Maintained
>>  F:	drivers/pci/controller/dwc/pcie-qcom-common.c
>>  F:	drivers/pci/controller/dwc/pcie-qcom.c
>>  
>> +PCIE DRIVER FOR RENESAS RZ/G3S SERIES
>> +M:	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
>> +L:	linux-pci@vger.kernel.org
>> +L:	linux-renesas-soc@vger.kernel.org
>> +S:	Supported
>> +F:	Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
>> +F:	drivers/pci/controller/pcie-rzg3s-host.c
>> +
>>  PCIE DRIVER FOR ROCKCHIP
>>  M:	Shawn Lin <shawn.lin@rock-chips.com>
>>  L:	linux-pci@vger.kernel.org
>> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
>> index 886f6f43a895..76fa5f330105 100644
>> --- a/drivers/pci/controller/Kconfig
>> +++ b/drivers/pci/controller/Kconfig
>> @@ -258,6 +258,13 @@ config PCI_RCAR_GEN2
>>  	  There are 3 internal PCI controllers available with a single
>>  	  built-in EHCI/OHCI host controller present on each one.
>>  
>> +config PCIE_RENESAS_RZG3S_HOST
>> +	tristate "Renesas RZ/G3S PCIe host controller"
>> +	depends on ARCH_RENESAS || COMPILE_TEST
>> +	select MFD_SYSCON
>> +	help
>> +	  Say Y here if you want PCIe host controller support on Renesas RZ/G3S SoC.
>> +
>>  config PCIE_ROCKCHIP
>>  	bool
>>  	depends on PCI
>> diff --git a/drivers/pci/controller/Makefile b/drivers/pci/controller/Makefile
>> index 038ccbd9e3ba..229929a945c2 100644
>> --- a/drivers/pci/controller/Makefile
>> +++ b/drivers/pci/controller/Makefile
>> @@ -10,6 +10,7 @@ obj-$(CONFIG_PCI_TEGRA) += pci-tegra.o
>>  obj-$(CONFIG_PCI_RCAR_GEN2) += pci-rcar-gen2.o
>>  obj-$(CONFIG_PCIE_RCAR_HOST) += pcie-rcar.o pcie-rcar-host.o
>>  obj-$(CONFIG_PCIE_RCAR_EP) += pcie-rcar.o pcie-rcar-ep.o
>> +obj-$(CONFIG_PCIE_RENESAS_RZG3S_HOST) += pcie-rzg3s-host.o
>>  obj-$(CONFIG_PCI_HOST_COMMON) += pci-host-common.o
>>  obj-$(CONFIG_PCI_HOST_GENERIC) += pci-host-generic.o
>>  obj-$(CONFIG_PCI_HOST_THUNDER_ECAM) += pci-thunder-ecam.o
>> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
>> new file mode 100644
>> index 000000000000..7649674bf72d
>> --- /dev/null
>> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
>> @@ -0,0 +1,1686 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * PCIe driver for Renesas RZ/G3S SoCs
>> + *
>> + * Copyright (C) 2025 Renesas Electronics Corp.
>> + *
>> + * Based on:
>> + *  drivers/pci/controller/pcie-rcar-host.c
>> + *  Copyright (C) 2009 - 2011  Paul Mundt
>> + */
>> +
>> +#include <linux/bitmap.h>
>> +#include <linux/bitops.h>
>> +#include <linux/cleanup.h>
>> +#include <linux/delay.h>
>> +#include <linux/iopoll.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/irq.h>
>> +#include <linux/irqchip/chained_irq.h>
>> +#include <linux/irqdomain.h>
>> +#include <linux/kernel.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/msi.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/pci.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regmap.h>
> 
> Do you need to select something REGMAP related in Kconfig?

I haven't selected it explicitly as Kconfig selects MFD_SYSCON which
selects REGMAP_MMIO which selects REGMAP.

> 
>> +#include <linux/reset.h>
>> +#include <linux/slab.h>
>> +
>> +/* AXI registers */
>> +#define RZG3S_PCI_REQDATA(id)			(0x80 + (id) * 0x4)
>> +#define RZG3S_PCI_REQRCVDAT			0x8c
>> +#define RZG3S_PCI_REQADR1			0x90
>> +#define RZG3S_PCI_REQADR1_BUS			GENMASK(31, 24)
>> +#define RZG3S_PCI_REQADR1_DEV			GENMASK(23, 19)
>> +#define RZG3S_PCI_REQADR1_FUNC			GENMASK(18, 16)
>> +#define RZG3S_PCI_REQADR1_REG			GENMASK(11, 0)
> 
> Consider adding new lines into this long list of defines. E.g., when there 
> are reg + it's fields which naturally form a group that could have empty 
> lines around it.

Ok, I'll consider it but it will lead to some inconsistencies accross
different defines in this list as there will be new lines after some
defines only. If I understood correctly your proposal, the result will be
something like this:

+#define RZG3S_PCI_REQISS			0x9c
+#define RZG3S_PCI_REQISS_REQ_ISSUE		BIT(0)
+#define RZG3S_PCI_REQISS_TR_TYPE		GENMASK(11, 8)
+#define RZG3S_PCI_REQISS_TR_TP0_RD		FIELD_PREP(RZG3S_PCI_REQISS_TR_TYPE, 0x4)
+#define RZG3S_PCI_REQISS_TR_TP0_WR		FIELD_PREP(RZG3S_PCI_REQISS_TR_TYPE, 0x5)
+#define RZG3S_PCI_REQISS_MOR_STATUS		GENMASK(18, 16)

+#define RZG3S_PCI_MSIRCVWADRL			0x100
+#define RZG3S_PCI_MSIRCVWADRL_ENA		BIT(0)
+#define RZG3S_PCI_MSIRCVWADRL_MSG_DATA_ENA	BIT(1)

+#define RZG3S_PCI_MSIRCVWADRU			0x104
+#define RZG3S_PCI_MSIRCVWMSKL			0x108
+#define RZG3S_PCI_MSIRCVWMSKU			0x10c
+#define RZG3S_PCI_PINTRCVIE			0x110
+#define RZG3S_PCI_PINTRCVIE_INTX(i)		BIT(i)
+#define RZG3S_PCI_PINTRCVIE_MSI			BIT(4)

+#define RZG3S_PCI_PINTRCVIS			0x114
+#define RZG3S_PCI_PINTRCVIS_INTX(i)		BIT(i)


> 
>> +#define RZG3S_PCI_REQBE				0x98
>> +#define RZG3S_PCI_REQBE_BYTE_EN			GENMASK(3, 0)
>> +#define RZG3S_PCI_REQISS			0x9c
>> +#define RZG3S_PCI_REQISS_REQ_ISSUE		BIT(0)
>> +#define RZG3S_PCI_REQISS_TR_TYPE		GENMASK(11, 8)
>> +#define RZG3S_PCI_REQISS_TR_TP0_RD		FIELD_PREP(RZG3S_PCI_REQISS_TR_TYPE, 0x4)
>> +#define RZG3S_PCI_REQISS_TR_TP0_WR		FIELD_PREP(RZG3S_PCI_REQISS_TR_TYPE, 0x5)
>> +#define RZG3S_PCI_REQISS_MOR_STATUS		GENMASK(18, 16)
>> +#define RZG3S_PCI_MSIRCVWADRL			0x100
>> +#define RZG3S_PCI_MSIRCVWADRL_ENA		BIT(0)
>> +#define RZG3S_PCI_MSIRCVWADRL_MSG_DATA_ENA	BIT(1)
>> +#define RZG3S_PCI_MSIRCVWADRU			0x104
>> +#define RZG3S_PCI_MSIRCVWMSKL			0x108
>> +#define RZG3S_PCI_MSIRCVWMSKU			0x10c
>> +#define RZG3S_PCI_PINTRCVIE			0x110
>> +#define RZG3S_PCI_PINTRCVIE_INTX(i)		BIT(i)
>> +#define RZG3S_PCI_PINTRCVIE_MSI			BIT(4)
>> +#define RZG3S_PCI_PINTRCVIS			0x114
>> +#define RZG3S_PCI_PINTRCVIS_INTX(i)		BIT(i)
>> +#define RZG3S_PCI_PINTRCVIS_MSI			BIT(4)
>> +#define RZG3S_PCI_MSGRCVIE			0x120
>> +#define RZG3S_PCI_MSGRCVIE_MSG_RCV		BIT(24)
>> +#define RZG3S_PCI_MSGRCVIS			0x124
>> +#define RZG3S_PCI_MSGRCVIS_MRI			BIT(24)
>> +#define RZG3S_PCI_PEIE0				0x200
>> +#define RZG3S_PCI_PEIS0				0x204
>> +#define RZG3S_PCI_PEIS0_DL_UPDOWN		BIT(9)
>> +#define RZG3S_PCI_PEIS0_RX_DLLP_PM_ENTER	BIT(12)
>> +#define RZG3S_PCI_PEIE1				0x208
>> +#define RZG3S_PCI_PEIS1				0x20c
>> +#define RZG3S_PCI_AMEIE				0x210
>> +#define RZG3S_PCI_AMEIS				0x214
>> +#define RZG3S_PCI_ASEIE1			0x220
>> +#define RZG3S_PCI_ASEIS1			0x224
>> +#define RZG3S_PCI_PCSTAT1			0x408
>> +#define RZG3S_PCI_PCSTAT1_DL_DOWN_STS		BIT(0)
>> +#define RZG3S_PCI_PCSTAT1_LTSSM_STATE		GENMASK(14, 10)
>> +#define RZG3S_PCI_PCCTRL2			0x410
>> +#define RZG3S_PCI_PCCTRL2_LS_CHG_REQ		BIT(0)
>> +#define RZG3S_PCI_PCCTRL2_LS_CHG		GENMASK(9, 8)
>> +#define RZG3S_PCI_PCSTAT2			0x414
>> +#define RZG3S_PCI_PCSTAT2_STATE_RX_DETECT	GENMASK(15, 8)
>> +#define RZG3S_PCI_PCSTAT2_SDRIRE		GENMASK(7, 0)
>> +#define RZG3S_PCI_PCSTAT2_LS_CHG_DONE		BIT(28)
>> +#define RZG3S_PCI_PERM				0x300
>> +#define RZG3S_PCI_PERM_PIPE_PHY_REG_EN		BIT(1)
>> +#define RZG3S_PCI_PERM_CFG_HWINIT_EN		BIT(2)
>> +#define RZG3S_PCI_MSIRE(id)			(0x600 + (id) * 0x10)
>> +#define RZG3S_PCI_MSIRE_ENA			BIT(0)
>> +#define RZG3S_PCI_MSIRM(id)			(0x608 + (id) * 0x10)
>> +#define RZG3S_PCI_MSIRS(id)			(0x60c + (id) * 0x10)
>> +#define RZG3S_PCI_AWBASEL(id)			(0x1000 + (id) * 0x20)
>> +#define RZG3S_PCI_AWBASEL_WIN_ENA		BIT(0)
>> +#define RZG3S_PCI_AWBASEU(id)			(0x1004 + (id) * 0x20)
>> +#define RZG3S_PCI_AWMASKL(id)			(0x1008 + (id) * 0x20)
>> +#define RZG3S_PCI_AWMASKU(id)			(0x100c + (id) * 0x20)
>> +#define RZG3S_PCI_ADESTL(id)			(0x1010 + (id) * 0x20)
>> +#define RZG3S_PCI_ADESTU(id)			(0x1014 + (id) * 0x20)
>> +#define RZG3S_PCI_PWBASEL(id)			(0x1100 + (id) * 0x20)
>> +#define RZG3S_PCI_PWBASEL_ENA			BIT(0)
>> +#define RZG3S_PCI_PWBASEU(id)			(0x1104 + (id) * 0x20)
>> +#define RZG3S_PCI_PDESTL(id)			(0x1110 + (id) * 0x20)
>> +#define RZG3S_PCI_PDESTU(id)			(0x1114 + (id) * 0x20)
>> +#define RZG3S_PCI_PWMASKL(id)			(0x1108 + (id) * 0x20)
>> +#define RZG3S_PCI_PWMASKU(id)			(0x110c + (id) * 0x20)
>>
>> +/* PHY control registers */
>> +#define RZG3S_PCI_PHY_XCFGD(id)			(0x2000 + (id) * 0x10)
>> +#define RZG3S_PCI_PHY_XCFGD_NUM			39
>> +#define RZG3S_PCI_PHY_XCFGA_CMN(id)		(0x2400 + (id) * 0x10)
>> +#define RZG3S_PCI_PHY_XCFGA_CMN_NUM		16
>> +#define RZG3S_PCI_PHY_XCFGA_RX(id)		(0x2500 + (id) * 0x10)
>> +#define RZG3S_PCI_PHY_XCFGA_RX_NUM		13
>> +#define RZG3S_PCI_PHY_XCFGA_TX			0x25d0
>> +#define RZG3S_PCI_PHY_XCFG_CTRL			0x2a20
>> +#define RZG3S_PCI_PHY_XCFG_CTRL_PHYREG_SEL	BIT(0)
>> +
>> +/* PCIe registers */
>> +#define RZG3S_PCI_CFG_BASE			0x6000
>> +#define RZG3S_PCI_CFG_BARMSK00L			0xa0
>> +#define RZG3S_PCI_CFG_BARMSK00U			0xa4
>> +#define RZG3S_PCI_CFG_LINKCS			0x70
>> +#define RZG3S_PCI_CFG_LINKCS_CUR_LS		GENMASK(19, 16)
>> +#define RZG3S_PCI_CFG_LINCS2			0x90
>> +#define RZG3S_PCI_CFG_LINCS2_TARGET_LS		GENMASK(3, 0)
> 
> Are these duplicating offsets / fields in the PCI Express Capability?
> If yes, you should use include/uapi/linux/pci_regs.h defines and not add 
> duplicates.

OK, I'll double check include/uapi/linux/pci_regs.h again.

> 
>> +
>> +/* System controller registers */
>> +#define RZG3S_SYS_PCIE_RST_RSM_B		0xd74
>> +#define RZG3S_SYS_PCIE_RST_RSM_B_MASK		BIT(0)
>> +
>> +/* Maximum number of windows */
>> +#define RZG3S_MAX_WINDOWS			8
>> +
>> +/* Number of MSI interrupts per register */
>> +#define RZG3S_PCI_MSI_INT_PER_REG		32
>> +/* The number of MSI interrupts */
>> +#define RZG3S_PCI_MSI_INT_NR			RZG3S_PCI_MSI_INT_PER_REG
>> +
>> +/* Timeouts */
>> +#define RZG3S_REQ_ISSUE_TIMEOUT_US		2500
>> +#define RZG3S_LTSSM_STATE_TIMEOUT_US		1000
>> +#define RZG3S_LS_CHANGE_TIMEOUT_US		1000
>> +#define RZG3S_LINK_UP_TIMEOUT_US		500000
>> +
>> +/**
>> + * enum rzg3s_pcie_link_speed - RZ/G3S PCIe available link speeds
>> + * @RZG3S_PCIE_LINK_SPEED_2_5_GTS: 2.5 GT/s
>> + * @RZG3S_PCIE_LINK_SPEED_5_0_GTS: 5.0 GT/s
>> + */
>> +enum rzg3s_pcie_link_speed {
>> +	RZG3S_PCIE_LINK_SPEED_2_5_GTS = 1,
>> +	RZG3S_PCIE_LINK_SPEED_5_0_GTS
>> +};
> 
> Use include/uapi/linux/pci_regs.h defines instead?

Will do it.

[ ... ]

>> +static int rzg3s_pcie_msi_enable(struct rzg3s_pcie_host *host)
>> +{
>> +	struct platform_device *pdev = to_platform_device(host->dev);
>> +	struct rzg3s_pcie_msi *msi = &host->msi;
>> +	struct device *dev = host->dev;
>> +	const char *devname;
>> +	int irq, ret;
>> +
>> +	mutex_init(&msi->map_lock);
> 
> Use devm_mutex_init() + remember error handling.

OK.

> 
>> +
>> +	irq = platform_get_irq_byname(pdev, "msi");
>> +	if (irq < 0)
>> +		return dev_err_probe(dev, irq ? irq : -EINVAL,
>> +				     "Failed to get MSI IRQ!\n");
>> +
>> +	devname = devm_kasprintf(dev, GFP_KERNEL, "%s-msi", dev_name(dev));
>> +	if (!devname)
>> +		return -ENOMEM;
>> +
>> +	ret = rzg3s_pcie_msi_allocate_domains(msi);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = devm_request_irq(dev, irq, rzg3s_pcie_msi_irq, 0, devname, host);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "Failed to request IRQ: %d\n", ret);
>> +		goto free_domains;
>> +	}
>> +
>> +	ret = rzg3s_pcie_msi_setup(host);
>> +	if (ret) {
>> +		dev_err_probe(dev, ret, "Failed to setup MSI!\n");
>> +		goto free_domains;
>> +	}
>> +
>> +	return 0;
>> +
>> +free_domains:
>> +	rzg3s_pcie_msi_free_domains(msi);
> 
> I'm a bit worried about tear down order here as you seem to be mixing 
> devm* and non-devm*. All devres based teardown will occur only after the 
> probe returns error.

I added it here to avoid adding a new devres helper for irq_domain_remove()
in case this failure happens. I can add a new devres helper for it, as well.

[ ...]

>> +static int rzg3s_pcie_resets_prepare(struct rzg3s_pcie_host *host)
>> +{
>> +	const struct rzg3s_pcie_soc_data *data = host->data;
>> +	int ret;
>> +
>> +	host->power_resets = devm_kmalloc_array(host->dev,
>> +						data->num_power_resets,
>> +						sizeof(*host->power_resets),
>> +						GFP_KERNEL);
>> +	if (!host->power_resets)
>> +		return -ENOMEM;
>> +
>> +	for (unsigned int i = 0; i < data->num_power_resets; i++)
>> +		host->power_resets[i].id = data->power_resets[i];
>> +
>> +	host->cfg_resets = devm_kmalloc_array(host->dev,
>> +					      data->num_cfg_resets,
>> +					      sizeof(*host->cfg_resets),
>> +					      GFP_KERNEL);
> 
> For these 2 allocs, devm_kcalloc() to init it to zero?

I considered it unnecessary to init it to zero as the the id member is
initialized below in this function and the rstc member is initialized through:

devm_reset_control_bulk_get_exclusive() ->
  __devm_reset_control_bulk_get() ->
    __reset_control_bulk_get()

[ ... ]

>> +static int rzg3s_pcie_set_inbound_windows(struct rzg3s_pcie_host *host,
>> +					  struct resource_entry *entry,
>> +					  int *index)
>> +{
>> +	u64 pci_addr = entry->res->start - entry->offset;
>> +	u64 cpu_addr = entry->res->start;
>> +	u64 cpu_end = entry->res->end;
>> +	u64 size_id = 0;
>> +	int id = *index;
>> +	u64 size;
>> +
>> +	while (cpu_addr < cpu_end) {
>> +		if (id >= RZG3S_MAX_WINDOWS)
>> +			return dev_err_probe(host->dev, -EINVAL,
>> +					     "Failed to set inbound windows!\n");
>> +
>> +		size = resource_size(entry->res) - size_id;
>> +
>> +		/*
>> +		 * According to the RZ/G3S HW manual (Rev.1.10,
>> +		 * section 34.3.1.71 AXI Window Mask (Lower) Registers) the min
>> +		 * size is 4K.
>> +		 */
>> +		size = max(size, 4096);
> 
> SZ_4K + remember to add the #include for it if not there yet.

OK

> 
>> +
>> +		/*
>> +		 * According the RZ/G3S HW manual (Rev.1.10, sections:
>> +		 * - 34.3.1.69 AXI Window Base (Lower) Registers
>> +		 * - 34.3.1.71 AXI Window Mask (Lower) Registers
>> +		 * - 34.3.1.73 AXI Destination (Lower) Registers)
>> +		 * the CPU addr, PCIe addr, size should be 4K alined and be a
> 
> aligned

OK

> 
>> +		 * power of 2.
>> +		 */
>> +		size = ALIGN(size, 4096);
> 
> SZ_4K

OK

> 
>> +
>> +		/*
>> +		 * According to the RZ/G3S HW manual (Rev.1.10, section
>> +		 * 34.3.1.71 AXI Window Mask (Lower) Registers) HW expects first
>> +		 * 12 LSB bits to be 0xfff. Extract 1 from size for this.
>> +		 */
>> +		size = roundup_pow_of_two(size) - 1;
>> +
>> +		cpu_addr = ALIGN(cpu_addr, 4096);
>> +		pci_addr = ALIGN(pci_addr, 4096);
> 
> Ditto.

OK

> 
>> +
>> +		rzg3s_pcie_set_inbound_window(host, cpu_addr, pci_addr, size,
>> +					      id);
>> +
>> +		pci_addr += size;
>> +		cpu_addr += size;
>> +		size_id = size;
>> +		id++;
>> +	}
>> +	*index = id;
>> +
>> +	return 0;
>> +}
>> +
>> +static int rzg3s_pcie_parse_map_dma_ranges(struct rzg3s_pcie_host *host)
>> +{
>> +	struct pci_host_bridge *bridge = pci_host_bridge_from_priv(host);
>> +	struct resource_entry *entry;
>> +	int i = 0, ret;
>> +
>> +	resource_list_for_each_entry(entry, &bridge->dma_ranges) {
>> +		ret = rzg3s_pcie_set_inbound_windows(host, entry, &i);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void rzg3s_pcie_set_outbound_window(struct rzg3s_pcie_host *host,
>> +					   struct resource_entry *win,
>> +					   int id)
>> +{
>> +	struct resource *res = win->res;
>> +	resource_size_t size = resource_size(res);
>> +	resource_size_t res_start;
>> +
>> +	if (res->flags & IORESOURCE_IO)
>> +		res_start = pci_pio_to_address(res->start) - win->offset;
>> +	else
>> +		res_start = res->start - win->offset;
>> +
>> +	/*
>> +	 * According to the RZ/G3S HW manual (Rev.1.10, section 34.3.1.75 PCIe
>> +	 * Window Base (Lower) Registers) the window base address need to be 4K
>> +	 * aligned.
>> +	 */
>> +	res_start = ALIGN(res_start, 4096);
>> +
>> +	size = ALIGN(size, 4096);
> 
> Ditto.

OK

[ ... ]

>> +
>> +static int rzg3s_pcie_resume_noirq(struct device *dev)
>> +{
>> +	struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
>> +	const struct rzg3s_pcie_soc_data *data = host->data;
>> +	struct regmap *sysc = host->sysc;
>> +	int ret;
>> +
>> +	ret = regmap_update_bits(sysc, RZG3S_SYS_PCIE_RST_RSM_B,
>> +				 RZG3S_SYS_PCIE_RST_RSM_B_MASK,
>> +				 FIELD_PREP(RZG3S_SYS_PCIE_RST_RSM_B_MASK, 1));
>> +	if (ret)
>> +		return ret;
>> +
>> +	/*
>> +	 * According to the RZ/G3S HW manual (Rev.1.10, section
>> +	 * 34.5.1.2 De-asserting the Reset) the PCIe IP needs to wait 5ms from
>> +	 * power on to the de-assertion of reset.
>> +	 */
>> +	usleep_range(5000, 5100);
> 
> Please make a define out of this since you're using it in multiple places.

OK

> 
>> +	ret = reset_control_bulk_deassert(data->num_power_resets,
>> +					  host->power_resets);
>> +	if (ret)
>> +		goto assert_rst_rsm_b;
> 
> Maybe add a helper for the wait + bulk_deassert().

OK.

Thank you for your review,
Claudiu

