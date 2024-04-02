Return-Path: <linux-pci+bounces-5508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF578894875
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 02:27:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB7C828326E
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 00:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 186F110E4;
	Tue,  2 Apr 2024 00:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="cpIC1dv6"
X-Original-To: linux-pci@vger.kernel.org
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D2BEC4;
	Tue,  2 Apr 2024 00:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712017654; cv=none; b=oTIEsr9Hf+Tq0GrqURMvzkVwUo4umPag2OEV0zvemPJPBs7TrTBYDiIowy+stGq+s2/PsxqzoeA4TArF15KtirsGufdsMEkzJ2euPbGp9uQGx5islLC5FJH25M8xs9kSyOjVAI9xmuOwCuvjXc7ZXdv3qheiKb2F4XXCbmA1BJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712017654; c=relaxed/simple;
	bh=fIGYmiYD8AMZwe+4Gsw6nOssrG7CtMo9B8Tvv1Z5vlk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LpgF+iaEXxNz8BQY6bVUZFjY8G4GovJhTyv5j+dymERY/faIQiDJfdGUpeC8JYFnPzT/XQexDY0mWwnr9sMEh5Qt7m+jrKUtce9z3w42zkaYzzBAK5WXr3ddFs0hylnsOIbET4ghL5VuV/YzD+CyKHeiyMyHOyM2n9QrGK48xY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=cpIC1dv6; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1712017644;
	bh=fIGYmiYD8AMZwe+4Gsw6nOssrG7CtMo9B8Tvv1Z5vlk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=cpIC1dv6RObP9UA+0I8I4WbuZMIfJR5hIqdMcNHrMPNjQNGL5CmapUB7sw5Zb1J2j
	 cclvW9+LqkwMVRWKe8lhRth//DA5btXHe0TnQWbixH1ZsoZh60I7wSB4QKXuH5uN0F
	 SJLiuxgS/dhiM7o+RzRaZQhPT/0fZgG+Y03Scdqs=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id A74251A3FFE;
	Mon,  1 Apr 2024 20:27:22 -0400 (EDT)
Message-ID: <67838089f740b7022106fccfae907843b02ec376.camel@xry111.site>
Subject: Re: [PATCHv3 pci-next 1/2] PCI/AER: correctable error message as
 KERN_INFO
From: Xi Ruoyao <xry111@xry111.site>
To: Ethan Zhao <haifeng.zhao@linux.intel.com>, Bjorn Helgaas
	 <helgaas@kernel.org>
Cc: Grant Grundler <grundler@chromium.org>, bhelgaas@google.com, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, mahesh@linux.ibm.com, oohall@gmail.com, 
	rajat.khandelwal@linux.intel.com, rajatja@chromium.org
Date: Tue, 02 Apr 2024 08:27:19 +0800
In-Reply-To: <ac855191-1289-40f5-b910-fb9558d5df76@linux.intel.com>
References: <20240326211705.GA1497507@bhelgaas>
	 <ac855191-1289-40f5-b910-fb9558d5df76@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-03-27 at 11:49 +0800, Ethan Zhao wrote:
> so, yup, basically, the signal integrity is not good enough.
> Though the function could work, its performance will be impacted.

FWIW I've replaced the motherboard and this is gone.  So it's likely a
signal integrity issue of the motherboard.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

