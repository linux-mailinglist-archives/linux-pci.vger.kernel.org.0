Return-Path: <linux-pci+bounces-12415-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B1CF963F88
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 11:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 397D01C222BA
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 09:09:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113C318C927;
	Thu, 29 Aug 2024 09:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2vcvL4KL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D140A15666A;
	Thu, 29 Aug 2024 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724922592; cv=none; b=a4edi0mhTMl4z/4Mrxi23+WQFSfOj1OkT9Qj2Jf4qLys/56GKSBM0lyujBWDlvQGr51TMXQ1dqg+3sqvdSaV8h0ZSmZVMgMb3SKymkfnDkabs0Mnsy3OP7h7Z5X/ya6nT3D3kzycqnNULEUFg88A39YGz/fs/aZwZxct3qoIMwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724922592; c=relaxed/simple;
	bh=JMeBGW1rhgHUV1IyuaKJAhu8KZMEiAGjzQflZ5mhluQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GFDUSajFu7sS6fGabLDARmESRWh1Q7Eeo5PSE5DptKuFbbaMJP/oFpF6FiKEobSGdxlnAghA/pISkAbTofje54Ufky+406KLLl4SNgXFWgNyvFEVN7GCzlWBySU6jx9Kb2U4QPlruzHeooFqiUKT5lko3OFuqDdXV9MpfoLSsvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2vcvL4KL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A39C4CEC1;
	Thu, 29 Aug 2024 09:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724922591;
	bh=JMeBGW1rhgHUV1IyuaKJAhu8KZMEiAGjzQflZ5mhluQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2vcvL4KLWQdVBW6V9TFZ64uVC8WyycnH4nVPmfOl/CDNJxwluE/wGk55hO9BlP7BX
	 WH/nXKleIdaea5CtcJjvknjZoPkKhoVaMHGbOabBQH/pyZFnaGovifFpVYOVm8sN4E
	 WNZOmxISvEXoZQS5Rp8H15EMKqzD0SZKO7PVasKI=
Date: Thu, 29 Aug 2024 11:09:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: WangYuli <wangyuli@uniontech.com>
Cc: mathias.nyman@intel.com, bhelgaas@google.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	guanwentao@uniontech.com, zhanjun@uniontech.com,
	Chen Baozi <chenbaozi@phytium.com.cn>,
	Wang Zhimin <wangzhimin1179@phytium.com.cn>,
	Chen Zhenhua <chenzhenhua@phytium.com.cn>,
	Wang Yinfeng <wangyinfeng@phytium.com.cn>,
	Jiakun Shuai <shuaijiakun1288@phytium.com.cn>
Subject: Re: [PATCH] usb: xHCI: add XHCI_RESET_ON_RESUME quirk for Phytium
 xHCI host
Message-ID: <2024082915-oil-carefully-bdfd@gregkh>
References: <59E000092FD56E43+20240829073005.304698-1-wangyuli@uniontech.com>
 <2024082944-say-caution-befe@gregkh>
 <A2BAFE2C814CDA13+6d47d76e-f0be-4380-bc98-9bd303ac52d6@uniontech.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A2BAFE2C814CDA13+6d47d76e-f0be-4380-bc98-9bd303ac52d6@uniontech.com>

On Thu, Aug 29, 2024 at 04:55:19PM +0800, WangYuli wrote:
> 
> On 2024/8/29 16:46, Greg KH wrote:
> > Please read the top of this file, there's no need to add this id to this
> > file as you are only using it in one .c file.
> 
> Thanks for review.
> 
> More files using PCI_VENDOR_ID_PHYTIUM will appear,though maybe not in the
> USB subsystem.
> 
> These patches are on their way and I won't keep you waiting too long.

When that change happens, then you can add it to the .h file.

> However,if I temporarily delete this line and use a raw hexadecimal value in
> xhci-pci.c,I'll need to modify xhci-pci.c again soon.

Just put the define in xhci-pci.c and all will be fine.

thanks,

greg k-h

