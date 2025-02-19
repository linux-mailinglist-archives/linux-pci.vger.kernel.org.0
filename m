Return-Path: <linux-pci+bounces-21843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 036F7A3CC92
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 23:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF08C18947C0
	for <lists+linux-pci@lfdr.de>; Wed, 19 Feb 2025 22:43:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3519325A35D;
	Wed, 19 Feb 2025 22:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PKdANEYz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547625A34B;
	Wed, 19 Feb 2025 22:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740005005; cv=none; b=c1qEuVuDmsxLlTp7urVmQoTmrNykL71dGtod9vMTFNQqgY8Cd8dbIxngMM2rsrjRRtKuOMZyQ8RT7LxDJxWrPOo+RLZGRPaQAnJTqglo9fnJqu27ka+4BSyTgpZNC9ky+kE0sChAiumps7aaU+L83zRsRucblRk6potm+MwxWZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740005005; c=relaxed/simple;
	bh=oB01MPEv8LjdiYQ+OxWvCnlcAnbSN33JSl8xlJVCC9k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FjSiucQh0cQnEMGWgz53Xog6O4+zKikwgjfFOgMQT/SzVYuuElMZvwBPJFER5u+UxfnJq669CGnn4DfVe3bfcI0lZ/rUv49YCf16ymHjIeaTKAJsv2lylHfWZzTzWHiSGoLPGlVF9tvBTp++KUqBYpHHMk5xQgyHT9WRjmk+c68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PKdANEYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64B31C4CED1;
	Wed, 19 Feb 2025 22:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740005004;
	bh=oB01MPEv8LjdiYQ+OxWvCnlcAnbSN33JSl8xlJVCC9k=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=PKdANEYzNjjbIr38NUk7z5p+Z9F+jXUNOmA/lCJpQk0PIvqLqO1KpO0bseNfZeNob
	 rLtJk3fBlNATiACZPTodvbpgflqT7l3UK4V7RSUPAq2k7JSBXpDoUiU8OcNRQBWAup
	 97RceaLpTYnX79uBjTd2v9iXYkUuKF/fOxMSmENUd9V0KSXP3vCnuXbx5c6y8PCbxe
	 HrXq0fUDtdNUmRi/saRgQ6+7SHEZK8KUz08YiBb4ITIw/iejPUG24gETgwfO0QILbq
	 rww1v9l2Y4wNnor4HcMEcCjb67uxHLwqtXO6Jmr3eFMSO9Dv7k7ATme476m1vIgAD8
	 z6O9Lj1jIyaFw==
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e04cb346eeso404257a12.2;
        Wed, 19 Feb 2025 14:43:24 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUw8wsyr+kDIoHS+Obdy+m4O2nN6FDJ66Qg8cZiAON6AHjvqJgsKwIaAboO9a4hePksKco4SUZ2sO1XYg==@vger.kernel.org, AJvYcCVXxz3TEa/wqCl+wEs0/pdc4qyetF0jwseKV2fNY7eGU6w9BPAs/iH2ZNUuOWqxC6NRXlcRVUhTnEPK@vger.kernel.org, AJvYcCWCcBAqe5QyKa48/9qla0OoOe4lD+4eqN40lAXj5YXh0daERut4eBuK8zExTzbV9F3QIBOfdLlGXCMrjDY/@vger.kernel.org, AJvYcCWI4QYUha0s4Zd6OzgWG3anWgb8mtaLAet9uA45yZrWVzFJFiRMGNkmNGY0xFygWY09pyyHlbDhutUx@vger.kernel.org
X-Gm-Message-State: AOJu0YzOkO83LYDOULBM875nE8gp7gFTKehyu1/PxpaOhHd0gynxoWn1
	fc8fm0jdQeAxM5ym5Y/PUhZ+OSB0OO1Cy/yr/+sXO2omfak3wN8N7Cb/IwP2uNqBZmoKsrrmup2
	1Iir2XqW1/J9JD119EeGDdT/g3A==
X-Google-Smtp-Source: AGHT+IFKS59MJjzGgNFJyErjdo066Kf2RALm9L7HJRWP4YBWsnRrUMaiDEu5+latsq8sxVCx8lc/g5fr4x7Fq4A6sTU=
X-Received: by 2002:a05:6402:381b:b0:5e0:8920:c4c5 with SMTP id
 4fb4d7f45d1cf-5e0a4afb1ddmr203602a12.11.1740005002935; Wed, 19 Feb 2025
 14:43:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1739486121.git.robin.murphy@arm.com> <c2f0ae276fd5a18e1653bae8bb0c51670e35b283.1739486121.git.robin.murphy@arm.com>
