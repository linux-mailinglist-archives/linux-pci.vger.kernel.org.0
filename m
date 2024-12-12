Return-Path: <linux-pci+bounces-18296-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DAB9EE974
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 15:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A299280ABC
	for <lists+linux-pci@lfdr.de>; Thu, 12 Dec 2024 14:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF2EA215793;
	Thu, 12 Dec 2024 14:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ieWMtjHx"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF15D21576F
	for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 14:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734015519; cv=none; b=nl80lZUOKiw9P02zHlMpEuyaX4WQygk8SBKVLcC888+PQ/mfVvkLoTBldLY42LnepWR8zuFFO3uhQF19YampVaTDjRebyBve5WeyiCHZppg8IPWH9tGnQUi8TfBptQ72TWxX64E6b6txm8R3IH4J/HnnpsnOxFYTs5pd8UVgnIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734015519; c=relaxed/simple;
	bh=G6Z2o7H+YRsuJn5EHuxMgQuZNMoz/Zu4aqlYRNiWXyI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p2gQeSo2zdgkDma49GCuCoqaPlDN7C5sLeFb6OaBvecrq4stPSJ4qIsTYHmUtaEoncbs0cZ7pnyn1F20FoDVQdyEH76FC2rMXBmXc36ltCy6gdtSOohyHrvlH+oelThi0ITJcqm4XkYtkkdiLDm1Fs3wNENzgw7jgQ2ORuBHXs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ieWMtjHx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734015517;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mp7PByfrT26c6XlUU6lXZIxvrN1DU5qMvcLQpbxnk5A=;
	b=ieWMtjHx/VA8JrMSRqY63odCgsUs32B8CbSf0fmzSTCiV7aAXJ3Uxxmmio9VfBnYnzw4Db
	5n/VHlD1v+BrNfgsJRb5dF5JoUy/vATckEKVm1XrLdTjwgrc0appiED284JnH/YTXkYbHp
	xugjBJDACvd8J4C0Z9aE59oVsIjH73c=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-Seke3iKQM6677XCGVC1C8w-1; Thu, 12 Dec 2024 09:58:35 -0500
X-MC-Unique: Seke3iKQM6677XCGVC1C8w-1
X-Mimecast-MFC-AGG-ID: Seke3iKQM6677XCGVC1C8w
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4361ac607b6so5773305e9.0
        for <linux-pci@vger.kernel.org>; Thu, 12 Dec 2024 06:58:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734015514; x=1734620314;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mp7PByfrT26c6XlUU6lXZIxvrN1DU5qMvcLQpbxnk5A=;
        b=kDxydR2A1byNQ2uwt+jbQCp3v/F/hGWApv4DdAn+BvnhBrG4kOZ4SVo8qJSkm4ViVC
         qnN/9yTaJZqGbQAQVnJsfTpOP0Nf3XB2uT+E7utUugIjjUu9ZiNMjWrFnaUaosdmPAIy
         yRt4b2fV0IYt1MfSJMecsM71nYMCcWLyL5CQvF78AspQptBIan2rwadgi0qbSWL3DvRN
         2WtKFjVeXAYIdIDXRhI/9fy3HcrmNhB8qyDZjIQIwyH3Ktx+LOQcPSgJLA9nACI/gTIU
         oJWXQ+tebqFvMXpmoosFjxrb2NZA6PY3fMcK/Cf3fjGl7d2duea/ktEiBY0Stfi4xPhH
         5Usg==
X-Forwarded-Encrypted: i=1; AJvYcCVHq9W7I1UJjGxffQ064D0ilxvw8DdGwObOFLbFk3myo7n4Oe3d2LrdkUCu7Su83ERr38Cka1+NRdc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8MVaIH8sP49BpnFQIfbQ03vxnjLUWgOblNW3P2I1GVsltfY/K
	D2r1QRnRgnfg8NE/6gAWdQZDVKW14OvwL7eiLgcyBAuIu7kSHEZlhABX58Ujdyp0VDo6mMTGChi
	AaC3cMAKvY+xQUWscHDat78a/ws5RHs7IsZ+rY4qfXpvzceFj5/YUFB2KfA==
X-Gm-Gg: ASbGncuIqEmdLeA0kBBBMZ7MgSd6SrM2Ox2wsM0iXAZFpZYx6QHoeXkyvxOR41cmhsK
	vo6BPJY2F+/C0gfMezjosEyLvxb6KU2XXNyvcfUMIUB6GvaJJd8J29U2dX1SML3JuUHRK14CzKA
	y02c/Ny0I+vOqB6rPpePWlF+AYk0GYlja8g9287+iixdM7j8gccveM2eSBeBg0UroiDLEdV1u+J
	wCpUDZkasS99cs1tdh/PAkeZ9y1rE7bkpPyHgQO2IsROaD5zjUE3gB3sL6DBytVhW4ZpIAcij0D
	zsJEkSI=
