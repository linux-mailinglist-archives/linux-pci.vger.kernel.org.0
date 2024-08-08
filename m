Return-Path: <linux-pci+bounces-11471-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F3794B57C
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 05:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147CC1F22C12
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2024 03:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A59A79B8E;
	Thu,  8 Aug 2024 03:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ufnTADZf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f67.google.com (mail-ot1-f67.google.com [209.85.210.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC6433B0
	for <linux-pci@vger.kernel.org>; Thu,  8 Aug 2024 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723087835; cv=none; b=Le8Kj28xLEeai6NKfe4XDuZHK42sPfkVtFAH9RDr1OS0BOrvVeu6YhjNsP/uF4V0GRlh+9fVGtozWN4PorWQZqkGgTOCvflqVjNFbvOe8hllu05E49380y4yndCq1/0q/Ijwt8jrX+2RmlAXJa10q/Xip9ciJKywYatPuLWUYIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723087835; c=relaxed/simple;
	bh=TWHRNAH0Kok1D3KYw0IL/8wPtq4gzco2MJXrgv0dQFM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=F76spXHu5Nw5mDh8EBGJlXE34kd6zwDkwAuK/UBM6U/d5J2UNmZD7OHDWs+AGEaiQy6U1lwdMjFoLlJzBLWnaFYG8pOEVxmKPBBq3SaqoCiSm8kgPuBjbaR51oWcfWgSCxPZmcH0aRLBfO/ZP6vBH45xD728zNEJOHSeEbZtgqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ufnTADZf; arc=none smtp.client-ip=209.85.210.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f67.google.com with SMTP id 46e09a7af769-70941cb73e9so213038a34.2
        for <linux-pci@vger.kernel.org>; Wed, 07 Aug 2024 20:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723087832; x=1723692632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0BhmOX8P4M5pYESd8Qa1JFTF6VZL9OuIxN8r0qkc6VA=;
        b=ufnTADZfx9ti9mEj6I4oVlIiu/oHY8Mzp31VGGpKpmzYCRhT4O6DyAqkSSuEG6wNDY
         NiedZuF1L6oVQ6KeyjrNlJyNS7mVFfJvxHETqAHAfO/CVc2MJA66F/3X3OkEI0WXdhC5
         JLqxzuCYB5I5z2pxPX0mDczmO9HP4McodtkhaNL82h4PcmG6QkiFj+WHEXsabdv+3qeq
         NSMq5OG2VM+yGhFz4ED7vFr4Vgs5lteR93XTYBKKteOUN7ZjXQqgwU1ScjBCD0ab/R8R
         l0ElN9yzehgyWWo3C/1SmfjFMA3bsUVXA+DWXFQm8U8aZFWVb6e09B/zFyII6kYJpQAr
         3nEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723087832; x=1723692632;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0BhmOX8P4M5pYESd8Qa1JFTF6VZL9OuIxN8r0qkc6VA=;
        b=Kvif/8zwx2KJ4/vDtgxvQVNRLXcmbkV0zoJb1YqZoRKjqYXTJj5ZKdjfPUr0diYkRT
         RbyiBJiH13ITwzyEklBSlPAyXIkWmtQBgcJ+Bb3JgbDW+fkaaGIJi/zrk1xsidmk3dLW
         8uHm9Kihh5pGYjAmOboxQb4qgk37c2IFffC5FBNCLtUPw3KYLqhE6lnZrgGADELp0VIe
         GS85BQ2+3wFVSIe97YcPMhcRfim2kAJzAbbQ8d2dhP92jTLXHXjP9nGkwKglBzZK3CuD
         bcXQkeF2mJy7XSqhjM8G98728g4k7ybj9ldMJYBSFuf87x9bAUhQqbYY6LQ+dT2GL9kk
         TY6A==
X-Forwarded-Encrypted: i=1; AJvYcCWLZQ02FM/anZnKvVEjNSTkLzq4fUcPLoLsUaQe5sNXqYhLntVYzcvm6mjjvDwbTFIWRngOf+M/ty8AXAytl9OISvXtZ4sKJYBR
X-Gm-Message-State: AOJu0YxRG0cLb+uRoaKcNgybYZt5ehlpH3+l+Lkv5/+LTHTu9CdKXSXp
	8XVtCabjJCwROYksTx8CyqpJNxKEGkvg1e6YguEvclylZKkkHTTi3jfvvbHVaQI=
X-Google-Smtp-Source: AGHT+IHbIR3A3r+KkVpAkU49LUJldYpI2oPUMbnU7lPotoq8CZ1Kd8P2SG4rb3FLpPm1ehBKBBd5aA==
X-Received: by 2002:a05:6830:6084:b0:703:6a59:b52b with SMTP id 46e09a7af769-70b4fc2315bmr905331a34.3.1723087831903;
        Wed, 07 Aug 2024 20:30:31 -0700 (PDT)
Received: from [127.0.0.1] ([182.232.174.245])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7b7635660ecsm7723120a12.38.2024.08.07.20.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 20:30:31 -0700 (PDT)
Date: Thu, 08 Aug 2024 10:30:26 +0700
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
CC: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 cros-qcom-dts-watchers@chromium.org, Bartosz Golaszewski <brgl@bgdev.pl>,
 Jingoo Han <jingoohan1@gmail.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 andersson@kernel.org, quic_vbadigan@quicinc.com,
 linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 8/8] PCI: pwrctl: Add power control driver for qps615
User-Agent: K-9 Mail for Android
In-Reply-To: <872e1c39-4547-7cd3-ba49-bbbe59e52087@quicinc.com>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com> <20240803-qps615-v2-8-9560b7c71369@quicinc.com> <spaudnuoam3cj7glxmnlw7y3m46d2vsm42s576jqwrcrmywl2n@oyrynorzhddg> <872e1c39-4547-7cd3-ba49-bbbe59e52087@quicinc.com>
Message-ID: <32488500-05B7-4D25-9AAF-06A249CC6B1D@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 5, 2024 1:14:47 PM GMT+07:00, Krishna Chaitanya Chundru <quic_kri=
chai@quicinc=2Ecom> wrote:
>
>
>On 8/3/2024 5:04 PM, Dmitry Baryshkov wrote:
>> On Sat, Aug 03, 2024 at 08:52:54AM GMT, Krishna chaitanya chundru wrote=
:
>>> QPS615 switch needs to be configured after powering on and before
>>> PCIe link was up=2E
>>>=20
>>> As the PCIe controller driver already enables the PCIe link training
>>> at the host side, stop the link training=2E Otherwise the moment we tu=
rn
>>> on the switch it will participate in the link training and link may co=
me
>>> up before switch is configured through i2c=2E
>>>=20
>>> The device tree properties are parsed per node under pci-pci bridge in=
 the
>>> driver=2E Each node has unique bdf value in the reg property, driver
>>> uses this bdf to differentiate ports, as there are certain i2c writes =
to
>>> select particular port=2E
>>>=20
>>> Based up on dt property and port, qps615 is configured through i2c=2E
>>>=20
>>> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc=2Ecom>
>>> ---
>>>   drivers/pci/pwrctl/Kconfig             |   7 +
>>>   drivers/pci/pwrctl/Makefile            |   1 +
>>>   drivers/pci/pwrctl/pci-pwrctl-qps615=2Ec | 638 +++++++++++++++++++++=
++++++++++++
>>>   3 files changed, 646 insertions(+)
>>>=20
>>> diff --git a/drivers/pci/pwrctl/Kconfig b/drivers/pci/pwrctl/Kconfig
>>> index 54589bb2403b=2E=2E6a1352af918c 100644
>>> --- a/drivers/pci/pwrctl/Kconfig
>>> +++ b/drivers/pci/pwrctl/Kconfig
>>> @@ -10,3 +10,10 @@ config PCI_PWRCTL_PWRSEQ
>>>   	tristate
>>>   	select POWER_SEQUENCING
>>>   	select PCI_PWRCTL
>>> +
>>> +config PCI_PWRCTL_QPS615
>>> +	tristate "PCI Power Control driver for QPS615"
>>> +	select PCI_PWRCTL
>>> +	help
>>> +	  Say Y here to enable the pwrctl driver for Qualcomm
>>> +	  QPS615 PCIe switch=2E
>>> diff --git a/drivers/pci/pwrctl/Makefile b/drivers/pci/pwrctl/Makefile
>>> index d308aae4800c=2E=2Eac563a70c023 100644
>>> --- a/drivers/pci/pwrctl/Makefile
>>> +++ b/drivers/pci/pwrctl/Makefile
>>> @@ -4,3 +4,4 @@ obj-$(CONFIG_PCI_PWRCTL)		+=3D pci-pwrctl-core=2Eo
>>>   pci-pwrctl-core-y			:=3D core=2Eo
>>>     obj-$(CONFIG_PCI_PWRCTL_PWRSEQ)		+=3D pci-pwrctl-pwrseq=2Eo
>>> +obj-$(CONFIG_PCI_PWRCTL_QPS615)		+=3D pci-pwrctl-qps615=2Eo
>>> diff --git a/drivers/pci/pwrctl/pci-pwrctl-qps615=2Ec b/drivers/pci/pw=
rctl/pci-pwrctl-qps615=2Ec
>>> new file mode 100644
>>> index 000000000000=2E=2E9dabb82787d5
>>> --- /dev/null
>>> +++ b/drivers/pci/pwrctl/pci-pwrctl-qps615=2Ec
>>> @@ -0,0 +1,638 @@
>>> +// SPDX-License-Identifier: GPL-2=2E0-only
>>> +/*
>>> + * Copyright (c) 2024 Qualcomm Innovation Center, Inc=2E All rights r=
eserved=2E
>>> + */
>>> +
>>> +#include <linux/delay=2Eh>
>>> +#include <linux/device=2Eh>
>>> +#include <linux/firmware=2Eh>
>>> +#include <linux/i2c=2Eh>
>>> +#include <linux/mod_devicetable=2Eh>
>>> +#include <linux/module=2Eh>
>>> +#include <linux/of=2Eh>
>>> +#include <linux/pci=2Eh>
>>> +#include <linux/pci-pwrctl=2Eh>
>>> +#include <linux/platform_device=2Eh>
>>> +#include <linux/regulator/consumer=2Eh>
>>> +#include <linux/string=2Eh>
>>> +#include <linux/types=2Eh>
>>> +
>>> +#include "=2E=2E/pci=2Eh"
>>> +
>>> +#define QPS615_GPIO_CONFIG		0x801208
>>> +#define QPS615_RESET_GPIO		0x801210
>>> +
>>> +#define QPS615_BUS_CONTROL		0x801014
>>> +
>>> +#define QPS615_PORT_L0S_DELAY		0x82496c
>>> +#define QPS615_PORT_L1_DELAY		0x824970
>>> +
>>> +#define QPS615_EMBEDDED_ETH_DELAY	0x8200d8
>>> +#define QPS615_ETH_L1_DELAY_MASK	GENMASK(27, 18)
>>> +#define QPS615_ETH_L1_DELAY_VALUE(x)	FIELD_PREP(QPS615_ETH_L1_DELAY_M=
ASK, x)
>>> +#define QPS615_ETH_L0S_DELAY_MASK	GENMASK(17, 13)
>>> +#define QPS615_ETH_L0S_DELAY_VALUE(x)	FIELD_PREP(QPS615_ETH_L0S_DELAY=
_MASK, x)
>>> +
>>> +#define QPS615_NFTS_2_5_GT		0x824978
>>> +#define QPS615_NFTS_5_GT		0x82497c
>>> +
>>> +#define QPS615_PORT_LANE_ACCESS_ENABLE	0x828000
>>> +
>>> +#define QPS615_PHY_RATE_CHANGE_OVERRIDE	0x828040
>>> +#define QPS615_PHY_RATE_CHANGE		0x828050
>>> +
>>> +#define QPS615_TX_MARGIN		0x828234
>>> +
>>> +#define QPS615_DFE_ENABLE		0x828a04
>>> +#define QPS615_DFE_EQ0_MODE		0x828a08
>>> +#define QPS615_DFE_EQ1_MODE		0x828a0c
>>> +#define QPS615_DFE_EQ2_MODE		0x828a14
>>> +#define QPS615_DFE_PD_MASK		0x828254
>>> +
>>> +#define QPS615_PORT_SELECT		0x82c02c
>>> +#define QPS615_PORT_ACCESS_ENABLE	0x82c030
>>> +
>>> +#define QPS615_POWER_CONTROL		0x82b09c
>>> +#define QPS615_POWER_CONTROL_OVREN	0x82b2c8
>>> +
>>> +#define QPS615_AXI_CLK_FREQ_MHZ		125
>>> +
>>> +struct qps615_pwrctl_reg_setting {
>>> +	unsigned int offset;
>>> +	unsigned int val;
>>> +};
>>> +
>>> +struct qps615_pwrctl_bdf_info {
>>> +	u16 usp_bdf;
>>> +	u16 dsp1_bdf;
>>> +	u16 dsp2_bdf;
>>> +	u16 dsp3_bdf;
>>=20
>> Why are these values dynamic? Please use #define's for now=2E If there
>> ever comes a similar bridge, it most likely will have a different ports
>> configuration, so it will need additional changes anyway=2E
>>=20
>We added this for future use case only, we felt it is easier to support
>at the time if we add this way=2E

Please don't=2E You are hardcoding distinct roles into the structure that =
is supposed to be generic=2E Possible future use cases might have different=
 number of ports or different port roles=2E

>
>>> +};
>>> +
>>> +enum qps615_pwrctl_ports {
>>> +	QPS615_USP,
>>> +	QPS615_DSP1,
>>> +	QPS615_DSP2,
>>> +	QPS615_DSP3,
>>> +	QPS615_ETHERNET,
>>> +	QPS615_MAX
>>> +};
>>> +
>>> +struct qps615_pwrctl_cfg {
>>> +	u32 l0s_delay;
>>> +	u32 l1_delay;
>>> +	u32 tx_amp;
>>> +	u32 axi_freq;
>>> +	u8  nfts;
>>> +	bool disable_dfe;
>>> +	bool disable_port;
>>> +};
>>> +
>>> +#define QPS615_PWRCTL_MAX_SUPPLY	6
>>> +
>>> +struct qps615_pwrctl_ctx {
>>> +	struct regulator_bulk_data supplies[QPS615_PWRCTL_MAX_SUPPLY];
>>> +	const struct qps615_pwrctl_bdf_info *bdf;
>>> +	struct qps615_pwrctl_cfg cfg[QPS615_MAX];
>>> +	struct gpio_desc *reset_gpio;
>>> +	struct i2c_client *client;
>>> +	struct pci_pwrctl pwrctl;
>>> +	struct device_link *link;
>>> +};
>>> +
>>> +/*
>>> + * downstream port power off sequence, hardcoding the address
>>> + * as we don't know register names for these register offsets=2E
>>=20
>> It is hard to believe that Qualcomm engineers don't know register names
>> for the Qualcomm device=2E
>>=20
>The switch IP is from the another vendor and the vendor provided these
>settings=2E The databook doesn't have the register names in it=2E
>>> + */
>>> +static const struct qps615_pwrctl_reg_setting common_pwroff_seq[] =3D=
 {
>>> +	{0x82900c, 0x1},
>>> +	{0x829010, 0x1},
>>> +	{0x829018, 0x0},
>>> +	{0x829020, 0x1},
>>> +	{0x82902c, 0x1},
>>> +	{0x829030, 0x1},
>>> +	{0x82903c, 0x1},
>>> +	{0x829058, 0x0},
>>> +	{0x82905c, 0x1},
>>> +	{0x829060, 0x1},
>>> +	{0x8290cc, 0x1},
>>> +	{0x8290d0, 0x1},
>>> +	{0x8290d8, 0x1},
>>> +	{0x8290e0, 0x1},
>>> +	{0x8290e8, 0x1},
>>> +	{0x8290ec, 0x1},
>>> +	{0x8290f4, 0x1},
>>> +	{0x82910c, 0x1},
>>> +	{0x829110, 0x1},
>>> +	{0x829114, 0x1},
>>> +};
>>> +
>>> +static const struct qps615_pwrctl_reg_setting dsp1_pwroff_seq[] =3D {
>>> +	{QPS615_PORT_ACCESS_ENABLE, 0x2},
>>> +	{QPS615_PORT_LANE_ACCESS_ENABLE, 0x3},
>>> +	{QPS615_POWER_CONTROL, 0x014f4804},
>>> +	{QPS615_POWER_CONTROL_OVREN, 0x1},
>>> +	{QPS615_PORT_ACCESS_ENABLE, 0x4},
>>> +};
>>> +
>>> +static const struct qps615_pwrctl_reg_setting dsp2_pwroff_seq[] =3D {
>>> +	{QPS615_PORT_ACCESS_ENABLE, 0x8},
>>> +	{QPS615_PORT_LANE_ACCESS_ENABLE, 0x1},
>>> +	{QPS615_POWER_CONTROL, 0x014f4804},
>>> +	{QPS615_POWER_CONTROL_OVREN, 0x1},
>>> +	{QPS615_PORT_ACCESS_ENABLE, 0x8},
>>> +};
>>> +
>>> +static int qps615_pwrctl_i2c_write(struct i2c_client *client,
>>> +				   u32 reg_addr, u32 reg_val)
>>> +{
>>> +	struct i2c_msg msg;
>>> +	u8 msg_buf[7];
>>> +	int ret;
>>> +
>>> +	msg=2Eaddr =3D client->addr;
>>> +	msg=2Elen =3D 7;
>>> +	msg=2Eflags =3D 0;
>>> +
>>> +	/* Big Endian for reg addr */
>>> +	reg_addr =3D cpu_to_be32(reg_addr);
>>=20
>> This is incorrect=2E After cpu_to_be32() the value depends on the CPU
>> endianness=2E So reg_addr >> 8 will return different values for LE and =
BE
>> CPUs=2E
>> I had following impression
>If reg address is 0x828a0c in big endian sytem it will be 0c8a8200
>and in litte endian it will be 0x828a0c only=2E
>If cpu uses big endian cpu_to_be32 will not change this value
>and in little endian case cpu_to_be32 will convert 0x828a0c to 0c8a8200=
=2E
>
>Now the output is same for both the systems I tried to use
>(reg_addr >> 8) directly=2E
>
>Are you saying (reg_addr >> 8) output will be different based upon
>LE and BE ? If that is the case I will remove the conversions
>in next patch=2E

Reg address is always 0x00828a0c=2E Then on little-endian system you conve=
rt it to to BE32, which results in the value 0x0c8a8200=2E Finally you use =
shifts to get {0x82, 0x8a, 0x0c}, which is supposedly correct=2E=20

On big-endian system cpu_to_be32 returns the same value,  0x00828a0c, sinc=
e it is BE32 already=2E So after shifts msg_buf will get {0x8a, 0x82, 0x00}=
, which is obviously incorrect=2E

>>> +
>>> +	msg_buf[0] =3D (u8)(reg_addr >> 8);
>>> +	msg_buf[1] =3D (u8)(reg_addr >> 16);
>>> +	msg_buf[2] =3D (u8)(reg_addr >> 24);
>>> +
>>> +	/* Little Endian for reg val */
>>> +	reg_val =3D cpu_to_le32(reg_val);
>>> +
>>> +	msg_buf[3] =3D (u8)(reg_val);
>>> +	msg_buf[4] =3D (u8)(reg_val >> 8);
>>> +	msg_buf[5] =3D (u8)(reg_val >> 16);
>>> +	msg_buf[6] =3D (u8)(reg_val >> 24);
>>=20
>> Same issue here=2E
>>=20
>>> +
>>> +	msg=2Ebuf =3D msg_buf;
>>> +	ret =3D i2c_transfer(client->adapter, &msg, 1);
>>> +	return ret =3D=3D 1 ? 0 : ret;
>>> +}
>>> +
>>> +static int qps615_pwrctl_i2c_read(struct i2c_client *client,
>>> +				  u32 reg_addr, u32 *reg_val)
>>> +{
>>> +	struct i2c_msg msg[2];
>>> +	u8 wr_data[3];
>>> +	u32 rd_data;
>>> +	int ret;
>>> +
>>> +	msg[0]=2Eaddr =3D client->addr;
>>> +	msg[0]=2Elen =3D 3;
>>> +	msg[0]=2Eflags =3D 0;
>>> +
>>> +	/* Big Endian for reg addr */
>>> +	reg_addr =3D cpu_to_be32(reg_addr);
>>> +
>>> +	wr_data[0] =3D (u8)(reg_addr >> 8);
>>> +	wr_data[1] =3D (u8)(reg_addr >> 16);
>>> +	wr_data[2] =3D (u8)(reg_addr >> 24);
>>=20
>> And here=2E
>>=20
>>> +
>>> +	msg[0]=2Ebuf =3D wr_data;
>>> +
>>> +	msg[1]=2Eaddr =3D client->addr;
>>> +	msg[1]=2Elen =3D 4;
>>> +	msg[1]=2Eflags =3D I2C_M_RD;
>>> +
>>> +	msg[1]=2Ebuf =3D (u8 *)&rd_data;
>>> +
>>> +	ret =3D i2c_transfer(client->adapter, &msg[0], 2);
>>> +	if (ret =3D=3D 2) {
>>> +		*reg_val =3D le32_to_cpu(rd_data);
>>> +		return 0;
>>> +	}
>>> +
>>> +	/* If only one message successfully completed, return -ENODEV */
>>> +	return ret =3D=3D 1 ? -ENODEV : ret;
>>> +}
>>> +
>>> +static int qps615_pwrctl_i2c_bulk_write(struct i2c_client *client,
>>> +					const struct qps615_pwrctl_reg_setting *seq, int len)
>>> +{
>>> +	int ret, i;
>>> +
>>> +	for (i =3D 0; i < len; i++) {
>>> +		ret =3D qps615_pwrctl_i2c_write(client, seq[i]=2Eoffset, seq[i]=2Ev=
al);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>> +static int of_pci_get_bdf(struct device_node *np)
>>> +{
>>> +	u32 reg[5];
>>> +	int error;
>>> +
>>> +	error =3D of_property_read_u32_array(np, "reg", reg, ARRAY_SIZE(reg)=
);
>>=20
>> Please use of_property_read_u32_index() instead=2E
>>=20
>ack=2E
>>> +	if (error)
>>> +		return error;
>>> +
>>> +	return (reg[0] >> 8) & 0xffff;
>>> +}
>>> +
>>> +static int qps615_pwrctl_disable_port(struct qps615_pwrctl_ctx *ctx,
>>> +				      enum qps615_pwrctl_ports port)
>>> +{
>>> +	const struct qps615_pwrctl_reg_setting *seq;
>>> +	int ret, len;
>>> +
>>> +	seq =3D (port =3D=3D QPS615_DSP1) ? dsp1_pwroff_seq : dsp2_pwroff_se=
q;
>>> +	len =3D (port =3D=3D QPS615_DSP1) ? ARRAY_SIZE(dsp1_pwroff_seq) : AR=
RAY_SIZE(dsp2_pwroff_seq);
>>> +
>>> +	ret =3D qps615_pwrctl_i2c_bulk_write(ctx->client, seq, len);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return qps615_pwrctl_i2c_bulk_write(ctx->client,
>>> +					    common_pwroff_seq, ARRAY_SIZE(common_pwroff_seq));
>>> +}
>>> +
>>> +static int qps615_pwrctl_set_l0s_l1_entry_delay(struct qps615_pwrctl_=
ctx *ctx,
>>> +						enum qps615_pwrctl_ports port, bool is_l1, u32 ns)
>>> +{
>>> +	u32 rd_val, units;
>>> +	int ret;
>>> +
>>> +	/* convert to units of 256ns */
>>> +	units =3D ns / 256;
>>> +
>>> +	if (port =3D=3D QPS615_ETHERNET) {
>>> +		ret =3D qps615_pwrctl_i2c_read(ctx->client, QPS615_EMBEDDED_ETH_DEL=
AY, &rd_val);
>>> +		if (ret)
>>> +			return ret;
>>> +		rd_val =3D u32_replace_bits(rd_val, units,
>>> +					  is_l1 ?
>>> +					  QPS615_ETH_L1_DELAY_MASK : QPS615_ETH_L0S_DELAY_MASK);
>>> +		return qps615_pwrctl_i2c_write(ctx->client, QPS615_EMBEDDED_ETH_DEL=
AY, rd_val);
>>> +	}
>>> +
>>> +	ret =3D qps615_pwrctl_i2c_write(ctx->client, QPS615_PORT_SELECT, BIT=
(port));
>>> +	if (ret)
>>> +		return ret;
>>=20
>> What if there is a concurrent call? The port_select / write_value
>> statements should use a lock to remove the possible race condition=2E
>>=20
>There should not be any concurrent calls since all calls come from the
>probe itself=2E

Comment this in the driver, since somebody might decide to call the functi=
on later=20

>>> +
>>> +	return qps615_pwrctl_i2c_write(ctx->client,
>>> +				       is_l1 ? QPS615_PORT_L1_DELAY : QPS615_PORT_L0S_DELAY, unit=
s);
>>> +}
>>> +
>>> +static int qps615_pwrctl_set_tx_amplitude(struct qps615_pwrctl_ctx *c=
tx,
>>> +					  enum qps615_pwrctl_ports port, u32 amp)
>>> +{
>>> +	int port_access;
>>> +
>>> +	switch (port) {
>>> +	case QPS615_USP:
>>> +		port_access =3D 0x1;
>>> +		break;
>>> +	case QPS615_DSP1:
>>> +		port_access =3D 0x2;
>>> +		break;
>>> +	case QPS615_DSP2:
>>> +		port_access =3D 0x8;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	};
>>> +
>>> +	struct qps615_pwrctl_reg_setting tx_amp_seq[] =3D {
>>> +		{QPS615_PORT_ACCESS_ENABLE, port_access},
>>=20
>> Hmm, this looks like another port selection, so most likely it should
>> also be under the same lock=2E
>>=20
>>> +		{QPS615_PORT_LANE_ACCESS_ENABLE, 0x3},
>>> +		{QPS615_TX_MARGIN, amp},
>>> +	};
>>> +
>>> +	return qps615_pwrctl_i2c_bulk_write(ctx->client, tx_amp_seq, ARRAY_S=
IZE(tx_amp_seq));
>>> +}
>>> +
>>> +static int qps615_pwrctl_disable_dfe(struct qps615_pwrctl_ctx *ctx,
>>> +				     enum qps615_pwrctl_ports port)
>>> +{
>>> +	int port_access, lane_access =3D 0x3;
>>> +	u32 phy_rate =3D 0x21;
>>> +
>>> +	switch (port) {
>>> +	case QPS615_USP:
>>> +		phy_rate =3D 0x1;
>>> +		port_access =3D 0x1;
>>> +		break;
>>> +	case QPS615_DSP1:
>>> +		port_access =3D 0x2;
>>> +		break;
>>> +	case QPS615_DSP2:
>>> +		port_access =3D 0x8;
>>> +		lane_access =3D 0x1;
>>> +		break;
>>> +	default:
>>> +		return -EINVAL;
>>> +	};
>>> +
>>> +	struct qps615_pwrctl_reg_setting disable_dfe_seq[] =3D {
>>> +		{QPS615_PORT_ACCESS_ENABLE, port_access},
>>> +		{QPS615_PORT_LANE_ACCESS_ENABLE, lane_access},
>>> +		{QPS615_DFE_ENABLE, 0x0},
>>> +		{QPS615_DFE_EQ0_MODE, 0x411},
>>> +		{QPS615_DFE_EQ1_MODE, 0x11},
>>> +		{QPS615_DFE_EQ2_MODE, 0x11},
>>> +		{QPS615_DFE_PD_MASK, 0x7},
>>> +		{QPS615_PHY_RATE_CHANGE_OVERRIDE, 0x10},
>>> +		{QPS615_PHY_RATE_CHANGE, phy_rate},
>>> +		{QPS615_PHY_RATE_CHANGE, 0x0},
>>> +		{QPS615_PHY_RATE_CHANGE_OVERRIDE, 0x0},
>>> +
>>> +	};
>>> +
>>> +	return qps615_pwrctl_i2c_bulk_write(ctx->client,
>>> +					    disable_dfe_seq, ARRAY_SIZE(disable_dfe_seq));
>>> +}
>>> +
>>> +static int qps615_pwrctl_set_nfts(struct qps615_pwrctl_ctx *ctx,
>>> +				  enum qps615_pwrctl_ports port, u32 nfts)
>>> +{
>>> +	int ret;
>>> +	struct qps615_pwrctl_reg_setting nfts_seq[] =3D {
>>> +		{QPS615_NFTS_2_5_GT, nfts},
>>> +		{QPS615_NFTS_5_GT, nfts},
>>> +	};
>>> +
>>> +	ret =3D  qps615_pwrctl_i2c_write(ctx->client, QPS615_PORT_SELECT, BI=
T(port));
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return qps615_pwrctl_i2c_bulk_write(ctx->client, nfts_seq, ARRAY_SIZ=
E(nfts_seq));
>>> +}
>>> +
>>> +static int qps615_pwrctl_assert_deassert_reset(struct qps615_pwrctl_c=
tx *ctx, bool deassert)
>>> +{
>>> +	int ret, val =3D 0;
>>> +
>>> +	if (deassert)
>>> +		val =3D 0xc;
>>> +
>>> +	ret =3D qps615_pwrctl_i2c_write(ctx->client, QPS615_GPIO_CONFIG, 0xf=
ffffff3);
>>=20
>> It's a kind of magic
>>=20
>I will add a macro in next patch=2E
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	return qps615_pwrctl_i2c_write(ctx->client, QPS615_RESET_GPIO, val);
>>> +}
>>> +
>>> +static int qps615_pwrctl_parse_device_dt(struct qps615_pwrctl_ctx *ct=
x, struct device_node *node)
>>> +{
>>> +	enum qps615_pwrctl_ports port;
>>> +	struct qps615_pwrctl_cfg *cfg;
>>> +	struct device_node *np;
>>> +	int bdf, fun_no;
>>> +
>>> +	bdf =3D of_pci_get_bdf(node);
>>> +	if (bdf < 0) {
>>=20
>> This is incorrect, it will fail if at any point BDF uses the most
>> significant bit (which is permitted by the spec, if I'm not mistaken)=
=2E
>>=20
>As per the reg property as described in the binding document we are not
>expecting any change here=2E
>https://elixir=2Ebootlin=2Ecom/linux/v6=2E10=2E3/source/Documentation/dev=
icetree/bindings/pci/pci=2Etxt#L50=2E

What will this function return if the bus no is 256?

Also please either move the function to the generic PCI code is change its=
 name to match the rest of the driver=2E The of_pci_ prefix is reserved for=
 the generic code=2E


>>> +		dev_err(ctx->pwrctl=2Edev, "Getting BDF failed\n");
>>> +		return 0;
>>> +	}
>>> +
>>> +	fun_no =3D bdf & 0x7;
>>=20
>> I assume that ARI is not supported?
>>=20
>Yes this doesn't support ARI=2E
>>> +
>>> +	/* In multi function node, ignore function 1 node */
>>> +	if (of_pci_get_bdf(of_get_parent(node)) =3D=3D ctx->bdf->dsp3_bdf &&=
 !fun_no)
>>> +		port =3D QPS615_ETHERNET;
>>> +	else if (bdf =3D=3D ctx->bdf->usp_bdf)
>>> +		port =3D QPS615_USP;
>>=20
>> The function is being called for child device nodes=2E Thus upstream
>> facing port (I assume that this is what USP means) can not be enumerate=
d
>> in this way=2E
>Sorry, but I didn't your question=2E
>
>These settings will not affect the enumeration sequence these are
>for configuring ports only=2E

You are handling the case of bdf equal to the USP=2E Is it possible at all=
?


>>=20
>>> +	else if (bdf =3D=3D ctx->bdf->dsp1_bdf)
>>> +		port =3D QPS615_DSP1;
>>> +	else if (bdf =3D=3D ctx->bdf->dsp2_bdf)
>>> +		port =3D QPS615_DSP2;
>>> +	else if (bdf =3D=3D ctx->bdf->dsp3_bdf)
>>> +		port =3D QPS615_DSP3;
>>> +	else
>>> +		return 0;
>>=20
>> -EINVAL >
>There are can be nodes describing endpoints also,
>for those nodes bdf will not match and we are not
>returning since it is expected for endpoint nodes=2E

Which endpoints? Bindings don't describe them=2E


>
>>> +
>>> +	cfg =3D &ctx->cfg[port];
>>> +
>>> +	if (!of_device_is_available(node)) {
>>> +		cfg->disable_port =3D true;
>>> +		return 0;
>>> +	};
>>> +
>>> +	of_property_read_u32(node, "qcom,axi-clk-freq-hz", &cfg->axi_freq);
>>> +
>>> +	of_property_read_u32(node, "qcom,l0s-entry-delay-ns", &cfg->l0s_dela=
y);
>>> +
>>> +	of_property_read_u32(node, "qcom,l1-entry-delay-ns", &cfg->l1_delay)=
;
>>> +
>>> +	of_property_read_u32(node, "qcom,tx-amplitude-millivolt", &cfg->tx_a=
mp);
>>> +
>>> +	cfg->disable_dfe =3D of_property_read_bool(node, "qcom,no-dfe");
>>> +
>>> +	of_property_read_u8(node, "qcom,nfts", &cfg->nfts);
>>> +
>>> +	for_each_child_of_node(node, np)
>>> +		qps615_pwrctl_parse_device_dt(ctx, np);
>>> +
>>> +	of_node_put(np);
>>> +	return 0;
>>> +}
>>> +
>>> +static void qps615_pwrctl_power_off(struct qps615_pwrctl_ctx *ctx)
>>> +{
>>> +	gpiod_set_value(ctx->reset_gpio, 1);
>>> +
>>> +	regulator_bulk_disable(ARRAY_SIZE(ctx->supplies), ctx->supplies);
>>> +}
>>> +
>>> +static int qps615_pwrctl_power_on(struct qps615_pwrctl_ctx *ctx)
>>> +{
>>> +	struct qps615_pwrctl_cfg *cfg;
>>> +	int ret, i;
>>> +
>>> +	ret =3D regulator_bulk_enable(ARRAY_SIZE(ctx->supplies), ctx->suppli=
es);
>>> +	if (ret < 0)
>>> +		return dev_err_probe(ctx->pwrctl=2Edev, ret, "cannot enable regulat=
ors\n");
>>> +
>>> +	gpiod_set_value(ctx->reset_gpio, 0);
>>> +
>>> +	if (!ctx->client)
>>> +		return 0;
>>=20
>> really?
>>=20
>Even if we don't do i2c configuration PCIe enumeration will happen, for
>some reason i2c client is not found, driver ignores the error and return
>since basic functionality will work=2E

So what is the point of such misconfiguration? If "something works" even i=
n the default case, then we don't need this driver at all, do we?

Even worse=2E With the modular kernels you can not guarantee probe order=
=2E However the user expects that if the driver is probed, it has configure=
d the hardware correctly=2E=20

Linux has special return value for such cases, please return it instead if=
 0=2E


>>> +
>>> +	/*
>>> +	 * Don't have a way to see if the reset has completed=2E
>>> +	 * Wait for some time=2E
>>> +	 */
>>> +	usleep_range(1000, 1001);
>>> +
>>> +	ret =3D qps615_pwrctl_assert_deassert_reset(ctx, false);
>>> +	if (ret)
>>> +		goto out;
>>> +
>>> +	if (ctx->cfg[QPS615_USP]=2Eaxi_freq =3D=3D QPS615_AXI_CLK_FREQ_MHZ) =
{
>>> +		ret =3D qps615_pwrctl_i2c_write(ctx->client, QPS615_BUS_CONTROL, BI=
T(16));
>>> +		if (ret)
>>> +			dev_err(ctx->pwrctl=2Edev, "Setting axi clk freq failed %d\n", ret=
);
>>=20
>> AXI, not axi
>>=20
>ack=2E
>>> +	}
>>> +
>>> +	for (i =3D 0; i < QPS615_MAX; i++) {
>>> +		cfg =3D &ctx->cfg[i];
>>> +		if (cfg->disable_port) {
>>> +			ret =3D qps615_pwrctl_disable_port(ctx, i);
>>> +			if (ret) {
>>> +				dev_err(ctx->pwrctl=2Edev, "Disabling port failed\n");
>>> +				goto out;
>>> +			}
>>> +		}
>>> +
>>> +		if (cfg->l0s_delay) {
>>> +			ret =3D qps615_pwrctl_set_l0s_l1_entry_delay(ctx, i, false, cfg->l=
0s_delay);
>>> +			if (ret) {
>>> +				dev_err(ctx->pwrctl=2Edev, "Setting L0s entry delay failed\n");
>>> +				goto out;
>>> +			}
>>> +		}
>>> +
>>> +		if (cfg->l1_delay) {
>>> +			ret =3D qps615_pwrctl_set_l0s_l1_entry_delay(ctx, i, true, cfg->l1=
_delay);
>>> +			if (ret) {
>>> +				dev_err(ctx->pwrctl=2Edev, "Setting L1 entry delay failed\n");
>>> +				goto out;
>>> +			}
>>> +		}
>>> +
>>> +		if (cfg->tx_amp) {
>>> +			ret =3D qps615_pwrctl_set_tx_amplitude(ctx, i, cfg->tx_amp);
>>> +			if (ret) {
>>> +				dev_err(ctx->pwrctl=2Edev, "Setting Tx amplitube failed\n");
>>> +				goto out;
>>> +			}
>>> +		}
>>> +
>>> +		if (cfg->nfts) {
>>> +			ret =3D qps615_pwrctl_set_nfts(ctx, i, cfg->nfts);
>>> +			if (ret) {
>>> +				dev_err(ctx->pwrctl=2Edev, "Setting nfts failed\n");
>>> +				goto out;
>>> +			}
>>> +		}
>>> +
>>> +		if (cfg->disable_dfe) {
>>> +			ret =3D qps615_pwrctl_disable_dfe(ctx, i);
>>> +			if (ret) {
>>> +				dev_err(ctx->pwrctl=2Edev, "Disabling DFE failed\n");
>>> +				goto out;
>>> +			}
>>> +		}
>>> +	}
>>> +
>>> +	ret =3D qps615_pwrctl_assert_deassert_reset(ctx, true);
>>> +	if (!ret)
>>> +		return 0;
>>> +
>>> +out:
>>> +	qps615_pwrctl_power_off(ctx);
>>> +	return ret;
>>> +}
>>> +
>>> +static int qps615_pwrctl_probe(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev =3D &pdev->dev;
>>> +	struct pci_host_bridge *bridge;
>>> +	struct qps615_pwrctl_ctx *ctx;
>>> +	struct device_node *node;
>>> +	struct pci_bus *bus;
>>> +	int ret;
>>> +
>>> +	bus =3D pci_find_bus(of_get_pci_domain_nr(dev->parent->of_node), 0);
>>> +	if (!bus)
>>> +		return -ENODEV;
>>> +
>>> +	bridge =3D pci_find_host_bridge(bus);
>>> +
>>> +	ctx =3D devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
>>> +	if (!ctx)
>>> +		return -ENOMEM;
>>> +
>>> +	node =3D of_parse_phandle(pdev->dev=2Eof_node, "qcom,qps615-controll=
er", 0);
>>> +	if (node) {
>>=20
>> And if !node?
>>=20
>>> +		ctx->client =3D of_find_i2c_device_by_node(node);
>>=20
>> Leaks the reference count, see the comment at the function definition=
=2E
>> Also what if the I2C bus gets unbound? Will it crash the driver?
>>=20
>I will fix in next patch=2E
>
>Driver is not expected to crash when i2c bus gets unbound=2E
>It should be properly handled in i2c driver=2E

Please verify it=2E


>
>- Krishna Chaitanya=2E
>>> +		of_node_put(node);
>>> +		if (!ctx->client)
>>> +			return dev_err_probe(dev, -EPROBE_DEFER,
>>> +					     "failed to parse qcom,qps615-controller\n");
>>> +	}
>>> +
>>> +	ctx->bdf =3D of_device_get_match_data(dev);
>>> +	ctx->pwrctl=2Edev =3D dev;
>>> +
>>> +	ctx->supplies[0]=2Esupply =3D "vddc";
>>> +	ctx->supplies[1]=2Esupply =3D "vdd18";
>>> +	ctx->supplies[2]=2Esupply =3D "vdd09";
>>> +	ctx->supplies[3]=2Esupply =3D "vddio1";
>>> +	ctx->supplies[4]=2Esupply =3D "vddio2";
>>> +	ctx->supplies[5]=2Esupply =3D "vddio18";
>>> +	ret =3D devm_regulator_bulk_get(dev, ARRAY_SIZE(ctx->supplies), ctx-=
>supplies);
>>> +	if (ret)
>>> +		return dev_err_probe(dev, ret,
>>> +				     "failed to get supply regulator\n");
>>> +
>>> +	ctx->reset_gpio =3D devm_gpiod_get(dev, "reset", GPIOD_ASIS);
>>> +	if (IS_ERR(ctx->reset_gpio))
>>> +		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio), "failed to get =
reset GPIO\n");
>>> +
>>> +	ctx->link =3D device_link_add(&bridge->dev, dev, DL_FLAG_AUTOREMOVE_=
CONSUMER);
>>> +
>>> +	platform_set_drvdata(pdev, ctx);
>>> +
>>> +	qps615_pwrctl_parse_device_dt(ctx, pdev->dev=2Eof_node);
>>> +
>>> +	if (bridge->ops->stop_link)
>>> +		bridge->ops->stop_link(bus);
>>> +
>>> +	ret =3D qps615_pwrctl_power_on(ctx);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	if (bridge->ops->start_link) {
>>> +		ret =3D bridge->ops->start_link(bus);
>>> +		if (ret)
>>> +			return ret;
>>> +	}
>>> +
>>> +	return devm_pci_pwrctl_device_set_ready(dev, &ctx->pwrctl);
>>> +}
>>> +
>>> +static void qps615_pwrctl_remove(struct platform_device *pdev)
>>> +{
>>> +	struct device *dev =3D &pdev->dev;
>>> +	struct qps615_pwrctl_ctx *ctx =3D dev_get_drvdata(dev);
>>> +
>>> +	device_link_del(ctx->link);
>>> +	qps615_pwrctl_power_off(ctx);
>>> +}
>>> +
>>> +static const struct qps615_pwrctl_bdf_info bdf_info =3D {
>>> +	=2Eusp_bdf	=3D 0x100,
>>> +	=2Edsp1_bdf	=3D 0x208,
>>> +	=2Edsp2_bdf	=3D 0x210,
>>> +	=2Edsp3_bdf	=3D 0x218,
>>> +};
>>> +
>>> +static const struct of_device_id qps615_pwrctl_of_match[] =3D {
>>> +	{ =2Ecompatible =3D "pci1179,0623", =2Edata =3D &bdf_info },
>>> +	{ }
>>> +};
>>> +MODULE_DEVICE_TABLE(of, qps615_pwrctl_of_match);
>>> +
>>> +static struct platform_driver qps615_pwrctl_driver =3D {
>>> +	=2Edriver =3D {
>>> +		=2Ename =3D "pwrctl-qps615",
>>> +		=2Eof_match_table =3D qps615_pwrctl_of_match,
>>> +		=2Eprobe_type =3D PROBE_PREFER_ASYNCHRONOUS,
>>> +	},
>>> +	=2Eprobe =3D qps615_pwrctl_probe,
>>> +	=2Eremove_new =3D qps615_pwrctl_remove,
>>> +};
>>> +module_platform_driver(qps615_pwrctl_driver);
>>> +
>>> +MODULE_AUTHOR("Krishna chaitanya chundru <quic_krichai@quicinc=2Ecom>=
");
>>> +MODULE_DESCRIPTION("Qualcomm QPS615 power control driver");
>>> +MODULE_LICENSE("GPL");
>>>=20
>>> --=20
>>> 2=2E34=2E1
>>>=20
>>=20


--=20
With best wishes
Dmitry

