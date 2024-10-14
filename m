Return-Path: <linux-pci+bounces-14480-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F9899D37E
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8023DB21F1C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 15:36:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4841819E7ED;
	Mon, 14 Oct 2024 15:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dy4qv+91"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81D914AA9;
	Mon, 14 Oct 2024 15:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728920134; cv=none; b=HCglzYz3pD2eJJmhz8uQOhdFUfcDfmpAbVGhXmOyV/TvgpEF0rC5JuyFwWuGW1++fmF6XQr/C614x7rDiIAUTOecbYt5TIkxEbeaLyRln7+lc+JpkMUO1VlaHD/dD+9RpRRRS3llhT+0DnfpOrb13gr5miTi4xfzEh03wdLMnfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728920134; c=relaxed/simple;
	bh=vAWW8CfwdM4PXSjdMuDBBhnLwrebdg2SW8fxlwMaGew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gudmDOHu3/JYkPN1a9O4f+up9zTSaecl/fBx34ymCGM5xQnB5bwx//bb/4EUCQiffP0gUdShWoqUZk4pfRwMoI2qHL7B1JGx9dIFhxjGCUTKDIFXSsKy6/LRIn0gqcW0BP0kmMnb1UXrxzAftDCgt7prQh/A7soA7hzA3DZSuWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dy4qv+91; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e22f10cc11so30892877b3.1;
        Mon, 14 Oct 2024 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728920131; x=1729524931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwoWR9kcLSD6y5POnvEG69c7ueVxZNzIdrUWcKD1IW4=;
        b=Dy4qv+91QsyhnxFywa7+XXniii0iBLnIJ4mnPwAmUuCYlXnmu4zpzkhmhoAyZJLG+I
         Lk927Sadp50JN9wntiBX1oMs4+WoUwEVZZmOjJPOQdA+DjzBABLtr/Gj/KmkT+xWj11P
         0CkQLwmzF1O4pvNgw1gKBGcmWmdS1d4YJ0YazzVp3e2STvWaNE81a5A9Lo/6/X2Izo0s
         POUtrRiOzGfSidN346E+jrPl7CbQPrlJCo93abhC6BNv7BlWo4IZbFWAguVhU+HVwn+r
         JPEkiwE+lq+fvDStckfQF0rlGi58ByCOhAy35xVA5uTH0iO5j+pueUjUVagetR7gHdfN
         CtOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728920131; x=1729524931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zwoWR9kcLSD6y5POnvEG69c7ueVxZNzIdrUWcKD1IW4=;
        b=nFsuIczWWjwxNz8uzivJnc8ohlpVQmQ39UioPsi7C+dBjwOrV/hEPmO15gt4kfK6D2
         vQ7th1Ryyd0uNqCQeCkVVNbJqpcsPsZKJEiv7Wscxk711zNnoesK8YNpSvhpGr4S6Zuu
         PQWxVZiXnx8cU2rB7NDEB/P70U6M8rjZ2OuheBlXFcm1WCkMZV4eR/d5oq1MKQz6eOsy
         3HeCSn4X4lbGZgtf/7AYSkCH5rCsD7vKIOS7UEYc40HEAXwVC0wTZsqoYhPe8MFFv+5k
         +9BptEomLyrngM7C0PX14Hc1Ha5JR4EeKotKeMmpL5QVmp4+j+3Hk/N2I2H322RY7N8r
         u7BQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPRg/DLpanCptPGe5wIzSBdhgT1l5qlmUXEt56xUEzsaceYkCbg4fxAQg/3MLjjHcH4j23BY2JZHZX@vger.kernel.org, AJvYcCXb+rNJwkiidVFzbKAaeCrUGRIeByA69XqlWEzEZopp/SJ9YLOPI412n6kRnOFI0nPdgVTZa3Te+/32@vger.kernel.org
X-Gm-Message-State: AOJu0YwFglk6r0lYSZ3djWrWA1/XZRYRgXmDXG26BtYADutzKhTXt0J8
	GNHBmuprHi5/Uq44/QSBXMW1dCS2weH0iRu9YTiYIhO78jb44YpijBCQK3GoFsfzAbKweR7D1xu
	5Shy9au2gTrmFJgVxsRzs3zdoL/Q=
X-Google-Smtp-Source: AGHT+IGA8oiecngmaY9OZSeRApkIfg6x4tQAnzHxtWVvD6lnBpiQAM/dJ6sedqPFuMT+SIY/SLxLJN+IQMSuY6ZmyD8=
X-Received: by 2002:a05:690c:399:b0:6e3:4436:56af with SMTP id
 00721157ae682-6e347c4861cmr90232657b3.33.1728920131664; Mon, 14 Oct 2024
 08:35:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241011121408.89890-1-dlemoal@kernel.org> <20241011121408.89890-2-dlemoal@kernel.org>
In-Reply-To: <20241011121408.89890-2-dlemoal@kernel.org>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Mon, 14 Oct 2024 17:34:55 +0200
Message-ID: <CAAEEuho3WOA7qNDav9D_wPxdOac8B9W=nD4hxR+fS038h0zE7Q@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] PCI: rockchip-ep: Fix address translation unit programming
To: Damien Le Moal <dlemoal@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Kishon Vijay Abraham I <kishon@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 11, 2024 at 2:14=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> The rockchip PCIe endpoint controller handles PCIe transfers addresses
> by masking the lower bits of the programmed PCI address and using the
> same number of lower bits masked from the CPU address space used for the
> mapping. For a PCI mapping of <size> bytes starting from <pci_addr>,
> the number of bits masked is the number of address bits changing in the
> address range [pci_addr..pci_addr + size - 1].
>
> However, rockchip_pcie_prog_ep_ob_atu() calculates num_pass_bits only
> using the size of the mapping, resulting in an incorrect number of mask
> bits depending on the value of the PCI address to map.
>
> Fix this by introducing the helper function
> rockchip_pcie_ep_ob_atu_num_bits() to correctly calculate the number of
> mask bits to use to program the address translation unit. The number of
> mask bits is calculated depending on both the PCI address and size of
> the mapping, and clamped between 8 and 20 using the macros
> ROCKCHIP_PCIE_AT_MIN_NUM_BITS and ROCKCHIP_PCIE_AT_MAX_NUM_BITS. As
> defined in the Rockchip RK3399 TRM V1.3 Part2, Sections 17.5.5.1.1 and
> 17.6.8.2.1, this clamping is necessary because:
> 1) The lower 8 bits of the PCI address to be mapped by the outbound
>    region are ignored. So a minimum of 8 address bits are needed and
>    imply that the PCI address must be aligned to 256.
> 2) The outbound memory regions are 1MB in size. So while we can specify
>    up to 63-bits for the PCI address (num_bits filed uses bits 0 to 5 of
>    the outbound address region 0 register), we must limit the number of
>    valid address bits to 20 to match the memory window maximum size (1
>    << 20 =3D 1MB).

Hello Damien,
I just found out the cadence controller
(drivers/pci/controller/cadence/pcie-cadence.c) suffers from the exact
same num_pass_bits calculation issue. The code in
cdns_pcie_set_outbound_region() is very similar to
rockchip_pcie_prog_ep_ob_atu().

I found out by running the NVMe endpoint function on a Texas
Instruments ARM67A SoC which relies on the pci-j721e cadence PCI
driver. I observed the same issues we had with the RK3399, when I
patched it with the same computation for the num pass bits as we did
for the RK3399, it would work.

So this issue also exists for all cadence based drivers. It's too bad
I don't have access to any technical doc ref to back this up.

Just wanted to let you know.
Best regards,
Rick

