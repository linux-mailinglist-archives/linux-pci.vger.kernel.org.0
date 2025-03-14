Return-Path: <linux-pci+bounces-23715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C3983A60A45
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 08:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB8657AB9FB
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 07:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4B319066D;
	Fri, 14 Mar 2025 07:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KD71UUa3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7ED18A6D2
	for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741938322; cv=none; b=NIuoM8QmpCXRdMx87loaylkEcrVFI7vj8RFIY9C5Oes8lNaCqA+WB266jCoqBBRfrqUrQvWpapB08eaQAbzvR6Npc4RErzhRCDs6qNbo7P0zVhf5W//VGIQQNs95ej52OWwB3XiiKpgo0FyR103d3evIkVpwa1UErDn9ZwdkWZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741938322; c=relaxed/simple;
	bh=4IXglGr9l4VCVBfr5iiKmffF4j+cQVeZIofcjJ0pYyE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RiBoR8XjG9WS3yOFJK01RBn668vMCgCEaRmaPbq0ff3Zit0qE4Ik4ayZRQBF3KN/zdBj5nn6/4zncYVYgsxXKFrYsaeUR+bJmbSVaIz4ZH+EzqQoZfWqC3Iw7b7s1vmQn/t4SgL3Yt5Ye15O+O34V3W00/616r+HNYi2S3+QBpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KD71UUa3; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-5499b18d704so1861982e87.0
        for <linux-pci@vger.kernel.org>; Fri, 14 Mar 2025 00:45:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741938318; x=1742543118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4IXglGr9l4VCVBfr5iiKmffF4j+cQVeZIofcjJ0pYyE=;
        b=KD71UUa30rCOobEKBiUd+1UqSauf5/aZdvUSpu0eNddGwoXgm7ro3FJd4Ymcy1m+yn
         aN7fzbmG02TbgKSvFsN9v5keyxljOrHSLL9bf2YobeeAlgONsAFeYCDJE3OX52z6TCAK
         lqPnL7keycTV0WEnpvQSzeYbNTZbAhFJV5xl9hsd+us0r/SSflcnz1jmRBBCNBnKwkLF
         IwCtKUj7NFZPHlFqk/EeMI1B2gXUQMZdYP0I/JT7veNc3Q48ScsL3tgQSw03JYVyMKfO
         N3c8dQ65yQLzqSf08tWW1zwPSY65nYdlLy7QUEFUynWsNydzwfzvWV8Ftb9fTvFckeAv
         M1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741938318; x=1742543118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4IXglGr9l4VCVBfr5iiKmffF4j+cQVeZIofcjJ0pYyE=;
        b=W/ebzOkJ9cztwXGqyhXwyd9ug04CMKhEEjU86bir6HOEgkH62T1/Ec/Xp3qtGpnLT6
         3Cq+sdPAa2uRypySoEJ2JptDpiSf6ZMWdZJjjYLHT2IcdpyioVqXSUkdGOyWnKP1sd5n
         FoL080EDSsCU5F4npbS+q4f40PJ/I+nbekpXSQV3dZj0FPqACihWdT6QKHN3nj9d4CDE
         3/ni5uWtSHun1TkHuqQfeLBvDRshjQy7tTpGJbDZ61WQN4O38/jDVnT6hT5Q538fm/Oz
         0+hd3xGKpGt7kklSZ9D7paMmuRWr5FaKnzv1ZoUPlpup8zgL+6y3N/UMrwZsJK5psDIl
         p80g==
X-Forwarded-Encrypted: i=1; AJvYcCXsL1NibAvcAQqaBzVziE7Pz/c/HLKFC7j94zQoCc7xKykrJuI7+JSggVPu/rcPykZCwJAydxj2Cxw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2OsydXHTBrcjZjEb0/e2QIGAaoN3CP/znJB2v5asyGZC2Ngvj
	s1fC5YEydxAWg1cuwU2WR3lWPlOf+JC16W1IHiRIQqQD6wKByi4Qm4T1VxT5qHaPQARF69MoWde
	fUtd6GmjpcCnIAdFieDLW6wdGklzMkJSYJb9ZyQ==
X-Gm-Gg: ASbGncvM7O0VgmMT0keG146zpKxn7KYACBE/A1y0fToUMiHk9s2oD0Ys75wq2nWnKFC
	FMh4Dg+y4JollhTD692CoUrA/csLcFnaSUaaKgX4XWTt5NaGIg+hfzfa5TWf7FWV0rpmb5lf9Fc
	1z+MtH3ot/adVxvIJwQfIPxEcfO6ojFj0=
X-Google-Smtp-Source: AGHT+IHn9sxin8VaKK5Gnmxxh46mS3jxTVpqeyGrlH8i+3MPWyEHFXgWyizzd4dtTn/AxPVdShyaidKbX1JVoYTvpIY=
X-Received: by 2002:a05:6512:400c:b0:549:6759:3979 with SMTP id
 2adb3069b0e04-549c391013fmr491228e87.18.1741938318560; Fri, 14 Mar 2025
 00:45:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250314071058.6713-1-zhangfei.gao@linaro.org> <20250314074243.GA234496@rocinante>
In-Reply-To: <20250314074243.GA234496@rocinante>
From: Zhangfei Gao <zhangfei.gao@linaro.org>
Date: Fri, 14 Mar 2025 15:45:07 +0800
X-Gm-Features: AQ5f1Jo1hzhKnUZ6-hglECj56zUmrT2BhqIMFCuupN6B6C346gBVJ_JE-yDZvlk
Message-ID: <CABQgh9FfdetW8n5q19KBo1JhhST_+T8fF+gFM3Siq7o7UyHkBA@mail.gmail.com>
Subject: Re: [PATCH] PCI: declare quirk_huawei_pcie_sva as FIXUP_HEADER
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Baolu Lu <baolu.lu@linux.intel.com>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
	iommu@lists.linux.dev, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Mar 2025 at 15:42, Krzysztof Wilczy=C5=84ski <kw@linux.com> wrot=
e:
>
> Hello,
>
> > "bcb81ac6ae3c iommu: Get DT/ACPI parsing into the proper probe path"
> > changes arm_smmu_probe_device sequence.
> >
> > From
> > pci_bus_add_device(virtfn)
> > -> pci_fixup_device(pci_fixup_final, dev)
> > -> arm_smmu_probe_device
> >
> > To
> > pci_device_add(virtfn, virtfn->bus)
> > -> pci_fixup_device(pci_fixup_header, dev)
> > -> arm_smmu_probe_device
> >
> > So declare the fixup as pci_fixup_header to take effect
> > before arm_smmu_probe_device.
>
> Applied to quirks, thank you!

Thanks Krzysztof

