Return-Path: <linux-pci+bounces-4-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69B587F229E
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 01:55:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EFC1C20EB1
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 00:55:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29D615B6;
	Tue, 21 Nov 2023 00:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ATfg8gqT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55BE17CA
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 00:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF618C433C7;
	Tue, 21 Nov 2023 00:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700528150;
	bh=WydedWHI5hgSzmjYaAgFcEvQrWisnvd0Tah1sl3VwoE=;
	h=Date:From:To:Subject:From;
	b=ATfg8gqTnNhLsAQlbCVsW6Uf6Gol6cMlaLhwJZTZlcJaAWK4tmdmDM8TGKNqLtcYe
	 f4MagAVIb5g83bGlsjUS8P3Sb5+Ba4Pk/5SxswQZTrtoadrPVtb/lCqMxXByePuFQl
	 ljT4I+Luh4o3HTSTmkPzZU3HrZIj/e9yLhwpk6iQ=
Date: Mon, 20 Nov 2023 19:55:49 -0500
From: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To: linux-pci@vger.kernel.org
Subject: PSA: this list has moved to new vger infra (no action required)
Message-ID: <20231120-rousing-messy-yak-ddb9bd@nitro>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hello, all:

This list has been migrated to new vger infrastructure. No action is required
on your part and there should be no change in how you interact with this list.

This message acts as a verification test that the archives are properly
updating.

If something isn't working or looking right, please reach out to
helpdesk@kernel.org.

Best regards,
-K

