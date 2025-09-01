Return-Path: <linux-pci+bounces-35276-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37B4EB3E6EA
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 16:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1A9E4447E2
	for <lists+linux-pci@lfdr.de>; Mon,  1 Sep 2025 14:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E22F341650;
	Mon,  1 Sep 2025 14:22:34 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4D612FA0FF;
	Mon,  1 Sep 2025 14:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756736554; cv=none; b=fAwP5qVeNBq1Etk95jMGyfnJPxyywRYfi6vFdivyoOu3cEvKZiuDRaQcjyMidE28K7gXA31lxDiX4THr/1rkmEtsgsfs+dBYjmktiI5aD2sg+IPQObrRZEi0BBwxTGttupitHPR270hMFtUz8ih/jeP+CfiOJAfI9CM4nof5PBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756736554; c=relaxed/simple;
	bh=hhl4zlAske+6hd2beTuG0YEKdJgjf0YEOktmfvEYST0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6vXhHjNzW26eX72gkV9uLZ7kOXwaKxDg6yQX+XVq7njxYq/pf8xTXiiqMrqFXPJ/2A304Deo+xSgKqKQRoQJ8+Y21g9phVmuBu5iCt9ztG9DToMyBXKnKw2lwC+DCqBVDASOnNelhAM9LQ8P5+zmomwy8nJvtoxogdDBM0sQFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-541f5f63bc9so3282298e0c.1;
        Mon, 01 Sep 2025 07:22:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756736551; x=1757341351;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZLSh+dplZEwqkEY2vG9Ve5oAn8yIPZsqSTneX9R1ncI=;
        b=v0aoxuA2cQ2o89uBABmTmjTy9xALEnlLuMh0c7Y0aGvbyGTDnr2/d2m+3sZvdIeSr0
         WBM0YyWsVfLSg7vcmagDqt3CVSJxUAARlomhLaALAAWcBWn1Y69+5Oiz0r9uM0sj4oMk
         ocrohOEJNbzqmJGZzuvV83wHIjImd7HDSfTtwOANn4UXN9ynG0FZYzAbVkj96hYGVf/x
         8nXH3vYUYNjrS8bT4sOnN1bvnZwjIDNYlWMEb0Fs9MpwL2ahD3xTMKxTsF2UHqv5TU/D
         PZwJy+kDV7WqioQUg8k9S962H+gOdzS7Jaudff7iO7Fd6tYPxyz8f5KIKjV6IkdqjMnK
         3kFg==
X-Forwarded-Encrypted: i=1; AJvYcCUFPld4OzW5NQl7A+ZE+AnXpgqy+wC4X3gRFVInn5VK2wXInLur6bHzk6/O7oezsV/vU/izObMRfrrAAB8lSB3AA5A=@vger.kernel.org, AJvYcCUnTBzKQvPFycbiFmfjjq0GvzV9AGUJMZ9RrHFWDEtvcIYUF4Euu2coxcW3KVBUIbKxOC6TptZj97knZHIG@vger.kernel.org, AJvYcCVsSUu/kJJY/Ev0EyFq9tcpshUwtYYKhsShLASYpltF6WfpwVkjmmf3syVFoiJkyv5sMHfuw5D3XHs/@vger.kernel.org, AJvYcCWyRU6DtfqPLBJSuUG9MZZBrWAsy/hnIsnP1GoSGHjNjBVv+f/xz4TaqaYfQpcb1OUkxK3I2VIS3+8Y@vger.kernel.org, AJvYcCXHMSTR/eDhrl0ooXfHV6OmSjT9q/wtdVFmMWLNleTR644UIrX6kvd32vq93grDaGK2Gt1yemnJ4PNo@vger.kernel.org
X-Gm-Message-State: AOJu0YxBDKj1Zp7kJnEfSgPbZD+zwx7tMaYNPkB52gBYzF5cqMOqMJ/P
	BREmIoqN94yPfpw2g1S5PNv2LVKoKr5bGTg2yyxPCOKE0dsUf4/25gp1CTAnIMSJsY8=
X-Gm-Gg: ASbGncsMwiEN6U0iCiD2CnBF/7bZ8fV/vZ/0+Sdc1D0otjo5P1Q+LxAS39yG2XDolYz
	KQlwsijzTqh5Q1HeSQAW2YpzC/YXA6wAKtKEe6q+A4ENtS9vmWMt4le4cRyKeuIVOSclBlTJIHW
	s0J2wlp9fnyozk1U8RF1htqeUngIqo01zAV6GBO2Gpd1l1MzjicGMHaannl1OOf4QAsHKsgU130
	ENUy1VsKiBtK6ekuaZQRRNqjVRoSxx72WnRQtaBJpHgRebDBBcFrTb8pMf5+BATov96hnRKjclW
	n6q6PQsu7Kw7h9bZqQlhF+5B80adV9wNzT7URka3t0O1wotyGc4ektQebg4hR7PjWnljWrrDvWS
	LpfqjyobGsCt6N3WlDTZh4DAdmHpvy/lB9yR2u6YhCN9JPrZ/SgO/cvviO6KAfeta4FutzL0=
