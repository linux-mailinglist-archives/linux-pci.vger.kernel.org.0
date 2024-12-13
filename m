Return-Path: <linux-pci+bounces-18384-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAF09F0F4E
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 15:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4292823E9
	for <lists+linux-pci@lfdr.de>; Fri, 13 Dec 2024 14:35:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24201E04BF;
	Fri, 13 Dec 2024 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N8Arj+08"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8654E53BE;
	Fri, 13 Dec 2024 14:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734100530; cv=none; b=GWk+HqUDKaQ4CIYgxy/rfUb/Lx2qu+xWO1ckYj42u/ohNPhuj9a0w5WqirSLE2MGy4c/yDiBR0CrmTy5AW2Mc9tj24w02iTJ6aVYrQyswc9Im7X4o3DtwHCEfTo/UFXb3C5d5pzGyD8wESwPBlU5+sxLgcQJWyYw8a7NXglAt2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734100530; c=relaxed/simple;
	bh=rNJFAtYA5eksohwxJIjGyRtuHzibdqKAMtZF33hOZnE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R36zrMNL3d0sg/YGRZV5q+IaOSYgq2f0KP4okbGk1Ukh9Cj6m51biJavhp9h3ggjBLMODZAwKMkvCU6i3x/Tm3praGB4HFsqCYpeOe63aMCFs0BLq+hWv45MjORY6gZjLpiZBESEZQPZdtttRRvMziNO0ag3M5o/FVvsEpmMN0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N8Arj+08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09088C4CEDF;
	Fri, 13 Dec 2024 14:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734100530;
	bh=rNJFAtYA5eksohwxJIjGyRtuHzibdqKAMtZF33hOZnE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=N8Arj+080Q8Bvt4gcIRleZGalv0b18WNi6SIWaofAWCs9cgsmHcbUbn3UlcUzQGBj
	 18bHWSs/NC0i1jAOZCLRKflqQzoWJrZKjGlE+waELgKUVDTtTRsF5iOEQa/oQtFZKA
	 8d7XVzgdmvBcX1VmhK4bTdLSjP2lU2OFDspzKDjEv4GdPdwHldaMBbQUkyAvetRCXj
	 pwRhvy9OcqPHvPYg9MIw5wjqE2r3cYqxT7Z9ozr5u4ZxLimRQhf7X2VMj//2deOnZe
	 ij9tcOqijr0jR5dr3qmaQrHnc4Wy0ceg7Mh2qlDQOhD+oXb9GmaGsou8blRg9MmUEc
	 isX/ijNh2jctw==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3eba347aa6fso756968b6e.3;
        Fri, 13 Dec 2024 06:35:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWW/dCcsTSEzyzh83nNaXNNAwblI0BnA8V5mnX4y6XOIO3TjA7r0tIeAOuyEwaErBehvGDpXkt+0foP@vger.kernel.org, AJvYcCWa/sxtqNyqFrZy+omRbHyMRrNZBXFVfrRuFg811DTd5ce6hm/CaeWpEbPdo22s6zLFOSB6I0vPoSM=@vger.kernel.org, AJvYcCXnEqpwf+YOK/X1jHxj9dx7EgtiqJojWHatN7Zer7EssS1yHfgMw4jYxeGcM/ZBZeZfnA5xhNadAahHU2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSwPXWoufPGx5II2V+EYOP6HTDPMj0JKb/Fjh+HBOe9DxhsqUP
	6GJQDiFH5BQQnDtIr9BNzDQJSEUW9pRi7SQ0xfHdJFQlg9ob7HPBtlU4pz7e8f5je+0wpwffLll
	V6dG86VXpRrMB0kIbQP19Z2IINss=
X-Google-Smtp-Source: AGHT+IFfOFfVyFc4e2ZBGKXJgwfpRMnnYPRRl89VhFh3RmkUkQjqu6RTHIO8ptQLeagYlw8Qi6Fx0hYaADxx5ZLz+kA=
X-Received: by 2002:a05:6808:13c6:b0:3eb:60e9:eae1 with SMTP id
 5614622812f47-3eba6948a1amr1662834b6e.29.1734100529125; Fri, 13 Dec 2024
 06:35:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205232900.GA3072557@bhelgaas> <20241209143821.m4dahsaqeydluyf3@thinkpad>
 <20241212055920.GB4825@lst.de> <13662231.uLZWGnKmhe@rjwysocki.net>
 <CAPDyKFrxEjHFB6B2r7JbryYY6=E4CxX_xTmLDqO6+26E+ULz6A@mail.gmail.com> <20241212151354.GA7708@lst.de>
In-Reply-To: <20241212151354.GA7708@lst.de>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 13 Dec 2024 15:35:15 +0100
X-Gmail-Original-Message-ID: <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
Message-ID: <CAJZ5v0gUpDw_NjTDtHGCUnKK0C+x0nrW6mP0tHQoXsgwR2RH8g@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: Shutdown the device if D3Cold is allowed by the user
To: Christoph Hellwig <hch@lst.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Bjorn Helgaas <helgaas@kernel.org>, kbusch@kernel.org, 
	axboe@kernel.dk, sagi@grimberg.me, linux-nvme@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, andersson@kernel.org, 
	konradybcio@kernel.org, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org, 
	"Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 4:14=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Thu, Dec 12, 2024 at 01:49:15PM +0100, Ulf Hansson wrote:
> > Right. This seems to somewhat work for ACPI types of systems, because
> > ACPI is controlling the low power state for all the devices. Based on
> > the requested system wide low power state, ACPI can then decide to
> > call pm_set_suspend_via_firmware() or not.
> >
> > Still there is a problem with this for ACPI too.
> >
> > How does ACPI know whether it's actually a good idea to keep the NVMe
> > storage powered in s2idle (ACPI calls pm_set_suspend_via_firmware()
> > only for S2R and S2disk!?)? Especially when my laptop only supports
> > s2idle and that's what I will use when I close the lid. In this way,
> > the NMVe storage will certainly contribute to draining the battery,
> > especially when I won't be using my laptop for a couple of days.
> >
> > In my opinion, we need a better approach that is both flexible and
> > that dynamically adjusts based upon the use case.
>
> Agreed.  I'd be happy to work with the PM maintainers to do this,
> but I don't really know enough about the PM core to drive it
> (as the reply from Rafael to my mail makes pretty clear :))

I'm here to help.

Let me know what exactly you want to achieve and we'll see how to make it w=
ork.