In-Reply-To: <c2f0ae276fd5a18e1653bae8bb0c51670e35b283.1739486121.git.robin.murphy@arm.com>
From: Rob Herring <robh@kernel.org>
Date: Wed, 19 Feb 2025 16:43:10 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+RA3ojYgqkELOrCd68JHRGPsuObzbRi3RA6eV7NYh0Cw@mail.gmail.com>
X-Gm-Features: AWEUYZnOMA-FyQa1U3tn01tUjPcRrp-PbPJQL6m4k_dHn-Ztt3nE99iHpRmo__k
Message-ID: <CAL_Jsq+RA3ojYgqkELOrCd68JHRGPsuObzbRi3RA6eV7NYh0Cw@mail.gmail.com>
Subject: Re: [PATCH 2/2] iommu: Get DT/ACPI parsing into the proper probe path
To: Robin Murphy <robin.murphy@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Hanjun Guo <guohanjun@huawei.com>, 
	Sudeep Holla <sudeep.holla@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Russell King <linux@armlinux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Danilo Krummrich <dakr@kernel.org>, Stuart Yoder <stuyoder@gmail.com>, 
	Laurentiu Tudor <laurentiu.tudor@nxp.com>, Nipun Gupta <nipun.gupta@amd.com>, 
	Nikhil Agarwal <nikhil.agarwal@amd.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Saravana Kannan <saravanak@google.com>, Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	iommu@lists.linux.dev, devicetree@vger.kernel.org, linux-pci@vger.kernel.org, 
	Charan Teja Kalla <quic_charante@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2025 at 5:49=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> In hindsight, there were some crucial subtleties overlooked when moving
> {of,acpi}_dma_configure() to driver probe time to allow waiting for
> IOMMU drivers with -EPROBE_DEFER, and these have become an
> ever-increasing source of problems. The IOMMU API has some fundamental
> assumptions that iommu_probe_device() is called for every device added
> to the system, in the order in which they are added. Calling it in a
> random order or not at all dependent on driver binding leads to
> malformed groups, a potential lack of isolation for devices with no
> driver, and all manner of unexpected concurrency and race conditions.
> We've attempted to mitigate the latter with point-fix bodges like
> iommu_probe_device_lock, but it's a losing battle and the time has come
> to bite the bullet and address the true source of the problem instead.
>
> The crux of the matter is that the firmware parsing actually serves two
> distinct purposes; one is identifying the IOMMU instance associated with
> a device so we can check its availability, the second is actually
> telling that instance about the relevant firmware-provided data for the
> device. However the latter also depends on the former, and at the time
> there was no good place to defer and retry that separately from the
> availability check we also wanted for client driver probe.
>
> Nowadays, though, we have a proper notion of multiple IOMMU instances in
> the core API itself, and each one gets a chance to probe its own devices
> upon registration, so we can finally make that work as intended for
> DT/IORT/VIOT platforms too. All we need is for iommu_probe_device() to
> be able to run the iommu_fwspec machinery currently buried deep in the
> wrong end of {of,acpi}_dma_configure(). Luckily it turns out to be
> surprisingly straightforward to bootstrap this transformation by pretty
> much just calling the same path twice. At client driver probe time,
> dev->driver is obviously set; conversely at device_add(), or a
> subsequent bus_iommu_probe(), any device waiting for an IOMMU really
> should *not* have a driver already, so we can use that as a condition to
> disambiguate the two cases, and avoid recursing back into the IOMMU core
> at the wrong times.
>
> Obviously this isn't the nicest thing, but for now it gives us a
> functional baseline to then unpick the layers in between without many
> more awkward cross-subsystem patches. There are some minor side-effects
> like dma_range_map potentially being created earlier, and some debug
> prints being repeated, but these aren't significantly detrimental. Let's
> make things work first, then deal with making them nice.
>
> With the basic flow finally in the right order again, the next step is
> probably turning the bus->dma_configure paths inside-out, since all we
> really need from bus code is its notion of which device and input ID(s)
> to parse the common firmware properties with...
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/acpi/arm64/dma.c        |  5 ++++
>  drivers/acpi/scan.c             | 10 +++-----
>  drivers/amba/bus.c              |  2 +-
>  drivers/base/platform.c         |  2 +-
>  drivers/bus/fsl-mc/fsl-mc-bus.c |  2 +-
>  drivers/cdx/cdx.c               |  2 +-
>  drivers/iommu/iommu.c           | 43 ++++++++++++++++++++++++---------
>  drivers/iommu/of_iommu.c        | 10 +++++++-
>  drivers/of/device.c             |  7 +++++-

Acked-by: Rob Herring (Arm) <robh@kernel.org>

>  drivers/pci/pci-driver.c        |  2 +-
>  10 files changed, 60 insertions(+), 25 deletions(-)

