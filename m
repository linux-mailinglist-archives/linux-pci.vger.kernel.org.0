Return-Path: <linux-pci+bounces-16883-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E68379CE0EC
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 15:07:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B4321F29722
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 14:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46ECB1CDA18;
	Fri, 15 Nov 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Afj5+xRl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9031CD210;
	Fri, 15 Nov 2024 14:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679640; cv=none; b=gunTIfUqACB5uPt9aJylvN2s/vWqbbJ83Xbz+RRzmcpV80w545Qjaa0wTi6GGszjkK6Pgmsgn5ZA7UFaxZJUebxV3PkomkWV44kot2SCnCVRV/Jaq8OM6KjCSv7U0AcCJeUj49uNCFK3j3N2hWzEuFXPI6qVvMDQeLm5nnGK1CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679640; c=relaxed/simple;
	bh=KdMIxf58FVxdssgvDJJk+WJcQuA3LMVt3GbRlC1HMdM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h6FEYXqMMSrChAbl24FdNS9DBcJq2Igw4fhI+M80ihjm58xPvB19NoEXSQSsGKBEPdfSWI6TQbH4EuthDIJ1iknP19qvuYEVAdRSEqFY2SyFK7NRnrL7qza71fRLd6v3MK+r43T11MOuH/sX9tOX4+e9HoUBZZzmqM/r1MU5w1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Afj5+xRl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1BCC4CED2;
	Fri, 15 Nov 2024 14:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731679639;
	bh=KdMIxf58FVxdssgvDJJk+WJcQuA3LMVt3GbRlC1HMdM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=Afj5+xRl8ACHgc4JUB4c9SG1vHnrTzXpVUOnphosQF18zyQjDG4EtWjP1YOP933Y/
	 gcJwGRLDe1sbAzvJ2BWLyty+mszyT7R7k5ar6Zij3gdysE0IKMA5P86qkgGjsOtMiR
	 mJb+CZ7a+9imayitmhmAAIFDh5eyI8kcqJeH68RhY7z2PKAl7jul80eBFF7bL1B/kS
	 0gTCgWg1C/dlBRvqNNp6SYOlvI6UEqfSgHPIJlQa8Q6lLgva0KRBvMvzrtgpClDrUV
	 0SXPuG1urCvUSJ/a9AjdRJaIKDrJrT71eeZeww8pjW6GhRXHewzTDMP8kDXZnD8arj
	 3YNrSY0ZZz9pQ==
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6eb0c2dda3cso19624147b3.1;
        Fri, 15 Nov 2024 06:07:19 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVgZ3vcK7r7sD4/2OEwPzHuZN+/q9x/X5S5FY2WbmLgBwlXHGxWWq4xfxORN1qocQWQEO+RlU+Vo4iB@vger.kernel.org, AJvYcCXQFuxWN0Fqa9NyU2+pJTEcZPtO8oHCg+OezndFu22cag9VuLqCCDBn7qyA4x88RWyh3fp1ClrTsnkb@vger.kernel.org, AJvYcCXvLvTqN0YRjxE1hrQaOinb3OD7Aido8cI/qlmKMSFKEl8UO6IQQecBqf6+S6KG8bslQSpij6wkSOKOHRdB@vger.kernel.org
X-Gm-Message-State: AOJu0YwnwNfOPNdKFKNcg/cSSI+6OAs8o6VhF9FT5bX8Mx2WJ4pnkSTN
	Q5R9qnXwwmvt2yvsMVriAgvRSIcQ2D5pURmFR2E0Ei2AneOYWaYKQQXYe13FxazHWMPVLzdLV8w
	w0whaDdDXu3m4MdzxtxW0LIW/CQ==
X-Google-Smtp-Source: AGHT+IFWmkCE81Tm2mvoVRJxeqLoR9tdqo2XQ+AgyKoHV9ZxQbPCvQG2HQklBmvrrBvGmQduTiT9sYVt/gndesa7n/U=
X-Received: by 2002:a05:690c:4484:b0:6ee:664e:8c33 with SMTP id
 00721157ae682-6ee664e92a2mr12401047b3.9.1731679638893; Fri, 15 Nov 2024
 06:07:18 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241105213217.442809-1-robh@kernel.org> <20241115072604.yre2d7yiclt5d3w5@thinkpad>
In-Reply-To: <20241115072604.yre2d7yiclt5d3w5@thinkpad>
From: Rob Herring <robh@kernel.org>
Date: Fri, 15 Nov 2024 08:07:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLkVUSgL-r1YvdSOTQGeN0r4Co=NRxvX1WL6q6yt0zN6g@mail.gmail.com>
Message-ID: <CAL_JsqLkVUSgL-r1YvdSOTQGeN0r4Co=NRxvX1WL6q6yt0zN6g@mail.gmail.com>
Subject: Re: [PATCH] dt-bindings: PCI: snps,dw-pcie: Drop "#interrupt-cells"
 from example
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 1:26=E2=80=AFAM Manivannan Sadhasivam
<manivannan.sadhasivam@linaro.org> wrote:
>
> On Tue, Nov 05, 2024 at 03:32:16PM -0600, Rob Herring (Arm) wrote:
> > "#interrupt-cells" is not valid without a corresponding "interrupt-map"
> > or "interrupt-controller" property. As the example has neither, drop
> > "#interrupt-cells". This fixes a dtc interrupt_provider warning.
> >
>
> But the DWC controllers have an in-built MSI controller. Shouldn't we add
> 'interrrupt-controller' property then?

Why? Is that needed for the MSI controller to function? I don't think so.

Now we do have "interrupt-controller" present for a number of MSI
providers. I suspect that's there to get OF_DECLARE to work, but I
doubt we really need MSI controllers initialized early.

Rob

