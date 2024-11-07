Return-Path: <linux-pci+bounces-16284-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A2009C10D6
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 22:19:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B2D51C225B0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2024 21:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5698A21731D;
	Thu,  7 Nov 2024 21:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bP26CKUr"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D8BA194C92;
	Thu,  7 Nov 2024 21:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731014372; cv=none; b=tu/IP3zbMLEn6fjyRf/n3dBueJGvJ5LMkEUmFoWdHBle6L64AG2owaTT/N9B4j3QflZob9hMRBU0aVMOFwVqOak9eGIok1LC+sz/NM1ZXottBVFzNOav6Ft1LS96jj/okXLby+NpcpdmvkKbi4VmVPJz0mDFU8M9hNlxVZi9QqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731014372; c=relaxed/simple;
	bh=6EJOYAl/kUJjbYJ96ISBGmvuILjiyPodEgngmPrqfRE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GCbe97AgKe89nQ2NUyqo3wXNC1DGRhfUBqnkSGD9ZFzA+LHscldlziC3VrArxQYC8ub1qOcYBbFHZZKL3p2G1gyJ++8BXd5dIt6uRj/Kx/wOox17AUJvOt4/EJoYZ+/MRvigWG/LH96kM7i6I7thawKGwMZSRiw5Mx3E3tOL2Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bP26CKUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBDBEC4CED2;
	Thu,  7 Nov 2024 21:19:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731014371;
	bh=6EJOYAl/kUJjbYJ96ISBGmvuILjiyPodEgngmPrqfRE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=bP26CKUrRcRrW2/AeW1GyvHZMXgcYT7c/f+vibPT8LIs2VJFqvPskAD8rvYLfBgzo
	 7MHnPaYwWUsH+9wQGMel/RwjWd4TnkGvdUiNsD083AMvPL6J+gWC8klP4Wz4vdx8UR
	 jOQmpalPG3/crnZfavXjsmP7HMtjdfDQH8RhsqhXSnnNGB4j1uB4Idgfv3OK5NZebZ
	 kFck/4HaaVsWGXkHdEjsKIQGVVqVHLwH6k8havga2STvg0sOjkCKERQJv6dekLUoMI
	 JYOmeqBBtmAWZwNEqw85hMyinARCUiLoTEQaAQVJ/EuVQySBBX8i1phYJkac6oYK+w
	 eDRGZhoZNtIVw==
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e2903a48ef7so1458741276.2;
        Thu, 07 Nov 2024 13:19:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFWR4evT7Vi2AHaHHQohiPuUaNPNuvhRIE5SWV9J/570FhBlIuN4VkmU6frV8jFqQPKk+HUnNOpIUL@vger.kernel.org, AJvYcCWY0y3XHbirz8/7rU7SpxKjikrV3zukPbMtppMQKz5eQUe+gKuVFbVKDXR0fd6bvePxiddcZtdYp1HXO0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNVob5wnX+jxcR1uPqoo+5BsB1igovpWiXfJjM+h0ptpIjtmWs
	JGyWzyad5Kdqnm5VdBFdiEQfIZxFbEDHZXmYDm2DtV7ehuH6FsonsAQlzgpC2dp2ObQcZkO5mx1
	pUOLwfie8AymQF53OeqMlSTw0LA==
X-Google-Smtp-Source: AGHT+IE0AYklUc4GjktYkiuQo+juQwy9Dp43p1y0r83xjpWA0bzLs74rK20hy5R/HwgvbbtaxtREPNHRwoiGz9DD8bo=
X-Received: by 2002:a05:6902:b17:b0:e29:236:fe2b with SMTP id
 3f1490d57ef6-e337f90370cmr472949276.49.1731014371053; Thu, 07 Nov 2024
 13:19:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107153255.2740610-1-robh@kernel.org> <20241107170002.wz7wkqmtyqiiaswl@pali>
In-Reply-To: <20241107170002.wz7wkqmtyqiiaswl@pali>
From: Rob Herring <robh@kernel.org>
Date: Thu, 7 Nov 2024 15:19:20 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJ-BaHq+o+E-OtAf8YbJbNnPSKHjvgAn_oq8KVEKPq4rg@mail.gmail.com>
Message-ID: <CAL_JsqJ-BaHq+o+E-OtAf8YbJbNnPSKHjvgAn_oq8KVEKPq4rg@mail.gmail.com>
Subject: Re: [PATCH] PCI: mvebu: Use for_each_of_range() iterator for parsing "ranges"
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	=?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 11:00=E2=80=AFAM Pali Roh=C3=A1r <pali@kernel.org> w=
rote:
>
> On Thursday 07 November 2024 09:32:55 Rob Herring (Arm) wrote:
> > The mvebu "ranges" is a bit unusual with its own encoding of addresses,
> > but it's still just normal "ranges" as far as parsing is concerned.
> > Convert mvebu_get_tgt_attr() to use the for_each_of_range() iterator
> > instead of open coding the parsing.
> >
> > Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> > ---
> > Compile tested only.
>
> I see no reason for such change, which was even non tested at all and
> does not fix any issue.

Maintenance of the kernel is an issue. Maybe not for you, but for some of u=
s.

>  There are more important issues in the driver,
> it was decided that bug fixes are not going to be included (yet).

The larger reason is to get rid of custom parsing of address
properties throughout the kernel. As well as remove and consolidate
uses of_n_addr_cells() and remove its support of long since deprecated
behavior. Also, I intend to make of_get_property/of_find_property()
warn about leaking data since it just returns a pointer into the raw
DT data and we have no control over the lifetime. Then we can't free
those properties. Why do we care? Overlays and Rust.

Rob

