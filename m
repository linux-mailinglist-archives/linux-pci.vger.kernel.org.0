Return-Path: <linux-pci+bounces-24680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72391A70514
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 16:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0070167474
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 15:33:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26A0419D891;
	Tue, 25 Mar 2025 15:33:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5D619D06A;
	Tue, 25 Mar 2025 15:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916785; cv=none; b=gzJyXjXPraucvIdIsjdyKlXE05d6P3AZGOWpeqfRh+xzKgSG6vj8/klAGK4zxlgl6WkXokDmxgTK0AG695nNFbNdL4mrlhLzRy2OGjPMgloq5pd3JZdU7h0L2tDaLNoTP7dGUY/67lZM01MqUZJviKmJGZ7Kt2fwWx5P5VwMkZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916785; c=relaxed/simple;
	bh=uOMaXxqQr1touZc2JkhdpC0WTA9CS+H9FhkB/6PIUEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCiO3yfxZODS3EQJSWbnQBwyDb/bURJBoJL/Am8rzhZC3dOGBy5OVoWKJArr4qEl7JgjqSQoptsZUbFcvZ/W9CURWlRRfkCuFXVIsalmTsmzPQajgTfIU1qk2ukFXUDes4cVCArbgb7/R8L8Y1ihTL2udMUh4IHpzfE8yBcPWCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ed1ac116e3so1502429a12.3;
        Tue, 25 Mar 2025 08:33:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742916778; x=1743521578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiWm+JkA0WFLQavBGxgJxiDDHRCBaxXFyxmdg7dNgng=;
        b=rgQSKt0kQoznYDixLWP3j1FjS30TXhk3J/HAxfelcAOx6TeSIqQKrJ9O20mimwi5N8
         N27HpvI3+K00N9Ga4Vn3AQKy5UtDvbdc9eXt5xP9VrUrW6n+1woduxYZ04j3+OcupmMj
         UZxg29L8gvzk4dLEUIlUYYzY/s8d7BpMGjR6oacE85099fmrhperpsaqOive9i3lBxd8
         olFxDAY/RQMSUNlbbu4swOs1Rgf5N57OtsOzcCz3h9YRGSNqqy4dz88+IcJdbPKVPkZF
         GJl7dJSfUPl/XKUcO4xYsl9SFUv1ngc4EmHYL+qRmDLygUyIpSq40xKGsmYrMcU0ciWj
         T53w==
X-Forwarded-Encrypted: i=1; AJvYcCW+Yky6KWS92LkFC92mz96LusuTmsj8LzU+mxJ/4CAsCDgO21DNMFmsYukebnyJUiL8WzRGAIaJQ65n@vger.kernel.org, AJvYcCWAGgoqier46grGozJwvqK57pgBH0uHZmKHG9JJr9KAiPNgfjdgXRcjwhiLBE2DTcffTfwUx+eHQes9@vger.kernel.org, AJvYcCWxUW951hIr6TFwtfnATJ2YmzXGwjupGPyx/MetwXpYEqg5IID/ow7igUqwjbsjjlDxeLU3ldx8KrWIIQ==@vger.kernel.org, AJvYcCXlaa8yI1FMExYICpHjEeUIUMjVe7654sv/vQ0DAvc1NdGqviu5vryxyg/7Eo2f7dvCqT/HfxAJG0hXVsp5Q7smspU=@vger.kernel.org, AJvYcCXn2g1ERRejXjyM9AVe5Q7M0GjpjeGUX1Fos314L5C+tH1AI6i0SsD5SAA5eH1SeCl//EcP1zY1JHjoCMf2@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa60gCgzxFGRaRUKkklZhYRmFWKzYxuoy7xZlVRSRcVOBLqTcs
	YZlZP2QmWBKWoZmPV49JCrEGt3lDc6+oZ2PRX5UCN6vxR9VI9kxdHoUP/NwCSOk=
X-Gm-Gg: ASbGnctTIIAGBZczhHFau4fq1tUwDm+SfxVf4EKNy0Hj5FwHRgmkSo4xBuIzNybH877
	8UF18L2iRz+xEcECY+ShuEFSX/tijUbzkC3wZHIc3Ccmf0Kj1FEJVzkOKWk3yb/Y0SEt7DXbQrv
	Mr+xbAMdjn1GXcqt/q8ksVSlGOlXLFQzaVo9Ijj4DFNXJKScefe15TkvPd1FddSDqp5GrwlzPEH
	4n7ul0YUK3+gJzGB15q6TCg6bslrtFfelAFc0W6CfVeP+ezkGSTk1XEi+URYbtE4+7TYHDM+KU3
	WwGFiC39bHkb8gxboJBFQ+3sbH9y8klbiYq5M8uvaLEgIgwNuGFgyqxOqmsphPY/XIeOJXu/4O3
	wrvsCOpI=
