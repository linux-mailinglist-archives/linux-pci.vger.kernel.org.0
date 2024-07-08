Return-Path: <linux-pci+bounces-9935-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A730592A5A8
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 17:30:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DFAA1F21C86
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 15:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8305A142E88;
	Mon,  8 Jul 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U2zvUdOK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F013F426;
	Mon,  8 Jul 2024 15:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720452584; cv=none; b=uvC2zuRnkhL11XtdLex50HBlNaSqOlt1PJ6i4Rc0P/bCSYenFHGcwTBqpk8+CZUkAMpLXqRl52EMJq4rgSI8dHQqU5AubEJNslzQVeVVK9gLfNiNov+evFeq4MgCg3kRCmsfEdXd5LA38Twv4RIv4Q4bZDIj8UGhrQ9cxxQzxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720452584; c=relaxed/simple;
	bh=ztW0g2FoZv1Ha2AVuu/92vUst4UA6CVs3jAeJnz1ouU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SqPHK3r5v3ozNbdtP7397oLQGOrs7B7H0mER6XTgyCGxu8bqKa9Qk3AmnSxKd19urTRomMoULhqLXb5dY1mV1Q4yVbrZ6XooQR1tbgQ1BWP+2NfP89nvzn9aiad/BgYZ4ENhzffFq4lhbjKyD7kErHSAYGxSi/9L9w+UW6q1CBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U2zvUdOK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB60DC116B1;
	Mon,  8 Jul 2024 15:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720452584;
	bh=ztW0g2FoZv1Ha2AVuu/92vUst4UA6CVs3jAeJnz1ouU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U2zvUdOKa60zfvyxouCovnzIYJPdLX2Ba6Ifi+5eEjkgsccW/d8ZWsClTVvVnlai0
	 7eBjOuB+R3uElB9PAZhYeUXLyFk7KdDHzSArMzcMnLOp52GUtPc3x71AUsNiu/Y2k4
	 ZY6PMjTf0uqbPVekBang/zSi6holrnmrPZybFcVlrVcCC2GiVt/D6BMfNpt1JhjAY5
	 epoulaz/QvSYWNlwAYC7BgvTh9f7J8I7R0BX9m49CVQOTrsTh423kW4ld0peEdxcat
	 yxgqleXx8MXUtY/tA/24eSFh9xfrv05Wap6xaO6cEGaDzq07JQPPVeNYIgqdboyT/2
	 FCQHXBMARN2EQ==
Message-ID: <6e57dbc0-f47a-464e-af6b-abd45c450dc6@kernel.org>
Date: Mon, 8 Jul 2024 10:29:41 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pci: bus: only call of_platform_populate() if
 CONFIG_OF is enabled
To: =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Lukas Wunner <lukas@wunner.de>, Bert Karwatzki <spasswolf@web.de>,
 caleb.connolly@linaro.org, bhelgaas@google.com, amit.pundir@linaro.org,
 neil.armstrong@linaro.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, Praveenkumar Patil <PraveenKumar.Patil@amd.com>
References: <20240707183829.41519-1-spasswolf@web.de>
 <Zoriz1XDMiGX_Gr5@wunner.de> <20240708003730.GA586698@rocinante>
 <CACMJSevHmnuDk8hpK8W+R7icySmNF8nT1T9+dJDE_KMd4CbGNg@mail.gmail.com>
 <20240708083317.GA3715331@rocinante>
Content-Language: en-US
From: Mario Limonciello <superm1@kernel.org>
In-Reply-To: <20240708083317.GA3715331@rocinante>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/8/2024 3:33, Krzysztof Wilczyński wrote:
> [...]
>>> If there aren't any objections, I will take this via the PCI tree, and add
>>> the missing tags.  So, no need to send a new version of this patch.
>>>
>>> Thank you for the work here!  Appreciated.
>>>
>>>          Krzysztof
>>
>> I don't think you can take it via the PCI tree as it depends on the
>> changes that went via the new pwrseq tree (with Bjorn's blessing).
> 
> Aye.
> 
>> Please leave your Ack here and I will take it with the other PCI
>> pwrctl changes.
> 
> Sounds good!  With that...
> 
> Acked-by: Krzysztof Wilczyński <kw@linux.com>
> 
>> After the upcoming merge window we should go back to normal.
> 
> Thank you!
> 
> 	Krzysztof

FWIW this other patch makes it quieter too.

https://lore.kernel.org/linux-pci/20240702180839.71491-1-superm1@kernel.org/

