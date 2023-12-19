Return-Path: <linux-pci+bounces-1193-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A5E2819363
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 23:16:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 489AB289930
	for <lists+linux-pci@lfdr.de>; Tue, 19 Dec 2023 22:16:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8228E3A1BC;
	Tue, 19 Dec 2023 22:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBJeW5la"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21FE13D0A2;
	Tue, 19 Dec 2023 22:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f174.google.com with SMTP id e9e14a558f8ab-35fc1a1b52bso3770315ab.2;
        Tue, 19 Dec 2023 14:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703024161; x=1703628961; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Vgoe1gicvQXkumx2xRFNpc454t5RYUbjInmiKr3m74=;
        b=SBJeW5labML9mKsX9jiwlxMe7P0yt7VSoM++mFdVzG+F+zR+iy9dojvg16lme8gCw+
         9zJXtbaHxFX+IbvMDyA6guMNuYWTv2FoR1lzVsiPJBWotbl/fFSDqHp53ye0uwb4CQrZ
         fYHeMhQs5naT7uVfl6B6mv+cA9wmN2jhhaf70XAofuFtc0w5b8HXmRmYOY6JGl0DUjR+
         foqVNT0Dq/AKBI+rYukbrtzxdW8fLye5Ce4bNKLqVC+BgHqWhPgw17MhZTHLCVPAOs7m
         g2Zm5Cf2NKIDgzpZ9hJ3/YylmmpScUcOudFh+fCeSb0j94Ep3gJ/Hj9U05UbmcfY+iS6
         7Ugw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703024161; x=1703628961;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Vgoe1gicvQXkumx2xRFNpc454t5RYUbjInmiKr3m74=;
        b=h4r00eTZNXVOdUql68y8IWixwYZQfN2OT9jWKjb9nQlpYoUzaNQ/68K3cnkdzwAYkz
         yiyDUEaD6F2JO1GKEmrwhiFtd5cNbxseKf3CbZyjpsRPtIgBZjZznUo0X3a6OX7EkIbZ
         K0g4cPQ0gpgNlCKLVagdcFqGh498eFa6BZDuIDX66rJLNxhXM48Cv2nPhMBHUH0ez1r3
         oaHSLrbeTjUJnGpS/vYP60W77dAoc0uINTi1lBbjEbFxS+9zWHUZpqtaHdIZSpOj3Yow
         FqIYtwHUsCWovOwE9o6qe7AtgswgreJI79lhj7cUojFODyUzIHq3WpJqeTMTOFnlYCFZ
         zSOQ==
X-Gm-Message-State: AOJu0YyLymLkThlxqnCjTXOol05neuKm8boI/TtfvbkXvjgsQzKTUZPB
	qhY7xKJLYnhzoiyEy3roluE=
X-Google-Smtp-Source: AGHT+IGGFaZwZ0GjyruU9UyGwmiyEWPcwF5NEIwYH2yPBu7dUz1Y9EOk+odB6M33wQ391057ElvelQ==
X-Received: by 2002:a05:6e02:b2a:b0:35d:7bc0:ee95 with SMTP id e10-20020a056e020b2a00b0035d7bc0ee95mr22241074ilu.10.1703024161004;
        Tue, 19 Dec 2023 14:16:01 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:b2ca:95aa:9761:8149])
        by smtp.gmail.com with ESMTPSA id b125-20020a636783000000b005cd7c0b4eb0sm6226575pgc.77.2023.12.19.14.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 14:16:00 -0800 (PST)
Date: Tue, 19 Dec 2023 14:15:58 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Esther Shimanovich <eshimanovich@chromium.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, Rajat Jain <rajatja@google.com>
Subject: Re: [PATCH v2] PCI: Relabel JHL6540 on Lenovo X1 Carbon 7,8
Message-ID: <ZYIWHjr0U08tIHOk@google.com>
References: <20231219-thunderbolt-pci-patch-4-v2-1-ec2d7af45a9b@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231219-thunderbolt-pci-patch-4-v2-1-ec2d7af45a9b@chromium.org>

Hi Esther,

On Tue, Dec 19, 2023 at 04:34:33PM -0500, Esther Shimanovich wrote:
> +static void carbon_X1_fixup_relabel_alpine_ridge(struct pci_dev *dev)
> +{
> +	if (!dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X1 Carbon 7th") &&
> +	    !dmi_match(DMI_PRODUCT_FAMILY, "ThinkPad X1 Carbon Gen 8"))
> +		return;
> +
> +	/* Is this JHL6540 PCI component embedded in a Lenovo device? */
> +	if (dev->subsystem_vendor != 0x17aa)
> +		return;

Maybe use PCI_VENDOR_ID_LENOVO and move the check first - it is cheaper
than string comparison. In general, symbolic constants are preferred to
magic numbers.

Actually, do we really need to check DMI given the checks below?

> +
> +	/* Is this JHL6540 PCI component embedded in an X1 Carbon Gen 7/8? */
> +	if (dev->subsystem_device != 0x22be && // Gen 8
> +	    dev->subsystem_device != 0x2292) { // Gen 7
> +		return;
> +	}
> +
> +	dev_set_removable(&dev->dev, DEVICE_FIXED);
> +
> +	/* Not all 0x15d3 components are external facing */
> +	if (dev->device == 0x15d3 &&

Again, maybe PCI_DEVICE_ID_INTEL_ALPINE_RIDGE_C_4C_BRIDGE?

Thanks.

-- 
Dmitry

