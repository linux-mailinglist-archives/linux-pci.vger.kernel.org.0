Return-Path: <linux-pci+bounces-38083-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2134BDB23B
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 21:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726943A9E27
	for <lists+linux-pci@lfdr.de>; Tue, 14 Oct 2025 19:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AD730171E;
	Tue, 14 Oct 2025 19:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b="bfe2nTwv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p9MKiIaX"
X-Original-To: linux-pci@vger.kernel.org
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F22723D7D9
	for <linux-pci@vger.kernel.org>; Tue, 14 Oct 2025 19:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760471826; cv=none; b=aIKAMy5eLb29oNq/is+9R3bv+C1WJGZtLUwmpEuoMQt96NX9TWWfZfhzJkqIntLkdHB73KKtE8O2b0XuowL4gxq9bUkTwew0wCMvEj4QQY1wxpBVC3ygG9U1HDBA8CHZol7WxlrUetuhI8KGzvppdjz0Zk0vMo/QTgn8KzSaNfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760471826; c=relaxed/simple;
	bh=6P/tuZqkbtJSCCy1oLWIQYUdCCRMYGkAVEERDCEdFGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PZMT+ZNQLuciJaqePn/qAQtCLX8NLkbkFGCtxFu1k0mG8eJkJjtuJKl3R/D7yGqf5vApPRXBY7n4wpziz+G9TAG1w59xzRH5+8TViFxHoooKJxqomPIM35ICGubTzbOYk+T3ULV/0I8HEy6zfPecLtP10pNII+V+8dmcDNDdR9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org; spf=pass smtp.mailfrom=shazbot.org; dkim=pass (2048-bit key) header.d=shazbot.org header.i=@shazbot.org header.b=bfe2nTwv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p9MKiIaX; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=shazbot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=shazbot.org
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4D1BD140009E;
	Tue, 14 Oct 2025 15:57:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 14 Oct 2025 15:57:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1760471821;
	 x=1760558221; bh=n7OvOctjo5/xfeVtn+H03nx7FphJGWk4u+7EFq9WQqA=; b=
	bfe2nTwv/QDvmoWKpSjcrEp31XXZLW/g+AlLoqkHJOIpk+LkybPKOaT/SYY4xYvC
	spVF5SwCTfu3VwGqoStYLGUmxKttWfI2C2tLGq5UhdwWMNNBHc2RUZXhdaUqS7Ro
	p0lh9pYXksYIJo7iJ2cYTpeA6ZiFXLYBfF8SodKTusZYdyyGuo2mW1QvQcClj5Vq
	Q1yOKsUYD4STbuM5PfYVPvW4SDiPLMXlcpjCygxOdNm0qPKeh1swa7vaCgtItylP
	1TTOqPN//MVt7wET96k3db3UKODEU6ZCcKwUqaYDdQPMUa0LBwrIwfMpO0aZK8sh
	O+HHNUILJax2iHP/R0UpNQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760471821; x=
	1760558221; bh=n7OvOctjo5/xfeVtn+H03nx7FphJGWk4u+7EFq9WQqA=; b=p
	9MKiIaXWBn347FubowuH15ZoksHlCtMnj0hkLKtmAEky+J+5V+Csdu5sKVPi/Doo
	L4sboR/W++RMonLVxh94AKHMRzdty3t7nmS7awQBE5dDz7er+RsFF8xqCclE3SZM
	UxDRWJlK5IHiJRz9n76nxAQ+vuemho+EY7eycz7BgpJsbsyrle26Pbd8RztFjb9e
	Qh/yHILlIJ6IyTK3Q6FaVY3r8SmPNwAA5MGspOltU1iEihALNfD5qC4m4vCHNC/+
	awzQKgZTCnNEa6zkDKWLC9H4lL1PZ795YknnNVFHKYugCQZqGdu/MWIxVn/oCu1X
	bC+CM89iUjIIxITrpS6/Q==
X-ME-Sender: <xms:DKvuaOPXXWyf4DLh9R8af9b1Tmw-y7kQfkU8hYx-6MdSyvOwf-BHgA>
    <xme:DKvuaD-eXbaJbTaYcf4B_RuMVjJW8b_7SH0W6kI3UQ0HwxsFAabKHUDTx9g3SqUNB
    JAGyIsJFNlLx_Ac-UOp8ODkyNfen5ROTDV1R6-TFjDy5eVainwvhQ>
