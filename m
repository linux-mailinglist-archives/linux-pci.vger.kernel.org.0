Return-Path: <linux-pci+bounces-33808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECA0B21914
	for <lists+linux-pci@lfdr.de>; Tue, 12 Aug 2025 01:16:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D91C16596D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 23:16:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97E61AA7BF;
	Mon, 11 Aug 2025 23:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUZPBtEV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428B313AC1;
	Mon, 11 Aug 2025 23:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954161; cv=none; b=CnxGXUtiR6BwXW2DRC4NPA4Eux4MNJT1nA7BZH1hNfICTGJS5OZftnCTb4Pw+eqZZ6v0cqDOPsjMQLZM+DN1+szOxdpsur22kbgAKXY/iD9kzgsZ0Pu6TmX+NcoeeSgqguKC0ayVYm18KJQOK+2dqz+0yJloCq3vXRUO/4fXk/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954161; c=relaxed/simple;
	bh=h90aWAdN6kmjnGhh/YsBA0AsA2ycY3NyAX0WocPdISE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pXaQsSHv2wDQQxUzeQPYvozqfLrAX78uLkm7JTxZSIqeZ2Y3rHapaHu8bY822zgVhMfUKq/XSOlUZ+PdwnSHx3rqjbNcL88BFtSHhulv+XN0rDf0n679W1lT5lP16B25wnY2LWfAGvWXxBg0md7ib2RhChA6rDvVoNN+Z8Ax5zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fUZPBtEV; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2407235722bso48786245ad.1;
        Mon, 11 Aug 2025 16:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754954159; x=1755558959; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GlitkVcXNHjzG7603fa784xq4aGVvZndeBw1vHOtobs=;
        b=fUZPBtEVzjzMqN8sINGCXqC9oGWJOQ8yxI44i8SNPAATwM8ASv1JsZWnSuiPgN7sJD
         jwGCUXJ0kuxWW/juzpFkZ2GJpQ656+fzmj+wdDCJx+5Xqt/qzQaLXiWh6E0/U6bPZSpz
         5tjNxiZuO83ArzRkCvDEuPjPXEsK4p4YGmo9fpOvJ39t49XEngHGTDADwyql485mSXzy
         7wRDsGcG/mW+nMddv4biiAvlxcVYp3/nkpH8unLlJyLsG5MjIqxpZze8YncBKWYz1/HA
         qzFVx+ctnwQOMJGFMfunnE+EtYlJ9A1gHmu8C/SK62YEnWCFlCyCGEdWuwAtS2xGpsfN
         morQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754954159; x=1755558959;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GlitkVcXNHjzG7603fa784xq4aGVvZndeBw1vHOtobs=;
        b=e/I7Zu8RB3sDRhH5PxdTOmMzS92PRUjYBSvuDLY2qwrVIH1SbQHY3xLhDmvvKf8JKk
         INUY9q3rGnEfgtewc/1QXDuQN11ijJN3zLUb0R/oiKGfdLiZJ/gvPTIkhobE41ViyoW6
         I6P34t//Ui/Vid5oBWZ0KjLPnzNNH0JfGPifJVSf8vuSTD7yzOx4YHb/N33IsTG2EkYo
         TEM/vkArhrSwOL9i7suifv4mqqC8qBehR+wLIgcgvNhsMefpcMdfXI94SXP+dRZhNyK4
         DMTxe3fhHT8Gy6L2sGZXrCmbYvoPSgQJ1cAZDpRB+mz9mAmbHP79WDk45JEAQpcmN92L
         HQ9g==
X-Forwarded-Encrypted: i=1; AJvYcCXny4nQVOoOHU3UFPZWl/sbY0uonzkj+M8SKXxfP4rSV1pyjJQbFd4M7s51PbBcNfN7ljeFrAJq2WM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyhyzp6cxWrbh3+dl9328Wq+XFOD2RyPNIuFCvt2nslA8IvjLSY
	My3WElUEIjpvIv7LXoTdT93Sry3VqFqFlb5p8DBpTqlCi4hWV33pDsF/ALmWvMEzWFs=