X-Google-Smtp-Source: AGHT+IGC257Aw+fZqXY2/N7+wrXBPK23LMp16sDZmIRYFaUG/SgrNrcH3CfrUWyvy1KMBk7MjoDL3Q==
X-Received: by 2002:a05:6122:2022:b0:544:8e42:aac with SMTP id 71dfb90a1353d-544a01c9c7fmr2966331e0c.4.1756736551196;
        Mon, 01 Sep 2025 07:22:31 -0700 (PDT)
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com. [209.85.217.43])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-54491464a00sm4366781e0c.16.2025.09.01.07.22.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Sep 2025 07:22:30 -0700 (PDT)
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-5299769c79cso2031008137.3;
        Mon, 01 Sep 2025 07:22:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUZzJg+nBj8o49Z8HxedbGnuD+K10k0K55/USha4BDDETfZpRKXMMWqjg8j/IIMDPOuvKjVVUGki2Kvn890ptFUGKs=@vger.kernel.org, AJvYcCVqNF2g1EtzcM0ATyVwR5NXwTRI1J8dDIlCPMFKaVKMYF0poEmlv6VyI0ZZJgyVvxAPxrjSKmxfA1VsX4Sx@vger.kernel.org, AJvYcCWSLzKsTIAK+eSTZ3uZYP/ETwzJdrQVTwxKj+E1vjusyUZdK7oHTbU3l8m5DA8jGKK+HSemMVdVUm6B@vger.kernel.org, AJvYcCWajs9Acl6kied5UiRurUEv7cCOgDSXN2Svcez7Kuyp3IU9AVowWTJxBcX8NmmSH9Y0DF0T+eNu4Q4e@vger.kernel.org, AJvYcCXgxgNTEbKiOvgRHaosvxpHlEw0qF+i/vTZykUQnsh/cMuP4f1yJI1DVRchH/ff/6ZioBmHb+4csrR8@vger.kernel.org
X-Received: by 2002:a05:6102:6a8c:b0:519:f3b6:a1ae with SMTP id
 ada2fe7eead31-52b1bb104c4mr2181488137.22.1756736549969; Mon, 01 Sep 2025
 07:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704161410.3931884-1-claudiu.beznea.uj@bp.renesas.com>
 <20250704161410.3931884-6-claudiu.beznea.uj@bp.renesas.com>
 <ddxayjj5wcuuish4kvyluzrujkes5seo7zlusmomyjfjcgzcyj@xe3zzzmy2zaj>
 <8ef466aa-b470-4dcb-9024-0a9c36eb9a6a@tuxon.dev> <zsgncwvhykw4ja3bbqaxwupppjsqq4pcrdgrsduahokmt72xsm@twekpse6uzzh>
 <CAMuHMdUu0uXBJndcwWoZp8NNyBJox5dZw4aoB8Ex50vBDDtP7g@mail.gmail.com> <6f2hpdkonomgrfzqoupcex2rpqtlhql4lmsqm7hqk25qakp7ax@bfrzflghmnev>
In-Reply-To: <6f2hpdkonomgrfzqoupcex2rpqtlhql4lmsqm7hqk25qakp7ax@bfrzflghmnev>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 1 Sep 2025 16:22:16 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUEqKc+qtRXiPzgjhWaer5KLroZ+hCSVLCQ497h3BtOAw@mail.gmail.com>
X-Gm-Features: Ac12FXyQcXb7KMSqJ3_EYSyMFOnb1q5L0gNjUWq7UpBRH6SSlGff4BAwA-gDtnc
Message-ID: <CAMuHMdUEqKc+qtRXiPzgjhWaer5KLroZ+hCSVLCQ497h3BtOAw@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] PCI: rzg3s-host: Add Initial PCIe Host Driver for
 Renesas RZ/G3S SoC
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>, bhelgaas@google.com, lpieralisi@kernel.org, 
	kwilczynski@kernel.org, robh@kernel.org, krzk+dt@kernel.org, 
	conor+dt@kernel.org, magnus.damm@gmail.com, catalin.marinas@arm.com, 
	will@kernel.org, mturquette@baylibre.com, sboyd@kernel.org, 
	p.zabel@pengutronix.de, lizhi.hou@amd.com, linux-pci@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-clk@vger.kernel.org, Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>, 
	Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"

Hi Mani,

