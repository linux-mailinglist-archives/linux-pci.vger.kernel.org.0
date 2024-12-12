Return-Path: <linux-pci+bounces-18301-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 917899EF198
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 17:39:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F607285D76
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 16:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B94622EA11;
	Thu, 12 Dec 2024 16:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7O5RU96"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003032288C0
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 16:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734020998; cv=none; b=Jq3Y5aXNI/0DXESrycS4TCmDXS1R0qlCHwjSP7F6E429PM/jNRKzmxq1XwK8HEblQoR9orEjCu/iBQDpxpxpsDDXO+YMnBBCrvKcjqsKPxpalkCxWeB4/xrC/qsiwfgGu76PLDOSKTuPydfmZLHno0lPbOwyUsZNhOwHF/EcaUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734020998; c=relaxed/simple;
	bh=gWB0BRFebjk00pC71MJN03tHjsq+//flbOeVjL0eWzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 Cc:Content-Type; b=FwOqg/Hwd8taPjkYOwT3xhbnbSz2Z6IY8xRldTyFpT99n7dxOwpzYU07inhAPItNViVV/aydF/h+3J7s4pgtLu4BOE3816fp0Hfm943q9LdjhspbmW+bDPFlDRfMouYDHHf90aUBHAQ/WY03cuZcvnQWQ4ydga36EVgTEAbyv08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7O5RU96; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6f0054cb797so6831557b3.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 08:29:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734020996; x=1734625796; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XEKKU4f34dN8LXHWBVKUE3kcH8a2Htoh1juEAfVgWR0=;
        b=W7O5RU96fefaWLzwkMtvwQdVvIiEYMn/3BFp4ZKh3IlYPdAKJHxwRokJqvHVh5vjOF
         opJrL7olE8df8sIUtvUdVvAooHkcwUz6KX/DQJ06Kxo9XzcRnjmW8XMmTvl0oJDIijwq
         N+CGw+/EzDfviEeSsYYSJqK28tIZgDlJKICF2+yJC7eZC08p6ckj8fdDNSEpxjPweSSB
         ZxQxOQ2/rugb0RbMY/4nxPW+hTn898JTwvPTMwPmJCMD7nW8pznIB7FYz2BEbRlsGBWC
         /5NL0JXSipMUtGKCmLdzE25+yLVlhEmDIT2wRI9XkQHKxdJ6ydqwpWY/zFFAzs1DVXla
         PgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734020996; x=1734625796;
        h=content-transfer-encoding:cc:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XEKKU4f34dN8LXHWBVKUE3kcH8a2Htoh1juEAfVgWR0=;
        b=o5O/geOS1rCDPNXGEI8vtcZjmCbuMvkONIvG+mni0jGWAaNYDJVLKl61x/34dVw0//
         JR38qQxFek6Qcqd4ZajwmvNxieJaGTakO11o8nV7N2vVOe1Ik2f+mm0C22MmP/TlpG7C
         5fOUpIKCorD05Zowbvet0yCEyIATI469d/R8gBt3xiUHhGMhBP7ydqM3/A7oe4IQ+nV3
         Y0Sp+2QzJ3Q1JB2gDu5/C7J5cdyZP2mco3aVYwA3sL7OjYEsRrPomaPgdt9lrRDpWhGL
         9N7823iqXsB35bfMG70n/he8U3uPkRt23Kwg6S01bFY8vp7kfcOcDqoZAHfddKwob6iF
         qb5Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEQtEH30xfLXEGs6SfN5511veHB99pFv/szr9/7D2JzFiC99JfBz5pROwc2ceYOigZgpbI5I17SUA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzrx5c6wNmaphIXxnIc3+1Se6EDf4nHYW/cvSjWivGyu8Dye36R
	7TCcYX5k7wEoTjzztAerXBwBnIMuzdLEj2Ga28b+CNvAi18OdCSM3geRLqLvRfb7C1dNSr2G5o0
	3RwD2Mj/kF8cgW9xLl14cHUz3nrY=
X-Gm-Gg: ASbGncugGsgW3xlJ0bIlrdAm+xeQ+iOKQJuuzZjGfdRWIN81skHDpNSrStY/dfuJYDt
	U8+4wGy4TBPgy3ODfARJAODa/z4n2DyCCurCYOxw=
X-Received: by 2002:a05:690c:6903:b0:6ef:9e74:c09b with SMTP id
 00721157ae682-6f27534f4c5mt11111997b3.33.1734020995845; Thu, 12 Dec 2024
 08:29:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241212162547.225880-1-rick.wertenbroek@gmail.com>
In-Reply-To: <20241212162547.225880-1-rick.wertenbroek@gmail.com>
From: Rick Wertenbroek <rick.wertenbroek@gmail.com>
Date: Thu, 12 Dec 2024 17:29:19 +0100
Message-ID: <CAAEEuhrgqa+qDzr6O-FR8XYUHm05h2Nd4HG7=XVt9u7zqQm3yA@mail.gmail.com>
Subject: Re: [PATCH] PCI: endpoint: Replace magic number "6" by PCI_STD_NUM_BARS
Cc: rick.wertenbroek@heig-vd.ch, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 5:25=E2=80=AFPM Rick Wertenbroek
<rick.wertenbroek@gmail.com> wrote:
>
> Replace the constant "6" by PCI_STD_NUM_BARS, as defined in
> include/uapi/linux/pci_regs.h:
>
> Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>
> ---
>  include/linux/pci-epf.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 18a3aeb62ae4..ee6156bcbbd0 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -157,7 +157,7 @@ struct pci_epf {
>         struct device           dev;
>         const char              *name;
>         struct pci_epf_header   *header;
> -       struct pci_epf_bar      bar[6];
> +       struct pci_epf_bar      bar[PCI_STD_NUM_BARS];
>         u8                      msi_interrupts;
>         u16                     msix_interrupts;
>         u8                      func_no;
> @@ -174,7 +174,7 @@ struct pci_epf {
>         /* Below members are to attach secondary EPC to an endpoint funct=
ion */
>         struct pci_epc          *sec_epc;
>         struct list_head        sec_epc_list;
> -       struct pci_epf_bar      sec_epc_bar[6];
> +       struct pci_epf_bar      sec_epc_bar[PCI_STD_NUM_BARS];
>         u8                      sec_epc_func_no;
>         struct config_group     *group;
>         unsigned int            is_bound;
> --
> 2.25.1
>

The commit message was supposed to state :

---

PCI: endpoint: Replace magic number "6" by PCI_STD_NUM_BARS

Replace the constant "6" by PCI_STD_NUM_BARS, as defined in
include/uapi/linux/pci_regs.h:
#define PCI_STD_NUM_BARS       6       /* Number of standard BARs */

Signed-off-by: Rick Wertenbroek <rick.wertenbroek@gmail.com>

---

But the line starting with # got eaten away as a comment.
Sorry about that.
Best regards,
Rick

