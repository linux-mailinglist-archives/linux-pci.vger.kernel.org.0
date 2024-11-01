Return-Path: <linux-pci+bounces-15814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 321CF9B98E9
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 20:48:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBCCB282746
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 19:48:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0858D1D1753;
	Fri,  1 Nov 2024 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E4zytgZa"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4AD71D0F49;
	Fri,  1 Nov 2024 19:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730490511; cv=none; b=Xj9zNz8ETLOHdBgmVWL/EAoH5+WJGhzJeSpmZ7DJl9Iv7RywhwIaHOs7sv+9UFPzuVpHHGZwupx9+fxPlDuu4P538EYPjbstx3pbXJaiEwd4uyWlhQlkW7a+9pxRtdaCdNz+5FekuyBUd6lAmrJBBSKMuUqadyCd8UNL+xBey8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730490511; c=relaxed/simple;
	bh=qY0CZeZ9z/CEZe07PqyC8aHboYZg44UmgcubBVWYXDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ISf0bavVsOO7o+6TfaGgWMBhBYQeDWkPlk0dp/t6+4ewOfUcLOoMY/kCi3qt+TorOOthx2gkawErmAzsUWgctkrgCId4SMiygc5Ww+6xKpk3b1FcOjDnOLCbejQgiBfea8/eVn2xx0h/ApgWBvfIUjTRlNMb0qQFES/GkOLZjcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E4zytgZa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82579C4CECD;
	Fri,  1 Nov 2024 19:48:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730490511;
	bh=qY0CZeZ9z/CEZe07PqyC8aHboYZg44UmgcubBVWYXDs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=E4zytgZanmwWJ9XbR75BkJw6eSX10HPg1Jy4x9Fw3iuKO25JFJeWCvCBS3IK/x4Zs
	 c/f6R2EBqPpfVTtqXdwKV5pYiD+vK0a60vj6ZdtY0xuwXdgG55crQqAFcdQOozowuZ
	 JxSEzQwz3J+FXbi2ynikR4ofc6o8qs9iRZb9Isq/47yXM4GxGn3vEU2y26K/CF9r0v
	 RV/hLM1oKmDr/W0vQGcn7YRBb9kcjfQpCyymbCekVV2uJt9AfRn2wO0k/BZTzvRggj
	 NKRsp/T8YbazQSOKRsvTSSmtLt6v+6/9VyD6Hh6q2BiesEnOlHXQpRiMa2E1GmPiMC
	 YnltZz5BGFVCQ==
Date: Fri, 1 Nov 2024 14:48:29 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Wei Fang <wei.fang@nxp.com>
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org, horms@kernel.org,
	linux-kernel@vger.kernel.org, pabeni@redhat.com,
	xiaoning.wang@nxp.com, edumazet@google.com, linux@armlinux.org.uk,
	devicetree@vger.kernel.org, conor+dt@kernel.org,
	claudiu.manoil@nxp.com, krzk+dt@kernel.org,
	christophe.leroy@csgroup.eu, alexander.stein@ew.tq-group.com,
	Frank.Li@nxp.com, kuba@kernel.org, vladimir.oltean@nxp.com,
	imx@lists.linux.dev, davem@davemloft.net
Subject: Re: [PATCH v6 net-next 02/12] dt-bindings: net: add i.MX95 ENETC
 support
Message-ID: <173049050923.4090067.16955532766209341437.robh@kernel.org>
References: <20241030093924.1251343-1-wei.fang@nxp.com>
 <20241030093924.1251343-3-wei.fang@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241030093924.1251343-3-wei.fang@nxp.com>


On Wed, 30 Oct 2024 17:39:13 +0800, Wei Fang wrote:
> The ENETC of i.MX95 has been upgraded to revision 4.1, and the vendor
> ID and device ID have also changed, so add the new compatible strings
> for i.MX95 ENETC. In addition, i.MX95 supports configuration of RGMII
> or RMII reference clock.
> 
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---
> v2: Remove "nxp,imx95-enetc" compatible string.
> v3:
> 1. Add restriction to "clcoks" and "clock-names" properties and rename
> the clock, also remove the items from these two properties.
> 2. Remove unnecessary items for "pci1131,e101" compatible string.
> v4: Move clocks and clock-names to top level.
> v5: Add items to clocks and clock-names
> v6:
> 1. use negate the 'if' schema (not: contains: ...)
> ---
>  .../devicetree/bindings/net/fsl,enetc.yaml    | 28 +++++++++++++++++--
>  1 file changed, 25 insertions(+), 3 deletions(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


