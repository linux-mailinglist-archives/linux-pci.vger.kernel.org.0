Return-Path: <linux-pci+bounces-35617-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA488B47A0C
	for <lists+linux-pci@lfdr.de>; Sun,  7 Sep 2025 11:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79B8B3C183E
	for <lists+linux-pci@lfdr.de>; Sun,  7 Sep 2025 09:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BDC7221294;
	Sun,  7 Sep 2025 09:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFsSmOmj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FFA1BD9CE;
	Sun,  7 Sep 2025 09:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757237289; cv=none; b=dLZAueaPqANe3RQuEX7170qnVlqfRD+/GxTcUCtLkKxJX13or0EDAPHbHmPLepNqqHzq8ibrleJ9RmYg7V7aBzh5FIAu8fnNTPcSxTqKnFWkQClOgtBNPS9p8YouejM18IpR0erD8g48yI7+2KoWQSAp9qOwENshDJGTsljQStU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757237289; c=relaxed/simple;
	bh=9QIp8Bnkemto1WfXYcjT9DowzK2f1Hc3NM2XpeRW/3Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JsaVyuCzrceYL2gUDPwZWgVgJStPTa5i6Q8PvwhXuEuK9u6rupe027SGQgKKHZLWqH70r9nSzGs2PT7i4q48V2AGRLCI7nc6HQB0hR2C2SkBZLzt99HDYdh3INgYlmSIELYVLjLunwnsbZzUxlS5OJWzWtRPc2e5qygR0su25ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFsSmOmj; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-45de1e6d76fso5157845e9.2;
        Sun, 07 Sep 2025 02:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757237285; x=1757842085; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7XB3+EZyHStMbJWyfu9oUjul9eDNETGU8O8plme6nr8=;
        b=AFsSmOmjkHTWMfaUxYGFYNTG1EspXRp0ywuXHvydNgisxw4tqtpSWslgLsgaAXdDlT
         BgfeAcGUtXFOJW9xFKvgupGTAx4iZeyikL0FFQdNQR93tp/WIiMSIODbvRo5LnoL3cgd
         0A8d99D9ZzUb/wnILoUfqcWJKqCaX+kpWALNbc5frodzu/+bBWofIndaqR26n1us75AQ
         sDA7XM92OLO0/EsAeEoilGGaTUhy+ZI2KQTlOgyBd/uv5br6UUqnFs2wwTf8GABfJXJE
         ZFX7NDE9GMs8ctZ1gLpjxoElx5WybdMBjXjK5sOgsM500QYEH34JNjP97su5cYWYmXP2
         NMaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757237285; x=1757842085;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7XB3+EZyHStMbJWyfu9oUjul9eDNETGU8O8plme6nr8=;
        b=RVnlbUOzwV8ygcy3zUksce8EOTD5um2EcTEEFdoqgM3KCcvDVUZy5G6wTkL3BhzktH
         2qT0WZL8k9UhiPS6T4dhI1N+m3ScwDuFKP9FKO/t/9H6Q9xjZF1CMXLpWoXMIhFmtw+y
         Y/yILQMVgmvdQ8gCjsStgD0KkzVhqVPHb/7FJgPqLdiKBoXQ7uGSnOUOROYi/td/6V/d
         lFwM2NI5R3dim1JSQMdYgaiEwLLaI0BEX5aQDvZ9OCvEMncXvSN+9p8wpY5h1tHGJ7ws
         sSMpyBJsc3RfjiHZCotgri+D/v2IOsN0XfPy7W1xVkAce3+gzvCoOzVd3P3HyIfLVZMr
         xP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmOImeH1NIVQQgMAlC17LYkpuiDBjqZ43cWlNvWyGEU9eBnIZxP62QDabiqbj7uZZeD/9MovREeTM+@vger.kernel.org, AJvYcCXPNI1NZ/MfFhZsznsYv2/zNXWfF5YnC3H+mlG6rCW4hzJrLt00K0Lg7+3KWdMbZ8Jj8p3MRSHxxlrbR5U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxSJdDGCfe4nzIW3olBAtslak+4rZ50aKiStCbdM7Iw71NrrvL
	x2ViM5dZBK6Fgw2+bm9L4u/chD7QYzKE1B82sRr4q+DYT+6HrJ458koN
