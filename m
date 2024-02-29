Return-Path: <linux-pci+bounces-4256-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8817A86C9CE
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 14:09:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80B94B26804
	for <lists+linux-pci@lfdr.de>; Thu, 29 Feb 2024 13:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13DE7E117;
	Thu, 29 Feb 2024 13:07:33 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D47D41F;
	Thu, 29 Feb 2024 13:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709212053; cv=none; b=pktSmZ6/srTZY7YZIdQSVT4Obop9QFK8MeYUB8fptNZLnhsekmSYJDNWw72gUB8Ij5HnEJISECvQoDdSepxY/z3fNalVuRomUGKInTn9Oy4v/VfNAofpHqeipfBYLU+3G2SQ1SJu3QSrwIFul3eNT/02X4BOjEmV4aCHydTWBD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709212053; c=relaxed/simple;
	bh=3yIJdudQ7IUGfEDQL3PsE8v3vQpnOpasVOfYzFhw8kM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oKeFwIp2EwTpAWSzVqh4O7uZDkbMpVqGY9QD4NfiWFNHoNhCzY8FOm4A7wpVh5UTi0oyzw2zxZyh9gFGV5Ieu57VSoolu3vpm8pj1aUrnL7y9sIn+5hKvkxMYF24qALHE5MWuNsvWrxCGrworIDow+MFFHT/9wvrt/nyFL07Ddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-60822b444c9so5920107b3.2;
        Thu, 29 Feb 2024 05:07:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709212050; x=1709816850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAP4KXWJnbrcaWP8G3GCQqukrFvvbAXkzLvoVeIpDp0=;
        b=HkqRWoENhMOilmMi4JpDJHLaTtLmyGfORkYvM8SIziJwu9Oe82HpO/NF2Pr71fWjLk
         tQRZ6T2exOXCt6IswydTvu/wz65cOynO8GdViY15afiHbKR4gwGqomUgBxOURQ4h5gka
         ERjG8KPoFpFgIzTlUaPcUEE5nUxqJFScneyAvqAK+UvN7wQLiMapK241xnphh78WTl0Y
         OFdirwqbK5Yut/VUh3t59QfJcvHgGrWbX9OTazgsrm7PrLq8vWJQ9JXZck/KCHwseJDg
         su6XS3u5GxDV7Qteo6JTcLMDUAgJcbnxgKK/Nq3v8PEUae6ymRYmwAa5c0iA4YUGYa7K
         25MQ==
X-Forwarded-Encrypted: i=1; AJvYcCXz6Im+pLVBvQCiRYXMKtl4dk2SLT360Wl6/qoPG0Zk3JsN9igTTCuDjJFPtwuxiVQEBOLxZtFXnr8Q/kOUE+6LM3xcBzn8DPHoWwuyfVkleQOIgSl9DbKQT9KtvfI5dzUBj7kyZKJsivySAuCZuIVOvTBtJncJEvoHHMJlrJOFgzDabPnYrikV
X-Gm-Message-State: AOJu0YxQoyKzu7LJa7niWK7V/k8Kwy6HzdDnjx0wMGJWwHjfZQg1Auft
	CWei37zj9uugNopFt/X9HOnoIqK9MFpP7gcrVNUveG57Ur3pT8Sz7w7hJcy8ePY=
X-Google-Smtp-Source: AGHT+IF7Z0dM8gNIKCf/e5mSsj+e5I8mP+/lHbFsLt6yZ8pkipW8joRAJ6jfiSe3nIDYUAw3m6G36A==
X-Received: by 2002:a0d:fcc6:0:b0:608:78b7:efb3 with SMTP id m189-20020a0dfcc6000000b0060878b7efb3mr2031169ywf.38.1709212049780;
        Thu, 29 Feb 2024 05:07:29 -0800 (PST)
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com. [209.85.219.177])
        by smtp.gmail.com with ESMTPSA id u128-20020a0dd286000000b006079e8f3572sm364127ywd.85.2024.02.29.05.07.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 05:07:20 -0800 (PST)
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc6d8bd618eso989552276.3;
        Thu, 29 Feb 2024 05:07:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXEqgNiFmKTk4w5gw0PWpzzJ0A53cjKGaFGK82N48W8338kkce7UbFIfAsft20dL3o4p7Od4eefITIjwdvxtc76jcOJCWYq++QqPmEgNN1neZb2POYf6C8mkGW5ebBpggvhMfNH1lTMTRwtRnjrNQcgiR/2eGCmsqjT+FFoexJjkk6yLllf3zhX
X-Received: by 2002:a25:c754:0:b0:dcc:d196:a573 with SMTP id
 w81-20020a25c754000000b00dccd196a573mr2371388ybe.36.1709212039523; Thu, 29
 Feb 2024 05:07:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229120719.2553638-1-yoshihiro.shimoda.uh@renesas.com> <20240229120719.2553638-7-yoshihiro.shimoda.uh@renesas.com>
In-Reply-To: <20240229120719.2553638-7-yoshihiro.shimoda.uh@renesas.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 29 Feb 2024 14:07:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXGEG-8xFKmpXpNFV_jyDJb0vYoUV=AOtHrPfjPiLzfOg@mail.gmail.com>
Message-ID: <CAMuHMdXGEG-8xFKmpXpNFV_jyDJb0vYoUV=AOtHrPfjPiLzfOg@mail.gmail.com>
Subject: Re: [PATCH 6/6] misc: pci_endpoint_test: Add Device ID for R-Car V4H
 PCIe controller
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, bhelgaas@google.com, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jingoohan1@gmail.com, 
	gustavo.pimentel@synopsys.com, mani@kernel.org, marek.vasut+renesas@gmail.com, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-renesas-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shimoda-san,

On Thu, Feb 29, 2024 at 1:07=E2=80=AFPM Yoshihiro Shimoda
<yoshihiro.shimoda.uh@renesas.com> wrote:
> Add Renesas R8A779G0 in pci_device_id table so that pci-epf-test
> can be used for testing PCIe EP on R-Car V4H.
>
> Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

