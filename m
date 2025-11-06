Return-Path: <linux-pci+bounces-40537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8190AC3D21D
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 20:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 295953B5B2C
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 19:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F6F24888A;
	Thu,  6 Nov 2025 19:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fMPtxfMw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFB138DF9
	for <linux-pci@vger.kernel.org>; Thu,  6 Nov 2025 19:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762455695; cv=none; b=WI3GoztU31UmWxfiIgulKa7b+rVnB7ghr+JNm2d5aqkVqmqDMPaytYA6wauvjlRF1R5KujThDJ+wtBDeEsCgyeeBAa1L4eQU7hMDVw6BAQUPHGtMoNMuSPXxoxJNp/f5/vmlca10CgTdeBSZbVrct/zp8DX58wqx5+g/rKK2m64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762455695; c=relaxed/simple;
	bh=rmBA/KK70v6rBVGjZpKXDIBM4WBJIcvL/O3YLKuQiHw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kB9SVYSz59zbkglvN0PyoqnGQaD45cpzoXUqpU3a9sgwOF3JcoCw4YBv5ylLNrPGmWAA88GiQ4lMUc/youUJPn3FdHeA+BszE8/h4DunQ85Qr6fj5BD5jNI4G60pDp7SHs5nDP7b5umFnmCh82EA7Fg7MJBxo+v37GmZIvh8lF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fMPtxfMw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640a3317b89so2035384a12.0
        for <linux-pci@vger.kernel.org>; Thu, 06 Nov 2025 11:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762455691; x=1763060491; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rmBA/KK70v6rBVGjZpKXDIBM4WBJIcvL/O3YLKuQiHw=;
        b=fMPtxfMw1sDTJuPyuizX5l8M0Z6htJ7vU+hSODoQVmY6J6B+PgW9X6FeQ5tPb3NYqp
         MOzzdNxDxrlW+ZTHveM7LJ0dMIVcQViyx7pZ9ETNLxHZAur3T9w23SOo4bgFxy55/0kU
         xU6nF6LBvAngqyuUMU4d1hl6bxY/WJEX4D4iv1vWXHplUj/nNCrRoRfIkhbo5GADSCuv
         DKNbnhAG8geI6RIqptVXtSmHkQxzJvlXevnE3sWHxb/xcsE0SuTR/AOR3XApVIUfL5PB
         bIaMmH6y2YvY0ZoT4RUHOAtSo4LkNyvQtWcseqIJS6LFH5ap/y1JnknbQJb3BI+L3lgP
         EfoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762455691; x=1763060491;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmBA/KK70v6rBVGjZpKXDIBM4WBJIcvL/O3YLKuQiHw=;
        b=j/VKeGWIYkE7njFTdWmkqRQEg05noSAICNEaRar1fKCQWlDgOyQHdKo2Empk74Mn6b
         lc3pURVUdJg6xrErPo2B1uB+ueHWlXctVTO3ZyFpHug7R7/qkO2chB32A7E9GNbHhGA0
         2e766LxN9rzmj+DVhC1bzt+CkwEiOnje9YDsrwGCVevEcJ3mhH/6BEG8kHpg9QDdmdhh
         V/Gj7T32MpVtdydQYP2Or+WObkJHPnZupriPDQt5OUMU53NhqibHUxl35UefigZn5tZ/
         bWOAhOZrZERBk7NaHi8D6bnq6MZdsoHekquRZ5W2TEOBZTzAERUHG0ZeSD6qdKRNnssE
         ZUgQ==
X-Forwarded-Encrypted: i=1; AJvYcCVi6iG2bYVUYlY2ICGP+cXqFWTKSeSZmG+3mbqfUZ+wQcNbFhu6lbBGuWka54v3MpXYmSAQoZ1YTZ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygxVadL1KOsDrgjfidRkZKvOZE3zwy79Czb4c9pDbN/izNhXVe
	5yJNs9dF/BQqoKFkVZVyNu91vkWKJ+UaDDYamZbmJsmKBiLfj048wdhDgKRLo6dBOjiHRbWEvbE
	EvXAA17e5/5f4aAMTFS/EhZSRIdpVWSaCUnOi
X-Gm-Gg: ASbGncsmb14NOPppJJjbzY4geNb8p1OWPINfx/cScn3PSgnCSBiTOk8NBTPU13UQnVZ
	5aB2oGGNcjSmTDBxt4mDbV2v33k8D5w7brvR1a4GohCIeJB8H64PVS2xa8bDefjfh5g4RqaU7Wr
	1ObE87LSFGY3Mw2my4pMNUuJBQFHRSyTzQoR+5T8iNY6r7GIfLt3SJCbLWg5LAGuUMxLU2Uirko
	onuAK3WnWrmTU45c4h8PXcpGxEBPtXu3NCOEwxLVobDRRMbIFbFQz+ZABg=