X-Gm-Gg: ASbGncu9apyKoLCfmbcfVlU3ipyb2NkqxivD9/V7JlKP4rTO/EmstEmV+QlpkqS21B1
	yaYmIimhaBC4WFUXYOaewmBE9GEgOP7FrEslY+aSSRWSlEvsMlPmGsuj1MDRhM5Z4/yOaXv69gx
	USUoNSR4hp1AisHTYPw/K8wMC90v1Oah8oWUd2flH5CLRuxdf9rR1H5zpTohPzgkxEuEUs8iFlS
	cyy4dZkY06nL2llzELtwgxj0qqtuCyMiBfPCbpuIq0l5DsbCk8u9V7zEuxnosWL2x5SNR+rlI2k
	6NEmn/c/pWhbhwe+POG9+QNBlD0ca39JRRAuNO4b4jGIONt4YmGv3QbJiJ75bPzDfQ5Pu+W3pG8
	6wVSU9p4yJYXTspaUttrSOIf6he6IvRMwrTMkci9R5fmu8xmuBd0JeIwiz/q31fSf
X-Google-Smtp-Source: AGHT+IFQqN1xdf8yX2rXwR72QToKnSI/WjPbg116r2WIKGc/6EtoIOWfniY52wX2yGeNBiMugvz2yw==
X-Received: by 2002:a05:600c:1548:b0:45b:88d6:8ddb with SMTP id 5b1f17b1804b1-45dddf0234emr35756295e9.37.1757237285381;
        Sun, 07 Sep 2025 02:28:05 -0700 (PDT)
Received: from ?IPv6:2a02:168:6806:0:267e:37:6a88:3fc5? ([2a02:168:6806:0:267e:37:6a88:3fc5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3e74893acecsm45931f8f.36.2025.09.07.02.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Sep 2025 02:28:04 -0700 (PDT)
Message-ID: <34a23816bf125c577a03ba68f251e7a77db9805b.camel@gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Fix the use of the for_each_of_range()
 iterator
From: Klaus Kudielka <klaus.kudielka@gmail.com>
To: Jan Palus <jpalus@fastmail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Pali
 =?ISO-8859-1?Q?Roh=E1r?=	 <pali@kernel.org>, Lorenzo Pieralisi
 <lpieralisi@kernel.org>, Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?=	
 <kwilczynski@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>, Rob
 Herring	 <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>
Date: Sun, 07 Sep 2025 11:28:04 +0200
In-Reply-To: <hiu2ouj4f7zak2ovtwtigf6fylz4c7fdyyqiqezsddoouzr4n5@bfs7kudjfnp5>
References: <20250902151543.147439-1-klaus.kudielka@gmail.com>
	 <hiu2ouj4f7zak2ovtwtigf6fylz4c7fdyyqiqezsddoouzr4n5@bfs7kudjfnp5>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-2+b1 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2025-09-03 at 14:44 +0200, Jan Palus wrote:
>=20
> Thanks for the patch Klaus! While it does improve situation we're not
> quite there yet. It appears that what used to be stored in `cpuaddr` var
> is also very different from `range.cpu_addr` value so the results
> in both `*tgt` and `*attr` are both wrong.
>=20
> Previously `cpuaddr` had a value like ie 0x8e8000000000000 or
> 0x4d0000000000000. Now `range.cpu_addr` is always 0xffffffffffffffff.
> Luckily what used to be stored in `cpuaddr`:
>=20
> u64 cpuaddr =3D of_read_number(range + na, pna)
>=20
> appears to be stored in range.pci_bus_addr now. I can't make any
> informed comment about this discrepancy however I can confirm following
> change (in addition to your patch) makes mvebu driver work again (or at
> least like it used to work in 6.15, it still needs Pali's patches to
> have some devices working):
>=20
> -			*tgt =3D DT_CPUADDR_TO_TARGET(range.cpu_addr);
> -			*attr =3D DT_CPUADDR_TO_ATTR(range.cpu_addr);
> +			*tgt =3D DT_CPUADDR_TO_TARGET(range.parent_bus_addr);
> +			*attr =3D DT_CPUADDR_TO_ATTR(range.parent_bus_addr);


Oh well, a CPU address that is not a CPU address....

Looking again at of_range_parser_one() - which I assume to be "correct" her=
e:

	range->flags =3D parser->bus->get_flags(parser->range);

	range->bus_addr =3D of_read_number(parser->range + busflag_na, na - busfla=
g_na);

	if (parser->dma)
		range->cpu_addr =3D of_translate_dma_address(parser->node,
				parser->range + na);
	else
		range->cpu_addr =3D of_translate_address(parser->node,
				parser->range + na);

	range->parent_bus_addr =3D of_read_number(parser->range + na, parser->pna)=
;

Indeed, range.cpu_addr is a translated version of range.parent_bus_addr, an=
d does
not seem to be relevant to pci-mvebu.

The driver previously interpreted the raw part of the "/soc/pcie/ranges" re=
source
(storing it in a local variable called cpuaddr).

To restore the behavior completely, we thus can use range.parent_bus_addr -=
--
confirming your test.

I'll prepare a patch version 2, including this second fix.

