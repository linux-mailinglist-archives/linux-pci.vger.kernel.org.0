Return-Path: <linux-pci+bounces-36537-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D975B8AF3F
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 20:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AF05A14CC
	for <lists+linux-pci@lfdr.de>; Fri, 19 Sep 2025 18:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0878A25CC64;
	Fri, 19 Sep 2025 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V2Naj6cI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7754258ED2
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 18:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758307156; cv=none; b=AEptf7Mr4lKCajTuYlf/x5Wf+uSBmXwzQUauT0e+QcMkf9cjarPnkI6CtssXuvzn5TqQjX19mwhs1AOo1Koa2zbNKq4QlmQSZnPmSAcEYXk29cNqoQsaJp3dEfTtghHluF/MH4OkPc8DdU28yDeGlCHiQlp/K8N2AXH+FMYFKQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758307156; c=relaxed/simple;
	bh=Ct11LhwIefIHb2O884WTh/6Zx+FIVHNhDqoX9MNDrXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MoGHLMa3LnxKojPMZp41FxhaRMUcVY6EjJcGCUJodmIPNW8zz8ZsXuXMYLKOiYaH2un3BgQOE3FIeUZPBmMKfpvmIfRKa3xLrVfTDJ5oIqWam7G8agYG2YWylsQjQ+maEH4+Xad7dUFnw28ONpWdop571N6hzzSje2Q0BJqv6rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V2Naj6cI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84195C4CEFA
	for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 18:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758307156;
	bh=Ct11LhwIefIHb2O884WTh/6Zx+FIVHNhDqoX9MNDrXg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=V2Naj6cIAEjgn1mhpOyZq8HMzNa+1luR9NYD6O4SFlzfvRKKUhUzRUFNP2LbCUgQL
	 Rc7Q4P6nQIsxPtWarPx4T7DWAjxDfBkjUNQu3MAww+aQpO+cKUtaNR/ybRgwpvka9y
	 jfvxHbQxG7Qf8GOBkeFiX/8uXAAGfWDFNiEddzkmEUCuWtslsVMIc4e2smUahKVRos
	 FbyTE9m3tKz7F9kQVDAGVWHiGu61o73PEvSuLXe4+ZU80OOv/fJWFOFlZxB63YB4ZZ
	 6xqM1aKiAUJ62HxSNxJ/+Q7bCobZW5HOBRPC49DLz29/+stVXeu/ji8Z+0k6WIeUUW
	 jJWKKXqj3s2Ag==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-621cecfcc04so1262915eaf.2
        for <linux-pci@vger.kernel.org>; Fri, 19 Sep 2025 11:39:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXAiyNJLBLN88IPhxhz50gUlZYxha5pKzLNiBGlndSdj5sXfzDui+EegnHvV9yfsyU0RCSR/w9OQBg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6ktA4miPj40fZuDybvTBnfyi5dXk4AGE/1iuWK/kF1pmXeEIo
	lNy5DM9ureBxBlAw9qQTjNtxHJ6uOJP0O7QsPEHKRu8W1zj9IlSWEcTQ6Y9+mjEtahJJoEuNXGC
	+uDWeX77lHoceJpGL3HHb/0Oa3ETUkjk=
X-Google-Smtp-Source: AGHT+IFdDiO4c6I8+fwYdDAP53KWdXnY7AIE8DYhGvcX3arVDjyu4gQ6q1v6FzblRUv67UzUlKDgSnlvQzI3fIbRuAs=
X-Received: by 2002:a05:6808:6617:b0:43c:8714:fe3c with SMTP id
 5614622812f47-43d6c2d5221mr1884744b6e.51.1758307155786; Fri, 19 Sep 2025
 11:39:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250919163147.4743-1-tiwai@suse.de> <20250919163147.4743-3-tiwai@suse.de>
In-Reply-To: <20250919163147.4743-3-tiwai@suse.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 19 Sep 2025 20:39:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jbr8WKp3+POEMy_mz2daWMGDPWHGMhWc-Ac=rcPAzDkg@mail.gmail.com>
X-Gm-Features: AS18NWBPNeOzmlhHw6cGSvaEPN-qntWOFnUgeY0ibfSriSDCQgwKHKp0HyJqd1E
Message-ID: <CAJZ5v0jbr8WKp3+POEMy_mz2daWMGDPWHGMhWc-Ac=rcPAzDkg@mail.gmail.com>
Subject: Re: [PATCH 2/3] PCI: Use PM runtime class macro for the auto cleanup
To: Takashi Iwai <tiwai@suse.de>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 19, 2025 at 6:32=E2=80=AFPM Takashi Iwai <tiwai@suse.de> wrote:
>
> Use the newly introduced class macro to simplify the code.
> Also, add the proper error handling for the PM runtime get errors,
> too.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  drivers/pci/pci-sysfs.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
> index 5eea14c1f7f5..08e5cf2ba73e 100644
> --- a/drivers/pci/pci-sysfs.c
> +++ b/drivers/pci/pci-sysfs.c
> @@ -1475,8 +1475,9 @@ static ssize_t reset_method_store(struct device *de=
v,
>                 return count;
>         }
>
> -       pm_runtime_get_sync(dev);
> -       struct device *pmdev __free(pm_runtime_put) =3D dev;
> +       CLASS(pm_runtime_resume_and_get, pmdev)(dev);
> +       if (IS_ERR(pmdev))
> +               return -ENXIO;
>
>         if (sysfs_streq(buf, "default")) {
>                 pci_init_reset_methods(pdev);
> --

I've just realized that this patch won't work and the reason why is
that __pm_runtime_resume() returns an error if runtime PM is disabled
for a device, so pmdev above will be an error pointer in that case.

One possible approach may be to make pm_runtime_resume_and_get_dev()
return 0 and bump up the usage counter for devices with runtime PM
disabled.

