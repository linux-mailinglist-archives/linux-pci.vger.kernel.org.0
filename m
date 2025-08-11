Return-Path: <linux-pci+bounces-33715-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBCAB20671
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 12:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDF518C08E0
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 10:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B36275B17;
	Mon, 11 Aug 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nMA6Irpl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6453513AD1C;
	Mon, 11 Aug 2025 10:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909760; cv=none; b=Utl0Ze+aOs3hnlOZLN03GBHxMaSF8BV44ivQylWEkAL/p3KnLkd3QhRmZ5tmrMOAqGQknIcDcuKHPtVB3T5q4QF15RQMvwyj+sbz/F/ikNy0EqxPOIrY0j+i5vSFhLpupPNGyT7tpoAWEosV4Z3Di+YAr4PoSbb1vLu/HFN+cJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909760; c=relaxed/simple;
	bh=Xzf+nwK2qY3PwRvaxvHONcQ/KLgN17tfoQPzvVifMhU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=BoJfA6d7p0ADlNllU6gxIEwk2BJLvZ2jJ/ftzZlWpVljyhRSyH6S2+tvUdkkwK3y8xyCrXEovH8FPN4coK1Xu2QRPJxGLRFo25OMhWFIdJXymA/tYt1F9pCimsMAK1iBvFXAa9hpKK/Bp/r2vXeIs/oJbUMR2oK1PqK3CxvZkOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nMA6Irpl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C96FC4CEF1;
	Mon, 11 Aug 2025 10:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754909759;
	bh=Xzf+nwK2qY3PwRvaxvHONcQ/KLgN17tfoQPzvVifMhU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=nMA6IrplwCz+5invYtW8rda4Szx+q4BGFC8SJx2xfpQt4ieIiQ2buj9dtlKxMiPvT
	 pa1YV6Wt/wG0IUOjn+e9oA+H1m8d09WIZ1NsIlIQDHEHnsg3xo9HxlqnOudaSRCUX1
	 2Ut7DyUMiG7hJwsNqtKGe+FdXHAlyEXB2ZqszgdfAl50YhSrkk0QR9TbrIEk5iNGdB
	 l0qEUQqGXKBep2ADwgri0DWWyL/87u5oC9Kcf54NzzeDfpGHxoNYBDh+DuFbEeOXz0
	 Wr97imQIbDrmKgwbStdLxHGDrsTHdlHhNmcY6K4VE3gwwrZlF+Fra7nKLdT0CrS+7E
	 F0RbV/GXb21mA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: Frank Li <Frank.li@nxp.com>, linux-pci@vger.kernel.org, 
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Bjorn Helgaas <helgaas@kernel.org>
In-Reply-To: <20250731-vntb-doc-v1-1-95a0e0cd28d0@baylibre.com>
References: <20250731-vntb-doc-v1-1-95a0e0cd28d0@baylibre.com>
Subject: Re: [PATCH] Documentation: PCI: endpoint: document BAR assignment
Message-Id: <175490975683.13738.17889079546991492298.b4-ty@kernel.org>
Date: Mon, 11 Aug 2025 16:25:56 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Thu, 31 Jul 2025 14:49:01 +0200, Jerome Brunet wrote:
> It is now possible to assign BARs while creating a vNTB endpoint function.
> Update the documentation accordingly.
> 
> 

Applied, thanks!

[1/1] Documentation: PCI: endpoint: document BAR assignment
      commit: 5f523381fdd44bcc3210ec18653eccafe4c4bf94

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


