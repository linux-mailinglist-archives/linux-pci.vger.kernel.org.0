Return-Path: <linux-pci+bounces-1221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B2581A0DB
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 15:11:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8B2C1C20E67
	for <lists+linux-pci@lfdr.de>; Wed, 20 Dec 2023 14:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973F135895;
	Wed, 20 Dec 2023 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LdyuB/Wi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7202739841;
	Wed, 20 Dec 2023 14:11:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF06DC433C8;
	Wed, 20 Dec 2023 14:11:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703081500;
	bh=i1vREzGg9L6c6Fd8geHXkYfzZq5y9cqUrhAh22X+8L4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=LdyuB/WixkJS74JDO3vKkJPH9rsRhrjL1Qgcvgw92zCcahIvro7KgaBubxblZ1RYM
	 x63JAQINmM9i5f/3Kqowbai95TRZiTOCn56jT3Im2mpLt0wANGKugvr2FpDJlREcVc
	 QkJRNknVEZkEvRPFexrVy0mqw5uVkzIKly+fPbkiZ6Z/t5+TA4KTdJ1lYYvee1Dcru
	 1ws/fyi8jNL3kswkqKRoLadxVSOKGYJg3PRUqFwH2WXS6ahNhSq3G78CjCpFQDG7e4
	 ee+tyoWwTw22R/Qls9zMPjNkqdjRg1cLA0VeNauyaktDeZszzi41IuSAcU4W/SD2ii
	 IrbXeiwE9gTGQ==
From: Kalle Valo <kvalo@kernel.org>
To: Mathias Krause <minipli@grsecurity.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,  Arend van Spriel
 <arend.vanspriel@broadcom.com>,  Franky Lin <franky.lin@broadcom.com>,
  Hante Meuleman <hante.meuleman@broadcom.com>,  linux-pci@vger.kernel.org,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org,
  SHA-cyfmac-dev-list@infineon.com,  brcm80211-dev-list.pdl@broadcom.com
Subject: Re: [PATCH] PCI: Remove unused 'node' member from struct pci_driver
References: <20231220133505.8798-1-minipli@grsecurity.net>
Date: Wed, 20 Dec 2023 16:11:37 +0200
In-Reply-To: <20231220133505.8798-1-minipli@grsecurity.net> (Mathias Krause's
	message of "Wed, 20 Dec 2023 14:35:05 +0100")
Message-ID: <87cyv12cbq.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Mathias Krause <minipli@grsecurity.net> writes:

> Remove the unused 'node' member. It got replaced by device_driver
> chaining more than 20 years ago in commit 4b4a837f2b57 ("PCI: start to
> use common fields of struct device_driver more...") of the history.git
> tree.
>
> Signed-off-by: Mathias Krause <minipli@grsecurity.net>
> ---
> There is only one "user" that makes use of the 'node' member, which is
> the brcm80211 driver. However, its "use" is clearly wrong (a list head
> cannot be initialized this way) and, obviously, not needed.
>
> If netdev folks instead want to split this off into a separate commit, I
> can do that. However, I don't expect any cross-tree conflicts regarding
> this change.
>
>  drivers/net/wireless/broadcom/brcm80211/brcmfmac/pcie.c | 1 -
>  include/linux/pci.h                                     | 2 --
>  2 files changed, 3 deletions(-)

No need to split anything, feel free to take this via PCI tree:

Acked-by: Kalle Valo <kvalo@kernel.org>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

