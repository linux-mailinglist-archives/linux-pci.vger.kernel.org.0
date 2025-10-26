Return-Path: <linux-pci+bounces-39339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D69C0ACF7
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 16:54:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 685C1189CECB
	for <lists+linux-pci@lfdr.de>; Sun, 26 Oct 2025 15:54:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E931FCF41;
	Sun, 26 Oct 2025 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3QR99tz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486B61C862D;
	Sun, 26 Oct 2025 15:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761494040; cv=none; b=t9JPLwUyeUaCqOtpc1aTw8zvBUwihettrucYOw/SLvD0TWWrV/5u1jQi8iG7QbJDmJMXL6EjCn6+2GfVcwZ2SSQ8qGFqcuMwlhEs5NGj11mtQjffNmLLthqrSfOcoJDnwIb9Gz6Oh7H3Dt03QiH6zDKpsX4hdpWjthl1F/Hw7tU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761494040; c=relaxed/simple;
	bh=yuj6B/4jdw5JEcTrXhjojLU0Yio81Or2fV2JsultxwA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=J1LmSSoo9NtfB4d736d9DWR5qEDYJWECKMqH6pR3nIAw2FPQ4G2lrTLcr9EcaarbaxT3+NtkV5W7/VNlWznjUiFDiq1CSykeCI2e6xzbwVs7uvG1RI7AzBA5Sn6iZ8FsDCYKNBocCq/WsW1AUFk2f+Cwbe187KPhcEalowkCXJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3QR99tz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B038EC4CEE7;
	Sun, 26 Oct 2025 15:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761494039;
	bh=yuj6B/4jdw5JEcTrXhjojLU0Yio81Or2fV2JsultxwA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=h3QR99tzfIu+K7ksVCwtEPWxwQ9sECLZsLctJSK9pvZ0dfZ0Le1G6+7Y1BhN2jW8Q
	 62tBIMX3gVFIdxnH8YSbdrwYVfqOg+MowM2OvHIsjPByKIVRWXFKF9JKWW1F9heQpk
	 qp0ZI4q7oPp9UhM4RvxeIGbgC+lNn6iQIa8Jlp5UfeADK6SSz5GOJJv1hEjofBriZU
	 UN7OYmhdjrQZcQyHufPPRAbgdcCLcs28WujPXet7IijwO6fTcpNzZedW3lSYs6LZ18
	 Bq9eemWv0Bm/7NiUo/QQrUPMoJuuGWtofXbOV48Jn2UPK1JrCfLdI1oqE94I0Y4ri4
	 GEdYmegIzdpLg==
From: Manivannan Sadhasivam <mani@kernel.org>
To: =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, Niklas Cassel <cassel@kernel.org>, 
 Frank Li <Frank.Li@nxp.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Mohamed Khalfella <khalfella@gmail.com>, 
 Christian Bruel <christian.bruel@foss.st.com>, 
 Bhanu Seshu Kumar Valluri <bhanuseshukumar@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 khalid@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org, 
 skhan@linuxfoundation.org, david.hunter.linux@gmail.com
In-Reply-To: <20251014024109.42287-1-bhanuseshukumar@gmail.com>
References: <20251014024109.42287-1-bhanuseshukumar@gmail.com>
Subject: Re: [PATCH v3] PCI: endpoint: pci-epf-test: Fix sleeping function
 being called from atomic context
Message-Id: <176149403315.9388.15839787422598934486.b4-ty@kernel.org>
Date: Sun, 26 Oct 2025 21:23:53 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2


On Tue, 14 Oct 2025 08:11:09 +0530, Bhanu Seshu Kumar Valluri wrote:
> When Root Complex (RC) triggers a Doorbell MSI interrupt to Endpoint (EP)
> it triggers a warning in the EP. pci_endpoint kselftest target is
> compiled and used to run the Doorbell test in RC.
> 
> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:271
> Call trace:
>  __might_resched+0x130/0x158
>  __might_sleep+0x70/0x88
>  mutex_lock+0x2c/0x80
>  pci_epc_get_msi+0x78/0xd8
>  pci_epf_test_raise_irq.isra.0+0x74/0x138
>  pci_epf_test_doorbell_handler+0x34/0x50
> 
> [...]

Applied, thanks!

[1/1] PCI: endpoint: pci-epf-test: Fix sleeping function being called from atomic context
      commit: 25423cda145f9ed6ee4a72d9f2603ac2a4685e74

Best regards,
-- 
Manivannan Sadhasivam <mani@kernel.org>


