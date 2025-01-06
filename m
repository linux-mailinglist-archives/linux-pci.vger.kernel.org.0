Return-Path: <linux-pci+bounces-19338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D71BA028C9
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 16:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0526E163BAD
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jan 2025 15:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE6A813665B;
	Mon,  6 Jan 2025 15:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aka97H+P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B8C1C69D;
	Mon,  6 Jan 2025 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176055; cv=none; b=UfEl6smVVmUjUuwrVNJQo7jKx+6DTs0TMyV1/B6aAW63Ce1jN76UGiaSYxbiWm/gBBG95JX34JyLUaDtr9rn0TrxPRJyhkqDKHxz3t9g2wM1fVJ4GgT63CLkWAJYu9QB8hkiy7ox/4DqrHubEK0mEzX77c5z31xEhA0kiNgThwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176055; c=relaxed/simple;
	bh=awan+AiOH4AinW1IjRS0hdUNq8s7EvKHEZibS6fH3lo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tgGSR7jK26/5yJ7ZnqHzEAH1m6CcYsqJWGXhjSR92P70E5lpDE0ASaWzSYiyhL5DqfAqefPyKbQ4IgqY5ltCzZzPTGZCxSbnfR82Vrl1FY/6w+EqtOeUsY9kgB0qiZ0pVB+cUTozKlrXZ/L/37R95An9IYxVwfHp3BrMySROrT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aka97H+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BE5C4CED6;
	Mon,  6 Jan 2025 15:07:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736176054;
	bh=awan+AiOH4AinW1IjRS0hdUNq8s7EvKHEZibS6fH3lo=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=aka97H+Pg4zqTewOPhxBKqQe6uTS6QC1X6IB4nTTxcdphMxFgqAFhs1ZpM1Gulbol
	 ZeEDySDIG9mVlBUOrGyRssV9BGBTt8dZFgZcO0cl/sI69mQl7Ki73qbHiKW81Uxqaf
	 8KN/LBF3j+wTcq/L425eTA7EPhNF8Ft/xUOJGC8bA7PPnH+8ttAlqAtnb12bLXiQmv
	 u4IFu3UwTEykqX0uVQY5Zdcw4XIca2WUMvehGGF3q8cAHQW8uXcyHvJvNr2uch8kB1
	 ZdxBpzG9c5/+5mwBebphCf3ByzxA9n231FDxhuLiZKiP0lZN3drrFMNuJ13tnjzVKu
	 lJOIkRSrYIiUQ==
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e549a71dd3dso4150967276.0;
        Mon, 06 Jan 2025 07:07:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUBBx8YDr7fiUhMx+UOaJ0KCIVH3IC2AJIFCgPIMbLz9ii7IuM3tmEqryQbDJfi/ckfKKvSFkCqZJgin6Um@vger.kernel.org, AJvYcCUtWgSKBGuzmvQ0lpFXE3g+q67x31AlgoXifAuBAP4+I194jYFohGO4WhAOMf0/jMpWW/wnWQiEXHmCGUnlc80=@vger.kernel.org, AJvYcCVk44JP/yi4PR+SoVon9UnPfGOEsnRl744+5Rzz6l9VXqY0rQc6G6KMGNz3SGmoeljuihZgl587SI4WUA==@vger.kernel.org, AJvYcCXAjkdeEenIh7q0inn5+OP6GGA2QhgUg+hc/RSX8tilp0ZlHLVtuUZgXG6w5XJgznHXP5ARd7RjeehV@vger.kernel.org, AJvYcCXkxfktRW4407DhHb2KmXP8q+Fz8CgKv05D2Ml//LJeUk2Olz9AE1uTuliU8mcJr7ncr1OiHnLWBYsaTNJRxw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwbIXb6Iz4YNZvqrAvTn8YC/5q4NuW87XO5j0BOZGQHiYgLq6sV
	URBCZVDPl6jY/hzzUU+7kfDNm/hOcS/sdXoPy3RyfuJkpcz+IwJ5wlyecF6M0rzTywCgl7W/vbv
	UoPS7fdAEf91ytO0fPeToOt9kJg==
