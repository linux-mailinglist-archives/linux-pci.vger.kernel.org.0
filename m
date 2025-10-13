Return-Path: <linux-pci+bounces-37941-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E120BD6035
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 21:54:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A9554075C3
	for <lists+linux-pci@lfdr.de>; Mon, 13 Oct 2025 19:54:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F13125C80E;
	Mon, 13 Oct 2025 19:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YygP3bz8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0439F2DC348
	for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 19:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760385270; cv=none; b=L16u/U33bCazZAD40shqapW1IJxIwD4DUAemF2nEzfVTngQuCscayVlFEc20l7OXtNnaUQsRD9+FpdLdVkD02z+sAyY1+XpfdCroRztO4RJRem+cfkaMto5/h2yRUW05OIXihnXLBCS1ijojQiSUAJgLI+rbswYJIVSHQCJhuyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760385270; c=relaxed/simple;
	bh=702xTHcKSBnArYRUXhSl43M+M8Li1OOWTnkHKboTLp4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hIuq3i6BubHkJttzLsJi+GHB7jreopH5E9jLjTv5H063mbJLSgHpVo4LZmc1QWPKCbYKd5OmRdvOhdRNf8SaWoy4BniumFOvre7mOlwD8vOXjfe3jKA9xbWIMCnOPX6/FUts/LRcEuqU3a+rml4rZiXAEm9nbaG0WSSC6X5yJTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YygP3bz8; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78af743c232so4120848b3a.1
        for <linux-pci@vger.kernel.org>; Mon, 13 Oct 2025 12:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760385267; x=1760990067; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hAv6GwqJAzZpN6xxdtpR+366Re0k3BBFU9P4xZ+xJFs=;
        b=YygP3bz8h6VmJK6M/fE16uLYn3bck8janxD20Tqp/axqnAcAyOr2kOrW/PUKefdiQq
         gIK1OD18Wv5xphOQjLzD81NNQlXSozaDqQOM0oKH0pUYKZ/wqPOI7Z01wDstJ4KpEQFf
         nrIUyxPbk3wOhVJTsi/w1pbUC0+KZ/X5zvIj0YnhIpXIGsj0u4D0wWC/n5c1m2VRISWN
         sHLdTFdBZ0K6m3hgjykYFpRT1VN3OGXIb1tSPCeRcDAjrCHGqJfnqrB/bAY/hiJyC/7/
         I1UTNwp3RSctcWewXZ7gzQ9oBsPETP39nodCBqsesbRuWDeGHuSsNj2Mhna8bbn+MWqx
         vd4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760385267; x=1760990067;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hAv6GwqJAzZpN6xxdtpR+366Re0k3BBFU9P4xZ+xJFs=;
        b=jSjjFb+c102R5uXHsJVypoJtvlin1s3fFBBwtyT1milmIQoQ52qQp+wPuXIDnZHOVB
         Hqb12ChpdJbkcRF2A9V3mPapg50WJLbKLTlYVF3INr61DGJjslEcs5CUbOBAioO+f/Sq
         pzqJGHJQHlf0MB19MF7OPHcKbKGIRzlwCBURgwVkW76SRFd5Bzq1fm2gT/70KIA7aBcy
         xVzkhM1Tr5HYQWwgjraLoahenV2Wb+UU926UirKtnSESkaWA0ih9gnkFVC90dN60Uvn8
         +nQoW99C3NIX809Asn/L/EWxCgjPdh0NnyYzogheVVBU+Oi+Gn/0S9ZTU3xP3gPWT77w
         3P+w==
X-Forwarded-Encrypted: i=1; AJvYcCXOrjwdhvpF1n/0KDh3LquttH0XnURH0nGTNSxqWoEYIjO0yuDf5E98bY0obzNRRHaCV9lM+/fap9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzdsJsQkGj/vHyvqhEaaQJMDP6Kg6ublY9gtkd2gq0y1VvL+kQ
	lYY7/0bYN5wNVsbkFWe1aVbZ+yxcWknvtA9PImghsFzIRpnFz26UDieT
X-Gm-Gg: ASbGncvQcGAtPYTagfchX7RECKqVuSeK6XQBH851qKYxNCJVucj6Dv8dyE+Pa6w8F66
	3FXulZmY7Xf1w8SVYZhPxndv0qJjaGUHmf7xmChnrk83HLGgyxFp/XGYDQTds/DIF8ZhpXS5BnO
	m1d+SfjHUeQB+1f1IKRk7gB3zfgwB9ZRuqyy4GWXCUhtkPLiaL1vAMdxsha6S+JD00dlpgvN+Tp
	7EhPNK+EqyGIU1EiQzpZixpTV0ajpnzTI26ueTJ3PtB2qQna+Y82a7EyNx/yks9y3a7CzLWzKjU
	mqy+Wi1RQU3wziDs79xoytbLQT/zz4HOAJ8bxSI/YCJXgsQThjabLCJVwSrpWkO1Adnj98gJOJV
	dyBlhMvG4b01ecJnkOvH/rOhMBWqgJLwG3moZurtAPlBdD+EtmNocqkh+SxPxbJZW
