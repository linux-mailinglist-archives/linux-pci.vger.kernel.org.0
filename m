Return-Path: <linux-pci+bounces-36772-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75E28B95F91
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 15:14:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40060163666
	for <lists+linux-pci@lfdr.de>; Tue, 23 Sep 2025 13:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18444324B06;
	Tue, 23 Sep 2025 13:14:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tethera.net header.i=@tethera.net header.b="fhY2a8K3"
X-Original-To: linux-pci@vger.kernel.org
Received: from phubs.tethera.net (phubs.tethera.net [192.99.9.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 476DA339A8;
	Tue, 23 Sep 2025 13:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.99.9.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758633254; cv=none; b=BF1v0FgK/D8PLcZQoWJEDdnnjdUWhKZcd8pOueXXZlHLaM5BkA1vqb95x9latjUoUAaTKA9Jf2J3DoEP0wpuwOw9PR8l7zXsm8/ZRqaWhbp+ftJYOjUP97p+sjE/tm95jLzg9tUuuflED9gh439KCixW6hjT3YCpssQsg7bM0+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758633254; c=relaxed/simple;
	bh=2sItBj+QU9qdXvNcIECQjyDp7nGnsVveQgohkd3EYmM=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=vCIVLPPGh+mDY15CZB9dZLwxnMytX9hgGsbzTnHtPGvz21vYNb7FAN6X8RzXRCxnGMgbzG/INDZyfZLsir3zMQUi7qnLRTH3WQiEhKZggnXmB4ZU5253jrF3GUDhJ9MMeB3UfR1+TGSoCQWI6dcz1TTfB2lzhmrait6vQ4foe7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tethera.net; spf=pass smtp.mailfrom=tethera.net; dkim=pass (2048-bit key) header.d=tethera.net header.i=@tethera.net header.b=fhY2a8K3; arc=none smtp.client-ip=192.99.9.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tethera.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tethera.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tethera.net;
 i=@tethera.net; q=dns/txt; s=2024; t=1758632774; h=from : to : cc :
 subject : in-reply-to : date : message-id : mime-version :
 content-type : from; bh=2sItBj+QU9qdXvNcIECQjyDp7nGnsVveQgohkd3EYmM=;
 b=fhY2a8K3+6Pqc7obdcyMoOLs2tg8wCZkGhoAXWA9670cPb67vtaRWP6JtAARfUpFAZs84
 IBx29vHM9Jx0C1WoHSU3HOMtKhfHw5OnrBD+qJSNuOiojlAoGPpdI0n1yFXcRmoPpqvBWqB
 LSjVz2iXNeb1Rls66wn8GHXud1K2QVXMf8Y4NfvWZTcPd9lLXJU0CS5b6+ufgxB7chZsJF+
 6SjHwRsZcTCiego5lqemkQ0b9qFxDqd0YGom6xqLJf6fADTwDxQ3SGawi7Cgsn5CMrpaTPN
 0ljaoj5ya23LZ0i0WKjwBoVlytOr/Jv7PCE/+FUWnn2ho0ZGTF7eooo5zMjA==
Received: from tethera.net (fctnnbsc51w-159-2-211-58.dhcp-dynamic.fibreop.nb.bellaliant.net [159.2.211.58])
	by phubs.tethera.net (Postfix) with ESMTPS id C93D818006D;
	Tue, 23 Sep 2025 10:06:13 -0300 (ADT)
Received: (nullmailer pid 1548093 invoked by uid 1000);
	Tue, 23 Sep 2025 13:06:13 -0000
From: David Bremner <david@tethera.net>
To: devnull+manivannan.sadhasivam.oss.qualcomm.com@kernel.org
Cc: bhelgaas@google.com, cassel@kernel.org, heiko@sntech.de, krishna.chundru@oss.qualcomm.com, kwilczynski@kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, linux-rockchip@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, lpieralisi@kernel.org, lukas@wunner.de, mahesh@linux.ibm.com, mani@kernel.org, manivannan.sadhasivam@oss.qualcomm.com, oohall@gmail.com, p.zabel@pengutronix.de, robh@kernel.org, wilfred.mallawa@wdc.com, will@kernel.org
Subject: Re: [PATCH v6 0/4] PCI: Add support for resetting the Root Ports in
 a platform specific way
In-Reply-To: <20250715-pci-port-reset-v6-0-6f9cce94e7bb@oss.qualcomm.com>
Date: Tue, 23 Sep 2025 10:06:13 -0300
Message-ID: <87ldm548u2.fsf@tethera.net>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


I have been testing this series on the 6.17 pre-releases, lightly
patched by the collabora [1] and mnt-reform [2] teams. I have been testing
on bare hardware, on MNT Research's pocket-reform product. I'm afraid I
can only offer CI level feedback, but in case it helps

1) The series now applies cleanly onto collabora's rockchip-devel branch
2) The resulting kernel boots and runs OK.
3) the resulting kernel still fails the "platform" pm_test [3] with
 "rockchip-dw-pcie a40c00000.pcie: Phy link never came up"

Of course there could be other reasons for (3), I don't know that much
about it.

I'm happy to test a newer version of the series if/when it exists.

d

[1]: https://gitlab.collabora.com/hardware-enablement/rockchip-3588/linux.git#rockchip-devel
[2]: https://salsa.debian.org/bremner/collabora-rockchip-3588#reform-patches
[3]: https://www.cs.unb.ca/~bremner/blog/posts/hibernate-pocket-12/

