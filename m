Return-Path: <linux-pci+bounces-35551-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 679ECB4627B
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 20:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A11063A2273
	for <lists+linux-pci@lfdr.de>; Fri,  5 Sep 2025 18:42:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE222274B37;
	Fri,  5 Sep 2025 18:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="CLgxvrlH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DB227467F;
	Fri,  5 Sep 2025 18:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757097721; cv=none; b=OfPfkG8vavooxAAHoAiedQ8M6w3tteEZl89NRbQi5VBbbLtTu4YtOjC04zuqEmCd8Lv04WfO+K6/9fxJHBRSifuMVvLrFtdY4mZ5Orp5DI/V4AC6MheD6SIT8e5vg/FHNgAjwGv9C9LS+yQQHCxv1rtd7xLscAijLESpmRLaiLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757097721; c=relaxed/simple;
	bh=K9jtQs5j3QRMxeewLxNfsL/mNQI/uM1HUPGRB0r9uEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EQcPpUxres3UVKxrwzUlHnmybojZLagD6hQYr0fy9mTCtEG1mnp3zr35jCfpugPRw/2g1BOYUJGtKSWpt2C5lfvKJXYVt51c4ECxpb2v2JHfVXhxC9n38z5kPot0vAU1JBbDJQSaHVfHUJkW6N7Uwwng/0VQL3R70baIaVqqMZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=CLgxvrlH; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4cJQDh0tYWz9tgf;
	Fri,  5 Sep 2025 20:41:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1757097716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NFlUyN+7jtcnbZceOxFSBadwGYBOZh16DUAu7RRTqBA=;
	b=CLgxvrlHXdbd7QLy8sNA763rx4NjevBE+ctoGzY7xBuzCmWowUx+pcPPAyzWKyQy8W0MfP
	ZdBNPPh7q2PITsenJs/H/QZdFZzS4dMJlfoTE9riP5f1vzQOPD31AsPFSzEyJIosel2dYR
	KJGQ5wnVRa/q3esLVkA/hE0K6EqDh32gefSPNS3GUCTHv+GL7ycbVYOj8SlmOnfuDIfw1d
	91Y4LDlilTyC1tdPJlYbP3z34kMzrWZ/L7jdtSZ5S7ru6pRl0k2w2c2Z2Wz6k2KlpDqL4E
	dtQgBaD+ErIDv7Je5VpMaJqYECaBd8nrCqauZePQrLk4fpa06wUNGjfxIoQeUQ==
Message-ID: <23b3e8e2-ba9d-4cb3-907e-3de7f2693b60@mailbox.org>
Date: Fri, 5 Sep 2025 20:41:53 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] PCI: endpoint: pci-epf-test: Limit PCIe BAR size for
 fixed BARs
To: Niklas Cassel <cassel@kernel.org>
Cc: linux-pci@vger.kernel.org, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Wang Jiang <jiangwang@kylinos.cn>,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org
References: <20250905121259.9378-1-marek.vasut+renesas@mailbox.org>
 <aLrXQGzYBB8JVE0Z@ryzen>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aLrXQGzYBB8JVE0Z@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: ez4feoizgzobrxefods6gmzf5wtgdnh9
X-MBO-RS-ID: 61fd2360f4c34ad6a9f

On 9/5/25 2:27 PM, Niklas Cassel wrote:
> On Fri, Sep 05, 2025 at 02:12:43PM +0200, Marek Vasut wrote:
>> Currently, the test allocates BAR sizes according to fixed table
>> bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 } . This
>> does not work with controllers which have fixed size BARs, like
>> Renesas R-Car V4H PCIe controller, which has BAR4 size limited
>> to 256 Bytes, which is much less than 131072 currently requested
>> by this test.
> 
> Perhaps rephase this to more clearly state that:
> This does not work with controllers with have fixed size BARs that is
> smaller than the requested BAR size.
> 
> (Since a lot of controllers drivers in-tree have fixed size BARs,
> and they do work perfectly fine, but it is only because their fixed
> size is larger than the size requested by pci-epf-test.c)
> 
> 
>>
>> Adjust the test such, that in case a fixed size BAR is detected
>> on a controller, minimum of requested size and fixed size BAR
>> size is used during the test instead.
> 
> This sentence needs to be updated, since you no longer take the minimum
> of requested size and fixed size BAR.
> 
> Perhaps simply:
> "Adjust the test such that in case a fixed size BAR is detected,
> the fixed BAR size is used, as that is the only possibly option."
> 
> 
> With that:
> Reviewed-by: Niklas Cassel <cassel@kernel.org>
All done in V3, which I will send shortly.

Thank you