X-Google-Smtp-Source: AGHT+IHQowLp57E0QwzAjWObp13r/o2qZgEpUfl4qciRWJZWdlUn8yKDeb4LxasXlK+bEOqryzkfUQ==
X-Received: by 2002:a05:6a20:9144:b0:27b:dcba:a8f3 with SMTP id adf61e73a8af0-32da8154217mr30340774637.15.1760385267100;
        Mon, 13 Oct 2025 12:54:27 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d096740sm12561009b3a.38.2025.10.13.12.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 12:54:26 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 13 Oct 2025 12:54:25 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH v2 03/24] MIPS: PCI: Use pci_enable_resources()
Message-ID: <9085ab12-1559-4462-9b18-f03dcb9a4088@roeck-us.net>
References: <20250829131113.36754-1-ilpo.jarvinen@linux.intel.com>
 <20250829131113.36754-4-ilpo.jarvinen@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250829131113.36754-4-ilpo.jarvinen@linux.intel.com>

Hi,

On Fri, Aug 29, 2025 at 04:10:52PM +0300, Ilpo Järvinen wrote:
> pci-legacy.c under MIPS has a copy of pci_enable_resources() named as
> pcibios_enable_resources(). Having own copy of same functionality could
> lead to inconsistencies in behavior, especially now as
> pci_enable_resources() and the bridge window resource flags behavior are
> going to be altered by upcoming changes.
> 
> The check for !r->start && r->end is already covered by the more generic
> checks done in pci_enable_resources().
> 
> Call pci_enable_resources() from MIPS's pcibios_enable_device() and remove
> pcibios_enable_resources().
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

This patch causes boot failures when trying to boot mips images from
ide drive in qemu. As far as I can see the interface no longer instantiates.

Reverting this patch fixes the problem. Bisect log attached for reference.

Guenter

---
# bad: [3a8660878839faadb4f1a6dd72c3179c1df56787] Linux 6.18-rc1
# good: [e5f0a698b34ed76002dc5cff3804a61c80233a7a] Linux 6.17
git bisect start 'HEAD' 'v6.17'
# good: [58809f614e0e3f4e12b489bddf680bfeb31c0a20] Merge tag 'drm-next-2025-10-01' of https://gitlab.freedesktop.org/drm/kernel
git bisect good 58809f614e0e3f4e12b489bddf680bfeb31c0a20
# good: [bed0653fe2aacb0ca8196075cffc9e7062e74927] Merge tag 'iommu-updates-v6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/iommu/linux
git bisect good bed0653fe2aacb0ca8196075cffc9e7062e74927
# good: [6a74422b9710e987c7d6b85a1ade7330b1e61626] Merge tag 'mips_6.18' of git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux
git bisect good 6a74422b9710e987c7d6b85a1ade7330b1e61626
# bad: [522ba450b56fff29f868b1552bdc2965f55de7ed] Merge tag 'clk-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux
git bisect bad 522ba450b56fff29f868b1552bdc2965f55de7ed
# bad: [256e3417065b2721f77bcd37331796b59483ef3b] Merge tag 'for-linus' of git://git.kernel.org/pub/scm/virt/kvm/kvm
git bisect bad 256e3417065b2721f77bcd37331796b59483ef3b
# bad: [2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92] Merge tag 'pci-v6.18-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci
git bisect bad 2f2c7254931f41b5736e3ba12aaa9ac1bbeeeb92
# bad: [531abff0fa53bc3a2f7f69b2693386eb6bda96e5] Merge branch 'pci/controller/qcom'
git bisect bad 531abff0fa53bc3a2f7f69b2693386eb6bda96e5
# bad: [fead6a0b15bf3b33dba877efec6b4e7b4cc4abc3] Merge branch 'pci/resource'
git bisect bad fead6a0b15bf3b33dba877efec6b4e7b4cc4abc3
# good: [0bb65e32495e6235a069b60e787140da99e9c122] Merge branch 'pci/p2pdma'
git bisect good 0bb65e32495e6235a069b60e787140da99e9c122
# bad: [ebe091ad81e1d3e5cbb1592ebc18175b5ca3d2bd] PCI: Use pbus_select_window_for_type() during IO window sizing
git bisect bad ebe091ad81e1d3e5cbb1592ebc18175b5ca3d2bd
# bad: [2ee33aa14d3f2e92ba8ae80443f2cd9b575f08cb] PCI: Always claim bridge window before its setup
git bisect bad 2ee33aa14d3f2e92ba8ae80443f2cd9b575f08cb
# good: [2657a0c982239fecc41d0df5a69091ca4297647c] m68k/PCI: Use pci_enable_resources() in pcibios_enable_device()
git bisect good 2657a0c982239fecc41d0df5a69091ca4297647c
# bad: [ae81aad5c2e17fd1fafd930e75b81aedc837f705] MIPS: PCI: Use pci_enable_resources()
git bisect bad ae81aad5c2e17fd1fafd930e75b81aedc837f705
# good: [754babaaf33349d9ef27bb1ac6f5d9d5a503a2a6] sparc/PCI: Remove pcibios_enable_device() as they do nothing extra
git bisect good 754babaaf33349d9ef27bb1ac6f5d9d5a503a2a6
# first bad commit: [ae81aad5c2e17fd1fafd930e75b81aedc837f705] MIPS: PCI: Use pci_enable_resources()

