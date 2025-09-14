Return-Path: <linux-pci+bounces-36102-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4F0B568E6
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 14:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D02188EBEC
	for <lists+linux-pci@lfdr.de>; Sun, 14 Sep 2025 12:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3266257422;
	Sun, 14 Sep 2025 12:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZTSN6/Zq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E80A1DFCB
	for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 12:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757853966; cv=none; b=e81qWrHerL03PtVeS9PY2eIInBPbwnceOD+swhBlD5EcyzToswXtCQSWBD8Xu6ggsaX2HWFBQFVVNHQFLpBIc0mKiuvAtpXzS/JV11h5y9xETSxi3rBsCy2lULHIfHK0bNEUJBeHORBCazQ9fstn0sfarP/ULWxYTX706jLFxIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757853966; c=relaxed/simple;
	bh=qJqu9zsz4DbzXRiErdBme0b5QqAULDUAKiuFM+6b2IU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ck91CyjPVtvsLrxOSjwBkYJMdOyCbXG6jx1oIol6ZaAQHRBGn3VagkLE3WF3nBTuG9oHbvesbhwRcg2iV+iqrDe9zBPdJtV16SVCznpJfVliIKYO5EsIOp+2NE5DcKVRsnzYwWJl42lOmmpEQWbo9nNylb4xuDMfs35Mk6UXLUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZTSN6/Zq; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-625e1dfc43dso5725566a12.1
        for <linux-pci@vger.kernel.org>; Sun, 14 Sep 2025 05:46:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757853963; x=1758458763; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/uA0DazZmkLDVCOd7Hi+MwWYlsTjyYHG3YOHKZZ9+8s=;
        b=ZTSN6/Zq4lUCwtFyToVAnQ1iRl4CFeb4X8Q0kTfdXuXzrPYD7WJdBhrIruBQ3UhwG1
         iYoD4kv8IZAlvv85drUVPbCLdHFsSXhNZ4LLFX7m1dNX/HNfFnuVdsNzncQlUFxEQJEw
         2ZUT6qSV0+K3om3Km6r7At+1KqAZvjrHp/DbDIGk8u6M7RQSbqWIfbSVN/9Qw4jJF9qX
         QpYWQBOr64PyIQkwDKuAmvZD4ErykQlRbUrWIISmZTD8OIiVuYsC/aQ2szhQGWYLwaHr
         NfjAhQ4zsU3pHvoesXKM87x86TbuaWY3Jpeznm8zldwFMQzqMKZbBcFbxFcjLhIH2e+Z
         eYaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757853963; x=1758458763;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/uA0DazZmkLDVCOd7Hi+MwWYlsTjyYHG3YOHKZZ9+8s=;
        b=Yz8U2K2WCs0vSOa4gKoKYwE6VGRzDNoZhlHyEsL8gIo0g5/tvefPyJxx3XIQpupAMc
         YUyH68b/FjVWttWq3XgtyKII6tv5OgLjMxuyHU2GDW0RQdzmPBc7jDnmJJ5BhT39DHkc
         Xk5nvOdiVKYX+pLYoas5mRFUt+NajoAnhskJZ6M2Ae9v+lWoYKOr3h0NDKFoTSTxkjDO
         cv/6qldHhmkcSXxq35lMWcbB+U4mA2VjkQVtskL6GPayNpT2a3ZA/JiVRSMnERVkB0AD
         DIui7ZBw4ooXqH/Cjw32dRVt8wh7LDBjiZC7MNMZnws7gQ/+jp4g+xKbitG14FF3BMne
         F9NA==
X-Forwarded-Encrypted: i=1; AJvYcCXf0v7btUdh13rfhWVl2QMFLZlB8JhRcQ9uzxxEKtn9amwJLn5tXlCFR7CEtOkaLyb3+xV4aAphbLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMMbL9NagMPbpv2sbGzwGY9kHPY4Ayoi7b0VK0WerVntx1YZbp
	eupfq5+sjyaVbvUoHDXr5NEvB/NRZAkPGj1q5RhFVOUvOJFJ1xU2C0bL5JoBuJhx7CSh7mMN5ch
	RqnGBms2Vns8CQfgLXKB/bcX1E3fRLeM+g86Deplq/w==
