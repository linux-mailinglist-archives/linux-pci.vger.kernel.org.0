Return-Path: <linux-pci+bounces-18908-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B88D9F9228
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 13:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664031664FD
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 12:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CAD204596;
	Fri, 20 Dec 2024 12:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TpNOoME2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD513C914
	for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 12:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734697625; cv=none; b=JscZLc105Sp9F4WbJGcipY96VMFiUsMB2p82JjPDQAuxV9OuwFuyUJGgwDHqBgPAxhAdPra9JC3dxXutsTIajj/cPGVLX34vOZMFuzz0YRxKmufyVRXFZnCefgCfZe1n4ZRw/WxLJzx+Ofj+l6CyZf35nwKFzWWo6cmCs2iXlPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734697625; c=relaxed/simple;
	bh=VEHgtPfPlauGelApB0lmhVxM9hgt/V7Dh8U7Qt+FYes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=usBM3x31mszAnbt/C/S9KM4Sqb4Wzgn/ETdyM8SqS+SgTLN/Zx/QthGAo0dXD0gJf9Egar27tH2O5BZj5BEXqMyw6woleQuyPGQG4E+bOGwa7tF9bKWIBUKd0fnT8QZp3SepQuCPXRJS1lyxzTvlLZBH0i7SDscuP4fbRwFihvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TpNOoME2; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7fd49d85f82so1421266a12.3
        for <linux-pci@vger.kernel.org>; Fri, 20 Dec 2024 04:27:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1734697624; x=1735302424; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=d34YpD18XPJbPPq+gzX4Ba4pRSVyQOB2rh5MKz2PYrM=;
        b=TpNOoME24uZH1QChVZn0Pkuanbr83Slltj8RIOhfIb9YY3LPuzPK2a5Js7vpvtHqlJ
         sdWgZdRFBj0n4NGatdVCeWiQ/MWDxSgEIaRHgmQZ1OaxZRTBMaEnK2rD4PiX/VXzDHUl
         ZPNtabbp71SuxFFHj31ikmCc+4x80wwkaYq0tfGWNDQIOrhdyciSuFDX3jSgj2W5fZqH
         bfL5/+T/9LSsVHTv3DVQxhxL8PueL1XLwb+3Pb629LTYN8jk7plAbV2l2msMbVY5g2IN
         DK3CtnR8EoR+XT4D6XxD3gl9ovlIi0PZs+9AkTh5XMdhHt+ngAyUUkHoD+ms/dbwB6aU
         XkQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734697624; x=1735302424;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d34YpD18XPJbPPq+gzX4Ba4pRSVyQOB2rh5MKz2PYrM=;
        b=OIb8KPfBkrmRqpC81/Qt9kND+39Dh+ItuEcec1o6Y27zRyik+7MHrDoNROUOb4NbdB
         U1fcBtQfcmGlLcYfmHIjCxacpjtjfeHkjKwg2V9lN/S3PEofujDFxLbuZnKaiyvq2ACN
         j/XkTY82/q7Ct6wbye/INfCl0Bv/2o17HQQl293OKrwNRtZS5o/v0RvlpwGCKKq8sdFx
         KhWZjOcxoWnUKbjg5wve4JSg6pNQ28gG+D3YXdR2TCUbJAEG36tUTUdofcJY6J7GeLgp
         8d6EevAiRRVUvckRiT0RlM33vy2UPv4mxbJdu3xPA71vC5SAaOJbh0t3vfjcde5YmVqS
         h75g==
X-Forwarded-Encrypted: i=1; AJvYcCVVkBL5MYHUin6YymP5sE82+LKSe5kAgq+EVyHRXORh1FAY2og39Bdsy28uMOY69w21qO2P9BJA6lM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD61DgShjiufSpbsjmUZGiWxg6w1e2AXCq1hi68QRHm16YvoWa
	Q8JEey4Co+8rtCkVrhQPdMjA4ZQn3d+xF7AAqcrwhZWslnhS+nTKgFoourqGvQ==
X-Gm-Gg: ASbGncsBRZgYWU6F38F+Z/SyB8w4KzYm2NHx0nxO4M9vgW54RxrYQJ43AvMeaLTp4Om
	0lLKatQvltq2yjcaCAGvPKPnxS58SUkGdE0BEyssA6XVI5vw5gq7ySVWeC/qK3YF9FdfRT5sfOD
	975akDbUxhdy0KqNnMhv3mHkN7UlNdeOEnPsgL5ZZOp86EnY4EjHm7gxyLjg2lhM8000XgPBawI
	6JA49DBdJYwRwdwVom0x76392BF/wn6aKmNqNQGab3BnV1n8mAMBQecHGT7kzkyi8EBKQ==
