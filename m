Return-Path: <linux-pci+bounces-19321-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DDDA02021
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 08:58:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D74371880338
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 07:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB92D1D63C7;
	Mon,  6 Jan 2025 07:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjVznEXG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043241D63FD;
	Mon,  6 Jan 2025 07:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736150327; cv=none; b=aphgLDwCs0RFyVqKik+eNFRudP9QDXdDPWITM5PFuMuY1pfv4+rPZdKyYDedrJ0ooIVYzGe22PafodAxorLmhoGyNAATBW4HLIqrbZn2nQMCStepm8LAde/BRYOkbPMtalXLoLqDbb0EcHDEhuBcyT47lPklfkJV5lZ/COecvpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736150327; c=relaxed/simple;
	bh=geQjC9BBt4PKYJpr+J+JQ5pwhe/mKAm8zUC8rwtwiQI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=exgjOohxCC8zynymECBsi9l5maYu8Ip4x3EzYbFLo2yapUUdi8okBpEhaFH2wTFYTFUYu2O1G3D/D7qGAUXAMchuqPTEw5v7Cl77fP0vYF9RIvsZiKcyNyzRUC7mtVp88EJi3PNWL7vD22wUymQSjXlL+dS/YpqIpRHoOq6rE24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjVznEXG; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5d3bbb0f09dso24812111a12.2;
        Sun, 05 Jan 2025 23:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736150324; x=1736755124; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/ZvKVkZErI5WQej5yg5jmmMF2hraK2A7CaX2pm18nzw=;
        b=EjVznEXG4RHTsCbqbemSqKdHl8DEQfBdGhkeQs1PMqxyrcNagbhuSqv9oEv6I4l7kv
         nEP+0W76hIqUVtj8oE/wdVunvhJQlha2+LJPyMJpg7BZP+3lJZf0HVzVaATc6YrBWynK
         3tbzbmL0BFgmXY+EvEAfCMQABGClNPd44twXbLvZJ1LQQ2J5zNprm4G8cR9/VjVHgIdX
         gmNbjjypmafizSRmJok8jzHopRddYmK3ZFxbuAcg9lIQiq/Eh9BOA39X5+Q93WBoTFru
         2ZuEUnQ0BYSIyy7SWyaggStbdoRvyhrT3gW/APEa00X0E7RrV5ZzbK20Yrgwxb/lSSs5
         0ETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736150324; x=1736755124;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/ZvKVkZErI5WQej5yg5jmmMF2hraK2A7CaX2pm18nzw=;
        b=Kr1BzFlV9E3njZUu1GQW/lautSvVmIxJAxUzrAk60A/TFhgPjIVbIvHuZ3/S7XTxLx
         uXH8NIfj3rWBD/Q+nqc4aTxVSP6h3Sje/Uc3psZVzo9QGSZfSnFtODTkbSbTLASU1xta
         W2bz+Aml3Vyv9pXYXww8TaAOR9EiRf+i2wMn7ooaLyDEgT6meCFH8W7cBdFZhl0g48dS
         M8hcwianVy7+I50m6RS2RXndUy8vlknl/4nJnXXMHZeoLOfUJzyVmLfAx3q7nnpU3V7B
         3VaLnxssMy5VcOIRrUjh4EfbZ6EqH/zOWRvKeascahHFlG0uhZ4qfPo1ca45dgTexLAY
         nrOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUlS0D2K1ROOkOtmYPKO8Ed8zeNZhPNv+j5tUGZmoPgI4VZ9pKQkwyQFiMp7xRyoYlrEkFqGkIA8i2Kovg=@vger.kernel.org, AJvYcCXMRzM/OGvkTGqyfPetcEHLZxqJg2hvmZ9iTMCGnfF0B2O4sh99exxjfMMFs6/ItHID1mFEMB8pii4P@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3Y20oHJcn1nUL7uZhg4TUEFkqnH/vjxEEWyT2YOUUMmZgpyth
	+3qEsq8N8zrnuo/PUCdRPtDfh8KgoIgjoMpSMoMcmgPmC/mNH6S78ZatBj7dY/gTaFHXqDfi1iN
	mXytlxPPM04pzNZ037VBek7kpcvhgXqugi80=
X-Gm-Gg: ASbGncvvdK5gLdRPHHTUWF/FGo8o931pMvkO+MmXbcMD5cmgxHAlHnMxh2tMqkyu74b
	23B3BRfl/NERcPRhv+Hk82qv2kt+QcJ2kf+aNYA==
