Return-Path: <linux-pci+bounces-38881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3A6BF6664
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 14:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E61719A3557
	for <lists+linux-pci@lfdr.de>; Tue, 21 Oct 2025 12:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 406EC1E7C23;
	Tue, 21 Oct 2025 12:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bdMZMNJh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D9517BED0
	for <linux-pci@vger.kernel.org>; Tue, 21 Oct 2025 12:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761049188; cv=none; b=f0UuojdaRFuqWsEDCTEIaFRcKsq3VInczBZL1GBkkRVCwNU6cCQJaX1BFmbpwhVU2iP+WZV9aA/LlfoO8H4rbTg7+dsmfaPgo+ftLb7LSGRLa+n2Gnqbd10lpmmFNfknsUpEff6GnRwUw0UKNFBRN3hbrXHZ+qXEoHOIYgbi3vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761049188; c=relaxed/simple;
	bh=s6vx8VrH2c/og0yLWr/Y9sUR3aZ+qnxVoV5eMNt6vVE=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qHgqoW9vN8ixI6KK+JsiqWGnO6TkUiHWBp2tnMtrf1QbLOxH/TiHnYTPBp9OA4O72Txncb0juYHBN2EGkph0djbn6CKo2gi/HuzwwuCkQO0UyEg8H+k3GiHyI25pTbuOfL7kzJHJfe3CnSodqS9FvYGZr0JCOa7v8EFRON/LgfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bdMZMNJh; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761049186; x=1792585186;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=s6vx8VrH2c/og0yLWr/Y9sUR3aZ+qnxVoV5eMNt6vVE=;
  b=bdMZMNJhhSIf9HBQ46qaXeR+CnFulqQRQv2ad+G29Zr1CxIWxjqSAiSO
   KqGddJTbm8oNl5391Sg1fbzl5aKy2nrJ1/z1RxmBiH88n6xRaxaMxQpHs
   70bRKgBM9qy6bNHDdEpgFUVlp7YWJVPoh8n/eEVosY3EPN/ikntVe7wBJ
   tOchg37wzPI+gSp5q3difITOHA2UQ2a08Pm5O/3L6U0HgzOnvDWDCK07v
   zwPlehD7A1UMu8qBQ5Ans9hPMZvTSmEsDpdrGooREnCyr7HajgMcORXfO
   ySQhva43zxvWamdKBuTPQJzk/EzopnFQQk2tC6RdsVx9JM1BzOU9E7cMK
   w==;
X-CSE-ConnectionGUID: qVWITCgqTai8OV21jIH4Gg==
X-CSE-MsgGUID: LweJzidhRJ6XUVQSlgL3ow==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="67036665"
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="67036665"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 05:19:45 -0700
X-CSE-ConnectionGUID: gG0xkmzTT+2jbxeYjZUpCg==
X-CSE-MsgGUID: O9PRIGNiSiacB+a42S6WVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,244,1754982000"; 
   d="scan'208";a="183606993"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.189])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 05:19:43 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 21 Oct 2025 15:19:39 +0300 (EEST)
To: FUKAUMI Naoki <naoki@radxa.com>
cc: Manivannan Sadhasivam <mani@kernel.org>, 
    linux-rockchip@lists.infradead.org, linux-pci@vger.kernel.org
Subject: Re: ROCK 5B/5B+ RTL8852BE probe failure on v6.18-rc
In-Reply-To: <3BA1DC4878E9DC7E+85e7ef2c-a762-4c12-8955-64212bc192da@radxa.com>
Message-ID: <b7e058ab-a5bf-1e71-850f-03e99f274e77@linux.intel.com>
References: <7755D0222F97F8A4+6c855efa-561f-4fd9-aadd-a4de3d244c7e@radxa.com> <dgn3ekyon6jwfinerxx2ohpvebnxvuvpyqratfc3ciys4l4et7@5un6wskt4xn3> <3BA1DC4878E9DC7E+85e7ef2c-a762-4c12-8955-64212bc192da@radxa.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 21 Oct 2025, FUKAUMI Naoki wrote:

> Hi Manivannan,
> 
> Thank you for your reply.
> 
> On 10/21/25 20:02, Manivannan Sadhasivam wrote:
> > On Tue, Oct 21, 2025 at 07:12:21PM +0900, FUKAUMI Naoki wrote:
> > > Hi,
> > > 
> > > I've observed an issue where the RTL8852BE fails to probe on the ROCK 5B
> > > and
> > > ROCK 5B+ using Linux v6.18-rc.
> > > 
> > > [    7.719288] rtw89_8852be 0002:21:00.0: loaded firmware
> > > rtw89/rtw8852b_fw-1.bin
> > > [    7.720192] rtw89_8852be 0002:21:00.0: enabling device (0000 -> 0003)
> > > [    7.728596] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.5
> > > (da87cccd), cmd version 0, type 5
> > > [    7.729407] rtw89_8852be 0002:21:00.0: Firmware version 0.29.29.5
> > > (da87cccd), cmd version 0, type 3
> > > [   11.420623] rtw89_8852be 0002:21:00.0: failed to dump efuse physical
> > > map
> > > [   11.422859] rtw89_8852be 0002:21:00.0: failed to setup chip information
> > > [   11.425273] rtw89_8852be 0002:21:00.0: probe with driver rtw89_8852be
> > > failed with error -16
> > > 
> > > This issue does not reproduce on v6.16. The issue does not reproduce with
> > > the MT7921E or the AX210. Furthermore, the issue does not reproduce on the
> > > ROCK 5A or the ROCK 5 ITX+.
> > > 
> > > The issue appears not to reproduce in or prior to commit 14bed9bc81ba. The
> > > issue reproduces, albeit with a low incidence rate, after commit
> > > bf76f23aa1c1.
> > 
> > Both of these commits are merge commits and they seem to be not related to
> > PCI
> > or WiFi.
> > 
> > > It reproduces, but not 100%, on v6.17, and is likely 100%
> > > reproducible on v6.18-rc.
> > > 
> > > The dmesg output and the result of lspci -vv when the issue occurs can be
> > > found below:
> > >   https://gist.github.com/RadxaNaoki/bf57b6d3d88c1e4310a23247e7bac9de
> > > 
> > > What should I investigate next?
> > > 
> > 
> > So the patch from Niklas [1] didn't solve the issue on these board + WiFi
> > chip
> > combo?
> 
> Yes, I am reproducing the issue with the patch applied, and it also reproduces
> on v6.17.
> 
> The RTL8852BE on the ROCK 5B+ is an onboard component, while the ROCK 5B uses
> an M.2 module; the issue does not appear on the ROCK 5A or ROCK 5 ITX+ even
> with the same M.2 module and the same kernel/userland.

Hi,

There have been quite a few changes into rtw89 post-6.16. Depending on 
how easy it is to reproduce the issue, a bisection might be useful to 
pinpoint the cause.

> Best regards,
> 
> --
> FUKAUMI Naoki
> Radxa Computer (Shenzhen) Co., Ltd.
> 
> > - Mani
> > 
> > [1]
> > https://lore.kernel.org/linux-pci/20251017163252.598812-2-cassel@kernel.org/
> > 
> 
> 
> 

-- 
 i.


