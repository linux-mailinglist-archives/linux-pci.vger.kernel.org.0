Return-Path: <linux-pci+bounces-39174-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C4ACC027A0
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 18:42:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DE51A6548A
	for <lists+linux-pci@lfdr.de>; Thu, 23 Oct 2025 16:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77A1732ED45;
	Thu, 23 Oct 2025 16:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0c6/U5A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E774308F38;
	Thu, 23 Oct 2025 16:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761237727; cv=none; b=GSVsBC+g0oitJJOqJJI9JwfpBhmkGWJQvSDy8TprqhFl4iDLbYOIczYWRHfIt3gnPL7cgSC3dd71XHHZ3zllQdVhR36s+uj49tQdQPAg7/5G3FNlhiAZjJUmq2qb5d4DsCBLrZS3we2obOU15EVSvYVFeoQk49K/ntWrT+XhXVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761237727; c=relaxed/simple;
	bh=uJlSRfT8/bS/3xoosDFJ8lVEcav1dFXv/a8+4Z4p9yU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=C98lTi/u8g3Abci4+sCqa5DOAm8T+WzTCY+4F2yszfplFfx5aRLtnynjeG1N1pCNf7oyEBeou1B6qRVF7Ff+Sr+60QawngvHM6Kx2W7DR8Gb4aim7+tuOWEO1Ilik9gwnfoM5S0+pN/tLQJ2LwxFdr9x0bq6RVBmnCqxoVmzbIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0c6/U5A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65469C4CEE7;
	Thu, 23 Oct 2025 16:42:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761237726;
	bh=uJlSRfT8/bS/3xoosDFJ8lVEcav1dFXv/a8+4Z4p9yU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=E0c6/U5APlHZou8vlFPJ5i8G+pQK2bxrRcJDExNNhIVu/u7etT0Y2H9Z4rb3xftrM
	 0Vjf5301edc0190v3pxs7zi/L8/O3Sn/QweobA4o86du8XidbyWifaYtaLclEcMA8q
	 Q6MIZ7Oe9KfuN34xfcvQezpP/3PO50tmOAWqm3+pLRsoVp6RRptrBlf5fW03miAbND
	 wUW0sOn86j3UQ8DApmdq29SyZWg4lAn3BVrPOLhUyl5R2+8kI4UaNKUKNHwjtf92yS
	 l3XNdyeYuJWbZiKJhBTd03iiWeNZgz5CgyBUhhiGvWhHZf/QYYvdrw+YfP8s6vqArM
	 5VoidMT8evUdw==
Date: Thu, 23 Oct 2025 11:42:05 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Linnaea Lavia <linnaea-von-lavia@live.com>
Cc: "linux-amlogic@lists.infradead.org" <linux-amlogic@lists.infradead.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	regressions@lists.linux.dev, Yue Wang <yue.wang@amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Subject: Re: PCIe probe failure on AmLogic A311D after 6.18-rc1
Message-ID: <20251023164205.GA1299816@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR05MB102707B8CDF84D776C39F22F2C7F0A@DM4PR05MB10270.namprd05.prod.outlook.com>

[+cc Meson folks, Krishna, author of c96992a24bec]

On Thu, Oct 23, 2025 at 11:33:07AM +0000, Linnaea Lavia wrote:
> I'm getting the following in dmesg after installing 6.18-rc1 on a VIM3 board.
> 
> [    5.391324] [     T50] dw-pcie fc000000.pcie: error -ENXIO: IRQ index 1 not found
> [    5.411265] [     T50] meson-pcie fc000000.pcie: host bridge /soc/pcie@fc000000 ranges:
> [    5.415323] [     T50] meson-pcie fc000000.pcie:       IO 0x00fc600000..0x00fc6fffff -> 0x0000000000
> [    5.422278] [     T50] meson-pcie fc000000.pcie:      MEM 0x00fc700000..0x00fdffffff -> 0x00fc700000
> [    5.442280] [     T50] meson-pcie fc000000.pcie: error -EBUSY: can't request region for resource [mem 0xfc000000-0xfc3fffff]
> [    5.449631] [     T50] meson-pcie fc000000.pcie: Add PCIe port failed, -16
> [    5.458779] [     T50] meson-pcie fc000000.pcie: probe with driver meson-pcie failed with error -16
> 
> I think the problem is related to c96992a24bec("PCI: dwc: Add
> support for ELBI resource mapping") and 2f2cea1ea70a("PCI:
> dwc/meson: Rework PCI config and DW port logic register accesses"),
> as they're both trying to map ELBI/DBI registers.

Thanks for the report!  Can you post complete dmesg logs for working
and broken boots, e.g., v6.17 and v6.18-rc1?

#regzbot ^introduced: v6.18-rc1

