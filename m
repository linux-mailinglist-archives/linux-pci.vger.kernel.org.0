Return-Path: <linux-pci+bounces-37485-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2DBABB5A0A
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 01:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7510348055A
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 23:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63529186E2E;
	Thu,  2 Oct 2025 23:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f5LjvHRQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D8A2BE658
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 23:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759448568; cv=none; b=TCo1vkw9wEnCOPlvO42im5oRBcT0EbhZMlhAQj1uRQ2+PreBM1etOrpXv4x5+pjH9eiGKFXrhsNNacolNKnjqBGzXoiiXmp+aMmWWs4TTNEhD9+OLSekQNKrzjINQxyeCi50JTxkQGTYPK8u5VkB6e/qw/F5bEAMR72TD1DvHU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759448568; c=relaxed/simple;
	bh=gJjbvYewm3FTigD0IImKi1Lk/ATATeELfBSgVimlQSI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XI9HA6vj0GpFB19rlzs2in2BOXxoOS0j4RHP+HHTdQcD6T1TxA+c9n2T/JHkPxbOqIwefVjtQGsjJvMNXUfnEVnUoxP8eAb9j4aRit0L2aV0DzvrwByJ+Du02p1prqNKl0Iim4Tixe21hIfU/wG7QzY75+AvsxB14obJzoLUSsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=f5LjvHRQ; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-57a604fecb4so1940462e87.1
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 16:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759448565; x=1760053365; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gJjbvYewm3FTigD0IImKi1Lk/ATATeELfBSgVimlQSI=;
        b=f5LjvHRQotQl+77GppalK+NyD3GAHZPeusJyRA5cQuy8BMlOTotdmPcwlSW5i+MhOt
         4QgQwVy6ns3v8ziYbDOHcULLRVBr8noSeXubvfjJf3TliSFXNRGZTUIlguq89EE2Psv7
         JewIed/gHhArhtPJsPTiipgUUeNbcXvAnLHMnSrOzBC5zGN4hMHqX3oSQ/ns8e+dQF25
         hfXbLas4dwBcvSt5iswiGdJee5qWOHYo3kLKPl/sYloK3R62gpqXFv+q2mi+9+uDO0jo
         1JnM5aeEaHd3FZ0S2EORso2a8DFpsbYxYoWhZ1WxHow2tjwT1wddMjJCYqhu5sa96zuy
         gH+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759448565; x=1760053365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gJjbvYewm3FTigD0IImKi1Lk/ATATeELfBSgVimlQSI=;
        b=rDuIFhtc4JlNaNvQLrjD/cT7u4cba+tbX8SOBGKE4tRVvHGgBcaEqzYQW9jBLotToo
         AlLsRf1YhxIwM2lH0HGraNSLYv2sSQqI0jqG7hnUGkF3FMiQT8J2/QYaFhrrO2+gO1SH
         lO4pjpGIC+lMKVRJtdcazs82tX0z5Kia6KKsHyh1qY5cqlVJ8nSynOY/HH/uXdqjPDy+
         gWZX4MhZpAIxpVTaO3oxiYADouS0tEqXWXz0pcZD8zvDXunO+83/Wk+t+uBVnpCnohpQ
         ZuUy9oCFpwK5f/pfkT+HNGlmbM/XfGjPpeNdW55DIEWfB2NLll7gNInZd+vD7CghChog
         w1Iw==
X-Forwarded-Encrypted: i=1; AJvYcCUk8c7kKgaIG2Brp5DZIE+1kR0vi12Z2yLZKB7S7CP6Lpz4CBVO0v4FaCg4cqagI750zpQgCAvJfYs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzWlNO24mS8lHyMwpcW+kiBLmwwgq4JEqz09uaza/gcDnrgADB3
	JSrS23JEOUaanfzqXsjO4fOXdhCh6WJtpO6FD2g8/p2rB2WzYiM8EiHcQV6woWnP5EdskAA0sfP
	hLMdPb49SZzsP0CW7+GXIX8WDVcvIntN+Jw/qCB1R
X-Gm-Gg: ASbGncv58Ss73ikNfX9BwNZ1O0rht8gp9TraQc3/iMTmLwywNjWI59PqE/kjGXzd+tE
	KgEQ98YocdlIvkV5Lz+AFYqwiCJrRpv8jLOh1yy9lxvoHadfGamHgU7gTHHIo62zaDaEl60cSN7
	UOSJpxfctrl+mscoPCOslKAZ3wwxWTElt02vQezjE8WCqsVdyPGWU0wcTG8BZ67ZQQP/I+yF09l
	PtHHnLVszUwYh0bx9BkK233TGdho5HHZIbPtw==
X-Google-Smtp-Source: AGHT+IFZ1jB2tcB8G2J26ZHxSJC11SyLjkju2JvcqrxYVc6SMqqMcsiXwmwlMmW41AI7IKEGdEauVtUZQAHZX9zl4fs=
X-Received: by 2002:a05:651c:50c:b0:360:c716:2666 with SMTP id
 38308e7fff4ca-374c3849b72mr2777821fa.30.1759448564630; Thu, 02 Oct 2025
 16:42:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org> <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca> <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com> <20251002232153.GK3195829@ziepe.ca>
In-Reply-To: <20251002232153.GK3195829@ziepe.ca>
From: David Matlack <dmatlack@google.com>
Date: Thu, 2 Oct 2025 16:42:17 -0700
X-Gm-Features: AS18NWDaj8RvZipjEJ2QAatnJ0ODM4jInJmPqpdDhTEeGpvwrsDlFmhWeb1pz7I
Message-ID: <CALzav=cYBmn_t1w2jHicSbnX57whJYD9Cu84KJekL0n2gZxfmw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org, 
	Pasha Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, 
	Vipin Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>, 
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 4:21=E2=80=AFPM Jason Gunthorpe <jgg@ziepe.ca> wrote=
:
> On Thu, Oct 02, 2025 at 02:31:08PM -0700, David Matlack wrote:
> > And we don't care about PF drivers until we get to
> > supporting SR-IOV. So the driver callbacks all seem unnecessary at
> > this point.
>
> I guess we will see, but I'm hoping we can get quite far using
> vfio-pci as the SRIOV PF driver and don't need to try to get a big PF
> in-kernel driver entangled in this.

So far we have had to support vfio-pci, pci-pf-stub, and idpf as PF
drivers, and nvme looks like it's coming soon :(

