Return-Path: <linux-pci+bounces-26223-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0083DA938F6
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 16:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 749AD19E7800
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 14:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC53574BE1;
	Fri, 18 Apr 2025 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6KPu1LU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CB7EEC8;
	Fri, 18 Apr 2025 14:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744988114; cv=none; b=ETMl5Hpv86RHPtpw071MAcX7eRMYlfK4bmeYU5CPzk7Owc3OfhHiOHo6yMa19VtnuR5qIksXPDj6RoIF0/a3Z4TlSaDMD7VxeS6n1skbSq/37AI5kv8IiXvWXFVrgB0Sn9W44NcWf9rBGr3rpjQuBv9QfiCqAg1yzhAHIgjcO0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744988114; c=relaxed/simple;
	bh=Frm0OyEXiFNugmsEtT7iUopntSsaA9tw3r4eeSFnUbY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QYzoOMxJyqo1eb/s13+8jxMiiN59GD3XKGzJXAjnQ+shrDMyNapxhiJh1y8xDwxTBXKxncksR9C5lsh8A7OCrliucK28ynqWsF5/l/1HhQLv6HBzAUXwPR8qUIpVsjfpgHuPfjhWimqowStGLBTDbUzdKcqOHB9EZOL5TDamZA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6KPu1LU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A8ABC4CEE2;
	Fri, 18 Apr 2025 14:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744988114;
	bh=Frm0OyEXiFNugmsEtT7iUopntSsaA9tw3r4eeSFnUbY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=s6KPu1LU/g8obT6chIIPEOIfs15cvyNkdg3BIqXZ6EqPBWW5RtaYX7i04EEkia9Pb
	 StL/4Fzc1ioA5zc9Rh7I0rqEuEezen59ERoS399lhYnv7labcWMHHrHtmEMQl5ByjN
	 zzVDfTQNylcxNYx7ZlWv7xGxfXYF9j6hvuNzUafJwWddt463KxNhXvEjhlZN5CSQh6
	 Is8wYv36J/use3ISNJSXzchH8EMe5uFcHACvo01+bW8cE4RHkytxMdfrpMHGx/tS+n
	 qJX2Z0LID1RsDXKPHUunCf9uDOphDOFwnI66xC5hGnR4DOn5ztA9h7SB5h4RwSrmKY
	 6twznn41rphgQ==
Date: Fri, 18 Apr 2025 16:55:13 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Hans Zhang <18255117159@163.com>, Bjorn Helgaas <helgaas@kernel.org>
CC: Shawn Lin <shawn.lin@rock-chips.com>, lpieralisi@kernel.org, kw@linux.com,
 bhelgaas@google.com, heiko@sntech.de, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
User-Agent: K-9 Mail for Android
In-Reply-To: <22720eef-f5a3-4e72-9c41-35335ec20f80@163.com>
References: <20250417165219.GA115235@bhelgaas> <22720eef-f5a3-4e72-9c41-35335ec20f80@163.com>
Message-ID: <225CC628-432C-4E88-AF2B-17C948B3790B@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 18 April 2025 14:33:08 CEST, Hans Zhang <18255117159@163=2Ecom> wrote:
>
>Dear Bjorn,
>
>Thanks your for reply=2E Niklas and I attempted to modify the relevant lo=
gic in drivers/pci/probe=2Ec and found that there was a lot of code judging=
 the global variable pcie_bus_config=2E At present, there is no good method=
=2E I will keep trying=2E
>
>I wonder if you have any good suggestions? It seems that the code logic r=
egarding pcie_bus_config is a little complicated and cannot be modified for=
 the time being?


Hans,

If:

diff --git a/drivers/pci/probe=2Ec b/drivers/pci/probe=2Ec
index 364fa2a514f8=2E=2E2e1c92fdd577 100644
--- a/drivers/pci/probe=2Ec
+++ b/drivers/pci/probe=2Ec
@@ -2983,6 +2983,13 @@ void pcie_bus_configure_settings(struct pci_bus *bu=
s)
         if (!pci_is_pcie(bus->self))
                 return;
  +       /*
+        * Start off with DevCtl=2EMPS =3D=3D DevCap=2EMPS, unless PCIE_BU=
S_TUNE_OFF=2E
+        * This might get overriden by a MPS strategy below=2E
+        */
+       if (pcie_bus_config !=3D PCIE_BUS_TUNE_OFF)
+               smpss =3D pcie_get_mps(bus->self);
+
         /*
          * FIXME - Peer to peer DMA is possible, though the endpoint woul=
d need
          * to be aware of the MPS of the destination=2E  To work around t=
his,



does not work, can't you modify the code slightly so that it works?

I haven't tried myself, but considering that it works when walking the bus=
, it seems that it should be possible to get something working=2E


Kind regards,
Niklas

