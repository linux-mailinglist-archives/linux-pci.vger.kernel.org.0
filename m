Return-Path: <linux-pci+bounces-9452-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B7091CEE7
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 21:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0DCF8282594
	for <lists+linux-pci@lfdr.de>; Sat, 29 Jun 2024 19:56:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E30D132118;
	Sat, 29 Jun 2024 19:56:19 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE1680046;
	Sat, 29 Jun 2024 19:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719690979; cv=none; b=iuEYPnzShUagG4vckIU2qgus0QnD+RvDBNdWbGdncRM2rScz5NiwLZ2kjsFzCUlwSOCX5Sfdn80DvDR63diV+0pjUk/iv6aj8UhiN6VfFNZpUOjdpk9o0cfRfyi6Ga5PjlNiccD9k/YRLYUuUWgnHdLwoPk3PlGMZQcUrFRkWNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719690979; c=relaxed/simple;
	bh=1zyFjmfrnIpVtD5pfXtivITCYlSVJt8VcSyFAiMzARw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTnTc5KfBRn38v6ns8JjeGCyCNtDb5x7rx4lMHXEYsXI0wH5YwLPyyy1Xdv+PY+XMlULmCht2Ti4amLmFVMzaZVM1RwF5xQhbfWolQBsHUq/RDK8+gcOfKt6FNW/SlV4SqCI072osjhmuOr3Fvx6UkNZMPuXMAbcmOs1Cx9GPZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70a078edb8aso667385b3a.1;
        Sat, 29 Jun 2024 12:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719690977; x=1720295777;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aspJJ3em1+CxpJdRNN6zcOGLZ0iaCLvtwvBApCjFbzg=;
        b=bp26YanJ5pkSBHL1wXfI2nvGTQFABcVSutstRWrajrSjNEhCYv7ebvO0zX+DrfnFm/
         jogxfqizkmAlOZRq6mk9OXPza5f4i10JTS6QAJNMae2/yNUtdo02KicEG0DHKtHc/9p8
         qsMWGCgdLdXYsjzx1fj/x2e+bbaSpUfL/9ioQ7hoObltoh+kRA1W6/NJTRyoIF3BBrZG
         u9etNRZdgukF5Zep3/Vo7tmUs1erIqtVoW/CLnu7WWv4Jvvs/8mc7zciNE1EGlWbI30D
         9C+YLND/H4svk7t+SjRtIMrpv6XanedyTbRa5foqfo8uu8BRjAKjedTiTEIYuMPseWM6
         E/+g==
X-Forwarded-Encrypted: i=1; AJvYcCWd7I9sEGknpLV+U65tuhLP7djfUAaT6lqnjB6daFHhstgsP4jmFpnm9RG8yg+ZqddXrv/n5uTa6gJyeejnNQHBsLFQZ8I9MQdQWoAkrbeGkR+bIqD/bTakaxomYR2whrFljgQvdcObsp1s6fI=
X-Gm-Message-State: AOJu0YwQUD1IyTxfHWrucpmwsMEdVrK72kN4YWcm5kh8V1GuLj/sqfRC
	dQPci9vMdXsU01EsNFO6BM9H1YuCN0CFGV/jFHOaRUdWri/FHymg
X-Google-Smtp-Source: AGHT+IERcDSCR4toeoJWgnIplqAZZS/9A6vIMCPfeYbEeqAgC/q/zNfEH4MD0+DM+B+i/XYUzWoKZA==
X-Received: by 2002:a05:6a00:1397:b0:706:2a38:94e2 with SMTP id d2e1a72fcca58-70aaaba9028mr3015397b3a.12.1719690977026;
        Sat, 29 Jun 2024 12:56:17 -0700 (PDT)
Received: from localhost (fpd11144dd.ap.nuro.jp. [209.17.68.221])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7086207ed02sm3407384b3a.95.2024.06.29.12.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jun 2024 12:56:16 -0700 (PDT)
Date: Sun, 30 Jun 2024 04:56:15 +0900
From: Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: lpieralisi@kernel.org, robh@kernel.org, bhelgaas@google.com,
	jingoohan1@gmail.com, mani@kernel.org,
	marek.vasut+renesas@gmail.com, linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v9 4/5] PCI: rcar-gen4: Add support for r8a779g0
Message-ID: <20240629195615.GC2249818@rocinante>
References: <20240611125057.1232873-1-yoshihiro.shimoda.uh@renesas.com>
 <20240611125057.1232873-5-yoshihiro.shimoda.uh@renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611125057.1232873-5-yoshihiro.shimoda.uh@renesas.com>

Hello,

[...]
> +/*
> + * The attached firmware file "104_PCIe_fw_addr_data_ver1.05.txt" in
> + * the datasheet is a text file. But, Renesas is not able to distribute
> + * the firmware freely. So, we require converting the text file
> + * to a binary before the driver runs by using the following script:
> + *
> + * $ awk '/^\s*0x[0-9A-Fa-f]{4}\s+0x[0-9A-Fa-f]{4}/ \
> + *      { print substr($2,5,2) substr($2,3,2) }' \
> + *      104_PCIe_fw_addr_data_ver1.05.txt | xxd -p -r > \
> + *      rcar_gen4_pcie.bin
> + *    $ sha1sum rcar_gen4_pcie.bin
> + *      1d0bd4b189b4eb009f5d564b1f93a79112994945  rcar_gen4_pcie.bin
> + */

I moved this comment to the top of the file, since it serves as more of
a documentation bit for the controller itself, and is not specific to the
function it was attached to, strictly speaking.

That said, I wonder if we should include this at all?  The file name might
and most likely will eventually change, as the datasheet gets updated to
include new revisions and erratas, etc.

So, I wonder if this is simply better to be included in the datasheet
itself, or some product guide and such, where Renesas can keep this up to
date and the users appraised of what they need to do to convert the
firmware correctly.

Users who do not have the datasheet and are not licensed wouldn't care.

	Krzysztof

