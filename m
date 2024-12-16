Return-Path: <linux-pci+bounces-18567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3129F3A12
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 20:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE97F1883094
	for <lists+linux-pci@lfdr.de>; Mon, 16 Dec 2024 19:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5531B20ADEB;
	Mon, 16 Dec 2024 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0Rs4OZk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C6F20A5FD;
	Mon, 16 Dec 2024 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734378216; cv=none; b=KxMmfzsXpsKtwR2k2pvEansv4S0qC/yHGODU2u94tzQEqpopHcqAGU+EeYVBPmFWweEMqcneLn9UQ4WWKtayyezK7ayvHEQcbMR7UoM9b/FdkTgauhw7sNxsYD3RGdk9Y4m+vAWh6vEW3EkKujta/w+cnH/VZ/tIYQt5v7yn0MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734378216; c=relaxed/simple;
	bh=bLCUG42w9Rd2j2ctr/dQMjIHxW6uq1VaCrTcAGQt3vQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O2sfq9MODD8qcuj1cQ1/I4AReoML4jZXHnyM+ABRzZyOtdXq6Sk/9+A7ipgiZ4oLZrIUnuKvkiHwUft5CeYEWJ8wury/VimeOZfa6nIxLOvX7sb9KDxjTlq1IDnnZtIBo45Hnafzq1fFukO8Y7aR/u9rmzh/Thj3TjLxjNNxw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0Rs4OZk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DF4C4CED0;
	Mon, 16 Dec 2024 19:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734378215;
	bh=bLCUG42w9Rd2j2ctr/dQMjIHxW6uq1VaCrTcAGQt3vQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=R0Rs4OZkNJFFbVLkxGZkocsVxkqWzRWQUbF7JQOf7Ia5kzkKZIBNEyWgaYt0laS02
	 v6bniI96SOM8buGJQCOS6vEEsLRfDFYfBKQmQoOIpSJGsjEgO6zjMQj7tVbZYfXGND
	 gED7MAQU1bO1u8uSKJi2VEnV/U9unIpshjn5CHXmHnBB7iIZkB3wIqpgsDuRxb3Xn1
	 ktzzVZV20cTNjbxORcBPdnepF+e3UT5CP6Yv0UGUh6oIPYbwdOwOcRl3gKHjOsGk8k
	 GtDA9dkjnif9DXvhiaics/9Xy9KfVGCJxvRT8DRvppRDkvpMEp6s8cQgdR48iGT7OD
	 aJG2KRR6r1DLQ==
Received: by mail-oi1-f169.google.com with SMTP id 5614622812f47-3eb8559b6b0so2471302b6e.1;
        Mon, 16 Dec 2024 11:43:35 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUWLvqgPqBepfvXyuhcqqJJWQ43ef9TG7WQwwx0AmN98/AyouYRaA/TjKhj93k2ZIuMTCbhf6rgVGdwKQ=@vger.kernel.org, AJvYcCVtWDR1IYAuqyLgAIkhM/FOL2Ss3BHdw4YyDvRoOrSCawK8Jsp/dnz2/4sxOI7ASBQo6rk088Oeb0BQ@vger.kernel.org, AJvYcCXux2aqM3833boqqyeTMmkbYhS3VuDabMpG5byqzEyec6vJJulzamp4PAWkkxOBKZkt86GJSpNSLcw=@vger.kernel.org
X-Gm-Message-State: AOJu0YycfYKbKNsSPedv0jIZWwQkA7kq6Hc0ptp1VBZZ8QWEwFfrbMCN
	OJqOI8cZNdo0k/UTDbIyRIx+VfOXhfzsAmjNQ8dct8XNEQx1gPH1qpQewSkkq1QowFAZUo+VRZY
	9EPrj2KjMcbJbrvCv+YKFVyAYBig=
X-Google-Smtp-Source: AGHT+IHBIkkg9ryeWoXUjvDA+eOStEt8YeUf9CRTqn6A5LAOHY0mQEKE5h0I8dvOns0NI/pgRtXFEf2n3JxCdyuWQY4=
X-Received: by 2002:a05:6808:2448:b0:3eb:60e9:eae1 with SMTP id
 5614622812f47-3ebcb33635dmr15143b6e.29.1734378214876; Mon, 16 Dec 2024
 11:43:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <13662231.uLZWGnKmhe@rjwysocki.net> <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com>
 <20241212151354.GA7708@lst.de> <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
 <20241214063023.4tdvjbqd2lrylb7o@thinkpad> <CAJZ5v0gLMx+tBo+MA3AQZ7qP28Z91d04oVBHVeTNcd-QD=kJZg@mail.gmail.com>
 <20241216171108.6ssulem3276rkycb@thinkpad> <CAJZ5v0j+4xjSOOy8TYE0pBuqd_GdQa683Qq0GEyJ9WAFad9Z=A@mail.gmail.com>
 <20241216175210.mnc5kp6646sq7vzm@thinkpad> <CAJZ5v0grRdTYaamSnKSF-HyMmCHDEZ4haLo+ziSBxhDg1PbjRQ@mail.gmail.com>
 <Z2CCH5HAbx8ECDin@kbusch-mbp.dhcp.thefacebook.com>
In-Reply-To: <Z2CCH5HAbx8ECDin@kbusch-mbp.dhcp.thefacebook.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 16 Dec 2024 20:43:23 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0jfaNjgjNAQPa3QPNdU8BCoocsbo4Vfo5obTxcyTKOUWw@mail.gmail.com>
Message-ID: <CAJZ5v0jfaNjgjNAQPa3QPNdU8BCoocsbo4Vfo5obTxcyTKOUWw@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Keith Busch <kbusch@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Christoph Hellwig <hch@lst.de>, 
	Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Bjorn Helgaas <helgaas@kernel.org>, axboe@kernel.dk, sagi@grimberg.me, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, andersson@kernel.org, konradybcio@kernel.org, 
	Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 16, 2024 at 8:40=E2=80=AFPM Keith Busch <kbusch@kernel.org> wro=
te:
>
> On Mon, Dec 16, 2024 at 08:34:24PM +0100, Rafael J. Wysocki wrote:
> > However, there is an additional concern that putting an NVMe device
> > into D3cold every time during system suspend on Android might cause it
> > to wear out more quickly.
> >
> > Is there anything else?
>
> I recall a previous reason for this behavior was because the resume
> latency was significantly faster if we don't prepare the device for D3,
> and the nvme protocol specific power states for some platforms was
> sufficiently low enough. Apparently this choice hasn't been universally
> optimal.

Thanks for chiming in!

I'm recalling some other reasons too (mentioned in one of my previous
messages), but overall this is a driver design choice, it is not done
to adhere to some general rule.