X-Google-Smtp-Source: AGHT+IH+Y4Mu5BYHnpAhpDDYEu9pnY0g5fsOj+T+jrFEJrqRN2a3pdfy5tPNDE4xFkznVewhY7OLbh6GTw5tCYHmiBc=
X-Received: by 2002:a05:6402:26c8:b0:634:ce70:7c5 with SMTP id
 4fb4d7f45d1cf-6413f063506mr466646a12.17.1762455690583; Thu, 06 Nov 2025
 11:01:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251029-rockchip-pcie-system-suspend-v4-0-ce2e1b0692d2@collabora.com>
 <cf6zumlp4iiltglu7bbrpdeysaznrkyvlemwl4lxwkfjkgux7a@wl37bxilsprx> <cbvcjgcd7saxj42ifgqn3l6mwpgenlhbr4zuf5ibqbtj6rmzqh@yuc7flbwyi2y>
In-Reply-To: <cbvcjgcd7saxj42ifgqn3l6mwpgenlhbr4zuf5ibqbtj6rmzqh@yuc7flbwyi2y>
From: Anand Moon <linux.amoon@gmail.com>
Date: Fri, 7 Nov 2025 00:31:12 +0530
X-Gm-Features: AWmQ_bnqyEL1PybATXbJIxvw3HT9eVFRywU_mWpf-A2S9gMDT2HPtzblvdFHBN0
Message-ID: <CANAwSgSvtc57kh-VJewk5=_MvfL3KVxNFU8C+tGh4iqJhnEVtw@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] PCI: dw-rockchip: add system suspend support
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jingoo Han <jingoohan1@gmail.com>, 
	Shawn Lin <shawn.lin@rock-chips.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	linux-kernel@vger.kernel.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"

Hi Sebastian,

On Tue, 4 Nov 2025 at 00:29, Sebastian Reichel
<sebastian.reichel@collabora.com> wrote:
>
> Hi,
>
> On Sat, Nov 01, 2025 at 07:29:41PM +0530, Manivannan Sadhasivam wrote:
> > On Wed, Oct 29, 2025 at 06:56:39PM +0100, Sebastian Reichel wrote:
> > > I've recently been working on fixing up at least basic system suspend
> > > support on the Rockchip RK3576 platform. Currently the biggest open
> > > issue is missing support in the PCIe driver. This series is a follow-up
> > > for Shawn Lin's series with feedback from Niklas Cassel and Manivannan
> > > Sadhasivam being handled as well as some of my own changes fixing up
> > > things I noticed.
> > >
> > > In opposite to Shawn Lin I did not test with different peripherals as my
> > > main goal is getting basic suspend to ram working in the first place.
> >
> > Wouldn't it break users who have connected endpoint devices and suspend their
> > platform? I don't want to have an untested feature that could potentially cause
> > regressions, just for the sake of getting basic system PM.
> >
> > But if your goal is to just add basic system PM operations for CI
> > testing, then I would suggest you to do something minimal in the
> > suspend/resume path that don't disrupt the operation of a device.
> >
> > But this also should be tested with some devices for sanity.
>
> My goal is proper system PM support, but I would like to go step by
> step. Right now system suspend on the Rockchip RK3576 EVB just hangs
> the board and it has to be power cycled afterwards. In parallel to
> this series I've send a bunch of fixes to get it working. It surely
> isn't perfect, but I fear things regressing again in other areas while
> the complex PCIe system sleep is being worked on - simply blocking system
> suspend is not very helpful, since it effectively hides suspend problems.
>
As per my understanding, the current DTS configuration is missing definitions
for critical PCIe power management GPIOs (clkreq-gpios, perst-gpios, wake-gpios)

clkreq-gpios, such as PCIE30x1_0_CLKREQn_M1_L (not sure if it is used ?)
perst-gpios such as PCIE30x1_0_PERSTn_M1_L
wake-gpios, such as PCIE30x1_0_WAKEn_M1_L.

However, the RK3588 TRM indicates that these power management functions
can be controlled programmatically using specific memory-mapped registers:

The PCIE_CLIENT_POWER_CON register at 0x002C provides comprehensive
power management controls, including link-state management, wake-up
event handling,
and clock management.

In PHY GRF, we have the PCIe3PHY_GRF_PHY0_LN0_CON0 register at 0x1000 allows
direct control over the PHY's power state (P-states like P1, P2),
enabling transitions into
deep suspend (L2/L3) via register writes
clkreq_n Clock request for lane X. This is a side-band signal that a
PIPE 4.2 controller needs
to enter and exit P1.CPM, P1.1, and P1.2 power states.

My thought is that using rockchip_pcie_phy_deinit() in the suspend
routine and rockchip_pcie_phy_init() in the resume routine are
incorrect; these functions
likely perform full resets or power cuts rather than managed power
state transitions,
thus disrupting the desired suspended state of the PCIe link

I tried a few things on my own, but I am not moving forward.

Thanks
-Anand

