Return-Path: <linux-pci+bounces-30664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA2DAE90A1
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 23:59:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 58F467AC7AF
	for <lists+linux-pci@lfdr.de>; Wed, 25 Jun 2025 21:58:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4817926E6E7;
	Wed, 25 Jun 2025 21:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gHs7BUrN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DB1826E6E6;
	Wed, 25 Jun 2025 21:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750888732; cv=none; b=Y/ZSdIli46rGx9OYSpwm+cQftovUkTayJXMe7I9FKjNnwdMuArV02oPOKsYSiwzXU05Yc2o3TdFbmr6wpDGRmWGzKxVj7QUC0l/kJlPYVpuV0z8CIny3ahrMHDoN0oQyVcQOAbTKG9fqSL16wK17CI+iDoyr1kqjwE/NLD4hmWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750888732; c=relaxed/simple;
	bh=oOHVi7WKulJD5Ln7DJz9kKtqOwBywgrMuliFZ1+w+HI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NUIN10EdTda3YmNS3RoCI3/YMP1QaOl4BSvGOTqyiCHnUYZ6mj/vDxfsJdqytmOiHCoN9Sle3PpWRF+Xhps8XUMGXqiAbYG+2koZ9XFni0wttBkAIbRiY+YWUWTBNnxPMAW77ll/aWqO6F14AAgIByzEBXfXveQpE5ebaue4Ak8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gHs7BUrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A42FEC4CEEA;
	Wed, 25 Jun 2025 21:58:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750888731;
	bh=oOHVi7WKulJD5Ln7DJz9kKtqOwBywgrMuliFZ1+w+HI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=gHs7BUrNu9peedXSq1UccpV5094B6OcM9oumLr6Asgee1dA0TvTBQbq4auS5Ez/Qj
	 cy6a6Ot6tZgS1guQZZGKrKPwvBtR1+Q0AApWW9l83i352c9dlAXZ7fnvN7H1guwaoM
	 fNhtrj9zrFIep+dq8nr/GPljwfB1NRKNjfOiogGSfsyYMFrN+ArK0NS8jMXA+07ZXl
	 bx+8pYU7A58CVDU/xzh20co/F9VEGInKVO3RMV11lo8+deg7oCtV/5RBKJI8zrisB2
	 J2NFRIjOmlVZv9ulkCRGPktF6vufB1+zJVzes+Yvvaewl2KYsOQ+Zfb8q67QJxjAIt
	 q48ndaErFJmaA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: lpieralisi@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com, 
 jingoohan1@gmail.com, Hans Zhang <18255117159@163.com>
Cc: robh@kernel.org, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20250612161226.950937-1-18255117159@163.com>
References: <20250612161226.950937-1-18255117159@163.com>
Subject: Re: [PATCH] PCI: dwc: Simplify boolean condition returns in
 debugfs
Message-Id: <175088873054.30154.8954618034013748758.b4-ty@kernel.org>
Date: Wed, 25 Jun 2025 15:58:50 -0600
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 13 Jun 2025 00:12:26 +0800, Hans Zhang wrote:
> Replace redundant ternary conditional expressions with direct boolean
> returns in PTM visibility functions. Specifically change this pattern:
> 
>     return (condition) ? true : false;
> 
> to the simpler:
> 
> [...]

Applied, thanks!

[1/1] PCI: dwc: Simplify boolean condition returns in debugfs
      commit: 032f05be51ab4a1d67d08a8083ec16dd934d255e

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


