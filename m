Return-Path: <linux-pci+bounces-24681-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ECB47A70517
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 16:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7107C16750E
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 15:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF8B1A2389;
	Tue, 25 Mar 2025 15:33:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A517119DF4D;
	Tue, 25 Mar 2025 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742916793; cv=none; b=Og4GXQQIWjThT66EHHh1BdYkok50dpcozW29hdUTPCn0hLwI7MJuL5YEG3/Wre0uPWUUOZyGMHGW5b+J19+DulDupMAqeSYIbbQXNE99ZAHevJxJnoolOlHZhXbPyZGnh4ktt9SqLCp5VVq6Yx30OLSSg5qL4MKon5ZHbONu2jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742916793; c=relaxed/simple;
	bh=uOMaXxqQr1touZc2JkhdpC0WTA9CS+H9FhkB/6PIUEs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jgBT62ST0+tZzY5mBDCeVMB52FOKBvdvvq1FHZlUSSSWzEGwJ5AmsvKsoTcGSUn6nTWxITjbY4owsuACEVTtWk9HoulFBCNppUDImhjiO03JbHl5ADIM2Cgtp9jpOPlVBG52g7rO2Bp03YqFPCSxo3DEMgv5MJxocKo0UoGKn8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4774ce422easo16309461cf.1;
        Tue, 25 Mar 2025 08:33:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742916788; x=1743521588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PiWm+JkA0WFLQavBGxgJxiDDHRCBaxXFyxmdg7dNgng=;
        b=TTF7VR+KJVbXUhkdKWdXc3eOlPXndbxaZjCdD9bi/hy7xQe5V2BIDfjw1Jslhm+n/N
         xUNVn3dZXbxHUWUZVvt0W+a0aTb2ZIQwx8x5tR+Mhl6kFU78E00nl/gqxKV02frqYcdM
         +qSDdReI6fodQMlzcpY7pLhFUN7ttJ13nitr4UH2tigsqCtNSBtjzGMOMiUcu+PLUYw6
         c47da6ZmcPviuAbIO6uL9s8SRep+19EemnuAC0MsVxJ7wK7e6k7G/oqhTkwvgAwuEAH+
         uDB0mq3NiUKi6EpmpDF9kuFPKZqaOcLIhUXchYtr/gLgyMHw4ixa+RYa48Mr2j0idbOX
         ofdg==
X-Forwarded-Encrypted: i=1; AJvYcCUIWAGCGQNb/V2PDf/77Wa02yZjxOvBI3oA2T+edhYgrryeQVoP49sl0uYkdO3sogas16BDqfQs4ICSDQ==@vger.kernel.org, AJvYcCWJ7f2x11xB+uxsi6lPWkClhdqOisrLcsfp6HXMY3k3TE754u54bUYZs49voT7L8bmiDKXQNvSeZDVv@vger.kernel.org, AJvYcCX4bL3x8ngxuuowvJRZAOxeSj1yF8YdvoMqP0AoreLuzYzpzl/4ws3LTkIYV9g2BXvCn84/j1fK5w5o@vger.kernel.org, AJvYcCXOC1K7NFtAmVMHDkGWcZ9gi7k8bTMFwiBvpqDbzF2b58mI6nyi3kIxl9DFkn6UhjAHZX44k6Nnxs/9WsBn/u4iQ4A=@vger.kernel.org, AJvYcCXUTLRrBomv0jYzM6CD7/2Ke7RY/vWbMvPdtxsASU5q5v0AhZJz4+YYeuJ06JRAZrKCJjTJqBqxY11j87W2@vger.kernel.org
X-Gm-Message-State: AOJu0YzfRZr/crQdyprmk0W+1n12Ve25aGoDFKCguT/qYIvXxt3LLbFO
	x8+dE34D9Ry2UGmz3CS6y1C05EUFR2BeqRjxlhLML00hPZ4cczXR/Euj3yY+AW0=
X-Gm-Gg: ASbGncuF7p3VG5I0FYkNgQlLVBbkZRJTWcH705CbpljAsp5gXoeMRuonGH7PnqONFBJ
	6Q2SSrBat3c5isu4rv52eLs39mWNnEbXXOUD+MT/nQzmEVqeqddKvtV/OJ/FYAKL4j4OwpYSktA
	KQxqcRm4Xv+kup2WKxbyCA3J1YcIesJXs6BH2xzswDoA30R5kZtUaxY3nmwkgd5ETuLdc37hq4C
	MGAsITd51TJa2LCg8nat7zzDaeyGStNcyeJMrdKKIfQMxePo4qWGYj4mse3uf9qn8DzZEsnRG7w
	qTxyFMzer5aqlwr0m6TUyfOMCnMA0QTx8kQ40hVp45ys5mmgHnSkFWSiuibf62WF2AUjHBYP0qY
	yKOH9S3s=
X-Google-Smtp-Source: AGHT+IFqvTjsXvX3xul61e4WC7plgr7WMyl39JcGULtJxkbH1TVujp6hDW+oSamYLl5bCnwzLzVxyw==
X-Received: by 2002:a05:620a:170a:b0:7c5:3b3b:c9d8 with SMTP id af79cd13be357-7c5ba1ea6e4mr2203802585a.45.1742916786164;
        Tue, 25 Mar 2025 08:33:06 -0700 (PDT)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c5b9347bd1sm656352785a.70.2025.03.25.08.33.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Mar 2025 08:33:05 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6e8f8657f29so48608956d6.3;
        Tue, 25 Mar 2025 08:33:05 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUGWFz/Nd/Uq1ns2oZ4TQiX9VYEWIa12T22DocPIxbQ1zXn7ShV4HjsElRzkjEqMbvG9lSwZZI5sM5z6g==@vger.kernel.org, AJvYcCUYwgm2g04WJotS+bIzp0HSdaY6rpAnHvk4F/S5qcx2A8pEk75JgwWhO76i/df72+42tQwYEBCqpb9auXbQkThCqT4=@vger.kernel.org, AJvYcCUfMIwztbyw/hV4LtJ3Z+wM9Lngjmn/r20Khyk9zgj/2rtFay+SqiVJYtGfZKAbsfoqPBl7DH45B5Pt@vger.kernel.org, AJvYcCVq7NIEqOa/0DEBzQwQcqaxmIuXKxbaUXHkYpkCMl1yG+uSI6qRDYY64FFW4JufZIl0qcG6pWoQBj7lFP4z@vger.kernel.org, AJvYcCVzQxK6CbhN47vU8YSbK4+NC+b8nreTdBuG1I6jF2PyCenyRMsXV77o/iyZxd/TCOVaZJpVwnIISFqq@vger.kernel.org
X-Received: by 2002:a05:6214:20c7:b0:6e8:9085:5d2f with SMTP id
 6a1803df08f44-6eb3f339a37mr326036416d6.32.1742916785150; Tue, 25 Mar 2025
 08:33:05 -0700 (PDT)
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
X-Gm-Features: AQ5f1JrInfgh7M7jTSsfMUqSCBjPY93HktuBUK2sUhwTSlijqeY8n60NM1ex8dE
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

