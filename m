Return-Path: <linux-pci+bounces-12284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5769C960B29
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 14:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8992B1C22EBD
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 12:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3B41BA270;
	Tue, 27 Aug 2024 12:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SkrNCwu/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65EFF19D8AC;
	Tue, 27 Aug 2024 12:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724763344; cv=none; b=lONIMYGblF7SOD1n4VqOafgtoYEzqhZi30y03mLIb5RPIb4AxohiUUmxeNuUl2eH4j/U1sJb0dLQbMV+a4NSL536bUbSqcOBPLORiencsWGww06ygtjL0uP/V0TAHCrh22JHyvToAI5wZRqvZodxd0geIiVePCF3gZOr8liSVU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724763344; c=relaxed/simple;
	bh=jnPSLRSKYNz2uR+5aPcgfTW5PwINHBVoAdjNAAU9oXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhK23ei+I/8WRfv+l8kPN0ZBOMa4Zc7FP5pl6N6zivHJEu28xCZUB53KwUaVdsjMpIC2h0f6ETtDxKkbsrxMPbB+rSZMRg0pPXRWd2ftmWQfsvcy6J0KxRDWtKLR6bxHvnzCCpVLJZazzVoYijGR27i+E4CpEG+gcINRXkIYl4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SkrNCwu/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53E2C4DDE8;
	Tue, 27 Aug 2024 12:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724763343;
	bh=jnPSLRSKYNz2uR+5aPcgfTW5PwINHBVoAdjNAAU9oXI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=SkrNCwu/BVrAxosJaVzvba6xYY9S/raXhLrSIbk73VW+Gbk2JcJsgU8VdI48hOaDV
	 CI0lR7N6Zlrk11lJWIJA3aaiI4fZvc93fixq1Q8o+nUvoyPC3aIkb+Ww3ygmhntfa/
	 MThRsdEHA3E7b9q61P8bD7c391lsiSz5MgAluRFQwudWPiR00bxb5gboIwXEMl167E
	 0mGQx8P96COTw12CtpNd+MXVcPsCu1MEq1V5P4Qd6tcTf+alsI+RUeu9pZdWEWXULt
	 dqOjhxHIjvJgWJSM6pDHac50w+kkvwomRqcDB++sgxtNdPxqzhHuIcktBgLBVEtaSL
	 jL2cjUSUZxAxQ==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5343d2af735so3992320e87.1;
        Tue, 27 Aug 2024 05:55:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUxZhcwhh1YEzseDHcPgxb9GGjxC+5a2VWNCXIoF4RYuECV5XQ5b6PjTWduLEIZoNnDDagXVlYxGqrIDK0=@vger.kernel.org, AJvYcCXB/5HyCfd2bLpVIZtn5S3HVYxeJ+pyqSSddj/jrMaCXjhUaJ8ZpGyFtFdbpQbgviDUaqGu+3FDC6M0@vger.kernel.org
X-Gm-Message-State: AOJu0YzXKLY/99lkKlyHQIqiKLpXjz5jc/D70ZL2fEIzC4k1GCBRMUNi
	nZAc8WzjjyJopUxV3v2W0EXyXbWAHxcoiNtXDYJtSxKUNmZRsH2Sdr74qJiTQEvXbnEKOxYyIvY
	Zq3qcqo8HdXbWIDdp62qbrV6F/Q==
X-Google-Smtp-Source: AGHT+IES1fUrvmDh1sgrTeNHW2LSehtKRfqP0etwYMtFPVktUkfVn9ATkCyF4G51m5SiY0lFMEjcVlo/zBhXSjxpdqQ=
X-Received: by 2002:a05:6512:3ba7:b0:52c:dd3d:85af with SMTP id
 2adb3069b0e04-5344e3da6c4mr1795436e87.25.1724763342119; Tue, 27 Aug 2024
 05:55:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240823093323.33450-2-brgl@bgdev.pl> <20240823221021.GA388724@bhelgaas>
In-Reply-To: <20240823221021.GA388724@bhelgaas>
From: Rob Herring <robh+dt@kernel.org>
Date: Tue, 27 Aug 2024 07:55:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJnxf0XBHKuoAOxsjOxAtufiWXsCJ2kTwi_WNOOS1-U2w@mail.gmail.com>
Message-ID: <CAL_JsqJnxf0XBHKuoAOxsjOxAtufiWXsCJ2kTwi_WNOOS1-U2w@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] PCI: don't rely on of_platform_depopulate() for
 reused OF-nodes
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Bjorn Helgaas <bhelgaas@google.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 23, 2024 at 5:10=E2=80=AFPM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
>
> [+to Rob]
>
> On Fri, Aug 23, 2024 at 11:33:22AM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > of_platform_depopulate() doesn't play nice with reused OF nodes - it
> > ignores the ones that are not marked explicitly as populated and it may
> > happen that the PCI device goes away before the platform device in whic=
h
> > case the PCI core clears the OF_POPULATED bit. We need to
> > unconditionally unregister the platform devices for child nodes when
> > stopping the PCI device.
>
> Rob, any concerns with this?

Yes, the flag bits are a mess. I don't have a better solution other
than perhaps what Bartosz suggests.

I was going to say we shouldn't really be mucking with the
OF_POPULATED flag outside the DT code, but then I grep'ed the tree. :(

Rob