X-Google-Smtp-Source: AGHT+IFrG9eb4Q5oiwTAQ33mdTfGdeqS6zs2mHn0GS/AJHJxe5SNvbyKKhrl2al1o1wJ0gQ5KPwUgQ==
X-Received: by 2002:a05:6a20:158c:b0:1e0:d6ef:521a with SMTP id adf61e73a8af0-1e5e043f6c0mr4790958637.1.1734697623521;
        Fri, 20 Dec 2024 04:27:03 -0800 (PST)
Received: from thinkpad ([117.213.102.140])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8164c7sm2981317b3a.4.2024.12.20.04.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 04:27:03 -0800 (PST)
Date: Fri, 20 Dec 2024 17:56:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v7 00/18] NVMe PCI endpoint target driver
Message-ID: <20241220122656.mb7bs47pfw2xbadr@thinkpad>
References: <20241220095108.601914-1-dlemoal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241220095108.601914-1-dlemoal@kernel.org>

On Fri, Dec 20, 2024 at 06:50:50PM +0900, Damien Le Moal wrote:
> This patch series implements an NVMe target driver for the PCI transport
> using the PCI endpoint framework.
> 
> The first 5 patches of this series move and cleanup some nvme code that
> will be reused in following patches.
> 
> Patch 6 introduces the PCI transport type to allow setting up ports for
> the new PCI target controller driver. Patch 7 to 10 are improvements of
> the target core code to allow creating the PCI controller and processing
> its nvme commands without the need to rely on fabrics commands like the
> connect command to create the admin and I/O queues.
> 
> Patch 11 relaxes the SGL check in nvmet_req_init() to allow for PCI
> admin commands (which must use PRPs).
> 
> Patches 12 to 16 improve the set/get feature support of the target code
> to get closer to achieving NVMe specification compliance. These patches
> though do not implement support for some mandatory features.
> 
> Patch 17 is the main patch which introduces the NVMe PCI endpoint target
> driver. This patch commit message provides and overview of the driver
> design and operation.
> 
> Finally, patch 18 documents the NVMe PCI endpoint target driver and
> provides a user guide explaning how to setup an NVMe PCI endpoint
> device.
> 
> The patches are base on Linus 6.13-rc3 tree.
> 
> This driver has been extensively tested using a Radxa Rock5B board
> (RK3588 Arm SoC). Some tests have also been done using a Pine Rockpro64
> board. However, this board does not support DMA channels for the PCI
> endpoint controller, leading to very poor performance.
> 
> Using the Radxa Rock5b board and setting up a 4 queue-pairs controller
> with a null-blk block device loop target, performance was measured using
> fio as follows:
> 
>  +----------------------------------+------------------------+
>  | Workload                         | IOPS (BW)              |
>  +----------------------------------+------------------------+
>  | Rand read, 4KB, QD=1, 1 job      | 14.3k IOPS             |
>  | Rand read, 4KB, QD=32, 1 job     | 80.8k IOPS             |
>  | Rand read, 4KB, QD=32, 4 jobs    | 131k IOPS              |
>  | Rand read, 128KB, QD=32, 1 job   | 16.7k IOPS (2.18 GB/s) |
>  | Rand read, 128KB, QD=32, 4 jobs  | 17.4k IOPS (2.27 GB/s) |
>  | Rand read, 512KB, QD=32, 1 job   | 5380 IOPS (2.82 GB/s)  |
>  | Rand read, 512KB, QD=32, 4 jobs  | 5206 IOPS (2.27 GB/s)  |
>  | Rand write, 128KB, QD=32, 1 job  | 9617 IOPS (1.26 GB/s)  |
>  | Rand write, 128KB, QD=32, 4 jobs | 8405 IOPS (1.10 GB/s)  |
>  +----------------------------------+------------------------+
> 
> These results use the default MDTS of the NVMe enpoint driver of 512 KB.
> 
> This driver is not intended for production use but rather to be a
> playground for learning NVMe and exploring/testing new NVMe features
> while providing reasonably good performance.
> 

Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

-- 
மணிவண்ணன் சதாசிவம்

