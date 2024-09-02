Return-Path: <linux-pci+bounces-12618-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 216A796844C
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 12:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 659FC1F24023
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 10:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973EE13CFB7;
	Mon,  2 Sep 2024 10:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gdHPK/br"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FF9A13CA93
	for <linux-pci@vger.kernel.org>; Mon,  2 Sep 2024 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271937; cv=none; b=cR/Kt2xStu4zRWHOUjudBSo4d1/jgFwH7l/zbsXK8/+mQptVnTod9CVtqKqD4Lhw/0qINCMKQAScpcv+Cfm/EmtiMXN7Dpr58J359D8QlkP0N3r5jSkY5AYPddClL2S+07fpppVJydl/UUhNNtkmUy7KVdzWnXUk30DLnc4hSnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271937; c=relaxed/simple;
	bh=eB/sfA/SQRF1nWslqyLOMEKOsncdOv8QtlGdFMEqO2U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ebNfeIikOrV6jK4xRtY6RQZKYuZIBGQGSQ0emMeMM1VbTjFQkZZsWZ6tUbIXZl+YKd0t8sG7SOTFzK1pJ+gv9eOIRu+lDXWXd5BVv+UqtP5nG+IQDfSpWC0Ie6RxaOdPaTntunEqKJeV3nI1wZgjKFJbEqI9HvkjIMcApC/4J8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gdHPK/br; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e02c4983bfaso4283891276.2
        for <linux-pci@vger.kernel.org>; Mon, 02 Sep 2024 03:12:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725271932; x=1725876732; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=76afwhTrp6Z2fEHksQViSsyfdFxYC6YbMO+dGFDi4MU=;
        b=gdHPK/brADu6gCmm6uZ59cKpCwhSIBesfJQZpusNX9o4Bkyphms9YwdCzG3VFsVPOJ
         GjQ47xlcq+MnM2QVVryO2j6C3RxZvloH4hJxCA08LWg+u0CyuqmzPgVFcUMHytjpDzqA
         JPSEIwyTkZ5P2jXjQtk2FYB0TkCQZ/n9F0ixFVvomsxotJEjYRHC5Xd2Uq+HepmiydKL
         2pUQ2TxFHKYYBj6BUWWPoCiTXtjYoc/6IVDjaYi+JUhAEdWLxMXwp9nfTv5o/Zc4Ro+n
         lVSlfNcmGVvCUtl1RyDWU7MR0q0E9bbkKH4ccROkWp51C36jxcPmZMmTmdgazgGvthcS
         nlng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725271932; x=1725876732;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=76afwhTrp6Z2fEHksQViSsyfdFxYC6YbMO+dGFDi4MU=;
        b=YV8wQuq9d5K2bKmnMSI/8g7U6UDcac2gdt+jy/HwNm4qX4EOBZWy52EE2noxIZ4p08
         ltKmV9veVcKGN73lQn1lnvfnHaPBVjWqfMTJOMFEmkQFu3gueDfYigm8UTu6qm9OxKpI
         e/gxTGFJsrzJskgj5P4tzdHMLhZrJpPYdYR+uPLtDCE1m+507pme7GuWps1GOnZ6bnGd
         Dyhxm5rHUKlX2Gkqm58yaQqBRpx2MN8dd77ZflIVyFiRDRirZMoJC1LPMyFxsIKLcEVq
         M5xYcCICLtTRtc+425g9NPGfQctxP6lDNceFibfzO8q13uVJWoxSIVnfCw3Wd70yXH7B
         nxcw==
X-Forwarded-Encrypted: i=1; AJvYcCUtzFoB02X8U3DPfWplMXEwUddjqt41yZ/T6EWqJ8RZeAFgfBXV/zcwzijxuZEjVJk5NySy4EWMad0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDGlHACQZC4pouEnEXsDAskLQiEWm57ELSLbYk0T4Hk8oeMDVn
	0iFeLIySdbF455VrbfgJX1ftFvsWgbcwLz11J4DI7EV/EZow1atMoqwsTRAQvIPa54U1KQjSdhs
	rgBcofY1yWG6OpttwAgxNZD8a0SzzUYFckVcrWA==
X-Google-Smtp-Source: AGHT+IEOFoWn27UCKvp8TREi+qlv0EH7pfVG4SvgGVdexFyRX/3fw9URaYzFEmIJRPeEe4xHCC1rm3QuK3UQniDK/os=
X-Received: by 2002:a05:690c:7286:b0:630:de2f:79b8 with SMTP id
 00721157ae682-6d40f14f4a9mr95541047b3.13.1725271931843; Mon, 02 Sep 2024
 03:12:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
 <20240803-qps615-v2-8-9560b7c71369@quicinc.com> <spaudnuoam3cj7glxmnlw7y3m46d2vsm42s576jqwrcrmywl2n@oyrynorzhddg>
 <872e1c39-4547-7cd3-ba49-bbbe59e52087@quicinc.com> <32488500-05B7-4D25-9AAF-06A249CC6B1D@linaro.org>
 <d0c8b466-5df2-853c-608d-ab67af1a9f32@quicinc.com> <CAA8EJpo7J9ZXC9uERg=WkjMbDD-fDTOO2VXaRVOCVZXiN18oSw@mail.gmail.com>
 <4d67915a-d57d-0a33-cdef-3bdf05961d16@quicinc.com>
In-Reply-To: <4d67915a-d57d-0a33-cdef-3bdf05961d16@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 2 Sep 2024 13:12:00 +0300
Message-ID: <CAA8EJppa2Z-h0vH2Cmeem_1Cw8C+53q7pXkJ03mut4Bsn+Vm7A@mail.gmail.com>
Subject: Re: [PATCH v2 8/8] PCI: pwrctl: Add power control driver for qps615
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, cros-qcom-dts-watchers@chromium.org, 
	Bartosz Golaszewski <brgl@bgdev.pl>, Jingoo Han <jingoohan1@gmail.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, andersson@kernel.org, 
	quic_vbadigan@quicinc.com, linux-arm-msm@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 2 Sept 2024 at 11:32, Krishna Chaitanya Chundru
