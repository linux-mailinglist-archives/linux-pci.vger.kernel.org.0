Return-Path: <linux-pci+bounces-19676-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC55A0BB8C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 16:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F24CB188530A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2025 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8871C5D53;
	Mon, 13 Jan 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sHxgeKpc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3D0D240259;
	Mon, 13 Jan 2025 15:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736781081; cv=none; b=HLQxzpTPO/9lrQ8ycYPE2rW8nyUZKvdI7JSCyTEklEN+nZUPdi42pBrtF164SQAsm98pvV3u1qPFNC0C/7ePNj7IgnBstW4xwISJ8Hw7In2Fu+T+8z+vBH+ICdwsxrhMsl+Nj8RqPruLngBp+fjluRTMnuSePrdt2FGVrm13A9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736781081; c=relaxed/simple;
	bh=N6GNEhMlM/EdKo1uVEpkZEePe/ExshF2obnY4wmPz1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GDzEH7j04NXz2m1X4kjFXOcxUsNTuf8QlHgxTQHObx6NO5jlLuBGJPUAKsECPP3Nc0rLhgQqm84OBKpmX4kII64JkoDBq4sdTL4hrgNM/Cop/bSlrFDrxeBoDS2+oneceqImLGBvHSOXLh8Rbksbh7Bgo2ZqgArKvU0lXD1wzfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sHxgeKpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2B86C4CED6;
	Mon, 13 Jan 2025 15:11:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736781081;
	bh=N6GNEhMlM/EdKo1uVEpkZEePe/ExshF2obnY4wmPz1o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sHxgeKpcFZwVtcznd92IQZSVdXQ8zlto0BNw4l/sLVZQNSpZyn1E4TLHG3gGCgL1U
	 N1opb9t+mJLNiG/9W1MkQfowvgkHgxu1Ea+L3iYE68ftFXREMbR2YMwZMWzjMdssnU
	 OOOKGfxwi7RUrWUE4cmhMVOrAfUhJMYzxX7W3hieXoPbbPjlo9CgGAY2dsObjswOpo
	 K/dbm8rpwrflXZO/pDzc6/x5j75DHX2lodXrtLX2mVYxklDZWghYSrwwD8JRLAtLJ6
	 BXRJjgs9C99zzJ1HWogc0nw0scidOo+Jtk5yGxwJEfb29SIJyk5sGLkWtvnhaixEIq
	 OuXm8c2Zm7gAw==
Date: Mon, 13 Jan 2025 08:11:19 -0700
From: Keith Busch <kbusch@kernel.org>
To: Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org, linux-pci@vger.kernel.org,
	Nirmal Patel <nirmal.patel@linux.intel.com>,
	Jonathan Derrick <jonathan.derrick@linux.dev>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?iso-8859-1?Q?Wilczy=B4nski?= <kw@linux.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 2/3] vmd: disable MSI remapping bypass under Xen
Message-ID: <Z4UtF737b3QFGnY0@kbusch-mbp>
References: <20250110140152.27624-3-roger.pau@citrix.com>
 <20250110222525.GA318386@bhelgaas>
 <Z4TlDhBNn8TMipdB@macbook.local>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Z4TlDhBNn8TMipdB@macbook.local>

On Mon, Jan 13, 2025 at 11:03:58AM +0100, Roger Pau Monné wrote:
> 
> Hm, OK, but isn't the limit 80 columns according to the kernel coding
> style (Documentation/process/coding-style.rst)?

That's the coding style. The commit message style is described in a
different doc:

  https://docs.kernel.org/process/submitting-patches.html#the-canonical-patch-format

