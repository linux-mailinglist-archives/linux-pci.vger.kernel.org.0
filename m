Return-Path: <linux-pci+bounces-10814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D11793CACF
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jul 2024 00:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2665E1F22998
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jul 2024 22:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E815517E9;
	Thu, 25 Jul 2024 22:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H3uJtd5x"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA42013E8A5
	for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 22:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721946120; cv=none; b=Pvfz+lb84wiF5wKGNQqTj74fMkIQTakXJzywWvVu1q//hrvwNxUZ7Dq2H+w6Rk5jV5lj8KZBiOYCrp5U3ZGN/HnJLP7NAhebWgK9O9Fwmuy7PsApZbl82BoMr1GNqjNGI/RlfqikCMf3I5+3IRDxqStRoPtwqb3wEAyln1YHDiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721946120; c=relaxed/simple;
	bh=e3QtoGAhKBBmMhj47JDionvHjW/apkWJ7Za+hWvi5KI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ROKPwpU0Nc9FqGlK8GpEpWKJK9Ni4Yi16s+F5jFjtJ7LbcPY9+M3KyxhU3kBU1NX6+IGMG9bCn6mLf5sAB6IR/rSuwRV9e4pPq8GVl4ZkBwtgTm3iPKWxmWrkMcyUHl3Egjt4SJTEyRiJFS6qJBYEFwItSYhaNuT8J1F0uBg9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H3uJtd5x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721946117;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c/KmYr3jbfKPlvOHElaBkUrO4ia1UgbTouR26iyDyNM=;
	b=H3uJtd5xw/SvSf40wQdsRztGu16REUxpH+b8WoKBZQ51dg/Ym7/eOYx/oHDG3FqWB50mrk
	n1+Rkz/QChkeIXhRbQsO/UJHhdvoxRxQYJF9PPoN/IvkqaKQPa0UURGvRo8vAuD2l8vaDM
	z0saDYsH6uXCEE5qJcMKDJ6ORc3lCuc=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-696-7nHjy5QsNLKbsDyHskOAdw-1; Thu, 25 Jul 2024 18:21:56 -0400
X-MC-Unique: 7nHjy5QsNLKbsDyHskOAdw-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b79ab201faso603846d6.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Jul 2024 15:21:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721946116; x=1722550916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/KmYr3jbfKPlvOHElaBkUrO4ia1UgbTouR26iyDyNM=;
        b=VHrwPJn8yo9k29hnYBoo+J+ZSVwCc7bO9nF8YT1xCCWL2C3wyiCItqizRNNO5zMaUx
         CXmpms/Zvd1Xu+czwbrqeEO1OBvII0FrQaa8rPG2XetP1Qx85gPbnwrB+7xYOojGr/Tc
         3xN1g2hkFAQ8IcVRn4QC2WRdnkonEBNrW6gJp/ZOoPx4H5jlnYvJRlv2LUNqgpj5aFaE
         M/s5e1ImAV/SQaGSKpJbjYReUoMcus2T65XpEeqrdoLMJsG1KaDuf6lZVklimFncQNsP
         Qedqb5SoKS9fG65VccAj+p1diCt2nBudJ+NasDb2xs09sQIJsT9Isf85jea4j7wtQziI
         3IeQ==
X-Forwarded-Encrypted: i=1; AJvYcCX28Mm2iN06nvuRHvqVjlvv1YsqtcHfSjMkSScvvC4zwZqr+aqyOTtyis6SXxByylB2i34k7cxSDzgEPUzeEfw0QesA+kB4vEOb
X-Gm-Message-State: AOJu0Yz2aaXI15cY2mq6Bt1sg8/b8wPw3K2fEu5hAMY5z9+U5LGn90uH
	GR6IKAn7ACjsIEcfKwpIon9MkJmWLHHzEssXQkaAS2R1ZzD/rCH6txnQRWSVmyAdA05TrJmWgjA
	e9TtEHh70GQibh7evbEim6SuMcVXDVKp+76IhCls4x9RpfSJD+oAf9hkabg==
X-Received: by 2002:a05:6214:cc6:b0:6b7:a4dc:e24a with SMTP id 6a1803df08f44-6bb4088c657mr43849366d6.54.1721946115686;
        Thu, 25 Jul 2024 15:21:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF07I6M5sZysuSbSiY1fNxwueDCqDxgZ2yyxKjAhplt3Bd7CWYx3uTZ4M/qfs37U5MR3g6jXg==
X-Received: by 2002:a05:6214:cc6:b0:6b7:a4dc:e24a with SMTP id 6a1803df08f44-6bb4088c657mr43849116d6.54.1721946115407;
        Thu, 25 Jul 2024 15:21:55 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::d])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f925dc1sm10943676d6.65.2024.07.25.15.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 15:21:55 -0700 (PDT)
Date: Thu, 25 Jul 2024 17:21:52 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com, 
	robh@kernel.org, vigneshr@ti.com, kishon@kernel.org, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org, 
	srk@ti.com
Subject: Re: [PATCH] PCI: j721e: Set .map_irq and .swizzle_irq to NULL
Message-ID: <vj6vtjphpmqv6hcblaalr2m4bwjujjwvom6ca4bjdzcmgazyaa@436unrb2lav7>
References: <20240724065048.285838-1-s-vadapalli@ti.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240724065048.285838-1-s-vadapalli@ti.com>

On Wed, Jul 24, 2024 at 12:20:48PM GMT, Siddharth Vadapalli wrote:
> Since the configuration of Legacy Interrupts (INTx) is not supported, set
> the .map_irq and .swizzle_irq callbacks to NULL. This fixes the error:
>   of_irq_parse_pci: failed with rc=-22
> due to the absence of Legacy Interrupts in the device-tree.
> 
> Fixes: f3e25911a430 ("PCI: j721e: Add TI J721E PCIe driver")
> Reported-by: Andrew Halaney <ahalaney@redhat.com>
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Tested-by: Andrew Halaney <ahalaney@redhat.com>

Thanks for the quick work and follow through on the patch, I appreciate
it! I would not have come to this solution myself, I was definitely off
in the weeds when debugging :P


