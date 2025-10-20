Return-Path: <linux-pci+bounces-38709-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F35BEF58D
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 07:19:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D5013BC0A7
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 05:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF2285045;
	Mon, 20 Oct 2025 05:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHYqOocp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5104D2AD3C;
	Mon, 20 Oct 2025 05:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760937538; cv=none; b=i8HBq6YmdYPTFDqM/rp+/+BzRnN5mMEVEl2ReVOZXZACVhzkjvyIEXpSTuPGNQzxcxkEXp9iVkVb3E3DnN5YPzTAy/KlvqHrCg7LdPwctUrELyQ1kk6C1RLQfPnvX7wQxopZIs6qJHZfY7awQqaiHtuSLfWI6aRK1yJ86baDJpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760937538; c=relaxed/simple;
	bh=DeHo/Ru9MNhb4/ml7h4GnuR5pMrP45DBZfpyiCNtk1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=EWX580zkvNYWZ3tgd4dk+lQknSJO5xFIz0NqP86zHhDjJHlBKTBkul9criAZTfTyeKPp5PkYTjP8r7ZExPYUVKo5weQGM3NcnkY/9zTf7m5ry/Yyw4kif1lScJqd7NM6KdCmO7lbdHKA8QKTPGuEUH6CePifs5kDE34oWxQFTQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHYqOocp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FF9FC4CEF9;
	Mon, 20 Oct 2025 05:18:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760937537;
	bh=DeHo/Ru9MNhb4/ml7h4GnuR5pMrP45DBZfpyiCNtk1Y=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=XHYqOocpFVGRchbJgYuD5Cge75M0PiFFoEU8Prl72wo8AGe18WlE/vf0ePfbF+ICf
	 6iv9OXy5a5OT9Gxbb4mxXz5sFiT/g5GfNmF2M51z8Dxzg239I+y8+qkAs5282HH7Ku
	 K3Twv6PC9wR1sriTRYSuVEHd/Ff1AprVbJcG+m1jlw16ozin8tDxkiTFG4mWqsyype
	 4wN9o1d3FEZlzpgFuctygCDMbo7YfFmnxC10mpc2kj0IQ3WaaQEKRXUzV8Ku729Paq
	 mGkq982ZZ9UikQjE1jDqgERljDIKohgBINv2ZSZDQxfMjgwXAgjkGGj9aLilheeDgg
	 G2jvBlvUQRSyQ==
From: Manivannan Sadhasivam <mani@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Chen Wang <unicorn_wang@outlook.com>, 
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, 
 linux-pci@vger.kernel.org
In-Reply-To: <242eca0ff6601de7966a53706e9950fbcb10aac8.1759169586.git.christophe.jaillet@wanadoo.fr>
References: <242eca0ff6601de7966a53706e9950fbcb10aac8.1759169586.git.christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH] PCI: sg2042: Fix a reference count issue in
 sg2042_pcie_remove()
Message-Id: <176093753190.6981.6733572795969751925.b4-ty@kernel.org>
Date: Mon, 20 Oct 2025 10:48:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Mon, 29 Sep 2025 20:13:22 +0200, Christophe JAILLET wrote:
> devm_pm_runtime_enable() is used in the probe, so pm_runtime_disable()
> should not be called explicitly in the remove function.
> 
> 

Applied, thanks!

[1/1] PCI: sg2042: Fix a reference count issue in sg2042_pcie_remove()
      commit: 932ec9dff6da40382ee63049a11a6ff047bdc259

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