X-ME-Received: <xmr:DKvuaKQIB7T5QEQ6yf-JU7XekLKVZIOr3A7XQ0NNCDGCgoVJmq9iskNCF3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddugeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkjghfgggtgfesthejredttddtvdenucfhrhhomheptehlvgigucgh
    ihhllhhirghmshhonhcuoegrlhgvgiesshhhrgiisghothdrohhrgheqnecuggftrfgrth
    htvghrnhepteetudelgeekieegudegleeuvdffgeehleeivddtfeektdekkeehffehudet
    hffhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hlvgigsehshhgriigsohhtrdhorhhgpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegrlhhokhdrrgdrthhifigrrhhisehorhgrtghlvgdrtg
    homhdprhgtphhtthhopegshhgvlhhgrggrshesghhoohhglhgvrdgtohhmpdhrtghpthht
    ohepughonhgrlhgurdgurdguuhhgghgvrhesihhnthgvlhdrtghomhdprhgtphhtthhope
    hlihhnuhigqdhptghisehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:DKvuaNkTEgGECfm6TpzxUlT-kPkhyt0hmRcOGy4cbzwtuEyCJ_F3gA>
    <xmx:DKvuaCSf1NmyrSB5UzT34RkQmZxs_GvLPTNCcIkQvg2P1h8KIP9rIQ>
    <xmx:DKvuaDNoSAJMUtvESIM5XAQ-qyhNsQg6Tr7WJ0GpURgzBV2tMDTtZQ>
    <xmx:DKvuaDVDYdcP8vwOpd2pQO8N8uBOiUtuUTlG8D9mEsZM2zqauEwIoQ>
    <xmx:DavuaOjTUWsvmlyf6yhfaNcdzd27VF84QGubo_8sJOu4eQo9QHRvDudA>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 15:57:00 -0400 (EDT)
Date: Tue, 14 Oct 2025 13:56:58 -0600
From: Alex Williamson <alex@shazbot.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, donald.d.dugger@intel.com,
 linux-pci@vger.kernel.org
Subject: Re: [QUERY] Is there a reason pci_quirk_enable_intel_rp_mpc_acs()
 uses pci_write_config_word()
Message-ID: <20251014135658.1afeff57@shazbot.org>
In-Reply-To: <67958fbe-fa61-4ea4-8040-c6b8d0313d57@oracle.com>
References: <67958fbe-fa61-4ea4-8040-c6b8d0313d57@oracle.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 10:57:39 +0530
ALOK TIWARI <alok.a.tiwari@oracle.com> wrote:

> Hi,
> 
> function pci_quirk_enable_intel_rp_mpc_acs() in
> drivers/pci/quirks.c, I noticed that the code reads a 32-bit value from
> INTEL_MPC_REG using pci_read_config_dword(), but writes it back using
> pci_write_config_word().
> 
> The relevant lines are:
> 
>      pci_read_config_dword(dev, INTEL_MPC_REG, &mpc);
>      if (!(mpc & INTEL_MPC_REG_IRBNCE)) {
>          pci_info(dev, "Enabling MPC IRBNCE\n");
>          mpc |= INTEL_MPC_REG_IRBNCE;
>          pci_write_config_word(dev, INTEL_MPC_REG, mpc);
>      }
> 
> Given that:
> /* Miscellaneous Port Configuration register */
> #define INTEL_MPC_REG 0xd8
> /* MPC: Invalid Receive Bus Number Check Enable */
> #define INTEL_MPC_REG_IRBNCE (1 << 26)
> 
> the IRBNCE bit is in the upper 16 bits of this 32-bit register.
> It seems that using pci_write_config_word() would not actually update 
> that bit.
> 
> is there a specific hardware reason for using a 16-bit write?

It looks like a typo to me.  Please post a formal fix.  Thanks,

Alex

> ---
> diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
> index 214ed060ca1b..1bd6e70058b5 100644
> --- a/drivers/pci/quirks.c
> +++ b/drivers/pci/quirks.c
> @@ -5312,7 +5312,7 @@ static void 
> pci_quirk_enable_intel_rp_mpc_acs(struct pci_dev *dev)
>          if (!(mpc & INTEL_MPC_REG_IRBNCE)) {
>                  pci_info(dev, "Enabling MPC IRBNCE\n");
>                  mpc |= INTEL_MPC_REG_IRBNCE;
> -               pci_write_config_word(dev, INTEL_MPC_REG, mpc);
> +               pci_write_config_dword(dev, INTEL_MPC_REG, mpc);
>          }
>   }
> 


