Return-Path: <linux-pci+bounces-10580-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F1E938776
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 04:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75074280A0B
	for <lists+linux-pci@lfdr.de>; Mon, 22 Jul 2024 02:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD5638C1A;
	Mon, 22 Jul 2024 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tsEi8vee"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9144D12B73;
	Mon, 22 Jul 2024 02:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721614331; cv=none; b=fnyzZ08xwjoWUY/18koGt8xAVqXI+XADkJdM0pDl+jxftABq3fjUStBI/aWhy9flnqIpCqtCTIfKu21baMK6zUH6/JTzpwOM+MPzQEiT1sXQJt9KzeBSlWuaD2H0M7oYRBnXVp6ekr/Ca4jQzDmueFt/nNwjAtU3nuzl8d0yUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721614331; c=relaxed/simple;
	bh=azGo6m46VBgBM9ZicAuLCQPYP/jnz/425Y1D8wyAsVs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cI9TLb7FgdXLXmlknTQNVu3Lo6T5OAj8MNz8Se2q2l9i6gADDodDHVIFBGj/GPsemiweDlh8pYZpORc4y0ETBT+QrfQX9KZsBvFvYCW3r0efk3SvMak4Pj5mLuiyPXo9+h7zp/ZsMm8igT9ZBbcPayKmIgD4cXAkPIY1Sqswq4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tsEi8vee; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 367CBC4AF10;
	Mon, 22 Jul 2024 02:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721614331;
	bh=azGo6m46VBgBM9ZicAuLCQPYP/jnz/425Y1D8wyAsVs=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=tsEi8veetkfkyxkB9x7XLhxI2FAksP4bmdPcxjHVjWOzbS6wkOnxStTFAKaQEzP2V
	 g0bxLloMauq9ZiEu9BBq/BST3CiP0t+VN4GHANsJ2LNH7vctGUk+FMvpMXJ6R/g67K
	 CyM7n7Owu6tWPTDoEHlUPC9jtV76+zGVFBNDXeEXnygONxu4wXF9vhmxTkYihFjmOX
	 UmZ+184CPjWcKwx8cS0fA+LVoTsL1oBJzQ410k0srnTR/TymT1lHSiOK9ugqGHIjwg
	 BQtZS7/lT4rNW3pJxa/DctqwDGsvAK/MVmlUFhXUyVkYQQNhYLdt/Ztyr/uXy+f3/a
	 I2uWO8qkbrBmA==
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so26585005e9.2;
        Sun, 21 Jul 2024 19:12:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXsvZIBRPSEXOHlOJAD54IiMWnsNXQfo6Zu/khk2Io5HDeR4ggQv/FZP63cDsHixVBpevZOWnnwRuS1oat7w8yyaWi25bJEzrGipjGTO78CZyzE437sXTyUm/Ymrp0S5IJggni6129GVdyIqFk+heLVXfFi6IQcOU64jkkyi/I8
X-Gm-Message-State: AOJu0Yy/JZkA4B+6pjGjNstEJMD6oXReEm7HouSywBWhvTVPqnkKvyxJ
	qvieR1VBiWwHdlOKUsWZyvg/ZZKBEtUrc0g0U2ZLuZGWuMMIughigwnkPPmZfV27WX93zsWYxKe
	RG5VGeuXzQdLzf9gueF6keYpNe3k=
X-Google-Smtp-Source: AGHT+IGT2WyeMDoqlKn1hDkEnwla+7lIh3WrUDuFvKGwxfwhDAI2HdQ/PAipMwCTm53YaP4pWdsbl0fcuJ39F0MwmrE=
X-Received: by 2002:adf:cc81:0:b0:367:947a:a491 with SMTP id
 ffacd0b85a97d-369bae6427emr3154183f8f.26.1721614329748; Sun, 21 Jul 2024
 19:12:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240613074258.4124603-1-zhanghongchen@loongson.cn>
In-Reply-To: <20240613074258.4124603-1-zhanghongchen@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Mon, 22 Jul 2024 10:11:57 +0800
X-Gmail-Original-Message-ID: <CAAhV-H4TSHqRg0F8xKb32g5CO2aQv=ibL2D_jqn8eUF8+yEZag@mail.gmail.com>
Message-ID: <CAAhV-H4TSHqRg0F8xKb32g5CO2aQv=ibL2D_jqn8eUF8+yEZag@mail.gmail.com>
Subject: Re: [PATCH v3] PCI: pci_call_probe: call local_pci_probe() when
 selected cpu is offline
To: Hongchen Zhang <zhanghongchen@loongson.cn>
Cc: Markus Elfring <Markus.Elfring@web.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	Alex Belits <abelits@marvell.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, 
	Nitesh Narayan Lal <nitesh@redhat.com>, Frederic Weisbecker <frederic@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
	stable@vger.kernel.org, Huacai Chen <chenhuacai@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

gentle ping?

Huacai

On Thu, Jun 13, 2024 at 3:43=E2=80=AFPM Hongchen Zhang
<zhanghongchen@loongson.cn> wrote:
>
> Call work_on_cpu(cpu, fn, arg) in pci_call_probe() while the argument
> @cpu is a offline cpu would cause system stuck forever.
>
> This can be happen if a node is online while all its CPUs are
> offline (We can use "maxcpus=3D1" without "nr_cpus=3D1" to reproduce it).
>
> So, in the above case, let pci_call_probe() call local_pci_probe()
> instead of work_on_cpu() when the best selected cpu is offline.
>
> Fixes: 69a18b18699b ("PCI: Restrict probe functions to housekeeping CPUs"=
)
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
> Signed-off-by: Hongchen Zhang <zhanghongchen@loongson.cn>
> ---
> v2 -> v3: Modify commit message according to Markus's suggestion
> v1 -> v2: Add a method to reproduce the problem
> ---
>  drivers/pci/pci-driver.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index af2996d0d17f..32a99828e6a3 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -386,7 +386,7 @@ static int pci_call_probe(struct pci_driver *drv, str=
uct pci_dev *dev,
>                 free_cpumask_var(wq_domain_mask);
>         }
>
> -       if (cpu < nr_cpu_ids)
> +       if ((cpu < nr_cpu_ids) && cpu_online(cpu))
>                 error =3D work_on_cpu(cpu, local_pci_probe, &ddi);
>         else
>                 error =3D local_pci_probe(&ddi);
> --
> 2.33.0
>
>

