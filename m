Return-Path: <linux-pci+bounces-13213-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 896ED9792C9
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 20:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B5B1C212D9
	for <lists+linux-pci@lfdr.de>; Sat, 14 Sep 2024 18:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A8A1D0949;
	Sat, 14 Sep 2024 18:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMD/hH/d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7F311CF2A7;
	Sat, 14 Sep 2024 18:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726337082; cv=none; b=OjHoijCMWtToeILnf3R48gRiIQa76Vbg9O852lYJRuhXxdW4IyR4E2WYaz+71bkmVCNTTVBDDKIpYqlAMeUVURHw+0zcCsUoRzzF4ycPmc5QbbbrdKY0AsgdHUL6MCXI0uAcc0EoeKdZ6Er2LqS5XFCMnJgLwKXwB+r5DoMI9u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726337082; c=relaxed/simple;
	bh=K88C5abGq4bEw+238ZrYSSvrXj0Fgoptaw+U+a/6TAA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h2ksrr9B5CBQ1EmRcawzxNaLBVOM3cGmFKZAsdPgW5Abw6sXOR1M52ZFmkdSwJ1bcMuKa7GvBv1hHO17IFutZhIxDzaMunbNmwAsiabTfKErICMJn+rmuqMprinsZyo5b1HBUGDVbfy3/Kc5lcB18iTFFoDzThaI++h38N98XXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SMD/hH/d; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-4585e250f9dso21245251cf.1;
        Sat, 14 Sep 2024 11:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726337080; x=1726941880; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k9Eb6mNSgQyhJLiS9HOCfo7oXhGl9Cvu9sqNifx8AvI=;
        b=SMD/hH/dXYmasOvk8XPEqTSN8in36+g/ItMGKx4ANSoA5E2TJ9akG/Y5LGcK5mpK/P
         L9bKZBqEs4RW7iEtNutW70WhQZ5bQk/ZAoiRIOlAf9SHRyHRk9fgNEaoMEFl5UQU3cyx
         1f2qGldF1C32WSdlYseZ54dPqRQMEvEa2ezk0+1Ob1DNFxYwKhsWOQ/O/9gGCo2l77I5
         YBTH+185H9XTorl8dzeM3SRMvyBPwpOqrm73nASmNsa/frEaEm9hiEU+0FYjbDpLHh2A
         dFs2o9ZhwCPSgwl98adxlGwa9XL9fjC7cLNupCoTGLGiJPutBGGw6h+BSvP9xUSVGKH8
         tdiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726337080; x=1726941880;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k9Eb6mNSgQyhJLiS9HOCfo7oXhGl9Cvu9sqNifx8AvI=;
        b=vtBD23rA1tWXTmKzqGkXnfmjmxCelH8hDrMeTkhpW0uEXznCrKc0IwR6ZrPab0rHBy
         evZY393NiTcrfd//bm5yK2bC5Atox+ogM/wxkAy8l43t/fsi4PXbIf6bw0CLnNnJhjJy
         J/RxAW4Dk4I4c69xw0LnljYhOwuOGiEdf1vst2SJjPNwa/HmrTxZA+K42I4Cso0EVlTj
         ySnfm1YEvmqL6GL+pzvN4t/x/Kn0VAguHgdk4Yo/AguHXv4mClSPeFc+3mHAWUMbDS1U
         khIqweOrZqnogy63C+nAyYaaA7M/+QsApiDGCUBmFaiwYbWS8W9flBnjJJb+bY0tsacR
         ajfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUfvKELw+I5xEjumoSKls3cbBIwrmAvWzFKplvAbGVl79Gz0Dmzgxx/mtymfPSIvjksCpMWq6pOHKLW9CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBeiWP+PqZ7sAfdjGdL7fIXkTfrRfzrsy9dWvBCDxS6rwnD2LX
	HKn6IPxp3K3HQuc+0yqp+tQtk/GjNL3EDyFVt+k6QN0fjIGOe2pZUQsJZyT/R6ROHRcWqvkxdPa
	79MjVzDF8uKjKLeHSh75vFIGMgM4=
X-Google-Smtp-Source: AGHT+IF5tzSw8i79B84DGHGmJKS+6+hpUK4gompHkFdSomAMJ5vt3D7G81sYHh0Bn0ejqOkj2NWsscU+lD3EorqJKVM=
X-Received: by 2002:a05:622a:352:b0:456:802c:a67e with SMTP id
 d75a77b69052e-458602ac826mr160998271cf.3.1726337079757; Sat, 14 Sep 2024
 11:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240914174554.98975-1-trintaeoitogc@gmail.com>
In-Reply-To: <20240914174554.98975-1-trintaeoitogc@gmail.com>
From: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Date: Sat, 14 Sep 2024 15:04:03 -0300
Message-ID: <CAM_RzfaM9BScunyGHmiiWTAG_TzybEfaxHOWYemcg47mix_X8w@mail.gmail.com>
Subject: Re: [PATCH] PCI: remove uneccessary if() and assignment
To: bhelgaas@google.com
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Guilherme Giacomo Simoes <trintaeoitogc@gmail.com> wrotes:
>
> This second if is uneccesary, because, the first if is equals.
> The assignment os return pci_revert_fw_address() to ret variable is uneccessary to.
> Then, the second if() was removed and the return function is the return of pci_revert_fw_address()
>
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
> ---
>  drivers/pci/setup-res.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/pci/setup-res.c b/drivers/pci/setup-res.c
> index c6d933ddfd46..8ca1007cb6b3 100644
> --- a/drivers/pci/setup-res.c
> +++ b/drivers/pci/setup-res.c
> @@ -352,12 +352,7 @@ int pci_assign_resource(struct pci_dev *dev, int resno)
>          */
>         if (ret < 0) {
>                 pci_info(dev, "%s %pR: can't assign; no space\n", res_name, res);
> -               ret = pci_revert_fw_address(res, dev, resno, size);
> -       }
> -
> -       if (ret < 0) {
> -               pci_info(dev, "%s %pR: failed to assign\n", res_name, res);
> -               return ret;
> +               return pci_revert_fw_address(res, dev, resno, size);
>         }
>
>         res->flags &= ~IORESOURCE_UNSET;
> --
> 2.46.0
>

Please disregard this patch.

