Return-Path: <linux-pci+bounces-30368-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FC8AE3E1C
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 13:38:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63E991709B4
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jun 2025 11:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B71E2376F7;
	Mon, 23 Jun 2025 11:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQBR0C3L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170FD2253FE
	for <linux-pci@vger.kernel.org>; Mon, 23 Jun 2025 11:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750678688; cv=none; b=eg/+sFl5OH6PXOes7aKTUE3ziXYwf6TkthYSbFjwNPeYrFioOM/FNHXTBWkVBAihA62OTuBgAJQWMDEZzoAXhLcs15VgK9rxbWhsVNxD47IVVpnyJNPUU0l1t9mi9UVSgvF7QypXSijGht1820tzgVcNXs+abe5Hta9X+crfY8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750678688; c=relaxed/simple;
	bh=0nq/n2xt26WKh/2uvAeZkvqdggWtbJRHgGXroegZyV4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gyErT9Ou6GigMaq6qq+Mumw+eHiGGsyJWCHWarftX7wryecMsrYZGwMEK5oBmTKZlNYQoRZXI9tuqWKHma0j8Qtkj7oL6CepJNsXLprnEu8I5n6QIuT+m4c0ce8KyYPbWEuedu0TeXTVnMIA7aPoah7HdY7F0mQJBz0K25QMUS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TQBR0C3L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60AE3C4CEF1;
	Mon, 23 Jun 2025 11:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750678687;
	bh=0nq/n2xt26WKh/2uvAeZkvqdggWtbJRHgGXroegZyV4=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=TQBR0C3LwJKl51n4LeHbxWEb447FUptwQhm+dqVYukd2hE3nltAUSX5JN6pAoVsV2
	 Z/SIRV2GyDUe2oSEkh45HPS3DCyaS60ZXFcxG4SzO7Id/RUd/6pxTnkkuNXTGKacju
	 nD1NMw9Lw6yC6mv7DaGFuO/quYkjC/7x+YhL6btJqvxoodhGZpzG+eDJmNititmsUE
	 OHZ+LKNeGBZWft/TDprUlN36IcqUUgAElldQ7T+ltUJi1r4MJZtvT3FqLaXEpP75Z4
	 lAfF18Vjs7taEKbf6pk8qz+9EIP6z6OqdN6E8UsnENZuITOZ8OyRh7QPtkK+/5748T
	 DIe/+jFKv8Yow==
From: Manivannan Sadhasivam <mani@kernel.org>
To: nirmal.patel@linux.ntel.com, george.d.sworo@intel.com
Cc: linux-pci@vger.kernel.org
In-Reply-To: <20250606210230.340803-2-george.d.sworo@intel.com>
References: <20250606210230.340803-1-george.d.sworo@intel.com>
 <20250606210230.340803-2-george.d.sworo@intel.com>
Subject: Re: [PATCH 1/1] PCI: vmd: Add VMD Device ID Support for PTL-H/P/U
Message-Id: <175067868730.6282.7284035580554346221.b4-ty@kernel.org>
Date: Mon, 23 Jun 2025 05:38:07 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 06 Jun 2025 14:02:30 -0700, george.d.sworo@intel.com wrote:
> Add VMD Device ID Support for PTL-H/P/U
> 
> 

Applied, thanks!

[1/1] PCI: vmd: Add VMD Device ID Support for PTL-H/P/U
      commit: 255c891533d89f5d7339076468a98afc947c4a73

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


