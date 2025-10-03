Return-Path: <linux-pci+bounces-37591-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17296BB82AB
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 23:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C26254A77AE
	for <lists+linux-pci@lfdr.de>; Fri,  3 Oct 2025 21:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6084325A357;
	Fri,  3 Oct 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuxvdsF8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B81A21B1BC
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 21:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759525598; cv=none; b=ix/2QVXr+avA9lTE6lnpy0cljEAHrH2khqCzpQxGAdf8z7iTYWG7RHiCs/n0tx461Du+0w8XUeEa3o6d8tjzxdVQm3GYHeKGEsDrCaFfE9SfBt7vE3P0Xaa6fdO4QOs1FTg0LAHVnNMafK29BZDqeQHcczHxanpWepM6qoC57lE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759525598; c=relaxed/simple;
	bh=smHvUO6y6+rxNgqQB01yRAJUFj9igvIQ+EulDbNNivE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xe1IstmL3KjM5AxIS+rOIsQc758Ne9nbyh/3FwYX3wmHdb77xo1jblsscvuNr2oMWj07DizX/MxMtfohKsc3qb/Ch3cYWuqxkk9nps0MY3y+4oqnl1TJzozN9bJO47AYPXnblH9RUjAg9zY+vcQx89UCRTWIkEezjzvyyKbaMKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuxvdsF8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC837C116D0
	for <linux-pci@vger.kernel.org>; Fri,  3 Oct 2025 21:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759525598;
	bh=smHvUO6y6+rxNgqQB01yRAJUFj9igvIQ+EulDbNNivE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=YuxvdsF81obCLJ71ofoqPhNPiaXXCs2cLAuKhJHTLKYJPg3xZB/1/TD/jINs5Ua1O
	 Rtyyv7gWnoOMH/wRsLROXHA7OlTRPHcVBim7n3Ic7lQkHLQ0oiXTT1+eBbogglLZZs
	 yee/zpw+DSs9juD2a6YG8OHoRwr9abz5XPL4tZWcCQs2/KHv7DeFRim5Th+P/IghRo
	 x0JqS55LS6sqHaeQCucG3YjnXzV3vSnWhu0maq4gYVQXH5uTJCcWU1YIvPC5+FHv7q
	 2IR763QV86/35lesoC5TEj8r8E5u74xlGebzUam+BzR8yV4ad2dDjIJ6vNRLQ/ydGO
	 6TRKtLaPPbMKA==
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-6360f986fb0so3121713d50.3
        for <linux-pci@vger.kernel.org>; Fri, 03 Oct 2025 14:06:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWW6ILkdxTRCzP0k5C7yIW8nNUgDXLvTPBItK+Ei+l+wOpTKQL5ef2BgzXrQBfbE/qk6aXTxe7JaQ8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdLRNxcac+ivZbO4Em8nX6sqibsOPqPNcDyIkxVv1jyjNzpko/
	RuzTC/XsqJVvxMsOdggI3Zy+eID1R0Svb3CcgjqUACy90aqZZAXbYOa0FU5AUZPMd4Uki3ALFa2
	dy+jHzWO2Wa0483dO2kCL65EoxYnOo/fwt2c4yrLP2Q==
X-Google-Smtp-Source: AGHT+IEwSPJ/yX5ZIhTiBfwNm0ItirHXcGbfQ0YU34j4BhQbTqiFL8oSKiBFAybUN0p/s6f72fePqzhe2TQ94F/S9ZA=
X-Received: by 2002:a05:690e:585:b0:636:18cc:fefb with SMTP id
 956f58d0204a3-63b9a064375mr2849137d50.5.1759525597099; Fri, 03 Oct 2025
 14:06:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-2-c494053c3c08@kernel.org> <20250929174627.GI2695987@ziepe.ca>
 <CACePvbVHy_6VmkyEcAwViqGP7tixJOeZBH45LYQFJDzT_atB1Q@mail.gmail.com> <20251003140457.GO3195829@ziepe.ca>
In-Reply-To: <20251003140457.GO3195829@ziepe.ca>
From: Chris Li <chrisl@kernel.org>
Date: Fri, 3 Oct 2025 14:06:26 -0700
X-Gmail-Original-Message-ID: <CACePvbVqSWnj_iBBNH6bZ+HJC_40coQhvCrFvKaHmYDspnRP5w@mail.gmail.com>
X-Gm-Features: AS18NWBk8FZfS9kE7tc1gSuNGpUXJqvl96bjWvHjlLAXWT0QpjpjfPViNEQhQXA
Message-ID: <CACePvbVqSWnj_iBBNH6bZ+HJC_40coQhvCrFvKaHmYDspnRP5w@mail.gmail.com>
Subject: Re: [PATCH v2 02/10] PCI/LUO: Create requested liveupdate device list
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	David Matlack <dmatlack@google.com>, Pasha Tatashin <tatashin@google.com>, 
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>, 
	Saeed Mahameed <saeedm@nvidia.com>, Adithya Jayachandran <ajayachandra@nvidia.com>, 
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 7:05=E2=80=AFAM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
>
> On Thu, Oct 02, 2025 at 10:33:20PM -0700, Chris Li wrote:
> > The consideration is that some non vfio device like IDPF is preserved
> > as well. Does the iommufd encapsulate all the PCI device hierarchy? I
> > was thinking the PCI layer knows about the PCI device hierarchy,
> > therefore using pci_dev->dev.lu.flags to indicate the participation of
> > the PCI liveupdate. Not sure how to drive that from iommufd. Can you
> > explain a bit more?
>
> I think you need to start from here and explain what is minimally
> needed and identify what gets put in the luo session and what has to
> be luo global.

That means it is a bigger conversion that PCI alone, this will need to
change the LUO subsystem design. I can start from the vfio/iommufd
point of view, if the liveupdate device is driven from the
vfio/iommufd side, what is the PCI layer needed to do collaborate. It
will likely end up changing the LUO subsystem and callback design. I
will make that my starting point for the next step.

Thank you.

Chris

