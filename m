Return-Path: <linux-pci+bounces-34944-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E64B38EB2
	for <lists+linux-pci@lfdr.de>; Thu, 28 Aug 2025 00:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3CAA1BA7DD8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Aug 2025 22:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F7A827E7EE;
	Wed, 27 Aug 2025 22:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEqk6wZD"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE8F26A08C
	for <linux-pci@vger.kernel.org>; Wed, 27 Aug 2025 22:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756334921; cv=none; b=oTFR2h8S2BURcJLcLdoBTpCvoLoo+ZKk1tKmrnCXenr89sHKRw1g96rH9clTD+sj2cemf4vwk4YAr7qJPil53Qgk+P09MrLkQ7v5eRXy4yO2tc8/6d5gAp96OrBVT+evKWCbHIi51f/jyDiD+jVrjOlBJvSmU3m7dUxDbqhvuh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756334921; c=relaxed/simple;
	bh=3y/21zxBzA8BO6/ExTI+4gMaUiaRRE2dzwMkFpgxF5M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OtK2yooX9jzON6hGxtiy69ZrMWfohH5sBp3+OnCdy6XeAbM766h3Vt4ev8hSxBcxr2irvocfeo2TEfKWdqCzN/JXql2HToAiMaY2uyLUAFMXJj+/8EcHVcR97w2ILUiFfzfcGDboI4I1nZKWTF+DxiIQx8CVa77UvTyHr8trSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEqk6wZD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0B6C4CEEB;
	Wed, 27 Aug 2025 22:48:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756334920;
	bh=3y/21zxBzA8BO6/ExTI+4gMaUiaRRE2dzwMkFpgxF5M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nEqk6wZDg8xTpXvW73VA/cjU51z9ImbFsw3Sic+CoErFzyE8mcGPVGJ46WXjuIwJe
	 Rr74BPxrEkzDXJ5SgyFkRxT/8ek9DFDmhlonAuBN+t4G10o8iecQoKW+CkSt67/joR
	 bplGHmbzEe/uP93akHWbwneOx3Q+Xjpe/Ug8G1yhhAMvA200ClYmxwUSMAhsPmQ7vv
	 RXxi0fTNGjyGRxh4Ql4eHMGvNhjmAgmtjauNB5tZEo0nOJA9IlywHlPzDuJnKtAV94
	 I01ICbCRp3o3Wb7kmM1NUVekK3E1VnNOtW6Ld+AHum1GXTVnHi3/RMYbiJWRg3cs6w
	 X7No0cnnlsDPw==
Date: Wed, 27 Aug 2025 16:48:38 -0600
From: Keith Busch <kbusch@kernel.org>
To: Keith Busch <kbusch@meta.com>
Cc: linux-pci@vger.kernel.org, Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] pciehp: sync interrupts for bus resets
Message-ID: <aK-LRopkiQSzbigD@kbusch-mbp>
References: <20250827224514.3162098-1-kbusch@meta.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250827224514.3162098-1-kbusch@meta.com>

On Wed, Aug 27, 2025 at 03:45:14PM -0700, Keith Busch wrote:
> 
> Fixes: bbf10cd686835d5 ("PCI: pciehp: Ignore belated Presence Detect Changed caused by DPC")

Ugh, I taged the wrong one. Should be:

Fixes: 2af781a9edc4ef ("PCI: pciehp: Ignore Link Down/Up caused by Secondary Bus Reset")

