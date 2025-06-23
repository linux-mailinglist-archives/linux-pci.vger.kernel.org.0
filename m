Return-Path: <linux-pci+bounces-30437-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB474AE4BF9
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 19:33:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52AEC17BF69
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 17:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507062C15BE;
	Mon, 23 Jun 2025 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b="h0IrKGpt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B75092BCF4C
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750700007; cv=none; b=lJqoPaIeQjc5Tuxj3gRw32crQpGJuqDYna1OT33zUvjXRsbaKQziCaWLC6LjUwnZQNCQoB2uER6SSP0pdTVciYMwuoWVHRweqmVg07H3pI6UwKeGf0s9Gg/Q3+rFmIsYRWxtYuk1qiaxPFN8O9xRWZKnhpcAD+LNhkrBcQctu7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750700007; c=relaxed/simple;
	bh=9ESxItapZGpeX27bCqCWykYCjM+yU4vTWbwqb34xOmU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ja2xCneYI6rIiMHZ7/t7h9cx/Uy9qZ2jvH6TliuES+WmTaLiKCEVtexuyji4KTW4z1iFo2qcqOrCAsUO5jLYO+/EPM5dcWxyI0l2Vq7UqUkvD5QYZL2P/Sew/ZtXH6yYCOjonlRMxImDWSnVuuGjw2WbLo4+yJnWvJaimYXMjf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com; spf=pass smtp.mailfrom=gateworks.com; dkim=pass (2048-bit key) header.d=gateworks.com header.i=@gateworks.com header.b=h0IrKGpt; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gateworks.com
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-6113e68da82so2099425eaf.1
        for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 10:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gateworks.com; s=google; t=1750700005; x=1751304805; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ESxItapZGpeX27bCqCWykYCjM+yU4vTWbwqb34xOmU=;
        b=h0IrKGptlbQ3xJYJdVcMeNuvAU3V/0m/vNdgsvWh0YWWduIvJPA1cn10puFAC5xIHq
         CM0bxMYXcugphbm8XwxfEQUry+FlqESiwJnQwVzAPZOFKwP9iJ0NG40lgFyAkOKYoYeA
         Kth78elC4E/yFdTTjPyGGZHcKSoYTWJE6s2jbMUs0pMaEnUcmzwtqAIjdVvxnVOlJrE5
         cIeDi63m7LcVhQTcMAZeqZnZ4ZrgpYZAARX6TCoUOpm8XniCISuTlQD9CqyfAJ9sBPJ0
         CZ4gBp7o9CLHnlWzA8JyDH1SmdJYyNjCwkivd+JMVeGUiLgVarhjm0BUXG1oevJ0YvRO
         KEeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750700005; x=1751304805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ESxItapZGpeX27bCqCWykYCjM+yU4vTWbwqb34xOmU=;
        b=ZhXeBInY1dwYA+kD578f3ylVgiPm8BtS8M7EKQLHH2SkqqDDz9fypSuLV8som1alFW
         YOSBPMKJsNUaaFfzsXat0IwktOfVLmjKHOsIwWixBQKTxUvd+9DfekUlj/nz19enVyYT
         Jkj/f/vu/wDIK8iN1vqrnpSaiooSOayEiCMcPn2+kexZTxBFXw535vQuZnEiKYkREizS
         K2upF7vy2qA+9XCEfX9JnXc8bEHXwz6M/cCGwUmZ/iP8nG3jbIIsWOKwlO0jfQEvnol9
         X5FfOHGo9KOoZZ//G427HoqEQ2DCYttvXxZr6b0bvKisuZYSs5mEUr9Ietw94KMPjb7w
         bGBg==
X-Forwarded-Encrypted: i=1; AJvYcCVdiScO8tYQB9U4RZPHIv/G2xb1fq1bPUkK/Gq8WdOIy4/Gkssjo8gvZwK5+mfUsbDPOg96zSWH7LY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJbvk+xH3pwKKPNJ2ZYewKfMR6g5KmpL9rXDeo906cS4aW0WdG
	5UeW1FEqbz0HJv6w7fVXWHsWnue3lGdaeXEOckICdL2lUUErNSwRp9PgwCLabXJxdNba+3beUuW
	V2h2MNEJ6GNPhxvulUT0Y7bdVomvNH31RBNSKTIC0aQ==
