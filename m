Return-Path: <linux-pci+bounces-29667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02FDDAD8881
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 11:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7722B3B7912
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jun 2025 09:52:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DCB29B233;
	Fri, 13 Jun 2025 09:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jh9B8LlP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D10E21E0DE8;
	Fri, 13 Jun 2025 09:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808360; cv=none; b=nfyTiWVy/tCbqc5TFxuR7RSAhpHvn6f6/vGqxsSP8b3F7G9wDd68NZrHALDVLQEI+xOEqISJbnky6+7aT//vBe1+vPTbB1z97I/55AZfUgCDoof6X16cmmA3TOSWKg4YcudrHCjgO0Ai2cal0Z2cQWaatxnaEJSLUqkMXIPnOgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808360; c=relaxed/simple;
	bh=O+2cVL+SJ6EEpHYwYawqtBx1lowvZC4Qgd74nrgQ4Lw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hBZJ9WgBVzq/T65lgX2XjJH6d366y7d0tYUXjDMbHnME/76uGUcO6fRas1aYNhvEdu/Xv33euYJ7dChiLoEdrLKXEcF9VNhTyH/D37Dy4DlxYuYI2DzWJ3B3T2kg0qs7MRhbN1D6C978ccpjGrCYg+QhqXDmFvz+/s6ZQlpa0Cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jh9B8LlP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 097E2C4CEE3;
	Fri, 13 Jun 2025 09:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749808360;
	bh=O+2cVL+SJ6EEpHYwYawqtBx1lowvZC4Qgd74nrgQ4Lw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=jh9B8LlPyIVyWfSeHC6fAMOuC4xT5pWPqIEIIp7OG9m9WE/tMLjbbqGlu3qxAwWQj
	 w8lxeQzKZwuDMlYLOAP90j1aanEgWOrG03lBaEeRhPLqBRvAJagQPao1mMwXXdtAQt
	 m1dFWVI0nbjIqgOHqfD6SpVFI4Nl4KWDfCLzjLJ7eqdmLTmbVXVM6TjRjUqW7EjfV7
	 uyDtupvO18Q2tDKGClh4oSk3CUsZ/leOcz8GVt1y7Q+mWECBNGDu/LFCqIGrFlYQNL
	 ixz+q5UbIy7L0NqaECobThtvUTzDbPS9uRI3Dj0THlZloFE9qqI/UwpWgikTejnpwt
	 XtvMaKpGhPVHA==
From: Manivannan Sadhasivam <mani@kernel.org>
To: bhelgaas@google.com, kwilczynski@kernel.org, 
 Manivannan Sadhasivam <mani@kernel.org>, Hans Zhang <18255117159@163.com>
Cc: ajayagarwal@google.com, ilpo.jarvinen@linux.intel.com, 
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250522161533.394689-1-18255117159@163.com>
References: <20250522161533.394689-1-18255117159@163.com>
Subject: Re: [PATCH] PCI/ASPM: consolidate variable declaration and
 initialization
Message-Id: <174980835752.36211.3568431773211416849.b4-ty@kernel.org>
Date: Fri, 13 Jun 2025 15:22:37 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Fri, 23 May 2025 00:15:33 +0800, Hans Zhang wrote:
> Merge the declaration and initialization of val into a single statement
> for clarity. This eliminates a redundant assignmentoperation and improves
> code readability while maintaining the same functionality.
> 
> 

Applied, thanks!

[1/1] PCI/ASPM: consolidate variable declaration and initialization
      commit: f58089683f6fb127ed87a5fcf78087de76c9d178

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


