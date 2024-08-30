Return-Path: <linux-pci+bounces-12488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 816969656DA
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 07:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45561C21501
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 05:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06405142624;
	Fri, 30 Aug 2024 05:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="I5jsYDMF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82BBEEB7;
	Fri, 30 Aug 2024 05:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724995433; cv=none; b=gaWB2Uc9U8779qv7YJQqwB5O6ou5wtjt/IJNu/SnF1zuYMwJLbewMMbDFJf5JwCRMQpxkD6kFxEjFSju+xPs5axB9nlxD3YAQFdnqSgczEZu6QQIYBUIxkY8lh+yBxzSYOG8I3l/UT0W3V2S5AmUjLV2weUWnK9FALPLJmfGxhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724995433; c=relaxed/simple;
	bh=g0jou+hkbZ1Cw5t8c9AWKZzysCGPuMG2V/6r2Uwp1Qw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZLan9vpCF8ylgDLU26hys+ncJYADrvHACVD9bxie2Tlf9cR+pKqRsiD7QSOnB6COBbenuecy8F52/jaLg9NtJyxnsJ2OEk3jzjh3HdmmeQGMQT2agAF2UETjdXhNkCmLQ/JZHXURUZ1Ynbw1N3D2wXme0neJEojn2qZWnVfLZDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=I5jsYDMF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8E1CC4CEC4;
	Fri, 30 Aug 2024 05:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724995433;
	bh=g0jou+hkbZ1Cw5t8c9AWKZzysCGPuMG2V/6r2Uwp1Qw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I5jsYDMF/JJrYup8m0quhEu3opTU6/ba3rMsdd6DIHxsgNVGOYp3s5iuAciy2cAXk
	 ItTHrrLh9/TO3eO8xbDrvN3V8DP+PPWCYx+wtDXWk1u3+1j/gnpJicvvCY7BNW8/hB
	 ssTRu5dJfZ7ZyNGxHwTAp0Ids7hCWfuW+fiR5ha8=
Date: Fri, 30 Aug 2024 07:23:49 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: mathias.nyman@intel.com, sergei.shtylyov@gmail.com, helgaas@kernel.org,
	yuzenghui@huawei.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	guanwentao@uniontech.com, Chen Baozi <chenbaozi@phytium.com.cn>,
	Wang Zhimin <wangzhimin1179@phytium.com.cn>,
	Chen Zhenhua <chenzhenhua@phytium.com.cn>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
Subject: Re: [PATCH v3] usb: xHCI: add XHCI_RESET_ON_RESUME quirk for Phytium
 xHCI host
Message-ID: <2024083013-crinkle-making-8cb8@gregkh>
References: <51AD65BA61BA0881+20240830043509.31019-1-wangyuli@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51AD65BA61BA0881+20240830043509.31019-1-wangyuli@uniontech.com>

On Fri, Aug 30, 2024 at 12:35:09PM +0800, WangYuli wrote:
> The resume operation of Phytium Px210 xHCI host would failed
> to restore state. Use the XHCI_RESET_ON_RESUME quirk to skip
> it and reset the controller after resume.
> 
> Changlog:
>  *v1 -> v2: Move the PCI_VENDOR_ID_PHYTIUM form pci_ids.h to xhci-pci.c
>   v2 -> v3: Change "||" to "&&", that was a mistake.

As per the documentation, the changelog goes below the --- line.

Please fix up and send a v4.

thanks,

greg k-h

