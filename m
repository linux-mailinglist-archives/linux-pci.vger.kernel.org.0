Return-Path: <linux-pci+bounces-16215-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3516F9C0192
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 10:54:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6649B1C20C7E
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 09:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 754FD1EF943;
	Thu,  7 Nov 2024 09:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="NaH/jdYG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93C531EF941
	for <linux-pci@vger.kernel.org>; Thu,  7 Nov 2024 09:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730973170; cv=none; b=ordXFDYED0y4bNl76vIxKtEcjTP+wfXJLl6eZ7nS7MZqeQsJlKGOaewVsxPir/Pv+Waj13JTzz7OCfR+PV7emsKVNVl1Xgn6JKXPWqGJaQGvGD1O32lbNDdqDAdyHUbgu7+SP53SSzl5XB60vfW/CR0WPn0/Rmrbk/ycDtik+TI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730973170; c=relaxed/simple;
	bh=lwkS4VJfaJEucEu5sjIf8kNJ80mve52KW6NV0UYNB8g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hVi74eAJREliHbU5Jtxqc/wcBwxVv+bjze3nZkx1q9B43webIFClv4aLPn4kD14d/Ia71rFSGMiU7P9jWKY5Gxnmrj79fmjY3m4QIgLw07qScCHoi9yPA/78S0B4+adB2XenIbnZ1yKQ5sT2WBvVrHdq5Ioyahm1Dz5fbhfgnEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=NaH/jdYG; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539e4b7409fso861273e87.0
        for <linux-pci@vger.kernel.org>; Thu, 07 Nov 2024 01:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1730973167; x=1731577967; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IA66ioYkj3vj3gACNMRiFPoKPNWp3AWQcm6mCZSqbfc=;
        b=NaH/jdYGTYkBmUyJs74b+/ex71quTl5uzSC92GKcZChVf/XxVQRQUeFUaY8Wh557qv
         zV9CX0d/IpapeSwP6N2cu1g08841CnRj0+z+UytkV7FeqkVD60X46jcxMoSVchlnG5lC
         zrqNjLuKaVPFc6WxUX1touZXuXCQruG56nbH0FGrk2TUJJH+HN23IPzJqwiAu28bjSHl
         uF5kwgHeL69CtXCZl0pGOYvHD8oD5loDQAWiEGg6diRyt3Iv7V5sag8Wi8KimSKyR8cn
         Y4UQlr52erRzkMf6qGdBluG2OBr09sfcM1G1+5XXXjbHbAPRkQzDKqMeP4p3E/q+9ZDH
         1nFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730973167; x=1731577967;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IA66ioYkj3vj3gACNMRiFPoKPNWp3AWQcm6mCZSqbfc=;
        b=Es9MViD2dxa2RYjjChsYzQdHDhwcqt6/o2NJ9Sr8OEbpxQ1/bNV4xUVCMI0Xpbq1GS
         mgqquxhPwRuy5jtoyVu1GDxDzWl5nGU8ZiErjAgymNRxS0DwzoP2x0F5f39ZBtm0GDcw
         ykI+DfqTPgZ4jtQzG0SAr4TC00GvNKHXrWNz0zSbJpFYoe5Yu2jCm5uCcwDqtYc6Lvvz
         rzRdqZO2vV7bKrrMcg8EJr5/K28e/rEb9RTew7e77aVK46uAaqb1F+EZMPpFj00VBxUb
         fbHQeh41dS3LV29v2u+XH02QlcqOjks6pI9JGQxQHwZGNsS+UUut1ocm6//GJpJlLKhE
         FNWA==
X-Forwarded-Encrypted: i=1; AJvYcCUzRJUAu1JAwBWE/oodOCQJhywU9BPvASWoGq049iDBIRF3SnWxEY5LFMF8XM097AFBIVzlgguqu0g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzei+GIhJMdoaZ+YKpd85XuBbEtiPYIF3pM3hvxEFQCBwUNCXkQ
	CRfmsHuH44WskW6pBVjxnMdtLIr2epfTnosue7ZQ4TMevH7sBJv9Ma/2iTUCsDd+2gsmAkvmZGN
	D0+mWLlB61A0vxut3SjBuqEEnWo3mssNzDBt2UQ==
X-Google-Smtp-Source: AGHT+IGoIjWDtseFdv8HQtxmB05m0ChWJ9ovwz6pG0rW7iORfMGi+Nv+cmXMOQUFwz4dLK8J9uZOk8L+1MSKQszJKqI=
X-Received: by 2002:a05:6512:230e:b0:53b:48f2:459b with SMTP id
 2adb3069b0e04-53d81994c48mr849244e87.23.1730973166565; Thu, 07 Nov 2024
 01:52:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-pci-pwrctl-rework-v2-2-568756156cbe@linaro.org> <20241106212826.GA1540916@bhelgaas>
In-Reply-To: <20241106212826.GA1540916@bhelgaas>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 7 Nov 2024 10:52:35 +0100
Message-ID: <CAMRc=Mcy8eo-nHFj+s8TO_NekTz6x-y=BYevz5Z2RTwuUpdcbA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] PCI/pwrctl: Create pwrctl devices only if at least
 one power supply is present
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: manivannan.sadhasivam@linaro.org, Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, stable+noautosel@kernel.org, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 6, 2024 at 10:28=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> On Fri, Oct 25, 2024 at 01:24:52PM +0530, Manivannan Sadhasivam via B4 Re=
lay wrote:
> > From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> >
> > Currently, pwrctl devices are created if the corresponding PCI nodes ar=
e
> > defined in devicetree. But this is not correct, because not all PCI nod=
es
> > defined in devicetree require pwrctl support. Pwrctl comes into picture
> > only when the device requires kernel to manage its power state. This ca=
n
> > be determined using the power supply properties present in the devicetr=
ee
> > node of the device.
>
> > +bool of_pci_is_supply_present(struct device_node *np)
> > +{
> > +     struct property *prop;
> > +     char *supply;
> > +
> > +     if (!np)
> > +             return false;
>
> Why do we need to test !np here?  It should always be non-NULL.
>

Right, I think this can be dropped. We check for the OF node in the
function above.

Bart

