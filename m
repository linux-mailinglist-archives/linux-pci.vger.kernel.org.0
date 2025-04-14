Return-Path: <linux-pci+bounces-25824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1954CA87FA5
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 13:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FFE174F25
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 11:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3DED29C322;
	Mon, 14 Apr 2025 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="B5TZlic7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E3C539A;
	Mon, 14 Apr 2025 11:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744631358; cv=none; b=h5Zubvc92/fGhstdC2Ck0EZX2yqUHsCIsZGMwRxoakSnWs243M4XhpbDvi3yrXL4MP0eo6VI73BaA0hGB4hDE7fv4/nsESxW2YeF0ow6m9QjGWY29sbRIuTLOFoXTcbPEkHEdxt5DmsnrQgC0TbcH23EgqDBkXYk2kbBjQrMwqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744631358; c=relaxed/simple;
	bh=ztxpMMJFLLvR1oZapArlbuf/s3HpqOv3E90SpnFpTec=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=JI9hh9P74WeJIOW4afS+As9M++V0HjU3doLP23juutbaz36HM1gwDDByU+37qQy7tcDCiJn5CfnPbXGxjoyan3N4y6WA63IaiNipqC5OlpN8iIRY2imXAwC1h7cAYdIk42jH+DQrISLfcNMYQP6wYB7UzPwh8YYSLLr6ufsRPcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=B5TZlic7; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1744631350; x=1745236150; i=wahrenst@gmx.net;
	bh=ztxpMMJFLLvR1oZapArlbuf/s3HpqOv3E90SpnFpTec=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 References:In-Reply-To:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B5TZlic7IPw+iMxfK9Lw9WWs8SYX20bTSJlUcIxtp/PzT1ScTT/296LjM++pVwoH
	 KsgGS0ZLHf0eFe2EwsWVPUxnVTAskcG+DUTb9PAEF8cYZtGHbGnp/RxbjDwusmlVg
	 CyDfhnCH0QPJG5mGNy6kZdYtIpmuYEk5/nfAhZPYE1UmVpv8x8m02w95v4FsfVlJb
	 eMRSoRZmNvVDsRnq1HL+maAKRE9qlj7VZ0H38bUx++udVrwMH2De8NuQ7XH6x8F4f
	 VzpRSu70sfLuoLORrwVKXma7u4dsVEYk8Pkm04JTswtRxgcmWKhhGry/nCGqDa8CK
	 8VEhHj+pUhiYeDjZYw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.1.107] ([37.4.251.153]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mof9P-1tFnGG3XYH-00ZWq1; Mon, 14
 Apr 2025 13:49:10 +0200
Message-ID: <a1133205-7dcd-4875-8a1f-a7f128140730@gmx.net>
Date: Mon, 14 Apr 2025 13:49:08 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Stefan Wahren <wahrenst@gmx.net>
Subject: Re: [PATCH v8 13/13] arm64: defconfig: Enable OF_OVERLAY option
To: Andrea della Porta <andrea.porta@suse.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Florian Fainelli <florian.fainelli@broadcom.com>,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Wilczynski <kw@linux.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Linus Walleij
 <linus.walleij@linaro.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Bartosz Golaszewski <brgl@bgdev.pl>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Saravana Kannan <saravanak@google.com>, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-gpio@vger.kernel.org, Masahiro Yamada <masahiroy@kernel.org>,
 Herve Codina <herve.codina@bootlin.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Andrew Lunn
 <andrew@lunn.ch>, Phil Elwell <phil@raspberrypi.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>, kernel-list@raspberrypi.com
References: <cover.1742418429.git.andrea.porta@suse.com>
 <9d5b41bf6d1565f0de96c7c1680bd404cba40189.1742418429.git.andrea.porta@suse.com>
Content-Language: en-US
In-Reply-To: <9d5b41bf6d1565f0de96c7c1680bd404cba40189.1742418429.git.andrea.porta@suse.com>
Autocrypt: addr=wahrenst@gmx.net; keydata=
 xjMEZ1dOJBYJKwYBBAHaRw8BAQdA7H2MMG3q8FV7kAPko5vOAeaa4UA1I0hMgga1j5iYTTvN
 IFN0ZWZhbiBXYWhyZW4gPHdhaHJlbnN0QGdteC5uZXQ+wo8EExYIADcWIQT3FXg+ApsOhPDN
 NNFuwvLLwiAwigUCZ1dOJAUJB4TOAAIbAwQLCQgHBRUICQoLBRYCAwEAAAoJEG7C8svCIDCK
 JQ4BAP4Y9uuHAxbAhHSQf6UZ+hl5BDznsZVBJvH8cZe2dSZ6AQCNgoc1Lxw1tvPscuC1Jd1C
 TZomrGfQI47OiiJ3vGktBc44BGdXTiQSCisGAQQBl1UBBQEBB0B5M0B2E2XxySUQhU6emMYx
 f5QR/BrEK0hs3bLT6Hb9WgMBCAfCfgQYFggAJhYhBPcVeD4Cmw6E8M000W7C8svCIDCKBQJn
 V04kBQkHhM4AAhsMAAoJEG7C8svCIDCKJxoA/i+kqD5bphZEucrJHw77ujnOQbiKY2rLb0pE
 aHMQoiECAQDVbj827W1Yai/0XEABIr8Ci6a+/qZ8Vz6MZzL5GJosAA==
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:T0QNT8oJFH3Ns/oSx+yvOcldq/37PEeJZ8dWssGFEoeeUNJGOj8
 KAfIXjvO1zKr1QEuPh7Eqjuqz2/z4zNabaGMxpSWbn1clCvFtqKNgYdhRGLS9tgQXUxW/se
 Tfk4+QgRqvFMd4vCU928Nm/NcWEAy0TPBmjeOKyqxFpQXGP2n71irv4xUMvjL7SMvpqm/0c
 M1XqzoKqO2/ChPsE+19rg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:jtrZ2GhFz9g=;d8d7oUs6bLbBoChY0c/bH2hp8ck
 XGrKelH8fwQk/0LqxpwXocMb9CXERgTSgjBpcgv5kgMBSy0KCQjo5T+E2x8qUWlqS5Vaxzloc
 pTYaVkPIQ2MLk5BsZvDYqHTpU/n50KPJJ5y/+XmXaLuvpQUK3MkpVuU8ulQoZs4d2djPLDx+v
 VUfqWpUAX2lBrYLk+c3JRboMIZWoOQM6yl6C+bzkYvczoG8LwZYsOYslVH7iyTA5XF1h2lc5w
 9CFiY8SiiwDh3O7PtNhYH2ylGVLlnrJeKpcZCCyXrcEJt7bi4WLEN2jYTC6/fRXwgh11B+lfy
 zyGzLPzD5L8xSP1UsaLh+7SNeOYFVDbosrVloNwzNEyJkW3F/Ddz7Gs6FDrgRVTp9rhTMw1wm
 k1aOuTy72BYjctn3yJO/+c2A8PDCDnlxcQR7+Q0ZWTDc5xfO0ho2XYJ+E/PpymnS0k4XyFGAD
 8aHzJyPF43s0VrW01FG1bupTaV+ZLUrm45yMRIn6OWOxEbB4s/GZtoxCUr117QE4HmYmlU/im
 0wuFg96Vtqd16hmnorVDPs2Nj/uIfN5jkEJvRIIeufjVsYq5d8nRGrwFn8BF8JvFI/rwbLb52
 MPZY0LjXueBPZvHK90N6riGUDA7hrbIFqAJ874CfvOg++n44CcS9VtWXBanfp+1amcIId0AAx
 r8L69lfIabDc9qL8Vby9v2do6WTVykZJLqeEEJwbwlEJfbdWNSVF2WL/UCCRvFVbHccQLvcco
 TFtUWQMk7GWxPR3OxDikizp2gQWCYrtQm9qi7C4eJ46rCx7fgpR1JWiCfcUOFvFdCfNXI+45m
 o+8E09k1b2xWXUSnyWqmJIkG5tx3OINOz7odIwV6GRakKPaP+254OB2esGpBCZ+TM8+iIHFu4
 zuZc8flXXe2LipHd2BQtvKUf1TJ3BAupIfRm3Kae1AqP4aL5mlAxKZ51dZxoUZnDG3RaJmJpQ
 HlzVF8qQoGr+LVMkq1hu1I1zTGmtK5z5ZIPbqTEZqI9nCa0d9sHSEmd37svI7H7T/YOAWg0Pc
 RNL6H18wXttv36KJ1jp0G6IuFeTNta7cnUaW0o2JzyWPApIDcLebHenkiemf+Hl9pToRgquzR
 V2hC7F0r6JMP+vNEg+Ur7ZZgaRxe/uZ3Hg0zyW5GzJKo6Fry60qR/Vm7oPeqqjzxYF1iPqno3
 6sjfYYHLhb+NpZNhAakG/q3YVR4QaXW/De1Zba4zang5EzvpnWTBZ0nrYQy2dB26Mwl41V11V
 V3bl2W41nR2JHbtGte4xy6po1IhfNqX7qEU56ZbrVHG3nt/aEW7A7Eh+Kfql/CwVkmA6VZS0x
 fEsKSx3VMu5nZTzZCSeZOT4WlDZf9zyO0smlAmZxE9iMwh4lWkuM1AX15hKi4twaARRKYekwd
 xnrZlNvZcMDl7LaTeT1hkNEhlqcHU5Tdl+zuPzGX7fiWqJiAZqM2fwoWAOcTywiCpeaM6sL03
 1CNkjD9+vq9JFcuda+xardD/PgYZP+avbY519DXAi/+fBr4LF


Am 19.03.25 um 22:52 schrieb Andrea della Porta:
> The RP1 driver uses the infrastructure enabled by OF_OVERLAY config
> option. Enable that option in defconfig in order to produce a kernel
> usable on RaspberryPi5 avoiding to enable it separately.
>
> Signed-off-by: Andrea della Porta <andrea.porta@suse.com>

Reviewed-by: Stefan Wahren <wahrenst@gmx.net>


