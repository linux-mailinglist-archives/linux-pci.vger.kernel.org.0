Return-Path: <linux-pci+bounces-31144-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A245AEF037
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 09:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 711363A7C60
	for <lists+linux-pci@lfdr.de>; Tue,  1 Jul 2025 07:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A471E51F6;
	Tue,  1 Jul 2025 07:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UhACgBF4"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F7238B
	for <linux-pci@vger.kernel.org>; Tue,  1 Jul 2025 07:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356511; cv=none; b=I2jHLr+yRH6zz/o/vvmJsqFwyaqBWYgqcJWesQp+yuHjBsnxZhIqIcv8Rr73uRolVpcntgIK3VO4RbYNvRrKnJeU+yRem9l/PHbq+mwBHiJ5GBwPCLwprF4QD09ZPLFcSA9rOPEsGCwxnIYhbaqB1+aszbM3wGbC7xuEt48tIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356511; c=relaxed/simple;
	bh=jFA2Vl0jPD75ev7E43ytDZByT+SH8CFGnuV65782Ojw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=AWhpipPmhm1Ou35arz90ke+HVhbloCMCKKtxAmx/W932Ug/j0iIwHetr4EOgDI4cVnGuACDVqC5bTLJkzkpzH9/5A3hCRDo27eIodrfHkkmxpDQY+UACzOjx6T/rF1IKgzXzB5rhw3Z0N0QwY0qpGiw9xJRM1iIuVnUqiZLRHeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UhACgBF4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1751356508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eHdMzgFfQJGJTVG/4M9MM8/CUYx5m9feJxrpAo8o1hk=;
	b=UhACgBF46x0muBuwgZ+HkvZBwVe8q3+TuQAlN8mhF8k9eV0jWiLR5KyaSa88YMN3itytZb
	mwp+sP9hR96/K8Du2EQAhq/ukkf9kQ8rCvisZJV9MerXzM+48LjiwVDI72pg4tN3xEZVMo
	mDsn8hTJMB9RN0LGDN+E6HhbuThn6GE=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-D5NwEIq9MBqNWfnFM9Dv1g-1; Tue, 01 Jul 2025 03:55:07 -0400
X-MC-Unique: D5NwEIq9MBqNWfnFM9Dv1g-1
X-Mimecast-MFC-AGG-ID: D5NwEIq9MBqNWfnFM9Dv1g_1751356507
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-74913385dd8so5158242b3a.0
        for <linux-pci@vger.kernel.org>; Tue, 01 Jul 2025 00:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751356506; x=1751961306;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eHdMzgFfQJGJTVG/4M9MM8/CUYx5m9feJxrpAo8o1hk=;
        b=MKpPRsmjuXGB565XJwfC8AgqIsx4cZ5c3Y1gFKzp2/eCXfu008ng60XFXz/ECotg9h
         QV4CQOvU90LIVK8yOZyReU5W0R7DDrzcAQxwXvv1UAGzRQxsRFbl3NO/24jyr7dwvW8l
         nbklMtq4WTGMb63QIRbtbNy2+p6XGrqTMQYO6JuxIIZhA87wjUpSVmBh6S3IIXeLUAki
         oMwEqiuuulExVccNCuRPMX/fOPPvVvKbsDmq2Xl2/8zDOcsJfLdd6jFr2x/6R/ukC3E7
         mh8yoC2wlxej8te4eFYtQy8pRhCvnLyVcZ0mR7XKR07lR4b9hvCGjkpbKb+DfkQsWXnL
         7NiA==
X-Forwarded-Encrypted: i=1; AJvYcCWwGQ1F/welppZdRs/o9rQkn+mCdMzAvTVFnrua5JdSCGVAiTr8OpdrZcQqPm8BWUn7JwWmeTK286c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxC47U7IaiRTdSuBos3hDddLrAuvVFcaNisX1bnlWQd5cuEHG+g
	qhY1H8LJBfZvrX2IreZoZW5RxafhDAWXkgc1OQKgXnYPI22JoBfG45yvnt1OUd4vLUjQzlIudHf
	2cUlOiCTLBy525PSpK2iDSJwX2fmN06VkKTbTpLTyEugOvUxtHNxXyORUi7T0Qw==
