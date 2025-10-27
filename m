Return-Path: <linux-pci+bounces-39442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B4CC0EDC0
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 16:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F97819C7AB5
	for <lists+linux-pci@lfdr.de>; Mon, 27 Oct 2025 15:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803DB2D2499;
	Mon, 27 Oct 2025 15:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b="VS0Cw936"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57B8261581;
	Mon, 27 Oct 2025 15:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577636; cv=pass; b=PAtrGY6UAhoUf16v+alYllYjomdfqiUY1BALIOf7Y4opGPyEfAust8OGSWautGQv5gR0SRP3BS7/dCnYv2+P/26v3Kf9L4AlYQFuH/JzXnnQxiiP6dLWApRA/n9isT8kZBVcDg3liNlxBnkx9DsappKd70gH+9lg1BiH49hjaW8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577636; c=relaxed/simple;
	bh=XJQiGH4ToenKrm6wRhZu15WDH87CJjC+Z9TP4TSm0hI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2wey0CmcI8Bc0DKUhRm5x06q/sbnlWkjHihE6AIDOs0kn/v6YipxIfyFTTYvC76BGWpQW6w5ZRkoeLz30LXwOkPjliZAaDzbVHK6e3JjcXQ5MsUXkwZYgk+XDEeHlkHw1mZlPBa9od4+wvveJj0TLPHHjz1MsUoVqODFtWPslg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=nicolas.frattaroli@collabora.com header.b=VS0Cw936; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1761577612; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=l+JZGGDR2m3VU/Cwyz5ZkLBgm7Q9KyF4781HOkVfwMtyTSuo0wj47T3aajxSe7Tq5XSaiSgsYd6lbGr8XohfdQJZZA7KqpcrpPpGCut7LauQspY6C2l8/7bqIFfVIittUFKZOKfvSiajZEFIgwubqJVMLsiyhLS8cIb0PCaB9ws=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761577612; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vlE4F3UR10G7Zn5lJKVF/CJoO7DYHlDbIy6oRd+W4UI=; 
	b=KypNEj+R1Ih647Xxqsg6sNnXb/y4n7zXm1Ynf0Ak9hF8yr0Ku2qcbjr38mqr2AA5enC5fg6BJdEdu+xNsaWniRJzAFACYZafFqLS+uFAPQqpg0G8JZEx9NWcb0AeOZ1OGiwULwRknN8+7rkjd1DIzHL+tp4deKqFkioGUIbj0c0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=nicolas.frattaroli@collabora.com;
	dmarc=pass header.from=<nicolas.frattaroli@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761577612;
	s=zohomail; d=collabora.com; i=nicolas.frattaroli@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
	bh=vlE4F3UR10G7Zn5lJKVF/CJoO7DYHlDbIy6oRd+W4UI=;
	b=VS0Cw9369DkAqJrTLgI8YvVbEftCYZ/9nc/E6JOEV5UglTkCFawOrhAhT3IA1pii
	zsKoOZ2HTDtRiSSMhT/PdG9OwhvecDsOUxgYsuAHVbgPRyPmufFvmCCFksOaWQZfyjY
	wHasNddMVLFpTaOzMhMKhqFiGsmw9GU28HFdfsbg=
Received: by mx.zohomail.com with SMTPS id 1761577609895742.3072902066041;
	Mon, 27 Oct 2025 08:06:49 -0700 (PDT)
From: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof =?UTF-8?B?V2lsY3p5xYRza2k=?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Heiko Stuebner <heiko@sntech.de>,
 Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>,
 Hans Zhang <18255117159@163.com>,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>,
 "moderated list:ARM/Rockchip SoC support"
 <linux-arm-kernel@lists.infradead.org>,
 "open list:ARM/Rockchip SoC support" <linux-rockchip@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>, Anand Moon <linux.amoon@gmail.com>
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: Re: [PATCH v1 0/2] Add runtime PM support to Rockchip DW PCIe driver
Date: Mon, 27 Oct 2025 16:06:44 +0100
Message-ID: <5264377.31r3eYUQgx@workhorse>
In-Reply-To: <20251027145602.199154-1-linux.amoon@gmail.com>
References: <20251027145602.199154-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

On Monday, 27 October 2025 15:55:28 Central European Standard Time Anand Moon wrote:
> Introduce runtime power management support in the Rockchip DesignWare PCIe
> controller driver.  These changes allow the PCIe controller to suspend and
> resume dynamically, improving power efficiency on supported platforms.
> 
> Can Patch 1 can be backpoted to stable? It helps clean shutdown of PCIe.

You can do this by adding a Fixes tag to your patch. In your case, it
might be fixing whatever introduced the clk_bulk_prepare_enable, i.e.:

Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")

This would be put above your Signed-off-by in the first patch, after
the empty line.

To generate fixes tags like this, I use the following pretty format
in my .git/config:

    [pretty]
        fixes = Fixes: %h (\"%s\")

I can then do `git log --pretty=fixes` to show commits formatted
the right way. To find which commit to pick, `git blame` and
some sleuthing are helpful.

With this tag, stable bots can pick the commit into any release
that the commit it fixes is in.

Kind regards,
Nicolas Frattaroli

> 
> Clarification: the series is based on
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git
> branch : controller/dw-rockchip
> 
> Thanks
> -Anand
> 
> Anand Moon (2):
>   PCI: dw-rockchip: Add remove callback for resource cleanup
>   PCI: dw-rockchip: Add runtime PM support to Rockchip PCIe driver
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
> 
> 
> base-commit: 7ad31f88429369ada44710176e176256a2812c3f
> 





