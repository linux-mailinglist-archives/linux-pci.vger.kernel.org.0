Return-Path: <linux-pci+bounces-19316-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3202EA01B30
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 18:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C93C83A3725
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jan 2025 17:46:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93CF01C07EE;
	Sun,  5 Jan 2025 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3ThokDs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2266E1B6CF6;
	Sun,  5 Jan 2025 17:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736099204; cv=none; b=potIr6nuMa0aDdI9CD0kmzHzWlBcOcqlx3vLjEX992mTNbi1yMuZ6o2ETCwVfOjGUlHjzCHbGyNYglhCK9Bi2F6RjZNUzLkgbEpLC/Q0jqVKHkPkVf+bsd9BWVbPkp+vDZBaehS+9jffpoGf4CYiffRJqR1DdDhgodBnNn8U/cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736099204; c=relaxed/simple;
	bh=/zpvxpfMwkglqz8JViS25fPZYPSkhuBJB761y02nWic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pa1SnfJEjBVZBruTnx0/L4TEIEyo1LrmIYQDeZSxdRjB4RDdpuUCcA9rogxwt3SaLuETCmme/z8w70wT2tLR0xmYarh0LLvVkdIHW/QSEl3t7NkE+fxFC6Nhkcz0l+3orp0eVBKlpVOa5suH7e7vpwMFhUSNT5xg7QzSCJuFbJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3ThokDs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5d3f65844deso23362783a12.0;
        Sun, 05 Jan 2025 09:46:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736099199; x=1736703999; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s/vG553TVWbrvDJ8ib/SgrZyZa0BMl1m3x5rzTpMHdQ=;
        b=A3ThokDsG/Ynqtw7NIKeZu/8jt601fDYtMAphAV2M6Jk76zT7LXDHr9TjCN/lrLEvS
         bksamwuPHxYdFL9C9EeGSbaATBQUq7Ub2j0JD0kT1ncHo7kW9ENHcbDOkZBuno05EsxI
         74OVqajj6XAycRRN4VPoyOta2DMHXlW/PAPAhiFKrPDe4Vl7Ivb78YkSk79xpgxJ0XKo
         cskbP8RoVoGiO7uGoTR6ng8NnkbiFt5aBU0HAR2BtPvApZFUTJ+dq4iuCvkhKDynEVu3
         MMG/8cTK+qUWp47za0ZF9IT2W1K7/Q+rCQCgAYJQLs5YCw89CKhSzCmOK4T48cxA+UUP
         2llQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736099199; x=1736703999;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/vG553TVWbrvDJ8ib/SgrZyZa0BMl1m3x5rzTpMHdQ=;
        b=Z3nA2dPeCwgley8kT26xfD2izqKTecYq59Ly/gRrq/sNncfQzuMXIyigHY/Iufvlf0
         12YimtzrK0CmEZxTxpxTMySquh5PyX0t4u6YvPELpwzAWIxldDRKnk39nr/AMMAruv9j
         C2wBzwVAKoe/tJpp9L2JEMmbK7w78gxyDovxygEA+Dqrg069QWaB6jlhpZqQxQjv6W7H
         lb70al6/+8xFXyvXmt/OpFINev6ecp8SRLlOMxd2TbfQmLWvu08N8KoMubKAHJ4hRZgW
         R0f6plmY/iBvQXCcqDGOTb95tz5UXP0gC568h+130nU+E+kEwDO6S0PzbsResiep9trj
         UtIw==
X-Forwarded-Encrypted: i=1; AJvYcCUh7Tyk+pNVQqkAfI/IYd64TN5j3NSgW+CaucSwojY3QgcdVf9AMWoeWHFl0zeZib9t+AAiZb3ltEvO@vger.kernel.org, AJvYcCW8AnGC2G7vNwS5KCtJD6SbffJdEtpt3Noy0qyaKZwvMKRWQzFGvdmkKGelOsjsbdLf36zkKWWI6o3dQUo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0/izvpqiBXy5ALzuc0Jx7V9PZirD5qNlESaRrXvXC5xfDhtoI
	1zOb0kI0Gnxppd3xGYdmbCmECAjZgJCbhsKtUvjqit7YpLJIvOg14XEilUxqZ0+2UCDoFHpj6mx
	wd8dk2/I1wMqvtVt3vwplk/MCB+0=
X-Gm-Gg: ASbGnctlUr6hEVb3/u4NDzdH3zBAm+SyFCy/etyZQLZs3RcqOElcmoPSJyDORbd50zS
	zZvJqNdKwvQZ9Oi2vK6MkNEsfKdjEEA7mMaZTzg==
X-Google-Smtp-Source: AGHT+IEeKTjZBx1EU+2eWZsG1Eb2WFMVN8CzIVSiSTqFzujvDjxi/Q2sGrpxzUgGfRYUHTXNMaNmc2n2wDs4vWtTX9A=
X-Received: by 2002:a05:6402:26d1:b0:5d3:e45d:ba91 with SMTP id
 4fb4d7f45d1cf-5d81de39850mr52109480a12.32.1736099198841; Sun, 05 Jan 2025
 09:46:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809073610.2517-1-linux.amoon@gmail.com> <Z3fKkTSFFcU9gQLg@ryzen>
 <CANAwSgS5ZWGTP+A11r_qFSrjWZH_DqsM89MLiP+1VAxhz+e+2A@mail.gmail.com> <5a3e8fda-f9e4-4c2f-847b-93f521b8313b@lunn.ch>
In-Reply-To: <5a3e8fda-f9e4-4c2f-847b-93f521b8313b@lunn.ch>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 5 Jan 2025 23:16:21 +0530
Message-ID: <CANAwSgSUuEvJb2Vn58o0i7Soo3jGzM8EYHvDtUTPxRHekCpruA@mail.gmail.com>
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

On Fri, 3 Jan 2025 at 21:34, Andrew Lunn <andrew@lunn.ch> wrote:
>
> > +&gmac1 {
> > +       clock_in_out = "output";
> > +       phy-handle = <&rgmii_phy1>;
> > +       phy-mode = "rgmii";
>
> rgmii is wrong. Please search the archives about this topic, it comes
> up every month. You need to remove the tx_delay and rx_delay
> properties, and use rgmii-id.
>
According to the RKRK3588 TRM-Part1 (section 25.6.11 Clock
Architecture), in RGMII mode,
the TX clock source is exclusively derived from the CRU (Clock Request Unit).
To dynamically adjust the timing alignment between TX/RX clocks and
data, delay lines are
integrated into both the TX and RX clock paths.

Register SYS_GRF_SOC_CON7[5:2] enables these delay lines,
while registers SYS_GRF_SOC_CON8[15:0] and SYS_GRF_SOC_CON9[15:0]
are used to configure the delay length for each path respectively.
Each delay line comprises 200 individual delay elements.

Therefore, it is necessary to configure both TX and RX delay values
appropriately
with phy-mode set as rgmii.

[1[ https://github.com/torvalds/linux/blob/master/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c#L1889-L1914

I have gone through a few of the archives about this topic

[2] https://lore.kernel.org/linux-rockchip/4fdcb631-16cd-d5f1-e2be-19ecedb436eb@linaro.org/T/

Thanks
-Anand

