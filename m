Return-Path: <linux-pci+bounces-24769-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFFE3A718B9
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 15:40:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D2E617729A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 14:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119FB1F3B89;
	Wed, 26 Mar 2025 14:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kxsmwuhz"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CA71F37B8
	for <linux-pci@vger.kernel.org>; Wed, 26 Mar 2025 14:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742999993; cv=none; b=MNGjor9IzLEYaausyE8E9eSz6tHhdGbbiPWj8NJsfnWo+E/z5/5lpXAeewzh81Mx8ZTT40WUoiqxsOupYIiy9QirMZHRoviardWqd2YK6a73XMZODiB13hdMFmdZ9vB5I7Z3kfsLfZZTBn6rNRclEM+wHsOUCPGyWhs8h1bDCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742999993; c=relaxed/simple;
	bh=9AHITBWbreh3yX6lCWJpe4xwhZrhF3thB61YD6Bsu3I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=IwAxu3hzf1/+yES5eBhTmobBaMxOsDVkEr9LGfQ6XkbxwaF7XP15LTTh8Q4Bm2C80NcoUY7PIsdDJp3lRMISeqefPDiV4IXX5rbz/kcEX8+mPxkXkZCjscivuqmgOFS6NjF/dh55otnckt6O/tsWAxAVFe9oewbc6KBvVREX9I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kxsmwuhz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A53C4CEE8;
	Wed, 26 Mar 2025 14:39:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742999992;
	bh=9AHITBWbreh3yX6lCWJpe4xwhZrhF3thB61YD6Bsu3I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=KxsmwuhzrtVs/GfWH9aujiM472rHVC0Zti8eoXqfn4tEcgLq4wpEoegSZ2rli70vJ
	 JivZfbpcU+//48YC/fTHeVGbwLOXIYVqldKXfe9U7bH42mVpmH6KhlL1KXwcMwwMA7
	 IS88mVt5x+BzzyqJGNhm+cd0xcvCbfCiE+u/Tb+wrsePYX59F2fEYUt+oe6qswOoVU
	 i/AkHewDrae/tGTV59AzL3vWq1kpUDcsiwACbeZ2gkxjl3HczZiiriHdvdGyrwTEFW
	 2ko9kV7UQItIyYPNMLWi7mSipNnJoeErkpYjrZ+V4wEfSrWaUl4CWG9lHpFrfwwkfb
	 JGL8kqkB6dRRA==
Date: Wed, 26 Mar 2025 10:39:50 -0400
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: bhelgaas@google.com, kw@linux.com, linux-pci@vger.kernel.org,
 Damien Le Moal <dlemoal@kernel.org>,
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_3/4=5D_misc=3A_pc?=
 =?US-ASCII?Q?i=5Fendpoint=5Ftest=3A_Let_PCI?=
 =?US-ASCII?Q?TEST=5F=7BREAD=2CWRITE=2CCOPY=7D_set_IRQ_type_automatically?=
User-Agent: K-9 Mail for Android
In-Reply-To: <2D76B56E-00A1-4AC1-B7B5-4ABEA53267CF@kernel.org>
References: <20250318103330.1840678-6-cassel@kernel.org> <20250318103330.1840678-9-cassel@kernel.org> <20250320152732.l346sbaioubb5qut@thinkpad> <Z91pRhf50ErRt5jD@x1-carbon> <20250322022450.jn2ea4dastonv36v@thinkpad> <2D76B56E-00A1-4AC1-B7B5-4ABEA53267CF@kernel.org>
Message-ID: <01676177-4757-41D3-BEC2-F61C0C7C3F69@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



Hello Mani,

On 22 March 2025 01:31:44 GMT-04:00, Niklas Cassel <cassel@kernel=2Eorg> w=
rote:
>
>BTW, can all Qcom platform raise INTx interrupts in EP mode?
>
>Bjorn did not like that I added intx_capable to epc_features without havi=
ng any platform that sets it to true=2E I'm quite sure that many platforms =
can raise INTx interrupts=2E
>If all Qcom platforms can raise INTx interrupts,
>then I could set intx_capable to true in epc_features in qcom-ep=2Ec, to =
address Bjorns comment=2E

Can all Qcom platforms raise INTx in EP mode?


Kind regards,
Niklas

