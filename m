Return-Path: <linux-pci+bounces-37481-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C2EBB59B2
	for <lists+linux-pci@lfdr.de>; Fri, 03 Oct 2025 01:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FDE84855B7
	for <lists+linux-pci@lfdr.de>; Thu,  2 Oct 2025 23:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D3B2877E0;
	Thu,  2 Oct 2025 23:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="Zvmvojs2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FDA16132F
	for <linux-pci@vger.kernel.org>; Thu,  2 Oct 2025 23:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759447318; cv=none; b=bDcVqUwZJE4aQhNJ6iNkhkzBn+ndlm3Y+Elnqni+SILwiSF4+6shNHbbEiEEkKNX/MAXamU9M2oFTSXjthWNl70knkPIWpIofzAUDbB1do6acPE1y4MMOKYm3FvFCzvtFHMZeR7NbQLeTmlkmO9gF87ksIDADEa9vOk3owGGG/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759447318; c=relaxed/simple;
	bh=Q9piomNJadBCp2fiMxMHhDI9JaKKkht2y11msmtagbE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jUJl0cZtyverUmMtiBdAJKI+y4fovaIjbtPhb/jnT06c/wUAcC2NaxvBONEL1yllW5T2F9TPNaNdx8dqTQxuZS44BqXjVmCH5PzVpp3OT9O6fW9KeWLf4wfzVRlCDFHLIqeVx2Z3oxZqOZlrcD8/gqQyCOXvn5qlffia1d5wFr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=Zvmvojs2; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4de659d5a06so9135681cf.3
        for <linux-pci@vger.kernel.org>; Thu, 02 Oct 2025 16:21:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1759447315; x=1760052115; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=r4Q5TvUjGnT97o6dwT74PCnUgaEQ50n5wSe+czl475E=;
        b=Zvmvojs2n8b3DHVvodSX+cfCCzevEBuIGFXL5b7FE1aFZVS/fUqtL6aww2nYp9UwtY
         j3O7gjARV9OpgkD6Pb34SQw8THiQJ7WAqZLyBiAvdL08ZB3TV4uu3DFr8RYJA4EfoYOz
         C5B4rnwC0p3+FoxFZ4M8t1YlSu7zsFiMlJgfQ/vRGewHALwOIm5khWqClL5wukP3URo5
         H6yUFxNlaI9yFKi90QzskI5SsfvL13Y3jUa6XJssg/bYQqBUBn0KgPdsO4s/20MYKDU6
         Vj8tcbrwO304Tkk9Zhx8VF4f+OYGOip8IzGsSoh7y8Ydn2KmzQhuN3yjr5lMgyj5NNWS
         OAKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759447315; x=1760052115;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4Q5TvUjGnT97o6dwT74PCnUgaEQ50n5wSe+czl475E=;
        b=nfDzPhpbhaVKpl75+m/82H4aoayFuLAd+SwAC+UkdcihcJu+nfbXv0Uo9tjGoVY+xk
         cqx9OdznZ3XUEJaF7fDThipqQQgyMOUspbLDLhc+ToTQLacRovPxUv7IPXUSh9nz8E/2
         kOVZWJyR1ehdrJBtTl+WLk+aoleBiRc6oeDF/X9VWL3gjM8PJHFtrAlKfI2Rv2eQXdQ9
         WESloNTM1zWD3el2E57rGcNofyIN2ttcU+PhHYaQD2KaS0NkP4lUJ1tvCamF0tQPbg7I
         HSUbk6yo/DuSiRfLnkMG78HpO7onEQI2oRbvsshbOUBBOAQnPZotEiUO5DlT8K5wYxC5
         DuxA==
X-Forwarded-Encrypted: i=1; AJvYcCUBX8mRHVfTIpRys0aoHnMq1LNNMlOuzFY4xEDc6+BpNSgXyYqyszzGJKafpnp4fjDd+/bHs/Tm828=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCkpD/Lb7z+deP08DxjfDg/KE/etaERO/lGrrrMKiwO4udz3H2
	XMHS7UQRr+H4oQpwawPUOevE+gq7MqvAVtwEfXRxKcb9pUwxJ3G0PpgESorTJjEHvas=
