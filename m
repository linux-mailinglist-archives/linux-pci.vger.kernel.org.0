Return-Path: <linux-pci+bounces-15835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EED99B9FCE
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 12:56:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D0728296F
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0E14176ABA;
	Sat,  2 Nov 2024 11:54:15 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3880F187355;
	Sat,  2 Nov 2024 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548455; cv=none; b=mLZRqkWGzphq3/HeTBcq/eUWMcYdt51TKj1bz/tVl3M1vpcrw8Go0h6aUx0+2XKbnf6w6qtmXRUOLRdEQFudmtU2QQgkYqAuSTCQnm+RW0OdTg1pNYnady1EQyG9z9gBhK6f2ydechqFVdZPW4IIVDzGjkkQRDpW+1rcitz8L58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548455; c=relaxed/simple;
	bh=XvbJ9e26e4gpCai0/lrArNSvaSzm/i6/gjXmcfle0BI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K2tH0JLPqSUUWnzAxgFnb5YnPNc8Ng4u/Px0dBtN6zw2tyMeFyb/8cpuoNQaQfokxFf9mfns0+XOjgL/H25BEY9/1Bfs3z6HTcYpS8lJkDpCns6qZ1bKxRDaz75InOXRtCrMmdbmUeKZlpXP6VO/vHWxJuno3Y2HuP6qe2w9I4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so2469708b3a.3;
        Sat, 02 Nov 2024 04:54:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730548453; x=1731153253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cVx7U4bzYVpyfgKjWQr0MaSdBVExKH9K4jnX08inNnM=;
        b=bdnjLVxgWwuxdR1v42NBbEszhUd2jtQdrJoPx0J8yLBD3UqfBRXg9Ku8E+9NSbILMX
         R7PlveFotDlN18hYhHN4Ofq9DumGw2o4uD12Lbcyw07+v3c7S62tQvRzV+iBFhM+mle1
         Tbe5X3y7iMOSiYLxK+dgWuC8vxuGGbX9oymEdPkuPAsOibr6ui+LQbrnQFbkat0LwTiY
         LQO39GD6de0uyObXhuo7pkw4utCBXD3zo1WL4knaN1n+x8C3ZJepWNTR77vWtBI3FqJT
         7f3SJi7rDqDtkVOaRvgUJWc1+BOpEbjHZMgo3gPF1BSnKAM2pWk38K93E8uFddEChh7i
         QXGA==
X-Forwarded-Encrypted: i=1; AJvYcCUvHZSbzu6LCawp3Gc6qWus90yb3ldY/mbRwEoQa+MrV999+Tj7Izl7jHAgor1/yWoK1GpSpgJ2+aMwbAWr@vger.kernel.org, AJvYcCUyYmvzg3HtsM9ymXmlgxpiqCH2s35dJxaIl+r73LuuXnG6Pif0cN2Pzhf4rlxc8qX+IeIq5r9JUGP+@vger.kernel.org, AJvYcCXOvg3ofW11Y3xHHhJ0ZQQE1IKd5JIw+GEjVl+u3cCFjdda3L+ynzeJnWRE9kF6XtIymav3ikldpw+Q@vger.kernel.org
X-Gm-Message-State: AOJu0YzaWyqJnCE5frULd6Mw0ZdZvh5DrAtyqF/A+DZ95265Jl52wrnf
	MQA1aUNkIFJ94N2gm+azFUzpBvtFqCY/86/CKJ+Ei3mZFX6rKlEl
X-Google-Smtp-Source: AGHT+IHADfTBPOuMjseNhPZnBBPX7nUxyp7rMazi1phiYKiysXu9Wg3hN940Yi3yFmnRm7R8Dx3VBQ==
X-Received: by 2002:a05:6a21:164a:b0:1d9:69cd:ae22 with SMTP id adf61e73a8af0-1db91dec892mr13325470637.30.1730548453509;
        Sat, 02 Nov 2024 04:54:13 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc31874bsm3986223b3a.213.2024.11.02.04.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 04:54:12 -0700 (PDT)
Date: Sat, 2 Nov 2024 20:54:11 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Conor Dooley <conor@kernel.org>, linux-pci@vger.kernel.org,
	Conor Dooley <conor.dooley@microchip.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 2/2] PCI: microchip: rework reg region handing to
 support using either instance 1 or 2
Message-ID: <20241102115411.GE2260768@rocinante>
References: <20240814-outmost-untainted-cedd4adcd551@spud>
 <20241101195129.GA1318063@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241101195129.GA1318063@bhelgaas>

Hello,

> > The PCI host controller on PolarFire SoC has multiple "instances", each
> > with their own bridge and ctrl address spaces. The original binding has
> > an "apb" register region, and it is expected to be set to the base
> > address of the host controllers register space. Defines in the driver
> > were used to compute the addresses of the bridge and ctrl address ranges
> > corresponding to instance1. Some customers want to use instance0 however
> > and that requires changing the defines in the driver, which is clearly
> > not a portable solution.
> 
> The subject mentions "instance 1 or 2".
> 
> This paragraph implies adding support for "instance0" ("customers want
> to use instance0").
> 
> The DT patch suggests that we're adding support for "instance2"
> ("customers want to use instance2").
> 
> Both patches suggest that the existing support is for "instance 1".
> 
> Maybe what's being added is "instance 2", and this commit log should
> s/instance0/instance 2/ ?  And probably s/instance1/instance 1/ so the
> style is consistent?
> 
> Is this a "pick one or the other but not both" situation, or does this
> device support two independent PCIe controllers?
> 
> I first thought this driver supported a single PCIe controller, and
> you were adding support for a second independent controller.
> 
> But the fact that you say "the [singular] host controller on
> PolarFire", and you're not changing mc_host_probe() to call
> pci_host_common_probe() more than once makes me think there is only a
> single PCIe controller, and for some reason you can choose to operate
> it using either register set 1 or register set 2.

Conor, let me know if we need to clarify the commit log per Bjorn's
questions.  If so, then I will do it directly on the branch.

	Krzysztof