X-Gm-Gg: ASbGncvcCLZkKz6qebN5Pyoa4knM23AHNDeV93IqRJ0qdnrvqsVTA1nZ4FO0x5lKZ5l
	4zXKA7ZW8/tAYbL9NyIDmRaINPEwbf03FJL9B1hpPm1mZhT0ksdn9CVkld/Tt3dLWWOLbBvJicR
	4Oy35Hpu9eLzGYL34BokO/O8ym+hJc8cUg3tGtubodKpgt4oXuq1QMxA/i/6D28jmUnlyT0NRuv
	zvCiLQ+PmFYgrWZjLBs2EixJ10TpF56rLqvRkfQduNnKaa5Ngobh/daxBUUDv7dvNOGRQrgh3aC
	4OlfgJvtusf5YdS7C0b6TzOlzlKNWyY2JhTq+XnLhXXAfXnx7jfQgsqXK8kNW+ojr+sZvxET98x
	nZud2sauN0w44ypewNqkiKw==
X-Google-Smtp-Source: AGHT+IGUqazPIKjPwjnFPJ6FlGGUuqv9MKNPOxv010O/xVi21OdnHwb5rqneZD1omgJ2A8dQEuUPBg==
X-Received: by 2002:a17:903:2447:b0:242:a0b0:3c39 with SMTP id d9443c01a7336-242fc372b29mr18282745ad.54.1754954159413;
        Mon, 11 Aug 2025 16:15:59 -0700 (PDT)
Received: from localhost ([2001:19f0:ac00:4eb8:5400:5ff:fe30:7df3])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-241e8aa8e0esm285891505ad.151.2025.08.11.16.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 16:15:59 -0700 (PDT)
Date: Tue, 12 Aug 2025 07:15:10 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Thomas Gleixner <tglx@linutronix.de>, 
	Inochi Amaoto <inochiama@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>, 
	Marc Zyngier <maz@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	Saurabh Sengar <ssengar@linux.microsoft.com>, Shradha Gupta <shradhagupta@linux.microsoft.com>, 
	Jonathan Cameron <Jonathan.Cameron@huwei.com>, Nicolin Chen <nicolinc@nvidia.com>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Chen Wang <unicorn_wang@outlook.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>
Subject: Re: [PATCH 4/4] irqchip/sg2042-msi: Set MSI_FLAG_MULTI_PCI_MSI flags
 for SG2044
Message-ID: <fxwrkdaipw7sgr34wtgrh2m757xiras6bfaaugcgopuaxe2e5n@3ipw3t5hg5i7>
References: <20250807112326.748740-1-inochiama@gmail.com>
 <20250807112326.748740-5-inochiama@gmail.com>
 <87349y7wt9.ffs@tglx>
 <h6sz4hsvajq5pbcd6m2byctdpg6yhjhwbecsqc4o3npieswxov@u3myntmq2xwa>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <h6sz4hsvajq5pbcd6m2byctdpg6yhjhwbecsqc4o3npieswxov@u3myntmq2xwa>

On Tue, Aug 12, 2025 at 06:36:20AM +0800, Inochi Amaoto wrote:
> On Mon, Aug 11, 2025 at 04:33:06PM +0200, Thomas Gleixner wrote:
> > On Thu, Aug 07 2025 at 19:23, Inochi Amaoto wrote:
> > 
> > > The MSI controller on SG2044 has the ability to allocate
> > > multiple PCI MSI interrupt if the controller supports it.
> > 
> > interrupts ...
> > 
> > Which controller?
> > 
> > if the PCI device supports multi MSI.
> > 
> 
> The PCIe controller, in detail, the Synopsys DesignWare PCIe controller.
> I will update the comment.

This is still too short, I mean if the PCIe controller also supports 
this feature, so the MSI controller and the PCIe device driver can
negotiate and then use this feature.

> 
> > > Add the missing flag so the controller can make full use
> > > of it.
> > 
> > Again, the controller does not make use of it. The controller supports
> > it and the device driver can use it if both the PCI device and the
> > underlying MSI controller support it.
> > 

Yeah, this does thing I want to describe.

Regards,
Inochi