X-Google-Smtp-Source: AGHT+IEnYXidILRma17RiBJIRjyp0jlM9WGy4gjmIPyezv9wOSIz1ZxsSIppyqCysCuPcRsqiWaUQQ==
X-Received: by 2002:a05:6402:40cc:b0:5df:6a:54ea with SMTP id 4fb4d7f45d1cf-5ebcd431b67mr15218946a12.11.1742916778052;
        Tue, 25 Mar 2025 08:32:58 -0700 (PDT)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com. [209.85.218.48])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ebcce36d66sm7930433a12.0.2025.03.25.08.32.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 08:32:56 -0700 (PDT)
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-abf3d64849dso937660766b.3;
        Tue, 25 Mar 2025 08:32:56 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCU4Bwm+ckYUD5L7KIf48A8oS+TYMaEbd686t3MJNooJbOtCThvlnswUYIgHhVH1WIaWhxFUa9dqZvOZGd+d@vger.kernel.org, AJvYcCUHLUF1PThcnC8MzrD+2f1PiCpRjUwCtMi4Fr89iH6tGBuLdsGAliVnM4xYfFDoxYIlW5aWsPXXIaLbrFbxq6fxPso=@vger.kernel.org, AJvYcCV0hniPaqsqBuiwxMqcQ21ZIF7H6EoWKCRnSrCAhEW3zKO6CsKG0rzuEVSK3GAIK7F3NkPrvkzIeCHZ@vger.kernel.org, AJvYcCVtayZ4Pbcil+8TveHYdOVWkvDvyFUlGRnoIbGCwX8EC9SFUokR63YzVKqRlUZg3kqGkvUyfKOLUtaD@vger.kernel.org, AJvYcCWYkJyqc3diajLwPiDoSHzYz5y5vrvppx3VGBAkiW5qzLvofzGYAMVmgRWBF27qPUW4RV6+b1QTflZwMQ==@vger.kernel.org
X-Received: by 2002:a17:907:9494:b0:ac1:de84:dec0 with SMTP id
 a640c23a62f3a-ac3f24ed6c4mr1547143566b.26.1742916775525; Tue, 25 Mar 2025
 08:32:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1740753261.git.robin.murphy@arm.com> <e3b191e6fd6ca9a1e84c5e5e40044faf97abb874.1740753261.git.robin.murphy@arm.com>
 <CAMuHMdWPFnHTFeeWL2-BU8tKOL-E5K2ROOz=LLBLTJJLCK9NgA@mail.gmail.com> <25bd5477-a388-405f-a976-6b1a59860ef8@arm.com>
In-Reply-To: <25bd5477-a388-405f-a976-6b1a59860ef8@arm.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 25 Mar 2025 16:32:42 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXt9gQxBSVrWw1VSji+faxga4Vo_NRie27K=EtdUMMa_Q@mail.gmail.com>
X-Gm-Features: AQ5f1JoGJs3g1Wq6ZLZNBkuvqix5EpionY5Jl_k8v4NSQBsoSN9WndnQ0FJE0b0
Message-ID: <CAMuHMdXt9gQxBSVrWw1VSji+faxga4Vo_NRie27K=EtdUMMa_Q@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iommu: Get DT/ACPI parsing into the proper probe path
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>, 
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	Charan Teja Kalla <quic_charante@quicinc.com>, 
	Linux-Renesas <linux-renesas-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Robin,

On Tue, 18 Mar 2025 at 18:24, Robin Murphy <robin.murphy@arm.com> wrote:
> On 18/03/2025 4:37 pm, Geert Uytterhoeven wrote:
> [...]
> > Thanks for your patch, which is now commit bcb81ac6ae3c2ef9 ("iommu:
> > Get DT/ACPI parsing into the proper probe path") in iommu/next.
> >
> > This patch triggers two issues on R-Car Gen3 platforms:
> >
> > 1. I am seeing a warning on Renesas Salvator-XS with R-Car M3N
> > (but not on the similar board with R-Car H3), and only for SATA[1].
> > Unfortunately commit 73d2f10957f517e5 ("iommu: Don't warn prematurely
> > about dodgy probes") does not help:
> [...]
> >      Call trace:
> >       __iommu_probe_device+0x208/0x38c (P)
> >       iommu_probe_device+0x34/0x74
> >       of_iommu_configure+0x128/0x200
> >       of_dma_configure_id+0xdc/0x1d4
> >       platform_dma_configure+0x48/0x6c
> >       really_probe+0xf0/0x260
> >       __driver_probe_device+0xec/0x104
> >       driver_probe_device+0x3c/0xc0
>
> Hurrah, this is the warning doing the correct job - something *is* off
> if we're now getting here without the IOMMU configuration being done
> already (for a normal device with no other funny business going on).
>
> > 2. The IOMMU driver's iommu_ops.of_xlate() callback is called about
> > three times as much as before:
>
> That would suggest that the fwspec gets set up OK, then something later
> in the __iommu_probe_device() path fails and tears it down again, so the
> next attempt starts from scratch. Do you see the "Cannot attach to
> IPMMU" message firing?

I do not see such messages.

> And similarly to the Rockchip case, does the
> below help?

The below is basically the same as your "[PATCH] iommu/ipmmu-vmsa:
Register in a sensible order"[1].  While that fixes my first issue,
it does not fix the second (harmless?) issue.

Note that I only noticed the second issue because I have local debug
code in soc_device_match().  Perhaps it happens, unnoticed, on other
systems too?

Thanks!

[1] https://lore.kernel.org/53be6667544de65a15415b699e38a9a965692e45.1742481687.git.robin.murphy@arm.com/

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

