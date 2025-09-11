Return-Path: <linux-pci+bounces-35955-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F1FB53E1C
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 23:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8376F567FFF
	for <lists+linux-pci@lfdr.de>; Thu, 11 Sep 2025 21:52:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51271258EC9;
	Thu, 11 Sep 2025 21:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lwFQjeHP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E20221FC7
	for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 21:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757627531; cv=none; b=UZQOysgpUtJVKuQooVqS2gI8tXDgKSzcq5HMYkR0MSZNMV4syFxXymYs7lU8CgkJvfFT/u+TUT3YknI32LRWN/FjNJqF4/xGlEiox7t/lDI1EKYVKpDZCFtk1xhu9w9whTjq1ndFBL+g1tLx6h2Xb/9LZ7MASZsQBV9JJm2icG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757627531; c=relaxed/simple;
	bh=11jfNs7XD9+70o8E2n4SbCGdw78596CKJwoetTJ9SVA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aS8hA3TmlYaNcdr8nqRqng5m+rY6OThS4lLEdgVGfbNF/aH8CFZow/5cQV67RaBjZi2WpAQ0kQtq/ajrMFWc6XCYi/Wukn7Lz3UmYZAWwppZ8T4G/qy/ObvdNc91UHbLZ4Zs/Qgf3TV90AdhpKJEUpXOUPEnPdekBCfVx7xwrqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lwFQjeHP; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-77269d19280so1215605b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 11 Sep 2025 14:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1757627529; x=1758232329; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HCC2l5e6FSf+CmwH+t7zaiFzHJluzLyI3JzzK5xSQZI=;
        b=lwFQjeHPpdlq0JSJLj9WNR9HDWjn0Uyb7dfJvcDlhrm8NjuTyn1QzfnH5F+tKvcQm8
         a7O7ZnhVq7vb8Q4I8WBbm8tMfc9f+EmchgO1yf+FhVDd+M4wbiXI5FqRNbl+DZYXVufS
         52MZ09ooL1cevhObSf5GSSh2mbSgAmZB3G6Xw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757627529; x=1758232329;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HCC2l5e6FSf+CmwH+t7zaiFzHJluzLyI3JzzK5xSQZI=;
        b=ld9Tf4zAE+Y93GTCHC5F+vM0wcFdbizp7tPePBg0cByIUNW5De6jNJ/KfPKLcubwgp
         BkYYYBPMADI917+AXw+xwDLnGIWT6tRPbnWAnhWUVC6F8dWDYfb3/U/PvGRVM+zBW+jz
         jdBlFiLA6IAdPeJhoV5q4X8KAhpnNY77ABDIIgjtHxPi+YNNHsx5Y2zJ5qNB0aou4DLF
         uYjMkIZU1umzZUv/qMSzIc7xtyrg5vnPMV1yl9If7Y9KS4gpuGTyT3STbvtkHttDmQ5H
         z8+NqBr72xxeJ0dKpyncDJTorrhUR7lUuHxh0bPu9gwgBpqxqskhTnVteaRw/3Nn/E42
         EPoA==
X-Forwarded-Encrypted: i=1; AJvYcCWHWL9CwHUWvfSW2BJF2JAUw2IGtHZewLjmeNN0CS6kvCQxxMe6DxLa2koo+mWfJNxTeBe6pm04de4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOYlZANE9a9WWdcR16+yeV5+9KV8KbsMdFGQOOUgbt2LqKXJyC
	I9wSqSceccWKbwTXxC7ZonuBG8m8BPZwZyQRiGcSFXIPQtnigdy7PwXrKEA3QsenDA==
X-Gm-Gg: ASbGncsawFDqiQvqdNqVFasXDjMynBDM+NAlcknHMh3GtvY/y6pd9UNausZO62/hpvV
	g17TWi5KbmB3vRyhQyRPfJtG1nSwfnf3Mp/eKvkrnAMYWy9bmLKkzXAjttogOZMbCqESi1/ZPam
	qMmxeXSXSuH0ye6Topio4MvQiwmSDgJMLooesBncpIP/qi/qC0Z+g06vy3Hy4sS6P7vmag5LknE
	DPhngm77Gi3mSjjBTCIU7RqKSejMG8tAGzP7m3BtyV3dsDfBUx4eAQH+qoIcxP6pZNfiWq00xAc
	ryZEgs3nqdRi56Ta8C7z2UAHFgUx3Pu3E4xh2zcm5ynUGz3rYfOt41KzDjEo1NWCIO65VtzUnPj
	kgycYU23zoDTGR5cN6eXY9jfXWzYvv2uxWLSvTtV2rDC0ysApL6xfzdj+PVo=
X-Google-Smtp-Source: AGHT+IHb7w+bL2sibzRwFec3AsLqESlpAB7GfKe+XRbiM8MpDO4ZOEXOkV+dkAH3wE9LCWOv78D60g==
X-Received: by 2002:a05:6a00:2345:b0:772:63ba:127 with SMTP id d2e1a72fcca58-776121884a1mr929198b3a.24.1757627529148;
        Thu, 11 Sep 2025 14:52:09 -0700 (PDT)
Received: from localhost ([2a00:79e0:2e14:7:6690:568:13de:b368])
        by smtp.gmail.com with UTF8SMTPSA id d2e1a72fcca58-77607b18400sm3138359b3a.59.2025.09.11.14.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Sep 2025 14:52:08 -0700 (PDT)
Date: Thu, 11 Sep 2025 14:52:06 -0700
From: Brian Norris <briannorris@chromium.org>
To: Lukas Wunner <lukas@wunner.de>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Terry Bowman <terry.bowman@amd.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Linas Vepstas <linasvepstas@gmail.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 0/4] PCI: Update error recovery documentation
Message-ID: <aMNEhqiJKK9NOreA@google.com>
References: <cover.1756451884.git.lukas@wunner.de>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1756451884.git.lukas@wunner.de>

On Fri, Aug 29, 2025 at 09:25:00AM +0200, Lukas Wunner wrote:
> The documentation on PCIe Advanced Error Reporting hasn't kept up with
> code changes over the years.  This series seeks to remedy as many issues
> as I could find.
> 
> Previous commits touching the documentation either prefixed the subject
> with "Documentation: PCI:" or (when combined with code changes) "PCI/AER:"
> or "PCI/ERR:".  I chose the latter for brevity and to avoid mentioning
> "documentation" or "PCI" twice in the subject.  If anyone objects or
> finds other mistakes in these patches, please let me know.  Thanks!

Series looks good to my limited knowledge:

Reviewed-by: Brian Norris <briannorris@chromium.org>

