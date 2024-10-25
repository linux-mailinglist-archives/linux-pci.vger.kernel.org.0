Return-Path: <linux-pci+bounces-15279-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E16D89AFC16
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 10:08:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A66F528569E
	for <lists+linux-pci@lfdr.de>; Fri, 25 Oct 2024 08:07:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B95019993F;
	Fri, 25 Oct 2024 08:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="EmI2siGf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889CD1B6D00
	for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 08:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729843661; cv=none; b=adzyqHphxn527qKuHWfZfdMzxPWfH37C6yK48tUrSgRa4x/KklbL98iSi+qMLBH0VQGdyPg4jG95mn+FB5pUkVLx8EdHnOCJp/Eb0EQKcmBhQO3RGu4QLs4NjknZVYjLnZIF3D8dTwyI395QfoBYg1tYVxiwJ8NzPidzrwsdPT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729843661; c=relaxed/simple;
	bh=CMzPrmjSeQgyPIDRqjhVnnO2Md44vEBUyZpNM1GWQMc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oqQBJ6S6e8zzqftlMcteqqsmpze2GCXD2sMFwDuvCvsFL/tzPQdiyDT1i5/Yu2KSS/7+OsgoQfJYvFOrhYG4VjVpCVQ1iDmlZ/4ECpCCOgDFQBLcKYWHe+MOPWoOfCV82vip9lh+IPl8kXTNOAjikdxGTd8jESGxtpqJ5x6w3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=EmI2siGf; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7ea76a12c32so1186095a12.1
        for <linux-pci@vger.kernel.org>; Fri, 25 Oct 2024 01:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1729843659; x=1730448459; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMzPrmjSeQgyPIDRqjhVnnO2Md44vEBUyZpNM1GWQMc=;
        b=EmI2siGfVjtQNg/ofTz/itnuj1Z4ORiOncCTvKodrzKH3I6LAUnBzWo+4E7MSB+Aq0
         QJErzIrgKsEPdIy2E6Cyl6cU9+uL2QfiGYQVb1kQDSejV+F2m/hjxp1RpWH5zzhxA09r
         ++zTAWkjqidv0NorNN9gDhB2LhGf/w3OCnTsZ5AQMKIaq0YcBB4VHQFgm0zZSm2HuriB
         jsyJGRl78DIzA8u7+USX1XdaSRXUIEm7Lbx8mHiLSVnldzDEfwZEjEbLgZMRr9KGIQB6
         tT1C+LpdrjO3lSTMBip60uNOtffhZOuuSBzgIIlkx9miu9nTBBSBnyevYur5rzyI9q+n
         T5fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729843659; x=1730448459;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMzPrmjSeQgyPIDRqjhVnnO2Md44vEBUyZpNM1GWQMc=;
        b=H6AxYpfeJGw7DnvVzQet0pxnZSkYtyF5v95lzJpmky0+TiKu52vWywlKCJ+is6bn9N
         6KwTCWEWs0U0kKH0VVPqZhak2HizfGzaJPaJXoo4e0VfYhE3Os72ikQFxPiT6Pq1xQJg
         xutY4jrMOm/sB6cA132FggMEhIP7ugujvBykmuu7O4d2dJS+dyq4ppsXm7gnsfQnvAsH
         LHlR6/TcZ9l2cSIuwjqnqt4RyAfj6KDxceQtwFiBUWl0Q5IM2y9sHjzbL3Ual6R+aKsK
         MwSsyMm/Rvat6QqOgxHycCrX3/vMMzQKzBr5A4HChi//v59TNl+Til89XRlE0G3ePlnK
         3WOg==
X-Forwarded-Encrypted: i=1; AJvYcCUsgmpTJOo9TmbI6KcDKNp6I2IRRn07nkz61mYrcEAj1s2IqXPkfol2PAd/WNVDVe4xjqsC/1jy5B8=@vger.kernel.org
X-Gm-Message-State: AOJu0YySLxZPcrLUWxFsnjai42Y5zh+bS6U0TXYHqMCetxSY44iuOket
	Fussq7pFBJL2YwpGwKseR+YMoqfKb+EGhSxNTNO1aPzPgysW/sE9jXF4Pz6uaXOpmKasjCO4Qd8
	6hXU6yAQHkOXXqulaLU/4AH1yE+WQ0o0JtwgbpA==
X-Google-Smtp-Source: AGHT+IGW1lxVwYjgZLZEEGxXj/E49c9ozc4sLvlK3AOIA3FBQVBY6vPoD9RntfkOGL5I9pzZ2gxz9e7HE1ZOJMkaPZM=
X-Received: by 2002:a05:6a20:4fa3:b0:1d9:857a:585c with SMTP id
 adf61e73a8af0-1d9857a651emr5605791637.19.1729843658910; Fri, 25 Oct 2024
 01:07:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025-pci-pwrctl-rework-v2-0-568756156cbe@linaro.org> <20241025-pci-pwrctl-rework-v2-4-568756156cbe@linaro.org>
In-Reply-To: <20241025-pci-pwrctl-rework-v2-4-568756156cbe@linaro.org>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 25 Oct 2024 10:07:18 +0200
Message-ID: <CAMRc=Mf1ytmuXWW+1YvqMPBb_DzX2_n0kL-W6SgyPGsMrnq6fQ@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] PCI/pwrctl: Move pwrctl device creation to its own
 helper function
To: manivannan.sadhasivam@linaro.org
Cc: Bjorn Helgaas <bhelgaas@google.com>, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Abel Vesa <abel.vesa@linaro.org>, 
	Stephan Gerhold <stephan.gerhold@linaro.org>, 
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>, 
	Krishna chaitanya chundru <quic_krichai@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 9:55=E2=80=AFAM Manivannan Sadhasivam via B4 Relay
<devnull+manivannan.sadhasivam.linaro.org@kernel.org> wrote:
>
> From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>
> This makes the pci_bus_add_device() API easier to maintain. Also add more
> comments to the helper to describe how the devices are created.
>
> Tested-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> Tested-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

