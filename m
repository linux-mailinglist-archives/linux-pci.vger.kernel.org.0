Return-Path: <linux-pci+bounces-12572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 654A5967A12
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 18:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 237C0281B81
	for <lists+linux-pci@lfdr.de>; Sun,  1 Sep 2024 16:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F4B44C93;
	Sun,  1 Sep 2024 16:51:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E961DFD1;
	Sun,  1 Sep 2024 16:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725209473; cv=none; b=T6Jtfhid93jBXU7ey+6mnZffIkO+16NTeyk4uAIACgDZl2UvicskPRPLIOkCBh6jnUCmAR2gq4w016xGH0dR4ZLEHZJMV8clQ6+1fe9EGTXQvJtEQbLaQ5Sf/m1A1+O3pS+9keFcvtg33+HzsszVSCx1LpUCuVbsOE2yfnrb/CM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725209473; c=relaxed/simple;
	bh=UMM1eWHEAKwZELG6jVj6AItw6zpAKP0hr98EoxOaGh0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tvJQJicORPZ0K5VGkU8LxGNii9y43QKSIvlNEfrxlrxtTe++vEu2egeTai+jUHLwhLityvKCmDIXKH420ORvtmOs19kHJbJhxLNKqE8/OyLf150h7/vup4MRqwl4bMpHlA8qVTUgKlPQCY/MYY3mSQLG5aMcMTJbEP3v8YOfm/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5dfa315ccf1so2064913eaf.3;
        Sun, 01 Sep 2024 09:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725209471; x=1725814271;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=faqvbHQvjipOxUuPh8oOgGos4CnxYbTO3zjHxxntymw=;
        b=a3A5SgLgoyOyrHwgoPgM6eVwn+otKrXD7SLJriaiseM1uJqv/+ky/zyt2hwnBUJH5+
         xvqYqx+oNw3aB4SAf3dZcR/0fkkgtes7VTCtYJouTa2sfIT/0qEnWILLfyhpR3oHKrUq
         cdUN/Pv6xcQijg5vRxcNRqEkfFu9e2BdoHwd7+ThzgAqsMLHki2n/pJ07EAiNW+1aRZY
         SIyYpc/oJboMtupt1y0Lgpmk42wsxq9spmXtIihRvKWZNZ/RdhdWomfuU2TcvR2g8Tn6
         7couYbG9C1FMMU3gxH4HAyilFQkZGNLh0GiO/hwKTKOlRmFof/0E7VDun0UteMGGvy2F
         7YXg==
X-Forwarded-Encrypted: i=1; AJvYcCUKq4nLqEv/y80FQ955oUL1nadkitNqkcmCLJeIut4lPSVtz0A6bdRaza+ulsqBiCms2DMvqJxrDJ6q@vger.kernel.org, AJvYcCUpJgtCQWi7dDwxO6Z33hFqgFAkV7X3AaC/vBHWnXBCZpxacXSfypU3V+kvhPEp2PkOrGKdRCZB9x/WjzB7ZvTLvFc=@vger.kernel.org, AJvYcCXaWh50gVuohnu+fu/DWk9mS3qtfEEZhFx3/L4UEd/llsqDhrp3Vn9HRtqSJnC7ybTbjYvmqDRq4aBA@vger.kernel.org
X-Gm-Message-State: AOJu0Yzft47HJGtzJ+VpFmaPuQ6KPsjy+aHXsB+R0UC4fYI5NR6lQBea
	7YsebHHbPTAktJ9i4zhm3iIhkVUKk0rNvdqfb+iC5NhinjQLpoph
X-Google-Smtp-Source: AGHT+IE2a3dBv1i8F63tbHlBRY/trHg1sCx9wdz/9SyW8/NVzSUlGyJLyIyhm/SRWIA/xAU4iW8Y2Q==
X-Received: by 2002:a05:6870:2c91:b0:277:c6e4:273c with SMTP id 586e51a60fabf-277c6e432d6mr5877344fac.45.1725209471436;
        Sun, 01 Sep 2024 09:51:11 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-715e55a5b56sm5542590b3a.57.2024.09.01.09.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 09:51:11 -0700 (PDT)
Date: Mon, 2 Sep 2024 01:51:09 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: marek.vasut+renesas@gmail.com, lpieralisi@kernel.org, robh@kernel.org,
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org,
	geert+renesas@glider.be, magnus.damm@gmail.com,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH 0/2] PCI: rcar-gen4: Add R-Car V4M support
Message-ID: <20240901165109.GH235729@rocinante>
References: <20240822064459.1133748-1-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822064459.1133748-1-yoshihiro.shimoda.uh@renesas.com>

Hello,

> Now the pcie-rcar-gen4 driver can reuse r8a779h0 (R-Car V4M) without
> any driver modification. So, just add compatible to the dt bindings doc.

Applied to dt-bindings, thank you!

[01/02] dt-bindings: PCI: rcar-gen4-pci-host: Add R-Car V4M compatible
        https://git.kernel.org/pci/pci/c/0e3a205c585e

[02/02] dt-bindings: PCI: rcar-gen4-pci-ep: Add R-Car V4M compatible
        https://git.kernel.org/pci/pci/c/6c41bcd64bcd

	Krzysztof