X-Received: by 2002:a05:600c:1e89:b0:435:21a1:b109 with SMTP id 5b1f17b1804b1-436228239d4mr34776275e9.2.1734015514538;
        Thu, 12 Dec 2024 06:58:34 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHoQPXURHNGvrny3f7vl2oVT9jWXY7D4FX6dkSlxmx2R9PGBk/+viTtA90lBPMFXjybTLaFQQ==
X-Received: by 2002:a05:600c:1e89:b0:435:21a1:b109 with SMTP id 5b1f17b1804b1-436228239d4mr34775655e9.2.1734015514130;
        Thu, 12 Dec 2024 06:58:34 -0800 (PST)
Received: from [192.168.88.24] (146-241-48-67.dyn.eolo.it. [146.241.48.67])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4362559edc3sm19213025e9.22.2024.12.12.06.58.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Dec 2024 06:58:33 -0800 (PST)
Message-ID: <a6d7a4ee-929e-4bee-80bf-a7b4f4f89f4a@redhat.com>
Date: Thu, 12 Dec 2024 15:58:30 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/11] Remove devres from pci_intx()
To: Philipp Stanner <pstanner@redhat.com>, amien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Basavaraj Natikar <basavaraj.natikar@amd.com>, Jiri Kosina
 <jikos@kernel.org>, Benjamin Tissoires <bentiss@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alex Dubov
 <oakad@yahoo.com>, Sudarsana Kalluru <skalluru@marvell.com>,
 Manish Chopra <manishc@marvell.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Rasesh Mody <rmody@marvell.com>,
 GR-Linux-NIC-Dev@marvell.com, Igor Mitsyanko <imitsyanko@quantenna.com>,
 Sergey Matyukevich <geomatsi@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Sanjay R Mehta <sanju.mehta@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Jon Mason <jdmason@kudzu.us>,
 Dave Jiang <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>,
 Bjorn Helgaas <bhelgaas@google.com>,
 Alex Williamson <alex.williamson@redhat.com>, Juergen Gross
 <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
 Mario Limonciello <mario.limonciello@amd.com>, Chen Ni <nichen@iscas.ac.cn>,
 Ricky Wu <ricky_wu@realtek.com>, Al Viro <viro@zeniv.linux.org.uk>,
 Breno Leitao <leitao@debian.org>, Thomas Gleixner <tglx@linutronix.de>,
 Kevin Tian <kevin.tian@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Mostafa Saleh <smostafa@google.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Yi Liu <yi.l.liu@intel.com>, Kunwu Chan <chentao@kylinos.cn>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 "Dr. David Alan Gilbert" <linux@treblig.org>,
 Ankit Agrawal <ankita@nvidia.com>,
 Reinette Chatre <reinette.chatre@intel.com>,
 Eric Auger <eric.auger@redhat.com>, Ye Bin <yebin10@huawei.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, ntb@lists.linux.dev,
 linux-pci@vger.kernel.org, kvm@vger.kernel.org,
 xen-devel@lists.xenproject.org
References: <20241209130632.132074-2-pstanner@redhat.com>
 <20241209130632.132074-13-pstanner@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20241209130632.132074-13-pstanner@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/9/24 14:06, Philipp Stanner wrote:
> pci_intx() is a hybrid function which can sometimes be managed through
> devres. This hybrid nature is undesirable.
> 
> Since all users of pci_intx() have by now been ported either to
> always-managed pcim_intx() or never-managed pci_intx_unmanaged(), the
> devres functionality can be removed from pci_intx().
> 
> Consequently, pci_intx_unmanaged() is now redundant, because pci_intx()
> itself is now unmanaged.
> 
> Remove the devres functionality from pci_intx(). Have all users of
> pci_intx_unmanaged() call pci_intx(). Remove pci_intx_unmanaged().
> 
> Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> ---
>  drivers/misc/cardreader/rtsx_pcr.c            |  2 +-
>  drivers/misc/tifm_7xx1.c                      |  6 +--
>  .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  |  2 +-
>  drivers/net/ethernet/brocade/bna/bnad.c       |  2 +-
>  drivers/ntb/hw/amd/ntb_hw_amd.c               |  4 +-
>  drivers/ntb/hw/intel/ntb_hw_gen1.c            |  2 +-
>  drivers/pci/devres.c                          |  4 +-
>  drivers/pci/msi/api.c                         |  2 +-
>  drivers/pci/msi/msi.c                         |  2 +-
>  drivers/pci/pci.c                             | 43 +------------------
>  drivers/vfio/pci/vfio_pci_core.c              |  2 +-
>  drivers/vfio/pci/vfio_pci_intrs.c             | 10 ++---
>  drivers/xen/xen-pciback/conf_space_header.c   |  2 +-
>  include/linux/pci.h                           |  1 -
>  14 files changed, 22 insertions(+), 62 deletions(-)

For the net bits:

Acked-by: Paolo Abeni <pabeni@redhat.com>