X-Gm-Gg: ASbGncvGUB1SuJcd7i5DrdXUd1MmjeuIgz99g5fjHcK0RrKOXQivQp9JvZTEQNn0uM5
	eVt87/9o/kG2duBj/b9tqiA0ftXaucCXskiZ6XX6UfZNZOubQ9MUK49y9GhYDO6iG6yyGt9xYtX
	Lh8Pn6LSWyP4SNyS+58V6nm4Kwxdd24yG/SKKzNZHSQUM=
X-Google-Smtp-Source: AGHT+IEnQISZoeoPxj8JEGlUaibukW91WXz6xwGvL5sx8yj9FeldaqG5qJs0cowqWl1mZaAAU6aoFwKpwix2JbTKO8M=
X-Received: by 2002:a05:6820:1b07:b0:611:7f80:6474 with SMTP id
 006d021491bc7-6117f806825mr4229278eaf.3.1750700004712; Mon, 23 Jun 2025
 10:33:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250616085742.2684742-1-hongxing.zhu@nxp.com>
 <20250616085742.2684742-2-hongxing.zhu@nxp.com> <kjsaipr2xq777dmiv2ac7qzrxw47nevc75j7ryma32vsnyr2le@mrwurn6rgnac>
In-Reply-To: <kjsaipr2xq777dmiv2ac7qzrxw47nevc75j7ryma32vsnyr2le@mrwurn6rgnac>
From: Tim Harvey <tharvey@gateworks.com>
Date: Mon, 23 Jun 2025 10:33:13 -0700
X-Gm-Features: AX0GCFtnkiV6JnGTj19oSXnEDcUfrmPAyTPCGVHfXU5cEeF-T0n_k13y5pEP9X4
Message-ID: <CAJ+vNU3mKiEE86SYFS0aEabkqRKADFDJN0giX73E0cA=GOyhjA@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: imx6: Remove apps_reset toggle in _core_reset functions
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>, frank.li@nxp.com, l.stach@pengutronix.de, 
	lpieralisi@kernel.org, kwilczynski@kernel.org, robh@kernel.org, 
	bhelgaas@google.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 23, 2025 at 4:42=E2=80=AFAM Manivannan Sadhasivam <mani@kernel.=
org> wrote:
>
> On Mon, Jun 16, 2025 at 04:57:41PM +0800, Richard Zhu wrote:
> > apps_reset is LTSSM_EN on i.MX7, i.MX8MQ, i.MX8MM and i.MX8MP platforms=
.
> > Since the assertion/de-assertion of apps_reset(LTSSM_EN bit) had been
> > wrappered in imx_pcie_ltssm_enable() and imx_pcie_ltssm_disable();
> >
>
> What about other i.MX chipsets like 6Q and its cousins? Wouldn't this cha=
nge
> affect them since they treat 'apps_reset' differently?
>
> - Mani

Hi Main,

This patch effectively brings back the behavior prior to commit
ef61c7d8d032 ("PCI: imx6: Deassert apps_reset in
imx_pcie_deassert_core_reset()") which caused the original
regressions.

To ease your concerns I've tested this patch on top of v6.16-rc3 with
the following IMX6 boards I have here with and without a PCI device
attached:
imx6q-gw51xx - no switch
imx6q-gw54xx - switch

I only have imx6qdl/imx8mm/imx8mp boards to test with.

From what I can tell it doesn't look like the original patch that
added the 'symmetric' apps_reset de-assert was necessarily well
tested. It started out being added because as far as I can tell it
'looked' like the right thing to do [1]. You requested changes to the
commit log for wording [2],[3] but I'm unclear that anyone tested
this.

Best Regards,

Tim
[1] https://patchwork.kernel.org/project/linux-pci/patch/1727148464-14341-6=
-git-send-email-hongxing.zhu@nxp.com/
[2] https://patchwork.kernel.org/project/linux-pci/patch/1728981213-8771-6-=
git-send-email-hongxing.zhu@nxp.com/
[3] https://patchwork.kernel.org/project/linux-pci/patch/20241101070610.126=
7391-6-hongxing.zhu@nxp.com/