X-Google-Smtp-Source: AGHT+IE5v5b24wHn+0AkgjrpnUGIFScwTNQZ1ekJTkcZg8nPK6eicHO3oCMGwPCrZi0JaC/+N7r52oVIeZuqe2Uy3yE=
X-Received: by 2002:a05:6402:524b:b0:5d0:bf27:ef8a with SMTP id
 4fb4d7f45d1cf-5d81de48bd1mr48949004a12.26.1736150323689; Sun, 05 Jan 2025
 23:58:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809073610.2517-1-linux.amoon@gmail.com> <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com>
 <5a3e8fda-f9e4-4c2f-847b-93f521b8313b@lunn.ch> <CANAwSgSUuEvJb2Vn58o0i7Soo3jGzM8EYHvDtUTPxRHekCpruA@mail.gmail.com>
 <c94570db-c0af-4d92-935c-5cc242356818@lunn.ch>
In-Reply-To: <c94570db-c0af-4d92-935c-5cc242356818@lunn.ch>
From: Anand Moon <linux.amoon@gmail.com>
Date: Mon, 6 Jan 2025 13:28:27 +0530
Message-ID: <CANAwSgQ_gojVxvi_OyHTyTSdzRrno=Yymn0AdEXyTHTgDTyFcA@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Enable async probe by default
To: Andrew Lunn <andrew@lunn.ch>
Cc: Niklas Cassel <cassel@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Andrew,

On Sun, 5 Jan 2025 at 23:27, Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Sun, Jan 05, 2025 at 11:16:21PM +0530, Anand Moon wrote:
> > Hi Andrew,
> >
> > On Fri, 3 Jan 2025 at 21:34, Andrew Lunn <andrew@lunn.ch> wrote:
> > >
> > > > +&gmac1 {
> > > > +       clock_in_out = "output";
> > > > +       phy-handle = <&rgmii_phy1>;
> > > > +       phy-mode = "rgmii";
> > >
> > > rgmii is wrong. Please search the archives about this topic, it comes
> > > up every month. You need to remove the tx_delay and rx_delay
> > > properties, and use rgmii-id.
> > >
> > According to the RKRK3588 TRM-Part1 (section 25.6.11 Clock
> > Architecture), in RGMII mode,
> > the TX clock source is exclusively derived from the CRU (Clock Request Unit).
> > To dynamically adjust the timing alignment between TX/RX clocks and
> > data, delay lines are
> > integrated into both the TX and RX clock paths.
> >
> > Register SYS_GRF_SOC_CON7[5:2] enables these delay lines,
> > while registers SYS_GRF_SOC_CON8[15:0] and SYS_GRF_SOC_CON9[15:0]
> > are used to configure the delay length for each path respectively.
> > Each delay line comprises 200 individual delay elements.
> >
> > Therefore, it is necessary to configure both TX and RX delay values
> > appropriately
> > with phy-mode set as rgmii.
> >
> > [1[ https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c#L1889-L1914
> >
> > I have gone through a few of the archives about this topic
> >
> > [2] https://lore.kernel.org/linux-rockchip/4fdcb631-16cd-d5f1-e2be-19ecedb436eb@linaro.org/T/
>
> O.K, let me repeat what i have said a number of times over the last
> couple of years.
>
> phy-mode = "rgmii" means the PCB has extra long clock lines on the
> PCB, so the 2ns delay is provided by them.
>
> phy-mode = "rgmii-id" means the MAC/PHY pair need to arrange to add
> the 2ns delay. As far as the DT binding is concerned, it does not
> matter which of the two does the delay. However, there is a convention
> that the PHY adds the delay, if possible.
>
> So, does your PCB have extra long clock lines?
>
> Vendors often just hack until it works. But works does not mean
> correct. I try to review as many .dts files as i can, but some do get
> passed me, so there are plenty of bad examples in mainline.
>
>         Andrew

Thanks for this tip, I am no expert in hardware design.

Here is the schematic design of the board, it looks like RTL8125B page 24
is controlled by a PCIe 2.0 bus

[0] https://dl.radxa.com/rock5/5b/docs/hw/radxa_rock5b_v13_sch.pdf

PERSTB              ---<< PCIE_PERST_L (GPIO3_B0_u)
LANWAKER        --->> PCIE20_1_2_WAKEn_M1_L (GPIO3_D0_u)
LAN_CLKREQB  --->> PCIE20_1_2_CLKREQn_M1_L( GPIO3_C7_u)
IOLATEB             --->> +V3P3A

PCIE2.0 DATA Impedance 85 R

PCIE_WLAN_TX_C_DP  ----->PCIE20_0_TXP
PCIE_WLAN_TX_C_DN  ----->PCIE20_0_TXN

PCIE2.0 CLK Impedance 100 R

PCIE3_WLAN_REFCLK0_DP --> PCIE20_0_REFCLKP
PCIE3_WLAN_REFCLK0_DN--->PCIE20_0_REFCLKN

I have no idea about the grf clk and data path delay over here.

Thanks
-Anand