X-Google-Smtp-Source: AGHT+IH09BKnIqxe6Y+K61gjwNh2dfOLIdP6VjieHTWStRetCqq8jo5DAw5KOFYTcVkghQ0AVoPjay6fuio4739Z1/E=
X-Received: by 2002:a05:690c:7106:b0:6ef:7640:e18a with SMTP id
 00721157ae682-6f3f820f277mr480459767b3.31.1736176053275; Mon, 06 Jan 2025
 07:07:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250106093304.604829-1-krishna.chundru@oss.qualcomm.com>
In-Reply-To: <20250106093304.604829-1-krishna.chundru@oss.qualcomm.com>
From: Rob Herring <robh@kernel.org>
Date: Mon, 6 Jan 2025 09:07:22 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJXGUmzE+tPccDmdi5r0YvQ5kOL2mh3e6KtEvTnsexnyg@mail.gmail.com>
Message-ID: <CAL_JsqJXGUmzE+tPccDmdi5r0YvQ5kOL2mh3e6KtEvTnsexnyg@mail.gmail.com>
Subject: Re: [PATCH V1] schemas: pci: bridge: Document PCI L0s & L1 entry
 delay and nfts
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: andersson@kernel.org, dmitry.baryshkov@linaro.org, 
	manivannan.sadhasivam@linaro.org, krzk@kernel.org, helgaas@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	lpieralisi@kernel.org, kw@linux.com, conor+dt@kernel.org, 
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree-spec@vger.kernel.org, quic_vbadigan@quicinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 6, 2025 at 3:33=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
> Some controllers and endpoints provide provision to program the entry
> delays of L0s & L1 which will allow the link to enter L0s & L1 more
> aggressively to save power.
>
> As per PCIe spec 6 sec 4.2.5.6, the number of Fast Training Sequence (FTS=
)
> can be programmed by the controllers or endpoints that is used for bit an=
d
> Symbol lock when transitioning from L0s to L0 based upon the PCIe data ra=
te
> FTS value can vary. So define a array for each data rate for nfts.
>
> These values needs to be programmed before link training.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> ---
> - This change was suggested in this patch: https://lore.kernel.org/all/20=
241211060000.3vn3iumouggjcbva@thinkpad/
> ---
>  dtschema/schemas/pci/pci-bus-common.yaml | 16 ++++++++++++++++

Do these properties apply to any link like downstream ports on a PCIe switc=
h?

>  1 file changed, 16 insertions(+)
>
> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/=
pci/pci-bus-common.yaml
> index 94b648f..f0655ba 100644
> --- a/dtschema/schemas/pci/pci-bus-common.yaml
> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
> @@ -128,6 +128,16 @@ properties:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      enum: [ 1, 2, 4, 8, 16, 32 ]
>
> +  nfts:

Kind of short. How about num-fts? Or is "NFTS" a PCI term?

> +    description:
> +      Number of Fast Training Sequence (FTS) used during L0s to L0 exit =
for bit
> +      and Symbol lock.
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    minItems: 1
> +    maxItems: 5

Need to define what is each entry? Gen 1 to 5?

> +    items:
> +      maximum: 255

Why not use uint8 array then?

> +
>    reset-gpios:
>      description: GPIO controlled connection to PERST# signal
>      maxItems: 1
> @@ -150,6 +160,12 @@ properties:
>      description: Disables ASPM L0s capability
>      type: boolean
>
> +  aspm-l0s-entry-delay-ns:
> +    description: Aspm l0s entry delay.
> +
> +  aspm-l1-entry-delay-ns:
> +    description: Aspm l1 entry delay.
> +
>    vpcie12v-supply:
>      description: 12v regulator phandle for the slot
>
> --
> 2.34.1
>
>

