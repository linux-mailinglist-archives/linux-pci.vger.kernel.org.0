Return-Path: <linux-pci+bounces-13103-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FDB976811
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 13:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28A71F222EB
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2024 11:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20AC418FDD7;
	Thu, 12 Sep 2024 11:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvRHM0JX"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7493224CF;
	Thu, 12 Sep 2024 11:43:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726141433; cv=none; b=ukw51aqoNfftj+BbX1dyswsnaSQ0TnEax7dRqYneS5uM0iPGjonUNUZ7Fo7XoI35DUJLV1ThxH2O9NjM6yrAh60fDRKpxrTcdCUmrcfMbCtH/PHq8AxDvG0H7/dJCzGXKAz/cCBvL+2dnM85+hevHU1+Q1sBr2i6LMUqS5hTV04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726141433; c=relaxed/simple;
	bh=L2aN52460BClnfF3OoyQwWj/aBHORiFTLfTWFwhmk2E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCTk6x7saxXnDCxMTSQ3g9BOb+cirGBrC1XO5FF18pnNbTyl3lXuUyldahZAyhzL0zD6O+rGkhllvlqNRuCIV/1SJeUjYVIxNXaBWGmumMbL6ve8EKeqYeYs8C/GUUdBiiZe4FtIsenc1N5OZXzOW3UfUY1h00Tqd++9K/OmiYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvRHM0JX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78379C4CEC5;
	Thu, 12 Sep 2024 11:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726141432;
	bh=L2aN52460BClnfF3OoyQwWj/aBHORiFTLfTWFwhmk2E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=ZvRHM0JX87URTa+fRqtIHIapUyfY8ygytKCBr9ZFKEiG81ScVYS0bL04DeRpE0Trx
	 BP4gn+bcswirj5fGnStBmvJt6n9Y1harwwjrPMioUyKpUQ/KYybQ9JHM3ymuqD9fkL
	 LmP1wbc8vWTEkL57qAgPH+L9FrFRhovsCgTNass8WZxm3YYt4rem1u3r44M62XGOga
	 NOOymYfpz+SpdwyZhYdBho7ZjBWfiN/9U1alG+Ni4CtjtiOqXXT2rKV1FR9dECRxDh
	 u7aU3h1vdJM0YI0d4KgxTjNDMDvwKUbGGkj002966DfBm9Wa8RlKeyelVwbs4k6XgW
	 GDChYP4sAj+sg==
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5e1b50feb9bso478796eaf.1;
        Thu, 12 Sep 2024 04:43:52 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUIJ/5N0YEtNA2ZXn9CHHihEmwj+fuNaufJ0fVXuo+Vd1bcBIy8w8Z8Fm7aNbsEbfGl1wsMumm09F+1@vger.kernel.org, AJvYcCWtLtC3aqyfYHxAgm5R/iaFITwoBxPv+8TxIuqytRYQNtlY/wbRj1RtpxYkW+uOtebvGkv3x9DY2sKc+l4=@vger.kernel.org, AJvYcCXfcIZuIvJV6CRoHmaH5zE92XQkfVdv9AAkfvVogk1Gy4UGMkSDp15SuJ0eZJYU4cG+9XHANtmXLo4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwCjDl1yIg/AsnpPA0rIxG0o3jpdlIeDGMzbgQXd+k188+pU5hY
	HlUa5khi3MOs8i+VwIKeH/fro6zTG4HM0SlyNNm70eu9s2i2SpihYxl5irxCK0juNLQ1EbAvnDr
	FkIXVhJmaxUgZ6E+Ym/oL8PFUTwg=
X-Google-Smtp-Source: AGHT+IH9oAdjjxWZh0+YZznLLwT+V+ddbYCUrZG5OXKxiAJVQLam/wvSS0L0q46R+vlAF2K79EpN80NkYM6/M9TBAlY=
X-Received: by 2002:a05:6870:2197:b0:25e:de4:9621 with SMTP id
 586e51a60fabf-27c3f2ba069mr1637668fac.24.1726141431837; Thu, 12 Sep 2024
 04:43:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240816204539.GA73302@bhelgaas> <90dca882-3c14-4c3e-aed2-e710593d2a9d@quicinc.com>
In-Reply-To: <90dca882-3c14-4c3e-aed2-e710593d2a9d@quicinc.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Thu, 12 Sep 2024 13:43:40 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0gMLfcKBapMSoFhNBv_h7t8omf3mnRG19NgN2RsaTmOBQ@mail.gmail.com>
Message-ID: <CAJZ5v0gMLfcKBapMSoFhNBv_h7t8omf3mnRG19NgN2RsaTmOBQ@mail.gmail.com>
Subject: Re: [PATCH v4] PCI: Enable runtime pm of the host bridge
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Bjorn Helgaas <bhelgaas@google.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com, quic_skananth@quicinc.com, 
	quic_parass@quicinc.com, Mayank Rana <quic_mrana@quicinc.com>, 
	Markus Elfring <Markus.Elfring@web.de>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:59=E2=80=AFAM Krishna Chaitanya Chundru
<quic_krichai@quicinc.com> wrote:
>
>
>
> On 8/17/2024 2:15 AM, Bjorn Helgaas wrote:
> > [+cc Rafael, Mayank, Markus (when people have commented on previous
> > versions, please cc them on new versions).  I'm still hoping Rafael
> > will have a chance to chime in]
> >
> Rafael,
>
> Can you please check on this behavior?

Please see my reply to Bjorn's message, sorry for the delay.