On Mon, 1 Sept 2025 at 16:04, Manivannan Sadhasivam <mani@kernel.org> wrote:
> On Mon, Sep 01, 2025 at 11:25:30AM GMT, Geert Uytterhoeven wrote:
> > On Sun, 31 Aug 2025 at 06:07, Manivannan Sadhasivam <mani@kernel.org> wrote:
> > > On Sat, Aug 30, 2025 at 02:22:45PM GMT, Claudiu Beznea wrote:
> > > > On 30.08.2025 09:59, Manivannan Sadhasivam wrote:
> > > > > On Fri, Jul 04, 2025 at 07:14:05PM GMT, Claudiu wrote:
> > > > >> From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> > > > >>
> > > > >> The Renesas RZ/G3S features a PCIe IP that complies with the PCI Express
> > > > >> Base Specification 4.0 and supports speeds of up to 5 GT/s. It functions
> > > > >> only as a root complex, with a single-lane (x1) configuration. The
> > > > >> controller includes Type 1 configuration registers, as well as IP
> > > > >> specific registers (called AXI registers) required for various adjustments.
> > > > >>
> > > > >> Hardware manual can be downloaded from the address in the "Link" section.
> > > > >> The following steps should be followed to access the manual:
> > > > >> 1/ Click the "User Manual" button
> > > > >> 2/ Click "Confirm"; this will start downloading an archive
> > > > >> 3/ Open the downloaded archive
> > > > >> 4/ Navigate to r01uh1014ej*-rzg3s-users-manual-hardware -> Deliverables
> > > > >> 5/ Open the file r01uh1014ej*-rzg3s.pdf
> > > > >>
> > > > >> Link: https://www.renesas.com/en/products/rz-g3s?queryID=695cc067c2d89e3f271d43656ede4d12
> > > > >> Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
> > > > >> Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
> >
> > > > >> +  ret = pm_runtime_resume_and_get(dev);
> > > > >> +  if (ret)
> > > > >> +          return ret;
> > > > >> +
> > > > >
> > > > > Do you really need to do resume_and_get()? If not, you should do:
> > > >
> > > > It it's needed to enable the clock PM domain the device is part of.
> > > >
> > >
> > > I've replied below.
> > >
> > > > >
> > > > >     pm_runtime_set_active()
> > > > >     pm_runtime_no_callbacks()
> > > > >     devm_pm_runtime_enable()
> >
> > > > >> +static int rzg3s_pcie_suspend_noirq(struct device *dev)
> > > > >> +{
> > > > >> +  struct rzg3s_pcie_host *host = dev_get_drvdata(dev);
> > > > >> +  const struct rzg3s_pcie_soc_data *data = host->data;
> > > > >> +  struct regmap *sysc = host->sysc;
> > > > >> +  int ret;
> > > > >> +
> > > > >> +  ret = pm_runtime_put_sync(dev);
> > > > >> +  if (ret)
> > > > >> +          return ret;
> > > > >
> > > > > Since there are no runtime callbacks present, managing runtime PM in the driver
> > > > > makes no sense.
> > > >
> > > > The PCIe device is part of a clock power domain. Dropping
> > > > pm_runtime_enable()/pm_runtime_put_sync() in this driver will lead to this
> > > > IP failing to work as its clocks will not be enabled/disabled. If you don't
> > > > like the pm_runtime_* approach that could be replaced with:
> > > >
> > > > devm_clk_get_enabled() in probe and clk_disable()/clk_enable() on
> > > > suspend/resume. W/o clocks the IP can't work.
> > >
> > > Yes, you should explicitly handle clocks in the driver. Runtime PM makes sense
> > > if you have a power domain attached to the IP, which you also do as I see now.
> > > So to conclude, you should enable/disable the clocks explicitly for managing
> > > clocks and use runtime PM APIs for managing the power domain associated with
> > > clock controller.
> >
> > Why? For the past decade, we've been trying to get rid of explicit
> > module clock handling for all devices that are always part of a
> > clock domain.
> >
> > The Linux PM Domain abstraction is meant for both power and clock
> > domains.  This is especially useful when a device is present on multiple
> > SoCs, on some also part of a power domain,  and the number of module
> > clocks that needs to be enabled for it to function is not the same on
> > all SoCs.  In such cases, the PM Domain abstraction takes care of many
> > of the integration-specific differences.
>
> Hmm, my understanding was that we need to explicitly handle clocks from the
> consumer drivers. But that maybe because, the client drivers I've dealt with
> requires configuring the clocks (like setting the rate, re-parenting etc...) on
> their own. But if there is no such requirement, then I guess it is OK to rely on
> the PM core and clock controller drivers.

When you need to know the actual clock rate, or change it, you
indeed have to handle the clock explicitly.  But it still may be enabled
automatically through the clock domain.

> > > But please add a comment above pm_runtime_resume_and_get() to make it clear as
> > > most of the controller drivers are calling it for no reason.
> >
> > Note that any child device that uses Runtime PM depends on all
> > its parents in the hierarchy to call pm_runtime_enable() and
> > pm_runtime_resume_and_get().
>
> Two things to note from your statement:
>
> 1. 'child device that uses runtime PM' - Not all child drivers are doing
> runtime PM on their own. So there is no need to do pm_runtime_resume_and_get()
> unless they depend on the parent for resource enablement as below.

It indeed depends on the child device, and on the bus.  For e.g. an
Ethernet controller connected to a simple SoC expansion bus, the bus must
be powered and clock, which is what "simple-pm-bus" takes care of
("simple-bus" does not).

> 2. 'child devices depending on parents in the hierarchy' - Again, not all
> child drivers require their parent to enable the resources. In those cases, they
> can just call pm_runtime_set_active() and pm_runtime_enable() in their probe.
> There is absolutely no need to do pm_runtime_resume_and_get() AFAIK (correct me
> if I'm wrong).

pm_runtime_set_active() may be sufficient, but I am not 100% sure.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