<quic_krichai@quicinc.com> wrote:
>
>
>
> On 9/2/2024 12:50 PM, Dmitry Baryshkov wrote:
> > On Mon, 2 Sept 2024 at 10:13, Krishna Chaitanya Chundru
> > <quic_krichai@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 8/8/2024 9:00 AM, Dmitry Baryshkov wrote:
> >>> On August 5, 2024 1:14:47 PM GMT+07:00, Krishna Chaitanya Chundru <quic_krichai@quicinc.com> wrote:
> >>>>
> >>>>
> >>>> On 8/3/2024 5:04 PM, Dmitry Baryshkov wrote:
> >>>>> On Sat, Aug 03, 2024 at 08:52:54AM GMT, Krishna chaitanya chundru wrote:
> >>>>>> QPS615 switch needs to be configured after powering on and before
> >>>>>> PCIe link was up.
> >>>>>>
> >>>>>> As the PCIe controller driver already enables the PCIe link training
> >>>>>> at the host side, stop the link training. Otherwise the moment we turn
> >>>>>> on the switch it will participate in the link training and link may come
> >>>>>> up before switch is configured through i2c.
> >>>>>>
> >>>>>> The device tree properties are parsed per node under pci-pci bridge in the
> >>>>>> driver. Each node has unique bdf value in the reg property, driver
> >>>>>> uses this bdf to differentiate ports, as there are certain i2c writes to
> >>>>>> select particular port.
> >>>>>>
> >>>>>> Based up on dt property and port, qps615 is configured through i2c.
> >>>>>>
> >>>>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> >>>>>> ---
> >>>>>>     drivers/pci/pwrctl/Kconfig             |   7 +
> >>>>>>     drivers/pci/pwrctl/Makefile            |   1 +
> >>>>>>     drivers/pci/pwrctl/pci-pwrctl-qps615.c | 638 +++++++++++++++++++++++++++++++++
> >>>>>>     3 files changed, 646 insertions(+)
> >>>>>>
> >>>>>> diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
> >>>>>> index 54589bb2403b..6a1352af918c 100644
> >>>>>> --- a/drivers/pci/pwrctl/Kconfig
> >>>>>> +++ b/drivers/pci/pwrctl/Kconfig
> >>>>>> @@ -10,3 +10,10 @@ config PCI_PWRCTL_PWRSEQ
> >>>>>>             tristate
> >>>>>>             select POWER_SEQUENCING
> >>>>>>             select PCI_PWRCTL
> >>>>>> +
> >>>>>> +config PCI_PWRCTL_QPS615
> >>>>>> +  tristate "PCI Power Control driver for QPS615"
> >>>>>> +  select PCI_PWRCTL
> >>>>>> +  help
> >>>>>> +    Say Y here to enable the pwrctl driver for Qualcomm
> >>>>>> +    QPS615 PCIe switch.
> >>>>>> diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
> >>>>>> index d308aae4800c..ac563a70c023 100644
> >>>>>> --- a/drivers/pci/pwrctl/Makefile
> >>>>>> +++ b/drivers/pci/pwrctl/Makefile
> >>>>>> @@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_PWRCTL)           += pci-pwrctl-core.o
> >>>>>>     pci-pwrctl-core-y                       := core.o
> >>>>>>       obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)               += pci-pwrctl-pwrseq.o
> >>>>>> +obj-$(CONFIG_PCI_PWRCTL_QPS615)           += pci-pwrctl-qps615.o
> >>>>>> diff --git a/drivers/pci/pwrctl/pci-pwrctl-qps615.c b/drivers/pci/pwrctl/pci-pwrctl-qps615.c
> >>>>>> new file mode 100644
> >>>>>> index 000000000000..9dabb82787d5
> >>>>>> --- /dev/null
> >>>>>> +++ b/drivers/pci/pwrctl/pci-pwrctl-qps615.c
> >>>>>> @@ -0,0 +1,638 @@
> >>>>>> +// SPDX-License-Identifier: GPL-2.0-only
> >>>>>> +/*
> >>>>>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
> >>>>>> + */
> >>>>>> +
> >>>>>> +#include <linux/delay.h>
> >>>>>> +#include <linux/device.h>
> >>>>>> +#include <linux/firmware.h>
> >>>>>> +#include <linux/i2c.h>
> >>>>>> +#include <linux/mod_devicetable.h>
> >>>>>> +#include <linux/module.h>
> >>>>>> +#include <linux/of.h>
> >>>>>> +#include <linux/pci.h>
> >>>>>> +#include <linux/pci-pwrctl.h>
> >>>>>> +#include <linux/platform_device.h>
> >>>>>> +#include <linux/regulator/consumer.h>
> >>>>>> +#include <linux/string.h>
> >>>>>> +#include <linux/types.h>
> >>>>>> +
> >>>>>> +#include "../pci.h"
> >>>>>> +
> >>>>>> +#define QPS615_GPIO_CONFIG                0x801208
> >>>>>> +#define QPS615_RESET_GPIO         0x801210
> >>>>>> +
> >>>>>> +#define QPS615_BUS_CONTROL                0x801014
> >>>>>> +
> >>>>>> +#define QPS615_PORT_L0S_DELAY             0x82496c
> >>>>>> +#define QPS615_PORT_L1_DELAY              0x824970
> >>>>>> +
> >>>>>> +#define QPS615_EMBEDDED_ETH_DELAY 0x8200d8
> >>>>>> +#define QPS615_ETH_L1_DELAY_MASK  GENMASK(27, 18)
> >>>>>> +#define QPS615_ETH_L1_DELAY_VALUE(x)      FIELD_PREP(QPS615_ETH_L1_DELAY_MASK, x)
> >>>>>> +#define QPS615_ETH_L0S_DELAY_MASK GENMASK(17, 13)
> >>>>>> +#define QPS615_ETH_L0S_DELAY_VALUE(x)     FIELD_PREP(QPS615_ETH_L0S_DELAY_MASK, x)
> >>>>>> +
> >>>>>> +#define QPS615_NFTS_2_5_GT                0x824978
> >>>>>> +#define QPS615_NFTS_5_GT          0x82497c
> >>>>>> +
> >>>>>> +#define QPS615_PORT_LANE_ACCESS_ENABLE    0x828000
> >>>>>> +
> >>>>>> +#define QPS615_PHY_RATE_CHANGE_OVERRIDE   0x828040
> >>>>>> +#define QPS615_PHY_RATE_CHANGE            0x828050
> >>>>>> +
> >>>>>> +#define QPS615_TX_MARGIN          0x828234
> >>>>>> +
> >>>>>> +#define QPS615_DFE_ENABLE         0x828a04
> >>>>>> +#define QPS615_DFE_EQ0_MODE               0x828a08
> >>>>>> +#define QPS615_DFE_EQ1_MODE               0x828a0c
> >>>>>> +#define QPS615_DFE_EQ2_MODE               0x828a14
> >>>>>> +#define QPS615_DFE_PD_MASK                0x828254
> >>>>>> +
> >>>>>> +#define QPS615_PORT_SELECT                0x82c02c
> >>>>>> +#define QPS615_PORT_ACCESS_ENABLE 0x82c030
> >>>>>> +
> >>>>>> +#define QPS615_POWER_CONTROL              0x82b09c
> >>>>>> +#define QPS615_POWER_CONTROL_OVREN        0x82b2c8
> >>>>>> +
> >>>>>> +#define QPS615_AXI_CLK_FREQ_MHZ           125
> >>>>>> +
> >>>>>> +struct qps615_pwrctl_reg_setting {
> >>>>>> +  unsigned int offset;
> >>>>>> +  unsigned int val;
> >>>>>> +};
> >>>>>> +
> >>>>>> +struct qps615_pwrctl_bdf_info {
> >>>>>> +  u16 usp_bdf;
> >>>>>> +  u16 dsp1_bdf;
> >>>>>> +  u16 dsp2_bdf;
> >>>>>> +  u16 dsp3_bdf;
> >>>>>
> >>>>> Why are these values dynamic? Please use #define's for now. If there
> >>>>> ever comes a similar bridge, it most likely will have a different ports
> >>>>> configuration, so it will need additional changes anyway.
> >>>>>
> >>>> We added this for future use case only, we felt it is easier to support
> >>>> at the time if we add this way.
> >>>
> >>> Please don't. You are hardcoding distinct roles into the structure that is supposed to be generic. Possible future use cases might have different number of ports or different port roles.
> >>>
> >> ok.
> >>>>
> >>>>>> +};
> >>>>>> +
> >>>>>> +enum qps615_pwrctl_ports {
> >>>>>> +  QPS615_USP,
> >>>>>> +  QPS615_DSP1,
> >>>>>> +  QPS615_DSP2,
> >>>>>> +  QPS615_DSP3,
> >>>>>> +  QPS615_ETHERNET,
> >>>>>> +  QPS615_MAX
> >>>>>> +};
> >>>>>> +
> >>>>>> +struct qps615_pwrctl_cfg {
> >>>>>> +  u32 l0s_delay;
> >>>>>> +  u32 l1_delay;
> >>>>>> +  u32 tx_amp;
> >>>>>> +  u32 axi_freq;
> >>>>>> +  u8  nfts;
> >>>>>> +  bool disable_dfe;
> >>>>>> +  bool disable_port;
> >>>>>> +};
> >>>>>> +
> >>>>>> +#define QPS615_PWRCTL_MAX_SUPPLY  6
> >>>>>> +
> >>>>>> +struct qps615_pwrctl_ctx {
> >>>>>> +  struct regulator_bulk_data supplies[QPS615_PWRCTL_MAX_SUPPLY];
> >>>>>> +  const struct qps615_pwrctl_bdf_info *bdf;
> >>>>>> +  struct qps615_pwrctl_cfg cfg[QPS615_MAX];
> >>>>>> +  struct gpio_desc *reset_gpio;
> >>>>>> +  struct i2c_client *client;
> >>>>>> +  struct pci_pwrctl pwrctl;
> >>>>>> +  struct device_link *link;
> >>>>>> +};
> >>>>>> +
> >>>>>> +/*
> >>>>>> + * downstream port power off sequence, hardcoding the address
> >>>>>> + * as we don't know register names for these register offsets.
> >>>>>
> >>>>> It is hard to believe that Qualcomm engineers don't know register names
> >>>>> for the Qualcomm device.
> >>>>>
> >>>> The switch IP is from the another vendor and the vendor provided these
> >>>> settings. The databook doesn't have the register names in it.
> >>>>>> + */
> >>>>>> +static const struct qps615_pwrctl_reg_setting common_pwroff_seq[] = {
> >>>>>> +  {0x82900c, 0x1},
> >>>>>> +  {0x829010, 0x1},
> >>>>>> +  {0x829018, 0x0},
> >>>>>> +  {0x829020, 0x1},
> >>>>>> +  {0x82902c, 0x1},
> >>>>>> +  {0x829030, 0x1},
> >>>>>> +  {0x82903c, 0x1},
> >>>>>> +  {0x829058, 0x0},
> >>>>>> +  {0x82905c, 0x1},
> >>>>>> +  {0x829060, 0x1},
> >>>>>> +  {0x8290cc, 0x1},
> >>>>>> +  {0x8290d0, 0x1},
> >>>>>> +  {0x8290d8, 0x1},
> >>>>>> +  {0x8290e0, 0x1},
> >>>>>> +  {0x8290e8, 0x1},
> >>>>>> +  {0x8290ec, 0x1},
> >>>>>> +  {0x8290f4, 0x1},
> >>>>>> +  {0x82910c, 0x1},
> >>>>>> +  {0x829110, 0x1},
> >>>>>> +  {0x829114, 0x1},
> >>>>>> +};
> >>>>>> +
> >>>>>> +static const struct qps615_pwrctl_reg_setting dsp1_pwroff_seq[] = {
> >>>>>> +  {QPS615_PORT_ACCESS_ENABLE, 0x2},
> >>>>>> +  {QPS615_PORT_LANE_ACCESS_ENABLE, 0x3},
> >>>>>> +  {QPS615_POWER_CONTROL, 0x014f4804},
> >>>>>> +  {QPS615_POWER_CONTROL_OVREN, 0x1},
> >>>>>> +  {QPS615_PORT_ACCESS_ENABLE, 0x4},
> >>>>>> +};
> >>>>>> +
> >>>>>> +static const struct qps615_pwrctl_reg_setting dsp2_pwroff_seq[] = {
> >>>>>> +  {QPS615_PORT_ACCESS_ENABLE, 0x8},
> >>>>>> +  {QPS615_PORT_LANE_ACCESS_ENABLE, 0x1},
> >>>>>> +  {QPS615_POWER_CONTROL, 0x014f4804},
> >>>>>> +  {QPS615_POWER_CONTROL_OVREN, 0x1},
> >>>>>> +  {QPS615_PORT_ACCESS_ENABLE, 0x8},
> >>>>>> +};
> >>>>>> +
> >>>>>> +static int qps615_pwrctl_i2c_write(struct i2c_client *client,
> >>>>>> +                             u32 reg_addr, u32 reg_val)
> >>>>>> +{
> >>>>>> +  struct i2c_msg msg;
> >>>>>> +  u8 msg_buf[7];
> >>>>>> +  int ret;
> >>>>>> +
> >>>>>> +  msg.addr = client->addr;
> >>>>>> +  msg.len = 7;
> >>>>>> +  msg.flags = 0;
> >>>>>> +
> >>>>>> +  /* Big Endian for reg addr */
> >>>>>> +  reg_addr = cpu_to_be32(reg_addr);
> >>>>>
> >>>>> This is incorrect. After cpu_to_be32() the value depends on the CPU
> >>>>> endianness. So reg_addr >> 8 will return different values for LE and BE
> >>>>> CPUs.
> >>>>> I had following impression
> >>>> If reg address is 0x828a0c in big endian sytem it will be 0c8a8200
> >>>> and in litte endian it will be 0x828a0c only.
> >>>> If cpu uses big endian cpu_to_be32 will not change this value
> >>>> and in little endian case cpu_to_be32 will convert 0x828a0c to 0c8a8200.
> >>>>
> >>>> Now the output is same for both the systems I tried to use
> >>>> (reg_addr >> 8) directly.
> >>>>
> >>>> Are you saying (reg_addr >> 8) output will be different based upon
> >>>> LE and BE ? If that is the case I will remove the conversions
> >>>> in next patch.
> >>>
> >>> Reg address is always 0x00828a0c. Then on little-endian system you convert it to to BE32, which results in the value 0x0c8a8200. Finally you use shifts to get {0x82, 0x8a, 0x0c}, which is supposedly correct.
> >>>
> >>> On big-endian system cpu_to_be32 returns the same value,  0x00828a0c, since it is BE32 already. So after shifts msg_buf will get {0x8a, 0x82, 0x00}, which is obviously incorrect.
> >>>
> >> ack, I will fix them.
> >>>>>> +
> >>>>>> +  msg_buf[0] = (u8)(reg_addr >> 8);
> >>>>>> +  msg_buf[1] = (u8)(reg_addr >> 16);
> >>>>>> +  msg_buf[2] = (u8)(reg_addr >> 24);
> >>>>>> +
> >>>>>> +  /* Little Endian for reg val */
> >>>>>> +  reg_val = cpu_to_le32(reg_val);
> >>>>>> +
> >>>>>> +  msg_buf[3] = (u8)(reg_val);
> >>>>>> +  msg_buf[4] = (u8)(reg_val >> 8);
> >>>>>> +  msg_buf[5] = (u8)(reg_val >> 16);
> >>>>>> +  msg_buf[6] = (u8)(reg_val >> 24);
> >>>>>
> >>>>> Same issue here.
> >>>>>
> >>>>>> +
> >>>>>> +  msg.buf = msg_buf;
> >>>>>> +  ret = i2c_transfer(client->adapter, &msg, 1);
> >>>>>> +  return ret == 1 ? 0 : ret;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int qps615_pwrctl_i2c_read(struct i2c_client *client,
> >>>>>> +                            u32 reg_addr, u32 *reg_val)
> >>>>>> +{
> >>>>>> +  struct i2c_msg msg[2];
> >>>>>> +  u8 wr_data[3];
> >>>>>> +  u32 rd_data;
> >>>>>> +  int ret;
> >>>>>> +
> >>>>>> +  msg[0].addr = client->addr;
> >>>>>> +  msg[0].len = 3;
> >>>>>> +  msg[0].flags = 0;
> >>>>>> +
> >>>>>> +  /* Big Endian for reg addr */
> >>>>>> +  reg_addr = cpu_to_be32(reg_addr);
> >>>>>> +
> >>>>>> +  wr_data[0] = (u8)(reg_addr >> 8);
> >>>>>> +  wr_data[1] = (u8)(reg_addr >> 16);
> >>>>>> +  wr_data[2] = (u8)(reg_addr >> 24);
> >>>>>
> >>>>> And here.
> >>>>>
> >>>>>> +
> >>>>>> +  msg[0].buf = wr_data;
> >>>>>> +
> >>>>>> +  msg[1].addr = client->addr;
> >>>>>> +  msg[1].len = 4;
> >>>>>> +  msg[1].flags = I2C_M_RD;
> >>>>>> +
> >>>>>> +  msg[1].buf = (u8 *)&rd_data;
> >>>>>> +
> >>>>>> +  ret = i2c_transfer(client->adapter, &msg[0], 2);
> >>>>>> +  if (ret == 2) {
> >>>>>> +          *reg_val = le32_to_cpu(rd_data);
> >>>>>> +          return 0;
> >>>>>> +  }
> >>>>>> +
> >>>>>> +  /* If only one message successfully completed, return -ENODEV */
> >>>>>> +  return ret == 1 ? -ENODEV : ret;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int qps615_pwrctl_i2c_bulk_write(struct i2c_client *client,
> >>>>>> +                                  const struct qps615_pwrctl_reg_setting *seq, int len)
> >>>>>> +{
> >>>>>> +  int ret, i;
> >>>>>> +
> >>>>>> +  for (i = 0; i < len; i++) {
> >>>>>> +          ret = qps615_pwrctl_i2c_write(client, seq[i].offset, seq[i].val);
> >>>>>> +          if (ret)
> >>>>>> +                  return ret;
> >>>>>> +  }
> >>>>>> +
> >>>>>> +  return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int of_pci_get_bdf(struct device_node *np)
> >>>>>> +{
> >>>>>> +  u32 reg[5];
> >>>>>> +  int error;
> >>>>>> +
> >>>>>> +  error = of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg));
> >>>>>
> >>>>> Please use of_property_read_u32_index() instead.
> >>>>>
> >>>> ack.
> >>>>>> +  if (error)
> >>>>>> +          return error;
> >>>>>> +
> >>>>>> +  return (reg[0] >> 8) & 0xffff;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int qps615_pwrctl_disable_port(struct qps615_pwrctl_ctx *ctx,
> >>>>>> +                                enum qps615_pwrctl_ports port)
> >>>>>> +{
> >>>>>> +  const struct qps615_pwrctl_reg_setting *seq;
> >>>>>> +  int ret, len;
> >>>>>> +
> >>>>>> +  seq = (port == QPS615_DSP1) ? dsp1_pwroff_seq : dsp2_pwroff_seq;
> >>>>>> +  len = (port == QPS615_DSP1) ? ARRAY_SIZE(dsp1_pwroff_seq) : ARRAY_SIZE(dsp2_pwroff_seq);
> >>>>>> +
> >>>>>> +  ret = qps615_pwrctl_i2c_bulk_write(ctx->client, seq, len);
> >>>>>> +  if (ret)
> >>>>>> +          return ret;
> >>>>>> +
> >>>>>> +  return qps615_pwrctl_i2c_bulk_write(ctx->client,
> >>>>>> +                                      common_pwroff_seq, ARRAY_SIZE(common_pwroff_seq));
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int qps615_pwrctl_set_l0s_l1_entry_delay(struct qps615_pwrctl_ctx *ctx,
> >>>>>> +                                          enum qps615_pwrctl_ports port, bool is_l1, u32 ns)
> >>>>>> +{
> >>>>>> +  u32 rd_val, units;
> >>>>>> +  int ret;
> >>>>>> +
> >>>>>> +  /* convert to units of 256ns */
> >>>>>> +  units = ns / 256;
> >>>>>> +
> >>>>>> +  if (port == QPS615_ETHERNET) {
> >>>>>> +          ret = qps615_pwrctl_i2c_read(ctx->client, QPS615_EMBEDDED_ETH_DELAY, &rd_val);
> >>>>>> +          if (ret)
> >>>>>> +                  return ret;
> >>>>>> +          rd_val = u32_replace_bits(rd_val, units,
> >>>>>> +                                    is_l1 ?
> >>>>>> +                                    QPS615_ETH_L1_DELAY_MASK : QPS615_ETH_L0S_DELAY_MASK);
> >>>>>> +          return qps615_pwrctl_i2c_write(ctx->client, QPS615_EMBEDDED_ETH_DELAY, rd_val);
> >>>>>> +  }
> >>>>>> +
> >>>>>> +  ret = qps615_pwrctl_i2c_write(ctx->client, QPS615_PORT_SELECT, BIT(port));
> >>>>>> +  if (ret)
> >>>>>> +          return ret;
> >>>>>
> >>>>> What if there is a concurrent call? The port_select / write_value
> >>>>> statements should use a lock to remove the possible race condition.
> >>>>>
> >>>> There should not be any concurrent calls since all calls come from the
> >>>> probe itself.
> >>>
> >>> Comment this in the driver, since somebody might decide to call the function later
> >> ack
> >>>
> >>>>>> +
> >>>>>> +  return qps615_pwrctl_i2c_write(ctx->client,
> >>>>>> +                                 is_l1 ? QPS615_PORT_L1_DELAY : QPS615_PORT_L0S_DELAY, units);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int qps615_pwrctl_set_tx_amplitude(struct qps615_pwrctl_ctx *ctx,
> >>>>>> +                                    enum qps615_pwrctl_ports port, u32 amp)
> >>>>>> +{
> >>>>>> +  int port_access;
> >>>>>> +
> >>>>>> +  switch (port) {
> >>>>>> +  case QPS615_USP:
> >>>>>> +          port_access = 0x1;
> >>>>>> +          break;
> >>>>>> +  case QPS615_DSP1:
> >>>>>> +          port_access = 0x2;
> >>>>>> +          break;
> >>>>>> +  case QPS615_DSP2:
> >>>>>> +          port_access = 0x8;
> >>>>>> +          break;
> >>>>>> +  default:
> >>>>>> +          return -EINVAL;
> >>>>>> +  };
> >>>>>> +
> >>>>>> +  struct qps615_pwrctl_reg_setting tx_amp_seq[] = {
> >>>>>> +          {QPS615_PORT_ACCESS_ENABLE, port_access},
> >>>>>
> >>>>> Hmm, this looks like another port selection, so most likely it should
> >>>>> also be under the same lock.
> >>>>>
> >>>>>> +          {QPS615_PORT_LANE_ACCESS_ENABLE, 0x3},
> >>>>>> +          {QPS615_TX_MARGIN, amp},
> >>>>>> +  };
> >>>>>> +
> >>>>>> +  return qps615_pwrctl_i2c_bulk_write(ctx->client, tx_amp_seq, ARRAY_SIZE(tx_amp_seq));
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int qps615_pwrctl_disable_dfe(struct qps615_pwrctl_ctx *ctx,
> >>>>>> +                               enum qps615_pwrctl_ports port)
> >>>>>> +{
> >>>>>> +  int port_access, lane_access = 0x3;
> >>>>>> +  u32 phy_rate = 0x21;
> >>>>>> +
> >>>>>> +  switch (port) {
> >>>>>> +  case QPS615_USP:
> >>>>>> +          phy_rate = 0x1;
> >>>>>> +          port_access = 0x1;
> >>>>>> +          break;
> >>>>>> +  case QPS615_DSP1:
> >>>>>> +          port_access = 0x2;
> >>>>>> +          break;
> >>>>>> +  case QPS615_DSP2:
> >>>>>> +          port_access = 0x8;
> >>>>>> +          lane_access = 0x1;
> >>>>>> +          break;
> >>>>>> +  default:
> >>>>>> +          return -EINVAL;
> >>>>>> +  };
> >>>>>> +
> >>>>>> +  struct qps615_pwrctl_reg_setting disable_dfe_seq[] = {
> >>>>>> +          {QPS615_PORT_ACCESS_ENABLE, port_access},
> >>>>>> +          {QPS615_PORT_LANE_ACCESS_ENABLE, lane_access},
> >>>>>> +          {QPS615_DFE_ENABLE, 0x0},
> >>>>>> +          {QPS615_DFE_EQ0_MODE, 0x411},
> >>>>>> +          {QPS615_DFE_EQ1_MODE, 0x11},
> >>>>>> +          {QPS615_DFE_EQ2_MODE, 0x11},
> >>>>>> +          {QPS615_DFE_PD_MASK, 0x7},
> >>>>>> +          {QPS615_PHY_RATE_CHANGE_OVERRIDE, 0x10},
> >>>>>> +          {QPS615_PHY_RATE_CHANGE, phy_rate},
> >>>>>> +          {QPS615_PHY_RATE_CHANGE, 0x0},
> >>>>>> +          {QPS615_PHY_RATE_CHANGE_OVERRIDE, 0x0},
> >>>>>> +
> >>>>>> +  };
> >>>>>> +
> >>>>>> +  return qps615_pwrctl_i2c_bulk_write(ctx->client,
> >>>>>> +                                      disable_dfe_seq, ARRAY_SIZE(disable_dfe_seq));
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int qps615_pwrctl_set_nfts(struct qps615_pwrctl_ctx *ctx,
> >>>>>> +                            enum qps615_pwrctl_ports port, u32 nfts)
> >>>>>> +{
> >>>>>> +  int ret;
> >>>>>> +  struct qps615_pwrctl_reg_setting nfts_seq[] = {
> >>>>>> +          {QPS615_NFTS_2_5_GT, nfts},
> >>>>>> +          {QPS615_NFTS_5_GT, nfts},
> >>>>>> +  };
> >>>>>> +
> >>>>>> +  ret =  qps615_pwrctl_i2c_write(ctx->client, QPS615_PORT_SELECT, BIT(port));
> >>>>>> +  if (ret)
> >>>>>> +          return ret;
> >>>>>> +
> >>>>>> +  return qps615_pwrctl_i2c_bulk_write(ctx->client, nfts_seq, ARRAY_SIZE(nfts_seq));
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int qps615_pwrctl_assert_deassert_reset(struct qps615_pwrctl_ctx *ctx, bool deassert)
> >>>>>> +{
> >>>>>> +  int ret, val = 0;
> >>>>>> +
> >>>>>> +  if (deassert)
> >>>>>> +          val = 0xc;
> >>>>>> +
> >>>>>> +  ret = qps615_pwrctl_i2c_write(ctx->client, QPS615_GPIO_CONFIG, 0xfffffff3);
> >>>>>
> >>>>> It's a kind of magic
> >>>>>
> >>>> I will add a macro in next patch.
> >>>>>> +  if (ret)
> >>>>>> +          return ret;
> >>>>>> +
> >>>>>> +  return qps615_pwrctl_i2c_write(ctx->client, QPS615_RESET_GPIO, val);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int qps615_pwrctl_parse_device_dt(struct qps615_pwrctl_ctx *ctx, struct device_node *node)
> >>>>>> +{
> >>>>>> +  enum qps615_pwrctl_ports port;
> >>>>>> +  struct qps615_pwrctl_cfg *cfg;
> >>>>>> +  struct device_node *np;
> >>>>>> +  int bdf, fun_no;
> >>>>>> +
> >>>>>> +  bdf = of_pci_get_bdf(node);
> >>>>>> +  if (bdf < 0) {
> >>>>>
> >>>>> This is incorrect, it will fail if at any point BDF uses the most
> >>>>> significant bit (which is permitted by the spec, if I'm not mistaken).
> >>>>>
> >>>> As per the reg property as described in the binding document we are not
> >>>> expecting any change here.
> >>>> https://elixir.bootlin.com/linux/v6.10.3/source/Documentation/devicetree/bindings/pci/pci.txt#L50.
> >>>
> >>> What will this function return if the bus no is 256?
> >>> The supported PCI bus number is from 0x0 to 0xff only. so we
> >> are not expecting any numbers greater than 0xff.
> >>> Also please either move the function to the generic PCI code is change its name to match the rest of the driver. The of_pci_ prefix is reserved for the generic code.
> >>>
> >> ack.
> >>>
> >>>>>> +          dev_err(ctx->pwrctl.dev, "Getting BDF failed\n");
> >>>>>> +          return 0;
> >>>>>> +  }
> >>>>>> +
> >>>>>> +  fun_no = bdf & 0x7;
> >>>>>
> >>>>> I assume that ARI is not supported?
> >>>>>
> >>>> Yes this doesn't support ARI.
> >>>>>> +
> >>>>>> +  /* In multi function node, ignore function 1 node */
> >>>>>> +  if (of_pci_get_bdf(of_get_parent(node)) == ctx->bdf->dsp3_bdf && !fun_no)
> >>>>>> +          port = QPS615_ETHERNET;
> >>>>>> +  else if (bdf == ctx->bdf->usp_bdf)
> >>>>>> +          port = QPS615_USP;
> >>>>>
> >>>>> The function is being called for child device nodes. Thus upstream
> >>>>> facing port (I assume that this is what USP means) can not be enumerated
> >>>>> in this way.
> >>>> Sorry, but I didn't your question.
> >>>>
> >>>> These settings will not affect the enumeration sequence these are
> >>>> for configuring ports only.
> >>>
> >>> You are handling the case of bdf equal to the USP. Is it possible at all?
> >>>
> >> at the time of the configuration the PCI link is not enabled yet,
> >> once we are done with the configurations only we are resumeing the link
> >> training. so when we start this configuration the link is not up yet.
> >
> > Is your answer relevant to the question I have asked?
> >
> sorry dmitry I might got your question wrong. what I understood is
> "you are configuring USP port before the link is up, is that possible?"
> I might read your statement wrongly.
>
> If the question is "why do we need to configure USP?" I will try to
> respond below.
> "USP also will have l0s, L1 entry delays, nfts etc which can be
> configured".
>
> Sorry once again if your question doesn't fall in both can you tell
> me your question.

My question was why the function gets executed for the root port. But
after reading the qps615_pwrctl_parse_device_dt() I have another
question: you are parsing DT nodes recursively. You should stop
parsing at the first level, so that grandchildren nodes can not
override your data (and so that the time isn't spent on parsing
useless data). Also I have the feeling that BDF parsing isn't so
correct. Will it work if QPS is sitting behind a PCI-PCI bridge?

> >>>
> >>>>>
> >>>>>> +  else if (bdf == ctx->bdf->dsp1_bdf)
> >>>>>> +          port = QPS615_DSP1;
> >>>>>> +  else if (bdf == ctx->bdf->dsp2_bdf)
> >>>>>> +          port = QPS615_DSP2;
> >>>>>> +  else if (bdf == ctx->bdf->dsp3_bdf)
> >>>>>> +          port = QPS615_DSP3;
> >>>>>> +  else
> >>>>>> +          return 0;
> >>>>>
> >>>>> -EINVAL >
> >>>> There are can be nodes describing endpoints also,
> >>>> for those nodes bdf will not match and we are not
> >>>> returning since it is expected for endpoint nodes.
> >>>
> >>> Which endpoints? Bindings don't describe them.
> >>>
> >> The client drivers like ethernet will add them once
> >> this series is merged. Their drivers are not present
> >> in the linux as of now.
> >
> > The bindings describe the hardware, not the drivers. Also the driver
> > should work with the bindings that you have submitted, not some
> > imaginary to-be-submitted state. Please either update the bindings
> > within the patchset or fix the driver to return -EINVAL.
> >
> The qps615 bindings describes only the PCIe switch part,
> the endpoints binding connected to the switch should be described by the
> respective clients like USB hub, NVMe, ethernet etc bindings should
> describe their hardware and its properties. And these bindings will
> defined in seperate bindinds file not in qps615 bindings.
>
> for example:-
>
> in the following example pcie@0,0 describes usp and
> pcie@1,0 & pcie@2,0 describes dsp's of the switch.
> now if we say usb hub is connected to dsp1 i.e to the
> node pcie@1,0 there will be a child node to the pcie@1,0
> to denote usb hub hardware.
> And that node is external to the switch and we are not
> configuring it through i2c. As these are pcie devices
> representation is generic one we can't say if the client
> nodes(in this case usb hub) will be present or not. if the child
> node( for example usb hub) is present we can't return -EINVAL
> because qps615 will not configure it.
>
> &pcieport {
>         pcie@0,0 {
>                 pcie@1,0 {
>                         reg = <0x20800 0x0 0x0 0x0 0x0>;
>                         #address-cells = <3>;
>                         #size-cells = <2>;
>
>                         device_type = "pci";
>                         ranges;
>                         usb_hub@0,0 {
>                                 //describes USB hub
>                         };
>                 };
>
>                 pcie@2,0 {
>                         reg = <0x21000 0x0 0x0 0x0 0x0>;
>                         #address-cells = <3>;
>                         #size-cells = <2>;
>
>                         device_type = "pci";
>                         ranges;
>                 };
>         };
> };
> >>>
> >>>>
> >>>>>> +
> >>>>>> +  cfg = &ctx->cfg[port];
> >>>>>> +
> >>>>>> +  if (!of_device_is_available(node)) {
> >>>>>> +          cfg->disable_port = true;
> >>>>>> +          return 0;
> >>>>>> +  };
> >>>>>> +
> >>>>>> +  of_property_read_u32(node, "qcom,axi-clk-freq-hz", &cfg->axi_freq);
> >>>>>> +
> >>>>>> +  of_property_read_u32(node, "qcom,l0s-entry-delay-ns", &cfg->l0s_delay);
> >>>>>> +
> >>>>>> +  of_property_read_u32(node, "qcom,l1-entry-delay-ns", &cfg->l1_delay);
> >>>>>> +
> >>>>>> +  of_property_read_u32(node, "qcom,tx-amplitude-millivolt", &cfg->tx_amp);
> >>>>>> +
> >>>>>> +  cfg->disable_dfe = of_property_read_bool(node, "qcom,no-dfe");
> >>>>>> +
> >>>>>> +  of_property_read_u8(node, "qcom,nfts", &cfg->nfts);
> >>>>>> +
> >>>>>> +  for_each_child_of_node(node, np)
> >>>>>> +          qps615_pwrctl_parse_device_dt(ctx, np);
> >>>>>> +
> >>>>>> +  of_node_put(np);
> >>>>>> +  return 0;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void qps615_pwrctl_power_off(struct qps615_pwrctl_ctx *ctx)
> >>>>>> +{
> >>>>>> +  gpiod_set_value(ctx->reset_gpio, 1);
> >>>>>> +
> >>>>>> +  regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int qps615_pwrctl_power_on(struct qps615_pwrctl_ctx *ctx)
> >>>>>> +{
> >>>>>> +  struct qps615_pwrctl_cfg *cfg;
> >>>>>> +  int ret, i;
> >>>>>> +
> >>>>>> +  ret = regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
> >>>>>> +  if (ret < 0)
> >>>>>> +          return dev_err_probe(ctx->pwrctl.dev, ret, "cannot enable regulators\n");
> >>>>>> +
> >>>>>> +  gpiod_set_value(ctx->reset_gpio, 0);
> >>>>>> +
> >>>>>> +  if (!ctx->client)
> >>>>>> +          return 0;
> >>>>>
> >>>>> really?
> >>>>>
> >>>> Even if we don't do i2c configuration PCIe enumeration will happen, for
> >>>> some reason i2c client is not found, driver ignores the error and return
> >>>> since basic functionality will work.
> >>>
> >>> So what is the point of such misconfiguration? If "something works" even in the default case, then we don't need this driver at all, do we?
> >>>
> >> we need this configuration for better power savings, reduce the AER
> >> errors etc.. if there is no i2c client then that particular platform
> >> doesn't need any configurations required.
> >
> > NAK. The i2c client is marked as required in the bindings. So there is
> > no way for the kernel to see the device with no qps615 controller
> > property.
> >
> agree as it is a required property we should not return 0 here.
> I will return proper error value here.
>
> - Krishna chaitanya.
> >>> Even worse. With the modular kernels you can not guarantee probe order. However the user expects that if the driver is probed, it has configured the hardware correctly.
> >>>> Linux has special return value for such cases, please return it
> >> instead if 0.
> >>>
> >> ack we will check and return them instead of 0.
> >> - Krishna chaitanya.
> >>>
> >>>>>> +
> >>>>>> +  /*
> >>>>>> +   * Don't have a way to see if the reset has completed.
> >>>>>> +   * Wait for some time.
> >>>>>> +   */
> >>>>>> +  usleep_range(1000, 1001);
> >>>>>> +
> >>>>>> +  ret = qps615_pwrctl_assert_deassert_reset(ctx, false);
> >>>>>> +  if (ret)
> >>>>>> +          goto out;
> >>>>>> +
> >>>>>> +  if (ctx->cfg[QPS615_USP].axi_freq == QPS615_AXI_CLK_FREQ_MHZ) {
> >>>>>> +          ret = qps615_pwrctl_i2c_write(ctx->client, QPS615_BUS_CONTROL, BIT(16));
> >>>>>> +          if (ret)
> >>>>>> +                  dev_err(ctx->pwrctl.dev, "Setting axi clk freq failed %d\n", ret);
> >>>>>
> >>>>> AXI, not axi
> >>>>>
> >>>> ack.
> >>>>>> +  }
> >>>>>> +
> >>>>>> +  for (i = 0; i < QPS615_MAX; i++) {
> >>>>>> +          cfg = &ctx->cfg[i];
> >>>>>> +          if (cfg->disable_port) {
> >>>>>> +                  ret = qps615_pwrctl_disable_port(ctx, i);
> >>>>>> +                  if (ret) {
> >>>>>> +                          dev_err(ctx->pwrctl.dev, "Disabling port failed\n");
> >>>>>> +                          goto out;
> >>>>>> +                  }
> >>>>>> +          }
> >>>>>> +
> >>>>>> +          if (cfg->l0s_delay) {
> >>>>>> +                  ret = qps615_pwrctl_set_l0s_l1_entry_delay(ctx, i, false, cfg->l0s_delay);
> >>>>>> +                  if (ret) {
> >>>>>> +                          dev_err(ctx->pwrctl.dev, "Setting L0s entry delay failed\n");
> >>>>>> +                          goto out;
> >>>>>> +                  }
> >>>>>> +          }
> >>>>>> +
> >>>>>> +          if (cfg->l1_delay) {
> >>>>>> +                  ret = qps615_pwrctl_set_l0s_l1_entry_delay(ctx, i, true, cfg->l1_delay);
> >>>>>> +                  if (ret) {
> >>>>>> +                          dev_err(ctx->pwrctl.dev, "Setting L1 entry delay failed\n");
> >>>>>> +                          goto out;
> >>>>>> +                  }
> >>>>>> +          }
> >>>>>> +
> >>>>>> +          if (cfg->tx_amp) {
> >>>>>> +                  ret = qps615_pwrctl_set_tx_amplitude(ctx, i, cfg->tx_amp);
> >>>>>> +                  if (ret) {
> >>>>>> +                          dev_err(ctx->pwrctl.dev, "Setting Tx amplitube failed\n");
> >>>>>> +                          goto out;
> >>>>>> +                  }
> >>>>>> +          }
> >>>>>> +
> >>>>>> +          if (cfg->nfts) {
> >>>>>> +                  ret = qps615_pwrctl_set_nfts(ctx, i, cfg->nfts);
> >>>>>> +                  if (ret) {
> >>>>>> +                          dev_err(ctx->pwrctl.dev, "Setting nfts failed\n");
> >>>>>> +                          goto out;
> >>>>>> +                  }
> >>>>>> +          }
> >>>>>> +
> >>>>>> +          if (cfg->disable_dfe) {
> >>>>>> +                  ret = qps615_pwrctl_disable_dfe(ctx, i);
> >>>>>> +                  if (ret) {
> >>>>>> +                          dev_err(ctx->pwrctl.dev, "Disabling DFE failed\n");
> >>>>>> +                          goto out;
> >>>>>> +                  }
> >>>>>> +          }
> >>>>>> +  }
> >>>>>> +
> >>>>>> +  ret = qps615_pwrctl_assert_deassert_reset(ctx, true);
> >>>>>> +  if (!ret)
> >>>>>> +          return 0;
> >>>>>> +
> >>>>>> +out:
> >>>>>> +  qps615_pwrctl_power_off(ctx);
> >>>>>> +  return ret;
> >>>>>> +}
> >>>>>> +
> >>>>>> +static int qps615_pwrctl_probe(struct platform_device *pdev)
> >>>>>> +{
> >>>>>> +  struct device *dev = &pdev->dev;
> >>>>>> +  struct pci_host_bridge *bridge;
> >>>>>> +  struct qps615_pwrctl_ctx *ctx;
> >>>>>> +  struct device_node *node;
> >>>>>> +  struct pci_bus *bus;
> >>>>>> +  int ret;
> >>>>>> +
> >>>>>> +  bus = pci_find_bus(of_get_pci_domain_nr(dev->parent->of_node), 0);
> >>>>>> +  if (!bus)
> >>>>>> +          return -ENODEV;
> >>>>>> +
> >>>>>> +  bridge = pci_find_host_bridge(bus);
> >>>>>> +
> >>>>>> +  ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
> >>>>>> +  if (!ctx)
> >>>>>> +          return -ENOMEM;
> >>>>>> +
> >>>>>> +  node = of_parse_phandle(pdev->dev.of_node, "qcom,qps615-controller", 0);
> >>>>>> +  if (node) {
> >>>>>
> >>>>> And if !node?
> >>>>>
> >>>>>> +          ctx->client = of_find_i2c_device_by_node(node);
> >>>>>
> >>>>> Leaks the reference count, see the comment at the function definition.
> >>>>> Also what if the I2C bus gets unbound? Will it crash the driver?
> >>>>>
> >>>> I will fix in next patch.
> >>>>
> >>>> Driver is not expected to crash when i2c bus gets unbound.
> >>>> It should be properly handled in i2c driver.
> >>>
> >>> Please verify it.
> >>>
> >>>
> >>>>
> >>>> - Krishna Chaitanya.
> >>>>>> +          of_node_put(node);
> >>>>>> +          if (!ctx->client)
> >>>>>> +                  return dev_err_probe(dev, -EPROBE_DEFER,
> >>>>>> +                                       "failed to parse qcom,qps615-controller\n");
> >>>>>> +  }
> >>>>>> +
> >>>>>> +  ctx->bdf = of_device_get_match_data(dev);
> >>>>>> +  ctx->pwrctl.dev = dev;
> >>>>>> +
> >>>>>> +  ctx->supplies[0].supply = "vddc";
> >>>>>> +  ctx->supplies[1].supply = "vdd18";
> >>>>>> +  ctx->supplies[2].supply = "vdd09";
> >>>>>> +  ctx->supplies[3].supply = "vddio1";
> >>>>>> +  ctx->supplies[4].supply = "vddio2";
> >>>>>> +  ctx->supplies[5].supply = "vddio18";
> >>>>>> +  ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies), ctx->supplies);
> >>>>>> +  if (ret)
> >>>>>> +          return dev_err_probe(dev, ret,
> >>>>>> +                               "failed to get supply regulator\n");
> >>>>>> +
> >>>>>> +  ctx->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_ASIS);
> >>>>>> +  if (IS_ERR(ctx->reset_gpio))
> >>>>>> +          return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio), "failed to get reset GPIO\n");
> >>>>>> +
> >>>>>> +  ctx->link = device_link_add(&bridge->dev, dev, DL_FLAG_AUTOREMOVE_CONSUMER);
> >>>>>> +
> >>>>>> +  platform_set_drvdata(pdev, ctx);
> >>>>>> +
> >>>>>> +  qps615_pwrctl_parse_device_dt(ctx, pdev->dev.of_node);
> >>>>>> +
> >>>>>> +  if (bridge->ops->stop_link)
> >>>>>> +          bridge->ops->stop_link(bus);
> >>>>>> +
> >>>>>> +  ret = qps615_pwrctl_power_on(ctx);
> >>>>>> +  if (ret)
> >>>>>> +          return ret;
> >>>>>> +
> >>>>>> +  if (bridge->ops->start_link) {
> >>>>>> +          ret = bridge->ops->start_link(bus);
> >>>>>> +          if (ret)
> >>>>>> +                  return ret;
> >>>>>> +  }
> >>>>>> +
> >>>>>> +  return devm_pci_pwrctl_device_set_ready(dev, &ctx->pwrctl);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static void qps615_pwrctl_remove(struct platform_device *pdev)
> >>>>>> +{
> >>>>>> +  struct device *dev = &pdev->dev;
> >>>>>> +  struct qps615_pwrctl_ctx *ctx = dev_get_drvdata(dev);
> >>>>>> +
> >>>>>> +  device_link_del(ctx->link);
> >>>>>> +  qps615_pwrctl_power_off(ctx);
> >>>>>> +}
> >>>>>> +
> >>>>>> +static const struct qps615_pwrctl_bdf_info bdf_info = {
> >>>>>> +  .usp_bdf        = 0x100,
> >>>>>> +  .dsp1_bdf       = 0x208,
> >>>>>> +  .dsp2_bdf       = 0x210,
> >>>>>> +  .dsp3_bdf       = 0x218,
> >>>>>> +};
> >>>>>> +
> >>>>>> +static const struct of_device_id qps615_pwrctl_of_match[] = {
> >>>>>> +  { .compatible = "pci1179,0623", .data = &bdf_info },
> >>>>>> +  { }
> >>>>>> +};
> >>>>>> +MODULE_DEVICE_TABLE(of, qps615_pwrctl_of_match);
> >>>>>> +
> >>>>>> +static struct platform_driver qps615_pwrctl_driver = {
> >>>>>> +  .driver = {
> >>>>>> +          .name = "pwrctl-qps615",
> >>>>>> +          .of_match_table = qps615_pwrctl_of_match,
> >>>>>> +          .probe_type = PROBE_PREFER_ASYNCHRONOUS,
> >>>>>> +  },
> >>>>>> +  .probe = qps615_pwrctl_probe,
> >>>>>> +  .remove_new = qps615_pwrctl_remove,
> >>>>>> +};
> >>>>>> +module_platform_driver(qps615_pwrctl_driver);
> >>>>>> +
> >>>>>> +MODULE_AUTHOR("Krishna chaitanya chundru <quic_krichai@quicinc.com>");
> >>>>>> +MODULE_DESCRIPTION("Qualcomm QPS615 power control driver");
> >>>>>> +MODULE_LICENSE("GPL");
> >>>>>>
> >>>>>> --
> >>>>>> 2.34.1
> >>>>>>
> >>>>>
> >>>
> >>>
> >
> >
> >



-- 
With best wishes
Dmitry

