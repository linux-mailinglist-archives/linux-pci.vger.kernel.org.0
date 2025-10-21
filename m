Return-Path: <linux-pci+bounces-38880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10AEDBF66DF
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:25:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 090F43BA5E6
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86753221FDA;
	Tue, 21 Oct 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRRjNj6n"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C31C355034
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 12:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049036; cv=none; b=ndHb6wwmmcWIe3R6D+NKxo1PV86q6r9RmMRwpcTZ9BMv3lU4jIfDAOHZEyhPe8I7ISRxhL9wHJw//alDlVvVHUJdfZCFQ/xWFjQL4XQrIn51UDKqxQ3yBOMDUv6cd6Ue8oUqQ5Wku3VcxVimPUtLHnyMrDKH/P0v6kDwGEMWG4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049036; c=relaxed/simple;
	bh=QKaQOeBETv/Tjyo/r5VnFZ/yPMBPWTataIf00CeNfP0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLKv6TiHBgJnWBpDDJZ2zw1+/eIhuE4Oton8j5HBykqS0e32ygX8lQ2DjI1l2as6R1z4MhzIwOVYowW6Q8GRrpVKob/2wSqkW4hRsPITx6EQRNGonW0IkmgBWkvCsSZYIaQpeBj2YL6ZlskIb0YtXdcKF9p/KR2BypFvtBC2IR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRRjNj6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DE0AC4CEF1;
	Tue, 21 Oct 2025 12:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761049035;
	bh=QKaQOeBETv/Tjyo/r5VnFZ/yPMBPWTataIf00CeNfP0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XRRjNj6nh085s0KNlvcNaUQTvoyS87lKEdkFEO7lA5temHOsw3ujr4eryFmFNcvBV
	 wb851n3S5KDk7tJ8GGvCiO9wDMdnpwKCqxlrR5NdS6XJ8ZsAMg0UsDaHRGcTT9tC8V
	 wV0TGd7h9yQLFpWgU96CJn1syHItSoSzWw7cUL6DAtGpDoSuu+0r5v7k9iIj1JvqA8
	 04hNQro607yUax+8JMHUcOSXue2+mIaq3qTFuZp3RItKr1+JZwY/F4AkVE8iRdG63+
	 UEF3qdi1ExZn5K2hE8rYkLnFufHPabjVOdrjEyeOIM5bNgQdnLtEX040GDI+69Zy3x
	 xdtGcV02msI7A==
Date: Tue, 21 Oct 2025 17:47:02 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: FUKAUMI Naoki <naoki@radxa.com>
Cc: linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: ROCK 5B/5B+ RTL8852BE probe failure on v6.18-rc
Message-ID: <basm3bnws2shwvpo5xv3opyooh2atvzkfsp54ll6lfca5ugifs@p6nbl6hc6qof>
References: <7755D0222F97F8A4+6c855efa-561f-4fd9-aadd-a4de3d244c7e@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7755D0222F97F8A4+6c855efa-561f-4fd9-aadd-a4de3d244c7e@radxa.com>

On Tue, Oct 21, 2025 at 07:12:21PM +0900, FUKAUMI Naoki wrote:
> Hi,
> 
> I've observed an issue where the RTL8852BE fails to probe on the ROCK 5B and
> ROCK 5B+ using Linux v6.18-rc.
> 
> [    7.719288] rtw89_8852be 0002:21:00.0: loaded firmware
> rtw89/rtw8852b_fw-1.bin
> [    7.720192] rtw89_8852be 0002:21:00.0: enabling device (0000 -> 0003)
> [    7.728596] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.5
> (da87cccd), cmd version 0, type 5
> [    7.729407] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.5
> (da87cccd), cmd version 0, type 3
> [   11.420623] rtw89_8852be 0002:21:00.0: failed to dump efuse physical map
> [   11.422859] rtw89_8852be 0002:21:00.0: failed to setup chip information
> [   11.425273] rtw89_8852be 0002:21:00.0: probe with driver rtw89_8852be
> failed with error -16
> 
> This issue does not reproduce on v6.16. The issue does not reproduce with
> the MT7921E or the AX210. Furthermore, the issue does not reproduce on the
> ROCK 5A or the ROCK 5 ITX+.
> 
> The issue appears not to reproduce in or prior to commit 14bed9bc81ba. The
> issue reproduces, albeit with a low incidence rate, after commit
> bf76f23aa1c1. It reproduces, but not 100%, on v6.17, and is likely 100%
> reproducible on v6.18-rc.
> 

You should try to bisect the commit in v6.18-rc1 that is causing the failure
reliably. This will greatly help in fixing the issue.

> The dmesg output and the result of lspci -vv when the issue occurs can be
> found below:
>  https://gist.github.com/RadxaNaoki/bf57b6d3d88c1e4310a23247e7bac9de
> 
> What should I investigate next?
> 

Nothing looks like a PCIe breakage AFAICT. Maybe you should check with rtw89
maintainers:

Ping-Ke Shih <pkshih@realtek.com> (maintainer:REALTEK WIRELESS DRIVER (rtw89))
linux-wireless@vger.kernel.org (open list:REALTEK WIRELESS DRIVER (rtw89))

Note: Since the failure happens after firmware loading, it could be the
firmware incompatibility issue also. But that could only be confirmed by rtw89
maintainers/community. 

- Mani

-- 
மணிவண்ணன் சதாசிவம்