X-Gm-Gg: ASbGnctl0TV1K8YcXEaV4XG2O9l11mJm2MBLBn1VVDM5AbJjPuqQse0e4xd02EoDlFc
	rcHy0O49B+hoYEBoSq6UAweeMbPYFEMy+EHPuA0o/jjeTRVxAYfmb05x8arAssl/WmzSZtcw/PU
	tYbIwYmlk8jhZiZ5DpIW5sn9QiZsIvY+ooloYPcLEGFoYvlVGQy4Rv4reM7061SXEGmZVrGUDYu
	zpH3SL3fAnNRFzRgnw00pF0RfzC/lY7BErYouP7Q1Xbdt50dHo4Tb4gmr6/sKXVY4tEPtflQmO9
	9k+vd2d7pbg0fBk0uchfWlJ2O8b6wcsh2wmQ/BvMtCc0Bgtu
X-Received: by 2002:a05:6a00:1495:b0:736:5c8e:baaa with SMTP id d2e1a72fcca58-74af6ebdffdmr22051634b3a.2.1751356506618;
        Tue, 01 Jul 2025 00:55:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHLLY/eKZv2t5yuLjLiXwRD/wN1GO4pT44DogAvkkhU/DiOVmH3mQAj6VLHh0UEaPV5yfZWTg==
X-Received: by 2002:a05:6a00:1495:b0:736:5c8e:baaa with SMTP id d2e1a72fcca58-74af6ebdffdmr22051587b3a.2.1751356506152;
        Tue, 01 Jul 2025 00:55:06 -0700 (PDT)
Received: from [10.200.68.91] (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af557439csm11016401b3a.80.2025.07.01.00.54.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 00:55:05 -0700 (PDT)
Message-ID: <ce0fdbf2753075056c227ce7567a69386a5aa0a3.camel@redhat.com>
Subject: Re: [RESEND PATCH v9 1/4] PCI: rockchip: Use standard PCIe defines
From: Philipp Stanner <pstanner@redhat.com>
To: Geraldo Nascimento <geraldogabriel@gmail.com>, 
	linux-rockchip@lists.infradead.org
Cc: Shawn Lin <shawn.lin@rock-chips.com>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=
 <kw@linux.com>,  Manivannan Sadhasivam <mani@kernel.org>, Rob Herring
 <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner
 <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>, Kishon Vijay Abraham I
 <kishon@kernel.org>, Rick wertenbroek <rick.wertenbroek@gmail.com>, Neil
 Armstrong <neil.armstrong@linaro.org>, Valmantas Paliksa
 <walmis@gmail.com>, linux-phy@lists.infradead.org,
 linux-pci@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Tue, 01 Jul 2025 09:54:51 +0200
In-Reply-To: <e81700ef4b49f584bc8834bfb07b6d8995fc1f42.1751322015.git.geraldogabriel@gmail.com>
References: <cover.1751322015.git.geraldogabriel@gmail.com>
	 <e81700ef4b49f584bc8834bfb07b6d8995fc1f42.1751322015.git.geraldogabriel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-2.fc40) 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2025-06-30 at 19:24 -0300, Geraldo Nascimento wrote:
> Current code uses custom-defined register offsets and bitfields for
> standard PCIe registers. Change to using standard PCIe defines. Since
> we are now using standard PCIe defines, drop unused custom-defined
> ones,
> which are now referenced from offset at added Capabilities Register.

This could be phrased a bit more cleanly. At least I don't get exactly
what "from offset" means. You mean you replace the unused custom ones?
But if they're unused, why are they even being replaced?


>=20
> Suggested-By: Bjorn Helgaas <bhelgaas@google.com>

s/By/by


P.

> Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> ---
> =C2=A0drivers/pci/controller/pcie-rockchip-ep.c=C2=A0=C2=A0 |=C2=A0 4 +-
> =C2=A0drivers/pci/controller/pcie-rockchip-host.c | 44 ++++++++++--------=
-
> --
> =C2=A0drivers/pci/controller/pcie-rockchip.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 | 12 +-----
> =C2=A03 files changed, 25 insertions(+), 35 deletions(-)
>=20
> diff --git a/drivers/pci/controller/pcie-rockchip-ep.c
> b/drivers/pci/controller/pcie-rockchip-ep.c
> index 55416b8311dd..300cd85fa035 100644
> --- a/drivers/pci/controller/pcie-rockchip-ep.c
> +++ b/drivers/pci/controller/pcie-rockchip-ep.c
> @@ -518,9 +518,9 @@ static void rockchip_pcie_ep_retrain_link(struct
> rockchip_pcie *rockchip)
> =C2=A0{
> =C2=A0	u32 status;
> =C2=A0
> -	status =3D rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_LCS);
> +	status =3D rockchip_pcie_read(rockchip, PCIE_EP_CONFIG_BASE +
> PCI_EXP_LNKCTL);
> =C2=A0	status |=3D PCI_EXP_LNKCTL_RL;
> -	rockchip_pcie_write(rockchip, status, PCIE_EP_CONFIG_LCS);
> +	rockchip_pcie_write(rockchip, status, PCIE_EP_CONFIG_BASE +
> PCI_EXP_LNKCTL);
> =C2=A0}
> =C2=A0
> =C2=A0static bool rockchip_pcie_ep_link_up(struct rockchip_pcie *rockchip=
)
> diff --git a/drivers/pci/controller/pcie-rockchip-host.c
> b/drivers/pci/controller/pcie-rockchip-host.c
> index b9e7a8710cf0..65653218b9ab 100644
> --- a/drivers/pci/controller/pcie-rockchip-host.c
> +++ b/drivers/pci/controller/pcie-rockchip-host.c
> @@ -40,18 +40,18 @@ static void rockchip_pcie_enable_bw_int(struct
> rockchip_pcie *rockchip)
> =C2=A0{
> =C2=A0	u32 status;
> =C2=A0
> -	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0	status |=3D (PCI_EXP_LNKCTL_LBMIE | PCI_EXP_LNKCTL_LABIE);
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0}
> =C2=A0
> =C2=A0static void rockchip_pcie_clr_bw_int(struct rockchip_pcie *rockchip=
)
> =C2=A0{
> =C2=A0	u32 status;
> =C2=A0
> -	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0	status |=3D (PCI_EXP_LNKSTA_LBMS | PCI_EXP_LNKSTA_LABS) << 16;
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0}
> =C2=A0
> =C2=A0static void rockchip_pcie_update_txcredit_mui(struct rockchip_pcie
> *rockchip)
> @@ -269,7 +269,7 @@ static void rockchip_pcie_set_power_limit(struct
> rockchip_pcie *rockchip)
> =C2=A0	scale =3D 3; /* 0.001x */
> =C2=A0	curr =3D curr / 1000; /* convert to mA */
> =C2=A0	power =3D (curr * 3300) / 1000; /* milliwatt */
> -	while (power > PCIE_RC_CONFIG_DCR_CSPL_LIMIT) {
> +	while (power > FIELD_MAX(PCI_EXP_DEVCAP_PWR_VAL)) {
> =C2=A0		if (!scale) {
> =C2=A0			dev_warn(rockchip->dev, "invalid power
> supply\n");
> =C2=A0			return;
> @@ -278,10 +278,10 @@ static void
> rockchip_pcie_set_power_limit(struct rockchip_pcie *rockchip)
> =C2=A0		power =3D power / 10;
> =C2=A0	}
> =C2=A0
> -	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCR);
> -	status |=3D (power << PCIE_RC_CONFIG_DCR_CSPL_SHIFT) |
> -		=C2=A0 (scale << PCIE_RC_CONFIG_DCR_CPLS_SHIFT);
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCR);
> +	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_DEVCAP);
> +	status |=3D FIELD_PREP(PCI_EXP_DEVCAP_PWR_VAL, power);
> +	status |=3D FIELD_PREP(PCI_EXP_DEVCAP_PWR_SCL, scale);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_DEVCAP);
> =C2=A0}
> =C2=A0
> =C2=A0/**
> @@ -309,14 +309,14 @@ static int rockchip_pcie_host_init_port(struct
> rockchip_pcie *rockchip)
> =C2=A0	rockchip_pcie_set_power_limit(rockchip);
> =C2=A0
> =C2=A0	/* Set RC's clock architecture as common clock */
> -	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0	status |=3D PCI_EXP_LNKSTA_SLC << 16;
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0
> =C2=A0	/* Set RC's RCB to 128 */
> -	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_LCS);
> +	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0	status |=3D PCI_EXP_LNKCTL_RCB;
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_LCS);
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_LNKCTL);
> =C2=A0
> =C2=A0	/* Enable Gen1 training */
> =C2=A0	rockchip_pcie_write(rockchip, PCIE_CLIENT_LINK_TRAIN_ENABLE,
> @@ -341,9 +341,9 @@ static int rockchip_pcie_host_init_port(struct
> rockchip_pcie *rockchip)
> =C2=A0		 * Enable retrain for gen2. This should be
> configured only after
> =C2=A0		 * gen1 finished.
> =C2=A0		 */
> -		status =3D rockchip_pcie_read(rockchip,
> PCIE_RC_CONFIG_LCS);
> +		status =3D rockchip_pcie_read(rockchip,
> PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
> =C2=A0		status |=3D PCI_EXP_LNKCTL_RL;
> -		rockchip_pcie_write(rockchip, status,
> PCIE_RC_CONFIG_LCS);
> +		rockchip_pcie_write(rockchip, status,
> PCIE_RC_CONFIG_CR + PCI_EXP_LNKCTL);
> =C2=A0
> =C2=A0		err =3D readl_poll_timeout(rockchip->apb_base +
> PCIE_CORE_CTRL,
> =C2=A0					 status,
> PCIE_LINK_IS_GEN2(status), 20,
> @@ -380,15 +380,15 @@ static int rockchip_pcie_host_init_port(struct
> rockchip_pcie *rockchip)
> =C2=A0
> =C2=A0	/* Clear L0s from RC's link cap */
> =C2=A0	if (of_property_read_bool(dev->of_node, "aspm-no-l0s")) {
> -		status =3D rockchip_pcie_read(rockchip,
> PCIE_RC_CONFIG_LINK_CAP);
> -		status &=3D ~PCIE_RC_CONFIG_LINK_CAP_L0S;
> -		rockchip_pcie_write(rockchip, status,
> PCIE_RC_CONFIG_LINK_CAP);
> +		status =3D rockchip_pcie_read(rockchip,
> PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
> +		status &=3D ~PCI_EXP_LNKCAP_ASPM_L0S;
> +		rockchip_pcie_write(rockchip, status,
> PCIE_RC_CONFIG_CR + PCI_EXP_LNKCAP);
> =C2=A0	}
> =C2=A0
> -	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_DCSR);
> -	status &=3D ~PCIE_RC_CONFIG_DCSR_MPS_MASK;
> -	status |=3D PCIE_RC_CONFIG_DCSR_MPS_256;
> -	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_DCSR);
> +	status =3D rockchip_pcie_read(rockchip, PCIE_RC_CONFIG_CR +
> PCI_EXP_DEVCTL);
> +	status &=3D ~PCI_EXP_DEVCTL_PAYLOAD;
> +	status |=3D PCI_EXP_DEVCTL_PAYLOAD_256B;
> +	rockchip_pcie_write(rockchip, status, PCIE_RC_CONFIG_CR +
> PCI_EXP_DEVCTL);
> =C2=A0
> =C2=A0	return 0;
> =C2=A0err_power_off_phy:
> diff --git a/drivers/pci/controller/pcie-rockchip.h
> b/drivers/pci/controller/pcie-rockchip.h
> index 5864a20323f2..f5cbf3c9d2d9 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -155,17 +155,7 @@
> =C2=A0#define PCIE_EP_CONFIG_DID_VID		(PCIE_EP_CONFIG_BASE + 0x00)
> =C2=A0#define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
> =C2=A0#define PCIE_RC_CONFIG_RID_CCR		(PCIE_RC_CONFIG_BASE + 0x08)
> -#define PCIE_RC_CONFIG_DCR		(PCIE_RC_CONFIG_BASE + 0xc4)
> -#define=C2=A0=C2=A0 PCIE_RC_CONFIG_DCR_CSPL_SHIFT		18
> -#define=C2=A0=C2=A0 PCIE_RC_CONFIG_DCR_CSPL_LIMIT		0xff
> -#define=C2=A0=C2=A0 PCIE_RC_CONFIG_DCR_CPLS_SHIFT		26
> -#define PCIE_RC_CONFIG_DCSR		(PCIE_RC_CONFIG_BASE + 0xc8)
> -#define=C2=A0=C2=A0 PCIE_RC_CONFIG_DCSR_MPS_MASK		GENMASK(7, 5)
> -#define=C2=A0=C2=A0 PCIE_RC_CONFIG_DCSR_MPS_256		(0x1 << 5)
> -#define PCIE_RC_CONFIG_LINK_CAP		(PCIE_RC_CONFIG_BASE
> + 0xcc)
> -#define=C2=A0=C2=A0 PCIE_RC_CONFIG_LINK_CAP_L0S		BIT(10)
> -#define PCIE_RC_CONFIG_LCS		(PCIE_RC_CONFIG_BASE + 0xd0)
> -#define PCIE_EP_CONFIG_LCS		(PCIE_EP_CONFIG_BASE + 0xd0)
> +#define PCIE_RC_CONFIG_CR		(PCIE_RC_CONFIG_BASE + 0xc0)
> =C2=A0#define PCIE_RC_CONFIG_L1_SUBSTATE_CTRL2 (PCIE_RC_CONFIG_BASE +
> 0x90c)
> =C2=A0#define PCIE_RC_CONFIG_THP_CAP		(PCIE_RC_CONFIG_BASE +
> 0x274)
> =C2=A0#define=C2=A0=C2=A0 PCIE_RC_CONFIG_THP_CAP_NEXT_MASK	GENMASK(31, 20=
)


