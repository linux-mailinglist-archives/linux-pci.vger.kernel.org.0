Return-Path: <linux-pci+bounces-37111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0EDABA4A1D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 18:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCF467BCB70
	for <lists+linux-pci@lfdr.de>; Fri, 26 Sep 2025 16:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA232FA0D3;
	Fri, 26 Sep 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FJnlHrNe"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D6112F99BC;
	Fri, 26 Sep 2025 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758904081; cv=none; b=FlcB/YZXv+hqPqCVWEDpse99X66I+V4OT4KSM//RIl+8zkQ+rtYVw4efRDwtMR/Cgd7EOOVR3eezQdG5Z1GJCK0Y2mXqtrCX2EFYjTCzsjg8RDBmsTXKCkfoQkp6fhvNcxy45uzG2il/oiLUDeh7xEReXiuCYaDTVo+FYlpgBNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758904081; c=relaxed/simple;
	bh=vjohy+nNyGpberAIlWkBgS5rNJca1fy4OxfKMLhyzHA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EMe+b6SOR5noj56u/rJaoY2igilzWvM0KH3tUVkbFkzz9n7yh1HlQOm4YSddnwoCALijGPMqMienSKqCYxF5rmmre15Dtxg89/1rPKaPSgMEvbtbpNFzI+8wimfAsNDslLCQohDtbgv3l6W8x94vF9Rx0v/qlH5RZuwGEHm90B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FJnlHrNe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE15AC4CEF4;
	Fri, 26 Sep 2025 16:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758904081;
	bh=vjohy+nNyGpberAIlWkBgS5rNJca1fy4OxfKMLhyzHA=;
	h=From:To:Cc:Subject:Date:From;
	b=FJnlHrNewbW9uZfkPhIN4QUg+E3ygvvEPwtbAeDYne87uvEngj/FF93oGYdc6f10K
	 Kmnui0i9sklOZCfjO0yHf1TTVAXNd1O32Zp81KyoayEG22RAi0F2jDdN0o3w7y3NK2
	 d+fGsubH5A/1OM1iRhMUbHTk4h4Bn2TY5JzSQF3y7+3xihC5w4fjcZuG0N2HtV92tM
	 iiyedEn86ukoStF/rYGoeeoZ4Yy9wvBnYSotUdi0nmTtQuqus2rSnS9R0w/MwmtrNM
	 dVy/D7dXdh2qdaSEDG0b6hgiNhdKQu4N1Gw/oTWiI9A4FHH4CqoBDVnjUqzvtcnPV1
	 Izwz9noDeAlGw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>,
 Linux PCI <linux-pci@vger.kernel.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Bjorn Helgaas <helgaas@kernel.org>, Zhang Qilong <zhangqilong3@huawei.com>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 Dhruva Gole <d-gole@ti.com>
Subject: [PATCH v4 0/3] PM: runtime: Auto-cleanup macros for runtime PM
Date: Fri, 26 Sep 2025 17:40:29 +0200
Message-ID: <6196611.lOV4Wx5bFT@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

Hi All,

This supersedes

https://lore.kernel.org/linux-pm/12763087.O9o76ZdvQC@rafael.j.wysocki/

which was an update of

https://lore.kernel.org/linux-pm/6204724.lOV4Wx5bFT@rafael.j.wysocki/

that superseded both

https://lore.kernel.org/linux-pm/5049058.31r3eYUQgx@rafael.j.wysocki/

and

https://lore.kernel.org/linux-pm/20250919163147.4743-1-tiwai@suse.de/

It follows the Jonathan's suggestion to use ACQUIRE()/ACQUIRE_ERR()
instead af raw CLASS() to make the code somewhat cleaner.

Thanks!




