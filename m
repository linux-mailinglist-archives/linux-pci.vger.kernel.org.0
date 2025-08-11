Return-Path: <linux-pci+bounces-33719-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F591B20708
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43287B6ACE
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 10:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC35267733;
	Mon, 11 Aug 2025 10:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8xjHyMh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E5E1F418D;
	Mon, 11 Aug 2025 10:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909979; cv=none; b=eo5e0tfvAppCC6t3u6FCN2MEaY3DAkRji3TJ/vH39Ko1V3tCrQg1F8qaqi+SYc7IvMpLogl3HIijl5jaA8C6qthr0mS4Y3rlGloU3A9RzGYaz6Mhp+GxoWV+ImAmHNCigTJKnSWzKws+/wqsrU1VslrI56qcD8ofTx/Wrao7+Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909979; c=relaxed/simple;
	bh=tZQ36z1Z6nxeJ9tWYrZFEmdfAxKzhVl+DzQyCGbp7mA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=akdqLCqTeS7R+pGr/1o8kvZ6y3bTGSNmuRXdT4Lv/9/wFl4uTaHI+hCqKV3A8WJYV1RzS7Kxr1scibg6l5th9OcoJnlboWMLKZAOMEEExUtGTHXdgXxiS0iJcoOMOKb0HX174cVE2d8EsJ0LM2ROHKCQohuGWB1zQ+ouARatF/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8xjHyMh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 948F8C4CEED;
	Mon, 11 Aug 2025 10:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754909978;
	bh=tZQ36z1Z6nxeJ9tWYrZFEmdfAxKzhVl+DzQyCGbp7mA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=k8xjHyMhWHh6LU2JNHedQBrhU9lznVihac65OTE1bUaucqXHmfdrz2z9KXhWzXWz2
	 9DXRmR8E3MgCEmkbqeuwvrAqBJBZfQEdsQVUV1kfT1ir7Xj8T/c9bIlH0XdlHaJSBA
	 D3T6d87gknynly+zFosxUkYofacDrl8euotqoj3LyFTfx8+GeikeCrglt/TWoh2Eya
	 egwc1tbifqEDlY4VzUTZdwEjqa1k5r5+GqhPgN4IEj1SfrRM+ujVPuuFW+OLVzcacv
	 XEe9zVjksnZEXF02AV4tbNr3Y8lehvtUU8Xl8xAdgV0awCGXbZRCMyzNQIqdmAtbtI
	 vlpFGP26n1OVg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Frank Li <Frank.Li@nxp.com>, Dan Carpenter <dan.carpenter@linaro.org>
Cc: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <aIzCdV8jyBeql-Oa@stanley.mountain>
References: <aIzCdV8jyBeql-Oa@stanley.mountain>
Subject: Re: [PATCH next] PCI: endpoint: pci-ep-msi: Fix NULL vs IS_ERR()
 check in pci_epf_write_msi_msg()
Message-Id: <175490997618.14083.4742096176826820783.b4-ty@kernel.org>
Date: Mon, 11 Aug 2025 16:29:36 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 01 Aug 2025 16:34:45 +0300, Dan Carpenter wrote:
> The pci_epc_get() function returns error pointers.  It never returns NULL.
> Update the check to match.
> 
> 

Applied, thanks!

[1/1] PCI: endpoint: pci-ep-msi: Fix NULL vs IS_ERR() check in pci_epf_write_msi_msg()
      commit: 57a75fa9d56e310e883e4377205690e88c05781b

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