X-Gm-Gg: ASbGncv1m1nWpExNcVzN1qJyrGbTWkpFlEg5fiWsdHB3gLAfORZ1Dg0S9zDcfqc2AZ2
	0PdVnF0sgyLl/9zo6OCn2Udq7p6p8J1VbNajXX5osJYf8MQzDkZCz/PLVP7zyeBCMlExe8Hnesh
	uhRQaGu0PqVAP+Ew87VH9wHa/chownLhqlq5mgXlI+0/PPE6IxCzsBDLpMgtN0JuU8fvXbfunKu
	zSd19mKCWtA4CiJ70iE+rAZriIq/3w3e2aq+MPPAiOSl7clIaZSMdPsKJd7jFLSj1YYXLfY5l8s
	I00V4i386z3DY5xzjzA+C0ISlESAPoaJGBNqHaRHPaCm7F+88zqvgmFRetfd6oKCmYg3ML8k3P4
	oY5KzJAoJ2lIe0qg1cd6ee1We4WU9WVEFgL3bSVjo+AsANY+R5iUX0yhY6B7jcPoKEj+4wrLvM9
	ywu9nXbUnpR+ho418Y
X-Google-Smtp-Source: AGHT+IEWbApPpoYIPJegt+iiGZZw9VIY52dxn/8hHI3G948Gvy7kTmzBDX0DIUJHAUyutFT5hXVSqg==
X-Received: by 2002:a05:622a:14b:b0:4d8:531e:f896 with SMTP id d75a77b69052e-4e576a7b75bmr18718281cf.27.1759447315472;
        Thu, 02 Oct 2025 16:21:55 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-47-55-120-4.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.120.4])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4e55af265a4sm29033531cf.22.2025.10.02.16.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 16:21:54 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1v4ScT-0000000E1Uo-2AKk;
	Thu, 02 Oct 2025 20:21:53 -0300
Date: Thu, 2 Oct 2025 20:21:53 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: David Matlack <dmatlack@google.com>
Cc: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, Len Brown <lenb@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-acpi@vger.kernel.org, Pasha Tatashin <tatashin@google.com>,
	Jason Miu <jasonmiu@google.com>, Vipin Sharma <vipinsh@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Parav Pandit <parav@nvidia.com>, William Tu <witu@nvidia.com>,
	Mike Rapoport <rppt@kernel.org>, Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH v2 03/10] PCI/LUO: Forward prepare()/freeze()/cancel()
 callbacks to driver
Message-ID: <20251002232153.GK3195829@ziepe.ca>
References: <20250916-luo-pci-v2-0-c494053c3c08@kernel.org>
 <20250916-luo-pci-v2-3-c494053c3c08@kernel.org>
 <20250929174831.GJ2695987@ziepe.ca>
 <CAF8kJuNZPYxf2LYTPYVzho_NM-Rtp8i+pP3bFTwkM_h3v=LwbQ@mail.gmail.com>
 <20250930163837.GQ2695987@ziepe.ca>
 <aN7KUNGoHrFHzagu@google.com>
 <CACePvbX6GfThDnwLdOUsdQ_54eqF3Ff=4hrGhDJ0Ba00-Q1qBw@mail.gmail.com>
 <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALzav=cKoG4QLp6YtqMLc9S_qP6v9SpEt5XVOmJN8WVYLxRmRw@mail.gmail.com>

On Thu, Oct 02, 2025 at 02:31:08PM -0700, David Matlack wrote:
> I'm saying the only drivers that actually needed to implement Live
> Update driver callbacks have been vfio-pci and PF drivers. The
> vfio-pci support doesn't exist yet upstream, and we are planning to
> use FD preservation there. So we don't know if driver callbacks will
> be needed for that. 

I don't expect driver callbacks trough the pci subsystem, and I think
they should be removed from this series.

As I said the flow is backwards from what we want. The vfio driver
gets a luo FD from an ioctl, and it goes through and calls into luo
and pci with that session object to do all the required serialization.

Any required callbacks should be routed through luo based on creating
preserved objects within luo and providing ops to luo.

There is no other way to properly link things to sessions.

> And we don't care about PF drivers until we get to
> supporting SR-IOV. So the driver callbacks all seem unnecessary at
> this point.

I guess we will see, but I'm hoping we can get quite far using
vfio-pci as the SRIOV PF driver and don't need to try to get a big PF
in-kernel driver entangled in this.

Jason

