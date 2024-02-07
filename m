Return-Path: <linux-pci+bounces-3191-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A72DD84C6EA
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 10:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC2131C23230
	for <lists+linux-pci@lfdr.de>; Wed,  7 Feb 2024 09:09:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433561F608;
	Wed,  7 Feb 2024 09:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b="o2F/n0we"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D642231F
	for <linux-pci@vger.kernel.org>; Wed,  7 Feb 2024 09:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707296960; cv=none; b=oQRwJ6YR1Vv9l3qAVrNLgab+OVcPBywZZYbaQKhlhY3HQNYNr2w+JM1sl+QpduZLB6aVmtAsK6NALlVvyXArR5evMqByovomhqFqjgzA9SDTTFh0TDNLVO3oon795M3G6lqIV6/K+l/+wmGBATZfKdnCnO22gWeegCI9PfR693I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707296960; c=relaxed/simple;
	bh=kL9Qa5KilatsDA9dOcsd2sr7TpU8RxZfa1NocdfsKHo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YXe+OiSe0okMgIWu4Jam0+DbDfmF4xrKkmADE0IFz3n1P8mlamBfotbFUna//HZu6rpAzkXPDSFvWxqOhzMqFPo/UIRu5RwqUkb4fhoIR+Mrp90J1GBzsR/7Im5puX38ee0FVnRF/OvVjoqRYzP0kf5bEv/F69wdGZExNxHupnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org; spf=pass smtp.mailfrom=endlessos.org; dkim=pass (2048-bit key) header.d=endlessos.org header.i=@endlessos.org header.b=o2F/n0we; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=endlessos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=endlessos.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dc25e12cc63so1326441276.0
        for <linux-pci@vger.kernel.org>; Wed, 07 Feb 2024 01:09:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos.org; s=google; t=1707296957; x=1707901757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IdNYaHzhP6aLq1DwaaQlYeeTpj0ps251+zH7kXwqcrU=;
        b=o2F/n0we/xLNS4/cYBC7cu6TfsuYDLlbvRk1ts2Fb2S6mrG/cJxde63ihj6VxN93/1
         SMD54K7v39MwacLiv+KCDS7oEoMf+AzBzBN9v2XiW6zcWYfMP75b4SpoLGMQj9GozD2O
         +JCwSswkTU4lmy2ijQYQE47+tR8GHbJdjg9DrEsQU8MRdT96jsc6ISh0k2RRYfSx3XIA
         aQb86PAmBk/xwG/6sPq/fGx2yL26GJnIYOcOJEpgcgZ9RcfsRLY2ttHRIaxPGPsP7GQh
         NtmOaLqaK7TkcTTIwSg93lGY4vpkt/ZoXT9vn2QtODbOrIWzBHvcEO7W/1fSfq3lxlE+
         DaOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707296957; x=1707901757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IdNYaHzhP6aLq1DwaaQlYeeTpj0ps251+zH7kXwqcrU=;
        b=KZq0bpSuIZWAjs/nl/DVGHh+nGlo0NHY/ZML5d8Lfo3jzKds9vuYZStwwYQ8gS+oLB
         13mzsVM5zXQ2WTcTduE+uihwCRPgKyn9ZS/UrRyRzptAjuEOWOxq/l8Qr6aQ83vwl3uM
         Rx57u5kUEg+W/YvfxiS+eJpei/r+F3q7d5oIDeEqBnH1fGt58Ztgrqof8VHysGDYmFdk
         peKW707i0EIZSd8/C0t0iF4mHi+Ph3hYm/MD9WTtnHrRBl7LEke/M24yCx2IQ+nxg3zC
         A89Bvpogmvjsj4HvrR7rUHczRtOm2GlhKF7pxFj9KwWDheTUhBQKXdI/XVzr+V2U1MGy
         ywMw==
X-Gm-Message-State: AOJu0Yx+4uj6BxwDIdduby2B7p2XmtGDKka0yqsyCdk6yyi2SDasGgWa
	1uOto2ZfCWFxkmtbe3ko2EjhMrpMV6RYrk8dbvHuzMjOEpcx8ssZrwVcS+Hgnx8cSXmiCm0NRX0
	U97sSYFbJdPD2qqMRi11adkNGhqFolUY454Q/0A==
X-Google-Smtp-Source: AGHT+IGI/sjUDIdU62Aw2X7CoIvmkWQz0p+NzMf8UuCStnMYVvDZdhQlqf/FP9/KnYi9EQAqimmbQxS4EJSxrJQ6m2M=
X-Received: by 2002:a25:ae98:0:b0:dc2:1f6b:be4c with SMTP id
 b24-20020a25ae98000000b00dc21f6bbe4cmr3307793ybj.22.1707296957197; Wed, 07
 Feb 2024 01:09:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207084452.9597-1-drake@endlessos.org> <20240207084452.9597-2-drake@endlessos.org>
In-Reply-To: <20240207084452.9597-2-drake@endlessos.org>
From: Jian-Hong Pan <jhp@endlessos.org>
Date: Wed, 7 Feb 2024 17:08:41 +0800
Message-ID: <CAPpJ_edoG0dD4aHZiZShcFMoD2JLQhbh7nuUPzgMT_ZMySJ=VQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Revert "ACPI: PM: Block ASUS B1400CEAE from
 suspend to idle by default"
To: Daniel Drake <drake@endlessos.org>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, bhelgaas@google.com, 
	david.e.box@linux.intel.com, mario.limonciello@amd.com, rafael@kernel.org, 
	lenb@kernel.org, linux-acpi@vger.kernel.org, linux@endlessos.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Daniel Drake <drake@endlessos.org> =E6=96=BC 2024=E5=B9=B42=E6=9C=887=E6=97=
=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=884:45=E5=AF=AB=E9=81=93=EF=BC=9A
>
> This reverts commit d52848620de00cde4a3a5df908e231b8c8868250, which
> was originally put in place to work around a s2idle failure on this
> platform where the NVMe device was inaccessible upon resume.
>
> After extended testing, we found that the firmware's implementation of
> S3 is buggy and intermittently fails to wake up the system. We need
> to revert to s2idle mode.
>
> The NVMe issue has now been solved more precisely in the commit titled
> "PCI: Disable D3cold on Asus B1400 PCI-NVMe bridge"
>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D215742
> Signed-off-by: Daniel Drake <drake@endlessos.org>

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>

> ---
>  drivers/acpi/sleep.c | 12 ------------
>  1 file changed, 12 deletions(-)
>
> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
> index 808484d112097..728acfeb774d8 100644
> --- a/drivers/acpi/sleep.c
> +++ b/drivers/acpi/sleep.c
> @@ -385,18 +385,6 @@ static const struct dmi_system_id acpisleep_dmi_tabl=
e[] __initconst =3D {
>                 DMI_MATCH(DMI_PRODUCT_NAME, "20GGA00L00"),
>                 },
>         },
> -       /*
> -        * ASUS B1400CEAE hangs on resume from suspend (see
> -        * https://bugzilla.kernel.org/show_bug.cgi?id=3D215742).
> -        */
> -       {
> -       .callback =3D init_default_s3,
> -       .ident =3D "ASUS B1400CEAE",
> -       .matches =3D {
> -               DMI_MATCH(DMI_SYS_VENDOR, "ASUSTeK COMPUTER INC."),
> -               DMI_MATCH(DMI_PRODUCT_NAME, "ASUS EXPERTBOOK B1400CEAE"),
> -               },
> -       },
>         {},
>  };
>
> --
> 2.43.0
>

