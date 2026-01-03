Return-Path: <linux-pci+bounces-43952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F23C2CEFA88
	for <lists+linux-pci@lfdr.de>; Sat, 03 Jan 2026 05:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD8BA3013EB7
	for <lists+linux-pci@lfdr.de>; Sat,  3 Jan 2026 04:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CA5F1B81A1;
	Sat,  3 Jan 2026 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TRPX5eDW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9693D2744F
	for <linux-pci@vger.kernel.org>; Sat,  3 Jan 2026 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767412865; cv=none; b=hcBrZNp1skBf2QkRyj/2Mre9crNzw/iVeLPM6dxfV6XdGc+tKhPgsArp26KFaBNOveQ0whkIsi0gTnRJa6QpduAOFVka54Ir1GHkgvpdhOCcMAdDOdjbROhU9J6tqxQjTXIkDOMmVIVWvuRI2X4Emy7N/ZyrR+2keEaiRJApPJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767412865; c=relaxed/simple;
	bh=O5TyLxDxTl+f2mZ1axYzsQh2njdkr6wcLvTK/Jvsf3M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=RkjYAvvkT1/7iEF0yUsnVMr+F3Nc+c4wlxY8EbORpe0Z2JuRrKXxmAxACKyXq2o+91TvySGelMbxGuTTq7n2W/pR/nFaMsOcHazHBGUdFROhS9aLhfQv05QMbqmzKWuMaGw4WdSpF24tLJny83wSGF6paYKfiAEe8G1X6J5pczI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TRPX5eDW; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b7277324054so2050659766b.0
        for <linux-pci@vger.kernel.org>; Fri, 02 Jan 2026 20:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767412861; x=1768017661; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O5TyLxDxTl+f2mZ1axYzsQh2njdkr6wcLvTK/Jvsf3M=;
        b=TRPX5eDWmed9dEbBDAByhjEEmAP9tHMCv3z25+KNIx3kjqWKgOg4YQsxI0ZXk/un6y
         yhZ22kSCjIz3Dfs+lHY7QXD8aJEQlTKLMVJK2jnQSWVFV2LKAQTqa5R0j6tSaZdPVBxi
         HsKTBqzIDOGEikqSrNWOTSFgrd/gAmdTxJe/zgEUsMvmF3T0Z9+SHJpFRNy2h7+TEsH9
         WZYH1xreDHat5RBnTdzB1yb7450GQ/rYdhaymRfp1DSA7qQzxTNoNx1XzuHmfIUMnVLg
         UjvoZncQDTS+PrSrE7PLIRN8eNg+sGzzaMa060F6jhXjz2+d7Z6Dz5i5NugG4qdr0U9n
         fxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767412861; x=1768017661;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O5TyLxDxTl+f2mZ1axYzsQh2njdkr6wcLvTK/Jvsf3M=;
        b=HRDxpVqfXSFhI5X1B9HQF3m+2JKqfM9DD//JATQyEYPeMcBPE+gSywUgKrxQWOawcL
         0pYYngVQ5iaxpeT7lIhV1BgSg/292Fy439RzeoWmggWGFDUwhxIDs750Cg7xJAYWy+jd
         9pUINk/BsOdBuwpMZNGwGQuHk20p6IgQyJTAQolPpo/DOJInrBhEI6xlnjTEMOCd9QJ5
         v+zBHeTBL8s8pO3NCBpfZp32DxlmaPJnQbx+cZz2hwWzqired0ve0CiFBANy72SV/ho9
         p7o7WuL9LSpwVeUkgNnhcDVKoATQpjEA1zv+02quLrk1q5H8c8FYeNBG7Qv4xD2fn8dO
         799Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpvc4OngN1IRYrgvt7JQpRuYvETrgl+u9ZJqiF+gWcWSErhM0EWUDcPgDsaVKc1JchS/E6pILOzSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1pTC8VCy2+edaTLQ65QXyN9Ou6QjoZCjB6jRFWyKTye5ll0sC
	lQEgp9crcIp/EpjrglmmhrkKR+asqPmwVp/aBBn94zzc8juOEv43FHg7ylbnhnDaeIylm5cwWU0
	e2o+pvyZnjF54EFoscm9kE0qfR8yN3sg=
X-Gm-Gg: AY/fxX5Fyt9YX2V2ftdCmZPbYv5kUvZtbTeIzprHfU7DFeQpjtYxR7mnooSs5dgoGsW
	9DIKmiKxNqSmxrU6DdywTCvNRobQsAVm5BDBfPU78XEjOSAMVu4jOcXQqHpWQspnBhNJDrJjeDu
	l9lBQj68auM9QvgbMtjoKYbKA0GNxql1V466JvMP2bX2Fz/KrQUANRAZTvwaTlM14ixUg3gr8uu
	orKVwxPDRE9kvbdYgeOcx+pfEHXfUMzBgSMc78kjGfsp1hsH1dFBbSUTLD2UOQqSBGq9nPBWd38
	Uw==
X-Google-Smtp-Source: AGHT+IFbqOg1v7R6x4ZKSLsBtcF4IavFaKTZJD22J8rhS7PY+gLCvqJNHPA4Xulg1zgPgOEwgSlZWRiPLIIb2GrK8bY=
X-Received: by 2002:a17:907:d8c:b0:b72:6143:60c2 with SMTP id
 a640c23a62f3a-b803722fd2dmr4546055166b.51.1767412861124; Fri, 02 Jan 2026
 20:01:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260102131819.123745-1-linux.amoon@gmail.com>
In-Reply-To: <20260102131819.123745-1-linux.amoon@gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sat, 3 Jan 2026 09:30:44 +0530
X-Gm-Features: AQt7F2quBQViuflKz_7WiGupGUP2_HLsYQ3tNIlxCVaZuJpRuYGaxaR_J_lrz5U
Message-ID: <CANAwSgQ2TBnGAwaykRFDCphAZOk6gY1yVYOroUDYnRwP1kZACg@mail.gmail.com>
Subject: Re: [PATCH v2] PCI: dw-rockchip: Add runtime PM support to Rockchip PCIe
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Niklas Cassel <cassel@kernel.org>, 
	Shawn Lin <shawn.lin@rock-chips.com>, Hans Zhang <18255117159@163.com>, 
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>, 
	"open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS" <linux-pci@vger.kernel.org>, 
	"moderated list:ARM/Rockchip SoC support" <linux-arm-kernel@lists.infradead.org>, 
	"open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi All

On Fri, 2 Jan 2026 at 18:48, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Add runtime powwe manageement functionality into the Rockchip DesignWare
There is a small typo over here,
 s/runtime powwe manageement/runtime power management/
If you need it, I will send an updated version.
> PCIe controller driver. Calling devm_pm_runtime_enable() during device
> probing allows the controller to report its runtime PM status, enabling
> power management controls to be applied consistently across the entire
> connected PCIe hierarchy.
>
> Signed-off-by: Anand Moon <linux.amoon@gmail.com>

Thanks
-Anand