X-Gm-Gg: ASbGncsD5J57gZBhwfOLZbe3xz8vWlQdReiawFVEtFxvCYiNZzvyM8z7GGis/Ta6Wuv
	KBsCzAcbUHFbQot4cQigziG9AqatERAZzbxY4kBu51Zt7agnJF5m1QIcbnFp9TGUKYTZLi7Ctg7
	8KuB6ponVJkpcqUvv+dSXNUCaUfs08ivJFaiuODCAEapMDXD14/+oVwYZ8wlPNX1gooR86tDCw4
	nfwYGk88/hCnSqBcqPLAA3UKSxyQaPCWle78KS5SMk7NngkNfsPTirMiQ==
X-Google-Smtp-Source: AGHT+IF0U4igUTTHAKDeCW0Fg2kILVIbP1QPrcy1J8WdoQD+33IuiA/5Yv77TdtGzFDmT9u8ZTuET3vq9LCucVbwHEg=
X-Received: by 2002:a05:6402:46c1:b0:627:d1af:8c66 with SMTP id
 4fb4d7f45d1cf-62ed823f049mr9261875a12.5.1757853963345; Sun, 14 Sep 2025
 05:46:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912141436.2347852-1-vincent.guittot@linaro.org>
 <20250912141436.2347852-4-vincent.guittot@linaro.org> <c3449621-546d-4911-9692-a465c6fa9697@kernel.org>
In-Reply-To: <c3449621-546d-4911-9692-a465c6fa9697@kernel.org>
From: Vincent Guittot <vincent.guittot@linaro.org>
Date: Sun, 14 Sep 2025 14:45:52 +0200
X-Gm-Features: Ac12FXxJDD4XnD2dYu4f7pXduOOEfZf2XFKS1QftIpaBO3CqniLNvi7YXY_SGp4
Message-ID: <CAKfTPtAcVq2rwhPEkoC=raFVG8YhpxUBwmaXqNogr4JeejP72Q@mail.gmail.com>
Subject: Re: [PATCH 3/4] pcie: s32g: Add initial PCIe support (RC)
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: chester62515@gmail.com, mbrugger@suse.com, ghennadi.procopciuc@oss.nxp.com, 
	s32@nxp.com, lpieralisi@kernel.org, kwilczynski@kernel.org, mani@kernel.org, 
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	Ionut.Vicovan@nxp.com, larisa.grigore@nxp.com, Ghennadi.Procopciuc@nxp.com, 
	ciprianmarian.costea@nxp.com, bogdan.hamciuc@nxp.com, 
	linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 14 Sept 2025 at 12:15, Krzysztof Kozlowski <krzk@kernel.org> wrote:
>
> On 12/09/2025 16:14, Vincent Guittot wrote:
> > +
> > +static u64 s32g_get_coherency_boundary(struct device *dev)
> > +{
> > +     struct device_node *np;
> > +     struct resource res;
> > +
> > +     np = of_find_node_by_type(NULL, "memory");
>
> You leak OF node.

ah yes, always forgot to put the node

>
> > +
> > +     if (of_address_to_resource(np, 0, &res)) {
> > +             dev_warn(dev, "Fail to get coherency boundary\n");
> > +             return 0;
> > +     }
> > +
> > +     return res.start;
> > +}
>
>
>
> ...
>
>
> > +
> > +static struct platform_driver s32g_pcie_driver = {
> > +     .driver = {
> > +             .name   = "s32g-pcie",
> > +             .owner  = THIS_MODULE,
>
> That 12-yo code. My litmus test from last talk...

yes, I forgot to remove it

>
> Please clean it up from such old coding style. BTW, tools are reporting
> this since years (in this case coccinelle), so be sure that you actually
> run standard static checks on new driver code (smatch, sparse, coccinelle).
>
>
> Best regards,
> Krzysztof

